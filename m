Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BFFD6EBF1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGxmI-0004pd-4H; Fri, 29 Nov 2024 04:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tGxmF-0004p2-9c
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 04:59:07 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tGxmB-0003xU-Kz
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 04:59:06 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43494a20379so15365925e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 01:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732874342; x=1733479142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hI/xxTgjum7R5i6Ad97JEX8w3FQEhDpVP9eXMuQUKU=;
 b=hPDbYVFW0Xl8/xs0riBGXdG47pLzdyX68CHMcrM7KCI7g29xyjjBuLzEHAVYBPyK+a
 lGOual2xyCmjzlHFCxgustu+WwsWjjp9EDPu88RN5ad8GrixvXHYFL4fsUQjj1s74PuO
 Zwn/1zyD5pQF9E/QFFogEuad/ml5Daez3SDyJ6Qz0seQuzQVMvoi/aQ9F6rNXBqJ/oM+
 0Zmt/z1v9N+Vg1/OmYKlbDtMl2opwUUsa+b9EGmNRar+OH56FhuDYsdNV1Pe5bUHcZuu
 U0EwQGUYAWur2XlE5EQET5r/6E+k/RrIYgyfaB1E6NZkMKcjyZu5xSZPYX+F8kx9DLTZ
 LJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732874342; x=1733479142;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hI/xxTgjum7R5i6Ad97JEX8w3FQEhDpVP9eXMuQUKU=;
 b=mR9kOU/ZqRMcOc4MqXJa9RRJgtMPlDucI6orhdw//5fRUx7zjnJxPiYpQsuqezYEpE
 IIML6Vn6E8RcAqHsWxn6h2526VlIFX/YlS5x4tG1KpDU79ZrQbvC7u47kVjJWXBBAkuW
 rITb7bnvmaGNq8lCpYSXb3DPWYRaQfM4+OBPu+uINVVX1c/AL3WW61dFWIWwqVnuJvYb
 vmFRyOaZLcxBvnquODHSrWXBgMfNugWRXvgb7JGt4dsSxx915JkMKDSOrYsHTAN2kK1X
 +ld3ulZOBtprqsjUMWZJ3Echilbqcb5zpAG62tNvJhZaT9stsV1ZQF5zJgS+LTYSVbbN
 Ij5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWHlxoIf1AolF4krw6XwRDF1qM+crcNWEhqleLGD4MfxRqT+NUYrXQMY1Bi6+2qWeBp4uSD2/ZgmP1@nongnu.org
X-Gm-Message-State: AOJu0YwJKYNuEwOsknSC3cfN2yp5G2ZHtmyqv5Tva27au69dkM0dfzKi
 n/0dNyGVS2x11L3yKKGEu5/uXQCDykeQKtEGKbrCi6YM5Dw3S5lW9fPZDPCYv3ojYMsiS0trpuu
 07QU=
X-Gm-Gg: ASbGncujQwjZmLwEbpFg2txkOg6OxZ8TfBamyG5KJsl0HkS0qKcIZNh4+xu+v3weneH
 LoOIqOlZ3mnLgF6mQCyDv85QtMPVSfV4ZZVq+hH6mGmBFuVpUeuFyt0pNfPRE8beckBPXy52kkf
 x5OG+rD69vlCxbF/3UFKCanaHoVmDdn8Yi64cwtNa2itcgoa8IuuN8tCWLRjbUUuBBG63YKJwyP
 qKwNl9ryWbx07ElpAPdkvzMEFb7nSNhRCbgPAbqEIDHbmZm
X-Google-Smtp-Source: AGHT+IE+QjE//GjxQG5ehLPNQ7Y/5dFBdFL7WdGne2/KQihWP4rnsuxbBbj2ZHn2imVQF/3GpjCCrw==
X-Received: by 2002:a05:600c:524d:b0:434:9be8:6cb5 with SMTP id
 5b1f17b1804b1-434a9dd0052mr113841215e9.17.1732874341658; 
 Fri, 29 Nov 2024 01:59:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385df63255bsm988347f8f.86.2024.11.29.01.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 01:59:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3778D5F858;
 Fri, 29 Nov 2024 09:59:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yanfeng <yfliu2008@qq.com>
