Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C82C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 16:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s95nm-0004tQ-Kb; Mon, 20 May 2024 12:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s95nf-0004qf-9Q
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:23:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s95lq-0003e7-8t
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:23:44 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KCNorJ009728;
 Mon, 20 May 2024 16:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=8KJjiTz5cUcdHAJQ7wjJCrFcdJ1KyZ7q/8IJMz8o2CQ=; b=So
 rLOTzPTXV6zBTUjQYaWuVELFIzIo1z+S+MDrj4y6esRr32C/Oru2UYfhmhzw+lBO
 mTrkitxDiQ5keYlVDDVyYdb0ljzB60sJrp6dMFaa4Lfu03RBCtzzGlNXI8mVA64t
 5AvQqoFM8QLrz3VzH0NkMGQXXHUEhiS8E9gixe9NTcYow6U1Se60P43BYk+MuEhC
 H1s36qb7oRdbmP4jXS74TFAtO1d1JWtm7ZxA1xZsPz0F+u1JpaQj6iEu3zM3oBU2
 z7L9rtJSpsYU1cmvoWY6RcMvfApKG+NNge2xi6ZmpCE8DIvjvmhhD2GvjflciE4Z
 VK6hq8UZr/hJcjeSEWdw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gbtkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 16:21:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KGLkbj005101
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 16:21:46 GMT
Received: from [10.110.110.43] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 09:21:45 -0700
Message-ID: <753805ab-eac8-4c8c-9997-fa73c61e08ed@quicinc.com>
Date: Mon, 20 May 2024 11:21:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon: fix HVX store new
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
CC: <ltaylorsimpson@gmail.com>, <sidneym@quicinc.com>, <bcain@quicinc.com>,
 <richard.henderson@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <f548dc1c240819c724245e887f29f918441e9125.1716220379.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <f548dc1c240819c724245e887f29f918441e9125.1716220379.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 2MKZkGZEp6IzksYAszstuedLAM3O-gqT
X-Proofpoint-ORIG-GUID: 2MKZkGZEp6IzksYAszstuedLAM3O-gqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
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


On 5/20/2024 10:53 AM, Matheus Tavares Bernardino wrote:
> At 09a7e7db0f (Hexagon (target/hexagon) Remove uses of
> op_regs_generated.h.inc, 2024-03-06), we've changed the logic of
> check_new_value() to use the new pre-calculated
> packet->insn[...].dest_idx instead of calculating the index on the fly
> using opcode_reginfo[...]. The dest_idx index is calculated roughly like
> the following:
>
>      for reg in iset[tag]["syntax"]:
>          if reg.is_written():
>              dest_idx = regno
>              break
>
> Thus, we take the first register that is writtable. Before that,
> however, we also used to follow an alphabetical order on the register
> type: 'd', 'e', 'x', and 'y'. No longer following that makes us select
> the wrong register index and the HVX store new instruction does not
> update the memory like expected.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---


Reviewed-by: Brian Cain <bcain@quicinc.com>


>   tests/tcg/hexagon/hvx_misc.c      | 23 +++++++++++++++++++++++
>   target/hexagon/gen_trans_funcs.py |  9 ++++++---
>   2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c
> index 1fe14b5158..90c3733da0 100644
> --- a/tests/tcg/hexagon/hvx_misc.c
> +++ b/tests/tcg/hexagon/hvx_misc.c
> @@ -474,6 +474,27 @@ static void test_vcombine(void)
>       check_output_w(__LINE__, BUFSIZE);
>   }
>   
> +void test_store_new()
> +{
> +    asm volatile(
> +        "r0 = #0x12345678\n"
> +        "v0 = vsplat(r0)\n"
> +        "r0 = #0xff00ff00\n"
> +        "v1 = vsplat(r0)\n"
> +        "{\n"
> +        "   vdeal(v1,v0,r0)\n"
> +        "   vmem(%0) = v0.new\n"
> +        "}\n"
> +        :
> +        : "r"(&output[0])
> +        : "r0", "v0", "v1", "memory"
> +    );
> +    for (int i = 0; i < MAX_VEC_SIZE_BYTES / 4; i++) {
> +        expect[0].w[i] = 0x12345678;
> +    }
> +    check_output_w(__LINE__, 1);
> +}
> +
>   int main()
>   {
>       init_buffers();
> @@ -515,6 +536,8 @@ int main()
>   
>       test_vcombine();
>   
> +    test_store_new();
> +
>       puts(err ? "FAIL" : "PASS");
>       return err ? 1 : 0;
>   }
> diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
> index 9f86b4edbd..30f0c73e0c 100755
> --- a/target/hexagon/gen_trans_funcs.py
> +++ b/target/hexagon/gen_trans_funcs.py
> @@ -89,6 +89,7 @@ def gen_trans_funcs(f):
>   
>           new_read_idx = -1
>           dest_idx = -1
> +        dest_idx_reg_id = None
>           has_pred_dest = "false"
>           for regno, (reg_type, reg_id, *_) in enumerate(regs):
>               reg = hex_common.get_register(tag, reg_type, reg_id)
> @@ -97,9 +98,11 @@ def gen_trans_funcs(f):
>               """))
>               if reg.is_read() and reg.is_new():
>                   new_read_idx = regno
> -            # dest_idx should be the first destination, so check for -1
> -            if reg.is_written() and dest_idx == -1:
> -                dest_idx = regno
> +            if reg.is_written():
> +                # dest_idx should be the first destination alphabetically
> +                if dest_idx_reg_id is None or reg_id < dest_idx_reg_id:
> +                    dest_idx = regno
> +                    dest_idx_reg_id = reg_id
>               if reg_type == "P" and reg.is_written() and not reg.is_read():
>                   has_pred_dest = "true"
>   

