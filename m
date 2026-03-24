Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E791DE9A761
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zJQ-00062Y-DI; Tue, 24 Mar 2026 06:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4zJ8-00060c-Ro; Tue, 24 Mar 2026 06:48:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4zJ7-0000MJ-8f; Tue, 24 Mar 2026 06:48:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O81axp669847; Tue, 24 Mar 2026 10:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZN+Npy
 4K7D4Aw3Sbbh1VeT42ctluYBqwQxfhcfnFKag=; b=jpYPGY/DOPa1+zWLwf3CoS
 Oy6ZR7pAVfADW/lG+z9Cvw7Y6K04IK4hfDoXpbznEe1dXS2/mbRdwOe5yES/GQwV
 LOU59v7NV9O+FPu+fPyEe5KfSfJV2GrVSI9Gixjw4UhxOC+vCHGpuUm4AFV7PwWc
 +n3g99tOYUUDhdqM6+VCgw7Qank2s/GzFuaiuF+nVkKto5j8GOm5x7EcG2j8KZZB
 jUPiBvwDoj4pPS/o3siid/zDsKijIdXAtZuCo1Q+Y6drRNIG8YsWI9aQwcqMEs3k
 IBTV6rSO0Xzt+B0oEhMY9Od+tlPyGtom/Fi8K5rLzGewI6D0qgaRpoh4yH5aJzpA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktute3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 10:48:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O8kfV2012203;
 Tue, 24 Mar 2026 10:48:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk17ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 10:48:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62OAm2bi51970410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 10:48:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2BF42004B;
 Tue, 24 Mar 2026 10:48:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 582D620043;
 Tue, 24 Mar 2026 10:47:57 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.27.96])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 10:47:57 +0000 (GMT)
Message-ID: <52b6a46d32483a51e666e9560662825a54101092.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com, Aditya
 Gupta	 <adityag@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Date: Tue, 24 Mar 2026 16:17:53 +0530
In-Reply-To: <fc2985a0adfeb0de4bb2980798950f1ca2b0a4f7.camel@linux.ibm.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <20260323231612.GA2637687@ax162>
 <8cde9a355050b306180f80e8d1340ec814c0876c.camel@linux.ibm.com>
 <CAFEAcA-zJor6L=WFxjfPVhY-bCGHvJTht0yX37Gks_Ozk+PdZQ@mail.gmail.com>
 <fc2985a0adfeb0de4bb2980798950f1ca2b0a4f7.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LIwfBlq5bNLTpNZ_neiDQ4PRT2DuE2e4
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c26be7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=HjBtZnm0hsDL5flKV7UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4NiBTYWx0ZWRfX0mTMGnGz9LqT
 1es5fw2MRbZci76IBKcGYBtlqTWtU2wZVH8ELZRCfxFqTCltoPnZoji4iT46/7dWn0NkY7PbH4L
 USQ54cwDVD6hmbrJhSzZFKUPqgVNABWqYyUXJxLNvlvKK2bhT5+t7N+XvfSroWP6ev3NgKUooHr
 RT53CSffKjxApeZcdGXsB2IPe5cNKuf5uLpj9qREFS3WYDm+JOUtSmZnzPzoF2LtfswcmvXZUGK
 j5comioSg5Iyii71UXS3ee9d1CbTEmsQUjV1O1ufxPDQKHjYqsnsKtryE+iHd1bCEbQE0rMNH4u
 yNdsB4s749Eb8mRBZ/9T3lP/7+NbR06nSHQF7NhsC/LDlkUYLtHZ5LtAuTQ458G2vANwjc3IyrU
 nBF6gZBAGf4eugm8q1Gjil4spcWrXoGlrgEmelETGMCMx7tCqeNN1M2n+huw5DhaI3TyF3VD1T0
 fIhXzfrKeFzU0VGxD9g==
X-Proofpoint-GUID: 4iM4rraKhxWoesZupUT5walrztZV8lQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240086
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2026-03-24 at 15:51 +0530, Shivang Upadhyay wrote:
> On Tue, 2026-03-24 at 10:14 +0000, Peter Maydell wrote:
> >=20
> > You might also consider using qemu_add_machine_init_done_notifier()
> > to register a callback that happens after machine-init is complete
> > (i.e. all command-line created devices have been completed): if
> > I understand correctly that would be a valid place to create the
> > DTB
> > (the machine-init-done hook is called after everything is created,
> > but before we process the dumpdtb option).
>=20
> Ah, That would be a good direction. Thanks Ill check on this, and
> report.

I tried adding dt_create in qemu_add_machine_init_done_notifier hook,
and that Does fix the above case.

Thanks for the suggestion Peter. I should send a patch after the tests.

~Shivang.

