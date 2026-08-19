Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273E6C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwaaQ-0007c7-4h; Wed, 19 Aug 2026 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wwaaP-0007ba-5J; Wed, 19 Aug 2026 03:19:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wwaa5-00067I-7u; Wed, 19 Aug 2026 03:19:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J6VnfO2666861; Wed, 19 Aug 2026 07:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=a4cJlYUPLRX7wROf8Nj9gv+VPYlE9X
 T4wp38DBawI2s=; b=VHEh/g3MlQMv1+7UHkmpYeb+at2mGZtfGk8yxvZFKUb2rd
 zGZmGmlmKWttxy+toWuLL6jsyxj/cINuD5mG5+ato061T33e8H/3aQbdoYGLhNVP
 IC9a0sU0Dj93GkcrWtwvzccAjy1kJWpPopWKMkeFtOFXvHHUona2gFdALrYEgZ2A
 C8JVxoln9sivAeCo9GxWgioDuEwsLbaSpJvVToU3UenMF0QM20TRqaWvb8AiJ9jp
 FY//6k4qyh1+8rLGrKKT2bqDbRzr+FDjU9ncgqgj2gXIjlaS9ubT1JS4QOcrb7mM
 nhvtmosrUqJfys0uHynEMS1BOJ31P5R6ZbRfNpGg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0a73u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 07:19:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J7BOgG013044;
 Wed, 19 Aug 2026 07:19:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yfdj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 07:19:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67J7JHdT45744464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 07:19:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE0412004B;
 Wed, 19 Aug 2026 07:19:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DE3A20040;
 Wed, 19 Aug 2026 07:19:15 +0000 (GMT)
Received: from dhcp-9-123-15-208.bl1-in.ibm.com (unknown [9.123.15.208])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Aug 2026 07:19:15 +0000 (GMT)
Date: Wed, 19 Aug 2026 12:49:13 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for PPC KVM and
 sPAPR
Message-ID: <aoVY8SwmwupldeYt@dhcp-9-123-15-208.bl1-in.ibm.com>
References: <20260819050545.21232-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819050545.21232-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a8558fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=kcJ0IuGOz4MQWM4fTz8A:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: GgkmTPcihBMsX0TlhGwlzdGFLa5Nd6zJ
X-Proofpoint-GUID: Un-T7HVv_nJFhJPCkyLJooBFf2MPAqHd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA1MSBTYWx0ZWRfX9ldlzKbeAf9U
 VNcaKVs+3uzrZMQtn1LikhbG6fhitaYbysNN3xHqk/tWGZYquLFLbZf3OTz4tOJMgIdHX1hT+vB
 GXIORUdNgW9g/jbDkMsvNgyCFa5tx2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA1MSBTYWx0ZWRfX45M4kRgEtE1P
 k248riSayGaYFCCO+NDLjBxlXuNmTdqTuGgh5Ws3Dd3UPVvR6Lc3lWctDcJKCbPluoKJN/HtYCc
 g71kVrz9ue70LGAnmOm1lhyVyH2rHW2m2ngLziLlC3BG7IySFxoIFu4FoSmNaa3G2IxkfmGAhB9
 BnQmYxObzYbs9sRUD0hKGhQ3Cin/78kn5ME7Wrga0CnyspP1280Fiv6XRm15UaLyErOr7wLpIrX
 cBaTFIomWd+NwE/dSKVRu0F7g0CbAGBzYiVsxFMUqBbBy8KlwQYp6UJXrCyPpualQERESFd/wuk
 +n4ShLvVNlDd6lQz7bQ4+zPGUek9Tywc90QXqzbthanJYyJ8q2xDSxpWGG3gBYaBTecgHHYtwQO
 ADm+H+EF9oYQB30QqoNEwwOdUjGV5Q0A8e4Mcda9wQRTcDO5uOf4xODfijoie4DU/PrG3y8dHUY
 TvC5me9WgF0LDi5P7Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190051
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 19, 2026 at 10:35:45AM +0530, Amit Machhiwal wrote:
> I have been contributing to PPC KVM and sPAPR (pseries) for some time now and
> would like to get notified of incoming changes to help with code reviews.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b51f5c3e6022..1a1c77285d3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -497,6 +497,7 @@ F: tests/functional/aarch64/test_kvm.py
>  PPC KVM CPUs
>  M: Nicholas Piggin <npiggin@gmail.com>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
> +R: Amit Machhiwal <amachhiw@linux.ibm.com>
>  S: Odd Fixes
>  F: target/ppc/kvm.c
>  
> @@ -1661,6 +1662,7 @@ F: tests/functional/ppc/test_40p.py
>  sPAPR (pseries)
>  M: Nicholas Piggin <npiggin@gmail.com>
>  M: Harsh Prateek Bora <harshpb@linux.ibm.com>
> +R: Amit Machhiwal <amachhiw@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/*/spapr*
> 
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995
> -- 
> 2.50.1 (Apple Git-155)
> 

Acked-by: Gautam Menghani <gautam@linux.ibm.com>

