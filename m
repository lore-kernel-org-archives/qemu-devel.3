Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D29C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whq18-0001fV-MH; Thu, 09 Jul 2026 10:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1whq17-0001ew-Ij; Thu, 09 Jul 2026 10:46:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1whq14-000420-Nw; Thu, 09 Jul 2026 10:46:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EIXdr2551742; Thu, 9 Jul 2026 14:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=cUCedvf/NsvquBkKgrKyvcJwBe9Veh
 fLBecXP8OxiPk=; b=jyMZgX6+/U1I78eb53qEyyrusv2UGAOLjPFU/eWkY9IA9p
 vldEFpplAoPNNyRHCOl9kajx8/EPRPLg1kmIfH9O/tbXY8Sb0LxZBZpaflFAqMZ7
 moXr24ki66qp5s9qp90JbpKdko5J2dhIEl5CtQffTP9l/btOeyU6ibP23aMuYQQY
 dVRloI/JHkRRAFAeDb+zaxyaoQEQDSIjD/tmOa/D8IRyw4KF2BcRgS6sSk6Ap7Gg
 6Usf3clJzEEQf0P5uTLYoNhrpyGQugNyAdUzHzjexjlRzUQg/ql2YtyHuypcOQz7
 BF2jzcuZm4OgAyi+U8bT3Wp6bqrc9FcgbZ5Jjw2g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknsnjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:46:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EYd5M012737;
 Thu, 9 Jul 2026 14:46:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yd8ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:46:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669EkAHo38142308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 14:46:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FB6220049;
 Thu,  9 Jul 2026 14:46:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3A6120040;
 Thu,  9 Jul 2026 14:46:08 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  9 Jul 2026 14:46:08 +0000 (GMT)
Date: Thu, 9 Jul 2026 20:16:11 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Remove unused helper_lscbx()
Message-ID: <20260709201237.46ba7f2d-72-amachhiw@linux.ibm.com>
Mail-Followup-To: Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260709095056.1803725-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709095056.1803725-1-peter.maydell@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4fb437 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=BoEjErS5yIuBRj-D9BoA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: j4hRIfUkxQx4vdQ1I0ltETK7GBageFgn
X-Proofpoint-ORIG-GUID: ojND788OhKRrUAlyZcToP4QMcJxnxxk2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfXwd7470xBM7n3
 6E28ZekJACldfJHpF0PCCixtHo/FyFSpWNhPhP27VOqrVZ+xy7Jd/TaB85LlPmfsfb/7TLE7MrY
 EWKAf60T2OQxqWsVEe124ZT0PUOGN3w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfXy0QhhVUMNUFY
 +2lkD+f087O7RMQsEGqUm3It/fvNPBhUTbnNzJ8bgsr+FMYaQ19SNMm35UzHcAOr/C5q9FgR7Dm
 4NLiKWulsLeEIhThxOPxkczWF34nFWEeY554DFArDrw1YxBei/INrLh3rqYnyKUps1beOgyiNDs
 jwrz5HMWCey87LdHP8nGBdcILlERwHH1zydri0Lh1HgxSLt8rJoirTqygDP0eMNZQfO2ua//kTh
 DT31EulMV50n3lrJWJwxlUUz5+tFkwonZxe61b9Ve1h34Ut5kE2NKWGeAime6kSV8ZvhG7lBD7o
 VDMtpZOumhRnuvZecL4QxYBlcZLDstxwXXEr42IL1smuiSkUVZ4RyAuTeDQGiS6VFQfSiYHL+T3
 SUgeghUNAajgPcgxOhS21ebdJJnGVveQII7mS3kKFs3kyzO7lxr95ett6eGfUW3jGTJlhflZ6XS
 eETWNxwswuf9vgsI3RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090141
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 2026/07/09 10:50 AM, Peter Maydell wrote:
> The helper_lscbx() function isn't called anywhere.  It used to be
> used by the PPC 601 CPU support; we removed that in commit 005b69fdcc
> in 2022 but missed this helper function.
> 
> Fixes: 005b69fdcc ("target/ppc: Remove PowerPC 601 CPUs")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This came to my attention because Coverity reported a
> "shifts into sign bit" issue in the function: CID 1663681
> ---
>  target/ppc/helper.h     |  1 -
>  target/ppc/mem_helper.c | 28 ----------------------------
>  2 files changed, 29 deletions(-)

"git grep lscbx" returns only the declaration in helper.h and the
definition in mem_helper.c -- no TCG translator references, no
gen_lscbx, nothing in translate.c. Confirmed dead code with zero
callers. Thanks for the cleanup.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index e99c8c824b..6b2d19a3ad 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -54,7 +54,6 @@ DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
>  #endif
>  DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
>  DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
> -DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
>  
>  #if defined(TARGET_PPC64)
>  DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 119dc1df23..787ba2cdec 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -367,34 +367,6 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
>  #endif
>  }
>  
> -/* XXX: to be tested */
> -target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
> -                          uint32_t ra, uint32_t rb)
> -{
> -    int i, c, d;
> -
> -    d = 24;
> -    for (i = 0; i < xer_bc; i++) {
> -        c = cpu_ldub_data_ra(env, addr, GETPC());
> -        addr = addr_add(env, addr, 1);
> -        /* ra (if not 0) and rb are never modified */
> -        if (likely(reg != rb && (ra == 0 || reg != ra))) {
> -            env->gpr[reg] = (env->gpr[reg] & ~(0xFF << d)) | (c << d);
> -        }
> -        if (unlikely(c == xer_cmp)) {
> -            break;
> -        }
> -        if (likely(d != 0)) {
> -            d -= 8;
> -        } else {
> -            d = 24;
> -            reg++;
> -            reg = reg & 0x1F;
> -        }
> -    }
> -    return i;
> -}
> -
>  /*****************************************************************************/
>  /* Altivec extension helpers */
>  #if HOST_BIG_ENDIAN
> -- 
> 2.43.0
> 
> 

