Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF73EE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 07:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKYOG-0008EA-GK; Mon, 09 Dec 2024 02:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tKYOE-0008Ds-3l
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 02:41:10 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tKYOA-0000s1-38
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 02:41:08 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:292a:0:640:622b:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D25EA60C0B;
 Mon,  9 Dec 2024 10:40:57 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b658::1:2f] (unknown
 [2a02:6b8:b081:b658::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tefNta1IaGk0-86DIyEPR; Mon, 09 Dec 2024 10:40:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733730057;
 bh=Gf31hWQCpmJb0B35QiqTORZaZSvWTMGgEbXCl1SxleQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Md55/tVihimbUHFWjBstChgedZhD++cmQiGO08dJQ8IfWpTaFix/PMsKQjfcpoGB1
 vU30G4rW0wnCDLTzJ0r62eLrFOpxFtjB22MCSRzkiUF7nCczzsFQIHfKIr5nFUp2VC
 sXPYKvE9kjvLH/TPGSXnZGIUemeltp0/OsvXpHuI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <779a4733-888b-4591-af5e-381572c84c20@yandex-team.ru>
Date: Mon, 9 Dec 2024 10:40:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] overcommit: introduce mem-lock-onfault
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
 <Z1JOpadES2iV_i0v@x1n>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z1JOpadES2iV_i0v@x1n>
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

On 12/6/24 4:08 AM, Peter Xu wrote:

> On Fri, Dec 06, 2024 at 02:19:06AM +0300, Daniil Tatianin wrote:
>> Currently, passing mem-lock=on to QEMU causes memory usage to grow by
>> huge amounts:
>>
>> no memlock:
>>      $ qemu-system-x86_64 -overcommit mem-lock=off
>>      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>      45652
>>
>>      $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
>>      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>      39756
>>
>> memlock:
>>      $ qemu-system-x86_64 -overcommit mem-lock=on
>>      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>      1309876
>>
>>      $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
>>      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>      259956
>>
>> This is caused by the fact that mlockall(2) automatically
>> write-faults every existing and future anonymous mappings in the
>> process right away.
>>
>> One of the reasons to enable mem-lock is to protect a QEMU process'
>> pages from being compacted and migrated by kcompactd (which does so
>> by messing with a live process page tables causing thousands of TLB
>> flush IPIs per second) basically stealing all guest time while it's
>> active.
>>
>> mem-lock=on helps against this (given compact_unevictable_allowed is 0),
>> but the memory overhead it introduces is an undesirable side effect,
>> which we can completely avoid by passing MCL_ONFAULT to mlockall, which
>> is what this series allows to do with a new command line option called
>> mem-lock-onfault.
> IMHO it'll be always helpful to dig and provide information on why such
> difference existed.  E.g. guest mem should normally be the major mem sink
> and that definitely won't be affected by either ON_FAULT or not.
>
> I had a quick look explicitly on tcg (as that really surprised me a bit..).
> When you look at the mappings there's 1G constant shmem map that always got
> locked and populated.
>
> It turns out to be tcg's jit buffer, alloc_code_gen_buffer_splitwx_memfd:

Thanks for looking into this! I'd guessed it was something to do with 
JIT, makes sense.

>      buf_rw = qemu_memfd_alloc("tcg-jit", size, 0, &fd, errp);
>      if (buf_rw == NULL) {
>          goto fail;
>      }
>
>      buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
>      if (buf_rx == MAP_FAILED) {
>          error_setg_errno(errp, errno,
>                           "failed to map shared memory for execute");
>          goto fail;
>      }
>
> Looks like that's the major reason why tcg has mlockall bloated constantly
> with roughly 1G size - that seems to be from tcg_init_machine().  I didn't
> check kvm.
>
> Logically having a on-fault option won't ever hurt, so probably not an
> issue to have it anyway.  Still, share my finding above, as IIUC that's
> mostly why it was bloated for tcg, so maybe there're other options too.

Yeah, the situation with KVM is slightly better, although it's still a 
~200MiB overhead with default Q35 and no extra devices (I haven't 
measured the difference with various devices).

I think it's definitely nice to have an on-fault option for this, as 
optimizing every possible mmap caller for the rare mem-lock=on case 
might be too ambitious.

Thanks!

>
>> memlock-onfault:
>>      $ qemu-system-x86_64 -overcommit mem-lock-onfault=on
>>      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>      54004
>>
>>      $ ./qemu-system-x86_64 -overcommit mem-lock-onfault=on -enable-kvm
>>      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>>      47772
>>
>> You may notice the memory usage is still slightly higher, in this case
>> by a few megabytes over the mem-lock=off case. I was able to trace this
>> down to a bug in the linux kernel with MCL_ONFAULT not being honored for
>> the early process heap (with brk(2) etc.) so it is still write-faulted in
>> this case, but it's still way less than it was with just the mem-lock=on.
>>
>> Daniil Tatianin (2):
>>    os: add an ability to lock memory on_fault
>>    overcommit: introduce mem-lock-onfault
>>
>>   include/sysemu/os-posix.h |  2 +-
>>   include/sysemu/os-win32.h |  3 ++-
>>   include/sysemu/sysemu.h   |  1 +
>>   migration/postcopy-ram.c  |  4 ++--
>>   os-posix.c                | 10 ++++++++--
>>   qemu-options.hx           | 13 ++++++++++---
>>   system/globals.c          |  1 +
>>   system/vl.c               | 18 ++++++++++++++++--
>>   8 files changed, 41 insertions(+), 11 deletions(-)
>>
>> -- 
>> 2.34.1
>>
>>

