Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B5CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeYm-0002Hh-2v; Mon, 12 May 2025 21:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYi-0002F5-DT; Mon, 12 May 2025 21:35:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYf-00021R-VL; Mon, 12 May 2025 21:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=zwEMbmSFTjMvk+Wblmd/B55xjOZPc62J//7lW5rGbRk=; b=BfVdvFR52Zfh
 jL58m61oGJr6oXsVVpwY9PComauiKjrFytxmlDelfMBiVrj0lPcKHNHx9eiTbM9MrPZ6jRBMyh8qE
 3LJXryuo2bMKcNNl9oM0LP9OWjUtnzEZko5AFsAVTdayAUGdgxqo0wCJ7XDJXnsWXS98kIgYJEfvw
 k3G1LVRicI/P/xLyqwku+EuaCSWh2/rwIhDHmLqVrPRBranxKIFZYMhA12umu4/t/yHVgg4gzh/oF
 LxnwY9WJXN2JlZQk3bNFjD+SaNPkZGtlUnx+k1sEvgC2By+cS2ojwU1aOsGx3A7vI/QVGiSmEWWjP
 eG+fhWEI/JGe2zzkaiYmhQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeUd-00DboQ-2l; Tue, 13 May 2025 03:35:36 +0200
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 0/4] improve block_status() for cbw + snapshot setup
Date: Tue, 13 May 2025 03:32:34 +0200
Message-ID: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Recently we had some reports about stuck full backups: running backup
job had 0 progress for more than an hour. This reproduced only on big
images, at least 30TB of allocated space.
We are using snapshot filter + cbw filter + blockdev-backup. The
discovered problem lies in access bitmap in cbw filter.
To build bcs bitmap for backup, the job repeatedly asks for block
status with a range (X, virtual_size). As we are accessing the disk
via snapshot filter, we end up in cbw_co_snapshot_block_status()->
cbw_snapshot_read_lock(). Here we check that access bitmap does not
have any zeroes in this range. After that, we ask the disk.
Firstly, we always look for zero in access bitmap for the whole
range. This is rather slow, because it is full and we need to scan
every bit in a lower level. Secondly, the following block status call
to the disk may return not-very-high amount of continious clusters,
for example 512 (empirical value, guessing for the 'full' image it is
4K/clu_addr_size for qcow2 driver).
This way we are doomed to re-scan access bitmap on the next block
status request (X + 512, virtual_size).

perf tracing example:
  96.67%          9581  qemu-kvm         qemu-kvm                    [.] hbitmap_next_zero
   0.33%            32  qemu-kvm         qemu-kvm                    [.] qcow2_cache_do_get.lto_priv.0
   0.10%            10  qemu-kvm         [kernel.vmlinux]            [k] perf_adjust_freq_unthr_context
   0.08%             8  qemu-kvm         qemu-kvm                    [.] qcow2_get_host_offset

This can be clearly observed on the image with small clu_size=65536
and preallocated metadata.
size                   10T   11T
blockdev-backup        52s   57s
cbw + snap             325s  413s
cbw + snap + patches   55s   61s

The growth is also non-linear in this case, +10% size results in
+20% time.

This patchset changes access-bitmap into 'deny' bitmap by reversing
the bits within and making the code look for set bits. It is much
faster due to hbitmap levels.

Also
 - update iotest 257: now access bitmap on the cbw filter is empty,
so count is 0 instead of 67108864 (which is the image size)
 - remove meta betmap leftovers
 - report block_status() until the end of accessible section to
snapshot filter, instead of returning EINVAL on big requests

Andrey Zhadchenko (4):
  hbitmap: drop meta bitmap leftovers
  hbitmap: introduce hbitmap_reverse()
  block/copy-before-write: reverse access bitmap
  block/copy-before-write: report partial block status to snapshot

 block/copy-before-write.c    | 33 +++++++++++++++++++++------------
 block/dirty-bitmap.c         |  9 +++++++++
 include/block/block_int-io.h |  1 +
 include/qemu/hbitmap.h       |  8 ++++++++
 tests/qemu-iotests/257.out   | 28 ++++++++++++++--------------
 util/hbitmap.c               | 32 +++++++++++++++++---------------
 6 files changed, 70 insertions(+), 41 deletions(-)

-- 
2.43.0


