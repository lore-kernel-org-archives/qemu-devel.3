Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F12CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAptS-0007vV-M6; Fri, 02 May 2025 08:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uAptQ-0007vH-8I
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:53:28 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uAptO-0000bW-84
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:53:28 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so332820666b.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746190404; x=1746795204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKTCUo16RGCEv7+YHxIHGL7zLzA8SixBikNRyxni/tY=;
 b=cKM5mHcbmvWUVi40RrPTNmJb9cgKWk/6vaGFuf19fk0ujYJRUvyzQRbDLaZ+H52Uod
 r3OfJEt0+bqnxRcncbPlawv9Jmn/U7UPoSMTt6IIUWlijtsx/YwP73ODiucv+6K21ynm
 F6IY/VLjvJDcjQscuG/IPXRNe6xGbqDPaPsu8MVzXrMwby9EoTsKhW+e3xRKg89s+dj8
 zWkDrrzmz8rkA4OZ44qRNwIuacx4BFM7vLZHsm561Cx8y4d1gYyZ+j1pR1gU/Sf/TZIs
 tctuDbJqka2Hy5RT5Sw2zgdtvXAQ+S2LIgkZwd0Z8a1DYRVzvMj7Dg/fjItLf4/D606P
 Mwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746190404; x=1746795204;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aKTCUo16RGCEv7+YHxIHGL7zLzA8SixBikNRyxni/tY=;
 b=DwkgR6TaG2qn6NohgE59JZ7G3ZmAsYpXKcf5BmAfVmwt+Q3wRxXYrpk+xlvO/BIPUO
 2Bi1fTw8518Yc5a7okXZZ26ByDoCCQwVemX3u3pvJjcPYNdjBHPetyR3D704r3CWjwok
 YqktBeol2XP7FEe0kPOl9E58oOy/jYrneRH0XP9YuxWQZiAaBYbnrlawokFaXjsoY3hY
 pnlHUmU5/mcsoidkIhiQBHltAVP/lbEmRN0v0BNxYbXCYeMPua7QkMQ0E5AMdLS4LN4N
 /nOgwa6bE14Ok2oQbNMJWDMqWbm8I5fbn2CZihr8qFZ5ntj/f+S4La33f0Thiw6d6crm
 WkSw==
X-Gm-Message-State: AOJu0YyZp13rLzxMgA2CDV+KM06AluCVBqOHAn3nTyZGLs/I7Fe292nv
 Ui2GmbwN49fg6vfpaz7eL3iDsPzb/YBFemaW3KEuYbuPdrORRkqRKsKBRj3+FDc=
X-Gm-Gg: ASbGncto4cI2L9Ik0ZwPZr4XY5+MVqPxz5nDPjNxH8hvCUW6WXE4Y0LsBQUxp/eC5S/
 F89jv82vpmM2JnGu6KNyB2oP0B0Vx5+Fcb2OwQmqFUgOqkYaPzlJIpNka7c9ceAAWO7Yyx+WQvR
 W+9va71C6UIdtI/K0J5Wwb8lnBl6hkvm/TREVOr1CZp/5gIN3AG8iTD40tj4LNODrxaHd6sDgfX
 57/rgdEfYMKX3HNQ87G7/hjyxHJBtxJIMBQSnvVlGxizIh2Jy7eJJBiKIUYK/Adsjky84X9dfTC
 CZMMdFetBHDjPCpcbP+Jr5/8uyODK5IkYNCky5EwaGc=
X-Google-Smtp-Source: AGHT+IHh1anvBWUyq2ugYzA7nMVs3wRnM35wLZOMUnLJLVjl2sZRg9HBUnpxjIj7v0umkn+Wl8GViA==
X-Received: by 2002:a17:906:dc90:b0:aca:a347:c050 with SMTP id
 a640c23a62f3a-ad17a85cd42mr266286666b.0.1746190403870; 
 Fri, 02 May 2025 05:53:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18950973bsm45791466b.142.2025.05.02.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 05:53:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 651725F86B;
 Fri,  2 May 2025 13:53:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc: qemu-devel@nongnu.org,  gustavo.romero@linaro.org,
 richard.henderson@linaro.org,  philmd@linaro.org,
 manos.pitsidianakis@linaro.org,  Patryk 'patryk4815' Sondej
 <patryk.sondej@gmail.com>