Cc: qemu-riscv@nongnu.org,  qemu-devel@nongnu.org,  alistair.francis@wdc.com
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
In-Reply-To: <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com> (Yanfeng's
 message of "Fri, 29 Nov 2024 10:11:22 +0800")
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 29 Nov 2024 09:59:00 +0000
Message-ID: <87r06ufjiz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Yanfeng <yfliu2008@qq.com> writes:

> On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
>> Yanfeng Liu <yfliu2008@qq.com> writes:
>>=20
>> > This adds `virt` virtual register on debug interface so that users
>> > can access current virtualization mode for debugging purposes.
>> >=20
>> > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>> > ---
>> > =C2=A0gdb-xml/riscv-32bit-virtual.xml |=C2=A0 1 +
>> > =C2=A0gdb-xml/riscv-64bit-virtual.xml |=C2=A0 1 +
>> > =C2=A0target/riscv/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 18 ++++++++++++------
>> > =C2=A03 files changed, 14 insertions(+), 6 deletions(-)
>> >=20
>> > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-
>> > virtual.xml
>> > index 905f1c555d..d44b6ca2dc 100644
>> > --- a/gdb-xml/riscv-32bit-virtual.xml
>> > +++ b/gdb-xml/riscv-32bit-virtual.xml
>> > @@ -8,4 +8,5 @@
>> > =C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> > =C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
>> > =C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"32"/>
>> > +=C2=A0 <reg name=3D"virt" bitsize=3D"32"/>
>> > =C2=A0</feature>
>> > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-
>> > virtual.xml
>> > index 62d86c237b..7c9b63d5b6 100644
>> > --- a/gdb-xml/riscv-64bit-virtual.xml
>> > +++ b/gdb-xml/riscv-64bit-virtual.xml
>> > @@ -8,4 +8,5 @@
>> > =C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> > =C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
>> > =C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"64"/>
>> > +=C2=A0 <reg name=3D"virt" bitsize=3D"64"/>
>> > =C2=A0</feature>
>>=20
>> I assume these are mirrored in gdb not a QEMU only extension?
>
> So far I think it is a QEMU extension and the `gdb-multiarch` doesn't tre=
at is
> specially. My tests shows it basically works:
>
> ```
> (gdb) ir virt
> priv           0x3	prv:3 [Machine]
> virt           0x0	0
> (gdb) set $priv =3D 2
> (gdb) ir virt
> priv           0x1	prv:1 [Supervisor]
> virt           0x0	0
> (gdb) set $virt =3D 1
> (gdb) ir virt
> priv           0x1	prv:1 [Supervisor]
> virt           0x1	1
> (gdb) set $virt =3D 0
> (gdb) ir virt
> priv           0x1	prv:1 [Supervisor]
> virt           0x0	0
> (gdb) set $virt =3D 1
> (gdb) ir virt
> priv           0x1	prv:1 [Supervisor]
> virt           0x1	1
> (gdb) set $priv =3D 3
> (gdb) ir virt
> priv           0x3	prv:3 [Machine]
> virt           0x0	0
> ```

A gdbstub test case would be useful for this although I don't know if
the RiscV check-tcg tests switch mode at all.

>
> As I am rather new to QEMU, please teach how we can add it as a QEMU only
> extension.

You don't need to extend the XML from GDB, you can build a specific one
for QEMU extensions. For example:

    gdb_feature_builder_init(&param.builder,
                             &cpu->dyn_sysreg_feature.desc,
                             "org.qemu.gdb.arm.sys.regs",
                             "system-registers.xml",
                             base_reg);

This exports all the system registers QEMU knows about and GDB can
access generically. Note the id is org.qemu..., indicating its our
schema not gdbs.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

