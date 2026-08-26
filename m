Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC758C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz75D-0007aG-PA; Wed, 26 Aug 2026 02:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wz75C-0007Zy-5I; Wed, 26 Aug 2026 02:25:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wz75A-0002xQ-Jn; Wed, 26 Aug 2026 02:25:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VuPt2716644; Wed, 26 Aug 2026 06:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=qxawFgCdgG4b5ynUxKGd4uhxcbcFon
 FbtZ6IEBYmNes=; b=LBXWq4jhy8spSNo4e4RscI8iUq98kp0XLrg6qFJqFo81D4
 JYZaexzFTng3YIw9B/2Fjwi3Rn0nD2Oe3JCyLHIJY8ye9UleCN5txtNbldTogsaU
 VH/9vL5lTSePUGww9A5QoxLeGfvrufRDIrcB96Y9RZUPyALpxGy+zXfDdDhVM9OF
 8bLeUXtVzGnro9aVa/EcxdWSvb3/RC7Z8OZPOYmAHJTWCfY6wq1ajofMii+QfITb
 9yl7FOzNtXxazddEO5pFhq20zZpu/ytl+RhrKZCckupepw6pj3Kff0AjzKViDGei
 VId9AVmhjDWClp/L2axvS8IaOSlobkmR9J0emHMQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hw29a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 06:25:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q6BWIc006993;
 Wed, 26 Aug 2026 06:25:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q8pqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 06:25:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q6PmO753019090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 06:25:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE92E2004D;
 Wed, 26 Aug 2026 06:25:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 068172004B;
 Wed, 26 Aug 2026 06:25:45 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.39.21.125])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 06:25:44 +0000 (GMT)
Date: Wed, 26 Aug 2026 11:55:42 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 37/37] target/ppc: Add self as maintainer for PowerPC
 TCG CPUs
Message-ID: <ao6G5mpXglUZQ2Pz@Gautams-MacBook-Pro.local>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-38-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-38-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0OCBTYWx0ZWRfX/zHH5y12MvMJ
 OQLIDqFsgTbXf3sqQHwg/lS6F3iFdkQv9p/6meWOz71R3qHyB6/e0e4XHOyN1R46ZUZiONZLDoU
 cjlZyNFlnkd3+Qn++PZQdhmDgpByW60=
X-Proofpoint-GUID: XjvOvfJ76UTKL9_pkpNUhCNldmFi8nT0
X-Proofpoint-ORIG-GUID: TbISmvxzWwUqaQS7V-N2ApWUL9T1Dq4Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0OCBTYWx0ZWRfX6SvVxDIqZrqr
 3TM/iSYWgOD8OlUOO0DLcWTqxSAJWaN1LL3ZyUCyt6iFhzLyIzwrVFM6WKF5XcscPHCczHoS1ZI
 kYfpCWocR1lSzw3hcC8Hwyj2kKlH6qfOUJIqEnNFpwkupMQrGkeSVrtZkgTq0OAg+N1LGagtS8B
 2CO4qy7ULN1TjTH7HQJXuuG9WJJsPun8n84OKNm7nJTx+L51NfhZFPg77ENlx4Z1B6NpdPUunzp
 6Lm4P/iSfOCXJu1qJZPXPI1zr2HEjF5bvIMq3Hj78atPV5fVVGxE/fz6JcHsVrcyZWgz2yHI2Pe
 0svqFTHmR6yEQqXl/xept1ahHMaigRbizRC3USbiG++cwPqf51g3XitLp0QdSB/mw+pfiRBkcOS
 aSUCPjUG/ESH463R/LD2ZaASWXD8SQzOyXO3IaIGG/8iC+oGdb26xZFXaLOEfVKQoZBx4rDcXEo
 0n4VTcs/9JgM47C60rg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8e86f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=oHigSh02aUfPcg319hEA:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
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

On Wed, Aug 26, 2026 at 10:39:03AM +0530, Chinmay Rath wrote:
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
> -- 
> 2.55.0

Acked-by: Gautam Menghani <gautam@linux.ibm.com>


