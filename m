Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AFFCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PPL-0000C0-DR; Thu, 16 Oct 2025 10:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PPI-0000B9-VW
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:56:44 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PPC-0008W6-Pe
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:56:44 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so149088166b.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760626595; x=1761231395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AYPIdEsoAMLYFBuom60D9v7vT0wj7FvGb5ra70rjWI=;
 b=KdtI5FnAZaKlTJPbgDrB5px5dHUnEc2san52C03Py/NOdtK4M1+xU8cXUr3ehXnArl
 kSspnwpflhLKtAp5j6QpgBXUUA/JmEAZXQN4JMx5nuqimF2yg5sGo15ysG2bk2yhAAPq
 7NoPR15pVciIu78AnhClL41oua+QDw9snfX+OGGKeRhVUUALI5xa2At0Y2/A5LQD1cHt
 8gu+0+SDp/jwRmXAoAy3oH1xh7pJYljY8pYpuMLykjd8OTYS1gVwX+h44a8kS7bUyMJF
 dqrvo/C6uumaC6GJA63t8n6D/V3JdL7S7bKT9BttOibtq96pcnetCTuMvctQFMQeuhOJ
 HgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760626595; x=1761231395;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7AYPIdEsoAMLYFBuom60D9v7vT0wj7FvGb5ra70rjWI=;
 b=H5mMn+VVJBVlBFU1omulBIxPsX2N4miu08KxU0evx2GRqUHIrQPgHrfSeFb4O2WPnX
 mesjOv7KQsQj3U6yjZ78tay6mPWYZnBI71alUto+/M3fpsbWZTvu3GE0yhfdSvzoaFc/
 vbk9vq36Bj+/7u1dPXC5I1VFh3Q9JrU53uMGpoVIEsRV5gvHBlYqDFmDTTAfGzf0OziK
 y7AfjdwlFOMybiY3NhWuNTWV/3GcCieeptJ7Ai3yEhFb8mvCg5gpxlxnzcLazcOxfSf7
 7RyXfyok6CBvLYrp6WllVpWYJ4TbJ/UPDyqqGuvCBpz2Fb+Xk8z5DHk3DyTPNoudFZVX
 +A4w==
X-Gm-Message-State: AOJu0YxlHvwHYREQzix4qr5NaAV5RwUBKHgAn37JJZih3R/STjEyYSm3
 PDNrT3hUHPy6pHetKlvD5yuGveM3/YuwT7AIptMWKkyujoNtTiZ7uld0bvxU66Pa/1k=
X-Gm-Gg: ASbGncsXqQmZQk4WbPAtqkVctJrM1I+TnGtfxl9xi5Fw1ydTnNdSSzuhuArto9mxRY3
 /7sSi5iHp8tUc0g9yjtUWhF8NKUhS//p8pkVm3dmKBa80QG6qGSnmcdp+gCOnj7plOTiLvCksIL
 0aG8fdsLLuVsv6Vy4B4q1A9/7YsGQOm2DJ/IHgOyO4T1rIDaeFvkBp95sTmVcc9hdyoqcyrYlyO
 dUmg4rcVVo2tDjNaL+xeTSTdAlTP4OgJKeZ0hQqNKpbH0rBNmzw4YC/lctdwQdLcLXHdBITV66c
 gB8ZcMY0KEJMUdMVLqYd3ccWM3S4KByTQ+KoqcdsZd2+pNL7lLovmu3z0XGDi1I5bE76elVgXGq
 cMJmIq9uXyR97OpDIQGsCZLEZn4P3btqAjrJzuPCxu2gAEO3t5lfhq/yqfLsSzb9nQlR/tGQUH7
 B4
X-Google-Smtp-Source: AGHT+IHGZWgr7m12+1Z6Z7xkMnuNN1fDEJGM8CrtBkUZWYgh/kblpHlGFLvBnxzwDMjo2HD0JHuNHA==
X-Received: by 2002:a17:907:3cc9:b0:b09:c230:12dc with SMTP id
 a640c23a62f3a-b6472d5d530mr24170966b.8.1760626595288; 
 Thu, 16 Oct 2025 07:56:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cccdaa1bbsm533811366b.58.2025.10.16.07.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 07:56:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9847E5F80C;
 Thu, 16 Oct 2025 15:56:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org,  Dominik 'Disconnect3d' Czarnota
 <dominik.b.czarnota@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] gdbstub/user-target: Map errno values from the host OS
 to GDB
In-Reply-To: <20251015162520.15736-1-yodel.eldar@yodel.dev> (Yodel Eldar's
 message of "Wed, 15 Oct 2025 11:25:20 -0500")
References: <20251015162520.15736-1-yodel.eldar@yodel.dev>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 16 Oct 2025 15:56:33 +0100
Message-ID: <87o6q6j3oe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Yodel Eldar <yodel.eldar@yodel.dev> writes:

> This patch introduces the function "gdb_host_errno_to_gdb" that maps
> host-dependent errno values to their GDB protocol-specific
> representations as listed in the GDB manual [1].
>
> The stub now uses the correct GDB errno values in F reply packets.
>
> [1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.h=
tml
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2751
> Reported-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.co=
m>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>  gdbstub/user-target.c | 93 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 4 deletions(-)
>
> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
> index 43231e695e..29feb0509c 100644
> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -302,6 +302,87 @@ static void hostio_reply_with_data(const void *buf, =
size_t n)
>                            gdbserver_state.str_buf->len, true);
>  }
>=20=20
> +/*
> + * Map host error numbers to their GDB protocol counterparts.
> + * For the list of GDB File-I/O supported error numbers, please consult:
> + * https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.h=
tml
> + */
> +
> +static int gdb_host_errno_to_gdb(int errnum)
> +{
> +    enum {
> +        GDB_EPERM        =3D    1,
> +        GDB_ENOENT       =3D    2,
> +        GDB_EINTR        =3D    4,
> +        GDB_EIO          =3D    5,
> +        GDB_EBADF        =3D    9,
> +        GDB_EACCES       =3D   13,
> +        GDB_EFAULT       =3D   14,
> +        GDB_EBUSY        =3D   16,
> +        GDB_EEXIST       =3D   17,
> +        GDB_ENODEV       =3D   19,
> +        GDB_ENOTDIR      =3D   20,
> +        GDB_EISDIR       =3D   21,
> +        GDB_EINVAL       =3D   22,
> +        GDB_ENFILE       =3D   23,
> +        GDB_EMFILE       =3D   24,
> +        GDB_EFBIG        =3D   27,
> +        GDB_ENOSPC       =3D   28,
> +        GDB_ESPIPE       =3D   29,
> +        GDB_EROFS        =3D   30,
> +        GDB_ENOSYS       =3D   88,
> +        GDB_ENAMETOOLONG =3D   91,
> +        GDB_EUNKNOWN     =3D 9999,
> +    };

We have this enum in include/gdbstub/syscalls.h already.

> +
> +    switch (errnum) {
> +    case EPERM:
> +        return GDB_EPERM;
> +    case ENOENT:
> +        return GDB_ENOENT;
> +    case EINTR:
> +        return GDB_EINTR;
> +    case EIO:
> +        return GDB_EIO;
> +    case EBADF:
> +        return GDB_EBADF;
> +    case EACCES:
> +        return GDB_EACCES;
> +    case EFAULT:
> +        return GDB_EFAULT;
> +    case EBUSY:
> +        return GDB_EBUSY;
> +    case EEXIST:
> +        return GDB_EEXIST;
> +    case ENODEV:
> +        return GDB_ENODEV;
> +    case ENOTDIR:
> +        return GDB_ENOTDIR;
> +    case EISDIR:
> +        return GDB_EISDIR;
> +    case EINVAL:
> +        return GDB_EINVAL;
> +    case ENFILE:
> +        return GDB_ENFILE;
> +    case EMFILE:
> +        return GDB_EMFILE;
> +    case EFBIG:
> +        return GDB_EFBIG;
> +    case ENOSPC:
> +        return GDB_ENOSPC;
> +    case ESPIPE:
> +        return GDB_ESPIPE;
> +    case EROFS:
> +        return GDB_EROFS;
> +    case ENOSYS:
> +        return GDB_ENOSYS;
> +    case ENAMETOOLONG:
> +        return GDB_ENAMETOOLONG;
> +    default:
> +        return GDB_EUNKNOWN;
> +    }
> +}
> +
>  void gdb_handle_v_file_open(GArray *params, void *user_ctx)
>  {
>      const char *filename =3D get_filename_param(params, 0);
> @@ -315,7 +396,8 @@ void gdb_handle_v_file_open(GArray *params, void *use=
r_ctx)
>      int fd =3D open(filename, flags, mode);
>  #endif
>      if (fd < 0) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
> +        int gdb_errno =3D gdb_host_errno_to_gdb(errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>      } else {
>          g_string_printf(gdbserver_state.str_buf, "F%x", fd);
>      }
> @@ -327,7 +409,8 @@ void gdb_handle_v_file_close(GArray *params, void *us=
er_ctx)
>      int fd =3D gdb_get_cmd_param(params, 0)->val_ul;
>=20=20
>      if (close(fd) =3D=3D -1) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
> +        int gdb_errno =3D gdb_host_errno_to_gdb(errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>          gdb_put_strbuf();
>          return;
>      }
> @@ -350,7 +433,8 @@ void gdb_handle_v_file_pread(GArray *params, void *us=
er_ctx)
>=20=20
>      ssize_t n =3D pread(fd, buf, bufsiz, offset);
>      if (n < 0) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
> +        int gdb_errno =3D gdb_host_errno_to_gdb(errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>          gdb_put_strbuf();
>          return;
>      }
> @@ -373,7 +457,8 @@ void gdb_handle_v_file_readlink(GArray *params, void =
*user_ctx)
>      ssize_t n =3D readlink(filename, buf, BUFSIZ);
>  #endif
>      if (n < 0) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
> +        int gdb_errno =3D gdb_host_errno_to_gdb(errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>          gdb_put_strbuf();
>          return;
>      }

with that fixed:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

