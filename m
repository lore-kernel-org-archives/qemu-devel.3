Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422B4C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76j7-00059u-BS; Tue, 22 Apr 2025 02:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u76j4-000551-E7; Tue, 22 Apr 2025 02:03:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u76j2-0003Mu-Qu; Tue, 22 Apr 2025 02:03:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LNmRxh004279;
 Tue, 22 Apr 2025 06:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kFJFvi
 qEHX6k6pXOfHmvrHOQA986MFFvw7KsJ7QV/tg=; b=Hl0X0UzHney+fM1VR/7KPA
 da+Dfjxuo2UY+9o5CcPrgF/MwdTeTnnX4pKIcGpg1cCltlFfuzyD9cOUnH/VGi15
 R6O5g3kDcLecHY+R1KGpYyW0RSz3ct/Tn6oxfNXAAosoQzvaiTTPGZOrV53liBDu
 BN3tRYGjC/1AEBsGr2fK1CEjbkP2y65hOva9vSZ5igNVnQQRg+yIVerg+/7b61Th
 PefMb30xnJ/uBQBND8R4vijYtJZps+ydgGp7R20sSBexSdWxVuaSEmcVc8wdhE72
 6TVffwl7jRXVwlRBlSx2QiZMyKG1a2Q+IeB7NF+2fEMXLJr4RQdcsBEV1AFpouzQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466000s3af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 06:03:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M62r1i006132;
 Tue, 22 Apr 2025 06:03:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466000s3ac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 06:03:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M2YHbt015450;
 Tue, 22 Apr 2025 06:03:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464qnkhdgf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 06:03:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53M636KH35324302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 06:03:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BC302004D;
 Tue, 22 Apr 2025 06:03:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6D1A2005A;
 Tue, 22 Apr 2025 06:03:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.215.117])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Apr 2025 06:03:02 +0000 (GMT)
Date: Tue, 22 Apr 2025 11:32:59 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 2/2] target/ppc: Deprecate Power8E and Power8NVL
Message-ID: <ecp2idyfzojcwnte5vefcppmpfem5bo2z56rydhz3yjdh42tqa@druvtcyqgufp>
References: <20250422044156.26554-1-adityag@linux.ibm.com>
 <20250422044156.26554-3-adityag@linux.ibm.com>
 <e608e2dc-3d93-4daa-aa1e-39a3fe5205b8@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e608e2dc-3d93-4daa-aa1e-39a3fe5205b8@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xBxhMsBPEpW1pG1wfgRJlRCRi3x6Y983
X-Proofpoint-ORIG-GUID: C405EnWnU6nV-9U7yOzK65LUpCVU0eKY
X-Authority-Analysis: v=2.4 cv=N6QpF39B c=1 sm=1 tr=0 ts=6807311f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=J5lfiQVZu8VZoo4CgJUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=901
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On 25/04/22 07:53AM, Cédric Le Goater wrote:
> On 4/22/25 06:41, Aditya Gupta wrote:
> > <...snip...>
> >
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 05381441a9ff..527f2613dcb5 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -275,6 +275,15 @@ embedded 405 for power management (OCC) and other internal tasks, it
> >   is theoretically possible to use QEMU to model them. Let's keep the
> >   CPU implementation for a while before removing all support.
> > +Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.0)
> > +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> 
> You should adjust the QEMU version to 10.1 now.

Did it in v6.

Thanks for the reviews Cédric.
- Aditya Gupta



