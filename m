Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29C4E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 19:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVc2Y-00009p-Dr; Wed, 08 Jan 2025 14:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVc2X-00009Z-2h
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 14:48:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVc2U-0004SR-O7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 14:48:28 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508EktL3007143;
 Wed, 8 Jan 2025 19:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vyDe/7
 QnhuennzF+1iAq00wgfnykyEMqYeNhshNbdxM=; b=pKLzsboXeDS9MlYVNh3uGT
 /bhXCKj2RW5Y32WmXqLEo8X7xyTf+AT4MRRdOuRmcBTZtYRldp3yv9ildm7fbLTk
 Qc7tfzsF2OMDjwUtHlw6+Bfx27nYks7Nfp8radYjsZ4Lg6+PYS8vuJbvlUw4A6BR
 fUI187pWWCTQMYwPLhUbr+gA5AFV7FF3VjzlMGXXg+ItKiX6WGvr2ID1ZCepcKfu
 KuDk8R/VwSW9t60CAegr1ORfL+49hok7Cj88uoLRwD+Pl1zgjEkzSxuYOK45spyv
 AfudCIx/XOxyBYzf8NQkNaw3zXusZgtH0nq7ia9pIXvl2QRnM9YNUfC3che1R8eA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupv7n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:48:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508GRg09008869;
 Wed, 8 Jan 2025 19:48:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq01ku8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 19:48:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508Jm3MJ55902630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 19:48:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C7E720043;
 Wed,  8 Jan 2025 19:48:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A23A420040;
 Wed,  8 Jan 2025 19:48:02 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 19:48:02 +0000 (GMT)
Message-ID: <2f75af6a55c1726ae706cf6eb19e8b583fd647c0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 6/8] gdbstub: Allow late attachment
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent
 Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Date: Wed, 08 Jan 2025 20:48:02 +0100
In-Reply-To: <87tta99q8b.fsf@draig.linaro.org>
References: <20241216123412.77450-1-iii@linux.ibm.com>
 <20241216123412.77450-7-iii@linux.ibm.com>
 <87tta99q8b.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CgCR6ucee5CL2VOV-DXWMiC5zcOZvcRO
X-Proofpoint-GUID: CgCR6ucee5CL2VOV-DXWMiC5zcOZvcRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 2025-01-08 at 17:20 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > Allow debugging individual processes in multi-process applications
> > by
> > starting them with export QEMU_GDB=3D/tmp/qemu-%d.sock,suspend=3Dn.
> > Currently one would have to attach to every process to ensure the
> > app
> > makes progress.
> >=20
> > In case suspend=3Dn is not specified, the flow remains unchanged. If
> > it
> > is specified, then accepting the client connection is delegated to
> > a
> > thread. In the future this machinery may be reused for handling
> > reconnections and interruptions.
> >=20
> > On accepting a connection, the thread schedules gdb_handlesig() on
> > the
> > first CPU and wakes it up with host_interrupt_signal. Note that the
> > result of this gdb_handlesig() invocation is handled, as opposed to
> > many other existing call sites. These other call sites probably
> > need to
> > be fixed separately.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0bsd-user/main.c=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> > =C2=A0gdbstub/user.c=C2=A0=C2=A0=C2=A0 | 120
> > ++++++++++++++++++++++++++++++++++++++++++----
> > =C2=A0linux-user/main.c |=C2=A0=C2=A0 1 -
> > =C2=A03 files changed, 110 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/bsd-user/main.c b/bsd-user/main.c
> > index 61ca73c4781..ca4773a3f40 100644
> > --- a/bsd-user/main.c
> > +++ b/bsd-user/main.c
> > @@ -628,7 +628,6 @@ int main(int argc, char **argv)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (gdbstub) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_start(gdbstu=
b);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_handlesig(cpu, 0, NULL,=
 NULL, 0);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0 cpu_loop(env);
> > =C2=A0=C2=A0=C2=A0=C2=A0 /* never exits */
> > diff --git a/gdbstub/user.c b/gdbstub/user.c
> > index c900d0a52fe..6ada0d687b9 100644
> > --- a/gdbstub/user.c
> > +++ b/gdbstub/user.c
> > @@ -10,6 +10,7 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include "qemu/osdep.h"
> > +#include <sys/syscall.h>
>=20
> Whats this needed for? I can build without it.

