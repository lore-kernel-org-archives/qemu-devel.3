Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93E7C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAaV-0004kv-Vs; Wed, 31 Jan 2024 08:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVAaT-0004cX-94
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:25:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVAaR-00088z-8j
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:25:08 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VCTmBh019093; Wed, 31 Jan 2024 13:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=I9H/6vahux8z385ohjTnUDjcChmX0oDRIjS5NnTxqDA=;
 b=Z6M45kwKvhP3i24uzpKlsuR6fSDlsEjE6+wHHyq96qqoEnKtpQr/bWgYdIquM0iSIgWO
 JxoHKu4K9mFYWIx4uwfnAUKd4fCTkNq6CZbr7gsAn4GCHRgVgUO1vTZppT3xMd18PkF/
 f/Q0o1qIHVEdQlmjECnTIki5nymc915T3ScCAv17jTka4HQurPRB7l+d7GK1Wgyv+wSf
 kAlziWUnGIJcnHDylDGFBWMGXWJGu636MZH2bxvDO3vhRzkT/21vGMjm4Ei5hkGWoyqq
 7WWdt+k5QhsECAjXboT8xKVca1EeCR+xTG3JHyEuXbi819RNy3unmXPZ4jdC23KCJ+fO +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vymu83rh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 13:25:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VD5aVf002670;
 Wed, 31 Jan 2024 13:25:01 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vymu83rgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 13:25:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VD7MuK007179; Wed, 31 Jan 2024 13:25:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2d59h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 13:25:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VDOx8u16974412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 13:24:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AE682004B;
 Wed, 31 Jan 2024 13:24:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABE8C20040;
 Wed, 31 Jan 2024 13:24:58 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 13:24:58 +0000 (GMT)
Message-ID: <c119a9db6b352f4b4f4f3dbe86a7c8fd92dd10e2.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] make vm-build-freebsd fixes
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Kyle
 Evans <kevans@freebsd.org>, qemu-devel@nongnu.org
Date: Wed, 31 Jan 2024 14:24:58 +0100
In-Reply-To: <60d24401-8ccd-4ee6-ad58-8cff0d725209@redhat.com>
References: <20240125194840.1564-1-iii@linux.ibm.com>
 <60d24401-8ccd-4ee6-ad58-8cff0d725209@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E-aMbsUhho9w4ZT48_YHu6aBFzXo2_ma
X-Proofpoint-ORIG-GUID: YY3s7q2PfoyrU9hwYQsfH6f3xQE4qzrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=981 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310102
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

On Wed, 2024-01-31 at 14:24 +0100, Thomas Huth wrote:
> On 25/01/2024 20.48, Ilya Leoshkevich wrote:
> > Hi,
> >=20
> > I needed to verify that my qemu-user changes didn't break BSD, and
> > Daniel Berrange suggested vm-build-freebsd on IRC. I had several
> > problems with it, which this series resolves.
> >=20
> > Best regards,
> > Ilya
> >=20
> > Ilya Leoshkevich (3):
> > =C2=A0=C2=A0 tests/vm: Set UseDNS=3Dno in the sshd configuration
> > =C2=A0=C2=A0 tests/vm/freebsd: Reload the sshd configuration
> > =C2=A0=C2=A0 meson: Disable CONFIG_NOTIFY1 on FreeBSD
> >=20
> > =C2=A0 meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0 tests/vm/basevm.py | 2 ++
> > =C2=A0 tests/vm/freebsd=C2=A0=C2=A0 | 2 ++
> > =C2=A0 3 files changed, 5 insertions(+)
>=20
> Tested-by: Thomas Huth <thuth@redhat.com>
>=20
> I can take the patches through my tree (and fix the second patch to
> use=20
> console_wait_send() if you don't mind).
>=20
> =C2=A0 Thomas
>=20

Sure, that sounds good to me. Thanks!

