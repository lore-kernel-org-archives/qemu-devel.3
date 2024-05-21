Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFCBC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 16:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Rx0-0005YB-I7; Tue, 21 May 2024 12:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9Rwb-0005Bq-LP; Tue, 21 May 2024 12:02:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RwY-00020J-Sh; Tue, 21 May 2024 12:02:29 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LEXVoq013602; Tue, 21 May 2024 16:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=b8SkKPpGehnnu2h7p5j7IUUbq5HbG3U6fJ2F+tsBVqY=;
 b=fK8tfTJcj91bdKQEl92SOjpGnttnqk6Q0GX/wu18KKugtO+hyMOZ8FUCXcjTX/m4ir+u
 64wQ2nhTJKQWfF3JLpr9c7ZE9eXaRWl8tBIbGBgBTBmPINbakqyv1i6LP6H8tak468vh
 F0LTaQEdPvsN9Zi094QiWX/iyMoyEfK2fozDvDpIGdfdIyWtHYyJIt/yz4CBiAuZya/Y
 DZiluMuz8w71RzgW1kdY5DEH24IV0lE4W57P4UunyXqGYhtr9zwlxtmGO5NkFE1M6nwC
 OK5r+SbPovBR4mbzRJF6EwsfaEnvt7qajClthM87jdeUsZwoSInzY/Qli+d9QYMrv+Om Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8wfpg8rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:02:24 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LG2NBV025301;
 Tue, 21 May 2024 16:02:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8wfpg8rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:02:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LETlOt023565; Tue, 21 May 2024 16:02:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77np6m64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:02:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LG2Koi27329072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 16:02:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8B6258054;
 Tue, 21 May 2024 16:02:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 935685806B;
 Tue, 21 May 2024 16:02:20 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 16:02:20 +0000 (GMT)
Message-ID: <82a796f0004e82aa1e84e3eb425d348d8dfbb63d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 09/12] target/ppc: Add SMT support to PTCR SPR
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Chinmay Rath
 <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 11:02:20 -0500
In-Reply-To: <20240521013029.30082-10-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-10-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zvJbRU6cAddGEZYxOQ3Y2FzTsS_z5zbI
X-Proofpoint-GUID: AxIjMQcRScsIJ8h-w_8WuazrGYSv1Nes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=922 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Thanks,

Glenn

On Tue, 2024-05-21 at 11:30 +1000, Nicholas Piggin wrote:
> PTCR is a per-core register.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/misc_helper.c | 16 ++++++++++++++--
>  target/ppc/translate.c   |  4 ++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 6f419c9346..a67930d031 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -173,6 +173,7 @@ void helper_store_sdr1(CPUPPCState *env,
> target_ulong val)
>  void helper_store_ptcr(CPUPPCState *env, target_ulong val)
>  {
>      if (env->spr[SPR_PTCR] != val) {
> +        CPUState *cs = env_cpu(env);
>          PowerPCCPU *cpu = env_archcpu(env);
>          target_ulong ptcr_mask = PTCR_PATB | PTCR_PATS;
>          target_ulong patbsize = val & PTCR_PATS;
> @@ -194,8 +195,19 @@ void helper_store_ptcr(CPUPPCState *env,
> target_ulong val)
>              return;
>          }
>  
> -        env->spr[SPR_PTCR] = val;
> -        tlb_flush(env_cpu(env));
> +        if (cs->nr_threads == 1 || !(env->flags &
> POWERPC_FLAG_SMT_1LPAR)) {
> +            env->spr[SPR_PTCR] = val;
> +            tlb_flush(cs);
> +        } else {
> +            CPUState *ccs;
> +
> +            THREAD_SIBLING_FOREACH(cs, ccs) {
> +                PowerPCCPU *ccpu = POWERPC_CPU(ccs);
> +                CPUPPCState *cenv = &ccpu->env;
> +                cenv->spr[SPR_PTCR] = val;
> +                tlb_flush(ccs);
> +            }
> +        }
>      }
>  }
>  
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index c688551434..76f829ad12 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -971,6 +971,10 @@ void spr_write_hior(DisasContext *ctx, int sprn,
> int gprn)
>  }
>  void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
>  {
> +    if (!gen_serialize_core(ctx)) {
> +        return;
> +    }
> +
>      gen_helper_store_ptcr(tcg_env, cpu_gpr[gprn]);
>  }
>  


