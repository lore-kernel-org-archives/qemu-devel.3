Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D49CA101F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Sep 2025 20:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvLth-0000s1-LA; Sun, 07 Sep 2025 16:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uvLta-0000r5-Fi
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 16:21:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uvLtI-00072p-J2
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 16:21:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9345C56F2A2;
 Sun, 07 Sep 2025 22:21:07 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id YVgaXl2ElUY3; Sun,  7 Sep 2025 22:21:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 48DC656F319; Sun, 07 Sep 2025 22:21:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4673D56F306;
 Sun, 07 Sep 2025 22:21:05 +0200 (CEST)
Date: Sun, 7 Sep 2025 22:21:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Julian Ganz <neither@nut.email>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
Message-ID: <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
 <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 5 Sep 2025, Julian Ganz wrote:
> September 5, 2025 at 9:25 PM, "BALATON Zoltan" wrote:
>> On Fri, 5 Sep 2025, Julian Ganz wrote:
>>> September 5, 2025 at 1:38 PM, "BALATON Zoltan" wrote:
>>>> Have you done any testing on how much overhead this adds
>>>>  to interrupt heavy guest workloads? At least for PPC these are already
>>>>  much slower than real CPU so I'd like it to get faster not slower.
>>>>
>>>  No, I have not made any performance measurements. However, given that
>>>  for every single TB execution a similar hook is called already, the
>>>  impact related to other existing plugin infrastructure _should_ be
>>>  neglectible.
>>>
>>>  That is, if your workload actually runs any code and is not constantly
>>>  bombarded with interrupts that _do_ result in a trap (which _may_ happen
>>>  during some tests).
>>>
>>>  So if you are performance sensitive enough to care, you will very likely
>>>  want to disable plugins anyway.
>>>
>> I can disable plugins and do that normally but that does not help those who get QEMU from their distro (i.e. most users). If this infrastructure was disabled in default builds and needed an explicit option to enable then those who need it could enable it and not imposed it on everyone else who just get a default build from a distro and never use plugins. Having an option which needs rebuild is like not having the option for most people. I guess the question is which is the larger group? Those who just run guests or those who use this instrumentation with plugins.
>
> Hard to say.
>
>> The default may better be what the larger group needs. Even then distros may still change the default so it would be best if the overhead can be minimised even if enabled. I think the log infrastructure does that, would a similar solution work here?
>>
>> For testing I've found that because embedded PPC CPUs have a software controlled MMU (and in addition to that QEMU may flush TLB entries too often) running something that does a lot of memory access like runnung the STREAM benchmark on sam460ex is hit by this IIRC but anything else causing a lot of interrupts like reading from emulated disk or sound is probably affected as well. I've tried to optimise PPC exception handling a bit before but whenever I optimise something it is later undone by other changes not caring about performance.
>
> I could try running the benchmark on multiple versions:
>
> * qemu with plugins disabled,
> * with plugins enabled but without these patches and
> * with plugins enabled and with these patches.
>
> However, I'll likely only report back with results next week, though.
> Do you happen to have an image you can point me to? Either something
> that has the benchmark already or some unixoid running on the platform?
> I'm currently not motivated enough to cook up some bare-metal testbed
> for a platform I'm not familiar with.

I don't have ready images to test embedded PPC MMU exceptions which I 
think this may affect most. I had an image for pegasos2 for a general test 
used here:
https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html
but that machine has a G4 CPU which has hardware MMU so is likely not 
affected.

I have uploaded some PPC binaries for the STREAM benchmark that I tested 
with before here:
http://zero.eik.bme.hu/~balaton/qemu/stream-test.zip
which may excercise this if run on sam460ex or ppce500 machines but I 
don't have a scripted test case for that. There is some docs on how to run 
Linux on these machines here:
https://www.qemu.org/docs/master/system/target-ppc.html

Alternatively maybe running a disk IO benchmark on an emulated IDE 
controller using PIO mode or some other device that generates a lots of 
interrupts may test this. I think you can use the "info irq" command in 
QEMU Monitor to check how many interrupts you get.

Regards,
BALATON Zoltan

