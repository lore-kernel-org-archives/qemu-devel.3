Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07F7C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNnC-0006sN-DG; Thu, 04 Jul 2024 10:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sPNnA-0006rh-Na; Thu, 04 Jul 2024 10:50:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sPNn9-0004HA-1s; Thu, 04 Jul 2024 10:50:36 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Dvhrv028382;
 Thu, 4 Jul 2024 14:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 Ov5dR3NVQWZEsjuC0WltBWgRBB1v8xN3mLzqhgCv0LM=; b=ZAhFxUbDHGQ8iL7h
 pPa/Y7QRrNhDtopozJPn6eIc4taZvsfdRwPJKay9onzb2QGaK+R5XIHCAWNbWulF
 W89bc5LCahszWnePnIqcq/xrTL+lZ1c07gVfqs8LVLojd2aoe2EGqCJJo+o4x3hr
 KgMdz01VBdjA8pMJL9dc5N+g03CteGOmafdfKfUQV/bckNdck5Oa40AajHcoPCzp
 J1YHMk2XEl0NyI1TgA8f/A3mQ3TkfyqsjUJ1jfCABJpiPvk00Duw0yUx1zas3ZVE
 tC3yMLdgvN5SxixCaENEryvrppdwqofJ6i9XB6XxwFG++KMCyYWSBz4R4nZ3JjbR
 suFZeA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405sju0pbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jul 2024 14:50:23 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 464EoMjB011794;
 Thu, 4 Jul 2024 14:50:22 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405sju0pbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jul 2024 14:50:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 464E5Zl4005945; Thu, 4 Jul 2024 14:50:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vkugug5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jul 2024 14:50:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 464EoIrY40763766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jul 2024 14:50:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EFCE20040;
 Thu,  4 Jul 2024 14:50:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E57AA2004B;
 Thu,  4 Jul 2024 14:50:17 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  4 Jul 2024 14:50:17 +0000 (GMT)
Message-ID: <13b19a4859e25274d05663bc0ca05621c56af985.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, david@redhat.com,
 balaton@eik.bme.hu
Date: Thu, 04 Jul 2024 16:50:17 +0200
In-Reply-To: <20240702234155.2106399-1-richard.henderson@linaro.org>
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PK1HpEFLX_gBm0BPdLMKMNrcWYQl-D8Y
X-Proofpoint-ORIG-GUID: Cy5r1Ez5bgLcK3GtC22ihuODAxHZgPQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=572 phishscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040099
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-07-02 at 16:41 -0700, Richard Henderson wrote:
> While looking into Zoltan's attempt to speed up ppc64 DCBZ
> (data cache block set to zero), I wondered what AArch64 was
> doing differently.=C2=A0 It turned out that Arm is the only user
> of tlb_vaddr_to_host.
>=20
> None of the code sequences in use between AArch64, Power64 and S390X
> are 100% safe, with race conditions vs mmap et al, however, AArch64
> is the only one that will fail this single threaded test case.=C2=A0 Use
> of these new functions fixes the race condition as well, though I
> have not yet touched the other guests.
>=20
> I thought about exposing accel/tcg/user-retaddr.h for direct use
> from the targets, but perhaps these wrappers are cleaner.=C2=A0 RFC?
>=20
>=20
> r~
>=20
>=20
> Richard Henderson (2):
> =C2=A0 accel/tcg: Introduce memset_ra, memmove_ra
> =C2=A0 target/arm: Use memset_ra, memmove_ra in helper-a64.c
>=20
> =C2=A0include/exec/cpu_ldst.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++
> =C2=A0accel/tcg/user-exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++++
> =C2=A0target/arm/tcg/helper-a64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 ++--
> =C2=A0tests/tcg/multiarch/memset-fault.c | 77
> ++++++++++++++++++++++++++++++
> =C2=A04 files changed, 144 insertions(+), 5 deletions(-)
> =C2=A0create mode 100644 tests/tcg/multiarch/memset-fault.c

This sounds good to me.

I haven't debugged it, but I wonder why doesn't s390x fail here.
For XC with src =3D=3D dst, it does access_memset() -> do_access_memset()
-> memset() without setting the RA. And I don't think that anything
around it sets the RA either.

