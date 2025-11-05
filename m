Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05507CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 06:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGX1J-0001ZF-RG; Wed, 05 Nov 2025 01:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGX1H-0001Z3-0b
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 01:29:23 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGX1C-0002CW-N4
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 01:29:22 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A56T5Ow091273
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 5 Nov 2025 15:29:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BONvDtzJvIV3ocKryUtFxyh7XlGBZCuCTB2ZNwX5PKM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762324145; v=1;
 b=YoCi6LAdZp/uSwM8z1w/sEbUSUAjRy+Kf0h+eNaEn8dX9OswxLMC6tvEDG2NDFTx
 LL6j7Nuv20ndP1UQV6R2PK2Feoid1SlAT55/0v2NSD6I42tvlzr1pYURmLS04LY9
 dPoJsYby4405FWAX+5+VkTnO6NQg9G0PFAXQcktGxXJmRHiVEk0WQIxmVhchAMPZ
 +1QZ+epMwBlf8FO0UqETp750My7DsrHDpqLchhHmavjRusgYxieVIzF91bK9EC1w
 ZHn5hkMUQ6f6EAQ9X76cfxMF133Z4MeHV6kYy82Al61ZSsivsu2nT4I1aYT2pcdu
 dIalJp9pj5l2UWBcvaTWkQ==
Message-ID: <889e6be6-0cef-4a23-9d57-2e0611f9588a@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 5 Nov 2025 15:29:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
 <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
 <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
 <d4921688-b3b3-45f2-a3c9-dee2977750cd@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d4921688-b3b3-45f2-a3c9-dee2977750cd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/04 21:18, Paolo Bonzini wrote:
> On 11/4/25 09:38, Thomas Huth wrote:
>> Thread 4 (Thread 0x7f31bd1ff6c0 (LWP 89223) "qemu-system-alp"):
>> #0  0x00007f31c47150cd in syscall () at /lib64/libc.so.6
>> #1  0x00005593dd2b578d in qemu_futex_wait (f=0x5593ddad9e50 
>> <rcu_call_ready_event>, val=4294967295) at /home/thuth/devel/qemu/ 
>> include/qemu/futex.h:47
>> #2  0x00005593dd2b59a1 in qemu_event_wait (ev=0x5593ddad9e50 
>> <rcu_call_ready_event>) at ../../home/thuth/devel/qemu/util/event.c:162
>> #3  0x00005593dd2c12e3 in call_rcu_thread (opaque=0x0) at ../../home/ 
>> thuth/devel/qemu/util/rcu.c:304
> 
> The RCU thread is simply waiting.
> 
>> Thread 3 (Thread 0x7f31bc8fd6c0 (LWP 89224) "qemu-system-alp"):
>> #0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
>> #1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/ 
>> libc.so.6
>> #2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
>> #3  0x00007f31c470a7c6 in ppoll () at /lib64/libc.so.6
>> #4  0x00007f31c6916890 in g_main_context_iterate_unlocked.isra () at / 
>> lib64/libglib-2.0.so.0
>> #5  0x00007f31c6916a4f in g_main_loop_run () at /lib64/libglib-2.0.so.0
>> #6  0x00005593dd0d1ab0 in iothread_run (opaque=0x559405a567a0) 
>> at ../../ home/thuth/devel/qemu/iothread.c:70
>> #7  0x00005593dd2b3311 in qemu_thread_start (args=0x559405a571a0) 
>> at ../../home/thuth/devel/qemu/util/qemu-thread-posix.c:393
>> #8  0x00007f31c4693f54 in start_thread () at /lib64/libc.so.6
>> #9  0x00007f31c471732c in __clone3 () at /lib64/libc.so.6
> 
> This iothread is doing nothing.
> 
>> Thread 2 (Thread 0x7f3137fff6c0 (LWP 89225) "qemu-system-alp"):
>> #0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
>> #1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/ 
>> libc.so.6
>> #2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
>> #3  0x00007f31c470b2be in write () at /lib64/libc.so.6
>> #4  0x00005593dd2af441 in event_notifier_set (e=0x559405a56a54) 
>> at ../../home/thuth/devel/qemu/util/event_notifier-posix.c:117
>> #5  0x00005593dd2cdcde in aio_notify (ctx=0x559405a56980) at ../../ 
>> home/ thuth/devel/qemu/util/async.c:506
> In this backtrace the CPU is waking up the main loop (thread 1), but the 
> main loop is running so I don't think it's really a deadlock.  It's more 
> likely that the replay is not matching the record, or there's a similar 
> reason why the replay is not proceeding.

I agree. It is more likely that debugging the replay code instead of the 
RCU change will lead to the real cause.

Regards,
Akihiko Odaki

