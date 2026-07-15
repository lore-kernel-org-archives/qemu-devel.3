Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48019C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk0mQ-0002Ph-Og; Wed, 15 Jul 2026 10:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wk0mP-0002LM-64; Wed, 15 Jul 2026 10:40:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wk0mN-0002oA-GM; Wed, 15 Jul 2026 10:40:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FECHKq381748; Wed, 15 Jul 2026 14:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=8pKZSYoQWLp5jKesDynnk/GPiaLf7C
 hiol+yTFEJNyE=; b=RFSRpp49bTf49l7Qa9AFwvJG6w0eVBVN+OuUJzVea5ZLmB
 AS+anFhbMRo15IbM5bw7UZzFlfPF8ZHAQQ0m8QB9XbaZcXevg0bxBhlRsXhHLZn8
 y6aW37TlOwa5SgW21NMpFwh4Q/XnngNvG3cby8hae/IBKEcWGvGpnFeTLYCA6r1U
 kZHnrx1ufOqGTpxgn+AqbHWS3S7GrE4u2rFsiKM6Gi8uHIpbPx29T2KSYpRXiqSJ
 hVBhvQiYEoAzUD0DZevocTLvzjuCW+3rsNrnxqpLwO6DWLaCP5bH9emNbLAj3XbD
 VmQECX0IPemiKgI2VGMLsBmt+GDT6kIwqzVVJLZQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbug8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 14:40:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FEYfLP022110;
 Wed, 15 Jul 2026 14:40:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k0fa7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 14:40:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FEe1Od27853174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 14:40:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66E0658058;
 Wed, 15 Jul 2026 14:40:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFD9A58059;
 Wed, 15 Jul 2026 14:39:56 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.43.68.28])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with SMTP;
 Wed, 15 Jul 2026 14:39:56 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation);
 Wed, 15 Jul 2026 20:09:54 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 mahesh@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH 0/3] hw/ppc: reorg PowerPC RAS code for better
 maintainability
In-Reply-To: <20260714164745.573141-1-shivangu@linux.ibm.com>
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
Date: Wed, 15 Jul 2026 20:09:54 +0530
Message-ID: <87pl0ob9l1.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a579bc3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4Z04ArDzD7oIC62fKxoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX3ls6ShRpI/u5
 WyaQlWAtPfBMO+yMMkiqi1d0p/fDbVowdiJr/cj6jNO+xkexY27vFPqfX8HBPZZ3TnyEjPK9awu
 t+N+u/ZLvHW/CGS+GfQpwe7Hh//t02GjLskEkxLp8qdlTtTaNa5bH9voDppp0kiwayh+dPCbs+N
 XS73rgjlY4J0KR//+HhVgvrJtl/jncNEB6AN3272bV79RS8Gvatehf+MgBCCiK7JHouEyvtHCd0
 28sOj+OOY1YpoS/dcr2hhqWuUJGbhMVd4VjZKDGZHFsRBuDHXupCG5dWmCOlyQD31omEDcsOOFO
 7RzVoUoGxok2Xpeml9Vij0AkBd+6v1BBe/JryZxxowwLseCRy+hmMDGRdwuWRrkP6j4x4uS++bc
 fIMz8runKvsEDxfxljsI1mmF0BUzqQlXKLkyi9f47UyS9tdg85c4tnnrg1sfhMVzTE1ow6usgt5
 qU+tSaUegdbfN1PzQNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX5pGVQBKjAivt
 b+5n50nb1J6mSt2QG9nWerPYgb3N7PWotsE+YaTbQFD+jh+PpcNFM6+bnc5TfjW8dyxijAITSYm
 RXpzOZVgSQX7w85wB9eenIVzfFyuSvg=
X-Proofpoint-GUID: 7MrAjf9Vp0c8a2DhXMjUg0jikoGQvTZQ
X-Proofpoint-ORIG-GUID: aN5PNFqGAU8oB3sy3aqQ_OlL5uVkl5rk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vaibhav@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Shivang,

Thanks for the patches. My review comments below:

Shivang Upadhyay <shivangu@linux.ibm.com> writes:

> Extracting RAS related code from spapr_rtas.c, to a newly created spapr_rtas_ras.c
> and carving out a MAINTAINERS entry dedicated to PowerPC RAS. This will cover RAS
> related functionalities for PowerPC platforms.
For a refactor-only change, this patch is adding 44 new lines to the
codebase which feels a bit heavy.

Just moving code from one file to a new file will reset the git blame
history of the code making future reviews difficult.

Such movement also makes code optimization difficult for compiler.

IMHO such code movement should only be done when:

* Its accompanied with patches for adding or fixing a functionality.
Or
* It clearly improves performance
Or
* Results in significant reduction in LOC

Since these patches doesnt seem to fit to any of the above criteria I
suggest you to reconsider these patches. 

>
> Also adding myself as a reviewer, to help share the review workload.
>
Thanks for volunteering as a reviwer for this code. Having more help
with reviews is always good :-)

> Shivang Upadhyay (3):
>   hw/ppc: move RAS-specific RTAS handlers to spapr_rtas_ras.c
>   MAINTAINERS: add dedicated PowerPC RAS section
>   MAINTAINERS: add self as reviewer for PowerPC RAS
>
>  MAINTAINERS             |  33 +++---
>  hw/ppc/meson.build      |   1 +
>  hw/ppc/spapr_rtas.c     | 189 --------------------------------
>  hw/ppc/spapr_rtas_ras.c | 232 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 249 insertions(+), 206 deletions(-)
>  create mode 100644 hw/ppc/spapr_rtas_ras.c
>
> -- 
> 2.54.0
>
>

-- 
Cheers
~ Vaibhav

