Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426DFCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 20:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTlA-0005aM-I9; Wed, 24 Jun 2026 15:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcTl4-0005Y5-Be; Wed, 24 Jun 2026 15:59:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcTl2-00084u-GD; Wed, 24 Jun 2026 15:59:38 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OJmZ0I2206209; Wed, 24 Jun 2026 19:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=mvOpp2N1JzJK/SGi3nmnsM8O8An2DM
 RAzTvzNRGxOQ0=; b=AziWOXgMs1kTimilWZ06Y/dRgZPsHDRLuNTIvr59HZ5UJq
 CpOVzBU1gdY5xSak9hme5BCSos9KPs48kZKzmiOuMQypTfmk8HA07JstB/5+Cjka
 jIyp6R06itJHlXefAwxZ5GFMqR/7o6QbhhYs/hSPeKfLOESKiBcwteFkvYt7RW8T
 f5A0MBZPrqedr4CfPc7v04o1cKnlU0i/oD2ddFcZ7nfjTXIzNH2h1tVUZUcmOcIL
 qmauwCWWs2T8BflRnOrgbEx6vwjBC3oIkukPo0Ik5wOL/XZEZooZkRx3HlqT0bjQ
 94OmzoB3aRHmS9a4AqzTAvZAv9PSJ3M/F0xXYDEg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqx536-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 19:59:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OJo3aM012312;
 Wed, 24 Jun 2026 19:59:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66kah6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 19:59:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OJxIOi42271060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7222B20043;
 Wed, 24 Jun 2026 19:59:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D17920040;
 Wed, 24 Jun 2026 19:59:13 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.20.104]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jun 2026 19:59:12 +0000 (GMT)
Date: Thu, 25 Jun 2026 01:29:09 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] powernv: boot OpenBSD on POWER9
Message-ID: <ajw1PJpTXiyJzcPZ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260616223148.38348-2-kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616223148.38348-2-kirill@korins.ky>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3c371c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=HSgNecxd4Qb8Fe5FNfEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX1esURapXJJvY
 R4CGNzL0KaYssNLEsU3GEftr7f+7JFHfuw2MZPMhn0cyiRO783/CVD59asYxEtsfRBcRcYxfsai
 s99sDZpv68meqIGkWTHuardVKMgVw1iGHrSZD8iOumX9HXKjNadESjTBSETMF+HNSQ9VfiECQ2+
 zPkRXjiNCaT8byRQ6K/bPRkWn4AR6COgy0/dhiIoDde7aKP/SdXrGmXiIh1Dyh2yUHcQClyK/S9
 LvyBury4/10Pt4AtCWZ/3ydv7G2P3cHqI6Qj03WQgz8mZas6u0eyJLod3AZd6VK7SwgzfJeT/xq
 4UCEEqmoEJOfxq7XXGAFcMsg00wi6zOJMGiuEs5kfVbjUsmX6RP/aN9V1Ji9B954FAbRtOxOHDN
 F4nc7Udn7JPJqHCM3khpOarNGLDde0QsAXh4RYZ/CR88yaHiW4mGd6GfCrPbLWhWn9/i89JkRFj
 bjtM4q/L0WIrwX98U1Q==
X-Proofpoint-GUID: NvhbODAtLba5r6lmfQJnlwRFMFyGc0_0
X-Proofpoint-ORIG-GUID: gU-7ySZNYguK5BVLDLbLa_k1gECvtT2B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX8T8qcuBCMkS4
 aOacyiz689kI19AyUnTwK/Y3O+vDtVbEXhZSO4jKcDpHIA+9dC1uV1QwsEjAR8KyLpmRyEtcDaf
 hq+OiYdAsYVSlbDeN6lK5sQEIIXW+E4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

+ adding people from ./scripts/get_maintainer.pl in cc

On 26/06/17 12:31AM, Kirill A. Korinsky wrote:
> OpenBSD/powernv programs PTCR for LPID 0 with a partition
> table size exponent one smaller than QEMU's existing ISA v3.0
> interpretation. Try QEMU's existing PATS interpretation first,
> then fall back to the OpenBSD LPID 0 form; nonzero LPIDs keep
> the old behaviour.
> 
> The PSI model now exposes POWER9 IRQ level and pending status
> registers, and keeps both updated while delivering through the
> existing XIVE LSI source. This lets guests that select the
> POWER9 PSI LSI IRQ method continue to receive LPC interrupts.
> 
> The blast radius is probably minimal: the partition table
> fallback is limited to bare metal LPID 0 after the original
> lookup fails, while the PSI change only touches POWER9 PSI
> state and reuses the existing delivery path.

Thanks for the interesting change Kirill ! Will be nice to have OpenBSD
boot in PowerNV.

> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> @@ -817,18 +819,15 @@ static const MemoryRegionOps pnv_psi_p9_xscom_ops = {
>  static void pnv_psi_power9_set_irq(void *opaque, int irq, int state)
>  {
>      PnvPsi *psi = opaque;
> -    uint64_t irq_method = psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL)];
> +    uint64_t irq_bit = PPC_BIT(irq);
>  
> -    if (irq_method & PSIHB9_IRQ_METHOD) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported\n");
> -        return;
> -    }

is it required to remove this check ? afais, irq_method isn't having
this bit set by openbsd too.

> <...snip...>
>      /* Calculate number of entries */
> -    pats = 1ull << (pats + 12 - 4);
> -    if (pats <= lpid) {
> +    entries = table_size / sizeof(*entry);

nit: previously sizeof(*entry) == 1<<4 = 16 bytes. just to be extra
cautious, should we have __packed in ppc_v3_pate_t, can compilers
increase the size of the struct any arch ? i can't think of one just
being extra cautious

> +    if (entries <= lpid) {
>          return false;
>      }
>  
> @@ -45,3 +47,24 @@ bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
>      entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
>      return true;
>  }
> +
> +bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
> +{
> +    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
> +
> +    /*
> +     * Keep the existing ISA v3.0 PATS interpretation first.  OpenBSD/powernv
> +     * uses the PATSIZE value it writes to PTCR as one exponent smaller, and it
> +     * only needs that interpretation for the bare metal LPID 0 table.
> +     */
> +    if (ppc64_v3_get_pate_from_size(cpu, lpid, entry, 1ull << (pats + 12))) {
> +        return true;
> +    }
> +
> +    if (lpid == 0) {
> +        return ppc64_v3_get_pate_from_size(cpu, lpid, entry,
> +                                           1ull << (pats + 11));

any reason openbsd needs to populate ptcr this way ?

thanks for adding a testcase too !

- Aditya G

> 2.54.0

