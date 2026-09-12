Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33AEC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5N1J-00042A-Dn; Sat, 12 Sep 2026 08:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5N1H-00041h-LA; Sat, 12 Sep 2026 08:39:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5N1G-0002Bt-6c; Sat, 12 Sep 2026 08:39:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CC1eNq3521106; Sat, 12 Sep 2026 12:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=aggSw1Twi8K8gwSDmrTGMK54sd1maI
 XNgn47MNJ3hB4=; b=iPHm8Kcs15SZflwP5hZqyL7zx1X2M1ZcdEdEigdKXvJ3FM
 Lxrf0xMHB++WMhIpN6tsdc0u5ZK5gHxVLkR5yLrvJIv3PpVGhB+A1HY50e6nyT47
 RRDkhs5u403j1/9H+vt5PP6YyFE81rBYgEQhEP5WvScgh2mkuVI55O2cF68cdt8q
 tN/KyLq9g34yS8SUD3prpoUUyrKdjjeBdFvZbFrI5tj51vzC3okYzSKgIuMTMldy
 pFKsQeyHh4+JELcSz2yEfemzvriQ1yKQV+KvEIDjgoD3eeghckNxz2ucrV6hT4V4
 hH7Ra1g6o84YXXFmIF5hhuIh6R/baRMFKMedDIGg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dhf3m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:39:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBbF623253281; Sat, 12 Sep 2026 12:39:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq334qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:39:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68CCdVi329819238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 12 Sep 2026 12:39:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83D6420043;
 Sat, 12 Sep 2026 12:39:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C879720040;
 Sat, 12 Sep 2026 12:39:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.87.143.209])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 12 Sep 2026 12:39:26 +0000 (GMT)
Date: Sat, 12 Sep 2026 18:09:18 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v6 2/9] pnv/phb5: Add reset logic to PHB5
Message-ID: <aqVHph2Un4WtjRms@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-3-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831123005.1485518-3-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX4yfBPv3d+mc9
 aNRDI4ydAGkyKIjJgQplQSgpkWAgEi9f3tXpSCrL2+8T0pQv7vVexBx/McS31pAjv/CTg2PCSOt
 MgDeivFU05XDraGybGjEDR3a4naFd7hqSc1IRFYid7DuUSYm1vuFEpJujFmI/rgIrYqXbRz4DdG
 lHnryQggNgCk7gzMbq2iIGigNS9VsPNIGvWbbdRdpvmunB6gufXqxC3iIeJu7CbyfZJw9uvqEBe
 fgVjjdtwB1VkGBcnoRAzKE5pB/Tr9ZeATtcQFYL4tQdKlytvdmvQcQKiGI8PiOlgC3gksh2N/Uw
 HmPdd78+oP8mgSAlVy1S8JoHTro8d3Bh6V9d83ROVEggu+yQh42MrFyv0fyUZQSxbmPno3M+MYn
 +ZyQHatWlVm6W0IaRZr6ZEweQJaU4FiAixhzwhh0F9lEKI9+EBTun3FsKa6OQn+xU/vYMtbT/21
 9+kc4CJRhmND9Vxu9Aw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa54808 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=HyS0GJsuYoGZKTDaHm4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 7YnajtCrnKmE-ALaeb9WEA9yiDSHnX2c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfXx1vV0DMidVjy
 N8CAm0o6uAbCltWypFGKMoxh8N8P3wnLEClm0ZtcykB+BrNQXFIyvyduzzDxE1wbrxofM0L3IOe
 /LNmJAxZT52k6Wzo1o8MM6QymMAFTXA=
X-Proofpoint-GUID: d-BQabECJne05WlPYmo2EV_YRYuqBmaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120181
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

On 26/08/31 07:29AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> > <...snip...>
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1,7 +1,8 @@
>  /*
>   * QEMU PowerPC PowerNV (POWER9) PHB4 model
> + * QEMU PowerPC PowerNV (POWER10) PHB5 model

minor nit: maybe leftover, no more true ?

> --- a/tests/qtest/pnv-phb-test.c
> +++ b/tests/qtest/pnv-phb-test.c
> @@ -17,7 +17,8 @@
>  #define PHB3_PBCQ_SPCI_ASB_DATA      0x2
>  
>  /* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
> -#define PHB4_XSCOM              0x40084800ull
> +#define PHB5_XSCOM              0x40084800ull
> +#define PNV_P10_CHIP_INDEX      3

this is index 2 now, after removal of p8e/nvl


