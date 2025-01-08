Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CE2E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYhY-00069f-J8; Wed, 08 Jan 2025 11:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVYhX-00068G-0V
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:14:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVYhV-00035x-5z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:14:34 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508BhNGU025541;
 Wed, 8 Jan 2025 16:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=y2KCmI
 /7khv71Iy8c1LpsoPS2xA2m+oEXJaeqb9UBUs=; b=BrJN+CH/865NkVFPdeSQXU
 PCeWxO9YahDFR7yRlIb28qqZD/EbgeCD7b41GWfqGmdmTsKTq2+gE+BW0Lv3W3uJ
 08E9HRZp6EkBuUmmTOCgw537UrelWtI+LgvEjOPum+FemruI5sk43uuTs9UM0Okv
 ZI3UHcoQ2I1TGTGAX0nnJJac6CuJPZ6lVcg1MyHQ6HEEJONR1ebLX+fEGXZ2ZYtk
 lY7uS7hpYuU7psGwiBGGi9oP/pukG4C6Qa2N2nrsmFOemuz/BO61osj+eQurRIVw
 j4duS77GqFF/eV0xHlaWqbopdmWJc//PsmCa0r8pO1/BlMClP+deoCB0kIcj8H9Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441edj3yn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 16:14:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DMBwh013641;
 Wed, 8 Jan 2025 16:14:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap0gu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 16:14:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508GEHRb44892566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 16:14:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D950920043;
 Wed,  8 Jan 2025 16:14:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6460020040;
 Wed,  8 Jan 2025 16:14:17 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 16:14:17 +0000 (GMT)
Message-ID: <dbdc943984d3d7ceded8b793be0cc0f546aae971.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] gdbstub: Try unlinking the unix socket before
 binding
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent
 Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Date: Wed, 08 Jan 2025 17:14:17 +0100
In-Reply-To: <875xmpb82n.fsf@draig.linaro.org>
References: <20241216123412.77450-1-iii@linux.ibm.com>
 <20241216123412.77450-3-iii@linux.ibm.com>
 <875xmpb82n.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zlIVG_0z2SNJhQIdH-38cXyOlXDpVVV7
X-Proofpoint-ORIG-GUID: zlIVG_0z2SNJhQIdH-38cXyOlXDpVVV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=961 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080133
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 2025-01-08 at 16:10 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > In case an emulated process execve()s another emulated process,
> > bind()
> > will fail, because the socket already exists. So try deleting it.
> >=20
> > Note that it is not possible to handle this in do_execv(): deleting
> > gdbserver_user_state.socket_path before safe_execve() is not
> > correct,
> > because the latter may fail, and afterwards we may lose control.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0gdbstub/user.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/gdbstub/user.c b/gdbstub/user.c
> > index ef52f249ce9..c900d0a52fe 100644
> > --- a/gdbstub/user.c
> > +++ b/gdbstub/user.c
> > @@ -337,6 +337,7 @@ static int gdbserver_open_socket(const char
> > *path)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 sockaddr.sun_family =3D AF_UNIX;
> > =C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun=
_path) - 1,
> > path);
> > +=C2=A0=C2=A0=C2=A0 unlink(sockaddr.sun_path);
>=20
> Should we be checking for errors here? What do we expect when
> attempting
> to unlink a non-existent path? -EIO?

ENOENT I guess.
I will add a check that requires either success or ENOENT.

> > =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bind(fd, (struct sockaddr *)&sockaddr,
> > sizeof(sockaddr));
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("bind socket");


