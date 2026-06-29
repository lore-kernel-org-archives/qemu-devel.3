Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0944C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBuR-0001sw-9f; Mon, 29 Jun 2026 09:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1weBu7-000180-Ld; Mon, 29 Jun 2026 09:20:03 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1weBu5-000541-Bb; Mon, 29 Jun 2026 09:20:03 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0B97A44C12;
 Mon, 29 Jun 2026 15:19:49 +0200 (CEST)
Message-ID: <526e49ea-03a7-460f-9974-976abf83c6b2@proxmox.com>
Date: Mon, 29 Jun 2026 15:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/28] fuse: Manually process requests (without libfuse)
From: Fiona Ebner <f.ebner@proxmox.com>
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-18-kwolf@redhat.com>
 <2493d422-d58a-4409-aee4-e932a4e0a73c@proxmox.com>
 <8ec42109-4123-4cc7-a55e-9aa2576a791c@redhat.com>
 <d5c3d3da-5102-4bdc-87bc-9733fb0cbf09@redhat.com>
 <9be52b33-9a28-41ca-896c-a41b5558864c@proxmox.com>
Content-Language: en-US
In-Reply-To: <9be52b33-9a28-41ca-896c-a41b5558864c@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1782739177164
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

Am 12.05.26 um 5:23 PM schrieb Fiona Ebner:
> Hi Hanna,
> 
> Am 08.05.26 um 3:11 PM schrieb Hanna Czenczek:
>> On 08.05.26 15:06, Hanna Czenczek wrote:
>>> On 08.05.26 13:55, Fiona Ebner wrote:
>>>> Dear maintainers,
>>>>
>>>> Am 10.03.26 um 6:37 PM schrieb Kevin Wolf:
>>>>> From: Hanna Czenczek <hreitz@redhat.com>
>>>>>
>>>>> Manually read requests from the /dev/fuse FD and process them, without
>>>>> using libfuse.  This allows us to safely add parallel request
>>>>> processing
>>>>> in coroutines later, without having to worry about libfuse internals.
>>>>> (Technically, we already have exactly that problem with
>>>>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>>>>>
>>>>> We will continue to use libfuse for mounting the filesystem;
>>>>> fusermount3
>>>>> is a effectively a helper program of libfuse, so it should know best
>>>>> how
>>>>> to interact with it.  (Doing it manually without libfuse, while doable,
>>>>> is a bit of a pain, and it is not clear to me how stable the "protocol"
>>>>> actually is.)
>>>>>
>>>>> Take this opportunity of quite a major rewrite to update the Copyright
>>>>> line with corrected information that has surfaced in the meantime.
>>>>
>>>> a colleague ran into another issue with a fuse export, this time in
>>>> combination with virt-fw-vars and bisecting points to this patch.
>>>> Before commit a94a1d7699 ("fuse: Manually process requests (without
>>>> libfuse)") the reproducer [0] completes successfully, after that
>>>> commit it hangs at [1]. The issue is still present with current
>>>> master. I can dig into the details next week.
>>>
>>> On my system, virt-fw-vars opens the file with O_TRUNC (after “INFO:
>>> writing raw edk2 varstore...”). It then tries to write to the file,
>>> but this returns a short write because the export is not marked as
>>> growable, and for some reason, the write is infinitely retried instead
>>> of aborting on ret=0 (which should indicate ENOSPC for writes).
>>>
>>> Using growable=true makes it work.  (For me :))
>>>
>>> For some reason, before said commit, libfuse just did not pass that
>>> truncate on. I’ll look into why exactly, but so far I would say the
>>> FUSE export behavior is as I would expect it.
>>
>> Ah, I see. libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, which has O_TRUNC be
>> passed on as an open option, but the old export code just ignored all
>> open options.
>>
>> The new code does not set that option, so O_TRUNC is executed as an
>> explicit truncate by the kernel, which then *is* executed.
> 
> thank you for digging into it!
> 
>> I’m not entirely sure how we should handle it. There is a case to be
>> made that with growable=off, it may make sense to ignore O_TRUNC (which
>> requires turning on FUSE_CAP_ATOMIC_O_TRUNC again and then continue to
>> ignore it). But on the other hand, O_TRUNC is O_TRUNC, and growable=off
>> does not explicitly mean “please behave as much as a block device as
>> possible”.
>>
>> What do you suggest?
> 
> It turns out that the missing FUSE_ATOMIC_O_TRUNC flag also regresses
> exports from block devices, making open() with O_TRUNC fail with
> EOPNOTSUPP [0], which worked before. Intuitively to me, growable=off
> feels like it should imply "shrinkable=off" as well.
> 
> My suggestions would be one of the following, with a preference for 2.:
> 
> 1. Always set FUSE_ATOMIC_O_TRUNC
> 
>   Most backwards compatible. There is the issue that O_TRUNC does not
>   apply when it's actually a file, which is surprising.
> 
> 2. Set FUSE_ATOMIC_O_TRUNC if growable=off
> 
>   Feels natural to me. People using growable=on with block device based
>   exports are still affected by the change in behavior.
> 
> 3. Set FUSE_ATOMIC_O_TRUNC if driver not file-based
> 
>   What should be the exact condition to consider the driver
>   not file-based? Here, O_TRUNC for a growable=off file-based export
>   does apply, which feels surprising to me. Continues breaking the use
>   I reported this issue for, requiring using growable=on in such cases.
> 
> 4. Set FUSE_ATOMIC_O_TRUNC if growable=off or if driver not file-based
> 
>   Similar to 2., but reduces cases affected by the change in behavior.

Should I go for approach number 2 or do you prefer another one?

> 
> Best Regards,
> Fiona
> 
> [0]:
> 
>> #!/bin/bash
>>
>> rm /tmp/export.fuse
>> lvremove lvm/test
>>
>> touch /tmp/export.fuse
>> lvcreate -n test --size 1M lvm
>>
>> (
>> ./storage-daemon/qemu-storage-daemon \
>>     --blockdev raw,node-name=node0,file.driver=host_device,file.filename=/dev/lvm/test \
>>     --export fuse,id=exp0,mountpoint=/tmp/export.fuse,node-name=node0,writable=true \
>>     --chardev socket,id=qmp,path=/run/qsd.qmp,server=on,wait=off \
>>     --monitor chardev=qmp,mode=control
>> ) &
>>
>> sleep 1 # too lazy to do proper synchronization for the reproducer here
>>
>> python3 -c 'open("/tmp/export.fuse", "wb")'
>> echo '{"execute": "qmp_capabilities"}{"execute": "quit"}' | socat - /run/qsd.qmp



