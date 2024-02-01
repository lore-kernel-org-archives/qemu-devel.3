Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6350DC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZsi-0000aA-KR; Thu, 01 Feb 2024 11:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVZsd-0000X8-L0
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:25:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVZsX-00051A-8q
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:25:33 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 411Fp1Qh022947; Thu, 1 Feb 2024 16:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nDNOHMYVOO3zdJqGH59gQiExbN3A/PPuCaFylZoOcFM=;
 b=bCOIL86lLgjxwzcvPUf6diQp5iPSNpb9Hu1+Uy9gq4g/IhhgZhydSA62M4KLhhON8jsB
 OlcF0lhTTbGRFzjmz+OfGSXTzW7LT/iPExIzZq12E2LEkrxmQ6qieuC61JnR5tVmCvWG
 DAG6Wz9/zTYtR3A02SZ3fVezGH933kb6IQz4TpE74XgeRXkzvBVxFBeqv5ruu3nZlmsV
 PKD7iLQhMmddqrLYEGvqFyYNDadvkbQXWK6mOAuHWNdZCc0Kxrzplt73Py3xAHSHum0k
 8Iavn7QUTJkyL3wXUvixLFF4fEMgYKuve2Q4U6s1oxcajG9CVk3MHBkKuTqIymSIHhFI 4w== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0e5x19g4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 16:25:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 411EIvEm010858; Thu, 1 Feb 2024 16:22:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweckw391-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 16:22:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 411GM8FA42008864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Feb 2024 16:22:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DA8B20043;
 Thu,  1 Feb 2024 16:22:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04E7620040;
 Thu,  1 Feb 2024 16:22:08 +0000 (GMT)
Received: from [9.171.74.74] (unknown [9.171.74.74])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Feb 2024 16:22:07 +0000 (GMT)
Message-ID: <bd14786900838155c9f1d2e82adc5e4d68207ee9.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] gdbstub: Implement follow-fork-mode child
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Date: Thu, 01 Feb 2024 17:22:07 +0100
In-Reply-To: <877cjomlk9.fsf@draig.linaro.org>
References: <20240131205031.144607-1-iii@linux.ibm.com>
 <20240131205031.144607-3-iii@linux.ibm.com>
 <877cjomlk9.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8d2HYAKkcaRXZ0TB5BHp9VY_J-02ClMJ
X-Proofpoint-ORIG-GUID: 8d2HYAKkcaRXZ0TB5BHp9VY_J-02ClMJ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010128
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

On Thu, 2024-02-01 at 12:11 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > Currently it's not possible to use gdbstub for debugging linux-user
> > code that runs in a forked child, which is normally done using the
> > `set
> > follow-fork-mode child` GDB command. Purely on the protocol level,
> > the
> > missing piece is the fork-events feature.
> >=20
> > However, a deeper problem is supporting $Hg switching between
> > different
> > processes - right now it can do only threads. Implementing this for
> > the
> > general case would be quite complicated, but, fortunately, for the
> > follow-fork-mode case there are a few factors that greatly simplify
> > things: fork() happens in the exclusive section, there are only two
> > processes involved, and before one of them is resumed, the second
> > one
> > is detached.
> >=20
> > This makes it possible to implement a simplified scheme: the parent
> > and
> > the child share the gdbserver socket, it's used only by one of them
> > at
> > any given time, which is coordinated through a separate socketpair.
> > The
> > processes can read from the gdbserver socket only one byte at a
> > time,
> > which is not great for performance, but, fortunately, the
> > follow-fork-mode involves only a few messages.
> >=20
> > Add the hooks for the user-specific handling of $qSupported, $Hg,
> > and
> > $D. Advertise the fork-events support, and remember whether GDB has
> > it
> > as well. Implement the state machine that is initialized on fork(),
> > decides the current owner of the gdbserver socket, and is
> > terminated
> > when one of the two processes is detached. The logic for the parent
> > and
> > the child is the same, only the initial state is different.
> >=20
> > Handle the `stepi` of a syscall corner case by disabling the
> > single-stepping in detached processes.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0gdbstub/gdbstub.c=C2=A0=C2=A0 |=C2=A0 29 ++++--
> > =C2=A0gdbstub/internals.h |=C2=A0=C2=A0 3 +
> > =C2=A0gdbstub/user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 210
> > +++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A03 files changed, 234 insertions(+), 8 deletions(-)

