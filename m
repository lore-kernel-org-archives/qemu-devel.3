Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390D0CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQLS-0005eA-Vb; Wed, 07 Oct 2026 08:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEQLL-0005aA-5Q; Wed, 07 Oct 2026 08:01:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEQLI-0000TI-SC; Wed, 07 Oct 2026 08:01:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1ADD5833DF;
 Wed, 07 Oct 2026 14:01:50 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id h8wkls39FzNh; Wed,  7 Oct 2026 14:01:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 46F895833C5; Wed, 07 Oct 2026 14:01:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 45AA4583382;
 Wed, 07 Oct 2026 14:01:48 +0200 (CEST)
Date: Wed, 7 Oct 2026 14:01:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bin Meng <bin.meng@processmission.com>
cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 07/17] target/ppc: Register L1CSR2 on e500mc/e5500/e6500
 cores
In-Reply-To: <20261006094921.110871-8-bin.meng@processmission.com>
Message-ID: <4bc51987-b59a-e626-cf39-3edf28747c7d@eik.bme.hu>
References: <20261006094921.110871-1-bin.meng@processmission.com>
 <20261006094921.110871-8-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
> U-Boot programs the L1 data cache stash identifier before entering
> its C initialization code. The e500mc, e5500 and e6500 core manuals
> define L1CSR2 as a 32-bit SPR with number 606 (0x25e) and reset
> value zero.
>
> Expose the register on all three cores, excluding e500v1 and e500v2.
>
> Reference:
> - E500MCRM (Rev.3), section 2.14.3
>  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
> - E5500RM (Rev.4), section 2.14.3
>  https://www.nxp.com/webapp/Download?colCode=E5500RM
> - E6500RM (Rev.0), section 2.11.3
>  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
> target/ppc/cpu.h      | 1 +
> target/ppc/cpu_init.c | 4 ++++
> 2 files changed, 5 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index abcbcf3c18..d3f1c82730 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2038,6 +2038,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
> #define SPR_BOOKE_DSRR1       (0x23F)
> #define SPR_BOOKE_SPRG8       (0x25C)
> #define SPR_BOOKE_SPRG9       (0x25D)
> +#define SPR_Exxx_L1CSR2       (0x25E)

This name is too unspecific. Did you mean E5xx or something similar? Or 
could just be E500MC with 5500 and 6500 being derivative of that.

Regards,
BALATON Zoltan

> #define SPR_BOOKE_MAS0        (0x270)
> #define SPR_BOOKE_MAS1        (0x271)
> #define SPR_BOOKE_MAS2        (0x272)
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 23f25a56c0..e5856b5b1d 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -2965,6 +2965,10 @@ static void init_proc_e500(CPUPPCState *env, int version)
>                  &spr_read_generic, &spr_write_e500_l1csr1,
>                  0x00000000);
>     if (version != fsl_e500v1 && version != fsl_e500v2) {
> +        spr_register(env, SPR_Exxx_L1CSR2, "L1CSR2",
> +                     SPR_NOACCESS, SPR_NOACCESS,
> +                     &spr_read_generic, &spr_write_generic32,
> +                     0x00000000);
>         spr_register(env, SPR_Exxx_L2CSR0, "L2CSR0",
>                      SPR_NOACCESS, SPR_NOACCESS,
>                      &spr_read_generic, &spr_write_e500_l2csr0,
>

