Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07720CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBrKx-0005dG-HR; Thu, 23 Oct 2025 05:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBrKu-0005cX-Tv; Thu, 23 Oct 2025 05:10:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBrKs-0004tX-BT; Thu, 23 Oct 2025 05:10:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N4OuuY011773;
 Thu, 23 Oct 2025 09:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x11bVB
 ZpqVnxIiqjV0ob+gfZap7QUmzFDM6fs3uz0P0=; b=fuXX62woFJHEudvKiJZF9H
 I0dVLDDD3ts0jioEDwbefCIsyMMJrbPY5bkavUy0Y9XVD4lR2rzSH16Zi9lX8Rdl
 auSoUBB51++Z8dmnKXP1fIuh7i3Mrtz8KTqhLGei8dBa5ouZSCTUL7GuoPAHk3YD
 hrNeAT6hhPXvaWJ2Bzyn4FkhlQQd1jMZ4ljKymk47ADbC3BwPNddtCYpmGtTw+n1
 SXOHuCYMbcBYRLMmWxxaz4X/wah2ZHoIVD/0/ORuRnRffiz9XfX5Gt/GVRO3wzyc
 dAk6bYcsx/lE3lR2B26dvTHJpuftgTZXxnNz2LFjIn1lS6zB9VNMzgFtHTBlZ3aQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cfyyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 09:10:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N94kmc004056;
 Thu, 23 Oct 2025 09:10:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cfyyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 09:10:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N67BlW024987;
 Thu, 23 Oct 2025 09:10:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk4vj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 09:10:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N9AAv229688190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 09:10:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC2FD2004B;
 Thu, 23 Oct 2025 09:10:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 382F720040;
 Thu, 23 Oct 2025 09:10:08 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 09:10:07 +0000 (GMT)
Message-ID: <8051966f-a7bb-4978-9a0e-716082eb0de7@linux.ibm.com>
Date: Thu, 23 Oct 2025 14:40:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] MAINTAINERS: Add entry for FADump (pSeries)
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-9-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251021134823.1861675-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XTKy3sdoVQWcEPY9qLW8gos-bbkT6v_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX43uWAyAmGJBK
 IBkqwySiMWSCAcs94K6LpD6e4EqcOSRQ6a+DXr8b3Iq4qlngnr3urcoFEkdXk15iWa/SoqBM2QL
 6Z0/6hfpbV7OaAU7+wki7oDc6R1ETcoVDoeLBjpbndmHKX8Bn4thYWVnYCFYkmOw5PlimV3bNQR
 az4GIkmMp912180vaHz1wujKcq5YFvwniepL1y0RTktR3gZoTlOiWFr08V1zJu2h5MN4YTU45/B
 HQ+mohIOU5WEeamziLaIN0+KGghBToRzCsNvx0towyYBV2xVBzl09VXQaC2AE0kDqvGOmKlcG/2
 Ivv7yfOnalnog8UFPonHTaK2l8+///5WzU26A2mFizoYp/d3jjymG7XgX6e2/NU3qly5frA5g9r
 3fLzpFxN2mCAUmJ1y6Vyq8bEfruNow==
X-Proofpoint-GUID: dTXzlpUUrjVothSD5mrato3t3oPRqpIn
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f9f0f7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=fmbmi_iLyhxoRCsJ9Q0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 21/10/25 19:18, Aditya Gupta wrote:
> Add maintainer and reviewer for fadump subsystem.
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 667acd933c7f..5dcea23bfd3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3213,6 +3213,14 @@ F: scripts/coccinelle/remove_local_err.cocci
>   F: scripts/coccinelle/use-error_fatal.cocci
>   F: scripts/coccinelle/errp-guard.cocci
>   
> +Firmware Assisted Dump (fadump) for sPAPR (pseries)
> +M: Aditya Gupta <adityag@linux.ibm.com>
> +R: Sourabh Jain <sourabhjain@linux.ibm.com>
> +S: Maintained
> +F: include/hw/ppc/spapr_fadump.h
> +F: hw/ppc/spapr_fadump.c
> +F: tests/functional/ppc64/test_fadump.py
> +
>   GDB stub
>   M: Alex Bennée <alex.bennee@linaro.org>
>   R: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>