[...]
=C2=A0
> > diff --git a/gdbstub/user.c b/gdbstub/user.c
> > index 120eb7fc117..962f4cb74e7 100644
> > --- a/gdbstub/user.c
> > +++ b/gdbstub/user.c
> > @@ -10,6 +10,7 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include "qemu/osdep.h"
> > +#include <sys/syscall.h>
> > =C2=A0#include "qemu/bitops.h"
> > =C2=A0#include "qemu/cutils.h"
> > =C2=A0#include "qemu/sockets.h"
> > @@ -25,6 +26,41 @@
> > =C2=A0#define GDB_NR_SYSCALLS 1024
> > =C2=A0typedef unsigned long
> > GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
> > =C2=A0
> > +/*
> > + * Forked child talks to its parent in order to let GDB enforce
> > the
> > + * follow-fork-mode. This happens inside a start_exclusive()
> > section, so that
> > + * the other threads, which may be forking too, do not interfere.
> > The
> > + * implementation relies on GDB not sending $vCont until it has
> > detached
> > + * either from the parent (follow-fork-mode child) or from the
> > child
> > + * (follow-fork-mode parent).
> > + *
> > + * The parent and the child share the GDB socket; at any given
> > time only one
> > + * of them is allowed to use it, as is reflected in the respective
> > fork_state.
> > + * This is negotiated via the fork_sockets pair as a reaction to
> > $Hg.
> > + */
> > +enum GDBForkState {
> > +=C2=A0=C2=A0=C2=A0 /* Fully owning the GDB socket. */
> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_ENABLED,
> > +=C2=A0=C2=A0=C2=A0 /* Working with the GDB socket; the peer is inactiv=
e. */
> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_ACTIVE,
> > +=C2=A0=C2=A0=C2=A0 /* Handing off the GDB socket to the peer. */
> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_DEACTIVATING,
> > +=C2=A0=C2=A0=C2=A0 /* The peer is working with the GDB socket. */
> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_INACTIVE,
> > +=C2=A0=C2=A0=C2=A0 /* Asking the peer to close its GDB socket fd. */
> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_ENABLING,
> > +=C2=A0=C2=A0=C2=A0 /* Asking the peer to take over, closing our GDB so=
cket fd. */
> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_DISABLING,
> > +=C2=A0=C2=A0=C2=A0 /* The peer has taken over, our GDB socket fd is cl=
osed. */
> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_DISABLED,
> > +};
>=20
> gulp - thats a potentially fairly complex state diagram. Do we just
> work
> through the states sequentially?

Unfortunately no. I had less states at some point, but then realized
it was better to have these things laid out explicitly. Let me try to
summarize the possible transitions:

GDB_FORK_ENABLED: Terminal state; GDB follows the current process.
GDB_FORK_DISABLED: Terminal state; GDB follows the other process.
GDB_FORK_ACTIVE -> GDB_FORK_DEACTIVATING: On $Hg.
GDB_FORK_ACTIVE -> GDB_FORK_ENABLING: On $D.
GDB_FORK_ACTIVE -> GDB_FORK_DISABLING: On $D.
GDB_FORK_ACTIVE -> GDB_FORK_DISABLED: On communication error.
GDB_FORK_DEACTIVATING -> GDB_FORK_INACTIVE: On gdb_read_byte() return.
GDB_FORK_DEACTIVATING -> GDB_FORK_DISABLED: On communication error.
GDB_FORK_INACTIVE -> GDB_FORK_ACTIVE: On $Hg in peer.
GDB_FORK_INACTIVE -> GDB_FORK_ENABLE: On $D in peer.
GDB_FORK_INACTIVE -> GDB_FORK_DISABLE: On $D in peer.
GDB_FORK_INACTIVE -> GDB_FORK_DISABLED: On communication error.
GDB_FORK_ENABLING -> GDB_FORK_ENABLED: On gdb_read_byte() return.
GDB_FORK_ENABLING -> GDB_FORK_DISABLED: On communication error.
GDB_FORK_DISABLING -> GDB_FORK_DISABLED: On gdb_read_byte() return.

