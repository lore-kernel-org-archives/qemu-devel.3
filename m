Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0258E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 05:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN3k8-0005m9-1m; Mon, 16 Dec 2024 00:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3k2-0005kS-4G; Mon, 16 Dec 2024 00:34:02 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3jz-00008Z-V8; Mon, 16 Dec 2024 00:34:01 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4b11a11a4f0so981155137.3; 
 Sun, 15 Dec 2024 21:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734327238; x=1734932038; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQ8NRM4pwYIeNPbqMkOkg3JqEBNtwJI7DX9dM13ksuo=;
 b=dEaTGN5gEfYhEZPJ9OK5QMJvtp0B79jG80thEZC6l9/YwNNpIWPfjPaib7UnVzjADS
 qE2ydMJNz2yL6RvQc6O0DIIhezla4TLozVMptzY4/T8dznU/LCMdkGu+sVQ/D6IPf6WF
 jWpBPt4fw0NHUOYFac8qbZTJlD71juyWH86DdydOI9bR9gzqEii9CYUqpDQGvZjVOQ5y
 uwqSbvfMW/fWcYF5S9/YOyzLKeo3d7VDZlDhdSs+xrQNeLlpcKqZ8//wfS6IzQO+1YvY
 lkd9nieRPUxslwljph72b0B1K+saUnHJpAb//6wUFMNa171aOZVHtjlBJoIg6pNLK3pa
 PfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734327238; x=1734932038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQ8NRM4pwYIeNPbqMkOkg3JqEBNtwJI7DX9dM13ksuo=;
 b=IuErykouLiBM+vWV2WlXlrXSk3jMIwBfMn8Oekg8fOa4+/ZFE2Km9z81zYyszUd6HU
 gWIQANProbnCZZZDKF9vC1c7fe1m9lnNUTQefuiDrhg0Oc7KXf2a1SfredZgGNiWBgHZ
 cyptg3AbIIXobgZDv5stdxAnPJzYOuhLKvdPNEq7dus5Embf4KKb0oFMY8Fpp3w6rWjv
 Qva5Oroolu8i4ZiYB1jaK7UdUEoZOKleu5TNWe4rp8qzMd0SpvTKcpTlmj4g4aETmprS
 kMKDq2Sk3+NtVP8Lj8axndElNwcNk+/CtsTgAAz4Qsmo/A2QQIpaw3IlTqBXgQX+rI+1
 KIJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMQTmLiR+wKIflW34I0tsgsWA4DS/361YjOziFokuiUB4xrUV1dAk+UdnW6vjYX+UZVY7WJrDi4kl7DA==@nongnu.org,
 AJvYcCUYt0wfh4z6nYCR0DUqvQeqtnLqHoP9zFrm4hTC7X250Ud/l1Pq4H4RRrgWtvZ8su6l8XvpQDpFK+n/@nongnu.org
X-Gm-Message-State: AOJu0YypBv0sCT/3j0oPE3n2XjV/Yl7WDJxS3lYGcqHRuxiu+/HoiDQP
 Ix5XavhCklNGK8HjxWQxSJJqoo0+elKwZK1YjAXfATgLrXMRAf8G24xCMNhnuFdVcKdXFcNRTs/
 vuzRrAd7tV/xxUbV5bYe0gowZaas=
X-Gm-Gg: ASbGncuGPJX5CpNMxUzqqMjXjJd/GIoe4c60Hy+kgKSM/HUdvdG/PD2GCqAqiPtihU3
 aol6BXGz8Y63dzXdIwrJ3yVH05JwcpCTTe9ub6BOpPprTqpk4iVMT0vyeMW3Yt4N+JluN
X-Google-Smtp-Source: AGHT+IF1dz/rOtHO89Hmjj8v0O06fM4l9yBI/NDErbqLSVpEBvs7aXnRR3JkHaeKEk3846bLx9Rma1IfVBXp2ecNlag=
X-Received: by 2002:a05:6102:b04:b0:4af:eccf:e3ca with SMTP id
 ada2fe7eead31-4b25d9a5d19mr8923960137.10.1734327238150; Sun, 15 Dec 2024
 21:33:58 -0800 (PST)
MIME-Version: 1.0
References: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
 <8734jbh21e.fsf@draig.linaro.org>
 <tencent_CA6E4D0C897F3ED0EF988CCE5DF541442A05@qq.com>
 <87r06ufjiz.fsf@draig.linaro.org>
 <tencent_AADD9A1292CD7CB89F16999E7BDD03895406@qq.com>
 <0516feb0-ba9a-4ac0-a2bd-1bf97ca9694e@lauterbach.com>
 <tencent_06871EF8A4ECD65A90D4E769FC60C972DC09@qq.com>
 <874j3ibldp.fsf@draig.linaro.org>
 <tencent_F33CF7D60707A9F1B567A493F92CBF77B207@qq.com>
