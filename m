Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3CC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9DG-00036T-CZ; Thu, 08 Feb 2024 13:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rY9DC-00033X-DJ; Thu, 08 Feb 2024 13:33:26 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rY9DA-0002Gc-GD; Thu, 08 Feb 2024 13:33:26 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB81B4E604B;
 Thu,  8 Feb 2024 19:33:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MzLNKbdOU6OX; Thu,  8 Feb 2024 19:33:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DC99C4E6049; Thu,  8 Feb 2024 19:33:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA1DC745708;
 Thu,  8 Feb 2024 19:33:18 +0100 (CET)
Date: Thu, 8 Feb 2024 19:33:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 06/11] hw/misc/macio: Realize IDE controller before
 accessing it
In-Reply-To: <20240208181245.96617-7-philmd@linaro.org>
Message-ID: <4f25c957-3019-2dcf-56ac-cf34a2fb6c53@eik.bme.hu>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1599874485-1707417198=:22368"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1599874485-1707417198=:22368
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 8 Feb 2024, Philippe Mathieu-Daudé wrote:
> We should not wire IRQs on unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/misc/macio/macio.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index c9f22f8515..db662a2065 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -122,15 +122,17 @@ static bool macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
>                               Error **errp)
> {
>     SysBusDevice *sbd = SYS_BUS_DEVICE(ide);
> +    bool success;
>
> -    sysbus_connect_irq(sbd, 0, irq0);
> -    sysbus_connect_irq(sbd, 1, irq1);
>     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
>     object_property_set_link(OBJECT(ide), "dbdma", OBJECT(&s->dbdma),
>                              &error_abort);
>     macio_ide_register_dma(ide);
> +    success = qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);

If realize is unsuccessful can you connect irqs if device may be 
unrealized? So maybe either the next two lines should be in an if block or 
drop the success flag and return false here if (!qdev_realize) and true at 
end of func?

Regards,
BALATON Zoltan

> +    sysbus_connect_irq(sbd, 0, irq0);
> +    sysbus_connect_irq(sbd, 1, irq1);
>
> -    return qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
> +    return success;
> }
>
> static void macio_oldworld_realize(PCIDevice *d, Error **errp)
>
--3866299591-1599874485-1707417198=:22368--