Some states have only one meaningful transition:

GDB_FORK_DEACTIVATING -> GDB_FORK_INACTIVE
GDB_FORK_ENABLING -> GDB_FORK_ENABLED

and can in theory be squashed, but then the socketpair communication
would have to be moved to the respective user-hook, which would
complicate the error handling.

[...]

> > @@ -369,16 +421,168 @@ static void disable_gdbstub(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0 CPU_FOREACH(cpu) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_breakpoint_remove_=
all(cpu, BP_GDB);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no cpu_watchpoint_r=
emove_all for user-mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_single_step(cpu, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tb_flush(cpu);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0}
> > =C2=A0
> > -/* Disable gdb stub for child processes.=C2=A0 */
> > =C2=A0void gdbserver_fork_end(pid_t pid)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0 if (pid !=3D 0 || !gdbserver_state.init ||
> > gdbserver_user_state.fd < 0) {
> > +=C2=A0=C2=A0=C2=A0 char b;
> > +=C2=A0=C2=A0=C2=A0 int fd;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (!gdbserver_state.init || gdbserver_user_state.f=
d < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 if (pid =3D=3D -1) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gdbserver_user_state.fo=
rk_state !=3D GDB_FORK_DISABLED)
> > {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_a=
ssert(gdbserver_user_state.fork_state =3D=3D
> > GDB_FORK_INACTIVE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
se(gdbserver_user_state.fork_sockets[0]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
se(gdbserver_user_state.fork_sockets[1]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0 disable_gdbstub();
> > +
> > +=C2=A0=C2=A0=C2=A0 if (gdbserver_user_state.fork_state =3D=3D GDB_FORK=
_DISABLED) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pid =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dis=
able_gdbstub();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 if (pid =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(gdbserver_user_state.=
fork_sockets[0]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D gdbserver_user_state=
.fork_sockets[1];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(gdbserver_state.pr=
ocess_num =3D=3D 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(gdbserver_state.pr=
ocesses[0].pid =3D=3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fo=
rk_peer_pid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(gdbserver_state.pr=
ocesses[0].attached);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_state.processes[0=
].pid =3D getpid();
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(gdbserver_user_state.=
fork_sockets[1]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D gdbserver_user_state=
.fork_sockets[0];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fork_s=
tate =3D GDB_FORK_ACTIVE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fork_p=
eer_pid =3D pid;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fork_p=
eer_tid =3D pid;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!gdbserver_state.allow_=
stop_reply) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o fail;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_s=
tate.str_buf,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "T%02=
xfork:p%02x.%02x;thread:p%02x.%02x;",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > gdb_target_signal_to_gdb(gdb_target_sigtrap()),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid, =
pid, (int)getpid(),
> > qemu_get_thread_id());
>=20
> I don't think I messed up the merge but:
>=20
> ../../gdbstub/user.c: In function =E2=80=98gdbserver_fork_end=E2=80=99:
> ../../gdbstub/user.c:461:50: error: implicit declaration of function
> =E2=80=98gdb_target_sigtrap=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
> =C2=A0 461 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> gdb_target_signal_to_gdb(gdb_target_sigtrap()),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^~~~~~~~~~~~~~~~~~
> ../../gdbstub/user.c:461:50: error: nested extern declaration of
> =E2=80=98gdb_target_sigtrap=E2=80=99 [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
>=20
> I cant see where gdb_target_sigtrap is from?

This is from [1], which this series is Based-on. I can make one series
with both features if it's more convenient to review.

[1] https://patchew.org/QEMU/20240116094411.216665-1-iii@linux.ibm.com/

