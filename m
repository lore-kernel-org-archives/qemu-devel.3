Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7485EC1EA5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 12:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnyFL-0005GY-C2; Thu, 05 Feb 2026 07:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vnyFH-0005Fq-UO; Thu, 05 Feb 2026 07:14:03 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vnyFF-0007IZ-8q; Thu, 05 Feb 2026 07:14:03 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5534D47C54;
 Thu, 05 Feb 2026 13:13:58 +0100 (CET)
Message-ID: <36a69637-d7b9-42cb-b16f-473091efb3ee@proxmox.com>
Date: Thu, 5 Feb 2026 13:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/6] block/io: avoid failure caused by misaligned
 BLKZEROOUT ioctl
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260202221634.GB429972@fedora>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260202221634.GB429972@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1770293559899
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

Am 02.02.26 um 11:15 PM schrieb Stefan Hajnoczi:
> On Fri, Jan 09, 2026 at 01:08:27PM +0100, Fiona Ebner wrote:
>> Previous discussion here:
>> https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@proxmox.com/
>>
>> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
>> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
>> certain 'qemu-img convert' invocations, because of a pre-existing
>> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
>> the request is shorter than the block size of the block device.
>>
>> Stefan suggested prioritizing bl.pwrite_zeroes_alignment in
>> bdrv_co_do_zero_pwritev(). This RFC explores that approach and the
>> issues with qcow2 I encountered, where
>> bl.pwrite_zeroes_alignment = s->subcluster_size;
>> I would be happy to discuss potential solutions and whether we should
>> use this approach after all.
> 
> Hi Fiona,
> I wanted to continue this discussion. My thoughts are that making
> bdrv_co_do_zero_pwritev() use bl.pwrite_zeroes_alignment is the right
> long-term solution to keep all the padding logic in one place.
> 
> On the other hand, your series shows it involves fixing a bunch of test
> failures and that's not fun. The original bug that is being solved here
> is my doing, so feel free to hand this over to me if you decide you
> don't want to work on it.

in your other mail, you mentioned you'll ask Kevin for his opinion. So
in part, I was waiting for that. But I also was side-tracked by other
things, and it will be 1-2 more weeks until I can really focus on this
again. If that is too long, please go ahead and pick it up.

Best Regards,
Fiona