Subject: Re: [PATCH] gdbstub: Implement qGDBServerVersion packet
In-Reply-To: <20250403191340.53343-1-dominik.b.czarnota@gmail.com> (Dominik
 Czarnota's message of "Thu, 3 Apr 2025 21:13:40 +0200")
References: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 02 May 2025 13:53:22 +0100
Message-ID: <87jz6zw4vx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com> writes:

> This commit adds support for the `qGDBServerVersion` packet to the qemu
> gdbstub  which could be used by clients to detect the QEMU version
> (and, e.g., use a workaround for known bugs).
>
> This packet is not documented/standarized by GDB but it was implemented
> by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].
>
> This has been implemented by Patryk, who I included in Co-authored-by
> and who asked me to send the patch.
>
> [0] https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
> [1] https://github.com/pwndbg/pwndbg/issues/2648
>
> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
> Signed-off-by: Dominik 'Disconnect3d' Czarnota
> <dominik.b.czarnota@gmail.com>

Hmm:

cc -m64 -Ilibuser.a.p -I. -I../.. -Iqapi -Itrace -Iui -Iui/shader -I/usr/in=
clude/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-c=
olor=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protect=
or-strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-secur=
ity -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-sel=
f -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-st=
yle-declaration -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -=
Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing=
-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /home/alex/lsrc=
/qemu.git/linux-headers -isystem linux-headers -iquote . -iquote /home/alex=
/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git/include -iquote /home/alex/=
lsrc/qemu.git/host/include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/inc=
lude/generic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -mss=
e2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-a=
liasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero -fzero-call-used=
-regs=3Dused-gpr -fPIE -DCONFIG_USER_ONLY -DCOMPILING_SYSTEM_VS_USER -MD -M=
Q libuser.a.p/gdbstub_gdbstub.c.o -MF libuser.a.p/gdbstub_gdbstub.c.o.d -o =
libuser.a.p/gdbstub_gdbstub.c.o -c ../../gdbstub/gdbstub.c
../../gdbstub/gdbstub.c: In function =E2=80=98handle_query_gdb_server_versi=
on=E2=80=99:
../../gdbstub/gdbstub.c:1603:74: error: implicit declaration of function =
=E2=80=98target_name=E2=80=99 [-Werror=3Dimplicit-function-declaration]
 1603 |     g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:=
%s;", target_name(), QEMU_VERSION);
      |                                                                    =
      ^~~~~~~~~~~
../../gdbstub/gdbstub.c:1603:74: error: nested extern declaration of =E2=80=
=98target_name=E2=80=99 [-Werror=3Dnested-externs]
../../gdbstub/gdbstub.c:1603:46: error: format =E2=80=98%s=E2=80=99 expects=
 argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =E2=80=
=98int=E2=80=99 [-Werror=3Dformat=3D]
 1603 |     g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:=
%s;", target_name(), QEMU_VERSION);
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~~~  ~~~~~~~~~~~~~
      |                                                                    =
      |
      |                                                                    =
      int
cc1: all warnings being treated as errors

where did target_name() come from and/or go to?

> ---
>  gdbstub/gdbstub.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 282e13e163..8d616a7f52 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1582,6 +1582,16 @@ static void handle_query_threads(GArray *params, v=
oid *user_ctx)
>      gdbserver_state.query_cpu =3D gdb_next_attached_cpu(gdbserver_state.=
query_cpu);
>  }
>=20=20
> +static void handle_query_gdb_server_version(GArray *params, void *user_c=
tx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:%s;",=
 target_name(), QEMU_VERSION);
> +#else
> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-system-%s;versio=
n:%s;", target_name(), QEMU_VERSION);
> +#endif
> +    gdb_put_strbuf();
> +}
> +
>  static void handle_query_first_threads(GArray *params, void *user_ctx)
>  {
>      gdbserver_state.query_cpu =3D gdb_first_attached_cpu();
> @@ -1827,6 +1837,10 @@ static const GdbCmdParseEntry gdb_gen_query_table[=
] =3D {
>          .handler =3D handle_query_threads,
>          .cmd =3D "sThreadInfo",
>      },
> +    {
> +        .handler =3D handle_query_gdb_server_version,
> +        .cmd =3D "GDBServerVersion",
> +    },
>      {
>          .handler =3D handle_query_first_threads,
>          .cmd =3D "fThreadInfo",

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

