Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3965D1049509
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gFs-0002tf-NK; Thu, 12 Mar 2026 09:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0gFr-0002tR-4P
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:39:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w0gFo-0000o5-IA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:39:10 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 09642596D8B;
 Thu, 12 Mar 2026 14:39:06 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id sCMaUKSCRBBK; Thu, 12 Mar 2026 14:39:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8655F5969EB; Thu, 12 Mar 2026 14:39:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8476D5969EA;
 Thu, 12 Mar 2026 14:39:03 +0100 (CET)
Date: Thu, 12 Mar 2026 14:39:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: alistair23@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com, 
 pbonzini@redhat.com, berrange@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/7] hw/arm: xlnx-zynqmp: Don't call qdev_get_machine in
 soc init
In-Reply-To: <CAFEAcA8PjHZN0kxKqp=8y2xG3wefmh2JioV06p0Hgw9dkg3_Ug@mail.gmail.com>
Message-ID: <a7a425d4-f01a-d25f-31df-38af8f4802d7@eik.bme.hu>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
 <20260312043158.4191378-4-alistair.francis@wdc.com>
 <CAFEAcA8PjHZN0kxKqp=8y2xG3wefmh2JioV06p0Hgw9dkg3_Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 12 Mar 2026, Peter Maydell wrote:
> On Thu, 12 Mar 2026 at 04:32, <alistair23@gmail.com> wrote:
>>
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> Calling qdev_get_machine() in the soc_init function would result in
>> the following assert
>>
>>     ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
>>
>> when trying to run
>>
>>     ./qemu-system-aarch64 -S -display none -M virt -device xlnx-zynqmp,help
>>
>> as the machine wasn't created yet. We call qdev_get_machine() to obtain
>> the number of CPUs in the machine. So instead of initialising the CPUs in
>> the SoC init let's instead do it in the realise where the machine
>> will exist.
>
> Here I'm not sure I agree. We should init child objects in init, not in
> realize, unless there's a strong reason we need to not do that.
> Working around "we crash if the user does something pointless
> on the command line" isn't a strong enough reason IMHO.
>
> The problem here, though, is of the kind "what child objects we
> need depends on the configuration of this device", which kind of
> pushes "init children" into "realize". We do that in some places
> already. But I don't like that -- it makes us inconsistent about
> how we handle child init. If we're OK doing some child init in
> the parent's realize method, why not do all child init in realize?

How about saying that we do most things in realize (so simple devices 
don't even need an init method) and do in init those that need to be done 
before realize such as things exposing properties that can be set before 
realize. I think that's better than always splitting init and realize for 
all children that's most of the time would just add complexity without 
reason.

This is similar to what I asked about in
https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03945.html

Regards,
BALATON Zoltan

