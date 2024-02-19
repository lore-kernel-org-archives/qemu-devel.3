Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D08FC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Tb-0002qb-CZ; Mon, 19 Feb 2024 09:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4TZ-0002eJ-K4
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:18:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4TX-0000kX-Si
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:18:33 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDUi1W018363; Mon, 19 Feb 2024 14:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=V/X1VdaAZnwuIDkS7fDmFg+mfXcj4D+XnX9LNiX6Wlw=;
 b=OdlUQlJJCWRsw9qSKAtmWMTyuc827lY7eu4UOfDNHwyI3rquC8uRCwT8gGsUDF5Gpp0n
 gMtvR+XA3DbAf3xH1trDZKpSlvX5lQDz+jMR5/idRW1WsJEcmbQGSW4UHWJwgA6iDJG3
 rcD/8xuJZwA7AlVgo0an2yUl9ZhYzC2RmiqLtx3fGA5FQRMImIBm0eJSDUOGT6qirvuU
 oziSmK3CnjjOv3rVfADpfOb3vpujR0PjezMAwfGqN1BTHGWdhu49uG9QVK7oyawnrk9G
 PJMBMAyQmEJ8p8nsZyhdoLOG3pXJERj41DOo0rkZKMuSghvAupNDk8EPAERT1vA/VtPo 6w== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb2p8kkds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:18:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JEGsfZ009551; Mon, 19 Feb 2024 14:18:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1n8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:18:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEILGY41353720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:18:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EA632004D;
 Mon, 19 Feb 2024 14:18:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CD4B2004B;
 Mon, 19 Feb 2024 14:18:21 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:18:21 +0000 (GMT)
Message-ID: <471ebba0055db993c8a3c57a290ce092358eb88b.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/11] gdbstub: Support disablement in a
 multi-threaded process
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Mon, 19 Feb 2024 15:18:21 +0100
In-Reply-To: <2310cfb390c130baf709ac18328556ac0b713146.camel@linux.ibm.com>
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-2-iii@linux.ibm.com>
 <8e3732d9-129c-4514-bb7a-d4c5bdca90dd@linaro.org>
 <2310cfb390c130baf709ac18328556ac0b713146.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rJNP-vUHH2DqEk1CTXc43GTUzqnoOlJa
X-Proofpoint-GUID: rJNP-vUHH2DqEk1CTXc43GTUzqnoOlJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2024-02-19 at 14:05 +0100, Ilya Leoshkevich wrote:
> On Sat, 2024-02-17 at 10:21 -1000, Richard Henderson wrote:
> > On 2/16/24 03:05, Ilya Leoshkevich wrote:
> > > The upcoming follow-fork-mode child support will require
> > > disabling
> > > gdbstub in the parent process, which may have multiple threads
> > > (which
> > > are represented as CPUs).
> > >=20
> > > Loop over all CPUs in order to remove breakpoints and disable
> > > single-step. Move the respective code into a separate function.
> > >=20
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > > =C2=A0 gdbstub/user.c | 19 +++++++++++++++----
> > > =C2=A0 1 file changed, 15 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/gdbstub/user.c b/gdbstub/user.c
> > > index 14918d1a217..e17f7ece908 100644
> > > --- a/gdbstub/user.c
> > > +++ b/gdbstub/user.c
> > > @@ -356,16 +356,27 @@ int gdbserver_start(const char
> > > *port_or_path)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > > =C2=A0 }
> > > =C2=A0=20
> > > +static void disable_gdbstub(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 CPUState *cpu;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 close(gdbserver_user_state.fd);
> > > +=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fd =3D -1;
> > > +=C2=A0=C2=A0=C2=A0 CPU_FOREACH(cpu) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_breakpoint_remove_all=
(cpu, BP_GDB);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no cpu_watchpoint_remo=
ve_all for user-mode */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_single_step(cpu, 0);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tb_flush(cpu);
> >=20
> > You only need to flush once.=C2=A0 The cpu argument is used to determin=
e
> > if we can perform the=20
> > flush immediately or need to queue it.
>=20
> I thought we needed to flush jump caches on all CPUs, but I see now
> that do_tb_flush() already does this, so this loop is unnecessarily
> quadratic.
>=20
> Btw, shouldn't do_tb_flush() have cpu as a local variable, and not as
> a parameter?

Never mind, the dummy parameter is needed for usage with
async_safe_run_on_cpu().


[...]