In-Reply-To: <tencent_F33CF7D60707A9F1B567A493F92CBF77B207@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Dec 2024 15:33:32 +1000
Message-ID: <CAKmqyKNzYM=BvXETpkuPJDd66C7NNUFTFZqacPJJeXwbMyKdFg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv/gdb: add virt mode debug interface
To: Yanfeng Liu <yfliu2008@qq.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mario Fleischmann <mario.fleischmann@lauterbach.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Dec 5, 2024 at 7:17=E2=80=AFPM Yanfeng Liu <yfliu2008@qq.com> wrote=
:
>
> On Thu, 2024-12-05 at 08:10 +0000, Alex Benn=C3=A9e wrote:
> > Yanfeng Liu <yfliu2008@qq.com> writes:
> >
> > > On Wed, 2024-12-04 at 17:03 +0100, Mario Fleischmann wrote:
> > > > Hi everyone,
> > > >
> > > > I'd like to chime in here because we are sitting on a similar patch
> > > > which I wanted to send to the mailing list as soon as riscv-debug-s=
pec
> > > > v1.0.0 becomes ratified.
> > > >
> > > > For hypervisor support, `(qemu) info registers` isn't enough. We ne=
ed to
> > > > have both read and write access to the V-bit.
> > > >
> > > > On 04.12.2024 14:43, Yanfeng Liu wrote:
> > > > > On Fri, 2024-11-29 at 09:59 +0000, Alex Benn=C3=A9e wrote:
> > > > > > Yanfeng <yfliu2008@qq.com> writes:
> > > > > >
> > > > > > > On Thu, 2024-11-28 at 14:21 +0000, Alex Benn=C3=A9e wrote:
> > > > > > > > Yanfeng Liu <yfliu2008@qq.com> writes:
> > > > > > > >
> > > > > > > > > This adds `virt` virtual register on debug interface so t=
hat
> > > > > > > > > users
> > > > > > > > > can access current virtualization mode for debugging purp=
oses.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > > > > > > > > ---
> > > > > > > > >   gdb-xml/riscv-32bit-virtual.xml |  1 +
> > > > > > > > >   gdb-xml/riscv-64bit-virtual.xml |  1 +
> > > > > > > > >   target/riscv/gdbstub.c          | 18 ++++++++++++------
> > > > > > > > >   3 files changed, 14 insertions(+), 6 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/ri=
scv-
> > > > > > > > > 32bit-
> > > > > > > > > virtual.xml
> > > > > > > > > index 905f1c555d..d44b6ca2dc 100644
> > > > > > > > > --- a/gdb-xml/riscv-32bit-virtual.xml
> > > > > > > > > +++ b/gdb-xml/riscv-32bit-virtual.xml
> > > > > > > > > @@ -8,4 +8,5 @@
> > > > > > > > >   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > > > >   <feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > > > >     <reg name=3D"priv" bitsize=3D"32"/>
> > > > > > > > > +  <reg name=3D"virt" bitsize=3D"32"/>
> > > > > > > > >   </feature>
> > > > > > > > > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/ri=
scv-
> > > > > > > > > 64bit-
> > > > > > > > > virtual.xml
> > > > > > > > > index 62d86c237b..7c9b63d5b6 100644
> > > > > > > > > --- a/gdb-xml/riscv-64bit-virtual.xml
> > > > > > > > > +++ b/gdb-xml/riscv-64bit-virtual.xml
> > > > > > > > > @@ -8,4 +8,5 @@
> > > > > > > > >   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > > > > > > > >   <feature name=3D"org.gnu.gdb.riscv.virtual">
> > > > > > > > >     <reg name=3D"priv" bitsize=3D"64"/>
> > > > > > > > > +  <reg name=3D"virt" bitsize=3D"64"/>
> > > > > > > > >   </feature>
> > > > > > > >
> > > > > > > > I assume these are mirrored in gdb not a QEMU only extensio=
n?
> > > > > > >
> > > > > > > So far I think it is a QEMU extension and the `gdb-multiarch`
> > > > > > > doesn't
> > > > > > > treat
> > > > > > > is
> > > > > > > specially. My tests shows it basically works:
> > > > > > >
> > > > > > > ```
> > > > > > > (gdb) ir virt
> > > > > > > priv           0x3      prv:3 [Machine]
> > > > > > > virt           0x0      0
> > > > > > > (gdb) set $priv =3D 2
> > > > > > > (gdb) ir virt
> > > > > > > priv           0x1      prv:1 [Supervisor]
> > > > > > > virt           0x0      0
> > > > > > > (gdb) set $virt =3D 1
> > > > > > > (gdb) ir virt
> > > > > > > priv           0x1      prv:1 [Supervisor]
> > > > > > > virt           0x1      1
> > > > > > > (gdb) set $virt =3D 0
> > > > > > > (gdb) ir virt
> > > > > > > priv           0x1      prv:1 [Supervisor]
> > > > > > > virt           0x0      0
> > > > > > > (gdb) set $virt =3D 1
> > > > > > > (gdb) ir virt
> > > > > > > priv           0x1      prv:1 [Supervisor]
> > > > > > > virt           0x1      1
> > > > > > > (gdb) set $priv =3D 3
> > > > > > > (gdb) ir virt
> > > > > > > priv           0x3      prv:3 [Machine]
> > > > > > > virt           0x0      0
> > > > > > > ```
> > > > > >
> > > > > > A gdbstub test case would be useful for this although I don't k=
now if
> > > > > > the RiscV check-tcg tests switch mode at all.
> > > > > >
> > > > > > >
> > > > > > > As I am rather new to QEMU, please teach how we can add it as=
 a QEMU
