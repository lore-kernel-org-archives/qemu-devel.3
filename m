Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A065C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 17:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPmfu-0002kA-CD; Fri, 05 Jul 2024 13:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sPmfs-0002jT-OJ; Fri, 05 Jul 2024 13:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sPmfq-00068n-41; Fri, 05 Jul 2024 13:24:43 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465ExWeU017854;
 Fri, 5 Jul 2024 17:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 BuYZ8Ses1IWixZbo4FE/LJUTnb87qx79OuGVEcweAHY=; b=I2htMkbpcEljUdN9
 iFpBfE9DV0sOcazIKhljkf5fXZQ9a+8hSRIcGAhDfacyc2vWlZlXHSqwpMgZG20b
 SEl4oh7/JSGglusIy6PDii3DcXnWlTqAbUoqMXGCO3suXp/bcVNof9o+o7nnv8nS
 raScihToxG3TTC68YgflA8cOC1lFbkStcqhev1dDDHOYUV8ypFOUJVsiLRtCpGo8
 GL+/vcWz5kfqy0g8q/6WvZelEsqv16d/4ZFnlfi38AmqoQUgjZZpBbT4F+8RFAD3
 D9cTjS6uSQL+Y3rCBUVavEY/1csHioRBqcLOauo98fsfS2Nh7uGEdLoSP9avpsZx
 b54Zlg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406k2e8cv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jul 2024 17:24:27 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 465HOQxU015296;
 Fri, 5 Jul 2024 17:24:26 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406k2e8cup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jul 2024 17:24:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 465F31RF009477; Fri, 5 Jul 2024 17:24:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtn6dmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jul 2024 17:24:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 465HOMjH31523282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jul 2024 17:24:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 047492004D;
 Fri,  5 Jul 2024 17:24:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 939BB20063;
 Fri,  5 Jul 2024 17:24:21 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jul 2024 17:24:21 +0000 (GMT)
Message-ID: <e78b2024e22769c4d2cc3203ccfe5748d2e409e5.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, david@redhat.com,
 balaton@eik.bme.hu
Date: Fri, 05 Jul 2024 19:24:21 +0200
In-Reply-To: <426dbf1d-cfa8-4fd4-b857-8b8a283dd55e@linaro.org>
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
 <13b19a4859e25274d05663bc0ca05621c56af985.camel@linux.ibm.com>
 <9fe81eeb-473a-4ffb-ad6f-f93e40283e8a@linaro.org>
 <426dbf1d-cfa8-4fd4-b857-8b8a283dd55e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lmB3YdtX8sjyw7UWJ0ORmn6p-FmGa1df
X-Proofpoint-ORIG-GUID: rY7gIb9dMK3djrKamF-xVAnxrs_zR2YV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=659 impostorscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2024-07-04 at 14:48 -0700, Richard Henderson wrote:
> On 7/4/24 08:18, Richard Henderson wrote:
> > On 7/4/24 07:50, Ilya Leoshkevich wrote:
> > > On Tue, 2024-07-02 at 16:41 -0700, Richard Henderson wrote:
> > > > While looking into Zoltan's attempt to speed up ppc64 DCBZ
> > > > (data cache block set to zero), I wondered what AArch64 was
> > > > doing differently.=C2=A0 It turned out that Arm is the only user
> > > > of tlb_vaddr_to_host.
> > > >=20
> > > > None of the code sequences in use between AArch64, Power64 and
> > > > S390X
> > > > are 100% safe, with race conditions vs mmap et al, however,
> > > > AArch64
> > > > is the only one that will fail this single threaded test case.=C2=
=A0
> > > > Use
> > > > of these new functions fixes the race condition as well, though
> > > > I
> > > > have not yet touched the other guests.
> > > >=20
> > > > I thought about exposing accel/tcg/user-retaddr.h for direct
> > > > use
> > > > from the targets, but perhaps these wrappers are cleaner.=C2=A0 RFC=
?
> > > >=20
> > > >=20
> > > > r~
> > > >=20
> > > >=20
> > > > Richard Henderson (2):
> > > > =C2=A0=C2=A0 accel/tcg: Introduce memset_ra, memmove_ra
> > > > =C2=A0=C2=A0 target/arm: Use memset_ra, memmove_ra in helper-a64.c
> > > >=20
> > > > =C2=A0=C2=A0include/exec/cpu_ldst.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++
> > > > =C2=A0=C2=A0accel/tcg/user-exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++++
> > > > =C2=A0=C2=A0target/arm/tcg/helper-a64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 10 ++--
> > > > =C2=A0=C2=A0tests/tcg/multiarch/memset-fault.c | 77
> > > > ++++++++++++++++++++++++++++++
> > > > =C2=A0=C2=A04 files changed, 144 insertions(+), 5 deletions(-)
> > > > =C2=A0=C2=A0create mode 100644 tests/tcg/multiarch/memset-fault.c
> > >=20
> > > This sounds good to me.
> > >=20
> > > I haven't debugged it, but I wonder why doesn't s390x fail here.
> > > For XC with src =3D=3D dst, it does access_memset() ->
> > > do_access_memset()
> > > -> memset() without setting the RA. And I don't think that
> > > anything
> > > around it sets the RA either.
> >=20
> > s390x uses probe_access_flags, which verifies the page is mapped
> > and writable, and raises=20
> > the exception when it isn't.=C2=A0 In contrast, for user-only,
> > tlb_vaddr_to_host *only*=20
> > performs the guest -> host address mapping, i.e. (addr +
> > guest_base).
>=20
> I should clarify: probe_access_flags verifies that the page is mapped
> *at that moment*,=20
> but does not take the mmap_lock.=C2=A0 So the race is that the page can b=
e
> unmapped by another=20
> thread after probe_access_flags and before the memset completes.

I see, thanks. I completely overlooked the access_prepare() calls.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

