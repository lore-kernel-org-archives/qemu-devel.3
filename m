Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF1DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH05K-0000R2-RX; Mon, 19 May 2025 08:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH05G-0000Qc-CD
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:59:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH05D-0001An-5X
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:59:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so25142565e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747659545; x=1748264345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wju8kJoyatCef446Jva9JRWQWE/g3HoLGqXsHbl149s=;
 b=H7b3bNH2wU+dyy/gAK26NLM4QTDPB72n8g0clV1qCVlVFa5ob3cvoMfIM4i3UAEQpD
 5h8yPzDZqddFcF0upUm9Yq3SKPXCNhXZetVUY15JCeg8FPJ2Qs0ADHcE41lwB+3oZPOw
 O3PPP+JZuyx/dcc/FZ1H+sqrfNnttvZUcLLDphEx/c0aR7BG0rYUz/0U8fcTV+XXUAlW
 Gzl5bjI7A51X3p0yQ+Iuo7vG6U66n7nmGBQbK9VPGRKJJX8gW4WHTKxF0nvPHfZCaYjB
 ZDroo06HxrhhgwN7BQTKY0AsEsxLu0j47oQR22x13IOpieWkJ0LHJ3ffsULpHya7nfDq
 wEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747659545; x=1748264345;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wju8kJoyatCef446Jva9JRWQWE/g3HoLGqXsHbl149s=;
 b=c+IyKPsEXpc+uDuYKmoMzf+r46GLyvaqkCl+OTE5L7E8Ou252yoWK0SAUwY/Hi4ezK
 926N9hs1JpvaPn0dxriWe1/11JjliATvZaVT8fVkaFO+LmqJ1qdhNOcAh57d2e6HxFHI
 mnCEx+YjTQxS457hEgkdq9eImk+7Wp3gATgH6cpybdeTvbjZaT+ReSJ/xtvRYARhorr5
 P5kyD6nS1judJ0RpX3DxILwwYyag7Oo8pPh7zjA+cTwVrQ4GysXb+wBY9BkAp0RXm+zW
 N/5tvZyx6ri/uxB++U4+e2KuvZMSSGZPdmkXeVECG5itN3wojHwM9t3s/0YJL4KUg7eJ
 aCvA==
X-Gm-Message-State: AOJu0Yy5TyjuszwyChJ6puvrOlSO8BTVAHiLZxtjcSkhHrgWIIOxGh9t
 JqiZDsXj9sAzuDgsL7o/zkl9nEzlKxqGYl7gZRyLaLXrmu/vb+/aG5M0ehLvXXKkQd4=
X-Gm-Gg: ASbGnctTUXtajSSMMr+SuKW0ff7zuhBSxlN/TtR9g3IduKfq60Uw25JbxGsJZ2q4Xfr
 nkm0+4HyDvFlAg0c58yihpnEQrEYcXrtBoJUoo+v4Hbc2yjjdiCrwkzX/kD54TIKWarzhruFsHf
 TyVrt3X75R4QlH7hpuBTraePp/HkQh+fhGvFg6aYkXMFLsdzviMlvhaqqpUv0RH20MZWIrD1OgX
 Oc8DShVVjoUachje6sjCVrtmW1tN8DaxStP+f/Gl2dzA2kDT5SW+LfRHultdAIuLEdO3K2V7kud
 2sff8NxxZhrUUAAIOF7xyP9K9SG/aRbvCxMaj7qV3t04yjZj89cy
X-Google-Smtp-Source: AGHT+IF2g9x7+i2GeMUbon/yZ3BQUuFVkV0J7OUzt8O1UG5SQJAQcHU0RpwC0vxS1faD0/ez/lUSVw==
X-Received: by 2002:a05:6000:2211:b0:3a3:6c6e:ea33 with SMTP id
 ffacd0b85a97d-3a36c6eeb2dmr3592213f8f.18.1747659545204; 
 Mon, 19 May 2025 05:59:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd51583dsm135895995e9.22.2025.05.19.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 05:59:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C01BF5F87C;
 Mon, 19 May 2025 13:59:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc: qemu-devel@nongnu.org,  gustavo.romero@linaro.org,
 richard.henderson@linaro.org,  philmd@linaro.org,
 manos.pitsidianakis@linaro.org,  Patryk 'patryk4815' Sondej
 <patryk.sondej@gmail.com>
Subject: Re: [PATCH] gdbstub: Implement qGDBServerVersion packet
In-Reply-To: <87jz6zw4vx.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Fri, 02 May 2025 13:53:22 +0100")
References: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
 <87jz6zw4vx.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 19 May 2025 13:59:03 +0100
Message-ID: <87ecwksqnc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com> writes:
>
>> This commit adds support for the `qGDBServerVersion` packet to the qemu
>> gdbstub  which could be used by clients to detect the QEMU version
>> (and, e.g., use a workaround for known bugs).
>>
>> This packet is not documented/standarized by GDB but it was implemented
>> by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].
>>
>> This has been implemented by Patryk, who I included in Co-authored-by
>> and who asked me to send the patch.
>>
>> [0] https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
>> [1] https://github.com/pwndbg/pwndbg/issues/2648
>>
>> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
>> Signed-off-by: Dominik 'Disconnect3d' Czarnota
>> <dominik.b.czarnota@gmail.com>
>
> Hmm:
>
> cc -m64 -Ilibuser.a.p -I. -I../.. -Iqapi -Itrace -Iui -Iui/shader
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g
> -fstack-protector-strong -Wempty-body -Wendif-labels
> -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
> -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> -Wno-shift-negative-value -isystem
> /home/alex/lsrc/qemu.git/linux-headers -isystem linux-headers -iquote
> . -iquote /home/alex/lsrc/qemu.git -iquote
> /home/alex/lsrc/qemu.git/include -iquote
> /home/alex/lsrc/qemu.git/host/include/x86_64 -iquote
> /home/alex/lsrc/qemu.git/host/include/generic -iquote
> /home/alex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -msse2 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
> -fzero-call-used-regs=3Dused-gpr -fPIE -DCONFIG_USER_ONLY
> -DCOMPILING_SYSTEM_VS_USER -MD -MQ libuser.a.p/gdbstub_gdbstub.c.o -MF
> libuser.a.p/gdbstub_gdbstub.c.o.d -o libuser.a.p/gdbstub_gdbstub.c.o
> -c ../../gdbstub/gdbstub.c
> ../../gdbstub/gdbstub.c: In function =E2=80=98handle_query_gdb_server_ver=
sion=E2=80=99:
> ../../gdbstub/gdbstub.c:1603:74: error: implicit declaration of function =
=E2=80=98target_name=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>  1603 |     g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;versio=
n:%s;", target_name(), QEMU_VERSION);
>       |                                                                  =
        ^~~~~~~~~~~
> ../../gdbstub/gdbstub.c:1603:74: error: nested extern declaration of =E2=
=80=98target_name=E2=80=99 [-Werror=3Dnested-externs]
> ../../gdbstub/gdbstub.c:1603:46: error: format =E2=80=98%s=E2=80=99 expec=
ts argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =E2=
=80=98int=E2=80=99 [-Werror=3Dformat=3D]
>  1603 |     g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;versio=
n:%s;", target_name(), QEMU_VERSION);
>       |                                              ^~~~~~~~~~~~~~~~~~~~=
~~~~~~  ~~~~~~~~~~~~~
>       |                                                                  =
        |
>       |                                                                  =
        int
> cc1: all warnings being treated as errors
>
> where did target_name() come from and/or go to?

I fixed the include so queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

