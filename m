Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259A4D7494D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 23:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5vzG-0001If-V1; Tue, 29 Oct 2024 19:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5vzD-0001Hs-Jl; Tue, 29 Oct 2024 19:50:55 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5vzA-0007NG-Vt; Tue, 29 Oct 2024 19:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1730245845;
 bh=YYBKmi3qVitdy25cvaeEwxwunuCrFaSkdZsXaa8Yn48=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=AwnD5qKSkIkWKA8UO6LjIG1PWdo14ZCaHk7zM8QSx+KqntShUapCIm6JZ3Wdho1ZA
 C0m5AnYXPPqgIGJZ80hoTAmJJC7Zcz8FtFOldqys/l6pkMGa9PVfEQFkDe/PA+zLIX
 GIrheV0E5Hwbw1l/g/IfWklRYOiq79ZfhdHbunuMUOvoNT4sLG68b0C4x/1TVmqBo5
 vq2CBqpDjntYn1JTFAtXeDGHVPpbHgNe30NdtRseHDe/b9x0rEK+JV/ILP+uSrQUPS
 vgEXkzxwCSUynKjR4xJsgcuaLr+QBLA8HasmqB5R7NG9xjScyxYBkvRQysEh8D+XK/
 s6MLrRcPIEtjA==
Received: from [192.168.68.112]
 (ppp118-210-190-243.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.190.243])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 20DC567E6D;
 Wed, 30 Oct 2024 07:50:45 +0800 (AWST)
Message-ID: <41d563a4c0de07ad4cc363c6a3599734608454a9.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 5/8] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
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
Date: Wed, 30 Oct 2024 10:20:44 +1030
In-Reply-To: <20241029091729.3317512-6-jamin_lin@aspeedtech.com>
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-6-jamin_lin@aspeedtech.com>
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
> should be 0 at the Present State Register (0x24). However, some board
> are
> design Write Protected pin active high. In other words, write enable
> the bit 19
> should be 0 and write protected the bit 19 should be 1 at the
> Present State Register (0x24). To support it, introduces a new
> "wp_invert"
> property and set it false by default.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
> =C2=A0hw/sd/sdhci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +=
+++++
> =C2=A0include/hw/sd/sdhci.h | 5 +++++
> =C2=A02 files changed, 11 insertions(+)
>=20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index db7d547156..bdf5cbfb80 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -275,6 +275,10 @@ static void sdhci_set_readonly(DeviceState *dev,
> bool level)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 SDHCIState *s =3D (SDHCIState *)dev;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (s->wp_invert) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 level =3D !level;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (level) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->prnsts &=3D ~SDHC_WRI=
TE_PROTECT;
> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> @@ -1551,6 +1555,8 @@ static Property sdhci_sysbus_properties[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false),
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_LINK("dma", SDHCIState,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_mr, TYPE_MEMORY_=
REGION, MemoryRegion *),
> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("wp-invert", SDHCIState,

Can we line the name up with the mmc-controller devicetree binding
("wp-inverted")?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/mmc/mmc-controller.yaml#n71

Andrew

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wp_invert, false),
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
> =C2=A0};
> =C2=A0
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 6cd2822f1d..d68f4788e7 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -100,6 +100,11 @@ struct SDHCIState {
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t sd_spec_version;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t uhs_mode;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t vendor;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* For vendor specific functionality */
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Write Protect pin default active low for dete=
cting SD card
> +=C2=A0=C2=A0=C2=A0=C2=A0 * to be protected. Set wp_invert to true invert=
ed the signal.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 bool wp_invert;
> =C2=A0};
> =C2=A0typedef struct SDHCIState SDHCIState;
> =C2=A0


