Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA345CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYIjH-00006o-GF; Sat, 13 Jun 2026 03:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wYIj4-0008UY-Ij; Sat, 13 Jun 2026 03:24:19 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wYIj1-0006i8-Qq; Sat, 13 Jun 2026 03:24:18 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 109AB29A65;
 Sat, 13 Jun 2026 09:24:09 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id bijlK1b2jbgF; Sat, 13 Jun 2026 09:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1781335447;
 bh=4IjxmISfYgqUEoK/IPgwPCIlc8kcM31o8AKSJu1pes4=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=IK7peSoDj7An79ozjng+9Aklwt9A1QZy73Wuzsxhtcvl41dmkrvKg5RDU6jK0BAF3
 2xT0kg1forbU2qCKZkUjXolyQ0H30ecOSHKTygummFIWdLXY7Qz1Fyhq8mO4G01upw
 ZvR17otlaClw49Ecr1Jez3J3BvCTc9nJPjCDsw4UBHUsunQPy8etNKUDGUeC2mF1Gs
 Fh+2+r5XZeFIzG0k/ts4mTtFb/Bw/QxkkVPp7/VHbCI9bUfj8r9BBUZqCz3/kqlAqP
 Q6xyJxkOcrMR9b6uLPri0ioVRZq3Em0IvD5YCYu0wKlJCM0XnWgju5Tg8eii73rbGZ
 sxjijxNiiOpww==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id BABB829AE8;
 Sat, 13 Jun 2026 09:24:06 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Andrey VOLKOV <andrey@volkov.fr>,
 =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>
Subject: Re: [PATCH v4 5/7] hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
Date: Sat, 13 Jun 2026 09:24:06 +0200
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 qemu-arm@nongnu.org, "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1779986496.git.matyas.bobek@gmail.com>
 <9b0a0ffeeeff5ca0ec9525659bb2296850a88c62.1779986496.git.matyas.bobek@gmail.com>
 <dca6513c-5494-4eee-a0bb-bce64ffa3934@volkov.fr>
In-Reply-To: <dca6513c-5494-4eee-a0bb-bce64ffa3934@volkov.fr>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202606130924.06288.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.97, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Dear Andrey and others,

thanks for license resolution and feedback to the updated
v4 series. As for the suggestions, I suggest to postpone
at least some of them after mainlining which is again
delayed. The opinion why to postpone some of changes
based on the suggestions described inline

On Friday 29 of May 2026 13:35:39 Andrey VOLKOV wrote:
> Some small remarks regarding the use of hard-coded constants such as
> FSL_IMX6_NUM_WDTS in loops, IMHO, it would be better to use
>
> |ARRAY_SIZE()|instead:
>
> -    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
> +    for (i = 0; i < ARRAY_SIZE(s->can); i++) {

I think that it is worse to change one/newly introduced peripheral
declaration to new style which makes it inconsistent with the rest
of peripherals than keep the style of other peripherals

https://gitlab.com/qemu-project/qemu/-/blob/master/include/hw/arm/fsl-imx6.h#L44

https://gitlab.com/qemu-project/qemu/-/blob/master/hw/arm/fsl-imx6.c#L60

    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
        snprintf(name, NAME_SIZE, "usb%d", i);
        object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
    }

    for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
        snprintf(name, NAME_SIZE, "spi%d", i + 1);
        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
    }
    for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
        snprintf(name, NAME_SIZE, "wdt%d", i);
        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
    }

I understand the generic idea of higher safety  of the ARRAY_SIZE
to prevent mishmash, but in this specific case, I think that
if the change should be done then on all peripherals setup
at least in whole fsl-imx6.c.

> BTW, it would be also more logical to combine |CanBusState|and
>
> |FlexcanState|into a single structure (possibly anonymous), for
>
> example:struct FslIMX6State { ...
>
>   struct {
>      CanBusState       *state;
>      FlexcanState       flexcan;
>   } can[FSL_IMX6_NUM_CANS];
>
> ...
> };

This is probably for more thinking and considerations. The property

hw/arm/fsl-imx6.c:

static const TypeInfo fsl_imx6_type_info = {
    .name = TYPE_FSL_IMX6,
    .parent = TYPE_DEVICE,
...

hw/arm/sabrelite.c:

static const TypeInfo sabrelite_machine_init_typeinfo = {
    .name          = TYPE_SABRELITE_MACHINE,
    .parent        = TYPE_MACHINE,
 ...

The property and possibility to set "canbus0" and "canbus1" have
to be accessible when machine is selected and setup. The fsl_imx6
SoC is not directly parent of sabrelite_machine but only one of
its components so the properties are not directly inherited.
This means that if the properties are not defined on the level
of sabrelite_machine, current code

   object_property_add_link(obj, "canbus0",

then there have to be added aliases or some other mechanism
to propagate/make visible the required mapping to CAN bus objects
(their names) from machine to the SoC.

> As a matter of personal preference, I would also rename "|can"|to 
> "|flexcan"/"fcan"|, since these objects represent FlexCAN controllers
> rather than CAN2.0 ones.

Matyas Bobek has already updated his patch series

https://gitlab.fel.cvut.cz/bobekmat/qemu-flexcan/-/commits/flexcan-series-v6.1

to reflect some of yours suggestions including more specific naming
even that it seems that for most peripherals the SoC style
is to keep names as simple as "eth" which could be questioned
for possible hidding of some other mame 

 struct FslIMX6State {
     ...
     ChipideaState      usb[FSL_IMX6_NUM_USBS];
     IMXFECState        eth;
+    FlexcanState       flexcan[FSL_IMX6_NUM_CANS];
     DesignwarePCIEHost pcie;
     OrIRQState         pcie4_msi_irq;
     MemoryRegion       rom;

So I agree that there are more thing which could be discussed,
changed in direction to implement CAN FD capable FlexCAN
variant, etc., but I think that we should get to the
point where this iMX6 version functional with Linux kernel
is included in the mainline as the level change.

Best wishes,  

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

