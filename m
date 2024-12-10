Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84A0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3cF-0004qw-8R; Tue, 10 Dec 2024 12:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tL3bw-0004k0-MU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:01:41 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tL3bt-0006fK-5h
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:01:23 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3b05:0:640:71ba:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5052E60A98;
 Tue, 10 Dec 2024 20:01:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b69c::1:32] (unknown
 [2a02:6b8:b081:b69c::1:32])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 91qQPV3IgmI0-Sw8wco2j; Tue, 10 Dec 2024 20:01:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733850071;
 bh=O5hFNsO/jxQo9R0QZNMvhKGJpSWKuowCtPUjS9Mtc28=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Nek5maaQkSEiQPv3CJo/qbiq6im+DwSAJztShk0xkkp53GQADKKpBNq26EK5cSOqq
 lHbXSWpCxLQuDyC9JwExupuK3HkRgJdtGiqcMeH/hNoAegu6rWA0POm4seLPOzmwZs
 MlLd0M5oi5Q8A7RFICbr7ynY+iNzrMTd+6biZRVM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ddd20bd5-2596-4966-a77f-fb44b651dc6a@yandex-team.ru>
Date: Tue, 10 Dec 2024 20:01:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] overcommit: introduce mem-lock-onfault
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
 <Z1JOpadES2iV_i0v@x1n> <779a4733-888b-4591-af5e-381572c84c20@yandex-team.ru>
 <Z1hw7dvTe4jMgXeq@x1n>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z1hw7dvTe4jMgXeq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/10/24 7:48 PM, Peter Xu wrote:

> On Mon, Dec 09, 2024 at 10:40:51AM +0300, Daniil Tatianin wrote:
>> On 12/6/24 4:08 AM, Peter Xu wrote:
>>
>>> On Fri, Dec 06, 2024 at 02:19:06AM +0300, Daniil Tatianin wrote:
>>>> Currently, passing mem-lock=on to QEMU causes memory usage to grow by
>>>> huge amounts:
>>>>
>>>> no memlock:
>>>>       $ qemu-system-x86_64 -overcommit mem-lock=off
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       45652
>>>>
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       39756
>>>>
>>>> memlock:
>>>>       $ qemu-system-x86_64 -overcommit mem-lock=on
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       1309876
>>>>
>>>>       $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
>>>>       $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>>>       259956
>>>>
>>>> This is caused by the fact that mlockall(2) automatically
>>>> write-faults every existing and future anonymous mappings in the
>>>> process right away.
>>>>
>>>> One of the reasons to enable mem-lock is to protect a QEMU process'
>>>> pages from being compacted and migrated by kcompactd (which does so
>>>> by messing with a live process page tables causing thousands of TLB
>>>> flush IPIs per second) basically stealing all guest time while it's
>>>> active.
>>>>
>>>> mem-lock=on helps against this (given compact_unevictable_allowed is 0),
>>>> but the memory overhead it introduces is an undesirable side effect,
>>>> which we can completely avoid by passing MCL_ONFAULT to mlockall, which
>>>> is what this series allows to do with a new command line option called
>>>> mem-lock-onfault.
>>> IMHO it'll be always helpful to dig and provide information on why such
>>> difference existed.  E.g. guest mem should normally be the major mem sink
>>> and that definitely won't be affected by either ON_FAULT or not.
>>>
>>> I had a quick look explicitly on tcg (as that really surprised me a bit..).
>>> When you look at the mappings there's 1G constant shmem map that always got
>>> locked and populated.
>>>
>>> It turns out to be tcg's jit buffer, alloc_code_gen_buffer_splitwx_memfd:
>> Thanks for looking into this! I'd guessed it was something to do with JIT,
>> makes sense.
>>
>>>       buf_rw = qemu_memfd_alloc("tcg-jit", size, 0, &fd, errp);
>>>       if (buf_rw == NULL) {
>>>           goto fail;
>>>       }
>>>
>>>       buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
>>>       if (buf_rx == MAP_FAILED) {
>>>           error_setg_errno(errp, errno,
>>>                            "failed to map shared memory for execute");
>>>           goto fail;
>>>       }
>>>
>>> Looks like that's the major reason why tcg has mlockall bloated constantly
>>> with roughly 1G size - that seems to be from tcg_init_machine().  I didn't
>>> check kvm.
>>>
>>> Logically having a on-fault option won't ever hurt, so probably not an
>>> issue to have it anyway.  Still, share my finding above, as IIUC that's
>>> mostly why it was bloated for tcg, so maybe there're other options too.
>> Yeah, the situation with KVM is slightly better, although it's still a
>> ~200MiB overhead with default Q35 and no extra devices (I haven't measured
>> the difference with various devices).
>>
>> I think it's definitely nice to have an on-fault option for this, as
>> optimizing every possible mmap caller for the rare mem-lock=on case might be
>> too ambitious.
> It really depends, IMHO, and that's why I didn't already ack the series.
>
> It may be relevant to the trade-off here on allowing faults to happen later
> even if mem-lock=on.  The question is why, for example in your use case,
> would like to lock the memory.
>
> Take kvm-rt as example, I believe that's needed because RT apps (running in
> the guest) would like to avoid page faults throughout the stack, so that
> guest workload, especially on the latency part of things, is predictable.
>
> Here if on-fault is enabled it could beat that purpose already.
>
> Or if the current use case is making sure after QEMU boots the memory will
> always present so that even if later the host faces memory stress it won't
> affect anything running the VM as it pre-allocated everything (so that's
> beyond memory-backend-*,prealloc=on, because it covers QEMU/KVM memory
> too).  Meanwhile locked pages won't swap out, so it's always there.
>
> But then with on-fault, it means the pages will only be locked upon access.
> Then it means the guarantee on "QEMU secures the memory on boot" is gone
> too.
>
> That's why I was thinking whether your specific use case really wants
> on-fault, or you do want e.g. to have a limit on the tcg-jit buffer instead
> (or same to whatever kvm was consuming), so you don't want that large a
> buffer, however you still want to have all things locked up upfront.  It
> can be relevant to why your use case started to use mem-lock=on before this
> on-fault flag.

I mentioned my use case in the cover letter. Basically we want to 
protect QEMU's pages from being migrated and compacted by kcompactd, 
which it accomplishes by modifying live page tables and spamming the 
process with TLB invalidate IPIs while it does that, which kills guest 
performance for the duration of the compaction operation.

Memory locking allows to protect a process from kcompactd page 
compaction and more importantly, migration (that is taking a PTE and 
replacing it with one, which is closer in memory to reduce 
fragmentation). (As long as /proc/sys/vm/compact_unevictable_allowed is 0)

For this use case we don't mind page faults as they take more or less 
constant time, which we can also avoid if we wanted by preallocating 
guest memory. We do, however, want PTEs to be untouched by kcompactd, 
which MCL_ONFAULT accomplishes just fine without the extra memory 
overhead that comes from various anonymous mappings getting 
write-faulted with the currently available mem-lock=on option.

In our case we use KVM of course, TCG was just an experiment where I 
noticed anonymous memory
jump way too much.

I don't think it's feasible in our case to look for the origin of every 
anonymous mapping that grew compared to the no mem-lock case (which 
there's about ~30 with default Q35 + KVM, without any extra devices), 
and try to optimize it to map anonymous memory less eagerly.

Thanks!

>
> OTOH, I believe on-fault cannot work with kvm-rt at all already, because of
> its possible faults happening later on - even if the fault can happen in
> KVM and even if it's not about accessing guest mem, it can still be part of
> overhead later when running the rt application in the guest, hence it can
> start to break RT deterministics.
>
> Thanks,
>

