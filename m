Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8C9D2B941
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Lpp-00054M-3q; Tue, 05 Nov 2024 10:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8Lpn-000542-9L
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:51:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8Lpj-0006Ql-2i
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:51:10 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5FeJHp013605;
 Tue, 5 Nov 2024 15:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/59eyO
 tyFXbHpV9ZldNtt72zzkOq6Weqg2L6GX+x8jY=; b=Yq/QemNMPtrFG2vySgU6pw
 NG2kAYWCFV33D2BPhhsPQoSBXPKOc89e+tAc+z5pjqADSORrlz9t7IF3JgorkgcT
 IKmAwq0RQus0D/zBfJ/lbOzawm5+LwQ9VfVrDrYjhsNCu4B94BhfupPhvvvHvt5k
 B8KbrRzNCj96/j6/sgPD3ZPFdCufehlAw4rzhoQ0msE++Vj6GySZo5X+xLt4WLrN
 nBbDInwcGXUfPCsBzskplJTTSi0+hvqfXEwN9RZy07RlgROM5Jj6nDGFMlaPC2E7
 VIV+Mt93n60rdh7ja7sg3NFvUDh3YSlfbBTaDBV5EaY2gt1G/qfUWth+iTqGs31g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qp6x01bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 15:50:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A56JvW0024243;
 Tue, 5 Nov 2024 15:50:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds4gap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 15:50:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5Foq8E33817270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 15:50:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A17F20043;
 Tue,  5 Nov 2024 15:50:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6549F20040;
 Tue,  5 Nov 2024 15:50:51 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2024 15:50:51 +0000 (GMT)
Message-ID: <74ef513603500e76330c2735803d5e1402406f4a.camel@linux.ibm.com>
Subject: Re: [PATCH 4/8] user: Introduce host_interrupt_signal
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Kyle Evans <kevans@freebsd.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Tue, 05 Nov 2024 16:50:51 +0100
In-Reply-To: <CANCZdfrhzc-HZabUjkAMTgcHR0+6OQPxNshkQfMYD4wbNcm=wQ@mail.gmail.com>
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-5-iii@linux.ibm.com>
 <CANCZdfrhzc-HZabUjkAMTgcHR0+6OQPxNshkQfMYD4wbNcm=wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zBI9jWlGR3L5fTC0Fdsa6Sd7cJWyRgak
X-Proofpoint-GUID: zBI9jWlGR3L5fTC0Fdsa6Sd7cJWyRgak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=746
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2024-11-05 at 08:39 -0700, Warner Losh wrote:
> On Thu, Oct 24, 2024 at 2:00=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> > Attaching to the gdbstub of a running process requires stopping its
> > threads. For threads that run on a CPU, cpu_exit() is enough, but
> > the
> > only way to grab attention of a thread that is stuck in a long-
> > running
> > syscall is to interrupt it with a signal.
> >=20
> > Reserve a host realtime signal for this, just like it's already
> > done
> > for TARGET_SIGABRT on Linux. This may reduce the number of
> > available
> > guest realtime signals by one, but this is acceptable, since there
> > are
> > quite a lot of them, and it's unlikely that there are apps that
> > need
> > them all.
> >=20
> > Set signal_pending for the safe_sycall machinery to prevent
> > invoking
> > the syscall. This is a lie, since we don't queue a guest signal,
> > but
> > process_pending_signals() can handle the absence of pending
> > signals.
> > The syscall returns with QEMU_ERESTARTSYS errno, which arranges for
> > the automatic restart. This is important, because it helps avoiding
> > disturbing poorly written guests.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0| 12 ++++++++++++
> > =C2=A0include/user/signal.h |=C2=A0 2 ++
> > =C2=A0linux-user/signal.c=C2=A0 =C2=A0| 11 +++++++++++
> > =C2=A03 files changed, 25 insertions(+)
> >=20
> > diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> > index a2b11a97131..992736df5c5 100644
> > --- a/bsd-user/signal.c
> > +++ b/bsd-user/signal.c
> > @@ -49,6 +49,8 @@ static inline int sas_ss_flags(TaskState *ts,
> > unsigned long sp)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on_sig_stack(ts, sp) ? SS_ONSTACK : 0=
;
> > =C2=A0}
> >=20
> > +int host_interrupt_signal =3D SIGRTMAX;
> > +
> >=20
>=20
>=20
> I'd be tempted to use SIGRTMAX=C2=A0+ 1 or even TARGET_NSIG. 127 or 128
> would
> work and not overflow any arrays (or hit any bounds tests) I'd likely
> use SIGRTMAX=C2=A0+ 1,
> though, since it avoids any edge-cases from sig =3D=3D NSIG that might be
> in the code
> unnoticed.
>=20
> Now, having said that, I don't think that there's too many (any?)
> programs we need
> to run as bsd-user that have real-time signals, much less one that
> uses SIGRTMAX,
> but stranger things have happened. But it is a little wiggle room
> just in case.
>=20
> Other than that:
>=20
> Reviewed-by: Warner Losh <imp@bsdimp.com>

Thanks for the suggestion, I'll use SIGRTMAX + 1 in v2.

