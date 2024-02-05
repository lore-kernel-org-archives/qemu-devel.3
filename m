Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE4AC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 15:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX1Kg-0007EL-DH; Mon, 05 Feb 2024 10:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX1Kf-0007Dy-3o
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:56:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX1Kb-0005GV-MJ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:56:28 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415FfIi4012931; Mon, 5 Feb 2024 15:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hCA6A+Rask12r1xE2a5ZcFp0VAA2Ln5kqicANnJuzAg=;
 b=pDtgyLpPkKt4OIITBhb04KI+6/atOMYi9MKUwGRORaF6Q4SuhH2uDGA7jPOlEhhFgvJM
 LdgCEqAxZuVpPXR+ckswgjkpe7U27POnegmSs0KEgzNRGK2OlQrFXJ9nX0zilgpF7m8V
 seyQzCguSHyy1hXMmABynrQ+Y6ry8Prr5r/aaEm6bAqYgEPex4yA5v2PSgOXY1TKsY4j
 alZRfqqbBKyNd6kjik6Mk2xklsN36Daawqkhod36nocqLPQzIfGuJMm9naDrmrLs0sG3
 dGZysupATOhtV39b+yoGV0KtPsqNLjEY1XjZyaOEBjqCpAdzbZWc/0igdpM77fcBhATs jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w313mupd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 15:56:20 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415FqVpE026929;
 Mon, 5 Feb 2024 15:56:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w313mup6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 15:56:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415E5wrB014739; Mon, 5 Feb 2024 15:56:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnhd3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 15:56:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415Fu9Y620447752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 15:56:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7792520040;
 Mon,  5 Feb 2024 15:56:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 311BA2004B;
 Mon,  5 Feb 2024 15:56:09 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 15:56:09 +0000 (GMT)
Message-ID: <56191177ef5b9df3d1b6fffe19e76fbd851af5ff.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] meson: Disable CONFIG_NOTIFY1 on FreeBSD
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Warner
 Losh <imp@bsdimp.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu
 <lwhsu@freebsd.org>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 05 Feb 2024 16:56:09 +0100
In-Reply-To: <ZcD_bnSRD2XSLIp5@redhat.com>
References: <20240125194840.1564-1-iii@linux.ibm.com>
 <20240125194840.1564-4-iii@linux.ibm.com>
 <33c9ccef-fa8f-41e4-a7a1-17c3dffb9d9d@linaro.org>
 <Zbp4ekYJLQB-BIFo@redhat.com>
 <CANCZdfotNMgPadLA0o9+POcLeTN-rGoR+XkbqBHtjd+cZMy0Fg@mail.gmail.com>
 <ZcD_bnSRD2XSLIp5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOAIyJgaqmxbPlW7TbX8-aeCZYFyM1wS
