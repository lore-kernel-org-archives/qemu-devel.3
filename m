Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EFECF319D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuPV-0006kG-Bp; Wed, 02 Oct 2024 04:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svuPT-0006jg-G5
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1svuPR-0002bf-Ex
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927sXvp001529;
 Wed, 2 Oct 2024 08:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 xgtbHHA2i4dCdH3Waczl8KzXiX0uJqXt5z0bKK5kDZY=; b=fg40S93Y+KpTpJHH
 NrxC32VaJ5bCULtqy/M8kw7UCU4j/mfW21WC55VhinYLOHGYzxmmbt/ibzikZOMg
 StICG4SwLJYSA0eKwoi2TjI408cKPF2AXf4bNJ1+HWVWOa6+oryaSY+cSO8FoQ1s
 9QvPwvrBvM57vWFI7zdNqd32VYdPMJxIohJO5cfs3k8dpfEOHnJVWJpPEt5huiBH
 CplZ4tZHUF58O3/ujOoJCJegRXYhT4s5Q/SFecH/843DNVIIFKeY84TwiNUY213u
 6tkkHq7VZ3uNRJNo7kD3DSz4TixF2f9IoEaH4mJVjfXouq9pqSV2TRrI5hUxI6K+
 0xlwGQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42126r02ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 08:08:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49288WRN029244;
 Wed, 2 Oct 2024 08:08:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42126r02eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 08:08:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4926K9ox020409;
 Wed, 2 Oct 2024 08:08:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4s98d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 08:08:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49288T6328508864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 08:08:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EE1B2004B;
 Wed,  2 Oct 2024 08:08:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5356820040;
 Wed,  2 Oct 2024 08:08:29 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Oct 2024 08:08:29 +0000 (GMT)
Message-ID: <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Noah Goldstein <goldstein.w.n@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Date: Wed, 02 Oct 2024 10:08:29 +0200
In-Reply-To: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -oLlsVwofo9tmUNCrzPz9tY8EGAfYF3b
X-Proofpoint-ORIG-GUID: Qb7Me3fRwiiozWbgaGhZ3jF31SfbrMSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020059
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

On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> The new option '-qemu-children' makes it so that on `execve` the
> child
> process will be launch by the same `qemu` executable that is
> currently
> running along with its current commandline arguments.
>=20
> The motivation for the change is to make it so that plugins running
> through `qemu` can continue to run on children.=C2=A0 Why not just
> `binfmt`?: Plugins can be desirable regardless of system/architecture
> emulation, and can sometimes be useful for elf files that can run
> natively. Enabling `binfmt` for all natively runnable elf files may
> not be desirable.

Another reason to have this is that one may not have root permissions
to configure binfmt-misc.

There was a similar patch posted to the mailing list some years back,
which I used to cherry-pick when I needed this. I'm not sure what
happened to that discussion though.

> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
> =C2=A0linux-user/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
> =C2=A0linux-user/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20=
 +++++++++++++++-----
> =C2=A0linux-user/user-internals.h |=C2=A0 4 ++++
> =C2=A03 files changed, 41 insertions(+), 5 deletions(-)
>=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8143a0d4b0..dfb303a1f2 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
> =C2=A0uintptr_t guest_base;
> =C2=A0bool have_guest_base;
> =C2=A0
> +bool qemu_dup_for_children;
> +int qemu_argc;
> +char ** qemu_argv;

Style: ** belong to the variable name.
There are a couple other issues, please check the output of

git format-patch -1 --stdout | ./scripts/checkpatch.pl -

