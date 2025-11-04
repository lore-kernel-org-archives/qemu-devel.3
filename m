Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ACECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCYb-0006Xv-2z; Tue, 04 Nov 2025 03:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGCYY-0006X1-EY
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:38:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGCYV-0005Pi-O3
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RBxl96VvIKgtXPsH6iKaWsKYX1KeOafMFXnfBoWkLNs=;
 b=NwecBC/QvSb76SKnmJ0FQcZC1QkQ5G/AsckMydBJr8RbfwWPLxj9qYrl1Pcn6RhpHVQowZ
 EmtQmL49o6ufSaXfUXBxdlZFdFeOmurWSFFlOaD5Dq3Qudws6+TQQTS79KkNmNYPWATmGr
 rT0XAZPG4WpekVoPk1hvM9cP7gdTmJw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-zz3kAD1PPYei4KOz1p_bsA-1; Tue, 04 Nov 2025 03:38:15 -0500
X-MC-Unique: zz3kAD1PPYei4KOz1p_bsA-1
X-Mimecast-MFC-AGG-ID: zz3kAD1PPYei4KOz1p_bsA_1762245494
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c17b29f3so2607257f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762245494; x=1762850294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RBxl96VvIKgtXPsH6iKaWsKYX1KeOafMFXnfBoWkLNs=;
 b=YVPU6w0hljZEiHUlHZwoPdpcu8rjEY+L/bXp57MRaKRnCsoVOFDTHxD6Gobaz/82Nu
 i8fHnNuBBuMf2+TU4rVFr02rBzGrSzf1bPTShTBVqTWVRcmtGk5h+8OaUjvjV9OY/Qzw
 owd2NwiXcT9I5yrcD88hT/O96Thau2G10Up8bLGhfjI9LiZfDOw2HgZR+BhVrT7Bd23H
 oQcVghPsYwVRj8HXPSEmOfizDV0t7goa4caMM+q5xeSZWnhc08NAlTOV2hrV9bQMpiAf
 6GZT0bq8FHTrnZLqNFVCVSb4A+mBtvoey8hhTCNgch1ZwBi8NQmHM38oCHD0LuB9QOOZ
 znLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762245494; x=1762850294;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RBxl96VvIKgtXPsH6iKaWsKYX1KeOafMFXnfBoWkLNs=;
 b=wdHgeT2B33qUpYtU0GjQP5UhKzDZfxwDodSr+b4Ap0+8GaVbOejL446Jwe3pbAtroh
 iG6lz56DL19omjiodWnPyhFQ1aYy5pAdU/T8Ho0ZnQjrM1tg26ARu/hcCg7QB+6tP+Mn
 kNB5BRPUjI0ITIAnSW0EodaFTVDzQ7EX3mdTXWxVOEY0x+r3rQ5hvptKYNwblaNX4nTm
 pvQbTho+5PSvBOLrQLT/ePtY8NO/u5pGf2PuqO4nYFoY11P3jT4pIlGUPLWmQkTgzuRN
 gvp0aZAGy5H75oO/51YpN/LzLCRERubtld0XUUmKY0qQ3e1+OJIrvbuCUBao1nceFdZT
 CAPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJb0HZnJAfYWzrBF+PyssBs+wB7cEvWEed2l86kGNSNyvjpXiTo+vskV9iRvxHsgYawFvfQlFKECsL@nongnu.org
X-Gm-Message-State: AOJu0Yx9VOBPmoU+Ndq7PoTytnK1Fvw647iFPhbx9w9FSgK28v5JD9s+
 pCuvdIBfK2bqdVOd72kwD9kEYebHqMXgz/73XDlBvcOQ2xxe3RPNuvVq5b6igQhOv7hVqe5NHzC
 2X+a+gKJwu13dUmXlAI/bf/+2F8jwrJSnxrdu3E57R6Vlp//nOWZ/q9UJ
