Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78642CFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 17:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxV3d-0003wj-Ca; Sun, 06 Oct 2024 13:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxV3C-0003sz-ON; Sun, 06 Oct 2024 13:28:13 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxV34-0002uq-Ha; Sun, 06 Oct 2024 13:28:10 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5DA394E6004;
 Sun, 06 Oct 2024 19:23:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id d6eBpTY9-MPz; Sun,  6 Oct 2024 19:23:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6EC814E6001; Sun, 06 Oct 2024 19:23:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6CCE2746F60;
 Sun, 06 Oct 2024 19:23:15 +0200 (CEST)
Date: Sun, 6 Oct 2024 19:23:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v2 09/23] hw/ppc/mpc8544_guts: Populate POR PLL ratio
 status register
In-Reply-To: <20241005194603.23139-10-shentey@gmail.com>
Message-ID: <29b750ca-5f21-232b-c8fa-ecfeea8a360b@eik.bme.hu>
References: <20241005194603.23139-1-shentey@gmail.com>
 <20241005194603.23139-10-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sat, 5 Oct 2024, Bernhard Beschow wrote:
> Populate this read-only register with some arbitrary values which avoids
> U-Boot's get_clocks() to hang().
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

I think the register fields are overkill, a value with a comment or some 
or'ed shift'ed values with a comment would be simpler but the result is 
the same so

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> hw/ppc/mpc8544_guts.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
> diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
> index e3540b0281..c02b34ccde 100644
> --- a/hw/ppc/mpc8544_guts.c
> +++ b/hw/ppc/mpc8544_guts.c
> @@ -29,6 +29,12 @@
> #define MPC8544_GUTS_RSTCR_RESET      0x02
>
> #define MPC8544_GUTS_ADDR_PORPLLSR    0x00
> +REG32(GUTS_PORPLLSR, 0x00)
> +    FIELD(GUTS_PORPLLSR, E500_1_RATIO, 24, 6)
> +    FIELD(GUTS_PORPLLSR, E500_0_RATIO, 16, 6)
> +    FIELD(GUTS_PORPLLSR, DDR_RATIO, 9, 5)
> +    FIELD(GUTS_PORPLLSR, PLAT_RATIO, 1, 5)
> +
> #define MPC8544_GUTS_ADDR_PORBMSR     0x04
> #define MPC8544_GUTS_ADDR_PORIMPSCR   0x08
> #define MPC8544_GUTS_ADDR_PORDEVSR    0x0C
> @@ -75,6 +81,12 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr addr,
>
>     addr &= MPC8544_GUTS_MMIO_SIZE - 1;
>     switch (addr) {
> +    case MPC8544_GUTS_ADDR_PORPLLSR:
> +        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_1_RATIO, 6); /* 3:1 */
> +        value = FIELD_DP32(value, GUTS_PORPLLSR, E500_0_RATIO, 6); /* 3:1 */
> +        value = FIELD_DP32(value, GUTS_PORPLLSR, DDR_RATIO, 12); /* 12:1 */
> +        value = FIELD_DP32(value, GUTS_PORPLLSR, PLAT_RATIO, 6); /* 6:1 */
> +        break;
>     case MPC8544_GUTS_ADDR_PVR:
>         value = env->spr[SPR_PVR];
>         break;
>

