Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E838AD1D48A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBJf-000673-Tr; Fri, 09 Jan 2026 07:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIW-0005ae-Jf; Fri, 09 Jan 2026 07:08:59 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1veBIT-00017E-L4; Fri, 09 Jan 2026 07:08:56 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B206048FBF;
 Fri, 09 Jan 2026 13:08:42 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com
Subject: [RFC v2 0/6] block/io: avoid failure caused by misaligned BLKZEROOUT
 ioctl
Date: Fri,  9 Jan 2026 13:08:27 +0100
Message-ID: <20260109120837.2772961-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1767960482175
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Previous discussion here:
https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@proxmox.com/

Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
certain 'qemu-img convert' invocations, because of a pre-existing
issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
the request is shorter than the block size of the block device.

Stefan suggested prioritizing bl.pwrite_zeroes_alignment in
bdrv_co_do_zero_pwritev(). This RFC explores that approach and the
issues with qcow2 I encountered, where
bl.pwrite_zeroes_alignment = s->subcluster_size;
I would be happy to discuss potential solutions and whether we should
use this approach after all.

For example, in iotest 154 and 271, there are assertion failures,
because the padded request extends beyond the end of the image:
Assertion `offset + bytes <= bs->total_sectors * BDRV_SECTOR_SIZE ||
child->perm & BLK_PERM_RESIZE' failed.
The total image length is not necessarily aligned to the cluster size.
This could be solved by shortening the relevant requests in
bdrv_co_do_zero_pwritev() and submitting them without the
BDRV_REQ_ZERO_WRITE flag and with bl.request_alignment as the
alignment see patch 5/6.

For iotest 179, I would need to avoid clearing BDRV_REQ_ZERO_WRITE for
the head and tail parts as long as the buffer is fully zero.
Otherwise, we end up with more 'data' sectors in the target map. See
patch 6/6. With or without that, iotests 154 and 271 produces
different output (I think it might be expected, but haven't checked in
detail yet).

Another issue is exposed by iotest 177, where the (sub-)cluster size
is 1MiB, but max-transfer is only 64KiB leading to assertion failures,
because max_transfer =
QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX), align);
evaluates to 0 (because align > bs->bl.max_transfer). This could be
fixed by safeguarding doing the QEMU_ALIGN_DOWN only if the value is
bigger than align, see patch 4/6.

I'm also not sure what to do about iotest 204 and 177 which use
'opt-write-zero=15M' for the blkdebug driver (which assigns that value
to pwrite_zeroes_alignment) making an is_power_of_2(align) assertion
fail.

Yet another issue is the 'detect_zeroes' option. If the option is set,
bdrv_aligned_pwritev() might set the BDRV_REQ_ZERO_WRITE flag even if
the request is not aligned to pwrite_zeroes_alignment and the original
bug could resurface.

Best Regards,
Fiona


Fiona Ebner (6):
  block/io: pass alignment to bdrv_init_padding()
  block/io: add 'bytes' parameter to bdrv_padding_rmw_read()
  block/io: honor pwrite_zeroes_alignment in bdrv_co_do_zero_pwritev()
  block/io: safeguard max transfer calculation in bdrv_aligned_pwritev()
  block/io: handle image length not aligned to write zeroes alignment in
    bdrv_co_do_zero_pwritev()
  block/io: keep zero flag for head/tail parts of misaligned zero write
    when possible

 block/io.c | 78 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 23 deletions(-)

-- 
2.47.3



