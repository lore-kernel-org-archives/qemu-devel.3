Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FC5C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaUK-0004Nn-DV; Thu, 15 May 2025 11:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaUJ-0004Nb-Mk; Thu, 15 May 2025 11:27:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFaUE-0003XK-RS; Thu, 15 May 2025 11:27:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgBPL004805;
 Thu, 15 May 2025 15:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kIp3is
 Tli09D2jtvO5D3LlX6OwMPzaO7tjV0AYBO/Do=; b=DPW9v6PL0xKr1whIZxUr2c
 L2LnEISMKp00V4cPIrKzNPui2fmpzsUXBlswao13J+l7zjFTyMwbvKZBX/yRDOg7
 5nogD3MhXzFU1HHDGhUVuShHD8G8VPUjbiCNNojhdNFWC8WH6xSc+8hfPMfap4wi
 uGpjzPeYtnRyRBiYpjQFAHNW+9/WcVwK/bTysU+lYCZ4ofp/cVHrwOFV3Wb/cd6z
 EVS5bsnyN+QYB+jjmqOHxKEB6+ndb+lE+EchsJAi08rugyfP194jpCDsbHadVFse
 a5V7ahb1xoDp1mtdIpZttCwQaNlu1ID2ZDqn99KEBZPUb0a1nETucMSTAQDmys0Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjsxq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:27:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFM2Gg032212;
 Thu, 15 May 2025 15:27:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjsxq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:27:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEGBKV021861;
 Thu, 15 May 2025 15:27:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfptxfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:27:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFQx0926345930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:26:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C69F58061;
 Thu, 15 May 2025 15:26:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40A1758063;
 Thu, 15 May 2025 15:26:59 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:26:59 +0000 (GMT)
Message-ID: <0c63e431-2603-4c4d-a48a-016b7275172f@linux.ibm.com>
Date: Thu, 15 May 2025 10:26:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/50] ppc/xive2: Avoid needless interrupt re-check on
 CPPR set
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-39-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-39-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bB0Ap_NYmc7a07Djp_8se2HK7D7jAZwg
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=682607c6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=g_CFbk5as9EJpEZ9zXwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L_vuor2wXbn8TAuUU1OLskM_7MAXhD-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfXx0ZseS8r60Fk
 PImk4spZg++lQCxo0s+rsbfpk8XZyFsamEu+dcorKQ4EbmdnpvyOncUcFhEPJ26II0goix2Fl5z
 GIcR/VBpiP/1QnAaPI8bQ0nJHDHIFhiJIA1PGzUGhSEj7XZDs9HMXIa+Tx8U/bkOuAhl3CG90ab
 NdpQKBTbXRdeG7KgjEHk6WvA7CVFz0rsJ+XkNbDl2vkbZ2BZbZZK8IPhvUx7EzsIrWA6niCYrxS
 3YONmOK27AIM4bC85uokkXbS4PARh4jI9R+Tuw1rMItjyNDF2nzG/E7/PUU0ByWxkqDLGqFaIMK
 1EMn5RqRMY135R5yqR84IRePHbuJHt7KTUPAbYx2742XT20KvQut9y2gOfdHmew0nIObChuIhtZ
 fGjgVpvqoDXfRS8p8Zbfl21Xd3XdYD7dSt0WaLGS5SsCF5A6JkQIWQ7LvWMUjBPzVYtzt9Ky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=830
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
> When CPPR priority is decreased, pending interrupts do not need to be
> re-checked if one is already presented because by definition that will
> be the highest priority.
>
> This prevents a presented group interrupt from being lost.

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,  MAK
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 0fdf6a4f20..ace5871706 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1250,7 +1250,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t sig_ring, uint8_t cppr)
>       }
>   
>       /* CPPR priority decreased (higher value) */
> -    xive2_tctx_process_pending(tctx, sig_ring);
> +    if (!xive_nsr_indicates_exception(sig_ring, nsr)) {
> +        xive2_tctx_process_pending(tctx, sig_ring);
> +    }
>   }
>   
>   void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,

