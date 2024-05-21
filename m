Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83551C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 22:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Y6S-0005Gn-3N; Tue, 21 May 2024 18:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y6Q-0005GL-7t
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:37:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y6O-0007hb-Fh
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:37:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LF5G9b015385;
 Tue, 21 May 2024 22:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=2trKOoIQb5am7u7PwPBHFLnWl43ktT9+sISyN4X2gik=; b=V+
 0/PTvyRMeT66coBuAQPWnv+1z29yJPHvJUue+R9IU6yISEzFWO2jh5YWty2DcXdZ
 22rBKsF95hI0PoxLK5nAu2priSex8w6+2/A0JGaqzi84F7Nq8x5un+Xd191svNaW
 LMvjB3j/ruBT3v4QXKqkBVcTBaUTmSoINjoUDbVl0BnvuWjBmm2t1pxuEL8MySBf
 HedT8krynBqQk36tJ2/uixeTluu/DEtkL4JtX4DxKanWn+NjD+L4ZNZKWpkx9Nt+
 rihvqohez83S91Fk4lPju4UkHRFeABbwDa4Y5Rchf3fdiU3iAf2tLVDw9pfMyqRU
 orse7CXnD5BMtgtQ2Z1g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqc706w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:36:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44LMavtb029973
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:36:57 GMT
Received: from [10.110.25.190] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 15:36:56 -0700
Message-ID: <aefe78aa-2142-4965-a075-d0caae101692@quicinc.com>
Date: Tue, 21 May 2024 17:36:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] target/hexagon: idef-parser simplify predicate init
To: Anton Johansson <anjo@rev.ng>, <qemu-devel@nongnu.org>
CC: <ale@rev.ng>, <ltaylorsimpson@gmail.com>, <bcain@quicinc.com>
References: <20240521201654.25851-1-anjo@rev.ng>
 <20240521201654.25851-5-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240521201654.25851-5-anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: K58g8mec2G4896NpwQwFvHTjjEpwUJE8
X-Proofpoint-GUID: K58g8mec2G4896NpwQwFvHTjjEpwUJE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_14,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxlogscore=933 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/21/2024 3:16 PM, Anton Johansson via wrote:
> Only predicate instruction arguments need to be initialized by
> idef-parser. This commit removes registers from the init_list and
> simplifies gen_inst_init_args() slightly.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <bcain@quicinc.com>

>   target/hexagon/idef-parser/idef-parser.y    |  2 --
>   target/hexagon/idef-parser/parser-helpers.c | 26 +++++++++++----------
>   2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/hexagon/idef-parser/idef-parser.y b/target/hexagon/idef-parser/idef-parser.y
> index cd2612eb8c..9ffb9f9699 100644
> --- a/target/hexagon/idef-parser/idef-parser.y
> +++ b/target/hexagon/idef-parser/idef-parser.y
> @@ -233,8 +233,6 @@ code : '{' statements '}'
>   argument_decl : REG
>                   {
>                       emit_arg(c, &@1, &$1);
> -                    /* Enqueue register into initialization list */
> -                    g_array_append_val(c->inst.init_list, $1);
>                   }
>                 | PRED
>                   {
> diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
> index c150c308be..a7dcd85fe4 100644
> --- a/target/hexagon/idef-parser/parser-helpers.c
> +++ b/target/hexagon/idef-parser/parser-helpers.c
> @@ -1652,26 +1652,28 @@ void gen_inst(Context *c, GString *iname)
>   
>   
>   /*
> - * Initialize declared but uninitialized registers, but only for
> - * non-conditional instructions
> + * Initialize declared but uninitialized instruction arguments. Only needed for
> + * predicate arguments, initialization of registers is handled by the Hexagon
> + * frontend.
>    */
>   void gen_inst_init_args(Context *c, YYLTYPE *locp)
>   {
> +    HexValue *val = NULL;
> +    char suffix;
> +
> +    /* If init_list is NULL arguments have already been initialized */
>       if (!c->inst.init_list) {
>           return;
>       }
>   
>       for (unsigned i = 0; i < c->inst.init_list->len; i++) {
> -        HexValue *val = &g_array_index(c->inst.init_list, HexValue, i);
> -        if (val->type == REGISTER_ARG) {
> -            /* Nothing to do here */
> -        } else if (val->type == PREDICATE) {
> -            char suffix = val->is_dotnew ? 'N' : 'V';
> -            EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,
> -                      val->pred.id, suffix);
> -        } else {
> -            yyassert(c, locp, false, "Invalid arg type!");
> -        }
> +        val = &g_array_index(c->inst.init_list, HexValue, i);
> +        suffix = val->is_dotnew ? 'N' : 'V';
> +        yyassert(c, locp, val->type == PREDICATE,
> +                 "Only predicates need to be initialized!");
> +        yyassert(c, locp, val->bit_width == 32,
> +                 "Predicates should always be 32 bits");
> +        EMIT_HEAD(c, "tcg_gen_movi_i32(P%c%c, 0);\n", val->pred.id, suffix);
>       }
>   
>       /* Free argument init list once we have initialized everything */

