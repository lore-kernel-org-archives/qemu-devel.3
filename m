Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E910AD0C5F4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GgN-0007NU-M7; Fri, 25 Oct 2024 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t4GgL-0007N4-TH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:32:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t4GgJ-0002ZJ-Vb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:32:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P3eIad024270;
 Fri, 25 Oct 2024 09:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L66yiu
 vk0Y2KHG2mgwEulCHdBfxp4zH8gjtm7iLunVI=; b=cXDbAGVRb7jGqZJST886Nr
 vYu9TjZ7a9XAkOXBq+AdlhoZ1OVThK+8wka871U3SsbWTnyB/+8Q2KnvGzXn/QC2
 jhMRZay5FRYhxU0+RE6bsqkzf8DLEsVg2MMVBZgP+UuKm1RWWB3NkomPLQ9aDf+0
 ehLXukDhgIAVHCb/4AwZzDZW6BhA6abNPXfeO+vuTuMNAf42ptU23bFtLZkjU9US
 K2ShULhbAybnIvuoTuM4WilrGGMfVeTQ0OUKZFOzs4VZehZv9BNPtrZcA/F8VtyO
 9wCaYNPOCfA7YjZ4RO3rj84dJnshLtDb5I/61JtLN1Ytcjad8inOgExEQ6iBre3Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf562a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 09:32:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49P9WTNw032099;
 Fri, 25 Oct 2024 09:32:29 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaf5626-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 09:32:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P6PA6K001777;
 Fri, 25 Oct 2024 09:32:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9myss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 09:32:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49P9WQDD34931402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 09:32:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC2EE20109;
 Fri, 25 Oct 2024 09:32:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66C8620107;
 Fri, 25 Oct 2024 09:32:25 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 09:32:25 +0000 (GMT)
Message-ID: <6d3832490ebc7abc62652c9be1d27a70c5d7551c.camel@linux.ibm.com>
Subject: Ping: [PATCH v2 1/2] linux-user: Map low priority rt signals
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Brian Cain
 <bcain@quicinc.com>, "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>
Date: Fri, 25 Oct 2024 11:32:24 +0200
In-Reply-To: <2afc8b53-5a35-482c-aa89-c61a882cedf0@linaro.org>
References: <20240212205022.242968-1-iii@linux.ibm.com>
 <20240212205022.242968-2-iii@linux.ibm.com>
 <2afc8b53-5a35-482c-aa89-c61a882cedf0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kd0JLuk5mGOOSsmLzFXQeECq5i7OGC1C
X-Proofpoint-ORIG-GUID: VaMLhh9fk8nH-bqWxBgCCZ8pDgq3STwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250073
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

On Tue, 2024-02-13 at 07:51 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing Brian & Taylor
>=20
> On 12/2/24 21:45, Ilya Leoshkevich wrote:
> > Some applications want to use low priority realtime signals (e.g.,
> > SIGRTMAX). Currently QEMU cannot map all target realtime signals to
> > host signals, and chooses to sacrifice the end of the target
> > realtime
> > signal range.
> >=20
> > Change this to the middle of that range, hoping that fewer
> > applications
> > will need it.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 linux-user/signal.c | 18 +++++++++++++-----
> > =C2=A0 1 file changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/linux-user/signal.c b/linux-user/signal.c
> > index d3e62ab030f..a81533b563a 100644
> > --- a/linux-user/signal.c
> > +++ b/linux-user/signal.c
> > @@ -511,13 +511,14 @@ static int core_dump_signal(int sig)
> > =C2=A0=20
> > =C2=A0 static void signal_table_init(void)
> > =C2=A0 {
> > -=C2=A0=C2=A0=C2=A0 int hsig, tsig, count;
> > +=C2=A0=C2=A0=C2=A0 int hsig, hsig_count, tsig, tsig_count, tsig_hole,
> > tsig_hole_size, count;
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > -=C2=A0=C2=A0=C2=A0=C2=A0 * Signals are supported starting from TARGET_=
SIGRTMIN and
> > going up
> > -=C2=A0=C2=A0=C2=A0=C2=A0 * until we run out of host realtime signals.=
=C2=A0 Glibc uses the
> > lower 2
> > -=C2=A0=C2=A0=C2=A0=C2=A0 * RT signals and (hopefully) nobody uses the =
upper ones.
> > -=C2=A0=C2=A0=C2=A0=C2=A0 * This is why SIGRTMIN (34) is generally grea=
ter than
> > __SIGRTMIN (32).
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Signals are supported starting from TARGET_=
SIGRTMIN and up
> > to
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * TARGET_SIGRTMAX, potentially with a hole in=
 the middle of
> > this
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * range, which, hopefully, nobody uses. Glibc=
 uses the lower
> > 2 RT
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * signals; this is why SIGRTMIN (34) is gener=
ally greater
> > than
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * __SIGRTMIN (32).
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To fix this properly we would ne=
ed to do manual signal
> > delivery
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * multiplexed over a single host s=
ignal.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Attempts for configure "missing"=
 signals via sigaction
> > will be
> > @@ -536,9 +537,16 @@ static void signal_table_init(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_to_target_signal_table[SIGABRT] =3D=
 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_to_target_signal_table[hsig++] =3D =
TARGET_SIGABRT;
> > =C2=A0=20
> > +=C2=A0=C2=A0=C2=A0 hsig_count =3D SIGRTMAX - hsig + 1;
> > +=C2=A0=C2=A0=C2=A0 tsig_count =3D TARGET_NSIG - TARGET_SIGRTMIN + 1;
> > +=C2=A0=C2=A0=C2=A0 tsig_hole_size =3D tsig_count - MIN(hsig_count, tsi=
g_count);
> > +=C2=A0=C2=A0=C2=A0 tsig_hole =3D TARGET_SIGRTMIN + (tsig_count - tsig_=
hole_size) /
> > 2;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (tsig =3D TARGET_SIGRTMIN;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsig <=3D =
SIGRTMAX && tsig <=3D TARGET_NSIG;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsig++, ts=
ig++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsig =3D=3D tsig_hole) =
{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tsi=
g +=3D tsig_hole_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_to_target_s=
ignal_table[hsig] =3D tsig;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=20

Ping.

I wonder if it would make sense to make this configurable?

