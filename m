Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242F0CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQNT-0006lD-R1; Wed, 07 Oct 2026 08:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEQMO-0006Ja-UU; Wed, 07 Oct 2026 08:03:05 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEQMN-0000b8-0D; Wed, 07 Oct 2026 08:03:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A5BB583382;
 Wed, 07 Oct 2026 14:02:55 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Sx90o8hJAv5y; Wed,  7 Oct 2026 14:02:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 253495833DF; Wed, 07 Oct 2026 14:02:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 235E2583355;
 Wed, 07 Oct 2026 14:02:53 +0200 (CEST)
Date: Wed, 7 Oct 2026 14:02:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bin Meng <bin.meng@processmission.com>
cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 08/17] target/ppc: Register L2CFG0 and L2CSR1 on e500mc
 and e5500
In-Reply-To: <20261006094921.110871-9-bin.meng@processmission.com>
Message-ID: <d5a1cffd-164c-7b41-2c56-93364f6c977d@eik.bme.hu>
References: <20261006094921.110871-1-bin.meng@processmission.com>
 <20261006094921.110871-9-bin.meng@processmission.com>
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

On Tue, 6 Oct 2026, Bin Meng wrote:
> The e500mc and e5500 core manuals define L2CFG0 as read-only SPR 519
> (0x207) and L2CSR1 as writable SPR 1018 (0x3fa). U-Boot reads the
> former to discover the private L2 cache and programs the latter to
> select its stash ID. Missing registrations leave cache discovery
> and stash setup incomplete.
>
> Expose both registers on e500mc and e5500. Use the 128 KiB L2 geometry
> specified by the e500mc manual and a 256 KiB default for e5500,
> matching T1040/T1024. Other SoC integrations can override the capacity.
>
> Note the e6500 shared L2 uses memory-mapped registers, hence we do not
> add these SPRs to that core.
>
> Reference:
> - E500MCRM (Rev.3), section 2.15.1 and 2.15.3
>  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
> - E5500RM (Rev.4), section 2.15.1 and 2.15.3
>  https://www.nxp.com/webapp/Download?colCode=E5500RM
> - E6500RM (Rev.0), section 2.12.1 and 2.12.3
>  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
> target/ppc/cpu.h      |  2 ++
> target/ppc/cpu_init.c | 14 ++++++++++++++
> 2 files changed, 16 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d3f1c82730..498b505a96 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1976,6 +1976,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
> #define SPR_Exxx_L1CFG0       (0x203)
> #define SPR_Exxx_L1CFG1       (0x204)
> #define SPR_Exxx_NPIDR        (0x205)
> +#define SPR_Exxx_L2CFG0       (0x207)

I see there are more of these already. Disregard previous comment in that 
case.

Regards,
BALATON Zoltan

> #define SPR_ATBL              (0x20E)
> #define SPR_ATBU              (0x20F)
> #define SPR_IBAT0U            (0x210)
> @@ -2341,6 +2342,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
> #define SPR_750_TDCH          (0x3FA)
> #define SPR_IABR2             (0x3FA)
> #define SPR_40x_DCCR          (0x3FA)
> +#define SPR_Exxx_L2CSR1       (0x3FA)
> #define SPR_ICTC              (0x3FB)
> #define SPR_40x_ICCR          (0x3FB)
> #define SPR_THRM1             (0x3FC)
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index e5856b5b1d..21c6012fa1 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -2974,6 +2974,20 @@ static void init_proc_e500(CPUPPCState *env, int version)
>                      &spr_read_generic, &spr_write_e500_l2csr0,
>                      0x00000000);
>     }
> +    if (version == fsl_e500mc || version == fsl_e5500) {
> +        /*
> +         * L2CSIZE is in 64 KiB units. Use 128 KiB for e500mc and a
> +         * 256 KiB default for e5500, matching the T1040/T1024 SoCs.
> +         * Other SoC models can override the e5500 capacity.
> +         */
> +        spr_register(env, SPR_Exxx_L2CFG0, "L2CFG0",
> +                     &spr_read_generic, SPR_NOACCESS,
> +                     &spr_read_generic, SPR_NOACCESS,
> +                     version == fsl_e500mc ? 0x3cb1c002 : 0x3cb1c004);
> +        spr_register(env, SPR_Exxx_L2CSR1, "L2CSR1",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic32, 0);
> +    }
>     spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
>                  SPR_NOACCESS, SPR_NOACCESS,
>                  &spr_read_generic, &spr_write_generic,
>

