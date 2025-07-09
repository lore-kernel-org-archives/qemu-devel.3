Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3787C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 14:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZVyx-0004bY-CT; Wed, 09 Jul 2025 10:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZVyl-0004ZN-8S
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:41:02 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZVyf-0004ZJ-TV
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:40:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60c93c23b08so11121764a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752072052; x=1752676852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTTUGiYrSyf2tH3Vwmlwrjvu0IDTk4cNojp+IkeIiQ0=;
 b=mh/sApUwAg3/f9t5n/srxIzCYU9Xw+C580oJWwL8Oc1olfUMMOSUfF8IguYmHlofTr
 AqUqIIxIHq1Yw3U+nvffpRuYAdZOxJ3B4vKLMWTPOru4Mkqoi58mqLzb2N5ujikdff9W
 vLrPcrPNObyaAAdEF4hJOVSVe5AKAOBZfqXi8b/6XNeDio+Ub7pJBuhW9wC3Pl9B47Gh
 HL8iiP4MRZ1FtWBJmbHJpWKNSCwSQ4ShMMxc1Cx0P7WvUqbu3uDzbvbywHQTzuC2QBzh
 Z9tTvv4So6mGtpwwLmAbZP4RduOi4yc81ek4KFNrDeLL+zNL5xCQI4hpAuEKTM+YgzqH
 SqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752072052; x=1752676852;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tTTUGiYrSyf2tH3Vwmlwrjvu0IDTk4cNojp+IkeIiQ0=;
 b=c4QKBc5Hea19WODSUNw9wypVQPYE0nQMfWsj1ibSJ0QPpU9Pj7Ihv/mWS47RME58Kw
 AYhNiJbI7cNzjplhGxQYXcWcDmaIiZng2JwHtpSIR2rsE3vr1u7pIR6Jm3O5X0YpptXw
 CQL5MHVhikoLNH+MHfgYUt8rES2ThycUgi6vG6EJlGRv47rncplpoxuUqkuIR7xZuiQH
 f4wtEFXYp63dreXB5ZwTNz5OZWkqCIHaXhLaof1pvkRkwMt+EMnoZ2HAOtz4DIzXStZA
 MYnv/mXGJWTNEcA+aqFgRWh26o/ciB+7Sc20vRbnjBFKIwPIjjTkOvSsQ/v2hzDAFJV9
 s3Hg==
X-Gm-Message-State: AOJu0Ywpzi9WnZ+3/JozNwbuYjYf/Yeik+tq2cFndcfPJWpxlh0S0k+K
 wi8ZgLvZ7c8IUj0gxPViDFUhPXz8r0TfXXCX8tBNgnlrYvFNl3zNsXkzfgBiZn6FNU8=
X-Gm-Gg: ASbGnct3iHuecSxYKXcwchVxlLQQf3OYsFNLFiMRYk4xOioYBpjOXEMrhxBf+EnPFzj
 EOx0hQg/bHC8fJe0eXg65w7Wj6gsA1j8G9bfupYBbsg//bv9FNKOj2v3C46IAugVu44BtdSFeeo
 loxxmaLehXT0HEbKoGruRm4lWFUYs71O51RiTe+Eq/AvBYNPTkPo5LiCiIc6qrL/58DEOEpFQdU
 lLx+b7UUoZiMOn6hMjjmAaJ0lDgoalGnq8QBwMmhZgzuWbgqlTf7oTjVHYfbIkEZLb21gwZAcXJ
 S0xJfKmiRUkAJzM6jzJ0qlQlj/GW3IlEj6FfNT+BJrPQA0yNelhP082+t8aJ0fA=
