Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F7BC83F12
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjeLg-0007QM-LC; Thu, 29 Aug 2024 08:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=t/gt=P4=kaod.org=clg@ozlabs.org>)
 id 1sjeLe-0007PL-OW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:33:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=t/gt=P4=kaod.org=clg@ozlabs.org>)
 id 1sjeLY-0001Iw-2J
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:33:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wvggb4tB1z4x2J;
 Thu, 29 Aug 2024 22:33:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WvggZ1HH4z4wj2;
 Thu, 29 Aug 2024 22:33:45 +1000 (AEST)
Message-ID: <a0665964-ba34-4144-82fd-184f864d844c@kaod.org>
Date: Thu, 29 Aug 2024 14:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com
References: <20240715084639.983127-1-chigot@adacore.com>
 <42fe0e65-e1c1-47be-9ba1-9a43e4a05192@kaod.org>
 <CAJ307Eg_w1K63Q7YmsAw6mSnwgPrC9R2UOvi+fUDjam4n0mvDg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAJ307Eg_w1K63Q7YmsAw6mSnwgPrC9R2UOvi+fUDjam4n0mvDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=t/gt=P4=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 8/28/24 09:21, Clément Chigot wrote:
> On Tue, Aug 27, 2024 at 7:40 PM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Hello Clément,
>>
>> On 7/15/24 10:46, Clément Chigot wrote:
>>> The BookE decrementer stops at 0, meaning that it won't decremented
>>> towards "negative" values.
>>> However, the current logic is inverted: decr is updated solely when
>>> the resulting value would be negative.
>>
>> How did you hit the issue ? which machine ? I didn't see any error
>> when booting Linux 6.6.3 on mpc8544ds, e500mc, e5500 and e6500.
> 
> I hit this issue while running some version of VxWorks on a custom
> machine: p3041ds (description [1] and our local implementation [2]).
> So, I'm not that surprised you were not able to reproduce.
> 
>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>> Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
>>
>> LGTM,
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> We have some automated tests with the ppce500 machine which it would be
>> interesting  to extend to have a better coverage of booke.
> 
> Thanks for the pointer, I'll see if I can extend them.
> 
>> Thanks,
>>
>> C.
>>
> 
> [1] https://www.nxp.com/design/design-center/software/qoriq-developer-resources/p3041-qoriq-development-system:P3041DS
> [2] https://github.com/AdaCore/qemu/blob/qemu-stable-9.0.0/hw/ppc/p3041ds.c

Nice. Do you have any plans to upstream the machine ?

Thanks,

C.


