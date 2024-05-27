Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A9DC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUv7-0003kS-0L; Mon, 27 May 2024 03:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBUui-0003WN-Oo; Mon, 27 May 2024 03:37:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBUuV-0000I2-C0; Mon, 27 May 2024 03:37:00 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VnnXB0V9Zz4x0y;
 Mon, 27 May 2024 17:36:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VnnX71vDBz4x0K;
 Mon, 27 May 2024 17:36:38 +1000 (AEST)
Message-ID: <6ef44e57-14b4-4498-b51b-7c486582c5ca@kaod.org>
Date: Mon, 27 May 2024 09:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] ppc/pnv: Better big-core model, lpar-per-core, 
 PC unit
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20240526122612.473476-1-npiggin@gmail.com>
 <66c95ef6-8f94-4661-bc4c-8f5f7abcce1f@kaod.org>
 <D1K935B9TYYV.3GMTXCVHSWP0G@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <D1K935B9TYYV.3GMTXCVHSWP0G@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=e5bn=M6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/27/24 09:32, Nicholas Piggin wrote:
> On Mon May 27, 2024 at 4:25 PM AEST, Cédric Le Goater wrote:
>> On 5/26/24 14:26, Nicholas Piggin wrote:
>>> Primary motivation for this series is to improve big-core support.
>>> Other things like SPR indirect, timebase state, PC xscom, are required
>>> for minimal big core support.
>>>
>>> I'm still not 100% happy with the big-core topology model after this.
>>> Maybe one day we add pnv big core and pnv small core structures. But
>>
>> I haven't look at the proposal yet, but indeed, we could introduce
>> a new TYPE_PNV_CORE type for big cores only.
> 
> Yeah. It's still tricky because big-core structure contains the CPUs
> if you are running in small core mode. So it would really have to be
> a PnvCPUCore and PnvPervasiveCore or something, where the former is
> either SMT4 and 1:1 with the latter or SMT8 and 1:2 depending on mode.
> 
> And some of the "CPU" type operations in big core mode still need to
> operate on the small core.
> 
> For now, the accessors and helpers seem to be not too bad.
> 
>>> nothing is completely clean because big core mode still has certain
>>> small core restrictions. I think for now we take a bit of mostly
>>> abstracted ugliness in TCG code for the benefit of not spreading
>>> hacks through pervasive (xscom) core addressing.
>>>
>>> After this series, power9 and power10 get through skiboot/Linux boot
>> s
>>
>> Have you tried SMT8 on powernv8 ? I remember seeing a hang if I am correct.
>> I don't think POWER8 deserves much attention anymore, we could deprecate
>> POWER8E and POWER8NVL. However, we should at least report an error if we
>> know a setup is broken.
> 
> Yeah it does have some problem. Maybe should just disable SMT unless
> someone finds time to work it out.


The new _init routines would be a good place to do that.

Thanks,

C.


> 
> Thanks,
> Nick


