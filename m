Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2379DE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ6ws-000604-RC; Thu, 05 Dec 2024 03:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJ6wk-0005za-B1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:10:50 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJ6wi-00006v-4W
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:10:49 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so6751785e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 00:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733386245; x=1733991045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPdc0EEVHeTFn15eI1D7uHRXwLa3eD+mEiTL1Dvotuo=;
 b=u/vQdknnLrF65/vzRm1ILXx4WjG7qhgt6/WdDHiHMpPyWwLPjezsUfIOgRJvb2YieW
 AA0XxbElovYwJRmLl5fUDSgLcr/5SVn87iRprq9O0Kos6mCoyLsgUia4dQA5Y6Kf2p6l
 s4/YKKIt5pvdneb7HIMbDuOBlAyWbaxMfsDnSLGfySafOKcM/FW7Qj2rF82ty3BXJhSq
 PPFbPprrg0H9D/LDd9guRSkAgaCsLF9FrCZwmsmLZvQHtuXECBD6orC+uBP/vkXWtUlz
 euBGgaQFO3qSDtDS5pokLV58r6euhu2dDU70gLhz8Pfq0K93bBrGKCn9hoUN+diVnqc7
 CyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733386245; x=1733991045;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PPdc0EEVHeTFn15eI1D7uHRXwLa3eD+mEiTL1Dvotuo=;
 b=HDFX5HN43uBnbr6fT0pkh26ph8x5dnLqdXMidSYzbF5TKD+CPauzmnaBSvOLPJ0dcU
 wdbYsFyeete2osDYlzn4oymcSGLDbEhHvYA2yLigETWNhpmo8AB5mylF4LSQNWEFH8oR
 GXsxLh9Hrb6YhG0S/twvRtizZeXeFqNtSjYN8NCC3FYIt8QR9/Nfb2F57puyAS3455ls
 xO/AY3tRcwF1gODJScy3Al/IcmWEWP0FSsdw0S1cWuQagacQS50NPzDrzpuqCkkaFh5P
 0CPjGjzWUqX7HzkP/E5j8FCwwSxerwS1kcOvJ8WgpSeMOwrV0IVJxCcnjNAWBiyE4+fV
 Llew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuMJNIchoOgVKWeJ+zSjVjeVpnIUKgvJL88lQsLfIzv7uVTJydVyfrVRE2vcLfQqqP4D43AYlO+aiw@nongnu.org
X-Gm-Message-State: AOJu0Yxk8eqTAUx/9rbnK6XpcfuQicyEqFKmKzsVlQMGKlSqrBK2Yq4O
 0SguyHvm6vynGSMB4YYlIBvMkceUBcduiP12iLbXOvsc4hRZbpU1Cvt2YqMJhmQ=
X-Gm-Gg: ASbGnctVPihQqj2gk7z69W+VMDTRNFeyyVnu+bszuK6ssd36a1XuBPUx3z1P9IRhnan
 FvnoF/YUJ9Jel8i2jOgNGhw34z0meD7hnXYObLCbIj6ZoaHui13mbvy+NzX5VVsYEGPKJAf8FT2
 FuiRY7AmDavmoAY9tyi5dk/96ZG0qoZAfu92mOFQMHD/rNtuarcORjjcSIy3kXJ4WpMi+wgEz5Q
 8IvYfO1ZKEJOmiKr7Nec/21PdZ5e5g9+9MiBduXsvPS7wJG
X-Google-Smtp-Source: AGHT+IGM60n+GSy+Mfvc9xMaw7CC4RIdZS/E2SvPbYPS2ch2qcG7zFkbAc/MOOJKeWHEJYRa9M+igg==
X-Received: by 2002:a05:6000:2809:b0:385:f07b:93d6 with SMTP id
 ffacd0b85a97d-385fd423ac5mr5335662f8f.45.1733386245313; 
 Thu, 05 Dec 2024 00:10:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b577sm52931845e9.3.2024.12.05.00.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 00:10:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B708C5F8A7;
 Thu,  5 Dec 2024 08:10:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yanfeng Liu <yfliu2008@qq.com>