X-Proofpoint-ORIG-GUID: wEet8l3e-KWw2SIe0Ge_C_bAUMtO8wLi
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 2024-02-05 at 15:31 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Feb 05, 2024 at 08:23:41AM -0700, Warner Losh wrote:
> > On Wed, Jan 31, 2024 at 9:42=E2=80=AFAM Daniel P. Berrang=C3=A9
> > <berrange@redhat.com>
> > wrote:
> >=20
> > > On Wed, Jan 31, 2024 at 05:24:10PM +0100, Philippe Mathieu-Daud=C3=A9
> > > wrote:
> > > > Hi,
> > > >=20
> > > > Warner, do you remember what this is about?
> > > >=20
> > > > (
> > > https://cgit.freebsd.org/ports/commit/emulators/qemu-devel/files/patc=
h-util_meson.build?id=3D2ab482e2c8f51eae7ffd747685b7f181fe1b3809
> > > > isn't very verbose).
> > >=20
> > > That's simply going to workaround our incomplete feature
> > > check. We look for sys/inotify.h and if present, we
> > > assume that is in the C library. That's true on Linux,
> > > but not true on *BSD, hence the undefined symbol.
> > >=20
> > > We need to augment the header file check with a linker
> > > symbol check for the C library.
> > >=20
> > > If we wanted to also check for -linotify that'd make
> > > it portable to BSD, but not the behaviour difference
> > > mentioned below.
> > >=20
> > > >=20
> > > > On 25/1/24 20:48, Ilya Leoshkevich wrote:
> > > > > make vm-build-freebsd fails with:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 ld: error: undefined symbol: inotify_ini=
t1
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 >>> referenced by filemonitor-inotify.c:=
183
> > > (../src/util/filemonitor-inotify.c:183)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 >>>
> > > =C2=A0util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive
> > > libqemuutil.a
> > > > >=20
> > > > > On FreeBSD inotify functions are defined in libinotify.so, so
> > > > > it might
> > > > > be tempting to add it to the dependencies. Doing so, however,
> > > > > reveals
> > > > > that this library handles rename events differently from
> > > > > Linux:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 $ FILEMONITOR_DEBUG=3D1 build/tests/unit=
/test-util-
> > > > > filemonitor
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Rename /tmp/test-util-filemonitor-K13LI2=
/fish/one.txt ->
> > > /tmp/test-util-filemonitor-K13LI2/two.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Event id=3D200000000 event=3D2 file=3Don=
e.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Queue event id 200000000 event 2 file on=
e.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Queue event id 100000000 event 2 file tw=
o.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Queue event id 100000002 event 2 file tw=
o.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Queue event id 100000000 event 0 file tw=
o.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Queue event id 100000002 event 0 file tw=
o.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Event id=3D100000000 event=3D0 file=3Dtw=
o.txt
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Expected event 0 but got 2
> > >=20
> > > Interesting. So In the "Rename" test, the destination already
> > > exists.
> > >=20
> > > BSD is thus reporting that 'two.txt' is deleted, before being
> > > (re)created
> > > Linux is only reporting 'two.txt' is created.
> > >=20
> > > I don't think we can easily paper over this difference. The
> > > easiest is
> > > probably to conditionalize the test
> > >=20
> > > =C2=A0git diff
> > > diff --git a/tests/unit/test-util-filemonitor.c
> > > b/tests/unit/test-util-filemonitor.c
> > > index a22de27595..c3b2006365 100644
> > > --- a/tests/unit/test-util-filemonitor.c
> > > +++ b/tests/unit/test-util-filemonitor.c
> > > @@ -281,6 +281,14 @@ test_file_monitor_events(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .type =3D QFILE_MO=
NITOR_TEST_OP_EVENT,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .filesrc=
 =3D "one.txt", .watchid =3D &watch1,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .eventid=
 =3D QFILE_MONITOR_EVENT_DELETED },
> > > +#ifdef __FreeBSD__
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .type =3D QFILE_MONITOR=
_TEST_OP_EVENT,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .filesrc =3D =
"two.txt", .watchid =3D &watch0,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .eventid =3D =
QFILE_MONITOR_EVENT_DELETED },
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .type =3D QFILE_MONITOR=
_TEST_OP_EVENT,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .filesrc =3D =
"two.txt", .watchid =3D &watch2,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .eventid =3D =
QFILE_MONITOR_EVENT_DELETED },
> > > +#endif
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .type =3D QFILE_MO=
NITOR_TEST_OP_EVENT,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .filesrc=
 =3D "two.txt", .watchid =3D &watch0,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .eventid=
 =3D QFILE_MONITOR_EVENT_CREATED },
> > >=20
> >=20
> > I agree this is likely the best course of action. Has anybody filed
> > a bug
> > at https://bugs.freebsd.org?
>=20
> I've not, and I'm not even sure I would class it a FreeBSD bug. Other
> than the fact that it differs from Linux behaviour, it feels like it
> is reasonble semantics to emit a 'delete' event in this scenario so
> that an event consumer can detect replacement of an existing file.
>=20
> With regards,
> Daniel

Sounds reasonable; I will send a v2 with the meson adjustments and with
the test fix.

