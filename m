Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCA5CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwdco-00047g-2r; Thu, 11 Sep 2025 05:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uwdck-000471-4U; Thu, 11 Sep 2025 05:29:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uwdcg-0001ST-DJ; Thu, 11 Sep 2025 05:29:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALJdmD023376;
 Thu, 11 Sep 2025 09:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=428OOm
 Ckxvu5WQweL2ujU+fa26PQ4McB1IjXizMhyjA=; b=TTxQ+53ZUnyZIq/gfpBCWS
 ZrZwWVdBDmoYOfiymjgSwfYxSS1YqgkevYxO5KWKFL6PmY3CxwNfbiWthtjjklsw
 0VD+WB9zvGnYj7OIw9jg+oG7YEMkIgm418U5aZltg//g9BkuhA+1dcRrahajnhUD
 4Oebm7hu5h8Elrk5MTRDC9GVYf6DKg9D40tN/PY8IcLLMD1UqBQzedUouqT5fi50
 Awy9d/rlQcUQU5D/6IeHDYVHu1+R+KQ7jaP569bX/3pq0HqIRgcdd/fw04/WXit/
 c5rexC83qkN9DNbyA8p1w5igk6Rl0AnXSioN+q5rdkFT6IPPwGPYzWwaK12qSI2Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx3q36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 09:29:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58B9Tb9N029319;
 Thu, 11 Sep 2025 09:29:37 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx3q2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 09:29:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B6XESt017188;
 Thu, 11 Sep 2025 09:29:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmmv9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 09:29:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58B9Ta2h19333688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Sep 2025 09:29:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15F3D5804E;
 Thu, 11 Sep 2025 09:29:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA66158054;
 Thu, 11 Sep 2025 09:29:33 +0000 (GMT)
Received: from [9.79.201.141] (unknown [9.79.201.141])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 11 Sep 2025 09:29:33 +0000 (GMT)
Message-ID: <768c783a-7165-482e-aa28-86430a4527a9@linux.ibm.com>
Date: Thu, 11 Sep 2025 14:59:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/ppc: Move floating-point compare instructions
 to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com
Cc: harshpb@linux.ibm.com
References: <20250619095840.369351-1-rathc@linux.ibm.com>
 <20250619095840.369351-3-rathc@linux.ibm.com>
 <7857ae80-63eb-4d18-9618-d6c94cdd0c17@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <7857ae80-63eb-4d18-9618-d6c94cdd0c17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XfjiId251xdZz6vx23J-Zxou4pOuYk1c
X-Proofpoint-ORIG-GUID: tq3zw7C5T0h6VtprZubydX1quvjGLZS_
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c29682 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=mR2v0fqNRR0weItYsYIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXzS1JBxdFF2/n
 WKW9q4KcJemP0BDs5oJgvvUDk6ej5TnxKI1Q3wtnyijSKte3yPlUcJyGBIGe3dr9uAC+ltevpfX
 VL2ImLng62Z3fwiZ50zGeLRwBkuvKeOcAAWr5szzywN6V9C7qI1ej3Vek7pKGPVP4sLp0OFSJyh
 V8x2vf1uw8BDW1tuU9Lt+AV26Df9zjnMVdJz9HZ6xf+yuy9Ifj8mQ+SSMFlMMYPscB+vwc6Hnk7
 aUO+lVL547fICe+DJ165Q0wS/HsROtMr6YSYVpMx9+xCj3Usx9fcTxBI6m1oNkgu4f6pGMRC/2v
 mf82n77m2Ik58OKfZKCYOapnIhnTMuo30OLcShzOOCHNmgjhd/jV2jbqrvKrLsrTmy594Acetnl
 qfhXmhHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 8/27/25 12:49, Richard Henderson wrote:
> On 6/19/25 19:58, Chinmay Rath wrote:
>> +static bool do_helper_cmp(DisasContext *ctx, arg_X_bf *a,
>> +                          void (*helper)(TCGv_env, TCGv_i64, TCGv_i64,
>> +                                         TCGv_i32))
>> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
>
> ...
>
>> +TRANS(FCMPU, do_helper_cmp, gen_helper_FCMPU);
>> +TRANS(FCMPO, do_helper_cmp, gen_helper_FCMPO);
>
> It's probably better to standardize on TRANS_FLAGS even though the 
> flags checked is the same for both of these.
>
Hi Richard,

I did notice in the code that there are quite many instructions using 
TRANS and doing flag check in the common helper.
For example, in target/ppc/translate/fixedpoint-impl.c.inc :

/static bool do_set_bool_cond(DisasContext *ctx, arg_X_bi *a, bool neg, 
bool rev)
{
     REQUIRE_INSNS_FLAGS2(ctx, ISA310);
     uint32_t mask = 0x08 >> (a->bi & 0x03);
     ....
     return true;
}

TRANS(SETBC, do_set_bool_cond, false, false)
TRANS(SETBCR, do_set_bool_cond, false, true)
TRANS(SETNBC, do_set_bool_cond, true, false)
TRANS(SETNBCR, do_set_bool_cond, true, true)
/

Do we want to standardize the use of TRANS_FLAGS in all such existing 
insns ?

I can send a followup patch doing the same for such insns (including the 
ones in this patch)

Thanks,

Chinmay

> But anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~