X-Gm-Gg: ASbGncspLB4jn5cMCZZvdoT98XTm1OwoGWncsjhIcSZzXTzlr6dIOG8kLWYps8mV/qF
 W9n2Eoz1v/NuRxn8WAU6Q58g1YU+pu9For4oEJ1DR6BMVMlQ07yTYzJgYTXqawBnOvlfhRP9+vw
 v56djajXSBQJQ7cXlJIvJjsiYibLX5uILaloOy76k/HUPxiNhPxEM9agpS09zlAmJvL7agjqkdR
 krcCK4yoDvhRK7CQXIH8RT3V/+sxIpXDJkd8gXSGgvaIRJ7LhmvvtHS6vy0dqiTbyEKN7nv9yhA
 5VI6k1S6aPerzwvbf3VpQMcBjlyTtKEi3uhc8eqgj2U66/xI3Z9m6iiawP2tfUbVfY+ZPOrM
X-Received: by 2002:a05:6000:178d:b0:429:b6e2:1ecf with SMTP id
 ffacd0b85a97d-429bd682973mr14191662f8f.22.1762245493642; 
 Tue, 04 Nov 2025 00:38:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo6I23zpNjvOsOlrM4fhPbChL7bdu9yrG/lMYtsCsICgJLGN+2uuIAvV9im3pFDSwh9vCgiw==
X-Received: by 2002:a05:6000:178d:b0:429:b6e2:1ecf with SMTP id
 ffacd0b85a97d-429bd682973mr14191635f8f.22.1762245493140; 
 Tue, 04 Nov 2025 00:38:13 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc192a96sm3321382f8f.13.2025.11.04.00.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 00:38:12 -0800 (PST)
Message-ID: <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
Date: Tue, 4 Nov 2025 09:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
 <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/11/2025 09.08, Akihiko Odaki wrote:
