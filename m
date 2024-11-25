Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5133AD58D64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFbvX-0000Sf-VJ; Mon, 25 Nov 2024 11:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFbvV-0000Ql-6l; Mon, 25 Nov 2024 11:27:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFbvS-0003Ue-Te; Mon, 25 Nov 2024 11:27:04 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFZiYk012701;
 Mon, 25 Nov 2024 16:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=2lijNTUVgh+sCJR49qXhV7JJZLlWuux/GhacsPKU9mg=; b=tRTsDukd0OuS
 /QNThv48y4qvTq8wpgIi9Nc0jFTMgx1VZ6zYrtzNV7eep2pZRyh5B8qXfoCNPmDO
 ONlNFvYsqXau5S4j9iKbpfeFmPBo0cHM7HsKVGLvf5gf9K3UVEQLw7m3kFTVXVJi
 pHZ+IgRUixsSho/Y12F+/j3a/pMurrK+p2aPlbM7bBRWNpVrOatUPDLrvsrbgVu8
 8bjDZ9SvlWERx6A+n5qMdov9zOkhAxRtDcIPb5XDEkCuAIHn5hN1dNRmLSnOp5U5
 cBa+y4qDaXmdEu6scoQ5jTcXRWHUy6O6F2DozrshzShP9VxlbnZBvmx/6juqRR4a
 SIgmTi3Zqg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n9ed2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:27:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APGQgLe004549;
 Mon, 25 Nov 2024 16:27:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n9ed0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:27:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFFm24024910;
 Mon, 25 Nov 2024 16:26:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433tvk0dta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:26:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4APGQwxV48824702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 16:26:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ADEA5803F;
 Mon, 25 Nov 2024 16:26:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 303DD5805A;
 Mon, 25 Nov 2024 16:26:58 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2024 16:26:58 +0000 (GMT)
Message-ID: <82803e326082109f889a40e2691a0a29e62b742a.camel@linux.ibm.com>
Subject: Re: [PATCH 3/4] target/ppc: Fix THREAD_SIBLING_FOREACH for mult-socket
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Date: Mon, 25 Nov 2024 10:26:57 -0600
In-Reply-To: <20241125132042.325734-4-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-4-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8_8.2) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9kBKgN0ikhhi79W2gDRTkvGAyN0JPW4j
X-Proofpoint-ORIG-GUID: a8m6nMj6pNaIyPHDO5pBMB7BN3p1CziF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2024-11-25 at 23:20 +1000, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
> 
> The THREAD_SIBLING_FOREACH macro wasn't excluding threads from
> other chips. Add chip_index field to the thread state and add
> a check for the new field in the macro.
> 
> Fixes: b769d4c8f4c6 ("target/ppc: Add initial flags and helpers for
> SMT support")
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> [npiggin: set chip_index for spapr too]
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/cpu.h        | 7 +++++--
>  hw/ppc/pnv_core.c       | 2 ++
>  hw/ppc/spapr_cpu_core.c | 1 +
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0b4f1013b8..2ffac2ed03 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1253,6 +1253,7 @@ struct CPUArchState {
>      /* For SMT processors */
>      bool has_smt_siblings;
>      int core_index;
> +    int chip_index;
>  
>  #if !defined(CONFIG_USER_ONLY)
>      /* MMU context, only relevant for full system emulation */
> @@ -1412,8 +1413,10 @@ struct CPUArchState {
>  
>  #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
>      CPU_FOREACH(cs_sibling)                                     \
> -        if (POWERPC_CPU(cs)->env.core_index ==                  \
> -            POWERPC_CPU(cs_sibling)->env.core_index)
> +        if ((POWERPC_CPU(cs)->env.chip_index ==                 \
> +             POWERPC_CPU(cs_sibling)->env.chip_index) &&        \
> +            (POWERPC_CPU(cs)->env.core_index ==                 \
> +             POWERPC_CPU(cs_sibling)->env.core_index))
>  
>  #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
>  do {                                            \
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index cbfac49862..e6b02294b1 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -322,6 +322,8 @@ static void pnv_core_cpu_realize(PnvCore *pc,
> PowerPCCPU *cpu, Error **errp,
>      pir_spr->default_value = pir;
>      tir_spr->default_value = tir;
>  
> +    env->chip_index = pc->chip->chip_id;
> +
>      if (pc->big_core) {
>          /* 2 "small cores" get the same core index for SMT
> operations */
>          env->core_index = core_hwid >> 1;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ada439e831..135f86a622 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -313,6 +313,7 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore
> *sc, int i, Error **errp)
>          return NULL;
>      }
>  
> +    env->chip_index = sc->node_id;
>      env->core_index = cc->core_id;
>  
>      cpu->node_id = sc->node_id;


