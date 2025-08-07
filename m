Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B46EC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 10:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujxcm-0000th-El; Thu, 07 Aug 2025 06:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujxcj-0000a8-5y
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:13:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujxcf-0007vX-Tc
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:13:24 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 577AD710036742
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 7 Aug 2025 19:13:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VkuZ0tzb4mKRc+5VnFqU/I5ErGuIcEXpVpBx69Sz2r8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754561587; v=1;
 b=hGcBN9xGhVkQzDhr9wT93LwgAMTkdLYkEQruVOzL4sSXq7m7A24v6YT/0IR1M0Az
 /hHXqdAYNpmZwbpVhmsHn0V/zIkYd1jRmXMI3G6qHMcUsgupziJrvJGeZG5u9alj
 a+nxMgkz+xMPsfilrJJciBtKO1TCVL+JRrI7pUOz8MQ0I1XpqiaX7lWr398P3Zuc
 OoOG7xTsqrS3ufK2mMtqaxPwhm2ki+7xOnNpa2gfN87hOvVegu2NGwDbHhQBk8nf
 NLCCdoZ/IPhO4krOqY+48TKq08yGI6qSyWDR1vciTOoFWyvUI9y/iJ4amyeIimNw
 uSpHOSKzamB0CW9X8EcyCw==
Message-ID: <e7a32cb5-9d60-4dd3-b8af-4dd734de2f03@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 7 Aug 2025 19:13:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250806152940.362418-1-lvivier@redhat.com>
 <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
 <36d5da25-8cae-40e0-bea4-47c6020b4f92@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <36d5da25-8cae-40e0-bea4-47c6020b4f92@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1 autolearn=no autolearn_force=no
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

On 2025/08/07 17:36, Laurent Vivier wrote:
> On 06/08/2025 19:44, Akihiko Odaki wrote:
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
>> secure-coding- practices.rst
>>
>> However, I don't see statements in the datasheet that says mode switch 
>> will clear stale interrupts.
> 
> The datasheet doesn't say "stale interrupts are cleared." but it 
> describes two fundamentally separate and mutually exclusive hardware 
> paths for generating interrupts:
> 
> Intel® 82574 GbE Controller Family Datasheet
> https://docs.rs-online.com/96e8/0900766b81384733.pdf

It is an old revision (2.5). More recent revision (3.4) can be found at:
https://courses.cs.washington.edu/courses/cse451/18au/readings/e1000e.pdf

> 
> See 7.4.1 Legacy and MSI Interrupt Modes
> 
> Legacy/MSI Path: An event (like a packet transmission completing) sets a 
> cause bit in the ICR (Interrupt Cause Register). The legacy delay timers 
> (TIDV/RDTR) can delay the propagation of this cause. When the timer 
> expires, if the corresponding bit in the IMS (Interrupt Mask Set) is 
> enabled, the hardware asserts the INTx pin to signal the CPU.

Both revisions 2.5 and 3.4 have the following statements, different from 
what you quoted:

 > In legacy and MSI modes, an interrupt cause is reflected by setting
 > one of the bits in the ICR register, where each bit reflects one or
 > more causes. This description of ICR register provides the mapping of
 > interrupt causes (for example, a specific Rx queue event or a LSC
 > event) to bits in the ICR.
 >
 > Mapping of causes relating to the Tx and Rx queues as well as
 > non-queue causes in this mode is not configurable. Each possible queue
 > interrupt cause (such as, each Rx queue, Tx queue or any other
 > interrupt source) has an entry in the ICR.
 >
 > The following configuration and parameters are involved:
 > • The ICR[31:0] bits are allocated to specific interrupt causes

Please ensure that you refer a correct datasheet and share it for me.

> 
> See 7.4.2 MSI-X Mode
> 
> MSI-X Path: An event on a specific queue (e.g., Rx Queue 1) is mapped 
> via the IVAR (Interrupt Vector Allocation Register) to a specific MSI-X 
> vector. The ITR (Interrupt Throttle Rate) register for that vector then 
> determines if an interrupt should be generated. If allowed, the hardware 
> performs a memory write to the address specified in the PCI MSI-X table, 
> delivering the message to a specific CPU core.
> 
> Only non-queue causes are reflected in ICR (so not TIDV/RDTR).
> 
> The key here is that a TIDV timer expiring is only connected to the 
> legacy ICR->IMS->INTx path. There is no described hardware path for a 
> TIDV timer expiration to trigger an MSI-X memory write.
> 
> Therefore, if a guest enables MSI-X, it reconfigures its interrupt 
> controller (APIC) to listen for MSI-X messages, not legacy INTx pin 
> assertions. So, even if the stale TIDV timer fires on the hardware, the 
> interrupt it generates has no configured path to be received by the 
> guest OS. From the guest's perspective, the interrupt is lost. Our 
> emulation should model this by ignoring/clearing the stale event, which 
> is precisely what the patch does.
> 
>>
>> The expression "TIDV/RDTR are not used for moderation in MSI-X mode" 
>> is also unclear. Behaving drivers may indeed use ITR for that purpose, 
>> but the question for us is: what will e1000e do when the guest tries 
>> to use TIDV/RDTR in MSI-X mode anyway? That defines the behavior we 
>> need to implement.
> 
> The TIDV and RDTR registers are part of the device's memory-mapped I/O 
> space. The hardware will almost certainly allow a write to these 
> registers at any time.
> 
> However, based on the separate hardware paths described above, the write 
> would be ineffective. A driver could set the TIDV timer, and the timer 
> would likely count down, but its expiration event is only wired to the 
> legacy interrupt generation logic. Since the device is configured for 
> MSI-X interrupt delivery, that path is dormant. The write is accepted, 
> but the action is inert.
> 
>>
>> If the datasheet describes the expected behavior with delayed 
>> interrupts in MSI-X, a reference to the datasheet should be made at 
>> least in the patch message. Otherwise, perhaps this "if 
>> (msix_enabled(core->owner))" is just extraneous and should be removed.
> 
> The "if (msix_enabled(core->owner))" check is not extraneous and must be 
> kept. It correctly separates the emulation logic for these two mutually 
> exclusive hardware modes. Removing it would incorrectly allow a legacy 
> delayed interrupt to be processed as if it were valid in MSI-X mode, 
> which is not how the hardware works.
> 
> Moreover it can introduce unexpected behavior in the guest as this case 
> could not be managed.

Revision 3.4's 4.6.1 Interrupts During Initialization says:
 > Most drivers disable interrupts during initialization to prevent
 > re-entrancy. Interrupts are disabled by writing to the IMC register.
 > Note that the interrupts need to be disabled also after issuing a
 > global reset, so a typical driver initialization flow is:
 >
 > 1. Disable interrupts
 > 2. Issue a global reset
 > 3. Disable interrupts (again)
 > 4. …
 >
 > After the initialization completes, a typical driver enables the
 > desired interrupts by
 > writing to the IMS register.

Drivers can ensure that old interrupts will not fire by following this 
procedure. The behavior when not following this is undefined (in the 
datasheet I'm referring to).

Regards,
Akihiko Odaki

