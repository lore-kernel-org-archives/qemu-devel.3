Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E320FD149D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4OFs-00063I-4G; Fri, 25 Oct 2024 13:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t4OFq-000632-2I
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:37:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t4OFk-0008Nf-97
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:37:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEfvIU014796;
 Fri, 25 Oct 2024 17:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NEOIoi
 uTBeCawxAHkYXMOgFNEXgDDOmyfkrziA0LBkI=; b=O6CixqsqFbyKVBjYZJrSGz
 tHKieyYrQMJg3GFC5ZiK84cFz7G02wsDhXHhVLXYwUFs9Nk/a4GGRy4KB/9V7xD7
 VJB/expxe55Vsd1yFUSn3UuQKLgKB3pblclYaNx1+cMcDzZtXnqAeCR20jIu8l/3
 Qluq1JkN37wcskljxFZXT2k9jAGQTF2gzQXOJNUYJ6i8o7GiBvPsp410jNP8uTgk
 uLmOjNhTJdVma3sWYcyFLslxChWfO/Y4e5qkx1lYx5NQcQnIAPWZBDP0T+McvRVl
 qYNf2tNknKsVb5CG4mjnXabJOm9WqL1rCF5+szyrnq+ajw/Gh777Oobfwg74EuOA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emae7uq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:37:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49PHbVpb012514;
 Fri, 25 Oct 2024 17:37:31 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emae7uq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:37:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEGff6008807;
 Fri, 25 Oct 2024 17:37:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkaxvs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:37:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49PHbTmo54132996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 17:37:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2A6420043;
 Fri, 25 Oct 2024 17:37:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F0B020040;
 Fri, 25 Oct 2024 17:37:28 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 17:37:28 +0000 (GMT)
Message-ID: <122e27ee6bb5952b4bd58df89eb20b29c3954ac7.camel@linux.ibm.com>
Subject: Re: Ping: [PATCH v2 1/2] linux-user: Map low priority rt signals
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Brian Cain
 <bcain@quicinc.com>, "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>
Date: Fri, 25 Oct 2024 19:37:27 +0200
In-Reply-To: <b45d04e1-b6f5-4b70-a59d-3df4320b8b07@linaro.org>
References: <20240212205022.242968-1-iii@linux.ibm.com>
 <20240212205022.242968-2-iii@linux.ibm.com>
 <2afc8b53-5a35-482c-aa89-c61a882cedf0@linaro.org>
 <6d3832490ebc7abc62652c9be1d27a70c5d7551c.camel@linux.ibm.com>
 <b45d04e1-b6f5-4b70-a59d-3df4320b8b07@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _aC61osR2PpFfxS6nzFIAoprxB5t-l5A
