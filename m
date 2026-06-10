Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671AACD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKMM-0007tm-79; Wed, 10 Jun 2026 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXKMG-0007tI-RA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:56:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXKMD-0001v3-Px
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:56:43 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6877c719cb0so8797600a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 07:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103400; cv=none;
 d=google.com; s=arc-20240605;
 b=TnxJ7DwTijo72rMJOVUm1pZQjoaFgMbFYmM6zjhGgCGHg9ul4eGS+YSqfYyRuBUrqZ
 M/d2Le8A87NGPfgwj2khhUm1c9G11m0eeO3Xmv89fJHgDb7MQ5oI+ZEg8VhIqmMfSbmc
 FkcfBA5FMQP5Zg3rHT8DB1IE4NSKxISTCkjMyXtahstVjDQaHT49x2TOsuVnyDf4Ag6b
 ZtpEU4B3e53NCpJ879LzBKiSK+wddpiysFUU34znQeIwneE1Suw5i+ngpGCLrj7O8h4z
 JOpKMzMYaLsvd+EvWBSIPRfgp7dj+kvq3TqJxlnM7j8vTykD3mba3v8IF2gVkj/rXAXa
 awIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YGUBAZSGtch67CfLxYg4o5KbtQVRAgE6OxMUVDSEWhc=;
 fh=CEi+k2sutVdMg+lF7Ccmh3EoLKhY0Vy0OXOknkY+yw0=;
 b=BxorPNkrQ/i1hXHbKiwyMsJ8XLIzAg+Y1FbvY20nAerDS3LLA2wwtVQIHOLf6lrDuJ
 CYpjzfpUB96jJRyJkU93r05a5LCTH2GY/vCbyGx+/SL2Q6P3o4k/paMXQCzEaizslSt6
 fge1ArVJyW/hisxkiRPS/eXeIxZ5GB6Ls5tkn6SbQPNXxVuYXVG1ZgO+FqQw8OzEuSJj
 k1Mj8ynlyk/Bc7J/vqy7nZx2ppWGLJWNOkPU5mfXF6FDkIYpmpp6NYXewoD/dCd3Mxo1
 f6Dm8zzRas/37qTiN+sD2jg//5nGypLLrs8bwUYYFuV2CenqLR2DtUcUXqP05I3oKfgi
 qpKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781103400; x=1781708200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGUBAZSGtch67CfLxYg4o5KbtQVRAgE6OxMUVDSEWhc=;
 b=dmj14DcY2mMLp448yFmNn7ZEBXOj3D1fX4WTcW/U9iwMHoT0eZRThKaYuXYTtjlVeV
 VNw2qlHGR2MS4ZQIMWq6/0muqqRxzUY0A4hBWOOrBVDlHIJYR91QPOjfB/RnCU4302AO
 R3gNmQcELlRvWiqOWdGubbXuH/6du4BGsbGMDnXUIPbVJQppuUFNgIAj4khf34sxFQIx
 Poevov5wIwfhr+Q1a69WYpi63mbDx8aY9ecyiWItex1TX6qCLi8EoJBU95xCqyaY3mCh
 y7TEStaMWD+CU6vCbZG1CHJINpI3nTZyloN6RgZimYjN8wtDNXrHmAbbA8crpX6CNWdD
 jmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781103400; x=1781708200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YGUBAZSGtch67CfLxYg4o5KbtQVRAgE6OxMUVDSEWhc=;
 b=c6nJNnCQJTu4bQLS2yROQ9o8B1Qd2O4FiS6N+SulTKw+vCCPAqJtjUFujHJRz3T/Zo
 kaKjrN3bKQEnSQfLcJUagxy6d/NC5A8vW2/j1+m/7ONm2jQxYKR43YwVzBjdG8fJ6Z0d
 YaXhTXixJXx7wPtKJuvheYGX0R5fiGGZOIgjhrI01yMIkzz6afUJM9tmqfflt+ouDQQ8
 aECT6R2+NflahoCC128cTOldf2KlTySrneJZZD+tR67Xs/rGT3kVJJyE/g/UDIalcbod
 TP9GOmMq6rzGUtjwUJmXywzs9YXwbMwZhONh/QcwC3kpDzV8/DRNmJ/ONJ2e8WANyaZl
 v++w==
X-Gm-Message-State: AOJu0YwVeH6k6VlMc0T7ukAnUanbZM20aioNZs1zskBYOOvPwtiYElQd
 MnGKwXL56AkI/kvOr5ON01oh3MY2njKV6HvCkzKkND1hSXhs70pzW2RG6o2sxwM7tC9OaR3uXv1
 qlbPgyAualhmiUPq9CpGkNjl3WOWzQuA=
