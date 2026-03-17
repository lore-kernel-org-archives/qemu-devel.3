Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08090FD8773
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Uhz-0006Ju-Ik; Tue, 17 Mar 2026 09:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1w2Uhx-0006JU-Bl; Tue, 17 Mar 2026 09:43:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1w2Uhv-0005j0-UP; Tue, 17 Mar 2026 09:43:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HBHnQY1512429; Tue, 17 Mar 2026 13:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=kQymxdDt3Z/VKPozM9+QMd7bReIizOVTlDkA8t8KgO0=; b=DqnpdQrz2soF
 PvYQXfcvfvkOXzRMkKK7neCdOniR1O8bv9Em2v3tV3IBBdOP5GhnFYp6Fh5oe4hb
 HGi4MddgsGfaUqdaj2lnudejq/Q6lfuwnRcRrGPp+MW/TO9BqTSGWzqfKOVKaDcU
 8gexlDTEDHGHfKrMVtPPn7PqyuXcVOAeoLc+sJdCHaIMR0bkA6pLJSfX/vChEuwH
 aozJhvkkfkQEVHUkTJGZu4mi/HU8NnlmG9/pX0q8eoVNKJ+pwEskyvqopJFqovmf
 6XlCtSCt0TTzfGP2/GKHi6AChQRRGwKihEAhXcJfFbQB5t2YyXPRyTgkMe1b21W2
 sXihbaTvMw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hvng6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:43:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HCLBJ4028496;
 Tue, 17 Mar 2026 13:43:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1959w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:43:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDhawP26804988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:43:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FC9B5805D;
 Tue, 17 Mar 2026 13:43:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C20E958052;
 Tue, 17 Mar 2026 13:43:35 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:43:35 +0000 (GMT)
Message-ID: <b6588805a48f32b50feaa7e3d6c63684fcd09ef1.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] target/ppc: Explicitly declare CFAR register as 64-bit
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>, Nicholas
 Piggin <npiggin@gmail.com>
Date: Tue, 17 Mar 2026 08:43:35 -0500
In-Reply-To: <20260315170832.40331-2-philmd@linaro.org>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-2-philmd@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: JqhAZv6yztkcqQ4sgL7Z5ZfeDWYxvZoh
X-Proofpoint-ORIG-GUID: cl-1b-GT8Jeja6kFgpn6AjHSGJg8kS2M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyMSBTYWx0ZWRfX1icCl3102HNl
 JE7TY/SWroZZvDQyE3bHsAMkC7TQwOrkCYGZNSlzz7JGBMq1koAoABwpsW2UhouOqvdjf+5ljY3
 3maMEp0rzgJUvYJ7/7ah7VJ034FwDt1jTYr4VId1UwRMY23kFnXP48qOWQua1vrKPlS4N1GnZEM
 AOBkgtnLJcIwyOMWeK1bzMn6KQtrsPZm4xygnUqaALBIeZFvqbAK5u/SeNvTvZsqot+47OqXROU
 uuGoqCXIqabhpJFR9YMnSGecmngoFpYvPiRgidJ7QTOB4xpMu9jlpGWUNhaIOhELAZEcqgRsN0a
 L8/+7Qot83U2sFHjGwoLQIVNUNiS20xrTIKPW8nXlZMTDOLtxTJ4+qZl6Wd49UjgjncxhMsV2YX
 xA0TUatt85easAaNi0VyWEWNWpP6xJWULOkGi5IkXBNy6xqPUlvD+DuBhFrLU9Yi6yPR7OoYx/q
 GggR5eCWDA3jskVzeZg==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b95a89 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=lzPJCMtVSMt1EVogKw0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Sun, 2026-03-15 at 18:08 +0100, Philippe Mathieu-Daudé wrote:
> The Come-From Address Register (CFAR) register is only available
> on 64-bit CPUs, and is 64-bit wide. Prefer the 64-bit APIs over
> the 'target-long' one. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/ppc/cpu.h       |  2 +-
>  target/ppc/translate.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index aba8109bbba..63c8fa25acc 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1285,7 +1285,7 @@ struct CPUArchState {
>      target_ulong ctr;
>      uint32_t crf[8];       /* condition register */
>  #if defined(TARGET_PPC64)
> -    target_ulong cfar;
> +    uint64_t cfar;
>  #endif
>      target_ulong xer;      /* XER (with SO, OV, CA split out) */
>      target_ulong so;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f26b0281737..0fc81570a8b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -69,7 +69,7 @@ static TCGv cpu_msr;
>  static TCGv cpu_ctr;
>  static TCGv cpu_lr;
>  #if defined(TARGET_PPC64)
> -static TCGv cpu_cfar;
> +static TCGv_i64 cpu_cfar;
>  #endif
>  static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>  static TCGv cpu_reserve;
> @@ -124,8 +124,8 @@ void ppc_translate_init(void)
>                                  offsetof(CPUPPCState, lr), "lr");
>  
>  #if defined(TARGET_PPC64)
> -    cpu_cfar = tcg_global_mem_new(tcg_env,
> -                                  offsetof(CPUPPCState, cfar), "cfar");
> +    cpu_cfar = tcg_global_mem_new_i64(tcg_env,
> +                                    offsetof(CPUPPCState, cfar), "cfar");
>  #endif
>  
>      cpu_xer = tcg_global_mem_new(tcg_env,
> @@ -626,12 +626,12 @@ void spr_write_lr(DisasContext *ctx, int sprn, int gprn)
>  /* CFAR */
>  void spr_read_cfar(DisasContext *ctx, int gprn, int sprn)
>  {
> -    tcg_gen_mov_tl(cpu_gpr[gprn], cpu_cfar);
> +    tcg_gen_mov_i64(cpu_gpr[gprn], cpu_cfar);
>  }
>  
>  void spr_write_cfar(DisasContext *ctx, int sprn, int gprn)
>  {
> -    tcg_gen_mov_tl(cpu_cfar, cpu_gpr[gprn]);
> +    tcg_gen_mov_i64(cpu_cfar, cpu_gpr[gprn]);
>  }
>  
>  /* Breakpoint */