> On 2025/11/04 16:41, Thomas Huth wrote:
>> On 04/11/2025 02.45, Akihiko Odaki wrote:
>>> On 2025/11/03 22:59, Thomas Huth wrote:
>>>> On 28/10/2025 18.34, Paolo Bonzini wrote:
>>>>> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>
>>>>> Borrow the concept of force quiescent state from Linux to ensure readers
>>>>> remain fast during normal operation and to avoid stalls.
>>>>
>>>>   Hi Akihiko,
>>>>
>>>> looks like this commit has introduced a regression with the "replay" 
>>>> functional test on the alpha target.
>>>> When I run something like:
>>>>
>>>>   pyvenv/bin/meson test --no-rebuild -t 1 --setup thorough \
>>>>    --num-processes 1 --repeat 10 func-alpha-replay
>>>>
>>>> in the build folder, approx. half of the test runs are failing for me now.
>>>>
>>>> I bisected the issue to this patch here - when I rebuild qemu-system- 
>>>> alpha with the commit right before this change here, the above test runs 
>>>> work fine, so I'm pretty sure that the problem has been introduced by 
>>>> this commit here.
>>>>
>>>> Could you please have a look?
>>>
>>> I cannot reproduce it with commit 55d98e3edeeb ("rcu: Unify force 
>>> quiescent state").
>>>
>>> Can you provide meson-logs/testlog-thorough.txt so that I can look into 
>>> the failure you are facing? If you think you have something useful for 
>>> debugging, please share it to me too.
>>
>> There's not much in that testlog-thorough.txt that could be helpful here,
>> it's basically just the information that the test has been killed due to
>> the timeout:
>>
>> ==================================== 1/1 ===================================
>> test:         qemu:func-thorough+func-alpha-thorough+thorough / func- 
>> alpha-replay
>> start time:   07:25:26
>> duration:     90.01s
>> result:       killed by signal 15 SIGTERM
>> command:      RUST_BACKTRACE=1 QEMU_TEST_QEMU_IMG=/tmp/qemu-rcu/qemu-img 
>> QEMU_TEST_GDB=/usr/bin/gdb MALLOC_PERTURB_=255 MESON_TEST_ITERATION=1 
>> PYTHONPATH=/home/thuth/devel/qemu/python:/home/thuth/devel/qemu/tests/ 
>> functional G_TEST_SLOW=1 SPEED=thorough QEMU_TEST_QEMU_BINARY=/tmp/qemu- 
>> rcu/qemu-system-alpha 
>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 
>> LD_LIBRARY_PATH=/tmp/qemu-rcu/tests/tcg/plugins:/tmp/qemu-rcu/contrib/ 
>> plugins 
>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QEMU_BUILD_ROOT=/tmp/qemu-rcu /tmp/qemu-rcu/pyvenv/bin/python3 /home/thuth/devel/qemu/tests/functional/alpha/test_replay.py
>> =============================================================================
>>
>> Summary of Failures:
>>
>> 1/1 qemu:func-thorough+func-alpha-thorough+thorough / func-alpha-replay 
>> TIMEOUT        90.01s   killed by signal 15 SIGTERM
>>
>>
>> There is also not that much helpful information in
>> tests/functional/alpha/test_replay.AlphaReplay.test_clipper, apart from
>> the console.log file. For a good run, the console log looks like this:
>>
>> 2025-11-04 08:16:46,148: PCI: 00:01:0 class 0101 id 1095:0646
>> 2025-11-04 08:16:46,149: PCI:   region 0: 0000c000
>> 2025-11-04 08:16:46,149: PCI:   region 1: 0000c008
>> 2025-11-04 08:16:46,149: PCI:   region 2: 0000c010
>> 2025-11-04 08:16:46,149: PCI:   region 3: 0000c018
>> 2025-11-04 08:16:46,149: PCI:   region 4: 0000c020
>> 2025-11-04 08:16:46,149: PCI: 00:07:0 class 0601 id 8086:0484
>> 2025-11-04 08:16:48,149: [    0.000000] Initializing cgroup subsys cpu
>> 2025-11-04 08:16:48,149: [    0.000000] Linux version 2.6.26-2-alpha- 
>> generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 20080704 
>> (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
>> 2025-11-04 08:16:48,150: [    0.000000] Booting GENERIC on Tsunami 
>> variation Clipper using machine vector Clipper from SRM
>> 2025-11-04 08:16:48,150: [    0.000000] Major Options: MAGIC_SYSRQ
>> 2025-11-04 08:16:48,150: [    0.000000] Command line: printk.time=0 
>> console=ttyS0
>> 2025-11-04 08:16:48,150: [    0.000000] memcluster 0, usage 1, 
>> start        0, end       15
>> 2025-11-04 08:16:48,150: [    0.000000] memcluster 1, usage 0, start       
>> 15, end    16384
>> 2025-11-04 08:16:48,150: [    0.000000] freeing pages 15:2048
>> 2025-11-04 08:16:48,150: [    0.000000] freeing pages 2987:16384
>> 2025-11-04 08:16:48,151: [    0.000000] reserving pages 2987:2988
>> 2025-11-04 08:16:48,151: [    0.000000] Built 1 zonelists in Zone order, 
>> mobility grouping on.  Total pages: 16272
>> 2025-11-04 08:16:48,151: [    0.000000] Kernel command line: printk.time=0 
>> console=ttyS0
>> 2025-11-04 08:16:57,358: PCI: 00:01:0 class 0101 id 1095:0646
>> 2025-11-04 08:16:57,358: PCI:   region 0: 0000c000
>> 2025-11-04 08:16:57,358: PCI:   region 1: 0000c008
>> 2025-11-04 08:16:57,359: PCI:   region 2: 0000c010
>> 2025-11-04 08:16:57,359: PCI:   region 3: 0000c018
>> 2025-11-04 08:16:57,359: PCI:   region 4: 0000c020
>> 2025-11-04 08:16:57,360: PCI: 00:07:0 class 0601 id 8086:0484
>> 2025-11-04 08:17:08,468: [    0.000000] Initializing cgroup subsys cpu
>> 2025-11-04 08:17:08,470: [    0.000000] Linux version 2.6.26-2-alpha- 
>> generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 20080704 
>> (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
>> 2025-11-04 08:17:08,471: [    0.000000] Booting GENERIC on Tsunami 
>> variation Clipper using machine vector Clipper from SRM
>> 2025-11-04 08:17:08,471: [    0.000000] Major Options: MAGIC_SYSRQ
>> 2025-11-04 08:17:08,472: [    0.000000] Command line: printk.time=0 
>> console=ttyS0
>> 2025-11-04 08:17:08,472: [    0.000000] memcluster 0, usage 1, 
>> start        0, end       15
>> 2025-11-04 08:17:08,473: [    0.000000] memcluster 1, usage 0, start       
>> 15, end    16384
>> 2025-11-04 08:17:08,473: [    0.000000] freeing pages 15:2048
>> 2025-11-04 08:17:08,474: [    0.000000] freeing pages 2987:16384
>> 2025-11-04 08:17:08,474: [    0.000000] reserving pages 2987:2988
>> 2025-11-04 08:17:08,475: [    0.000000] Built 1 zonelists in Zone order, 
>> mobility grouping on.  Total pages: 16272
>> 2025-11-04 08:17:08,476: [    0.000000] Kernel command line: printk.time=0 
>> console=ttyS0
>>
>> I.e. the replay worked as expected. When it fails, console.log only contains:
>>
>> 2025-11-04 08:25:26,601: PCI: 00:01:0 class 0101 id 1095:0646
>> 2025-11-04 08:25:26,601: PCI:   region 0: 0000c000
>> 2025-11-04 08:25:26,601: PCI:   region 1: 0000c008
>> 2025-11-04 08:25:26,601: PCI:   region 2: 0000c010
>> 2025-11-04 08:25:26,601: PCI:   region 3: 0000c018
>> 2025-11-04 08:25:26,601: PCI:   region 4: 0000c020
>> 2025-11-04 08:25:26,602: PCI: 00:07:0 class 0601 id 8086:0484
>> 2025-11-04 08:25:28,601: [    0.000000] Initializing cgroup subsys cpu
>> 2025-11-04 08:25:28,602: [    0.000000] Linux version 2.6.26-2-alpha- 
>> generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 20080704 
>> (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
>> 2025-11-04 08:25:28,602: [    0.000000] Booting GENERIC on Tsunami 
>> variation Clipper using machine vector Clipper from SRM
>> 2025-11-04 08:25:28,602: [    0.000000] Major Options: MAGIC_SYSRQ
>> 2025-11-04 08:25:28,602: [    0.000000] Command line: printk.time=0 
>> console=ttyS0
>> 2025-11-04 08:25:28,602: [    0.000000] memcluster 0, usage 1, 
>> start        0, end       15
>> 2025-11-04 08:25:28,602: [    0.000000] memcluster 1, usage 0, start       
>> 15, end    16384
>> 2025-11-04 08:25:28,602: [    0.000000] freeing pages 15:2048
>> 2025-11-04 08:25:28,603: [    0.000000] freeing pages 2987:16384
>> 2025-11-04 08:25:28,603: [    0.000000] reserving pages 2987:2988
>> 2025-11-04 08:25:28,603: [    0.000000] Built 1 zonelists in Zone order, 
>> mobility grouping on.  Total pages: 16272
>> 2025-11-04 08:25:28,603: [    0.000000] Kernel command line: printk.time=0 
>> console=ttyS0
>>
>> I.e. the replay did not work.
>>
>> Could this RCU stuff somehow influence the replay mechanism in QEMU?
> 
> I don't know (yet).
> 
> Can you attach gdb and show a backtrace for each thread? It often reveals 
> deadlock among threads.

Sure, it looks like this:

(gdb) thread apply all bt

Thread 4 (Thread 0x7f31bd1ff6c0 (LWP 89223) "qemu-system-alp"):
#0  0x00007f31c47150cd in syscall () at /lib64/libc.so.6
#1  0x00005593dd2b578d in qemu_futex_wait (f=0x5593ddad9e50 <rcu_call_ready_event>, val=4294967295) at /home/thuth/devel/qemu/include/qemu/futex.h:47
#2  0x00005593dd2b59a1 in qemu_event_wait (ev=0x5593ddad9e50 <rcu_call_ready_event>) at ../../home/thuth/devel/qemu/util/event.c:162
#3  0x00005593dd2c12e3 in call_rcu_thread (opaque=0x0) at ../../home/thuth/devel/qemu/util/rcu.c:304
#4  0x00005593dd2b3311 in qemu_thread_start (args=0x5594051010c0) at ../../home/thuth/devel/qemu/util/qemu-thread-posix.c:393
#5  0x00007f31c4693f54 in start_thread () at /lib64/libc.so.6
#6  0x00007f31c471732c in __clone3 () at /lib64/libc.so.6

Thread 3 (Thread 0x7f31bc8fd6c0 (LWP 89224) "qemu-system-alp"):
#0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
#1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/libc.so.6
#2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
#3  0x00007f31c470a7c6 in ppoll () at /lib64/libc.so.6
#4  0x00007f31c6916890 in g_main_context_iterate_unlocked.isra () at /lib64/libglib-2.0.so.0
#5  0x00007f31c6916a4f in g_main_loop_run () at /lib64/libglib-2.0.so.0
#6  0x00005593dd0d1ab0 in iothread_run (opaque=0x559405a567a0) at ../../home/thuth/devel/qemu/iothread.c:70
#7  0x00005593dd2b3311 in qemu_thread_start (args=0x559405a571a0) at ../../home/thuth/devel/qemu/util/qemu-thread-posix.c:393
#8  0x00007f31c4693f54 in start_thread () at /lib64/libc.so.6
#9  0x00007f31c471732c in __clone3 () at /lib64/libc.so.6

Thread 2 (Thread 0x7f3137fff6c0 (LWP 89225) "qemu-system-alp"):
#0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
#1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/libc.so.6
#2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
#3  0x00007f31c470b2be in write () at /lib64/libc.so.6
#4  0x00005593dd2af441 in event_notifier_set (e=0x559405a56a54) at ../../home/thuth/devel/qemu/util/event_notifier-posix.c:117
#5  0x00005593dd2cdcde in aio_notify (ctx=0x559405a56980) at ../../home/thuth/devel/qemu/util/async.c:506
#6  0x00005593dd2cdd2a in aio_timerlist_notify (opaque=0x559405a56980, type=QEMU_CLOCK_VIRTUAL) at ../../home/thuth/devel/qemu/util/async.c:524
#7  0x00005593dd2d4014 in timerlist_notify (timer_list=0x559405a56d50) at ../../home/thuth/devel/qemu/util/qemu-timer.c:293
#8  0x00005593dd2d3aaf in qemu_clock_notify (type=QEMU_CLOCK_VIRTUAL) at ../../home/thuth/devel/qemu/util/qemu-timer.c:147
#9  0x00005593dcf92c2c in icount_notify_aio_contexts () at ../../home/thuth/devel/qemu/accel/tcg/tcg-accel-ops-icount.c:72
#10 0x00005593dcf92c92 in icount_handle_deadline () at ../../home/thuth/devel/qemu/accel/tcg/tcg-accel-ops-icount.c:88
#11 0x00005593dcf93c45 in rr_cpu_thread_fn (arg=0x559405ce47d0) at ../../home/thuth/devel/qemu/accel/tcg/tcg-accel-ops-rr.c:251
#12 0x00005593dd2b3311 in qemu_thread_start (args=0x559405ce4720) at ../../home/thuth/devel/qemu/util/qemu-thread-posix.c:393
#13 0x00007f31c4693f54 in start_thread () at /lib64/libc.so.6
#14 0x00007f31c471732c in __clone3 () at /lib64/libc.so.6

Thread 1 (Thread 0x7f31bd82bb00 (LWP 89222) "qemu-system-alp"):
#0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
#1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/libc.so.6
#2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
#3  0x00007f31c470a7c6 in ppoll () at /lib64/libc.so.6
#4  0x00005593dd2d418e in qemu_poll_ns (fds=0x5594064aad30, nfds=5, timeout=993592000) at ../../home/thuth/devel/qemu/util/qemu-timer.c:342
#5  0x00005593dd2cf1bd in os_host_main_loop_wait (timeout=993592000) at ../../home/thuth/devel/qemu/util/main-loop.c:308
#6  0x00005593dd2cf30f in main_loop_wait (nonblocking=0) at ../../home/thuth/devel/qemu/util/main-loop.c:592
#7  0x00005593dce7edf6 in qemu_main_loop () at ../../home/thuth/devel/qemu/system/runstate.c:903
#8  0x00005593dd1e212e in qemu_default_main (opaque=0x0) at ../../home/thuth/devel/qemu/system/main.c:50
#9  0x00005593dd1e21e8 in main (argc=25, argv=0x7ffdad60bf18) at ../../home/thuth/devel/qemu/system/main.c:93


  HTH,
   Thomas


