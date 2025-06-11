Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A826C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLmk-0000Vg-Lk; Wed, 11 Jun 2025 09:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLmZ-0000Qy-1m
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:46:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLmL-0001nd-1R
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:46:17 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad88eb71eb5so916436866b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749649565; x=1750254365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5RAj/MpImh7qNE8LvEwmUj3HeRn3ZA7QnkvWQ4mSNQ=;
 b=g3pqmOWd8+7y8eNxFABFAMw/hqHUKE+EqB0IxpzXbX7ji5cl/2t5h9wC1xu7Q01mbD
 GY4mldFVdPaFZO3VbshKXndv52LudoNp4I6nUmwqs2yqSKqgLZ9feRL3J214ij2UxtjD
 W8atRgAAamrmnGPUQPIG4lzAAx/D8w+LuhWjG+8SveONc4yH0RcEjPWApagZ8MHWcDVG
 26Gs+eX1teEaeNS7BnynagTpL/x49enZok0QpcYsAc/5QzZf1RdDjG1rLFpnhy5ZMoSp
 ib79gMozskfF4WlOcVJy79vykIrgbPi9MaGBTUUlh8Ed9QgtsmOY/D6v283nkNB/xAv1
 r1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749649565; x=1750254365;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z5RAj/MpImh7qNE8LvEwmUj3HeRn3ZA7QnkvWQ4mSNQ=;
 b=GDpD5xk4dyVKSFJPdf+faAb6ceOkcQCmSSbViPQGGGOuFhMFVsmOaYtD9F8DlBwBgf
 vs8IBGZ+gDnZOcBoxa5xEUT0KjzKLzh1O+Z5wXBvlnnsSjP2b4zy4JlVCggB81hfY6rm
 tYBoNqE5eEoLvK3AxTRjdKp+R/d0O1oIiqaU+SztiCDQEwn3DmyqCww9WV5YpZWMmf+I
 DPp8Q1HyAyJqWcXsSdyDCd8xjuMiUdqoHdQiK/QxjnDbubbE/77Bt8aVFKyBY7nO05Qd
 2vEpcNEI5tG0tl4zIyWVXnU6s7BPCBfqM5DymMtzw8CyqsSUYvfusBazajthxzRWPaJ6
 YAlQ==
X-Gm-Message-State: AOJu0Yw0mNBqR+irofjvxxJkTsMZqfEGqCr0u6jAWZSiUoGizypp70gX
 yyks19QH0CCiA23oLPBd48pqH/4MIbfryNVi7ZvQ4Z4VAdHQGErCQ5RoR/a3q/YaSK4=
X-Gm-Gg: ASbGncu7Ud8RK4hc9hOk6TT6SymQ8X8n4bS5RYx1CuoJ5fz3VfBF+NrsiKbLsXG5xIN
 T2e/i85JxQQEdH8aENkCaE1riXmV0D1NSutpg57GThQR0RdwZD/+7krmUGyOH16sB/hBnaN2FP3
 WUctB4x0f+7F04dVbJChcgARVlsj4cSSBybzvDWG2+yD+E+3w71VD12oR37FJAqo5hLbNNyIWdC
 AGpMJJ2xMsX/MKJFS/aXbfU5r7N7kkM1drBY9LJSP3JUGbuEuIrbIo1JIi2fAlAqOKIAUQ+vISY
 GNa9gnr3mvqX32gbStYYP+4sc6j8Epih9Uhl0zF/OkyWhRjKFf3KYA0PzIbPTYQ=
X-Google-Smtp-Source: AGHT+IEYrZFePV5D92IZlQh9guNvntrLJWeQVWiV73tTfI+NpA7OcLwz7PPByIwVNK+mk2V8b+7D7A==
X-Received: by 2002:a17:907:d8f:b0:ad8:8621:9241 with SMTP id
 a640c23a62f3a-ade8981f595mr358005466b.54.1749649564644; 
 Wed, 11 Jun 2025 06:46:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d7541b8sm895649166b.8.2025.06.11.06.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 06:46:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D8D025F7CB;
 Wed, 11 Jun 2025 14:46:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 09/19] accel: Factor accel_cpu_realize() out
In-Reply-To: <20250606164418.98655-10-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Jun 2025 18:44:08
 +0200")
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-10-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 11 Jun 2025 14:46:01 +0100
Message-ID: <87plfajsrq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Factor accel_cpu_realize() out of accel_cpu_common_realize()
> for re-use.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  accel/accel-internal.h |  2 ++
>  include/qemu/accel.h   |  2 ++
>  accel/accel-common.c   | 15 ++++++++++++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/accel/accel-internal.h b/accel/accel-internal.h
> index d3a4422cbf7..b541377c349 100644
> --- a/accel/accel-internal.h
> +++ b/accel/accel-internal.h
> @@ -14,4 +14,6 @@
>=20=20
>  void accel_init_ops_interfaces(AccelClass *ac);
>=20=20
> +bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
> +
>  #endif /* ACCEL_SYSTEM_H */
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index c660c5f4b11..3c9aaf9523c 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -91,6 +91,8 @@ void accel_setup_post(MachineState *ms);
>   */
>  void accel_cpu_instance_init(CPUState *cpu);
>=20=20
> +bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
> +

Duplicate forward declarations:

  FAILED: libuser.a.p/accel_accel-user.c.o=20
  cc -m64 -Ilibuser.a.p -I. -I../.. -I../../common-user/host/x86_64 -I../..=
/linux-user/include/host/x86_64 -I../../linux-user/include -Iqapi -Itrace -=
Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.=
0/include -I/usr/include/sysprof-6 -fdiagnostics-color=3Dauto -Wall -Winval=
id-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body -W=
endif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wignore=
d-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-attrib=
ute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-sty=
le-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wtype=
-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi =
-Wno-shift-negative-value -isystem /home/alex/lsrc/qemu.git/linux-headers -=
isystem linux-headers -iquote . -iquote /home/alex/lsrc/qemu.git -iquote /h=
ome/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qemu.git/host/includ=
e/x86_64 -iquote /home/alex/lsrc/qemu.git/host/include/generic -iquote /hom=
e/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -msse2 -D_GNU_SOURCE -D_FILE_=
OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwra=
pv -ftrivial-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr -gsplit-=
dwarf -fPIE -DCONFIG_USER_ONLY -DCOMPILING_SYSTEM_VS_USER -MD -MQ libuser.a=
.p/accel_accel-user.c.o -MF libuser.a.p/accel_accel-user.c.o.d -o libuser.a=
.p/accel_accel-user.c.o -c ../../accel/accel-user.c
  In file included from ../../accel/accel-user.c:12:
  ../../accel/accel-internal.h:17:6: error: redundant redeclaration of =E2=
=80=98accel_cpu_realize=E2=80=99 [-Werror=3Dredundant-decls]
     17 | bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **=
errp);
        |      ^~~~~~~~~~~~~~~~~
  In file included from ../../accel/accel-user.c:11:
  /home/alex/lsrc/qemu.git/include/qemu/accel.h:94:6: note: previous declar=
ation of =E2=80=98accel_cpu_realize=E2=80=99 with type =E2=80=98_Bool(Accel=
State *, CPUState *, Error **)=E2=80=99
     94 | bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **=
errp);
        |      ^~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

