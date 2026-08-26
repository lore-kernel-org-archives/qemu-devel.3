Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14EEC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzA4w-0002Yl-7G; Wed, 26 Aug 2026 05:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wzA4u-0002YG-S7; Wed, 26 Aug 2026 05:37:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wzA4t-0003Dw-Ai; Wed, 26 Aug 2026 05:37:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q9VWn23661679; Wed, 26 Aug 2026 09:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=MRW6FZ7qHBwpbtNbDVOOdtV1xKe5Wm
 3TjCRoS1gMlwc=; b=HIqjw9BO5x/gCEA9oFPNDfx6d0oJTeG7vCcWGoaNgJR6WI
 +Hwt2nmjb8M6WoEubSj3JNqjVmFECTU0ilnhXEhzQs4xKWorMeIPZnEuvqUDyfmq
 y+d3FVLCsMc6e9GLJlC8+e/GEN/i630RoI3X7TU5WWA5Mvy2OVs81S34dS8DUbpm
 9nvhpJraxxZac2NiKk/ctYDyvmDRkd42zLnr5dN74BGFj8Z+vmqfDt1t0WsOkgBM
 Kg3hjeNfXo+rz9LMiuKxXmYEuvxTYaWSuhdpsp0hqTB7Uv099xxRmrEP4KHWdazN
 e/yndJyl/oM1oYvGtOUAkwzbnaINiL8TrPqaf/nA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxdg65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 09:37:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q9QHhq020031;
 Wed, 26 Aug 2026 09:37:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k17hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 09:37:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q9bg8749152272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 09:37:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3779A2004F;
 Wed, 26 Aug 2026 09:37:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54C642004E;
 Wed, 26 Aug 2026 09:37:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 09:37:38 +0000 (GMT)
Date: Wed, 26 Aug 2026 15:07:36 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 37/37] target/ppc: Add self as maintainer for PowerPC
 TCG CPUs
Message-ID: <ao6zESyx92Pcgjwy@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-38-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-38-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3OSBTYWx0ZWRfXyLADNjrRC7Hi
 trhIEroqys47MUOIUTu54/SF46kHUvccM2GOCAIaiU9o5NVAT/c0Aj5qQexFtyMSxq1eOf/p6yJ
 nMfTLC40Z0IdCBEfz15BFnDf3f/Ja9k=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8eb3eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=oHigSh02aUfPcg319hEA:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: vas8fGv42FPohnw-sROmL17H7Tcb-tiB
X-Proofpoint-GUID: buXticyMEQnAWRB7OTR502XTSiXzVJxs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3OSBTYWx0ZWRfX/NQS5g313CaK
 Q+Wsz+6bmvoZjfZCKFHJ+AytjeoKxmgRcAou9S35AG8DfFLb4g1ENdq5jnwDwsuOiTVn0ANcRwv
 GtLeUkucEztnrX4az4TtbC5t4dWByWAXjyuPb5/wKDplCWegXcdmnlV5NtVNh7WTX4Ik5qt6du9
 WvJsEO0UG+D0U/762UtHyitS8j2ur8yEMif6ab0ifRTYAvDfQDVTe5N7LBDeoPTVf4CRzW07Y2M
 LKyF5vFCdICCGYvceShp1BYMw5SZQgVUEDL3HqJlEIIlLHPnsuiIEGrXWUs5lliVwZzFVqBDz97
 cOXAD4CqO98YsUcdQMUJBoNiyDLPZT9SSHOJwI35H7pWl5E+odTAyfDx1tK1OTUrFTeXMI/d2Fq
 MxakR3OiK3GojyTNhamT/CRJLRazNyvLMJi3gTw2IewgxAy2u20b8VzinmE48JUD5DXbKST5y++
 tf2u6kGuGMuzMeiiajQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260079
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/08/26 10:39AM, Chinmay Rath wrote:
> I have been contributing and reviewing code in the PowerPC TCG CPUs
> module for a long time now. Stepping up as an active maintainer to
> better reflect the current status.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a0ee348c4..f040083503 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -337,8 +337,8 @@ F: tests/functional/or1k/meson.build
>  F: tests/tcg/or1k/
>  
>  PowerPC TCG CPUs
> +M: Chinmay Rath <rathc@linux.ibm.com>
>  M: Nicholas Piggin <npiggin@gmail.com>
> -R: Chinmay Rath <rathc@linux.ibm.com>
>  R: Glenn Miles <milesg@linux.ibm.com>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org

Thanks for the contributions and stepping up to be a maintainer !

Acked-by: Aditya Gupta <adityag@linux.ibm.com>

> -- 
> 2.55.0
> 
> 

