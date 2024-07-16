Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C265DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlRF-0008AQ-0b; Tue, 16 Jul 2024 12:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlRD-00085F-Mk; Tue, 16 Jul 2024 12:54:03 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTlRB-0003ea-NB; Tue, 16 Jul 2024 12:54:03 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNlX739bSz4wc4;
 Wed, 17 Jul 2024 02:53:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNlX53GSfz4wbh;
 Wed, 17 Jul 2024 02:53:57 +1000 (AEST)
Message-ID: <d29f8da0-fab2-45f8-8efc-49345c10db57@kaod.org>
Date: Tue, 16 Jul 2024 18:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] ppc/pnv: Add allow for big-core differences in
 DT generation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240716162617.32161-1-npiggin@gmail.com>
 <20240716162617.32161-12-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716162617.32161-12-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/16/24 18:26, Nicholas Piggin wrote:
> device-tree building needs to account for big-core mode, because it is
> driven by qemu cores (small cores). Every second core should be skipped,
> and every core should describe threads for both small-cores that make
> up the big core.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/pnv.c | 43 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d902860ecd..1d08176b75 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -141,9 +141,9 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       CPUPPCState *env = &cpu->env;
>       PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
>       PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
> -    g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
> +    uint32_t *servers_prop;
>       int i;
> -    uint32_t pir;
> +    uint32_t pir, tir;
>       uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
>                          0xffffffff, 0xffffffff};
>       uint32_t tbfreq = PNV_TIMEBASE_FREQ;
> @@ -154,7 +154,10 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       char *nodename;
>       int cpus_offset = get_cpus_node(fdt);
>   
> -    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, NULL);
> +    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, &tir);
> +
> +    /* Only one DT node per (big) core */
> +    g_assert(tir == 0);
>   
>       nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
>       offset = fdt_add_subnode(fdt, cpus_offset, nodename);
> @@ -235,12 +238,28 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       }
>   
>       /* Build interrupt servers properties */
> -    for (i = 0; i < smt_threads; i++) {
> -        pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
> -        servers_prop[i] = cpu_to_be32(pir);
> +    if (pc->big_core) {
> +        servers_prop = g_new(uint32_t, smt_threads * 2);
> +        for (i = 0; i < smt_threads; i++) {
> +            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
> +            servers_prop[i * 2] = cpu_to_be32(pir);
> +
> +            pnv_cc->get_pir_tir(chip, pc->hwid + 1, i, &pir, NULL);
> +            servers_prop[i * 2 + 1] = cpu_to_be32(pir);
> +        }
> +        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
> +                          servers_prop, sizeof(*servers_prop) * smt_threads
> +                                        * 2)));
> +    } else {
> +        servers_prop = g_new(uint32_t, smt_threads);
> +        for (i = 0; i < smt_threads; i++) {
> +            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
> +            servers_prop[i] = cpu_to_be32(pir);
> +        }
> +        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
> +                          servers_prop, sizeof(*servers_prop) * smt_threads)));
>       }
> -    _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
> -                       servers_prop, sizeof(*servers_prop) * smt_threads)));
> +    g_free(servers_prop);
>   
>       return offset;
>   }
> @@ -389,6 +408,10 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>   
>           _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
>                              pa_features_300, sizeof(pa_features_300))));
> +
> +        if (pnv_core->big_core) {
> +            i++; /* Big-core groups two QEMU cores */
> +        }
>       }
>   
>       if (chip->ram_size) {
> @@ -450,6 +473,10 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>   
>           _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
>                              pa_features_31, sizeof(pa_features_31))));
> +
> +        if (pnv_core->big_core) {
> +            i++; /* Big-core groups two QEMU cores */
> +        }
>       }
>   
>       if (chip->ram_size) {


