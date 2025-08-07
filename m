Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B324AC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 10:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujxhn-0003XO-Sq; Thu, 07 Aug 2025 06:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujxhl-0003QL-EJ
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:18:37 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujxhh-0000bk-K7
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:18:37 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 577AIO6t038431
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 7 Aug 2025 19:18:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Jn9Nvi/FDVG9NJdkbi216z8OIqhDRjphsXxpWAJr/+c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754561905; v=1;
 b=eHe0T6IUJ8hjqryCNki/fLC85ynhIgJwmkF21SWMeY5IQCItV0U/RO9LCyCm/5AK
 /71GFQnwZq9iUNfvHnUiCKa3bRdlOLzLjNIsxmYfjx0o4u1cpVrcxJucuMdHh27u
 iqEIqvhfERtSPqDMYNTSrUJPnQescSAtVUnSp8tVLJOTFQN0d0g4VEiTCWDDLHDt
 63WBCDHiQLxp+lmb+4M0qqOyLZDfv1MLBYLJApG+8VwZqYe/7BF65GdYmAojDz6o
 aHrqUs+RdYRISOgfMzjvFJySWI6vqNSTiwgb+8VTgm+RcihFvmzHqvSm7ChL3c2Q
 l54B8Yar4W1mcwsNsjzp+A==
Message-ID: <947b386b-b1b4-4f66-a9cf-b6972bd260c1@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 7 Aug 2025 19:18:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250806152940.362418-1-lvivier@redhat.com>
 <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
 <ea9dc9fa-21d0-4e32-881f-d0a8ac4378ff@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ea9dc9fa-21d0-4e32-881f-d0a8ac4378ff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/08/07 15:57, Thomas Huth wrote:
> On 06/08/2025 19.44, Akihiko Odaki wrote:
>> On 2025/08/07 0:29, Laurent Vivier wrote:
>>> A race condition between guest driver actions and QEMU timers can lead
>>> to an assertion failure when the guest switches the e1000e from legacy
>>> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
>>> RDTR) is active, but the guest enables MSI-X before the timer fires,
>>> the pending interrupt cause can trigger an assert in
>>> `e1000e_intmgr_collect_delayed_causes()`.
>>>
>>> The function's assertion (`assert(core->delayed_causes == 0)`)
>>> incorrectly assumes that it's impossible for a legacy delayed interrupt
>>> to be pending once the device is in MSI-X mode.
>>>
>>> This behavior is incorrect. On a physical device, a driver-initiated
>>> mode switch would mask interrupts, reconfigure the hardware, and clear
>>> any stale interrupt states. The legacy delay timers (TIDV/RDTR) are not
>>> used for moderation in MSI-X mode; the Interrupt Throttle Rate (ITR)
>>> mechanism is used instead. Therefore, any pending interrupt from the
>>> old mode should be ignored.
>>
>> It is true that triggering assertion is incorrect as per: docs/devel/ 
>> secure- coding-practices.rst
>>
>> However, I don't see statements in the datasheet that says mode switch 
>> will clear stale interrupts.
>>
>> The expression "TIDV/RDTR are not used for moderation in MSI-X mode" 
>> is also unclear. Behaving drivers may indeed use ITR for that purpose, 
>> but the question for us is: what will e1000e do when the guest tries 
>> to use TIDV/ RDTR in MSI-X mode anyway? That defines the behavior we 
>> need to implement.
> 
> If it's not clear what to do here, maybe we could use a 
> qemu_log_mask(LOG_UNIMP, ...) for now?

The behavior is undefined here as far as I understand. If so, 
LOG_GUEST_ERROR will fit better because it is not appropriate for guests 
to make an assumption on the behavior.

Regards,
Akihiko Odaki

