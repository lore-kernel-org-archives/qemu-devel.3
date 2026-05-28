Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAA7CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWAe-0002mf-Vm; Thu, 28 May 2026 04:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wSWAd-0002mR-DA; Thu, 28 May 2026 04:32:51 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wSWAb-0002Ms-4U; Thu, 28 May 2026 04:32:51 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 87B0842662;
 Thu, 28 May 2026 10:32:38 +0200 (CEST)
Message-ID: <800f05f8-e77a-496b-8a25-253ad7cafecb@proxmox.com>
Date: Thu, 28 May 2026 10:32:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/6] block/io: avoid failure caused by misaligned
 BLKZEROOUT ioctl
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, hreitz@redhat.com, fam@euphon.net
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260202221634.GB429972@fedora>
 <36a69637-d7b9-42cb-b16f-473091efb3ee@proxmox.com>
 <aYS_G-QHlbucVpUd@redhat.com>
 <CAJSP0QX22xxAq7sYChGMq9up3YOAXuxrbe99_8YoLFV0pKj0Zg@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJSP0QX22xxAq7sYChGMq9up3YOAXuxrbe99_8YoLFV0pKj0Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779957130348
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 27.05.26 um 11:06 PM schrieb Stefan Hajnoczi:
> On Thu, Feb 5, 2026 at 11:03 AM Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 05.02.2026 um 13:13 hat Fiona Ebner geschrieben:
>>> Hi Stefan,
>>>
>>> Am 02.02.26 um 11:15 PM schrieb Stefan Hajnoczi:
>>>> On Fri, Jan 09, 2026 at 01:08:27PM +0100, Fiona Ebner wrote:
>>>>> Previous discussion here:
>>>>> https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@proxmox.com/
>>>>>
>>>>> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
>>>>> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
>>>>> certain 'qemu-img convert' invocations, because of a pre-existing
>>>>> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
>>>>> the request is shorter than the block size of the block device.
>>>>>
>>>>> Stefan suggested prioritizing bl.pwrite_zeroes_alignment in
>>>>> bdrv_co_do_zero_pwritev(). This RFC explores that approach and the
>>>>> issues with qcow2 I encountered, where
>>>>> bl.pwrite_zeroes_alignment = s->subcluster_size;
>>>>> I would be happy to discuss potential solutions and whether we should
>>>>> use this approach after all.
>>>>
>>>> Hi Fiona,
>>>> I wanted to continue this discussion. My thoughts are that making
>>>> bdrv_co_do_zero_pwritev() use bl.pwrite_zeroes_alignment is the right
>>>> long-term solution to keep all the padding logic in one place.
>>>>
>>>> On the other hand, your series shows it involves fixing a bunch of test
>>>> failures and that's not fun. The original bug that is being solved here
>>>> is my doing, so feel free to hand this over to me if you decide you
>>>> don't want to work on it.
>>>
>>> in your other mail, you mentioned you'll ask Kevin for his opinion. So
>>> in part, I was waiting for that. But I also was side-tracked by other
>>> things, and it will be 1-2 more weeks until I can really focus on this
>>> again. If that is too long, please go ahead and pick it up.
>>
>> I didn't review this thoroughly yet, but I agree that considering the
>> alignment from the start is the better solution and also more consistent
>> with what we're already doing for normal reads and writes.
>>
>> We just need to make sure that we use the right alignments in the right
>> places, which can be a bit confusing with the fallbacks to buffered zero
>> writes here and there.
>>
>> I assume that there is enough time left to do this before the 11.0
>> release and there is no need to take something like v1 as an
>> intermediate solution?
> 
> No progress has been made and I'm unable to commit time at the moment.

Me neither unfortunately.

> Is everyone okay with merging Fiona's smaller original patch? While it
> would be nice to implement a deeper fix, it's better to have a fix and
> I think there is no great risk merging the original patch.
> 
> https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@proxmox.com/

FWIW, we have been using that patch downstream since mid-February [0]
and nobody reported issues with it as far as I'm aware. I suppose it
could use a 'TODO' code comment that the proper fix looks different. If
you choose to go with that patch, should I send a v2 with such a comment
or can that be added when applying?

Best Regards,
Fiona

[0]:
https://git.proxmox.com/?p=pve-qemu.git;a=commitdiff;h=6960b5e033fa911f9882751950df28a193255683


