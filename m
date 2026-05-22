Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F059CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 11:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOU3-00085M-Cz; Fri, 22 May 2026 07:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQOU1-000846-A4; Fri, 22 May 2026 07:56:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQOTz-0000Vj-ET; Fri, 22 May 2026 07:56:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MAZUr4394602; Fri, 22 May 2026 11:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=98pQLA55C6hCx8VCLzRt3NeRMsEs7s
 PvcvAk76zK0Wk=; b=LAP4drNYQ+33GVjyghrCIoay/odeV5LpuU5AV213YIbmk1
 Ff4L4nB3ZxU2hFjU/iqAKpyUoNRlosN7T2Iad88SwFHqCAo9sR1rRNqDUTBNBlH6
 FCpNL7TCA63go5YyVlUjOxkGjEtTD1bbJa2/Vf14b1i8v/Qbpf80vARIEiy9uR3L
 ZOM9SgF2gosRn4HkyG2Tb+HNPA+5JN+0FCfSAIFUg1ErJxAlrhPMQMDxwU+9tVWU
 nq3a5HKIc0O7t4iTI4F4NthDWWeg7lwZXrOh16OLn3nYH9jCsQ9s5DHiXW8CFCds
 8095s5XBkxlFr5FiAXrEcYk6PwpFLcMr8hZymyww==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9ybv9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 11:55:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MBsFHG018650;
 Fri, 22 May 2026 11:55:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754grgcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 11:55:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MBtvLG47251918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 11:55:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5486320043;
 Fri, 22 May 2026 11:55:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 761A420040;
 Fri, 22 May 2026 11:55:55 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.216.126])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 11:55:55 +0000 (GMT)
Date: Fri, 22 May 2026 17:25:53 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 16/39] MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
Message-ID: <20260522171736.8658feb5-5b-amachhiw@linux.ibm.com>
Mail-Followup-To: Markus Armbruster <armbru@redhat.com>, 
 qemu-devel@nongnu.org, philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-17-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521080511.999266-17-armbru@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNiBTYWx0ZWRfX11KqjPxKQWJG
 4hK+CtRbLjeadJxwrpAXLu2SCQ/IKLyzli4HLnx+yhGdQg0fP9AK6dFnmVtt/iYzCOkpgMo6wpb
 ZkEntAhf1UqgJaZVcNhNNd8KWspx/TX1a3cKvFOGKy8UKv6jiYPVnVBcU6vR2gMzM7jcRzBK5s+
 jfw0mYnpnn6Q2CbtiSVvlZNp5vy/grCgfNB31DbAea49K7ainN2OnIZFzaX+W9ymWXt6Go0rJBc
 2YPvGo0ofZk09w6egLaxlKTiMKhX0jdTPtE3QkeJHq6OWSxKaxxTB1E0Z1MsdhrLJBJCdSddTPv
 NRGBsn087qnNSqDOY5iifcS0e94O9cISTA/BAMoDEn7etxmHsdYA5xQoYDFC6c3Faq76TOGhqX9
 BLoh9Id3nR+qO7oW5ZVA9Z1Qx1uPxVDw9YdtqqdNi85gSvhGlY17F0N1+PzVjjXNXlnsQrWyC1o
 laYJ+btUkcHAES35WGg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a104450 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=CxphCBk61hIrtL5lSY8A:9
 a=CjuIK1q_8ugA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: EHaD60ThjT1Z76cpxTysC0IJEgcU-eCR
X-Proofpoint-GUID: WorCS0CLH4s4XaGz6ygVYqkXAZrzAdEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220116
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 2026/05/21 10:04 AM, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we deleted
> include/hw/ppc/pef.h.  Update it now.
> 
> Fixes: 00a238b1a8 (ppc/pef: switch to use confidential_guest_kvm_init/reset(), 2024-02-29)
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cefd2cbb..87450a84de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1634,7 +1634,6 @@ F: hw/*/xics*
>  F: include/hw/*/xics*
>  F: include/hw/ppc/fdt.h
>  F: hw/ppc/fdt.c
> -F: include/hw/ppc/pef.h

Confirmed that include/hw/ppc/pef.h was removed in commit 00a238b1a845
("ppc/pef: switch to use confidential_guest_kvm_init/reset()"). The
file is no longer in the tree, making this MAINTAINERS entry stale.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>  F: hw/ppc/pef.c
>  F: pc-bios/slof.bin
>  F: docs/system/ppc/pseries.rst
> -- 
> 2.54.0
> 
> 

