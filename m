Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5054FC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 17:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZwmY-00055T-7h; Tue, 13 Feb 2024 12:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rZwmU-00053s-Dm; Tue, 13 Feb 2024 12:41:18 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rZwmS-0001DR-66; Tue, 13 Feb 2024 12:41:18 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 00E7D4E6006;
 Tue, 13 Feb 2024 18:41:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 1Y1MR_NILkDo; Tue, 13 Feb 2024 18:41:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0D1924E6004; Tue, 13 Feb 2024 18:41:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A0F87456B4;
 Tue, 13 Feb 2024 18:41:08 +0100 (CET)
Date: Tue, 13 Feb 2024 18:41:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@linux.intel.com>, 
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, 
 qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v4 04/12] hw/i386/q35: Realize LPC PCI function before
 accessing it
In-Reply-To: <20240213130341.1793-5-philmd@linaro.org>
Message-ID: <f6fbfb33-ddca-a3f4-eeb2-727c1c6f0e6a@eik.bme.hu>
References: <20240213130341.1793-1-philmd@linaro.org>
 <20240213130341.1793-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1004743390-1707846068=:79075"
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

--3866299591-1004743390-1707846068=:79075
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 Feb 2024, Philippe Mathieu-Daudé wrote:
> We should not wire IRQs on unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/i386/pc_q35.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 7ca3f465e0..b7c69d55d6 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -248,13 +248,13 @@ static void pc_q35_init(MachineState *machine)
>     /* create ISA bus */
>     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
>                                 TYPE_ICH9_LPC_DEVICE);
> -    qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
> -                      x86_machine_is_smm_enabled(x86ms));
>     lpc_dev = DEVICE(lpc);
> +    qdev_prop_set_bit(lpc_dev, "smm-enabled",
> +                      x86_machine_is_smm_enabled(x86ms));
> +    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
>         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
>     }
> -    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>
>     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
>
>
--3866299591-1004743390-1707846068=:79075--

