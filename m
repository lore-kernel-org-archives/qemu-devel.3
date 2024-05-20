Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A53CC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 11:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s91Ou-0001T4-Nn; Mon, 20 May 2024 07:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s91Ot-0001Sl-Bt; Mon, 20 May 2024 07:41:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s91Oq-00069H-FD; Mon, 20 May 2024 07:41:55 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AC6A54E602E;
 Mon, 20 May 2024 13:41:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ctKXdF1MTUCX; Mon, 20 May 2024 13:41:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B80674E6000; Mon, 20 May 2024 13:41:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B64B8746E3B;
 Mon, 20 May 2024 13:41:46 +0200 (CEST)
Date: Mon, 20 May 2024 13:41:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: npiggin@gmail.com, qemu-ppc@nongnu.org, danielhb413@gmail.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 5/6] target/ppc: reduce duplicate code between
 init_proc_POWER{9, 10}
In-Reply-To: <20240520103329.381158-6-harshpb@linux.ibm.com>
Message-ID: <d038d95e-dc17-dc9d-c810-80b1832ba8b3@eik.bme.hu>
References: <20240520103329.381158-1-harshpb@linux.ibm.com>
 <20240520103329.381158-6-harshpb@linux.ibm.com>
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

On Mon, 20 May 2024, Harsh Prateek Bora wrote:
> Historically, the registration of sprs have been inherited alongwith
> every new Power arch support being added leading to a lot of code
> duplication. It's time to do necessary cleanups now to avoid further
> duplication with newer arch support being added.
>
> Signed-off-by: Harsh Prateek Bora <harshb@linux.ibm.com>
> ---
> target/ppc/cpu_init.c | 43 +++++++++----------------------------------
> 1 file changed, 9 insertions(+), 34 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 6d82f24c87..636e12ba7a 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6307,7 +6307,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
> };
> #endif /* CONFIG_USER_ONLY */
>
> -static void init_proc_POWER9(CPUPPCState *env)
> +static inline void register_power9_common_sprs(CPUPPCState *env)

QEMU conventions recommend not adding inline in C files and let the 
compiler decide about that. The inline may only be needed for functions 
defined in a header that are meant to be inlined in multiple files. So I 
think no inline is needed here. (I don't know if this is documented but I 
saw that in Richard Hendersons's reviews multiple times.)

Regards,
BALATON Zoltan

> {
>     /* Common Registers */
>     init_proc_book3s_common(env);
> @@ -6326,7 +6326,6 @@ static void init_proc_POWER9(CPUPPCState *env)
>     register_power5p_ear_sprs(env);
>     register_power5p_tb_sprs(env);
>     register_power6_common_sprs(env);
> -    register_HEIR32_spr(env);
>     register_power6_dbg_sprs(env);
>     register_power8_tce_address_control_sprs(env);
>     register_power8_ids_sprs(env);
> @@ -6342,6 +6341,12 @@ static void init_proc_POWER9(CPUPPCState *env)
>     register_power9_book4_sprs(env);
>     register_power8_rpr_sprs(env);
>     register_power9_mmu_sprs(env);
> +}
> +
> +static void init_proc_POWER9(CPUPPCState *env)
> +{
> +    register_power9_common_sprs(env);
> +    register_HEIR32_spr(env);
>
>     /* POWER9 Specific registers */
>     spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
> @@ -6499,39 +6504,9 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
>
> static void init_proc_POWER10(CPUPPCState *env)
> {
> -    /* Common Registers */
> -    init_proc_book3s_common(env);
> -    register_book3s_207_dbg_sprs(env);
> -
> -    /* Common TCG PMU */
> -    init_tcg_pmu_power8(env);
> -
> -    /* POWER8 Specific Registers */
> -    register_book3s_ids_sprs(env);
> -    register_amr_sprs(env);
> -    register_iamr_sprs(env);
> -    register_book3s_purr_sprs(env);
> -    register_power5p_common_sprs(env);
> -    register_power5p_lpar_sprs(env);
> -    register_power5p_ear_sprs(env);
> -    register_power5p_tb_sprs(env);
> -    register_power6_common_sprs(env);
> +    register_power9_common_sprs(env);
>     register_HEIR64_spr(env);
> -    register_power6_dbg_sprs(env);
> -    register_power8_tce_address_control_sprs(env);
> -    register_power8_ids_sprs(env);
> -    register_power8_ebb_sprs(env);
> -    register_power8_fscr_sprs(env);
> -    register_power8_pmu_sup_sprs(env);
> -    register_power8_pmu_user_sprs(env);
> -    register_power8_tm_sprs(env);
> -    register_power8_pspb_sprs(env);
> -    register_power8_dpdes_sprs(env);
> -    register_vtb_sprs(env);
> -    register_power8_ic_sprs(env);
> -    register_power9_book4_sprs(env);
> -    register_power8_rpr_sprs(env);
> -    register_power9_mmu_sprs(env);
> +
>     register_power10_hash_sprs(env);
>     register_power10_dexcr_sprs(env);
>     register_power10_pmu_sup_sprs(env);
>