X-Google-Smtp-Source: AGHT+IFUF9eDz7b7Pb9mCqfl+JNsqQvaeDuNeYEv2GuGqSlsHn87SUcaCsQtvs4zKIVuMvwHZnz69A==
X-Received: by 2002:a05:6402:278f:b0:60e:b01:74d0 with SMTP id
 4fb4d7f45d1cf-611a6619a48mr2404123a12.15.1752072052024; 
 Wed, 09 Jul 2025 07:40:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fcb0c856fsm9000588a12.39.2025.07.09.07.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:40:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 574E75F767;
 Wed, 09 Jul 2025 15:40:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rot127 <unisono@quyllur.org>
Cc: qemu-devel@nongnu.org,  laurent@vivier.eu,  philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk,  atar4qemu@gmail.com
Subject: Re: [PATCH] Adds the GDB register XML files for Sparc and Sparc64.
In-Reply-To: <4887cd10-6126-489f-9e68-85b3ecdf0b3d@quyllur.org> (Rot's message
 of "Mon, 7 Jul 2025 11:57:17 -0500")
References: <4887cd10-6126-489f-9e68-85b3ecdf0b3d@quyllur.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 09 Jul 2025 15:40:50 +0100
Message-ID: <87h5zltojx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Rot127 <unisono@quyllur.org> writes:

>  From 6c116b968cb28bcc0d0236913f1926206f50a9b4 Mon Sep 17 00:00:00 2001
> From: Rot127 <unisono@quyllur.org>
> Date: Fri, 27 Jun 2025 04:51:25 -0500
> Subject: [PATCH] Adds the GDB register XML files for Sparc and
> Sparc64.

These seems like a mangled commit. I can't get it to apply cleanly with
either git am or b4, possibly because the patch is an attachment rather
than generated with git-format-patch. Please see:

  https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#use-g=
it-format-patch

for details of formatting patches.

>
> The xml files are copied from binutils-gdb.
> The `-core.xml` files are just assembled from the others
> to match the registers defined by QEMU.
>
> The addition is especially necessary if one wants to use the TCG plugins
> with Sparc, because reading registers via the plugin API
> just queries GDB.
> The GDB stub initializes it's register file with the `*-core.xml` files.
> If they don't exist it returns no data.
> Also relevant for debugging I assume.
>
> Signed-off-by: Rot127 <unisono@quyllur.org>
> ---
>   configs/targets/sparc-linux-user.mak       |  1 +
>   configs/targets/sparc-softmmu.mak          |  1 +
>   configs/targets/sparc32plus-linux-user.mak |  1 +
>   configs/targets/sparc64-linux-user.mak     |  1 +
>   configs/targets/sparc64-softmmu.mak        |  1 +

Please split these changes into discrete patches for each target, ie:

  sparc
  sparc32plus
  sparc64

