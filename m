Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA4FCAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1rAS-0002jZ-So; Thu, 25 Sep 2025 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1v1rAP-0002ha-He; Thu, 25 Sep 2025 14:58:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1v1rAG-000285-0P; Thu, 25 Sep 2025 14:58:07 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PImICC029912;
 Thu, 25 Sep 2025 18:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JW/W1B
 dj3V+Z7Xj/fq5vrZOXCsOYPn6zPcQLEGZJHac=; b=VNlIQptilSZ6j5cfPyR2Vs
 iQuOFvhYYym7We3dPu2bVPIQul9aWePBGxLzyqSLBNtbk6hQKRXF3HJT2clkCdjD
 Rktq+yEj1BU9umUUskQPN1pNP1KcXYTptHSJd+smSJBs7GyPhKbAAwsRtKTAYgKI
 CG0RPkox9rhd6ThjPmFTYamxFd7UJDaE5hihgqb3mnzLDBb2cMVP4XEtdns8kS/M
 btMK9swPNYU2XqFGLrCL6Uj3GQrZabrUiJe+CSw1w5EuI91E2otV7YXrHWOt25vK
 k/DhLfmI5WnU0/mUIfKOo5GagYNNkM5wz0jyJZ2UwuLNaPVde5MyWFEg4ctSsDyw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbag1h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 18:57:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PIvghP017205;
 Thu, 25 Sep 2025 18:57:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbag1h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 18:57:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIJ1pT003435;
 Thu, 25 Sep 2025 18:57:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawkg52q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 18:57:41 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PIve2i24969794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 18:57:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B86B5805C;
 Thu, 25 Sep 2025 18:57:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DE035805D;
 Thu, 25 Sep 2025 18:57:37 +0000 (GMT)
Received: from [9.124.219.9] (unknown [9.124.219.9])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Sep 2025 18:57:37 +0000 (GMT)
Message-ID: <0819f230-54e3-49a4-98c1-9a8ecbad5995@linux.ibm.com>
Date: Fri, 26 Sep 2025 00:27:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] target/ppc: Support for IBM PPE42 MMU
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org
References: <20250918182731.528944-1-milesg@linux.ibm.com>
 <20250918182731.528944-6-milesg@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20250918182731.528944-6-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yoZTJK7VCPXdo72qxzTjlHK_Kciom-BK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX8XLl1hRHm1i6
 HJ0yPJQW7rV5uYPX9fJpEmDuKNbzuUDuUF7kjfCxo88F5lP6A23wz7dko6CmN9goqJdwxDQysIb
 aSCyHFIc0RPCKC0uIOnv8YlhlVmWW1CHQTppT66bqkIzkdjB7QsZfbPSe5u9VHjk88UsIKIPebM
 SS/9u5DJ90i/lwTPkRxVIwoEOXhm1dutSSOPiK9fDvFkpuUO8iOLhJocz1j+hW7omCBGjwPPwmR
 eNWYD7cV0QHixwtGB14jx1teKliYrnRMGLZjWQ52uBP8BKKX9NuCYAioDvosr1AaAxii17usQNq
 zRx5JU4BgqjlAzXnbAUfHc7M35o9atAgTSH5ZTwkhCPrjbQ8iTcJj3Lo1am5LY7YxJK/TleYUOk
 /9IUTbHRXm0C8B4Q5/Ytz2APT12kFg==
X-Proofpoint-ORIG-GUID: WOS7LpsfhbiG-7yOxUbpdsKmVMJPzSTj
X-Authority-Analysis: v=2.4 cv=B6W0EetM c=1 sm=1 tr=0 ts=68d590a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=FGfpzpXAeFzZHe8uLp8A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 9/18/25 23:57, Glenn Miles wrote:
> The IBM PPE42 processor only supports real mode
> addressing and does not distinguish between
> problem and supervisor states. It also uses
> the IR and DR MSR bits for other purposes.
> Therefore, add a check for PPE42 when we update
> hflags and cause it to ignore the IR and DR bits
> when calculating MMU indexes.
>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/helper_regs.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 41b7b939ec..a07e6a7b7b 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -186,6 +186,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
>       if (env->spr[SPR_LPCR] & LPCR_HR) {
>           hflags |= 1 << HFLAGS_HR;
>       }
> +    if (unlikely(ppc_flags & POWERPC_FLAG_PPE42)) {
> +        /* PPE42 has a single address space and no problem state */
> +        msr = 0;
> +    }
>   
>   #ifndef CONFIG_USER_ONLY
>       if (!env->has_hv_mode || (msr & (1ull << MSR_HV))) {