X-Gm-Gg: Acq92OE5jF7C7AVzN03zZtl9mxIrjkYoCsRFmw/Lij+XHXc4q1v70cOL5Y7k89f4mMd
 5cD0itSpGmlJwviAj0X1/y3Mm6f7noHJ+Iz02qgZlBTMbNAz6GctWMp4X2YQb3n82vlmAdZIbSN
 Eo6zX3MC5zvn+ZAy2glrXyUWv1JtLQhbkosMGdkNor/L1gnrHYf7MbDJmjpKvZyN4I4dvP/sAyY
 we4GIIEQh4LkmZtMtFXk+iB5bST2jS+ViBU9Pq1ArbMSxmQntIFDWgpYALKPeXHY0/vvSvu0raY
 Vw5VLGJsNf2JnpXG+8ieVe4OMSCfgPxd+w5660xChK06G8+Ls2FR
X-Received: by 2002:a05:6402:3608:b0:691:aeaf:42a7 with SMTP id
 4fb4d7f45d1cf-691aeaf44c4mr7704921a12.10.1781103399597; Wed, 10 Jun 2026
 07:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260609163807.6083-1-deller@kernel.org>
 <20260609163807.6083-3-deller@kernel.org>
In-Reply-To: <20260609163807.6083-3-deller@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Jun 2026 10:56:27 -0400
X-Gm-Features: AVVi8Cf8iPSwQLscLw9NWoDOQ3aw30YEmSdr_ZoBHz8W9fjXAR5lUS6RMsr2n4k
Message-ID: <CAJSP0QXMKQnPpdZq+HBb1G-K2RBGc_2wadn-O0x_9gnvk7w1uQ@mail.gmail.com>
Subject: Re: [PULL v2 2/8] linux-user/strace: add fsmount series of syscalls
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, 
 Max Filippov <jcmvbkbc@gmail.com>, Xinhui Yang <cyan@cyano.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 9, 2026 at 12:39=E2=80=AFPM Helge Deller <deller@kernel.org> wr=
ote:
>
> From: Xinhui Yang <cyan@cyano.uk>
>
> Following the addition of fsmount(2) series of syscalls in the syscall
> handler, strace support is added, with a dedicated function to print the
> parameters of fsconfig(2), which contains parameters that can be
> interpreted as multiple types.
>
> Snippet of the strace dump when running `mount -t tmpfs tmpfs /media`:
>
> 18 fsopen(tmpfs,1) =3D 3
> 18 read(3,0x407fcf1c,8191) =3D -1 errno=3D61 (No data available)
> 18 fsconfig(3,FSCONFIG_SET_STRING,"source","tmpfs",0) =3D 0
> 18 read(3,0x407fce3c,8191) =3D -1 errno=3D61 (No data available)
> 18 fsconfig(3,FSCONFIG_CMD_CREATE,NULL,NULL,0) =3D 0
> 18 read(3,0x407fce3c,8191) =3D -1 errno=3D61 (No data available)
> 18 fsmount(3,1,0) =3D 4
> 18 read(3,0x407fce3c,8191) =3D -1 errno=3D61 (No data available)
> 18 statx(4,"",AT_EMPTY_PATH|AT_STATX_SYNC_AS_STAT,0x1000,0x407fee98) =3D =
0
> 18 move_mount(4,,-100,/media,4) =3D 0
> 18 read(3,0x407fcfcc,8191) =3D -1 errno=3D61 (No data available)
> 18 close(3) =3D 0
> 18 close(4) =3D 0
>
> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/strace.c    | 105 +++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list |  15 ++++++
>  2 files changed, 120 insertions(+)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 2cbaf94c89..d861f311f6 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4344,6 +4344,111 @@ print_statx(CPUArchState *cpu_env, const struct s=
yscallname *name,
>  }
>  #endif
>
> +#ifdef TARGET_NR_fsconfig

This #ifdef is not tied to the host's available syscalls (the syscall
table that TARGET_NR_fsconfig is generated from ships in the QEMU
source tree). As a result, this code will be compiled even when the
host lacks fsconfig(2) and the associated FSCONFIG_* constants.

Please see the following CI failure:

../linux-user/strace.c: In function =E2=80=98print_fsconfig_cmd_name=E2=80=
=99:
../linux-user/strace.c:4352:10: error: =E2=80=98FSCONFIG_SET_FLAG=E2=80=99 =
undeclared
(first use in this function)
4352 | case FSCONFIG_SET_FLAG:
| ^~~~~~~~~~~~~~~~~
../linux-user/strace.c:4352:10: note: each undeclared identifier is
reported only once for each function it appears in
../linux-user/strace.c:4355:10: error: =E2=80=98FSCONFIG_SET_STRING=E2=80=
=99
undeclared (first use in this function)
4355 | case FSCONFIG_SET_STRING:
| ^~~~~~~~~~~~~~~~~~~
../linux-user/strace.c:4358:10: error: =E2=80=98FSCONFIG_SET_BINARY=E2=80=
=99
undeclared (first use in this function)
4358 | case FSCONFIG_SET_BINARY:
| ^~~~~~~~~~~~~~~~~~~
../linux-user/strace.c:4361:10: error: =E2=80=98FSCONFIG_SET_PATH=E2=80=99 =
undeclared
(first use in this function)
4361 | case FSCONFIG_SET_PATH:
| ^~~~~~~~~~~~~~~~~
../linux-user/strace.c:4364:10: error: =E2=80=98FSCONFIG_SET_PATH_EMPTY=E2=
=80=99
undeclared (first use in this function)
4364 | case FSCONFIG_SET_PATH_EMPTY:
| ^~~~~~~~~~~~~~~~~~~~~~~
../linux-user/strace.c:4367:10: error: =E2=80=98FSCONFIG_SET_FD=E2=80=99 un=
declared
(first use in this function); did you mean =E2=80=98CONFIG_GETTID=E2=80=99?
4367 | case FSCONFIG_SET_FD:
| ^~~~~~~~~~~~~~~
| CONFIG_GETTID
../linux-user/strace.c:4370:10: error: =E2=80=98FSCONFIG_CMD_CREATE=E2=80=
=99
undeclared (first use in this function)
4370 | case FSCONFIG_CMD_CREATE:
| ^~~~~~~~~~~~~~~~~~~
../linux-user/strace.c:4373:10: error: =E2=80=98FSCONFIG_CMD_RECONFIGURE=E2=
=80=99
undeclared (first use in this function)
4373 | case FSCONFIG_CMD_RECONFIGURE:
| ^~~~~~~~~~~~~~~~~~~~~~~~
../linux-user/strace.c: In function =E2=80=98print_fsconfig=E2=80=99:
../linux-user/strace.c:4408:10: error: =E2=80=98FSCONFIG_SET_FLAG=E2=80=99 =
undeclared
(first use in this function)
4408 | case FSCONFIG_SET_FLAG:
| ^~~~~~~~~~~~~~~~~
../linux-user/strace.c:4409:10: error: =E2=80=98FSCONFIG_SET_STRING=E2=80=
=99
undeclared (first use in this function)
4409 | case FSCONFIG_SET_STRING:
| ^~~~~~~~~~~~~~~~~~~
../linux-user/strace.c:4410:10: error: =E2=80=98FSCONFIG_SET_BINARY=E2=80=
=99
undeclared (first use in this function)
4410 | case FSCONFIG_SET_BINARY:
| ^~~~~~~~~~~~~~~~~~~
../linux-user/strace.c:4411:10: error: =E2=80=98FSCONFIG_SET_PATH=E2=80=99 =
undeclared
(first use in this function)
4411 | case FSCONFIG_SET_PATH:
| ^~~~~~~~~~~~~~~~~
../linux-user/strace.c:4412:10: error: =E2=80=98FSCONFIG_SET_PATH_EMPTY=E2=
=80=99
undeclared (first use in this function)
4412 | case FSCONFIG_SET_PATH_EMPTY:
| ^~~~~~~~~~~~~~~~~~~~~~~
../linux-user/strace.c:4413:10: error: =E2=80=98FSCONFIG_SET_FD=E2=80=99 un=
declared
(first use in this function); did you mean =E2=80=98CONFIG_GETTID=E2=80=99?
4413 | case FSCONFIG_SET_FD:
| ^~~~~~~~~~~~~~~
| CONFIG_GETTID

https://gitlab.com/qemu-project/qemu/-/jobs/14787411039#L3244

