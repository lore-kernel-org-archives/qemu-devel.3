Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C48D1CDCA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BXN-0001Si-C1; Tue, 22 Oct 2024 05:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3BXI-0001Rq-3R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:50:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3BXC-0002Df-D3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:50:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M3RAsf011316;
 Tue, 22 Oct 2024 09:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IcHUH9
 +lJ2EfdsZiMckmhPu3yv95Y4YaLONLhVrAPlw=; b=V2zf/9xUxU50MowHSJtsQB
 3MiIKhWcVgSULMyfqVV2TiGA6rwlEvCBXOW8FRk7Gn1nxQCm9tDbu7Fd3mkuwUom
 H29rcEBxSf3ArNz5dSmBH19hjtk848cTVL8o33yAQJtrgmUqlpYEP6DVDpLvYNE5
 3vHCOgKZ8arja0iaeT+mp2VHRdbsHbG7WAGm+KK0+KpwLVqvPGLDdvVFbXtPzfD1
 X1BIxgVTjQAtslntm6xwEDy4LpDmEa7MRH8KbCwArMH1B/E0MkRtVH1exSS0Zo1K
 7mmeklRaA2toEnEQm55T8J8NLC6ZS3IOVd9s9yrJ2+3PRQIg/qOHwiQLJSb+NnHw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmdx9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 09:50:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M5KRiW029439;
 Tue, 22 Oct 2024 09:50:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42crkk2g26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 09:50:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49M9oVtS18022728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 09:50:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E991E20043;
 Tue, 22 Oct 2024 09:50:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9766120040;
 Tue, 22 Oct 2024 09:50:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Oct 2024 09:50:30 +0000 (GMT)
Message-ID: <5a6ec294c6da14a2a65d3669ac4dcdc79934c452.camel@linux.ibm.com>
Subject: Re: [PATCH] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Date: Tue, 22 Oct 2024 11:50:30 +0200
In-Reply-To: <38ff2ca7-7156-4ad8-b777-dab689043ecc@linaro.org>
References: <20241021121820.483535-1-iii@linux.ibm.com>
 <38ff2ca7-7156-4ad8-b777-dab689043ecc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QdFBlXjNNs6V3mQITNwEoaQVj1ytnNHj
X-Proofpoint-GUID: QdFBlXjNNs6V3mQITNwEoaQVj1ytnNHj
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 2024-10-21 at 19:34 -0700, Richard Henderson wrote:
> On 10/21/24 05:17, Ilya Leoshkevich wrote:
> > Running qemu-i386 on a system running with SELinux in enforcing
> > mode
> > fails with:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 qemu-i386: tests/tcg/i386-linux-user/sigreturn=
-sigmask: Unable
> > to find a guest_base to satisfy all guest address mapping
> > requirements
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-ffffffff
> >=20
> > The reason is that main() determines mmap_min_addr from
> > /proc/sys/vm/mmap_min_addr, but SELinux additionally defines
> > CONFIG_LSM_MMAP_MIN_ADDR, which is normally larger: 32K or 64K,
> > but,
> > in general, can be anything. There is no portable way to query its
> > value: /boot/config, /proc/config and /proc/config.gz are distro-
> > and
> > environment-specific.
> >=20
> > For maximum compatibility, probing is required. Use
> > pgb_find_fallback()
> > for this purpose. The downside of this approach is that
> > mmap_min_addr
> > remains incorrect, but there don't seem to be any practical
> > consequences from this. If a correct mmap_min_addr will be required
> > in
> > the future, probing will need to be moved to linux-user main().
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 linux-user/elfload.c | 4 ++++
> > =C2=A0 1 file changed, 4 insertions(+)
>=20
> This is
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 https://gitlab.com/qemu-project/qemu/-/issues/25=
98
>=20
> which we closed as a system configuration / kernel bug.
>=20
> I'm open to working around the issue, because I can see it coming up
> again and again.
>=20
> In pgb_find_fallback, we use a skip value of 4M or 4G, using that
> skip as the base at=20
> which to begin the search.=C2=A0 I think it might be better to use this as
> the initial start=20
> point in pgb_find_itree as well, rather than mmap_min_addr.
>=20
> Since I never had a setup in which this triggered, would you be
> willing to test such a change?
>=20
>=20
> r~

The environment is a trixie container running on Fedora 40.

The following works, I can send a v2 if that's the preferred way to go:

--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2898,7 +2898,7 @@ static uintptr_t pgb_try_itree(const PGBAddrs
*ga, uintptr_t base,
 static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot
*root,
                                 uintptr_t align, uintptr_t brk)
 {
-    uintptr_t last =3D mmap_min_addr;
+    uintptr_t last =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;
     uintptr_t base, skip;
=20
     while (true) {

But just for my understanding, what is wrong with the current approach?
The intention here is to fix the weird case without affecting the happy
path. It also looks natural to try the fallback once the normal
handling fails.

