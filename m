Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83516C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz6OZ-0006eF-GO; Wed, 26 Aug 2026 01:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wz6OX-0006dm-Po; Wed, 26 Aug 2026 01:41:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wz6OW-0003TX-CU; Wed, 26 Aug 2026 01:41:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3W4712881413; Wed, 26 Aug 2026 05:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=dyekaHDIXvnO66Dz17aCbpXtBGv/Na
 El1mkhBFByIjg=; b=pHVEmtyk7zsoIQ6WSpryybEkelMCBiE7V1FRLlmwP5S47F
 C1/rcS8TwDABO+ZSsm29TcjQjiR9keRTAEAVgwokglwLtSFkDITn4/LaiIaxirK/
 qhfZFtJu1sYXkXW7UF44IZraElwOii2R5HU2PyZrn6YMDuE8cU5kG1+03V1tVmDd
 2xqOzXAx7SLpOPIrdOpvMkywB068zxWft0JaDL+kF+vICxpsxwt5OzJ8M9aiLjmm
 NNwGR+Q/b1waZOPo7pZNAQul0ywgXoYXkjY7gkICPNec0WGeeiN/l2DpLDymnKoE
 9T4ZfqbSKmbGBC8KNJB9wnjyUhN4OE4rQktNkqaQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxcfc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:41:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5fWpJ004687;
 Wed, 26 Aug 2026 05:41:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8ehx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:41:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5fhoD30802440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:41:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E6B720040;
 Wed, 26 Aug 2026 05:41:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0626D20049;
 Wed, 26 Aug 2026 05:41:40 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 05:41:39 +0000 (GMT)
Date: Wed, 26 Aug 2026 11:11:41 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 37/37] target/ppc: Add self as maintainer for PowerPC
 TCG CPUs
Message-ID: <20260826111046.0dcf27ef-5e-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-38-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-38-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0NCBTYWx0ZWRfX6FcT8KLb0O2h
 7EhNQrXcD95y0ploWFSsU+g8n2MB0iSlQQweumiNseA1qcqHz8aC9Z+8ltGLVQlEXH5Ct7t6SMb
 N6/5zNRAGgk5/BHXS2M8Xu1zEmdXaHI=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8e7c9c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=oHigSh02aUfPcg319hEA:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: fmZwHUfVvwTgiIYRSZ73JTAq5OMvPLqu
X-Proofpoint-GUID: vNZwxWJlncVkJdgPbMBTigRrfd7X5Z3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0NCBTYWx0ZWRfX+sF2lfKTMwe7
 s0yaDKbmq7nnwTtH8IqMv0DP8gJfGTNJL5NXrSJwrCzMEQbvcaYTicnPB1dZ7A7FlrCRZnBFOy1
 n/zopGZfCtdh472Y3EiOPudMy+UpUGMSK+szZw6wTKo+HDZrXiHE2ljrrpRIVR+aNKWzTvKtE1W
 E7EJQXuwIHmAis/FrIth3mMLnR5TVE02TwZE3gRNYEaugcwi2pZF1Aae7PZVMdXboy5bAKJO4cE
 TlevanpbjKanoBEzKkK661TkBWt+uCTvnQ1XjaqDFufIrcq0hKgfHw0dTXM6GBNNfJMkrEorBL6
 /+Ss6rUy8FukDmXDo0gs7qJ37NqNBg1hEvwX2UifW1Ig/Nfx71HWLcpIif68YRe+ffvEZRv72C5
 Jjn4Hh/DCK6l+eqhMAAu/DC+iQyXmtu8dh9Hvn4H5PeWh40Ww3wg3v0vDMAKF7R4IPmSlkJ5j3T
 Mm9Vm73jsPCmOcX7yvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260044
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/08/26 10:39 AM, Chinmay Rath wrote:
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

Thanks for your support, Chinmay!

Acked-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>  R: Glenn Miles <milesg@linux.ibm.com>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
> -- 
> 2.55.0
> 
> 

