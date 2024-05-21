Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416B8C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 16:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ShW-0000Jj-4L; Tue, 21 May 2024 12:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9ShT-0000JB-8N; Tue, 21 May 2024 12:50:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9ShR-0002Pe-D3; Tue, 21 May 2024 12:50:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LGFHCh003967; Tue, 21 May 2024 16:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=+vRfK8/hbW52rTD6ztEsJoV8R++jm11hriegJQQTgm8=;
 b=srb076Luy1SR6Jg1yxq4oVKksxaMCrkhrZtXKdkd44BAqnmFsGdvaIGD5XK+O7G1WXOH
 rRjrAN+qpBXmClui9/6K7u1d9HMW0m/oRtGZIZHXRWhTLyH5N7QJUcgvkqqR3mj32bh4
 DOvm9Ag0rhsB5UfQsAZL0acq8lxpKICK3XgdTW+FsDmK6MhyXWpA/XB8s2nKpXFV6iRs
 QlHhxgz0HFd2YakuM8TmcrcL0EDw1o3uIqW9Jkum3g0/Y1e/oDK4JGS2mmRLhrOEsz7l
 ylCfXL+7TBZaxjLJap59EfFdCFFt6ovhwsnC4sg0weE4fKC1sWXbCDwzNkr2Fx+FxhO1 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8xxv8414-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:50:51 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LGoodd031573;
 Tue, 21 May 2024 16:50:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8xxv8412-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:50:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LEXRfE026478; Tue, 21 May 2024 16:50:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785meqjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:50:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LGolou49873306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 16:50:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 499CE5806A;
 Tue, 21 May 2024 16:50:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 226A558067;
 Tue, 21 May 2024 16:50:47 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 16:50:47 +0000 (GMT)
Message-ID: <657a92dcac64898dc78557fd4ed6c34813ad64b3.camel@linux.ibm.com>
Subject: Re: [PATCH v2 07/12] target/ppc: add helper to write per-LPAR SPRs
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Chinmay Rath
 <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 11:50:46 -0500
In-Reply-To: <20240521013029.30082-8-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-8-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GOZMtA-Fl_nDhGNevaY6EjZyiTxr-8Mz
X-Proofpoint-GUID: PFr2HIHWHPHq_SvicZxoxtF3p69qsp-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=941 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210127
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
> An SPR can be either per-thread, per-core, or per-LPAR. Per-LPAR
> means
> per-thread or per-core, depending on 1LPAR mode.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/spr_common.h |  2 ++
>  target/ppc/translate.c  | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
> index 9e40b3b608..85f73b860b 100644
> --- a/target/ppc/spr_common.h
> +++ b/target/ppc/spr_common.h
> @@ -83,6 +83,8 @@ void spr_read_generic(DisasContext *ctx, int gprn,
> int sprn);
>  void spr_write_generic(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
>  void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn);
> +void spr_core_write_generic32(DisasContext *ctx, int sprn, int
> gprn);
> +void spr_core_lpar_write_generic(DisasContext *ctx, int sprn, int
> gprn);
>  void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 137370b649..c688551434 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -535,6 +535,34 @@ void spr_core_write_generic(DisasContext *ctx,
> int sprn, int gprn)
>      spr_store_dump_spr(sprn);
>  }
>  
> +void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn)
> +{
> +    TCGv t0;
> +
> +    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
> +        spr_write_generic32(ctx, sprn, gprn);
> +        return;
> +    }
> +
> +    if (!gen_serialize(ctx)) {
> +        return;
> +    }
> +
> +    t0 = tcg_temp_new();
> +    tcg_gen_ext32u_tl(t0, cpu_gpr[gprn]);
> +    gen_helper_spr_core_write_generic(tcg_env,
> tcg_constant_i32(sprn), t0);
> +    spr_store_dump_spr(sprn);
> +}
> +
> +void spr_core_lpar_write_generic(DisasContext *ctx, int sprn, int
> gprn)
> +{
> +    if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
> +        spr_core_write_generic(ctx, sprn, gprn);
> +    } else {
> +        spr_write_generic(ctx, sprn, gprn);
> +    }
> +}
> +
>  static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
>  {
>      /* This does not implement >1 thread */


