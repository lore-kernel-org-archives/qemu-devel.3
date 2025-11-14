Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD86CCD8CBF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 01:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJiMs-0005vH-Lp; Thu, 13 Nov 2025 20:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJiMp-0005ua-9D
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:12:47 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJiMk-0002kN-N4
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:12:45 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AE1CT3M031476
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 14 Nov 2025 10:12:29 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=B5duLP+jnqT9i+qTUWD2CdgU1XqR6RRVfAv64fbQvvo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763082749; v=1;
 b=hPGM9PdD3ypeaTgCuvqrlNsZa0tYBMHXz4xwRzSMu9X6P5B7q2SZ18UVQvjMQrAH
 nEGRj/32TQRRt7QXHEwjutqT4F6j7oD7HBAjh65N47D60k8lbquz69Pvc0zj8aJz
 dJgZjVP7aLmZXXMBp1NJj4GLZG2gPxIVysB/+BEpCOjdscemW5SwF0CR7Y76THS4
 yUGIBYXk7nwyo8cMbep2ndZPFvqvKbtoY67vsUY8Fu3fRcExZi30CbcUUh34+Uli
 zCLh5b8cWgT4OXAjyQoi0ekKYOAyFOqrNwMoE9aYBf19gd1ZV+W/ctkKnCoKEl/I
 4PyqwxhGXJDwoakujgpk2Q==
Message-ID: <97e08e70-3842-433f-b427-ccc20bef29cc@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 14 Nov 2025 10:12:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <1b318ad8-48b3-4968-86ca-c62aef3b3bd4@rsg.ci.i.u-tokyo.ac.jp>
 <7c49d808-ccb8-4262-ae6c-2ac746b43b80@rsg.ci.i.u-tokyo.ac.jp>
 <aRYVw1ydTbZr0OEH@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aRYVw1ydTbZr0OEH@x1.local>
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

On 2025/11/14 2:30, Peter Xu wrote:
> Hi, Akihiko,
> 
> I found that you replied to me and forgot to cc all, I added all of the
> people back.
> 
> On Sun, Nov 09, 2025 at 06:05:00PM +0900, Akihiko Odaki wrote:
>> On 2025/11/08 10:45, Akihiko Odaki wrote:
>>> On 2025/11/07 6:52, Peter Xu wrote:
>>>> When I was having a closer look, I found some other issues, I'll list it
>>>> all here.
>>>>
>>>> 1. I found that rcu_gp_event was initialized as "true".  I'm not sure
>>>>      whether it should be false.  This has nothing to do with your
>>>> series as
>>>>      well, only some observation of mine.
>>>>       qemu_event_init(&rcu_gp_event, true);
>>>
>>> Indeed it makes more sense to initialize it with false.
>>>
>>> rcu_read_unlock() sets the event only in grace periods, and
>>> wait_for_readers() always reset it when ending those grace periods. By
>>> initializing it with false, the event will be false whenever outside
>>> grace periods, improving consistency.
> 
> Thanks for confirming this. AFAIU this isn't a huge deal, as
> wait_for_readers() should be tolerant of false positives.  So I'll leave it
> to you on whether to touch it together.

It's just one-line change so I'll include it in the next version of this 
series.

> 
>>>
>>>>
>>>> 2. It looks to me your patch here checked the wrong retval of
>>>>      qemu_event_timedwait()..
>>>>
>>>>           } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
>>>>                      !sleeps || qemu_event_timedwait(&sync_event, 10)) {
>>>>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>>      should it be "!qemu_event_timedwait(&sync_event, 10)"?  Side
>>>> note: maybe
>>>>      we should cleanup all _timedwait() for QEMU's eventfd, sem, cond,
>>>>      ... because they don't return the same retval.. but if you think
>>>> sem is
>>>>      good, then we don't need eventfd's timedwait() in this series (your
>>>>      initial two patches).
>>>
>>> You are right here too. This is a stupid mistake.
>>
>> No, the original patch is right. qemu_event_timedwait(&sync_event, 10)
>> returning true means that the forced variable was set before timing out,
>> hence the we need to enter the force quiescent state.
> 
> You're correct.  I got misleaded by the comment here:
> 
>              /*
>               * Now one of the following heuristical conditions is satisfied:
>               * - A decent number of callbacks piled up.
>               * - It timed out.                <--------------------
>               * - force_rcu() was called.
>               *
>               * Force a quiescent state.
>               */
> 
> I'm guessing you got misleaded too when I raised the question and when you
> were looking.  Maybe it means it would be good to change that line of
> comment into:
> 
>               * - It timed out continuously 5 times (causing sleeps==0)

Mentioning the sleeps variable makes sense.

> 
>>
>>>
>>>>
>>>> 3. I doubt if malloc_trim() feature is broken with your current patchset,
>>>>      because now the loop looks like:
>>>>
>>>>           for (;;) {
>>>>               qemu_event_reset(&sync_event);
>>>>               n = qatomic_read(&rcu_call_count);
>>>>               if (n) {
>>>>                   break;
>>>>               }
>>>> #if defined(CONFIG_MALLOC_TRIM)
>>>>               malloc_trim(4 * 1024 * 1024);
>>>> #endif
>>>>               qemu_event_wait(&sync_event);
>>>>           }
>>>>
>>>>     I don't know if n can be zero here at all.. if you use the sem change
>>>>     this might trigger but it's not designed for it.  When using sem
>>>> we may
>>>>     want to periodically trim.  But I'd like to know how you think in
>>>> general
>>>>     on the sem idea first (e.g. do we need to be prepared for high
>>>> freq rcu
>>>>     frees).
>>>
>>> malloc_trim() is triggered when the RCU thread is idle, and that is not
>>> changed with this patch.
> 
> You're right, I read it wrong.  Please ignore this comment.
> 
> Thanks,
> 


