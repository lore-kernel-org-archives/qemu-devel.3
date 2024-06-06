Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21E0C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3cG-00009z-6d; Wed, 05 Jun 2024 23:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sF3cD-00009j-TS
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:16:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sF3c9-0001xm-Ia
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:16:37 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455KIUTW004347;
 Thu, 6 Jun 2024 03:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a3RqT8GympcQ1EiiJuK7SSGHi0tBI+kVJ+01wsrRFYM=; b=KVpIB4ZnpPWfG9CV
 uGjyJd3abHnXL2LO7NQMwrBZqaM0tD/39qIsEf6JZwGaShHbCnYdpgQuPbwUUqeT
 XFNkQwagtAzw81cPYl1itrpecrNQsY+xvnO4UN9Ry4WqSJx78oDxS/gTlqscX5d2
 XfcwPeuw7K0MlCgcOUN8082wC4UcPrVvSNZ4o61mqWWCVpGB2jasYreja5O5iJzi
 ORi1iryKKTpJ0iepNAl7RW1t9EKM5cmPV+ku3cM/j2QkNLd5NjgeGD4RzLZx+27H
 aC/Sf2DWmjQC7lT19KEbdsDt3NdlTmFEWwrKS7ROq36gbBRTl76CLEQdEAfEF4a5
 OD5CZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjxxarm4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 03:16:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4563GTeN013137
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 6 Jun 2024 03:16:29 GMT
Received: from [10.110.55.133] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 20:16:28 -0700
Message-ID: <302a6103-7783-4b4a-b700-4ca0504f7a6d@quicinc.com>
Date: Wed, 5 Jun 2024 22:16:27 -0500
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
X-Proofpoint-ORIG-GUID: BVQHGWfLdL7HRLBHqV3B8tf-226Ua3Mp
X-Proofpoint-GUID: BVQHGWfLdL7HRLBHqV3B8tf-226Ua3Mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued -- at https://github.com/quic/qemu/tree/hex.next


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

