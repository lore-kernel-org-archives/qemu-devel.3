Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890E9C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuo3e-00059A-6A; Fri, 14 Aug 2026 05:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wuo3b-00058x-VU; Fri, 14 Aug 2026 05:18:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wuo3a-0000nr-BR; Fri, 14 Aug 2026 05:18:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E81bIW533225; Fri, 14 Aug 2026 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FESdi9
 kIzuR2p9twwT+cDpc1fJTxsrTTMWszVAG0RBQ=; b=m+C2wBNhssKF26s6Lkdjj2
 jQqHckHlWlad+C8p4qUSODzMTxCOp72nIP2B2cCTe/c1tIRWAkl+5dPaLkWF1w9a
 B8Art/0phG/A9+yWC9y1/sGcQdmLm0UtX6Qs/E6NIQXtECYclugd1ZM4zzju+4Eb
 fDv5W0ptz4ld+tdikxhZ/JTmY2kpEbUYAi5SLkzXlmDz7mFJ5hDSuxAAc+sS1GZw
 4kNozZjvnZlzNKisiIKH8xCFr/KWib8FwRQoDTCgwbDamLz9h0GDopzRi9ebQv1d
 fSznKMg68a+NdsGvD2t4sp7wWVyQ4C365tZUZj6dPZKYr8qsz7k/5dEgOFmz+0UQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9v20d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 09:18:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E9BMrd009972;
 Fri, 14 Aug 2026 09:18:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gpk64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 09:18:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67E9HhSe3211812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 09:17:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 805D15805C;
 Fri, 14 Aug 2026 09:18:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3050A58059;
 Fri, 14 Aug 2026 09:18:17 +0000 (GMT)
Received: from [9.124.210.243] (unknown [9.124.210.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 09:18:16 +0000 (GMT)
Message-ID: <b42864df-b058-4c25-addd-1255f0ff07a6@linux.ibm.com>
Date: Fri, 14 Aug 2026 14:48:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/ppc: Validate HTABMASK and reserved bits in
 SDR1 for 32-bit mode
To: sesame_h@qq.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, Minhang Zhang <zhangminhang@kylinos.cn>,
 dhruvb@linux.ibm.com, ritesh.list@gmail.com
References: <tencent_6A02E5163538A46B0CE182183D6F5858F20A@qq.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <tencent_6A02E5163538A46B0CE182183D6F5858F20A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: sxMgPu73wC0zQ4nM3Sdfx6AsuOQEOgNY
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7edd60 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=dZbOZ2KzAAAA:8
 a=VnNF1IyMAAAA:8 a=TO_pBULcb9OLBtObqa0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2OCBTYWx0ZWRfX9pTOIC503GXB
 BrzDxPtN1PL2V6+B1t7gi7EpPZ3FeVar8avMeORBVe8Cu3hY4ArK89OoRsu8sQJ8zHxomStE14l
 o/pBXefe4O6xqphx4vBCAFcpY+v6e9VFMu9HVTU7k4RUdFOt8ZGlJdAk8maS2t2UBIFLEQhK88F
 kNHyT7TPkJpCdPFYxJBzD012nF5XMJyTzNwXOiLUiQHhLlQW7v3QRShbFyPgG3oozqRQMuQF/My
 lybfLanxfJh2UYqj8uxiaGK4PPlvlg4PIpeL1S9auK/JoABpYanFtxoPMdIm7rPoXi9YnL05e3l
 wL/NGWYl+kn/EQSiqdO1HtCyWXK9xWnhvM7DPV1CbWwYhWBUZpq1eOTo4+ITVZgc0pKdopu3NQy
 fTuY3TiGTJfbQPRKYCfSsabO8onJlhP40Vr2Dg8+t9JGHN3kanZv5ysF/T0RnABMz4vlTJmjGhx
 0y+63o+4OjaWInGOrQw==
X-Proofpoint-ORIG-GUID: SUMjd5iLYID4R0y8gvrc2wEkWRLEIn1Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2OCBTYWx0ZWRfX9fHbC/v/RF4A
 7vH0cWl+RJqGQGJTr62G8pBBSM1gzD/ucFz8ypBsSt/Vlt187khbOilk0vn4toes8HrpGiInOHT
 WijHLYVPpoI9YdB0i++BkatzKBWN34M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140068
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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


On 8/14/26 14:26, sesame_h@qq.com wrote:
> From: Minhang Zhang <zhangminhang@kylinos.cn>
>
> ppc_store_sdr1() had validation for 64-bit SDR1 values but lacked
> corresponding checks for the 32-bit case.  According to the Power ISA,
> in 32-bit mode SDR1 bits 16-22 are reserved (must be zero) and
> HTABMASK (bits 23-31) must consist of a consecutive string of
> 1-bits starting from the LSB, i.e., be of the form 2^n-1.
>
> Add checks to reject invalid HTABMASK values and log a guest error
> for non-zero reserved bits, following the same pattern used by the
> existing 64-bit validation.
>
> Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>
Thanks for making the changes.

Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/mmu_common.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 2499e61..2a36817 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -42,24 +42,39 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>       PowerPCCPU *cpu = env_archcpu(env);
>       qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, value);
>       assert(!cpu->env.has_hv_mode || !cpu->vhyp);
> -#if defined(TARGET_PPC64)
>       if (mmu_is_64bit(env->mmu_model)) {
> +#if defined(TARGET_PPC64)
>           target_ulong sdr_mask = SDR_64_HTABORG | SDR_64_HTABSIZE;
>           target_ulong htabsize = value & SDR_64_HTABSIZE;
>   
>           if (value & ~sdr_mask) {
>               qemu_log_mask(LOG_GUEST_ERROR, "Invalid bits 0x"TARGET_FMT_lx
> -                     " set in SDR1", value & ~sdr_mask);
> +                     " set in SDR1\n", value & ~sdr_mask);
>               value &= sdr_mask;
>           }
>           if (htabsize > 28) {
>               qemu_log_mask(LOG_GUEST_ERROR, "Invalid HTABSIZE 0x" TARGET_FMT_lx
> -                     " stored in SDR1", htabsize);
> +                     " stored in SDR1\n", htabsize);
>               return;
>           }
> -    }
>   #endif /* defined(TARGET_PPC64) */
> -    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
> +    } else {
> +        target_ulong sdr_mask = SDR_32_HTABORG | SDR_32_HTABMASK;
> +        target_ulong htabmask = value & SDR_32_HTABMASK;
> +
> +        if (value & ~sdr_mask) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Invalid bits 0x" TARGET_FMT_lx
> +                          " set in SDR1\n", value & ~sdr_mask);
> +            value &= sdr_mask;
> +        }
> +        if ((htabmask & (htabmask + 1)) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Invalid HTABMASK 0x" TARGET_FMT_lx
> +                          " in SDR1 (must be of form 2^n-1)\n", htabmask);
> +            return;
> +        }
> +    }
>       env->spr[SPR_SDR1] = value;
>   }
>   