> +
> =C2=A0/*
> =C2=A0 * Used to implement backwards-compatibility for the `-strace`, and
> =C2=A0 * QEMU_STRACE options. Without this, the QEMU_LOG can be
> overwritten by
> @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
> =C2=A0=C2=A0=C2=A0=C2=A0 perf_enable_jitdump();
> =C2=A0}
> =C2=A0
> +static void handle_arg_qemu_children(const char *arg)
> +{
> +=C2=A0=C2=A0=C2=A0 qemu_dup_for_children =3D true;
> +}
> +
> =C2=A0static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
> =C2=A0
> =C2=A0#ifdef CONFIG_PLUGIN
> @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "Generate a /tmp/perf-${pid}.map file for perf"},
> =C2=A0=C2=A0=C2=A0=C2=A0 {"jitdump",=C2=A0=C2=A0=C2=A0 "QEMU_JITDUMP",=C2=
=A0=C2=A0=C2=A0=C2=A0 false, handle_arg_jitdump,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "Generate a jit-${pid}.dump file for perf"},
> +=C2=A0=C2=A0=C2=A0 {"qemu-children",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "QEMU_CHILDREN",=C2=A0=C2=A0=C2=A0 fal=
se,
> handle_arg_qemu_children,
> +=C2=A0=C2=A0=C2=A0=C2=A0 "",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "Run child processes (created with execve) with
> qemu "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "(as instantiated for the parent)"},
> =C2=A0=C2=A0=C2=A0=C2=A0 {NULL, NULL, false, NULL, NULL, NULL}
> =C2=A0};
> =C2=A0
> @@ -729,6 +742,15 @@ int main(int argc, char **argv, char **envp)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 optind =3D parse_args(argc, argv);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (qemu_dup_for_children) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;

I get the following build error:

qemu/linux-user/main.c: In function =E2=80=98main=E2=80=99:
qemu/linux-user/main.c:746:13: error: declaration of =E2=80=98i=E2=80=99 sh=
adows a
previous local [-Werror=3Dshadow=3Dcompatible-local]
  746 |         int i;
      |             ^
qemu/linux-user/main.c:699:9: note: shadowed declaration is here
  699 |     int i;
      |         ^

I don't think this variable is needed at all.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_argc =3D optind;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_argv =3D g_new0(char *, =
qemu_argc);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < optind; ++i=
) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_=
argv[i] =3D strdup(argv[i]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_log_filename_flags(last_log_filename,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_log_mask | (enable_strac=
e *
> LOG_STRACE),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_fatal);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9d5415674d..732ef89054 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8459,13 +8459,14 @@ static int do_execv(CPUArchState *cpu_env,
> int dirfd,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_long pathname, abi_lon=
g guest_argp,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_long guest_envp, int f=
lags, bool
> is_execveat)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0=C2=A0 int ret, argp_offset;
> =C2=A0=C2=A0=C2=A0=C2=A0 char **argp, **envp;
> =C2=A0=C2=A0=C2=A0=C2=A0 int argc, envc;
> =C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong gp;
> =C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong addr;
> =C2=A0=C2=A0=C2=A0=C2=A0 char **q;
> =C2=A0=C2=A0=C2=A0=C2=A0 void *p;
> +=C2=A0=C2=A0=C2=A0 bool through_qemu =3D !is_execveat && qemu_dup_for_ch=
ildren;

Wouldn't it be better to check for dirfd =3D=3D AT_FDCWD?

> =C2=A0=C2=A0=C2=A0=C2=A0 argc =3D 0;
> =C2=A0
> @@ -8489,10 +8490,11 @@ static int do_execv(CPUArchState *cpu_env,
> int dirfd,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 envc++;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 argp =3D g_new0(char *, argc + 1);
> +=C2=A0=C2=A0=C2=A0 argp_offset =3D through_qemu ? qemu_argc : 0;
> +=C2=A0=C2=A0=C2=A0 argp =3D g_new0(char *, argc + argp_offset + 1);
> =C2=A0=C2=A0=C2=A0=C2=A0 envp =3D g_new0(char *, envc + 1);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeo=
f(abi_ulong),
> q++) {
> +=C2=A0=C2=A0=C2=A0 for (gp =3D guest_argp, q =3D argp + argp_offset; gp;=
 gp +=3D
> sizeof(abi_ulong), q++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (get_user_ual(addr, g=
p)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto execve_efault;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -8537,9 +8539,17 @@ static int do_execv(CPUArchState *cpu_env, int
> dirfd,
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *exe =3D p;
> -=C2=A0=C2=A0=C2=A0 if (is_proc_myself(p, "exe")) {
> +=C2=A0=C2=A0=C2=A0 if (through_qemu) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < argp_offset=
; ++i) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 argp[=
i] =3D qemu_argv[i];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exe =3D qemu_argv[0];
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 else if (is_proc_myself(p, "exe")) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exe =3D exec_path;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D is_execveat
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? safe_execveat(dirfd, e=
xe, argp, envp, flags)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : safe_execve(exe, argp,=
 envp);
> @@ -8553,7 +8563,7 @@ execve_efault:
> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -TARGET_EFAULT;
> =C2=A0
> =C2=A0execve_end:
> -=C2=A0=C2=A0=C2=A0 for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeo=
f(abi_ulong),
> q++) {
> +=C2=A0=C2=A0=C2=A0 for (gp =3D guest_argp, q =3D argp + argp_offset; *q;=
 gp +=3D
> sizeof(abi_ulong), q++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (get_user_ual(addr, g=
p) || !addr) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> diff --git a/linux-user/user-internals.h b/linux-user/user-
> internals.h
> index 5c7f173ceb..0719e65ff4 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -30,6 +30,10 @@ void stop_all_tasks(void);
> =C2=A0extern const char *qemu_uname_release;
> =C2=A0extern unsigned long mmap_min_addr;
> =C2=A0
> +extern bool qemu_dup_for_children;
> +extern int qemu_argc;
> +extern char ** qemu_argv;
> +
> =C2=A0typedef struct IOCTLEntry IOCTLEntry;
> =C2=A0
> =C2=A0typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t
> *buf_temp,


