Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AF4C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 03:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZko-0006iE-O4; Thu, 04 Jul 2024 23:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZkm-0006hp-J9; Thu, 04 Jul 2024 23:36:56 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZkk-0007qi-S8; Thu, 04 Jul 2024 23:36:56 -0400
Received: from [192.168.68.112]
 (ppp118-210-145-155.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.145.155])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 749522014E;
 Fri,  5 Jul 2024 11:36:50 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1720150611;
 bh=qrD3APwVTbEb6+UMXnlZvDWL8hR6derTmvhNktZVIG4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=hloTUKUjB1hfce45LdMBEgN3FArVjPsw+wV9r4vJk5fYS1gNAJAEXNc4hkxVsl/QO
 cb0Dw/ETc9IjGN40nIh7LrDTFcNhShH8uFQpicSJSWlSJEtvfxiEF/LlqIUtePTcyU
 RKFllkwycrFbDAatPlmiMXb5uHPmx+OvSZ6Q4C0L5LrK8ahskKJz4iPd7NiFuUvcxR
 5O4GL94ottZD63QFQhL5b+jT2QEaw2neF6OqjVgdQPuMj/zHUR7H912VdDRXq8a118
 lJcImNOdiEVmW6JoVoJ5veB41XXFfEkpIU+RthtngBXP1sUaehm4zmaFgz7Jt4Ugd4
 HoOOsJ6dAYtgQ==
Message-ID: <ba8b451ff51446c114fac96daa6e81abddf952a8.camel@codeconstruct.com.au>
Subject: Re: [PATCH 3/8] aspeed/scu: Add boot-from-eMMC HW strapping bit for
 AST2600 SoC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Peter
 Maydell <peter.maydell@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Date: Fri, 05 Jul 2024 13:06:49 +0930
In-Reply-To: <20240704053651.1100732-4-clg@redhat.com>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-4-clg@redhat.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2024-07-04 at 07:36 +0200, C=C3=A9dric Le Goater wrote:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Bit SCU500[2] of the AST2600 controls the boot device of the SoC.
>=20
> Future changes will configure this bit to boot from eMMC disk images
> specially built for this purpose.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/misc/aspeed_scu.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index 58db28db45aa..c9f98c20ffd9 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -349,6 +349,10 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
>  #define SCU_AST2600_H_PLL_BYPASS_EN                        (0x1 << 24)
>  #define SCU_AST2600_H_PLL_OFF                              (0x1 << 23)
> =20
> +/* STRAP1 SCU500 */
> +#define AST2600_HW_STRAP_BOOT_SRC_EMMC            (0x1 << 2)
> +#define AST2600_HW_STRAP_BOOT_SRC_SPI             (0x0 << 2)

Maybe these should have a `SCU_` prefix for consistency?

Anyway:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

