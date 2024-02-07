Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D969FC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkad-0001xL-Km; Wed, 07 Feb 2024 11:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rXkaT-0001vN-1p
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:15:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rXkaQ-0001vL-Mo
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:15:48 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417FbDeh024934; Wed, 7 Feb 2024 16:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xkdBSKWeI0YNU0fcFh2/lK5lgYj7W18YVvd1hRFT69k=;
 b=eDlGUF7rT0gytau6QcFMJive2bnnV37kx/GP80LI2IW4tSxA56us0B6hjt85N0oIvEGn
 TELzTNuD4PFmfs2/Z98bYHrD+tbDHezWDpU1b9jTrVihA2Q8LQbBhINkrqMj4pDuZ8v9
 YQwA4dmnzOaFXzUQryWu2vTKcHynqnBHVvMPU4kDqjwEELLoobc88RyXwHKYR1kWvdCb
 AYoZurSJJDW86MP2vYDG50be0NZ5YRhfK8FL7drtkFeAlkZF7XS6Jl/7rnwnVlu5r1vw
 zKH7JictvfuocDCe6GeXjYzrXg/79QLvQb/WOZc0XhVBuOgVZ/ObkreCs3BQmjrcUApz XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4cnkh397-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:15:32 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 417GAuIJ015671;
 Wed, 7 Feb 2024 16:15:31 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4cnkh38s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:15:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 417FVqku016148; Wed, 7 Feb 2024 16:15:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h26957-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:15:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 417GFSX28979110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Feb 2024 16:15:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 966CB2004B;
 Wed,  7 Feb 2024 16:15:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F77420040;
 Wed,  7 Feb 2024 16:15:28 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Feb 2024 16:15:28 +0000 (GMT)
Message-ID: <be8001fa50db711d0d5d9cbcfb6a752d2b057749.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] make vm-build-freebsd fixes
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Daniel
 P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
Date: Wed, 07 Feb 2024 17:15:27 +0100
In-Reply-To: <87sf24l3l9.fsf@draig.linaro.org>
References: <20240206002344.12372-1-iii@linux.ibm.com>
 <87sf24l3l9.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q8ERSkGN-9yn6Ek_Mqbxc5qVm6jX-DzG
X-Proofpoint-ORIG-GUID: Da5nEe6SjoGKFnqMLONVFs62JEDx5bf2
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=889
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Wed, 2024-02-07 at 15:02 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > v2:
> > https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00890.html
> > v2 -> v3: Structure the meson check similar to have_asan_fiber;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reduce the conte=
xt size a little (Philippe).
> >=20
> > v1:
> > https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05155.html
> > v1 -> v2: Link with libinotify instead of disabling the inotify
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support (Daniel).
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Use a bit more c=
ontext lines in order to prevent the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 incorrect applic=
ation of the test patch.
> >=20
> > Hi,
> >=20
> > I needed to verify that my qemu-user changes didn't break BSD, and
> > Daniel Berrange suggested vm-build-freebsd on IRC. I had several
> > problems with it, which this series resolves.
>=20
> Queued to testing/next, thanks.

Hi Alex,

thanks! But I think Thomas already took it into his tree:

https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg01015.html

Best regards,
Ilya

