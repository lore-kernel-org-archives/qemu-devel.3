Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAECC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGro-0003Bl-Qk; Mon, 14 Jul 2025 06:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubGrL-000378-Cz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:56:36 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubGrI-0000AU-QW
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:56:35 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60c79bedc19so7349908a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752490589; x=1753095389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BojVnca2qM9Xs83BvQV9atzrWIOblWoGc60qJ1eb4sw=;
 b=lLk3y0T/XvGfjl/5jBRPSw94T8Rhdgo7eugGpv0/eI5oRFL/fI+rFG6SYbBIrTH9kK
 yo9P8e7VTp1c/Na3RfGOJ6KOzZ/esAY8Hh/L5EI20hmZA3ohI76YFPQx5Io7RixgTuFW
 buui+jR3Z3/vyy+KIllQVUf0sS36tAHWTD8LSoTOgujC9GgAaNvK23PTeljRnb4wRBu0
 Kr2i3cPUZhX4EpNDnj5Gx8p9btubFL5PrgLWWnUrJAyGouYcm4J8N89JdYJM9S4y1W7N
 RRV3MC5ZZsXUtZnV8cJsKKXCpQ1rp7B7Af95O/56zm6km9zSDykrAH3N0+te+hZv1TT/
 QjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752490589; x=1753095389;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BojVnca2qM9Xs83BvQV9atzrWIOblWoGc60qJ1eb4sw=;
 b=ODuOM/OKdG4/BwudJZXarg2QOsOBjlyNE03Cbf6vVNU/aYBJVynQPaFTWwuauVTXWc
 oltc2PPqYdVbtzu9TPyqQ579ZRRL0xqGuRa6b0pCVOnp4VBM7QjVLuvKwDCkVkso/D2A
 UrdYgXg70VfGlnzc4dGXIlHJWi/2jDXledLPy67BOw6gPBoGlAzdrgsyyGKVgKRj778l
 R71BWDi79ZJcggy++/Rfxw52z77UOP024BzV3Zlyo+oRm5BW93cW/Ik4JttGKgzxIVhl
 h0NNxr6mlrXky65/dft2TC8uvWal1eQb+pcA/ADD/9+zyQLal2AG/UqCEWJoRMJHcp5g
 j7CQ==
X-Gm-Message-State: AOJu0Yyq8KeWc82hKY9hOi501P9oynmdWNSeEz1Jn2BPZdPsIOFHnQOk
 DhegZdj3NBhaRtco8eEdZ0mTvRzbtpDrd2lHYdmsdwcvRBLyZCyfQrQ9KLHBPb1E1Dd3+ZQHw12
 C4ty+2mA=
X-Gm-Gg: ASbGncuUBziKLNIRp1BJR0PuvRJ4xvIRV94uy93sOsRi2NRfpsoZJhcT5Bu2X8H559e
 +iDH7AsVFVbFFHS3oVUOJEaNcA25c4dWvLkVmbemKCdSsH+J64XtqtX2QpZQTXiWQK5OsuL0SSD
 a4b6hk7SHVOK6wwWKsl6+4VJr4jKediDwKQ1G1NykfzeuV62PBdxaeO8AGrY0uktitGXxPl4Ont
 bapqycFvxD9DRnJLmEk8sIkaTHAWMBpb5/cxw+7Qt/CoLwq4WzvyKJOAl9PD58wQ0MviBhGicuD
 BFZJ95gD44dLlxLgPcOvCRrB8xoRQ6b+WpmTUgDj27EuY+k2Q5My28y02mpEvBROb24MiPP8YgV
 j2JAXUvbnlKWjP4Oq5q3QNT4=
X-Google-Smtp-Source: AGHT+IFcfcHBTAuQ7XWbPFgRXpP4eCrIfla8CmlyP/mrYkiG+BUTIv11J8uY15hwOKQkbJo0id4otg==
X-Received: by 2002:a17:907:3d05:b0:ae3:62cb:7654 with SMTP id
 a640c23a62f3a-ae6fbc8853amr1433605566b.17.1752490589116; 
 Mon, 14 Jul 2025 03:56:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e8294013sm803698966b.118.2025.07.14.03.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 03:56:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 556BF5F78F;
 Mon, 14 Jul 2025 11:56:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: unisono@quyllur.org
