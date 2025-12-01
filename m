Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DDDD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ2XF-0001If-LX; Mon, 01 Dec 2025 06:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vQ2XD-0001Hx-Vg; Mon, 01 Dec 2025 06:57:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vQ2XB-0002qs-UX; Mon, 01 Dec 2025 06:57:39 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AULxtl8014086;
 Mon, 1 Dec 2025 11:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HmJq7C
 MYQ9bEbzgs7XbXfEyzhwPvUUePc4yKVFopaqY=; b=gMJJSUbYCMTX8TZEVLk1XG
 9LAT8uVMc8+ZGLOLXLvnjf0+l++xK9VeX8ilYx42RX4A+iOKJ2MBAEkZidClPpLs
 oo/p/4f3BYvn7SqtPz8yVUlrXQauBozo5n32LYNo7Uyd90cVJfF8MBSezE3oAbQK
 Z/bSZAv/Z6iQQuX5k0t6+oI8nPb7OwvOyrWNRJZE7arMDCYCJLpuaGMQz0bNgE2l
 7HRlYRBLut1jd1o6NsQupL4e3O8ThPG4nvRiyNMyK0aubxRrfGuaelEGJDnYqzSn
 O7zLTNYi+KkTw06TWgb95viksFCTr4U0gG8uPJLRY/zEz359geiD59R07zcF1CCg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg56s4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 11:57:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B19bdh2008521;
 Mon, 1 Dec 2025 11:57:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arc5mp5s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 11:57:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B1BvVtQ15663542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Dec 2025 11:57:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC21320049;
 Mon,  1 Dec 2025 11:57:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99BB520040;
 Mon,  1 Dec 2025 11:57:31 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.1.154])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Dec 2025 11:57:31 +0000 (GMT)
Message-ID: <d569827e7ef381842771738fae6c8f8bb30062ad.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Date: Mon, 01 Dec 2025 12:57:31 +0100
In-Reply-To: <f5a9796601bb90f754be75b9366149aafa2a9bb0.camel@linux.ibm.com>
References: <20251128133949.181828-1-thuth@redhat.com>
 <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
 <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
 <87zf838o2w.fsf@draig.linaro.org>
 <4bf61173827c033f9591f637f83d1aedc056a51e.camel@linux.ibm.com>
 <dfc4b7b2bdb7a6678364516de03a23959965de1e.camel@linux.ibm.com>
 <6181bc6bd6b41f46a835cee58ab3215b8cefedb4.camel@linux.ibm.com>
 <87ldjmv689.fsf@draig.linaro.org>
 <f5a9796601bb90f754be75b9366149aafa2a9bb0.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CiMBj4eRpNqMmjzfVCsrIODFQ_UrO2Yo
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692d82ae cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=5anqSEiUEPLlCeInwvMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX4Zh70FYPsIxq
 qImrhSZVHyj6pnwFVAwy47YUNtF4DwNbwECJ08Bfpan3S2DOFaxMPIkppWTKO7oENW6cW0l2Kje
 aKhh9U8pwNw7bhZnrBkufJd+O4x+CHuG6OE+d9FuMdhHoUPKjxIr5zSq3dkHGB7TERErmYu29Fc
 ePmcsMW9Q3WrHmbpLdCvj4T18ofNMCL58FHozIkSC6qaKESdXvRd6s1EoQU941L0ZvfJzdMAtiJ
 C8VymJiK9KnJ8f4Ij2GYlmM2RexCRGsslMx5PP5Ro894UcsbbB6PROlnXaaHsdDZXyGp3597h4v
 HbNJgUBoqUl7vYjFF2M7Sh1cp1kkhNkgN1Bo+N1gIpzEbBAHW9wKOONnULoMhMYDyH7q99daU/7
 DHmMuFU+buJv38jCAThip5KDld7SwQ==
X-Proofpoint-GUID: CiMBj4eRpNqMmjzfVCsrIODFQ_UrO2Yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 2025-12-01 at 12:17 +0100, Ilya Leoshkevich wrote:
> On Mon, 2025-12-01 at 10:36 +0000, Alex Benn=C3=A9e wrote:
> > Ilya Leoshkevich <iii@linux.ibm.com> writes:
> >=20
> > > On Sun, 2025-11-30 at 20:03 +0100, Ilya Leoshkevich wrote:
> > > > On Sun, 2025-11-30 at 19:32 +0100, Ilya Leoshkevich wrote:
> > > > > On Sun, 2025-11-30 at 16:47 +0000, Alex Benn=C3=A9e wrote:
> > > > > > Ilya Leoshkevich <iii@linux.ibm.com> writes:
> > > > > >=20
> > > > > > > On Fri, 2025-11-28 at 18:25 +0100, Ilya Leoshkevich
> > > > > > > wrote:
> > > > > > > > On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
> > > > > > > > > From: Thomas Huth <thuth@redhat.com>
> > > > > > > > >=20
> > > > > > > > > We just have to make sure that we can set the
> > > > > > > > > endianness to
> > > > > > > > > big
> > > > > > > > > endian,
> > > > > > > > > then we can also run this test on s390x.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > > > > > ---
> > > > > > > > > =C2=A0Marked as RFC since it depends on the fix for this
> > > > > > > > > bug
> > > > > > > > > (so
> > > > > > > > > it
> > > > > > > > > cannot
> > > > > > > > > =C2=A0be merged yet):
> > > > > > > > > =C2=A0
> > > > > > > > > https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c=
7-218212818891@redhat.com
> > > > > > > > > /
> > > > > > > > >=20
> > > > > > > > > =C2=A0tests/functional/reverse_debugging.py=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4
> > > > > > > > > +++-
> > > > > > > > > =C2=A0tests/functional/s390x/meson.build=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > > > > > > =C2=A0tests/functional/s390x/test_reverse_debug.py | 21
> > > > > > > > > ++++++++++++++++++++
> > > > > > > > > =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
> > > > > > > > > =C2=A0create mode 100755
> > > > > > > > > tests/functional/s390x/test_reverse_debug.py

[...]

> > > I believe now I at least understand what the race is about:
> > >=20
> > > - cpu_post_load() fires the TOD timer immediately.
> > >=20
> > > - s390_tod_load() schedules work for firing the TOD timer.
> >=20
> > Is this a duplicate of work then? Could we just rely on one or the
> > other? If you drop the cpu_post_load() tweak then the vmstate load
> > helper should still ensure everything works right?
>=20
> Getting rid of it fixes the problem and makes sense anyway.

Hmm, on the other hand, this appears to have been done this way
deliberately:


commit 7c12f710bad60dc7e509da4e80c77e952ef0490c
Author: David Hildenbrand <david@kernel.org>
Date:   Wed Jun 27 15:44:09 2018 +0200

    s390x/tcg: rearm the CKC timer during migration
   =20
    If the CPU data is migrated after the TOD clock, the CKC timer of a
CPU
    is not rearmed. Let's rearm it when loading the CPU state.
   =20
    Introduce tcg-stub.c just like kvm-stub.c for tcg specific stubs.


I guess introducing a dependency on migration order is indeed not great
for maintainability.

> > > - If rr loop sees work and then timer, we get one timer callback.
> > >=20
> > > - If rr loop sees timer and then work, we get two timer
> > > callbacks.
> >=20
> > If the timer is armed we should expect at least to execute a few
> > instructions before triggering the timer, unless it was armed ready
> > expired.
>=20
> Yes, it is armed expired.
>=20
>=20
> Isn't it a deficiency in record-replay that work and timers are not
> ordered relative to each other? Can't it bite us somewhere else?

[...]
>=20

