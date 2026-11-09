Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQCuA-0001XD-Oz; Sun, 08 Nov 2026 19:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQCu9-0001Wv-02; Sun, 08 Nov 2026 19:06:33 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQCu7-00035s-2P; Sun, 08 Nov 2026 19:06:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8BF4060C38B;
 Mon, 09 Nov 2026 01:06:25 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id xQrIzCm3QltB; Mon,  9 Nov 2026 01:06:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 84E1760C706; Mon, 09 Nov 2026 01:06:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 83254139920;
 Mon, 09 Nov 2026 01:06:23 +0100 (CET)
Date: Mon, 9 Nov 2026 01:06:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bin Meng <bin.meng@processmission.com>
cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 23/23] target/ppc: Match e500mc/e5500/e6500 host PVR
 revisions
In-Reply-To: <20261108120034.1755008-24-bin.meng@processmission.com>
Message-ID: <289dcb2a-5f7b-2c5b-1e66-61beb7c994b5@eik.bme.hu>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
 <20261108120034.1755008-24-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 8 Nov 2026, Bin Meng wrote:
> The generic models use PVRs 0x80230020, 0x80240020 and 0x80400020.
> The default PVR callback is an exact comparison, so KVM's fallback
> lookup fails on various P/T-series SoCs and the VMM cannot register
> the host CPU type.
>
> Match the architected core-version field in the upper 16 bits for
> all three families, allowing differences in the revision field.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
>
> ---
>
> Changes in v3:
> - New
>
> target/ppc/cpu_init.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index a2da7c509d..42d69d0865 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -3159,6 +3159,12 @@ POWERPC_FAMILY(e500v2)(ObjectClass *oc, const void *data)
>                  POWERPC_FLAG_BUS_CLK;
> }
>
> +static bool ppc_pvr_match_booke(PowerPCCPUClass *pcc, uint32_t pvr, bool best)

Not sure how booke specific is this. Why not call it _match_core if that's 
what it does? But it's not a big deal so probably does not worth a respin 
if there are no changes needed otherwise.

Regards,
BALATON Zoltan

> +{
> +    /* Match the core version while allowing hardware revision differences */
> +    return (pvr & 0xffff0000) == (pcc->pvr & 0xffff0000);
> +}
> +
> static void init_proc_e500mc(CPUPPCState *env)
> {
>     init_proc_e500(env, fsl_e500mc);
> @@ -3170,6 +3176,7 @@ POWERPC_FAMILY(e500mc)(ObjectClass *oc, const void *data)
>     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
>
>     dc->desc = "e500mc core";
> +    pcc->pvr_match = ppc_pvr_match_booke;
>     pcc->init_proc = init_proc_e500mc;
>     pcc->check_pow = check_pow_none;
>     pcc->check_attn = check_attn_none;
> @@ -3218,6 +3225,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
>     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
>
>     dc->desc = "e5500 core";
> +    pcc->pvr_match = ppc_pvr_match_booke;
>     pcc->init_proc = init_proc_e5500;
>     pcc->check_pow = check_pow_none;
>     pcc->check_attn = check_attn_none;
> @@ -3268,6 +3276,7 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
>     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
>
>     dc->desc = "e6500 core";
> +    pcc->pvr_match = ppc_pvr_match_booke;
>     pcc->init_proc = init_proc_e6500;
>     pcc->check_pow = check_pow_none;
>     pcc->check_attn = check_attn_none;
>

