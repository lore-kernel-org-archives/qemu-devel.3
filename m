Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71280C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFard-0007dm-2I; Thu, 15 May 2025 11:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFar0-0006rR-ML; Thu, 15 May 2025 11:50:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaqy-00072S-0r; Thu, 15 May 2025 11:50:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgBY6004852;
 Thu, 15 May 2025 15:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RhuEZD
 cPQ+DgIO8V2WL8y1IM7Hi8tTwDx9hL/+2K8vU=; b=PAlMmhJYPm0ozixNE8p+v7
 DPQSoOmfIHd0Sqw0QtsVvffUIf7g02Cdil5dvOdmqBS/VRyeHJHEIbymUTYZ2oyl
 i2ZLLKYh7c1JWP4y1MKvzXdJ3NEkvtOf9NSO25kqGPoV/SI6CBmCZ4vbPIFbN+Tn
 tiecUQsUqiYrEWLL2/w3P9y4wZ4VSIatxOZJaIGM30hQaqyVK1taJq4daTaLM9Ym
 Tl88uxU9ffiRx/lHo9/71ZnycTws34P5DDe1NVpom4Yag4NiKzrPfFnCa542jY+7
 xYd7MO/QP1baxQXQHGfjpOQks7jzf3Ad2IML6d21fTm9PI+JKQdV83ggcf5LKD+g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt37s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFhdxp022345;
 Thu, 15 May 2025 15:50:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt37r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE0HTP019386;
 Thu, 15 May 2025 15:50:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfru27w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFoTfG35193290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:50:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70AC258058;
 Thu, 15 May 2025 15:50:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D92558057;
 Thu, 15 May 2025 15:50:29 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:50:29 +0000 (GMT)
Message-ID: <c96c741f-51b7-481f-a1f3-68251013bcf7@linux.ibm.com>
Date: Thu, 15 May 2025 10:50:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/50] ppc/xive2: Implement POOL LGS push TIMA op
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-48-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-48-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WH-Ub6L_c66Yx2EXidzf-lXzug6YjY6C
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=68260d48 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=F6GhtudbdRW5Ju_cDBcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6AIRmrBXeSwxfy86GJKvNlVlUYre9N-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX35jvadzdLUg6
 gUNALJmtmPpn5v/JkNCoMqs29oqgz3rraQ9kZXi0CocG8lj6RRkO0tQ1ahL2dWHFor0xXg7wD8N
 yOJgZN3PdIUiRX4HjUMBvzADxO4uMLj4x+9qyfdR158jh9u9t8C7SHwYv4+S0vpGfHxkNwZNCWY
 gm0VORs6Q/m9iW0IXT4ivrnqlf2anKBfKB+VWoRXOWxJ+U7dt+X7p1tGfHu1pmYTKEnrrSGyLK+
 sGykcUMlJo0WNE5XRqTzUcCPOJUGlrada5VOlHBv0pOE/vFYCm50H/TtodmUI5l3Uvm7raxl+gi
 E6Uwt/VIZw8oer9zL5SleLGn3KLMNmnfsYFbVkTAoo4eSHLmalCduiv7+wPFcElCzrOwsLUGbwe
 VptNaGsOab57WlolhgpwKyiL7n787k7Tz9C/1QM9LM+IknkpPGpJX7SjGqsORa+9lWmpj0BJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Implement set LGS for the POOL ring.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index dc64edf13d..807a1c1c34 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -532,6 +532,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
>       xive_tctx_set_lgs(tctx, TM_QW1_OS, value & 0xff);
>   }
>   
> +static void xive_tm_set_pool_lgs(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive_tctx_set_lgs(tctx, TM_QW2_HV_POOL, value & 0xff);
> +}
> +
>   /*
>    * Adjust the PIPR to allow a CPU to process event queues of other
>    * priorities during one physical interrupt cycle.
> @@ -737,6 +743,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>         xive2_tm_push_pool_ctx, NULL },
>       { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 8, true, true,
>         xive2_tm_push_pool_ctx, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_LGS,   1, true, true,
> +      xive_tm_set_pool_lgs, NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
>         xive2_tm_set_hv_cppr, NULL },
>       { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,

