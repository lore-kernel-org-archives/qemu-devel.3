Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4D3CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEpdi-0006fl-6V; Thu, 08 Oct 2026 11:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEpdb-0006eS-AU; Thu, 08 Oct 2026 11:02:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEpdX-0005kB-Ru; Thu, 08 Oct 2026 11:02:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EZaFN1614859; Thu, 8 Oct 2026 15:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=0OWxaAn9CfZaghcr+qeZbFg/V6ncXwoD7CH4kJPou7s=; b=hnrRykcJnoH6
 ccQdWS1oE7yf9O4OuO9pW/iK0UL2sN1SdRBUb0IZ39OE+jzj2AFdK8wCppXU8AKG
 d24Lh6qUOV0qPcJseF7PC3T1cyhdzTCRwiTT87lzZGrmYVygkenIvsPHDnzxgJDG
 2RAB5VW/puyDBh6ZVECoxrBT5o9jJr3BBpRb2Ei4mDy+z+MMnopsG1A/+F+9VB1F
 D391+z4ylk2kkpKNbWpdAi4pOgFkow+ydnHVyRskinC1TSOl2eT6vBiLaneoDjSM
 lDwg5xlNmWnEgM1fGlS8Izv8YV147VuKBnvj5HMFshaokbULG5+aN+lcujkZFSV+
 00h/GDzQ0Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvm67u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 15:02:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EXf6D3636939; Thu, 8 Oct 2026 15:02:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh3p46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 15:02:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698F2HqP25428630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 15:02:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1039758063;
 Thu,  8 Oct 2026 15:02:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D30A58060;
 Thu,  8 Oct 2026 15:02:16 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 15:02:16 +0000 (GMT)
Message-ID: <4e558b6e13f4ab9f3970294911138d6978a1098d.camel@linux.ibm.com>
Subject: Re: [PATCH 04/10] target/ppc: Factor ppc_env_is_64bit() out
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org, Yonggang Luo
 <luoyonggang@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:02:16 -0500
In-Reply-To: <20261007232326.66240-5-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
 <20261007232326.66240-5-philmd@oss.qualcomm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: YyIG5dVCd90lNhUatYeEBZ99Flbxrc8G
X-Proofpoint-ORIG-GUID: CJbijbOKLpmx2rU93dxAnw6pJyp6-z6I
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac7b07b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=CoDvO8Mup1ZAVdhail0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OCBTYWx0ZWRfX7p49zveoYX1s
 Bk0md1ZU8uoNw9GL0fVvKn5uBjcsCabJwje3hO8YpsszhYozT0x3twkoyWsXYLmhv10yT6Vra6P
 NkI8pWgr5XfSeZOmTH5c/Fh8O6EMYvg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OCBTYWx0ZWRfX8uHh0iDPy6Eg
 grNMqnjZdNeUNwgDe5aoF7XXgMAhrbdu1MORDZU56mjcrWEE9WG6xYrZ+twvt3ImGYm17xnVFiA
 N+f3lHYwTkaoRHaE6pk/sjoWecM/xJhE9A1kVssqEbJ78qASsTl+lEZesB6u0RrcstDBCCgooyk
 PSYVxBjtJVyhxTrt3UjJi6tNJ542i7C5SCFx2PqIT5+gmfM0DAsimB5vKL8wgoKDe1kB4FH2Gt2
 OC+Jdn14Ren0kq/M6HKaWVj9oRP9KZUUbLjhIZnIuQSH0bmn08v6Lu1laNbZN9T4dfR/Qj/MO5x
 sZBCkcMtBeJcXebucsGGWiLD5EVB/sGip76xbcni4qQPvmAiRIJLgP+1wOEX/chI0QtWg67lE4x
 +rlmPcYgBqEz1ksHs7HdkUSCAvWQPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610020000 definitions=main-2610080058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-10-08 at 01:23 +0200, Philippe Mathieu-Daudé wrote:
> Replace the open-coded PPC_64B test in register_BookE206_sprs()
> by a ppc_env_is_64bit() helper for re-use in the next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/ppc/internal.h | 11 +++++++++++
>  target/ppc/cpu_init.c |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index a20a0f9f7e0..11476692616 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -23,6 +23,17 @@
>  #include "hw/core/registerfields.h"
>  #include "exec/page-protection.h"
>  
> +/**
> + * ppc_env_is_64bit:
> + * @env: the cpu context
> + *
> + * Return whether the CPU is a 64-bit implementation.
> + */
> +static inline bool ppc_env_is_64bit(const CPUPPCState *env)
> +{
> +    return env->insns_flags & PPC_64B;
> +}
> +
>  static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
>  {
>      return FIELD_EX64(env->msr, MSR, LE);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index b711f9c0a85..a43ef47acd2 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -869,7 +869,7 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
>              spr_register(env, mas_sprn[i], mas_names[i],
>                           SPR_NOACCESS, SPR_NOACCESS,
>                           &spr_read_generic,
> -                         (i == 2 && (env->insns_flags & PPC_64B))
> +                         (i == 2 && ppc_env_is_64bit(env))
>                           ? &spr_write_generic : &spr_write_generic32,
>                           0x00000000);
>          }


