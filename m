Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB57E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 11:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN9Fo-00086q-7X; Mon, 16 Dec 2024 06:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tN9Fm-00086Y-C2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 06:27:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tN9Fk-0001qn-GP
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 06:27:10 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3qsJU020128;
 Mon, 16 Dec 2024 11:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5wW2Gh
 ob9ARXluyfNcx0QSmf23N9t3icmTdRtNuTHAc=; b=fKzpYebSqc3T+N77EB0fkG
 mNWyKkHFqfaP3bOtEPGa0MHgiTvt0LOV1PgYFljiuURU0N3NVWSOAnd5/7er2sCt
 v7Hv7ePYluOZnDZ8UTWKk/ZbM6LI+btJwx1JPm18VTacxJ1lMk7TGJZ1n7X5r9YG
 gUu1EuNqJzcX93lidZs+5sF1QQnHb3u9g7MarcT+Ya5te5X7M8BghHL8V2g9Trq+
 45CC7Xwa3ldFYEPgmPISXYDSqVdsItHqMKm3zgUfxS0Axlw3yalqUK/IXE3e3hci
 Kfsme1EGGVrX53vSAEzKcf5Gb2Y3VVK+h3hN1I3kpHKoe4NRcB50rK35LEXcHvOA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgswc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 11:26:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9RN9Q005488;
 Mon, 16 Dec 2024 11:26:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbmwn72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 11:26:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BGBQSmC53215606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 11:26:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37F9420040;
 Mon, 16 Dec 2024 11:26:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F32E520043;
 Mon, 16 Dec 2024 11:26:27 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2024 11:26:27 +0000 (GMT)
Message-ID: <5d1097953195fefec40d5d00e480d2697d44deac.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: Do not use inttypes.h in
 multiarch/system/memory.c
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Mon, 16 Dec 2024 12:26:27 +0100
In-Reply-To: <727d4d4f-a299-4cdc-9723-c6b943d526ab@linaro.org>
References: <20241010085906.226249-1-iii@linux.ibm.com>
 <59b7a93e-7acb-4a73-9aae-bbfb36101c5d@redhat.com>
 <4f0cab2f2d564037e1a36a75ad1fb9d350c0f0e1.camel@linux.ibm.com>
 <727d4d4f-a299-4cdc-9723-c6b943d526ab@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hx0PoJ41-sNl1tNCDyblN5CNHuCRWuSy
X-Proofpoint-ORIG-GUID: hx0PoJ41-sNl1tNCDyblN5CNHuCRWuSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.168, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 2024-11-04 at 11:34 +0000, Richard Henderson wrote:
> On 10/29/24 23:29, Ilya Leoshkevich wrote:
> > On Thu, 2024-10-10 at 11:20 +0200, Paolo Bonzini wrote:
> > > On 10/10/24 10:58, Ilya Leoshkevich wrote:
> > > > make check-tcg fails on Fedora with the following error
> > > > message:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alpha-linux-gnu-gcc [...]
> > > > qemu/tests/tcg/multiarch/system/memory.c -o memory [...]
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu/tests/tcg/multiarch/system/memo=
ry.c:17:10: fatal
> > > > error:
> > > > inttypes.h: No such file or directory
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17 | #include <int=
types.h>
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compilation terminated.
> > > >=20
> > > > The reason is that Fedora has cross-compilers, but no cross-
> > > > glibc
> > > > headers. Fix by hardcoding the format specifiers and dropping
> > > > the
> > > > include.
> > > >=20
> > > > An alternative fix would be to introduce a configure check for
> > > > inttypes.h. But this would make it impossible to use Fedora
> > > > cross-compilers for softmmu tests, which used to work so far.
> > > >=20
> > > > Fixes: ecbcc9ead2f8 ("tests/tcg: add a system test to check
> > > > memory
> > > > instrumentation")
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > >=20
> > > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> >=20
> > [...]
> >=20
> > Thanks for the review!
> >=20
> > Could someone please pick this one and also [1] up?
> > Both patches are aimed at improving the situation with the test
> > builds.
> >=20
> > [1]
> > https://lore.kernel.org/qemu-devel/20241023131250.48510-1-iii@linux.ibm=
.com/
>=20
> Queued, thanks.
>=20
> r~

Hi Richard,

I noticed that this patch doesn't seem to be in master yet. Could it be
that it was overlooked, or is there some issue with it that I missed?

Best regards,
Ilya

