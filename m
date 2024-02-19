Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCF8C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 13:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc3LA-0006xJ-6R; Mon, 19 Feb 2024 08:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc3L8-0006wv-26
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:05:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc3L5-0002nb-Gr
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:05:45 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JD1DNk015647; Mon, 19 Feb 2024 13:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=VvPGwbyVjzUCQIREq8/G8lILm3uLTLNSaohrQUiJ5Ak=;
 b=IgJ/P3o2OG7qfSwqyl//ha0KV7VofW/v7MYUI2UfpJLhdJj+4Tz6EcpCHK4CXirs8pp1
 LPv8rJitSCMp54HkVRjhruEufErQfBVtWeiYPZ6cMnYInItmPMB0ej5rK1q2xDST1fvD
 0hT/Rr0lrZF0HdDJDbRXhqZOB73+7DpPpfvI/2uGZ5sQCj5ICe1pkvFQUeQJfLx9nnZK
 kLRUQoXJcs8O0LDtfJtLQrjioi1aFYyW7ul3t/EETsswxljkh02PZ+SEIu232YLj+N0q
 hhcDcKLRHzyoC308TrLo1TNJRI+8p9njFqk2H2HCG4uGMYZDzxXP4olRP4sFCkv18iCg hw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb3w7frr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 13:05:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JAJfRT013452; Mon, 19 Feb 2024 13:05:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h01jg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 13:05:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JD5WpQ15205116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 13:05:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F8542006A;
 Mon, 19 Feb 2024 13:05:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 008C520040;
 Mon, 19 Feb 2024 13:05:32 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 13:05:31 +0000 (GMT)
Message-ID: <2310cfb390c130baf709ac18328556ac0b713146.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/11] gdbstub: Support disablement in a
 multi-threaded process
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Mon, 19 Feb 2024 14:05:31 +0100
In-Reply-To: <8e3732d9-129c-4514-bb7a-d4c5bdca90dd@linaro.org>
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-2-iii@linux.ibm.com>
 <8e3732d9-129c-4514-bb7a-d4c5bdca90dd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lU6SgO9LADL9D2KRd2ZhQQ2KjMVQVB9W
X-Proofpoint-GUID: lU6SgO9LADL9D2KRd2ZhQQ2KjMVQVB9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190097
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

On Sat, 2024-02-17 at 10:21 -1000, Richard Henderson wrote:
> On 2/16/24 03:05, Ilya Leoshkevich wrote:
> > The upcoming follow-fork-mode child support will require disabling
> > gdbstub in the parent process, which may have multiple threads
> > (which
> > are represented as CPUs).
> >=20
> > Loop over all CPUs in order to remove breakpoints and disable
> > single-step. Move the respective code into a separate function.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 gdbstub/user.c | 19 +++++++++++++++----
> > =C2=A0 1 file changed, 15 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/gdbstub/user.c b/gdbstub/user.c
> > index 14918d1a217..e17f7ece908 100644
> > --- a/gdbstub/user.c
> > +++ b/gdbstub/user.c
> > @@ -356,16 +356,27 @@ int gdbserver_start(const char *port_or_path)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > =C2=A0 }
> > =C2=A0=20
> > +static void disable_gdbstub(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0 CPUState *cpu;
> > +
> > +=C2=A0=C2=A0=C2=A0 close(gdbserver_user_state.fd);
> > +=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fd =3D -1;
> > +=C2=A0=C2=A0=C2=A0 CPU_FOREACH(cpu) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_breakpoint_remove_all(c=
pu, BP_GDB);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no cpu_watchpoint_remove=
_all for user-mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_single_step(cpu, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tb_flush(cpu);
>=20
> You only need to flush once.=C2=A0 The cpu argument is used to determine
> if we can perform the=20
> flush immediately or need to queue it.

I thought we needed to flush jump caches on all CPUs, but I see now
that do_tb_flush() already does this, so this loop is unnecessarily
quadratic.

Btw, shouldn't do_tb_flush() have cpu as a local variable, and not as
a parameter?

>=20
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~