X-Proofpoint-GUID: q05DAao3n8Q5p7nmoztfiTpKj3FxJ3R8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 2024-10-25 at 16:36 +0100, Richard Henderson wrote:
> On 10/25/24 10:32, Ilya Leoshkevich wrote:
> > On Tue, 2024-02-13 at 07:51 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Cc'ing Brian & Taylor
> > >=20
> > > On 12/2/24 21:45, Ilya Leoshkevich wrote:
> > > > Some applications want to use low priority realtime signals
> > > > (e.g.,
> > > > SIGRTMAX). Currently QEMU cannot map all target realtime
> > > > signals to
> > > > host signals, and chooses to sacrifice the end of the target
> > > > realtime
> > > > signal range.
> > > >=20
> > > > Change this to the middle of that range, hoping that fewer
> > > > applications
> > > > will need it.
> > > >=20
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > > =C2=A0=C2=A0 linux-user/signal.c | 18 +++++++++++++-----
> > > > =C2=A0=C2=A0 1 file changed, 13 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/linux-user/signal.c b/linux-user/signal.c
> > > > index d3e62ab030f..a81533b563a 100644
> > > > --- a/linux-user/signal.c
> > > > +++ b/linux-user/signal.c
> > > > @@ -511,13 +511,14 @@ static int core_dump_signal(int sig)
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0 static void signal_table_init(void)
> > > > =C2=A0=C2=A0 {
> > > > -=C2=A0=C2=A0=C2=A0 int hsig, tsig, count;
> > > > +=C2=A0=C2=A0=C2=A0 int hsig, hsig_count, tsig, tsig_count, tsig_ho=
le,
> > > > tsig_hole_size, count;
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 * Signals are supported starting from TAR=
GET_SIGRTMIN and
> > > > going up
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 * until we run out of host realtime signa=
ls.=C2=A0 Glibc uses
> > > > the
> > > > lower 2
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 * RT signals and (hopefully) nobody uses =
the upper ones.
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 * This is why SIGRTMIN (34) is generally =
greater than
> > > > __SIGRTMIN (32).
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Signals are supported starting from TAR=
GET_SIGRTMIN and
> > > > up
> > > > to
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * TARGET_SIGRTMAX, potentially with a hol=
e in the middle
> > > > of
> > > > this
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * range, which, hopefully, nobody uses. G=
libc uses the
> > > > lower
> > > > 2 RT
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * signals; this is why SIGRTMIN (34) is g=
enerally greater
> > > > than
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 * __SIGRTMIN (32).
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To fix this properly w=
e would need to do manual
> > > > signal
> > > > delivery
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * multiplexed over a sin=
gle host signal.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Attempts for configure=
 "missing" signals via
> > > > sigaction
> > > > will be
> > > > @@ -536,9 +537,16 @@ static void signal_table_init(void)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_to_target_signal_table[SI=
GABRT] =3D 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_to_target_signal_table[hs=
ig++] =3D TARGET_SIGABRT;
> > > > =C2=A0=C2=A0=20
> > > > +=C2=A0=C2=A0=C2=A0 hsig_count =3D SIGRTMAX - hsig + 1;
> > > > +=C2=A0=C2=A0=C2=A0 tsig_count =3D TARGET_NSIG - TARGET_SIGRTMIN + =
1;
> > > > +=C2=A0=C2=A0=C2=A0 tsig_hole_size =3D tsig_count - MIN(hsig_count,=
 tsig_count);
> > > > +=C2=A0=C2=A0=C2=A0 tsig_hole =3D TARGET_SIGRTMIN + (tsig_count -
> > > > tsig_hole_size) /
> > > > 2;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (tsig =3D TARGET_SIGRTMIN;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
hsig <=3D SIGRTMAX && tsig <=3D TARGET_NSIG;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
hsig++, tsig++) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsig =3D=3D tsig_ho=
le) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 tsig +=3D tsig_hole_size;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_t=
o_target_signal_table[hsig] =3D tsig;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=20
> >=20
> > Ping.
> >=20
> > I wonder if it would make sense to make this configurable?
>=20
> There are plenty of IPC use-cases for which we need a consistent
> mapping of guest signals.=20
> =C2=A0 Because we must steal some for emulation, we cannot give the guest
> the full set.=C2=A0 But=20
> you're right that different applications allocate the rt signals
> differently, and=20
> arbitrarily nixing the highest signal numbers may be problematic.
>=20
> Nixing the middle rt signals seems equally problematic, so some sort
> of configuration=20
> seems the only solution.=C2=A0 Perhaps we could come up with some
> generalized mapping?

Sounds good. I guess we don't need that for non-realtime signals?

Perhaps we could use the same logic as uid_map?

export QEMU_RTSIG_MAP=3D"tsig1 hsig1 n1,tsig2 hsig2 len2"

If specified, [hsig, hsig+n) will be mapped to [tsig, tsig+n), and
qemu-user will exit with an error if either is out of range or there
are no host realtime signals left to steal.

If not specified, today's mapping will be used. I think it may also
make sense to make the default configurable, e.g., with
./configure --default-rtsig-map-ppc64le=3D"tsig1 hsig1 n1"

What do you think?

