Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82F9C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 22:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Y5C-0003Qh-Bn; Tue, 21 May 2024 18:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y5B-0003QT-8N
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:35:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y56-0007ZZ-RB
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:35:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LAoGJ0008814;
 Tue, 21 May 2024 22:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=+PlZCmbeWr20wmK46lkHW/av5wNapOOz1s1kOZ0vaII=; b=j+
 qDd/e2zUo6KPT1G7aPJCPTNCm6zz7djNemHls4CLHwbXjPxfY2QbdHextF3eAewK
 WYXEj/iAXeHGsn76r4MRFrENTCHZ9NtsyPm3jfm5PkPMAFudLoeeNCBPxwiYX78K
 k64jauvKb8Jb6nNnhFCTOnRIPaKmO6ArLVf7aMquVcGowBMxf9jMpI84F7XFLk+C
 dQ9CEuNZbMMfh6DO1Cno0MttbG7qdEy3nR6zzfC/YxJfm3qHaDde6v8/StjSFOxW
 fBsLURw8t38mRS8+oh1Vzis2nbp58DflfiaRQm1R1VYgx4FYfW7VUEigpkvh3AIV
 fFNIFHp30k0rvDblToFg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gf67p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:35:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44LMZb5Z019740
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:35:37 GMT
Received: from [10.110.25.190] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 15:35:36 -0700
Message-ID: <f63275f8-fdca-4ee2-9923-04f451a73ad6@quicinc.com>
Date: Tue, 21 May 2024 17:35:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] target/hexagon: idef-parser fix leak of init_list
To: Anton Johansson <anjo@rev.ng>, <qemu-devel@nongnu.org>
CC: <ale@rev.ng>, <ltaylorsimpson@gmail.com>, <bcain@quicinc.com>
References: <20240521201654.25851-1-anjo@rev.ng>
 <20240521201654.25851-4-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240521201654.25851-4-anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: uKaFVqDwxPlVZLn9yybS1yF2SZZHKoSN
X-Proofpoint-ORIG-GUID: uKaFVqDwxPlVZLn9yybS1yF2SZZHKoSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_13,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
> gen_inst_init_args() is called for instructions using a predicate as an
> rvalue. Upon first call, the list of arguments which might need
> initialization init_list is freed to indicate that they have been
> processed. For instructions without an rvalue predicate,
> gen_inst_init_args() isn't called and init_list will never be freed.
>
> Free init_list from free_instruction() if it hasn't already been freed.
> A comment in free_instruction is also updated.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <bcain@quicinc.com>

>   target/hexagon/idef-parser/parser-helpers.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
> index 95f2b43076..c150c308be 100644
> --- a/target/hexagon/idef-parser/parser-helpers.c
> +++ b/target/hexagon/idef-parser/parser-helpers.c
> @@ -2121,9 +2121,16 @@ void free_instruction(Context *c)
>           g_string_free(g_array_index(c->inst.strings, GString*, i), TRUE);
>       }
>       g_array_free(c->inst.strings, TRUE);
> +    /*
> +     * Free list of arguments that might need initialization, if they haven't
> +     * already been freed.
> +     */
> +    if (c->inst.init_list) {
> +        g_array_free(c->inst.init_list, TRUE);
> +    }
>       /* Free INAME token value */
>       g_string_free(c->inst.name, TRUE);
> -    /* Free variables and registers */
> +    /* Free declared TCGv variables */
>       g_array_free(c->inst.allocated, TRUE);
>       /* Initialize instruction-specific portion of the context */
>       memset(&(c->inst), 0, sizeof(Inst));

