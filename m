Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5566CF5361
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3aJE-0002M8-QN; Wed, 23 Oct 2024 08:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3aJ8-0002Lg-4c; Wed, 23 Oct 2024 08:17:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3aIy-0001ED-VN; Wed, 23 Oct 2024 08:17:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0O2Qk018182;
 Wed, 23 Oct 2024 12:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2oYIub
 je1s/WIebtYf+zDCBbLYyNNOGCIJaFvIBrxyE=; b=n2loIoLo7zCrJJv/kop4fs
 Jv6yrNs+63aEzn6owe1nxIJ/8R1FS0tNusQ0accJFrcuWJuOnP4/EHImE2PZzz7n
 EmSSRkY2M/J71mSzrg4Yl0qmoSO69RsGBS2/wHKhoQJRmKaPpUswMuJIuCvCasKG
 +XdfljHGXnFe8Fh6tDUzg6+z0WP6tCp3vxJCjg0q+S2FwyH6d1eb93uFon5P2apt
 JrP+UhhnV+vGCBk4ghfXqej8+mmcC/r68xcJtyNxiufMnYB08NNyVnpuxJAhQdmS
 u7qnIwGpFsCBQidjP+y3aNjb4fQn56/Zr0uxILHWtxU4Fq4FbJvatIxwWB6yI+2A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajjvt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 12:17:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NCEAoJ030959;
 Wed, 23 Oct 2024 12:17:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajjvt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 12:17:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBXp8A014286;
 Wed, 23 Oct 2024 12:17:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfjs53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 12:17:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49NCHI3G27525778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 12:17:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD16B2004B;
 Wed, 23 Oct 2024 12:17:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12ED020040;
 Wed, 23 Oct 2024 12:17:18 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 12:17:17 +0000 (GMT)
Message-ID: <935ba5fe7f761e641e9bcdd2e000c6e6c0c12fba.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: Replace -mpower8-vector with -mvsx
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Kewen Lin <linkw@linux.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Wed, 23 Oct 2024 14:17:17 +0200
In-Reply-To: <56b09f33-d176-4489-989a-ddf02329636f@linaro.org>
References: <20241021142830.486149-1-iii@linux.ibm.com>
 <56b09f33-d176-4489-989a-ddf02329636f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RBK3qo4xVbVycV3-0LjAy-syZmu2D7yZ
X-Proofpoint-GUID: Tc-Xr5rHZPn4H3UJbx5nVs1PfBDyWOZL
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Mon, 2024-10-21 at 19:59 -0700, Richard Henderson wrote:
> On 10/21/24 07:27, Ilya Leoshkevich wrote:
> > [1] deprecated -mpower8-vector, resulting in:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 powerpc64-linux-gnu-gcc: warning: switch '-mpo=
wer8-vector' is
> > no longer supported
> > =C2=A0=C2=A0=C2=A0=C2=A0 qemu/tests/tcg/ppc64/vsx_f2i_nan.c:4:15: error=
: expected ';'
> > before 'float'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 | typedef vector flo=
at vsx_float32_vec_t;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^~~~~~
> >=20
> > Similar to how this was done for the GCC testcases, replace
> > -mpower8-vector with -mvsx.
> >=20
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D109987
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 tests/tcg/ppc64/Makefile.target | 10 +++++-----
> > =C2=A0 1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/tests/tcg/ppc64/Makefile.target
> > b/tests/tcg/ppc64/Makefile.target
> > index 1940886c737..d1b00d2bf09 100644
> > --- a/tests/tcg/ppc64/Makefile.target
> > +++ b/tests/tcg/ppc64/Makefile.target
> > @@ -6,7 +6,7 @@ VPATH +=3D $(SRC_PATH)/tests/tcg/ppc64
> > =C2=A0=20
> > =C2=A0 config-cc.mak: Makefile
> > =C2=A0=C2=A0	$(quiet-@)( \
> > -	=C2=A0=C2=A0=C2=A0 $(call cc-option,-mpower8-vector,=C2=A0=C2=A0
> > CROSS_CC_HAS_POWER8_VECTOR); \
> > +	=C2=A0=C2=A0=C2=A0 $(call cc-option,-mvsx,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CROSS_CC_HAS_VSX);
> > \
> > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0 $(call cc-option,-mpower10,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > CROSS_CC_HAS_POWER10)) 3> config-cc.mak
>=20
> I don't think this is quite right.
> I think you need -mpower8 to get OPTION_MASK_P8_VECTOR set.

Do you mean -mcpu=3Dpower8? -mpower8 is a GAS option.

>=20
> > +ifneq ($(CROSS_CC_HAS_VSX),)
> > =C2=A0 PPC64_TESTS=3Dbcdsub non_signalling_xscv
>=20
> bcdsub is not in the base VSX instruction set, for instance.
>=20
>=20
> r~

I was confused why -mvsx works in practice, so I spent some time and
managed to create a "hostile" gcc build, in which this is now a
problem, using:

    ./configure --target=3Dpowerpc64-linux-gnu --enable-checking \
                --disable-bootstrap \
                --with-as=3D"$(which powerpc64-linux-gnu-as)"

The issue is masked by two things:

- GCC passes "-many" to GAS. GCC commit e154242724b0 ("[RS6000] Don't
  pass -many to the assembler") stops --enable-checking builds from
  doing this.

- binutils has the following line:

  /* The minimum supported cpu for 64-bit little-endian is power8.  */
  ppc_cpu |=3D ppc_parse_cpu (ppc_cpu, &sticky, "power8");

  so one needs to use the big-endian toolchain to see the problem.


I'll send a v2.

