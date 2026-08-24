Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01075C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVtn-0002B6-VC; Mon, 24 Aug 2026 10:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVtm-0002Ac-8r; Mon, 24 Aug 2026 10:43:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVtj-0007mM-Bp; Mon, 24 Aug 2026 10:43:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1g4h826856; Mon, 24 Aug 2026 14:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=wea+D3URXOMjpwCeWiHu1E5QdX+jNshXMsI5ZCcbZyE=; b=ZdS45mZ4bqzU
 GbidEKU8iKZ55LfFhIwnutUGUJVmmGP1fFU4YAZy7AGduZbjeX1EdU2Wg600m2DL
 hOYOJ2z6PGCbre0ry1cYVdWtA7u4l/6xWIR2u0NdubPf0O6Cl73Qj8auEgyq3wcZ
 89JpjEeIwK5Ts5xezhN1JRQDkZ2tNCgRCnVvYMNuEquzbXgrLOR9OMO2IjO78Wra
 wCX7dHS1orAgamnFhjlCeX8bZOBPrfq/dKhQz3wYVSnoT40wibdDqdiNhG1f39yN
 rC8wDswkOHcxWEQQhQjf3byqweNGZP08b7P1U4rltFWW8CgD2QjYNs/9PtVYoRGh
 IqVe0XuDOQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ea2cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:43:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEfMov017394;
 Mon, 24 Aug 2026 14:43:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgxgf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:43:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEhY5C29884988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:43:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10B6358059;
 Mon, 24 Aug 2026 14:43:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 412B15805D;
 Mon, 24 Aug 2026 14:43:33 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:43:33 +0000 (GMT)
Message-ID: <6cd6cb4df044fa2298334aa65afbc0df033ffac7.camel@linux.ibm.com>
Subject: Re: [PATCH 16/29] target/ppc: Fix TRANS* macro variadic arguments
 handling
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:43:32 -0500
In-Reply-To: <20260820140114.327023-17-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-17-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c5899 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=MMZzG85PMr-jjKs7zPEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX6EP2WJQyIql+
 WmhI/py2kMLgIqz89DvtYWVG4jmDvx0ZnQhj7eNgb3CqWAxa7wI+QkvvBL2EL1vKaGYL4qGAeX2
 AxVUV5zcYGMVpjplKeHGhOzU2X2W/MU=
X-Proofpoint-GUID: FUNWTblyxS2tEhd9AGZK2k18H_fEZY7T
X-Proofpoint-ORIG-GUID: QSe-GS4batqhWhvZR2pWdLJc3Cxy4H_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXwQnHYqS9nRRM
 pvGoHeWEcsnuyBCuq3TofdslBbzu6U2tcf6pl1P1WEpGNjx6zuBF4v6qJg+rbMsWRoJeKI8tiOj
 fSKb+X4WEY5PoSls9W3d3guOTdIl/KDzuDCD4zi2RzNUbmcwfoiVdN3u6Vv4pleFSd4jAUuQPdQ
 CMXJB/LE8a/vtwYXdsr8LQC/ShNp6vsCGC6BT7EVuyIsxVIxiH6etvXaCaFuofOr9/Y8XkqrSQJ
 jd3kIBj82bEHn2/w5vfpB+pIS84dIc0OpRJHSGyR1bbX1btZmBKg858WPl8TIxkWNHG4gQATzUB
 h6hNNS/KgKHFO4tEzsYfcAZaIKciXCeCSrQxSNkbb9eHz0emETB+51mDHMQAt2Y064pLC6mlDkh
 1Xv+OUF71DzZpV8W9Z0B3ppnChHZhZRNxXCN6j5aZE6It0aI/QBB9eR2EfS7zLf0mR3UrhVNnR1
 JxKGDc/YzC3IZ3ezVwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122
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

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Use ##__VA_ARGS__ in TRANS* macros to allow variadic arguments to be
> optional instead of mandatory. "##" removes the preceding comma when
> __VA_ARGS__ is empty, enabling macros to work with functions that don't
> need extra parameters.
> 
> This avoid compilation errors when using a pattern like below:
> 
>   static bool do_wait(DisasContext *ctx, arg_X_wait *a)
>   {...}
> 
>   TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)
> 
> Compilation Error:
> ../target/ppc/translate.c:5526:40: error: expected expression before ‘)’ token
>  5526 |         return FUNC(ctx, a, __VA_ARGS__);                      \
>       |                                        ^
> ../target/ppc/translate/storage-ctrl-impl.c.inc:368:1: note: in expansion of macro ‘TRANS_FLAGS’
>   368 | TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/translate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 7100787a25..f7c7f53d82 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4719,29 +4719,29 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
>   */
>  #define TRANS(NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
> -    { return FUNC(ctx, a, __VA_ARGS__); }
> +    { return FUNC(ctx, a, ##__VA_ARGS__); }
>  #define TRANS_FLAGS(FLAGS, NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
>      {                                                          \
>          REQUIRE_INSNS_FLAGS(ctx, FLAGS);                       \
> -        return FUNC(ctx, a, __VA_ARGS__);                      \
> +        return FUNC(ctx, a, ##__VA_ARGS__);                    \
>      }
>  #define TRANS_FLAGS2(FLAGS2, NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
>      {                                                          \
>          REQUIRE_INSNS_FLAGS2(ctx, FLAGS2);                     \
> -        return FUNC(ctx, a, __VA_ARGS__);                      \
> +        return FUNC(ctx, a, ##__VA_ARGS__);                    \
>      }
>  
>  #define TRANS64(NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
> -    { REQUIRE_64BIT(ctx); return FUNC(ctx, a, __VA_ARGS__); }
> +    { REQUIRE_64BIT(ctx); return FUNC(ctx, a, ##__VA_ARGS__); }
>  #define TRANS64_FLAGS2(FLAGS2, NAME, FUNC, ...) \
>      static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
>      {                                                          \
>          REQUIRE_64BIT(ctx);                                    \
>          REQUIRE_INSNS_FLAGS2(ctx, FLAGS2);                     \
> -        return FUNC(ctx, a, __VA_ARGS__);                      \
> +        return FUNC(ctx, a, ##__VA_ARGS__);                    \
>      }
>  
>  /* TODO: More TRANS* helpers for extra insn_flags checks. */