Must be a leftover - probably I was calling gettid() in one of the
intermediate versions? I don't see a need for it anymore and will drop
it in v4.

> > =C2=A0#include "qemu/bitops.h"
> > =C2=A0#include "qemu/cutils.h"
> > =C2=A0#include "qemu/sockets.h"
> > @@ -21,6 +22,7 @@
> > =C2=A0#include "gdbstub/user.h"
> > =C2=A0#include "gdbstub/enums.h"
> > =C2=A0#include "hw/core/cpu.h"
> > +#include "user/signal.h"
> > =C2=A0#include "trace.h"
> > =C2=A0#include "internals.h"
> > =C2=A0
> > @@ -416,11 +418,101 @@ static int gdbserver_open_port(int port)
> > =C2=A0=C2=A0=C2=A0=C2=A0 return fd;
> > =C2=A0}
> > =C2=A0
> > -int gdbserver_start(const char *port_or_path)
> > +static bool gdbserver_accept(int port, int gdb_fd, const char
> > *port_or_path)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0 int port =3D g_ascii_strtoull(port_or_path, NULL, 1=
0);
> > +=C2=A0=C2=A0=C2=A0 bool ret;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (port > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D gdb_accept_tcp(gdb_=
fd);
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D gdb_accept_socket(g=
db_fd);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb=
server_user_state.socket_path =3D
> > g_strdup(port_or_path);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 if (!ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(gdb_fd);
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 return ret;
> > +}
>=20
> Is the clean-up worth it here for the extra level of indirection. Is
> the
> string even port_or_path at this point because if it was a port the
> int
> port > 0?

The extra level of indirection arises because of using a thread.
I think port_or_path is indeed always a path; I will rename it.

> > +
> > +struct {
> > +=C2=A0=C2=A0=C2=A0 int port;
> > =C2=A0=C2=A0=C2=A0=C2=A0 int gdb_fd;
> > +=C2=A0=C2=A0=C2=A0 char *port_or_path;
> > +} gdbserver_args;
> > +
> > +static void do_gdb_handlesig(CPUState *cs, run_on_cpu_data arg)
> > +{
> > +=C2=A0=C2=A0=C2=A0 int sig;
> > +
> > +=C2=A0=C2=A0=C2=A0 sig =3D target_to_host_signal(gdb_handlesig(cs, 0, =
NULL, NULL,
> > 0));
> > +=C2=A0=C2=A0=C2=A0 if (sig >=3D 1 && sig < NSIG) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_kill_thread(gdb_get_cp=
u_index(cs), sig);
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +static void *gdbserver_accept_thread(void *arg)
> > +{
> > +=C2=A0=C2=A0=C2=A0 if (gdbserver_accept(gdbserver_args.port,
> > gdbserver_args.gdb_fd,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 gdbserver_args.port_or_path)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUState *cs =3D first_cpu;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_safe_run_on_cpu(cs, d=
o_gdb_handlesig,
> > RUN_ON_CPU_NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_kill_thread(gdb_get_cp=
u_index(cs),
> > host_interrupt_signal);
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 g_free(gdbserver_args.port_or_path);
>=20
> Should we set gdbserver_args.port_or_path =3D NULL here to avoid trying
> to
> reference or free it again?

Sounds good, will do.

> > +
> > +=C2=A0=C2=A0=C2=A0 return NULL;
> > +}
> > +
> > +__attribute__((__format__(__printf__, 1, 2)))
> > +static void print_usage(const char *format, ...)
> > +{
> > +=C2=A0=C2=A0=C2=A0 va_list ap;
> > +
> > +=C2=A0=C2=A0=C2=A0 va_start(ap, format);
> > +=C2=A0=C2=A0=C2=A0 vfprintf(stderr, format, ap);
> > +=C2=A0=C2=A0=C2=A0 va_end(ap);
> > +=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Usage: -g {port|path}[,suspend=3D{=
y|n}]\n");
> > +}
> > +
> > +#define SUSPEND "suspend=3D"
> > +
> > +int gdbserver_start(const char *args)
> > +{
> > +=C2=A0=C2=A0=C2=A0 g_auto(GStrv) argv =3D g_strsplit(args, ",", 0);
> > +=C2=A0=C2=A0=C2=A0 const char *port_or_path =3D NULL;
> > +=C2=A0=C2=A0=C2=A0 bool suspend =3D true;
> > +=C2=A0=C2=A0=C2=A0 int gdb_fd, port;
> > +=C2=A0=C2=A0=C2=A0 GStrv arg;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 for (arg =3D argv; *arg; arg++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_str_has_prefix(*arg, =
SUSPEND)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
st char *val =3D *arg + strlen(SUSPEND);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sus=
pend =3D (strcmp(val, "y") =3D=3D 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!suspend && (strcmp(val, "n") !=3D 0)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print_usage("Bad option value: %s", *arg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(port_or_path) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 print_usage("Unknown option: %s", *arg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 por=
t_or_path =3D *arg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
>=20
> We have some useful utility functions to parsing all the bools,
> something like:
>=20
> =C2=A0=C2=A0=C2=A0 for (arg =3D argv; *arg; arg++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_auto(GStrv) tokens =3D g_str=
split(*arg, "=3D", 2);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_strcmp0(tokens[0], "susp=
end") =3D=3D 0 && tokens[1]) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_b=
ool_parse(tokens[0], tokens[1], &suspend,
> &error_fatal);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (po=
rt_or_path) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 print_usage("Unknown option: %s", *arg);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port_o=
r_path =3D *arg;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
>=20
> which also avoids the #define and strlen messing about as well.

Looks good, I will adopt it (I think I'll swap error_fatal for
warn_report_err() though).

>=20
> (side note to no one in particular: should qapi_bool_parse being
> using g_strcmp0()?)

Makes sense, with the current approach I get

    Unknown option: suspend

for

    QEMU_GDB=3D/tmp/1234,suspend

which is somewhat puzzling. I will add the change to v4.

>=20
> > +=C2=A0=C2=A0=C2=A0 if (!port_or_path) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_usage("Port or path n=
ot specified");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 port =3D g_ascii_strtoull(port_or_path, NULL, 10);
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (port > 0) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_fd =3D gdbserver_o=
pen_port(port);
> > =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > @@ -431,16 +523,24 @@ int gdbserver_start(const char *port_or_path)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 if (port > 0 && gdb_accept_tcp(gdb_fd)) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > -=C2=A0=C2=A0=C2=A0 } else if (gdb_accept_socket(gdb_fd)) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.socket=
_path =3D g_strdup(port_or_path);
> > +=C2=A0=C2=A0=C2=A0 if (suspend) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gdbserver_accept(port, =
gdb_fd, port_or_path)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb=
_handlesig(first_cpu, 0, NULL, NULL, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuThread thread;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_args.port =3D por=
t;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_args.gdb_fd =3D g=
db_fd;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_args.port_or_path=
 =3D g_strdup(port_or_path);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_create(&thread,=
 "gdb-accept",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &gdbserver_accept_thread, NULL,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 QEMU_THREAD_DETACHED);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > -
> > -=C2=A0=C2=A0=C2=A0 /* gone wrong */
> > -=C2=A0=C2=A0=C2=A0 close(gdb_fd);
> > -=C2=A0=C2=A0=C2=A0 return -1;
> > =C2=A0}
>=20
> Not a problem with this patch in particular but it seems to me
> gdbserver_start should probably look like:
>=20
> =C2=A0 bool gdbserver_start(const char *args, Error **errp)
>=20
> so we can do the right thing when starting from the command line or
> via
> HMP. I'll see if I can clean that up on gdbstub/next.

I like this; in particular, I've added the usage of unix_listen(),
which uses Error, and for now I have to handle it using
warn_report_err() - just forwarding it up the stack would be much
nicer.

> > =C2=A0
> > =C2=A0void gdbserver_fork_start(void)
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index b09af8d4365..97245ab37c2 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -1027,7 +1027,6 @@ int main(int argc, char **argv, char **envp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbstub);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 exit(EXIT_FAILURE);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_handlesig(cpu, 0, NULL,=
 NULL, 0);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0#ifdef CONFIG_SEMIHOSTING
>=20