Cc: Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 qemu-riscv@nongnu.org,  qemu-devel@nongnu.org,  alistair.francis@wdc.com
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
In-Reply-To: <tencent_06871EF8A4ECD65A90D4E769FC60C972DC09@qq.com> (Yanfeng
 Liu's message of "Thu, 05 Dec 2024 09:29:22 +0800")
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
 <87r06ufjiz.fsf@draig.linaro.org>
 <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
 <0516feb0-ba9a-4ac0-a2bd-1bf97ca9694e@lauterbach.com>
 <tencent_06871EF8A4ECD65A90D4E769FC60C972DC09@qq.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 05 Dec 2024 08:10:42 +0000
Message-ID: <874j3ibldp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Yanfeng Liu <yfliu2008@qq.com> writes:

> On Wed, 2024-12-04 at 17:03 +0100, Mario Fleischmann wrote:
>> Hi everyone,
>>=20
>> I'd like to chime in here because we are sitting on a similar patch=20
>> which I wanted to send to the mailing list as soon as riscv-debug-spec=20
>> v1.0.0 becomes ratified.
>>=20
>> For hypervisor support, `(qemu) info registers` isn't enough. We need to=
=20
>> have both read and write access to the V-bit.
>>=20
>> On 04.12.2024 14:43, Yanfeng Liu wrote:
>> > On Fri, 2024-11-29 at 09:59 +0000, Alex Benn=C3=A9e wrote:
>> > > Yanfeng <yfliu2008@qq.com> writes:
>> > >=20
>> > > > On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
>> > > > > Yanfeng Liu <yfliu2008@qq.com> writes:
>> > > > >=20
>> > > > > > This adds `virt` virtual register on debug interface so that u=
sers
>> > > > > > can access current virtualization mode for debugging purposes.
>> > > > > >=20
>> > > > > > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>> > > > > > ---
>> > > > > > =C2=A0=C2=A0gdb-xml/riscv-32bit-virtual.xml |=C2=A0 1 +
>> > > > > > =C2=A0=C2=A0gdb-xml/riscv-64bit-virtual.xml |=C2=A0 1 +
>> > > > > > =C2=A0=C2=A0target/riscv/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++++++------
>> > > > > > =C2=A0=C2=A03 files changed, 14 insertions(+), 6 deletions(-)
>> > > > > >=20
>> > > > > > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-3=
2bit-
>> > > > > > virtual.xml
>> > > > > > index 905f1c555d..d44b6ca2dc 100644
>> > > > > > --- a/gdb-xml/riscv-32bit-virtual.xml
>> > > > > > +++ b/gdb-xml/riscv-32bit-virtual.xml
>> > > > > > @@ -8,4 +8,5 @@
>> > > > > > =C2=A0=C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> > > > > > =C2=A0=C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
>> > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"32"/>
>> > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"32"/>
>> > > > > > =C2=A0=C2=A0</feature>
>> > > > > > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-6=
4bit-
>> > > > > > virtual.xml
>> > > > > > index 62d86c237b..7c9b63d5b6 100644
>> > > > > > --- a/gdb-xml/riscv-64bit-virtual.xml
>> > > > > > +++ b/gdb-xml/riscv-64bit-virtual.xml
>> > > > > > @@ -8,4 +8,5 @@
>> > > > > > =C2=A0=C2=A0<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> > > > > > =C2=A0=C2=A0<feature name=3D"org.gnu.gdb.riscv.virtual">
>> > > > > > =C2=A0=C2=A0=C2=A0 <reg name=3D"priv" bitsize=3D"64"/>
>> > > > > > +=C2=A0 <reg name=3D"virt" bitsize=3D"64"/>
>> > > > > > =C2=A0=C2=A0</feature>
>> > > > >=20
>> > > > > I assume these are mirrored in gdb not a QEMU only extension?
>> > > >=20
>> > > > So far I think it is a QEMU extension and the `gdb-multiarch` does=
n't
>> > > > treat
>> > > > is
>> > > > specially. My tests shows it basically works:
>> > > >=20
>> > > > ```
>> > > > (gdb) ir virt
>> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
>> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
>> > > > (gdb) set $priv =3D 2
>> > > > (gdb) ir virt
>> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
>> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
>> > > > (gdb) set $virt =3D 1
>> > > > (gdb) ir virt
>> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
>> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
>> > > > (gdb) set $virt =3D 0
>> > > > (gdb) ir virt
>> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
>> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
>> > > > (gdb) set $virt =3D 1
>> > > > (gdb) ir virt
>> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:1 [Supervisor]
>> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
>> > > > (gdb) set $priv =3D 3
>> > > > (gdb) ir virt
>> > > > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prv:3 [Machine]
>> > > > virt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
>> > > > ```
>> > >=20
>> > > A gdbstub test case would be useful for this although I don't know if
>> > > the RiscV check-tcg tests switch mode at all.
>> > >=20
>> > > >=20
>> > > > As I am rather new to QEMU, please teach how we can add it as a QE=
MU
>> > > > only
>> > > > extension.
>> > >=20
>> > > You don't need to extend the XML from GDB, you can build a specific =
one
>> > > for QEMU extensions. For example:
>> > >=20
>> > > =C2=A0=C2=A0=C2=A0=C2=A0 gdb_feature_builder_init(&param.builder,
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cpu->dyn_sysreg_feature.desc,
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "org.qemu.gdb.arm.sys.regs",
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "system-registers.xml",
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_reg);
>> > >=20
>> > > This exports all the system registers QEMU knows about and GDB can
>> > > access generically. Note the id is org.qemu..., indicating its our
>> > > schema not gdbs.
>> > Thanks for teaching, I need time to digest. I guess more feature build=
er
>> > APIs
>> > are needed (like append_reg) and the getter/setter callbacks might be =
at a
>> > different place.
>> >=20
>> > BTW, compared to adding virtual register `virt`, how do you think if we
>> > share
>> > the V bit as part of existing `priv` register?
>>=20
>> IMHO this is a very good idea since the latest release candidate of=20
>> riscv-debug-spec also includes the V bit in priv:2.
>>=20
>
> Thanks for this information, I noticed the bit(2) of `priv` register is f=
or the
> V bit as per section 4.10.1.
>
>> > Or maybe we shall talk to GDB community to get their opinions? If they=
 agree
>> > to
>> > add a few words about V bit here
>> > https://sourceware.org/gdb/current/onlinedocs/gdb.html/RISC_002dV-Feat=
ures.html
>> > ,
>> > then it saves us a lot.
>>=20
>> Except being currently not supported by GDB
>>=20
>> (gdb) info register $priv
>> priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x5=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:5 [INVALID]
>>=20
>> are there any reasons from QEMU's side that would speak against=20
>> including V in priv?
>>=20
>
> My v1 patch used `bit(8)` to avoid seeing the `[INVALID]` thing at GDB si=
de,
> though that is due to GDB isn't in line with its own manual (i.e. use the=
 two
> lowest bits only).
>
> Without a doc or specification. we felt people may not know `bit(8)` in v=
1 patch
> was for the V bit, so I drafted patch v2 as Alistair suggested. However, =
as Alex
> pointed out, directly adding `virt` register in "org.gnu.gdb.riscv.virtua=
l" XML
> is improper. I also wanted to raise this in GDB side but my application t=
o join
> the mail list is still pending.
>
> Alex and Alistair, now I am wondering if we can follow the RiscV debug
> specification to use `bit(2)` of `priv` virtual register?=C2=A0My test sh=
ows except
> for the `[INVALID]` label, both set/get access seems working.

I guess the INVALID just means gdb needs teaching about the format of
the register.

>
>
> Regards,
> yf

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

