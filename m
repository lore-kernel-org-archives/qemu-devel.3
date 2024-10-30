Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E65D7494F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 00:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5wS2-0004N9-2k; Tue, 29 Oct 2024 20:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5wRz-0004MS-38; Tue, 29 Oct 2024 20:20:39 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5wRt-0002Wc-To; Tue, 29 Oct 2024 20:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1730247626;
 bh=+zGw45BaNklRHh169TsoQQkMDZLsSYtPW9CeQFweIm4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=eAj4g6NlEZRnPbIHo96VJ0S6CA12i9SdkIUqwDZe8zBzAmxqILgIIwZ7RwnWvIyNC
 yTjXZAk4Wx1sJJbLby/4a9sbg/w3loM7h4PZiHbWv2CsUYSQrzzIxZard2ZKnMnebe
 nGCzsOTgVFyU68Rpwk8z/qBfs61woO67ySHrJB7tSDvFz5NtAsOCRabW5oorxjHre/
 fuV3DWnZm+LK15fbQfZMhB0Kl7v7gKv+OG9VL4lXoYOITZ9y2GjKO/TCwToBamBcLt
 AZm6xi+SH3V6C8iGTgZRMWRh8QI7KX8gp1gF5OqEYnn/GI0tBIWQbzF+tV/3qxaznP
 Td4lLS5UlSVgQ==
Received: from [192.168.68.112]
 (ppp118-210-190-243.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.190.243])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D569E67E6D;
 Wed, 30 Oct 2024 08:20:24 +0800 (AWST)
Message-ID: <c834ae3efff1cd5f51499b5852a49e5332b796a1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 7/8] hw/arm/aspeed: Invert sdhci write protected pin
 for AST2600 and AST2500 EVBs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>,  Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)"
 <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Wed, 30 Oct 2024 10:50:22 +1030
In-Reply-To: <20241029091729.3317512-8-jamin_lin@aspeedtech.com>
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-10-29 at 17:17 +0800, Jamin Lin wrote:
> The Write Protect pin of SDHCI model is default active low to match
> the SDHCI
> spec. So, write enable the bit 19 should be 1 and write protected the
> bit 19
> should be 0 at the Present State Register (0x24).
>=20
> According to the design of AST2500 and AST2600 EVBs, the Write
> Protected pin
> is active high by default. To support it, introduces a new
> sdhci_wp_invert
> property in ASPEED MACHINE state and set it true for AST2500 and
> AST2600 EVBs
> and set "wp_invert" property true of sdhci-generic model.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
> =C2=A0hw/arm/aspeed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8=
 ++++++++
> =C2=A0include/hw/arm/aspeed.h | 1 +
> =C2=A02 files changed, 9 insertions(+)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index b4b1ce9efb..0468602d95 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -403,6 +403,12 @@ static void aspeed_machine_init(MachineState
> *machine)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(get_system_memory()),
> &error_abort);
> =C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_link(OBJECT(bmc->soc), "dram=
",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(machine->ram), &error_abort);
> +=C2=A0=C2=A0=C2=A0 if (amc->sdhci_wp_invert) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < bmc->soc->s=
dhci.num_slots; i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 objec=
t_property_set_bool(OBJECT(&bmc->soc-
> >sdhci.slots[i]),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "wp-i=
nvert", true,
> &error_abort);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 if (machine->kernel_filename) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When booting wit=
h a -kernel command line there is no u-
> boot
> @@ -1308,6 +1314,7 @@ static void
> aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
> =C2=A0=C2=A0=C2=A0=C2=A0 amc->fmc_model =3D "mx25l25635e";
> =C2=A0=C2=A0=C2=A0=C2=A0 amc->spi_model =3D "mx25l25635f";
> =C2=A0=C2=A0=C2=A0=C2=A0 amc->num_cs=C2=A0=C2=A0=C2=A0 =3D 1;
> +=C2=A0=C2=A0=C2=A0 amc->sdhci_wp_invert =3D true;
> =C2=A0=C2=A0=C2=A0=C2=A0 amc->i2c_init=C2=A0 =3D ast2500_evb_i2c_init;
> =C2=A0=C2=A0=C2=A0=C2=A0 mc->default_ram_size=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 512 * MiB;
> =C2=A0=C2=A0=C2=A0=C2=A0 aspeed_machine_class_init_cpus_defaults(mc);
> @@ -1409,6 +1416,7 @@ static void
> aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
> =C2=A0=C2=A0=C2=A0=C2=A0 amc->num_cs=C2=A0=C2=A0=C2=A0 =3D 1;
> =C2=A0=C2=A0=C2=A0=C2=A0 amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_=
ON |
> ASPEED_MAC2_ON |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_MAC3_ON;
> +=C2=A0=C2=A0=C2=A0 amc->sdhci_wp_invert =3D true;
> =C2=A0=C2=A0=C2=A0=C2=A0 amc->i2c_init=C2=A0 =3D ast2600_evb_i2c_init;
> =C2=A0=C2=A0=C2=A0=C2=A0 mc->default_ram_size =3D 1 * GiB;
> =C2=A0=C2=A0=C2=A0=C2=A0 aspeed_machine_class_init_cpus_defaults(mc);
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index cbeacb214c..879bdb96ee 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -39,6 +39,7 @@ struct AspeedMachineClass {
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t macs_mask;
> =C2=A0=C2=A0=C2=A0=C2=A0 void (*i2c_init)(AspeedMachineState *bmc);
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t uart_default;
> +=C2=A0=C2=A0=C2=A0 bool sdhci_wp_invert;

Other than also calling this `sdhci_wp_inverted` to match my comment on
the earlier patch about the model property and devicetree bindings,

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

