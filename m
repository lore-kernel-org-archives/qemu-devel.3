Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C150CC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 15:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Rqe-0001Ux-H8; Tue, 21 May 2024 11:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RqX-0001U9-3b; Tue, 21 May 2024 11:56:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RqL-0000Ry-25; Tue, 21 May 2024 11:56:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LFsseS007152; Tue, 21 May 2024 15:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=X1JQtfmL8zJtbRtbg4mfQ7NNJCGC67zaJkMx9Cun9Ns=;
 b=DVKlGFKVUPt83SnkDIqE8HdYYyqj/lBZBLJiTIdeRGHak1HIvZjxsjG9dUI0VIOAbEcN
 u8NDrT2d9QOQhJlIhAMizmxZbDRInhJYCmh844I+2OXvZYZEKVn6dS5ohHy64P53YPIR
 iKT4c2ug9T4xExEByhlehXB7mIb12TBZszNt/TwpBZ8syLSPctsavljFT+oDcnoHH8nd
 ZTO/aXIq98wa9j5w1nI+t15LA095RNEgI1AWpLZJQRK6aSRIR/QOX3TeH5dEfSvZY/9c
 E9eHvfUT64PSsTW33kO3l8OlEWrabFk16ibApi3RFdbDAcorKD/M2Ib9HSKa1WH501Fm vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8x3t03gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:55:58 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LFtv3g008953;
 Tue, 21 May 2024 15:55:57 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8x3t03gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:55:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LD0voK007412; Tue, 21 May 2024 15:52:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c2x3h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:52:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LFqMWj25887052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 15:52:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D4A858060;
 Tue, 21 May 2024 15:52:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4F7158043;
 Tue, 21 May 2024 15:52:21 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 15:52:21 +0000 (GMT)
Message-ID: <99aea881add8e8e720bf89743d13162b4da95477.camel@linux.ibm.com>
Subject: Re: [PATCH v2 06/12] target/ppc: Add PPR32 SPR
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 10:52:21 -0500
In-Reply-To: <20240521013029.30082-7-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-7-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uUiOlX_q4b_pByVXLLIGBMRXQoYlWo7E
X-Proofpoint-ORIG-GUID: 3P8_eusABJdxTa-hsgENkLH73KyBax_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_09,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Thanks,

Glenn

On Tue, 2024-05-21 at 11:30 +1000, Nicholas Piggin wrote:
> PPR32 provides access to the upper half of PPR.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/cpu.h        |  1 +
>  target/ppc/spr_common.h |  2 ++
>  target/ppc/cpu_init.c   | 12 ++++++++++++
>  target/ppc/translate.c  | 16 ++++++++++++++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2532408be0..141cbefb4c 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2120,6 +2120,7 @@ void ppc_compat_add_property(Object *obj, const
> char *name,
>  #define SPR_POWER_MMCRS       (0x37E)
>  #define SPR_WORT              (0x37F)
>  #define SPR_PPR               (0x380)
> +#define SPR_PPR32             (0x382)
>  #define SPR_750_GQR0          (0x390)
>  #define SPR_440_DNV0          (0x390)
>  #define SPR_750_GQR1          (0x391)
> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
> index eb2561f593..9e40b3b608 100644
> --- a/target/ppc/spr_common.h
> +++ b/target/ppc/spr_common.h
> @@ -203,6 +203,8 @@ void spr_read_tfmr(DisasContext *ctx, int gprn,
> int sprn);
>  void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
>  void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
> +void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
> +void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
>  #endif
>  
>  void register_low_BATs(CPUPPCState *env);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 892fb6ce02..7684a59d75 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5623,6 +5623,14 @@ static void register_HEIR64_spr(CPUPPCState
> *env)
>                   0x00000000);
>  }
>  
> +static void register_power7_common_sprs(CPUPPCState *env)
> +{
> +    spr_register(env, SPR_PPR32, "PPR32",
> +                 &spr_read_ppr32, &spr_write_ppr32,
> +                 &spr_read_ppr32, &spr_write_ppr32,
> +                 0x00000000);
> +}
> +
>  static void register_power8_tce_address_control_sprs(CPUPPCState
> *env)
>  {
>      spr_register_kvm(env, SPR_TAR, "TAR",
> @@ -6118,6 +6126,7 @@ static void init_proc_POWER7(CPUPPCState *env)
>      register_power6_common_sprs(env);
>      register_HEIR32_spr(env);
>      register_power6_dbg_sprs(env);
> +    register_power7_common_sprs(env);
>      register_power7_book4_sprs(env);
>  
>      /* env variables */
> @@ -6264,6 +6273,7 @@ static void init_proc_POWER8(CPUPPCState *env)
>      register_power6_common_sprs(env);
>      register_HEIR32_spr(env);
>      register_power6_dbg_sprs(env);
> +    register_power7_common_sprs(env);
>      register_power8_tce_address_control_sprs(env);
>      register_power8_ids_sprs(env);
>      register_power8_ebb_sprs(env);
> @@ -6431,6 +6441,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>      register_power6_common_sprs(env);
>      register_HEIR32_spr(env);
>      register_power6_dbg_sprs(env);
> +    register_power7_common_sprs(env);
>      register_power8_tce_address_control_sprs(env);
>      register_power8_ids_sprs(env);
>      register_power8_ebb_sprs(env);
> @@ -6625,6 +6636,7 @@ static void init_proc_POWER10(CPUPPCState *env)
>      register_power6_common_sprs(env);
>      register_HEIR64_spr(env);
>      register_power6_dbg_sprs(env);
> +    register_power7_common_sprs(env);
>      register_power8_tce_address_control_sprs(env);
>      register_power8_ids_sprs(env);
>      register_power8_ebb_sprs(env);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index ca4f4c9371..137370b649 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1414,6 +1414,22 @@ void spr_read_dexcr_ureg(DisasContext *ctx,
> int gprn, int sprn)
>      gen_load_spr(t0, sprn + 16);
>      tcg_gen_ext32u_tl(cpu_gpr[gprn], t0);
>  }
> +
> +/* The PPR32 SPR accesses the upper 32-bits of PPR */
> +void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_load_spr(cpu_gpr[gprn], SPR_PPR);
> +    tcg_gen_shri_tl(cpu_gpr[gprn], cpu_gpr[gprn], 32);
> +}
> +
> +void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn)
> +{
> +    TCGv t0 = tcg_temp_new();
> +
> +    tcg_gen_shli_tl(t0, cpu_gpr[gprn], 32);
> +    gen_store_spr(SPR_PPR, t0);
> +    spr_store_dump_spr(SPR_PPR);
> +}
>  #endif
>  
>  #define GEN_HANDLER(name, opc1, opc2, opc3, inval,
> type)                      \