> +static void
> +print_fsconfig_cmd_name(int cmd)
> +{
> +    switch (cmd) {
> +    case FSCONFIG_SET_FLAG:
> +        qemu_log("%s%s", "FSCONFIG_SET_FLAG", get_comma(0));
> +        break;
> +    case FSCONFIG_SET_STRING:
> +        qemu_log("%s%s", "FSCONFIG_SET_STRING", get_comma(0));
> +        break;
> +    case FSCONFIG_SET_BINARY:
> +        qemu_log("%s%s", "FSCONFIG_SET_BINARY", get_comma(0));
> +        break;
> +    case FSCONFIG_SET_PATH:
> +        qemu_log("%s%s", "FSCONFIG_SET_PATH", get_comma(0));
> +        break;
> +    case FSCONFIG_SET_PATH_EMPTY:
> +        qemu_log("%s%s", "FSCONFIG_SET_PATH_EMPTY", get_comma(0));
> +        break;
> +    case FSCONFIG_SET_FD:
> +        qemu_log("%s%s", "FSCONFIG_SET_FD", get_comma(0));
> +        break;
> +    case FSCONFIG_CMD_CREATE:
> +        qemu_log("%s%s", "FSCONFIG_CMD_CREATE", get_comma(0));
> +        break;
> +    case FSCONFIG_CMD_RECONFIGURE:
> +        qemu_log("%s%s", "FSCONFIG_CMD_RECONFIGURE", get_comma(0));
> +        break;
> +#ifdef FSCONFIG_CMD_CREATE_EXCL
> +    case FSCONFIG_CMD_CREATE_EXCL:
> +        /* Only available since Linux 6.6. */
> +        qemu_log("%s%s", "FSCONFIG_CMD_CREATE_EXCL", get_comma(0));
> +        break;
> +#endif
> +    default:
> +        qemu_log("%s (%d)%s", "UNKNOWN_CMD", cmd, get_comma(0));
> +        break;
> +    }
> +}
> +
> +static void
> +print_fsconfig(CPUArchState *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    /*
> +     * fsconfig(int fd, int cmd, char* key, void* value, int aux)
> +     * Where:
> +     * fd: file descriptor returned by fsopen().
> +     * cmd: integer constant specifying a command.
> +     * key: a string, can be NULL on certain commands.
> +     * value: any data in a buffer, can be NULL, raw buffer or a string.
> +     * aux: axillary values such as flags for FSCONFIG_SET_PATH.
> +     */
> +    int cmd =3D (int) arg1;
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_fsconfig_cmd_name(cmd);
> +    /* Process arg2 (key). */
> +    switch (cmd) {
> +    case FSCONFIG_SET_FLAG:
> +    case FSCONFIG_SET_STRING:
> +    case FSCONFIG_SET_BINARY:
> +    case FSCONFIG_SET_PATH:
> +    case FSCONFIG_SET_PATH_EMPTY:
> +    case FSCONFIG_SET_FD:
> +        print_string(arg2, 0);
> +        break;
> +    default:
> +        print_pointer(arg2, 0);
> +        break;
> +    }
> +    /* Process arg3 (value). */
> +    switch (cmd) {
> +    case FSCONFIG_SET_STRING:
> +    case FSCONFIG_SET_PATH:
> +    case FSCONFIG_SET_PATH_EMPTY:
> +        print_string(arg3, 0);
> +        break;
> +    default:
> +        print_pointer(arg3, 0);
> +        break;
> +    }
> +    /*
> +     * Process arg4 (aux).
> +     * On FSCONFIG_SET_PATH and FSCONFIG_SET_PATH_EMPTY, aux can
> +     * be either 0 or AT_FDCWD.
> +     * On FSCONFIG_SET_BINARY, aux is an integer to state the length
> +     * of the buffer pointed by arg3.
> +     * Otherwise, it must be 0.
> +     */
> +    switch (cmd) {
> +    case FSCONFIG_SET_PATH:
> +    case FSCONFIG_SET_PATH_EMPTY:
> +        print_at_dirfd(arg4, 1);
> +        break;
> +    default:
> +        print_raw_param("%d", arg4, 1);
> +        break;
> +    }
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_ioctl
>  static void
>  print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 6162a407f9..3a366b8cac 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1722,3 +1722,18 @@
>  #ifdef TARGET_NR_rseq
>  { TARGET_NR_rseq, "rseq" , "%s(%p,%u,%d,%#x)", NULL, NULL },
>  #endif
> +#ifdef TARGET_NR_fsopen
> +{ TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
> +#endif
> +#ifdef TARGET_NR_fsconfig
> +{ TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
> +#endif
> +#ifdef TARGET_NR_fsmount
> +{ TARGET_NR_fsmount, "fsmount", "%s(%d,%d,%d)", NULL, NULL },
> +#endif
> +#ifdef TARGET_NR_move_mount
> +{ TARGET_NR_move_mount, "move_mount", "%s(%d,%s,%d,%s,%d)", NULL, NULL }=
,
> +#endif
> +#ifdef TARGET_NR_fspick
> +{ TARGET_NR_fspick, "fspick", "%s(%d,%s,%d)", NULL, NULL },
> +#endif
> --
> 2.54.0
>
>