Cc: qemu-devel@nongnu.org,  atar4qemu@gmail.com,  laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk,  philmd@linaro.org
Subject: Re: [PATCH v2 1/3] Adds the GDB register XML files for Sparc64.
In-Reply-To: <20250711155141.62916-2-unisono@quyllur.org>
 (unisono@quyllur.org's message of "Fri, 11 Jul 2025 10:51:39 -0500")
References: <20250711155141.62916-1-unisono@quyllur.org>
 <20250711155141.62916-2-unisono@quyllur.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 14 Jul 2025 11:56:27 +0100
Message-ID: <87ms9711no.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

unisono@quyllur.org writes:

> From: Rot127 <unisono@quyllur.org>
>
> Commit 1/3
>
> Signed-off-by: Rot127 <unisono@quyllur.org>

I've queued this one to my current PR and cleaned up the commit message
to:

  gdbstub: add the GDB register XML files for sparc64.

  Signed-off-by: Rot127 <unisono@quyllur.org>
  Message-ID: <20250711155141.62916-2-unisono@quyllur.org>
  [AJB: clean up commit msg]
  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

It's ok to have single line commit messages when the title can
encapsulate everything you need to know. Extra stuff like Commit 1/3 is
just noise in the commit log.

> ---
>  configs/targets/sparc64-linux-user.mak |  1 +
>  configs/targets/sparc64-softmmu.mak    |  1 +
>  gdb-xml/sparc64-core.xml               | 99 ++++++++++++++++++++++++++
>  target/sparc/cpu.c                     |  1 +
>  4 files changed, 102 insertions(+)
>  create mode 100644 gdb-xml/sparc64-core.xml
>
> diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/spa=
rc64-linux-user.mak
> index 64ea04e3e2..7c2ecb7be0 100644
> --- a/configs/targets/sparc64-linux-user.mak
> +++ b/configs/targets/sparc64-linux-user.mak
> @@ -4,4 +4,5 @@ TARGET_ABI_DIR=3Dsparc
>  TARGET_SYSTBL_ABI=3Dcommon,64
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
> +TARGET_XML_FILES=3Dgdb-xml/sparc64-core.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc6=
4-softmmu.mak
> index 2504e31ae3..d9d51d21e5 100644
> --- a/configs/targets/sparc64-softmmu.mak
> +++ b/configs/targets/sparc64-softmmu.mak
> @@ -1,4 +1,5 @@
>  TARGET_ARCH=3Dsparc64
>  TARGET_BASE_ARCH=3Dsparc
>  TARGET_BIG_ENDIAN=3Dy
> +TARGET_XML_FILES=3Dgdb-xml/sparc64-core.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/gdb-xml/sparc64-core.xml b/gdb-xml/sparc64-core.xml
> new file mode 100644
> index 0000000000..375b9bb0cc
> --- /dev/null
> +++ b/gdb-xml/sparc64-core.xml
> @@ -0,0 +1,99 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.core">
> +  <reg name=3D"g0" bitsize=3D"64" type=3D"uint64" regnum=3D"0"/>
> +  <reg name=3D"g1" bitsize=3D"64" type=3D"uint64" regnum=3D"1"/>
> +  <reg name=3D"g2" bitsize=3D"64" type=3D"uint64" regnum=3D"2"/>
> +  <reg name=3D"g3" bitsize=3D"64" type=3D"uint64" regnum=3D"3"/>
> +  <reg name=3D"g4" bitsize=3D"64" type=3D"uint64" regnum=3D"4"/>
> +  <reg name=3D"g5" bitsize=3D"64" type=3D"uint64" regnum=3D"5"/>
> +  <reg name=3D"g6" bitsize=3D"64" type=3D"uint64" regnum=3D"6"/>
> +  <reg name=3D"g7" bitsize=3D"64" type=3D"uint64" regnum=3D"7"/>
> +  <reg name=3D"o0" bitsize=3D"64" type=3D"uint64" regnum=3D"8"/>
> +  <reg name=3D"o1" bitsize=3D"64" type=3D"uint64" regnum=3D"9"/>
> +  <reg name=3D"o2" bitsize=3D"64" type=3D"uint64" regnum=3D"10"/>
> +  <reg name=3D"o3" bitsize=3D"64" type=3D"uint64" regnum=3D"11"/>
> +  <reg name=3D"o4" bitsize=3D"64" type=3D"uint64" regnum=3D"12"/>
> +  <reg name=3D"o5" bitsize=3D"64" type=3D"uint64" regnum=3D"13"/>
> +  <reg name=3D"sp" bitsize=3D"64" type=3D"uint64" regnum=3D"14"/>
> +  <reg name=3D"o7" bitsize=3D"64" type=3D"uint64" regnum=3D"15"/>
> +  <reg name=3D"l0" bitsize=3D"64" type=3D"uint64" regnum=3D"16"/>
> +  <reg name=3D"l1" bitsize=3D"64" type=3D"uint64" regnum=3D"17"/>
> +  <reg name=3D"l2" bitsize=3D"64" type=3D"uint64" regnum=3D"18"/>
> +  <reg name=3D"l3" bitsize=3D"64" type=3D"uint64" regnum=3D"19"/>
> +  <reg name=3D"l4" bitsize=3D"64" type=3D"uint64" regnum=3D"20"/>
> +  <reg name=3D"l5" bitsize=3D"64" type=3D"uint64" regnum=3D"21"/>
> +  <reg name=3D"l6" bitsize=3D"64" type=3D"uint64" regnum=3D"22"/>
> +  <reg name=3D"l7" bitsize=3D"64" type=3D"uint64" regnum=3D"23"/>
> +  <reg name=3D"i0" bitsize=3D"64" type=3D"uint64" regnum=3D"24"/>
> +  <reg name=3D"i1" bitsize=3D"64" type=3D"uint64" regnum=3D"25"/>
> +  <reg name=3D"i2" bitsize=3D"64" type=3D"uint64" regnum=3D"26"/>
> +  <reg name=3D"i3" bitsize=3D"64" type=3D"uint64" regnum=3D"27"/>
> +  <reg name=3D"i4" bitsize=3D"64" type=3D"uint64" regnum=3D"28"/>
> +  <reg name=3D"i5" bitsize=3D"64" type=3D"uint64" regnum=3D"29"/>
> +  <reg name=3D"fp" bitsize=3D"64" type=3D"uint64" regnum=3D"30"/>
> +  <reg name=3D"i7" bitsize=3D"64" type=3D"uint64" regnum=3D"31"/>
> +
> +  <reg name=3D"f0" bitsize=3D"32" type=3D"ieee_single" regnum=3D"32"/>
> +  <reg name=3D"f1" bitsize=3D"32" type=3D"ieee_single" regnum=3D"33"/>
> +  <reg name=3D"f2" bitsize=3D"32" type=3D"ieee_single" regnum=3D"34"/>
> +  <reg name=3D"f3" bitsize=3D"32" type=3D"ieee_single" regnum=3D"35"/>
> +  <reg name=3D"f4" bitsize=3D"32" type=3D"ieee_single" regnum=3D"36"/>
> +  <reg name=3D"f5" bitsize=3D"32" type=3D"ieee_single" regnum=3D"37"/>
> +  <reg name=3D"f6" bitsize=3D"32" type=3D"ieee_single" regnum=3D"38"/>
> +  <reg name=3D"f7" bitsize=3D"32" type=3D"ieee_single" regnum=3D"39"/>
> +  <reg name=3D"f8" bitsize=3D"32" type=3D"ieee_single" regnum=3D"40"/>
> +  <reg name=3D"f9" bitsize=3D"32" type=3D"ieee_single" regnum=3D"41"/>
> +  <reg name=3D"f10" bitsize=3D"32" type=3D"ieee_single" regnum=3D"42"/>
> +  <reg name=3D"f11" bitsize=3D"32" type=3D"ieee_single" regnum=3D"43"/>
> +  <reg name=3D"f12" bitsize=3D"32" type=3D"ieee_single" regnum=3D"44"/>
> +  <reg name=3D"f13" bitsize=3D"32" type=3D"ieee_single" regnum=3D"45"/>
> +  <reg name=3D"f14" bitsize=3D"32" type=3D"ieee_single" regnum=3D"46"/>
> +  <reg name=3D"f15" bitsize=3D"32" type=3D"ieee_single" regnum=3D"47"/>
> +  <reg name=3D"f16" bitsize=3D"32" type=3D"ieee_single" regnum=3D"48"/>
> +  <reg name=3D"f17" bitsize=3D"32" type=3D"ieee_single" regnum=3D"49"/>
> +  <reg name=3D"f18" bitsize=3D"32" type=3D"ieee_single" regnum=3D"50"/>
> +  <reg name=3D"f19" bitsize=3D"32" type=3D"ieee_single" regnum=3D"51"/>
> +  <reg name=3D"f20" bitsize=3D"32" type=3D"ieee_single" regnum=3D"52"/>
> +  <reg name=3D"f21" bitsize=3D"32" type=3D"ieee_single" regnum=3D"53"/>
> +  <reg name=3D"f22" bitsize=3D"32" type=3D"ieee_single" regnum=3D"54"/>
> +  <reg name=3D"f23" bitsize=3D"32" type=3D"ieee_single" regnum=3D"55"/>
> +  <reg name=3D"f24" bitsize=3D"32" type=3D"ieee_single" regnum=3D"56"/>
> +  <reg name=3D"f25" bitsize=3D"32" type=3D"ieee_single" regnum=3D"57"/>
> +  <reg name=3D"f26" bitsize=3D"32" type=3D"ieee_single" regnum=3D"58"/>
> +  <reg name=3D"f27" bitsize=3D"32" type=3D"ieee_single" regnum=3D"59"/>
> +  <reg name=3D"f28" bitsize=3D"32" type=3D"ieee_single" regnum=3D"60"/>
> +  <reg name=3D"f29" bitsize=3D"32" type=3D"ieee_single" regnum=3D"61"/>
> +  <reg name=3D"f30" bitsize=3D"32" type=3D"ieee_single" regnum=3D"62"/>
> +  <reg name=3D"f31" bitsize=3D"32" type=3D"ieee_single" regnum=3D"63"/>
> +
> +  <reg name=3D"f32" bitsize=3D"64" type=3D"ieee_double" regnum=3D"64"/>
> +  <reg name=3D"f34" bitsize=3D"64" type=3D"ieee_double" regnum=3D"65"/>
> +  <reg name=3D"f36" bitsize=3D"64" type=3D"ieee_double" regnum=3D"66"/>
> +  <reg name=3D"f38" bitsize=3D"64" type=3D"ieee_double" regnum=3D"67"/>
> +  <reg name=3D"f40" bitsize=3D"64" type=3D"ieee_double" regnum=3D"68"/>
> +  <reg name=3D"f42" bitsize=3D"64" type=3D"ieee_double" regnum=3D"69"/>
> +  <reg name=3D"f44" bitsize=3D"64" type=3D"ieee_double" regnum=3D"70"/>
> +  <reg name=3D"f46" bitsize=3D"64" type=3D"ieee_double" regnum=3D"71"/>
> +  <reg name=3D"f48" bitsize=3D"64" type=3D"ieee_double" regnum=3D"72"/>
> +  <reg name=3D"f50" bitsize=3D"64" type=3D"ieee_double" regnum=3D"73"/>
> +  <reg name=3D"f52" bitsize=3D"64" type=3D"ieee_double" regnum=3D"74"/>
> +  <reg name=3D"f54" bitsize=3D"64" type=3D"ieee_double" regnum=3D"75"/>
> +  <reg name=3D"f56" bitsize=3D"64" type=3D"ieee_double" regnum=3D"76"/>
> +  <reg name=3D"f58" bitsize=3D"64" type=3D"ieee_double" regnum=3D"77"/>
> +  <reg name=3D"f60" bitsize=3D"64" type=3D"ieee_double" regnum=3D"78"/>
> +  <reg name=3D"f62" bitsize=3D"64" type=3D"ieee_double" regnum=3D"79"/>
> +
> +  <reg name=3D"pc" bitsize=3D"64" type=3D"code_ptr" regnum=3D"80"/>
> +  <reg name=3D"npc" bitsize=3D"64" type=3D"code_ptr" regnum=3D"81"/>
> +  <reg name=3D"state" bitsize=3D"64" type=3D"uint64" regnum=3D"82"/>
> +  <reg name=3D"fsr" bitsize=3D"64" type=3D"uint64" regnum=3D"83"/>
> +  <reg name=3D"fprs" bitsize=3D"64" type=3D"uint64" regnum=3D"84"/>
> +  <reg name=3D"y" bitsize=3D"64" type=3D"uint64" regnum=3D"85"/>
> +</feature>
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index ed7701b02f..245caf2de0 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -1090,6 +1090,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, c=
onst void *data)
>      cc->disas_set_info =3D cpu_sparc_disas_set_info;
>=20=20
>  #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
> +    cc->gdb_core_xml_file =3D "sparc64-core.xml";
>      cc->gdb_num_core_regs =3D 86;
>  #else
>      cc->gdb_num_core_regs =3D 72;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