> > > > > > > only
> > > > > > > extension.
> > > > > >
> > > > > > You don't need to extend the XML from GDB, you can build a spec=
ific
> > > > > > one
> > > > > > for QEMU extensions. For example:
> > > > > >
> > > > > >      gdb_feature_builder_init(&param.builder,
> > > > > >                               &cpu->dyn_sysreg_feature.desc,
> > > > > >                               "org.qemu.gdb.arm.sys.regs",
> > > > > >                               "system-registers.xml",
> > > > > >                               base_reg);
> > > > > >
> > > > > > This exports all the system registers QEMU knows about and GDB =
can
> > > > > > access generically. Note the id is org.qemu..., indicating its =
our
> > > > > > schema not gdbs.
> > > > > Thanks for teaching, I need time to digest. I guess more feature =
builder
> > > > > APIs
> > > > > are needed (like append_reg) and the getter/setter callbacks migh=
t be at
> > > > > a
> > > > > different place.
> > > > >
> > > > > BTW, compared to adding virtual register `virt`, how do you think=
 if we
> > > > > share
> > > > > the V bit as part of existing `priv` register?
> > > >
> > > > IMHO this is a very good idea since the latest release candidate of
> > > > riscv-debug-spec also includes the V bit in priv:2.
> > > >
> > >
> > > Thanks for this information, I noticed the bit(2) of `priv` register =
is for
> > > the
> > > V bit as per section 4.10.1.
> > >
> > > > > Or maybe we shall talk to GDB community to get their opinions? If=
 they
> > > > > agree
> > > > > to
> > > > > add a few words about V bit here
> > > > > https://sourceware.org/gdb/current/onlinedocs/gdb.html/RISC_002dV=
-Features.html
> > > > > ,
> > > > > then it saves us a lot.
> > > >
> > > > Except being currently not supported by GDB
> > > >
> > > > (gdb) info register $priv
> > > > priv           0x5      prv:5 [INVALID]
> > > >
> > > > are there any reasons from QEMU's side that would speak against
> > > > including V in priv?
> > > >
> > >
> > > My v1 patch used `bit(8)` to avoid seeing the `[INVALID]` thing at GD=
B side,
> > > though that is due to GDB isn't in line with its own manual (i.e. use=
 the
> > > two
> > > lowest bits only).
> > >
> > > Without a doc or specification. we felt people may not know `bit(8)` =
in v1
> > > patch
> > > was for the V bit, so I drafted patch v2 as Alistair suggested. Howev=
er, as
> > > Alex
> > > pointed out, directly adding `virt` register in "org.gnu.gdb.riscv.vi=
rtual"
> > > XML
> > > is improper. I also wanted to raise this in GDB side but my applicati=
on to
> > > join
> > > the mail list is still pending.
> > >
> > > Alex and Alistair, now I am wondering if we can follow the RiscV debu=
g
> > > specification to use `bit(2)` of `priv` virtual register? My test sho=
ws
> > > except
> > > for the `[INVALID]` label, both set/get access seems working.
> >
> > I guess the INVALID just means gdb needs teaching about the format of
> > the register.
>
> Yes, GDB currently uses mask `0xff`(instead of `0x3`) to get the mode val=
ue when
> adding the string label, this violates its own manual:
>
> 1303           else if (regnum =3D=3D RISCV_PRIV_REGNUM)
> 1304             {
> 1305               LONGEST d;
> 1306               uint8_t priv;
> 1307
> 1308               d =3D value_as_long (val);
> 1309               priv =3D d & 0xff;
> 1310
> 1311               if (priv < 4)
> 1312                 {
> 1313                   static const char * const sprv[] =3D
> 1314                     {
> 1315                       "User/Application",
> 1316                       "Supervisor",
> 1317                       "Hypervisor",
> 1318                       "Machine"
> 1319                     };
> 1320                   gdb_printf (file, "\tprv:%d [%s]",
> 1321                               priv, sprv[priv]);
> 1322                 }
> 1323               else
> 1324                 gdb_printf (file, "\tprv:%d [INVALID]", priv);
> 1325             }
>
>
> I am wondering if we can go ahead to follow RiscV debug specification and=
 sync
> with GDB later?

If there is a spec then that is the way to go. Just link to it when
submitting the patch.

We also at least want to be sending a patch to GDB to fix it,
otherwise we are going to break people.

Alistair