>   gdb-xml/sparc32-core.xml                   | 84 ++++++++++++++++++
>   gdb-xml/sparc32-cp0.xml                    | 19 +++++
>   gdb-xml/sparc32-cpu.xml                    | 42 +++++++++
>   gdb-xml/sparc32-fpu.xml                    | 43 ++++++++++
>   gdb-xml/sparc64-core.xml                   | 99 ++++++++++++++++++++++
>   gdb-xml/sparc64-cp0.xml                    | 17 ++++
>   gdb-xml/sparc64-cpu.xml                    | 42 +++++++++
>   gdb-xml/sparc64-fpu.xml                    | 60 +++++++++++++
>   target/sparc/cpu.c                         |  2 +
>   14 files changed, 413 insertions(+)
>   create mode 100644 gdb-xml/sparc32-core.xml
>   create mode 100644 gdb-xml/sparc32-cp0.xml
>   create mode 100644 gdb-xml/sparc32-cpu.xml
>   create mode 100644 gdb-xml/sparc32-fpu.xml
>   create mode 100644 gdb-xml/sparc64-core.xml
>   create mode 100644 gdb-xml/sparc64-cp0.xml
>   create mode 100644 gdb-xml/sparc64-cpu.xml
>   create mode 100644 gdb-xml/sparc64-fpu.xml
>
> diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/
> sparc-linux-user.mak
> index 4ff4b7287d..18cc1ce29d 100644
> --- a/configs/targets/sparc-linux-user.mak
> +++ b/configs/targets/sparc-linux-user.mak
> @@ -2,4 +2,5 @@ TARGET_ARCH=3Dsparc
>   TARGET_SYSTBL_ABI=3Dcommon,32
>   TARGET_SYSTBL=3Dsyscall.tbl
>   TARGET_BIG_ENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/sparc32-core.xml gdb-xml/sparc32-cp0.xml gdb-
> xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml
>   TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-
> softmmu.mak
> index 57801faf1f..db782a2a63 100644
> --- a/configs/targets/sparc-softmmu.mak
> +++ b/configs/targets/sparc-softmmu.mak
> @@ -1,3 +1,4 @@
>   TARGET_ARCH=3Dsparc
>   TARGET_BIG_ENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/sparc32-core.xml gdb-xml/sparc32-cp0.xml gdb-
> xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml
>   TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/
> targets/sparc32plus-linux-user.mak
> index 7a16934fd1..029fa69cb0 100644
> --- a/configs/targets/sparc32plus-linux-user.mak
> +++ b/configs/targets/sparc32plus-linux-user.mak
> @@ -5,4 +5,5 @@ TARGET_ABI_DIR=3Dsparc
>   TARGET_SYSTBL_ABI=3Dcommon,32
>   TARGET_SYSTBL=3Dsyscall.tbl
>   TARGET_BIG_ENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/sparc64-core.xml gdb-xml/sparc64-cp0.xml gdb-
> xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml
>   TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/
> sparc64-linux-user.mak
> index 64ea04e3e2..67a11f3c8a 100644
> --- a/configs/targets/sparc64-linux-user.mak
> +++ b/configs/targets/sparc64-linux-user.mak
> @@ -4,4 +4,5 @@ TARGET_ABI_DIR=3Dsparc
>   TARGET_SYSTBL_ABI=3Dcommon,64
>   TARGET_SYSTBL=3Dsyscall.tbl
>   TARGET_BIG_ENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/sparc64-core.xml gdb-xml/sparc64-cp0.xml gdb-
> xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml
>   TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/
> sparc64-softmmu.mak
> index 2504e31ae3..e5f14f937c 100644
> --- a/configs/targets/sparc64-softmmu.mak
> +++ b/configs/targets/sparc64-softmmu.mak
> @@ -1,4 +1,5 @@
>   TARGET_ARCH=3Dsparc64
>   TARGET_BASE_ARCH=3Dsparc
>   TARGET_BIG_ENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/sparc64-core.xml gdb-xml/sparc64-cp0.xml gdb-
> xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml
>   TARGET_LONG_BITS=3D64
> diff --git a/gdb-xml/sparc32-core.xml b/gdb-xml/sparc32-core.xml
> new file mode 100644
> index 0000000000..61964a79d1
> --- /dev/null
> +++ b/gdb-xml/sparc32-core.xml
> @@ -0,0 +1,84 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.core">
> +  <reg name=3D"g0" bitsize=3D"32" type=3D"uint32" regnum=3D"0"/>
> +  <reg name=3D"g1" bitsize=3D"32" type=3D"uint32" regnum=3D"1"/>
> +  <reg name=3D"g2" bitsize=3D"32" type=3D"uint32" regnum=3D"2"/>
> +  <reg name=3D"g3" bitsize=3D"32" type=3D"uint32" regnum=3D"3"/>
> +  <reg name=3D"g4" bitsize=3D"32" type=3D"uint32" regnum=3D"4"/>
> +  <reg name=3D"g5" bitsize=3D"32" type=3D"uint32" regnum=3D"5"/>
> +  <reg name=3D"g6" bitsize=3D"32" type=3D"uint32" regnum=3D"6"/>
> +  <reg name=3D"g7" bitsize=3D"32" type=3D"uint32" regnum=3D"7"/>
> +  <reg name=3D"o0" bitsize=3D"32" type=3D"uint32" regnum=3D"8"/>
> +  <reg name=3D"o1" bitsize=3D"32" type=3D"uint32" regnum=3D"9"/>
> +  <reg name=3D"o2" bitsize=3D"32" type=3D"uint32" regnum=3D"10"/>
> +  <reg name=3D"o3" bitsize=3D"32" type=3D"uint32" regnum=3D"11"/>
> +  <reg name=3D"o4" bitsize=3D"32" type=3D"uint32" regnum=3D"12"/>
> +  <reg name=3D"o5" bitsize=3D"32" type=3D"uint32" regnum=3D"13"/>
> +  <reg name=3D"sp" bitsize=3D"32" type=3D"uint32" regnum=3D"14"/>
> +  <reg name=3D"o7" bitsize=3D"32" type=3D"uint32" regnum=3D"15"/>
> +  <reg name=3D"l0" bitsize=3D"32" type=3D"uint32" regnum=3D"16"/>
> +  <reg name=3D"l1" bitsize=3D"32" type=3D"uint32" regnum=3D"17"/>
> +  <reg name=3D"l2" bitsize=3D"32" type=3D"uint32" regnum=3D"18"/>
> +  <reg name=3D"l3" bitsize=3D"32" type=3D"uint32" regnum=3D"19"/>
> +  <reg name=3D"l4" bitsize=3D"32" type=3D"uint32" regnum=3D"20"/>
> +  <reg name=3D"l5" bitsize=3D"32" type=3D"uint32" regnum=3D"21"/>
> +  <reg name=3D"l6" bitsize=3D"32" type=3D"uint32" regnum=3D"22"/>
> +  <reg name=3D"l7" bitsize=3D"32" type=3D"uint32" regnum=3D"23"/>
> +  <reg name=3D"i0" bitsize=3D"32" type=3D"uint32" regnum=3D"24"/>
> +  <reg name=3D"i1" bitsize=3D"32" type=3D"uint32" regnum=3D"25"/>
> +  <reg name=3D"i2" bitsize=3D"32" type=3D"uint32" regnum=3D"26"/>
> +  <reg name=3D"i3" bitsize=3D"32" type=3D"uint32" regnum=3D"27"/>
> +  <reg name=3D"i4" bitsize=3D"32" type=3D"uint32" regnum=3D"28"/>
> +  <reg name=3D"i5" bitsize=3D"32" type=3D"uint32" regnum=3D"29"/>
> +  <reg name=3D"fp" bitsize=3D"32" type=3D"uint32" regnum=3D"30"/>
> +  <reg name=3D"i7" bitsize=3D"32" type=3D"uint32" regnum=3D"31"/>
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
> +  <reg name=3D"y" bitsize=3D"32" type=3D"uint32" regnum=3D"64"/>
> +  <reg name=3D"psr" bitsize=3D"32" type=3D"uint32" regnum=3D"65"/>
> +  <reg name=3D"wim" bitsize=3D"32" type=3D"uint32" regnum=3D"66"/>
> +  <reg name=3D"tbr" bitsize=3D"32" type=3D"uint32" regnum=3D"67"/>
> +  <reg name=3D"pc" bitsize=3D"32" type=3D"code_ptr" regnum=3D"68"/>
> +  <reg name=3D"npc" bitsize=3D"32" type=3D"code_ptr" regnum=3D"69"/>
> +  <reg name=3D"fsr" bitsize=3D"32" type=3D"uint32" regnum=3D"70"/>
> +  <reg name=3D"csr" bitsize=3D"32" type=3D"uint32" regnum=3D"71"/>
> +</feature>
> diff --git a/gdb-xml/sparc32-cp0.xml b/gdb-xml/sparc32-cp0.xml
> new file mode 100644
> index 0000000000..a7f6e64de1
> --- /dev/null
> +++ b/gdb-xml/sparc32-cp0.xml
> @@ -0,0 +1,19 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.cp0">
> +  <reg name=3D"y" bitsize=3D"32" type=3D"uint32" regnum=3D"64"/>
> +  <reg name=3D"psr" bitsize=3D"32" type=3D"uint32" regnum=3D"65"/>
> +  <reg name=3D"wim" bitsize=3D"32" type=3D"uint32" regnum=3D"66"/>
> +  <reg name=3D"tbr" bitsize=3D"32" type=3D"uint32" regnum=3D"67"/>
> +  <reg name=3D"pc" bitsize=3D"32" type=3D"code_ptr" regnum=3D"68"/>
> +  <reg name=3D"npc" bitsize=3D"32" type=3D"code_ptr" regnum=3D"69"/>
> +  <reg name=3D"fsr" bitsize=3D"32" type=3D"uint32" regnum=3D"70"/>
> +  <reg name=3D"csr" bitsize=3D"32" type=3D"uint32" regnum=3D"71"/>
> +</feature>
> +
> diff --git a/gdb-xml/sparc32-cpu.xml b/gdb-xml/sparc32-cpu.xml
> new file mode 100644
> index 0000000000..b28c533a4f
> --- /dev/null
> +++ b/gdb-xml/sparc32-cpu.xml
> @@ -0,0 +1,42 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.cpu">
> +  <reg name=3D"g0" bitsize=3D"32" type=3D"uint32" regnum=3D"0"/>
> +  <reg name=3D"g1" bitsize=3D"32" type=3D"uint32" regnum=3D"1"/>
> +  <reg name=3D"g2" bitsize=3D"32" type=3D"uint32" regnum=3D"2"/>
> +  <reg name=3D"g3" bitsize=3D"32" type=3D"uint32" regnum=3D"3"/>
> +  <reg name=3D"g4" bitsize=3D"32" type=3D"uint32" regnum=3D"4"/>
> +  <reg name=3D"g5" bitsize=3D"32" type=3D"uint32" regnum=3D"5"/>
> +  <reg name=3D"g6" bitsize=3D"32" type=3D"uint32" regnum=3D"6"/>
> +  <reg name=3D"g7" bitsize=3D"32" type=3D"uint32" regnum=3D"7"/>
> +  <reg name=3D"o0" bitsize=3D"32" type=3D"uint32" regnum=3D"8"/>
> +  <reg name=3D"o1" bitsize=3D"32" type=3D"uint32" regnum=3D"9"/>
> +  <reg name=3D"o2" bitsize=3D"32" type=3D"uint32" regnum=3D"10"/>
> +  <reg name=3D"o3" bitsize=3D"32" type=3D"uint32" regnum=3D"11"/>
> +  <reg name=3D"o4" bitsize=3D"32" type=3D"uint32" regnum=3D"12"/>
> +  <reg name=3D"o5" bitsize=3D"32" type=3D"uint32" regnum=3D"13"/>
> +  <reg name=3D"sp" bitsize=3D"32" type=3D"uint32" regnum=3D"14"/>
> +  <reg name=3D"o7" bitsize=3D"32" type=3D"uint32" regnum=3D"15"/>
> +  <reg name=3D"l0" bitsize=3D"32" type=3D"uint32" regnum=3D"16"/>
> +  <reg name=3D"l1" bitsize=3D"32" type=3D"uint32" regnum=3D"17"/>
> +  <reg name=3D"l2" bitsize=3D"32" type=3D"uint32" regnum=3D"18"/>
> +  <reg name=3D"l3" bitsize=3D"32" type=3D"uint32" regnum=3D"19"/>
> +  <reg name=3D"l4" bitsize=3D"32" type=3D"uint32" regnum=3D"20"/>
> +  <reg name=3D"l5" bitsize=3D"32" type=3D"uint32" regnum=3D"21"/>
> +  <reg name=3D"l6" bitsize=3D"32" type=3D"uint32" regnum=3D"22"/>
> +  <reg name=3D"l7" bitsize=3D"32" type=3D"uint32" regnum=3D"23"/>
> +  <reg name=3D"i0" bitsize=3D"32" type=3D"uint32" regnum=3D"24"/>
> +  <reg name=3D"i1" bitsize=3D"32" type=3D"uint32" regnum=3D"25"/>
> +  <reg name=3D"i2" bitsize=3D"32" type=3D"uint32" regnum=3D"26"/>
> +  <reg name=3D"i3" bitsize=3D"32" type=3D"uint32" regnum=3D"27"/>
> +  <reg name=3D"i4" bitsize=3D"32" type=3D"uint32" regnum=3D"28"/>
> +  <reg name=3D"i5" bitsize=3D"32" type=3D"uint32" regnum=3D"29"/>
> +  <reg name=3D"fp" bitsize=3D"32" type=3D"uint32" regnum=3D"30"/>
> +  <reg name=3D"i7" bitsize=3D"32" type=3D"uint32" regnum=3D"31"/>
> +</feature>
> diff --git a/gdb-xml/sparc32-fpu.xml b/gdb-xml/sparc32-fpu.xml
> new file mode 100644
> index 0000000000..289c1d2b99
> --- /dev/null
> +++ b/gdb-xml/sparc32-fpu.xml
> @@ -0,0 +1,43 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.fpu">
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
> +</feature>
> +
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
> diff --git a/gdb-xml/sparc64-cp0.xml b/gdb-xml/sparc64-cp0.xml
> new file mode 100644
> index 0000000000..cef58f312b
> --- /dev/null
> +++ b/gdb-xml/sparc64-cp0.xml
> @@ -0,0 +1,17 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.cp0">
> +  <reg name=3D"pc" bitsize=3D"64" type=3D"code_ptr" regnum=3D"80"/>
> +  <reg name=3D"npc" bitsize=3D"64" type=3D"code_ptr" regnum=3D"81"/>
> +  <reg name=3D"state" bitsize=3D"64" type=3D"uint64" regnum=3D"82"/>
> +  <reg name=3D"fsr" bitsize=3D"64" type=3D"uint64" regnum=3D"83"/>
> +  <reg name=3D"fprs" bitsize=3D"64" type=3D"uint64" regnum=3D"84"/>
> +  <reg name=3D"y" bitsize=3D"64" type=3D"uint64" regnum=3D"85"/>
> +</feature>
> +
> diff --git a/gdb-xml/sparc64-cpu.xml b/gdb-xml/sparc64-cpu.xml
> new file mode 100644
> index 0000000000..b8a66d911a
> --- /dev/null
> +++ b/gdb-xml/sparc64-cpu.xml
> @@ -0,0 +1,42 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.cpu">
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
> +</feature>
> diff --git a/gdb-xml/sparc64-fpu.xml b/gdb-xml/sparc64-fpu.xml
> new file mode 100644
> index 0000000000..cef935ebd6
> --- /dev/null
> +++ b/gdb-xml/sparc64-fpu.xml
> @@ -0,0 +1,60 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.sparc.fpu">
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
> +</feature>
> +
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index ed7701b02f..6d52be9263 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -1090,8 +1090,10 @@ static void sparc_cpu_class_init(ObjectClass *oc,
> const void *data)
>       cc->disas_set_info =3D cpu_sparc_disas_set_info;
>
>   #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
> +    cc->gdb_core_xml_file =3D "sparc64-core.xml";
>       cc->gdb_num_core_regs =3D 86;
>   #else
> +    cc->gdb_core_xml_file =3D "sparc32-core.xml";
>       cc->gdb_num_core_regs =3D 72;
>   #endif
>       cc->tcg_ops =3D &sparc_tcg_ops;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

