Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2ACC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQDb-00037F-8I; Mon, 24 Aug 2026 04:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyQDZ-00036f-LR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:39:45 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyQDX-0006R4-3H
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:39:45 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso539301366b.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 01:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787560781; cv=none;
 d=google.com; s=arc-20260327;
 b=n5f4qZdGg1psdebeqmbfqSOF+WZDlA5kxDr1N4/YpdvDxzqpJWOj3pHa9Ocoo6qdMY
 EefIIsyFUN2wzbFa2q6esPxNmB7KPuwNWqx/d6xwFDdYzfiApIVa/VpGzjDnNXjaxBYH
 JVRwH9iJuhPUsspI4vjtl1xyMg09SUhoZHq1MEQx3RuQwp2c/5OO/c1dDkmCDOMKuP64
 IyZrb3ebmQ6EdZbpp/cd8T3rdrCdop1HfMo0UnDv4EpNV7TOz5YAyOAhvKQzsdONjeXv
 YR/3ZrZHB581eXXHKKIZ5yiKtc3xtHVC+RiZeg0VsnFJRdSkFoanH9bvYqsX/E9dmH/B
 ZkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PaYGs0mvig9qtp5L4+aiGdUi5d2gi8oX5o+LASwsPs8=;
 fh=PTtFTSd9KU+d017MulWJCIpFBanBiQh/femZ20rZPtg=;
 b=mRB10C6S/5H1AHssfoD83U2uPdpPIBE/s+S14V1P9owcwv1pZf8gPPQKoeBAiFlpJ2
 Qw7WxIZVXKzoqdr1Vv8c2HkYoqntsUt0xZ8VxDmhvwrRGNroz7/Dd+FzanG7W2Ik2al4
 WlvGeBAiY9gGavjswVokpVpkXhWexOISU7PXhOtKD6c5qqmFKyAYlyCQVXoRf2kx2Par
 g8LCl9y1cqdcPnVe9AAzcZhnQPHexuLMFvrvtuT5hmQLU2MaxJiiWFSuXbP8NkR4Ihmr
 QOF86ehrIH8tbe9d7VUeWXe9ykVoYo00pKVje0uBnxPEEqxeQ7+i59wRQyosvcSkTwuH
 rtKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787560781; x=1788165581; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PaYGs0mvig9qtp5L4+aiGdUi5d2gi8oX5o+LASwsPs8=;
 b=Y/6KNXhEh3aFOs7pJjGGc1F98eSZPgVnrHq5AOkNNIjeTCjZ1TwDh1CRo8UKupN8qF
 47jH5Sa/i0f3UAie5fp5dKADaj05ztoMqIqzPf37u1GrYpcxUpZ1V6f07Wcf47eTUho1
 CtQRYZ2COqp/vx4LpYocvBcCLfyYT1lKRbO0bWvun00FTXSwlZsLl1zRGoMJthVFZezo
 0d3F2nFm5kvsmHViolSiF5Qz78qUuYeS/RoCDJy2ZlWEvJNVEu13wwGfkOS2caERHLt+
 4/TwZ1FWyRMPEU2qL418TcTgAnVE0jpn5DLNL4hPtr2vhl2gCDrqfabagSPPZJZfqx9u
 gtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787560781; x=1788165581;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PaYGs0mvig9qtp5L4+aiGdUi5d2gi8oX5o+LASwsPs8=;
 b=nmu1+lXILDnesA1wuuTUFbNPVeSRPmba5d8Dwn6Kq1MJQiQIXYS26jBUu2rpr1zT/z
 8WBCzYr5YbockpDtGSpaaLCJKGIoChHu6P3L3zRaR2jFmqAyPzQMfsOEMZH4ZbL6dLto
 sqb2uC095cImI32F6Z0/nzGk7g3vKj6eYt7SkTC/i5xZFFcSZFKQ4mrWwfU0+NBkpGsx
 svB9rjVXcqBVf1qEm1kXsidcAczc0RJD53/P6rbUhGXt1vwuFMqflhuNyseNeWp4ZlQc
 yh+ElHlaTVvWzI+11a9SV/3Hhw5VX3sdka/ogMlTWlc3xuU8YKKXe03dFUt7inhEE8wr
 k4LQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzNtK1CHjTaSxW9cMNjPDCqtUXYcqvLRj+rdzfSlbRHHB4dF6biY3hUaPqs4pOP9tr1ld00N+HpOLi@nongnu.org
X-Gm-Message-State: AFuF++l2fyLluTOEgkVtOda5Iz3NMr9tZ4wugAN35Yi+QjWLd4a+HVBW
 ZQPNkmkQUVCHGPedmFLrMM3n0MmENKBRJnR0Lk1aYfl1LUxrvU4j40AIWeKQut0g+Z9Dw61+fC9
 yoITxdkLP1fOMGDkW2npYuZ3+5cEI0Ig=
X-Gm-Gg: AR+sD11LpnI+pj0+E7fus7pm+asCFAXP67/PRtsigH8vLhnQtEESkZvJeg2VS1qaP4u
 qgIQ1PyWnd1S/9fIEEBDbupIqOp9RxpGYV2uHxjTBQdrtoxt74KFpWjOz+uUnChNh3yoaNXK7YP
 PDEhmGVx2FYPbZ0e44IS3BIX28TieqWDbbU6lmwn0gvXfhwWnrGIG8y5zTwweYWm7Zy+Azg28eD
 2qvo1Ap7uJHpLtHt6bFV0wwTwTyZWZ3vQ5pAL2nIYspJX8H4nFEA47i5B9LdxV7ZfjkBs1sc3R6
 BypLkQtDNJOfBIbniiH7CJa4SSp9CmwrlRZ7VUjwtWF6
X-Received: by 2002:a17:906:ef06:b0:c20:768:af62 with SMTP id
 a640c23a62f3a-c24920d7131mr1843946766b.22.1787560780918; Mon, 24 Aug 2026
 01:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
 <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
 <230c2fe0-94f8-46e7-a574-9d036ced67b8@linaro.org>
 <6daaa4b7-4f84-44f3-9cc7-a70935da11b2@oss.qualcomm.com>
In-Reply-To: <6daaa4b7-4f84-44f3-9cc7-a70935da11b2@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 24 Aug 2026 16:39:28 +0800
X-Gm-Features: AcwNN1XzR-wu0UN0TqqhZT2A5ADyXb4DlAWXLacNT052haZq3nX9v07MW3XYRlc
Message-ID: <CAE2XoE_feFKfLRk7_2eiAW5rmKCgx7ZQAk_uLtDY_0+rxo_PeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] qom/object: add available_if field to TypeInfo
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005c73f30659c6edb4"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000005c73f30659c6edb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 2:54=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 8/22/2026 7:23 AM, Richard Henderson wrote:
> > On 8/21/26 16:51, Pierrick Bouvier wrote:
> >> With the single-binary, we start mixing types for different targets,
> >> that may or may not be available for current one.
> >>
> >> Previously, we implemented an approach based on interfaces, but it
> >> proved to be too limited. It requires duplication between
> >> machines/cpus/devices, and does not handle specific cases where a type
> >> should be available based on a target configuration (Kconfig).
> >>
> >> To solve this, we add a new field, available_if, to TypeInfo.
> >> It is an array containing a list of requirements for type to be
> >> available.
> >>
> >> For now, we have only targets as requirements, but later we'll add
> >> specific target config entries also.
> >>
> >> We also add a TARGET_REQS macro, to declare a list of requirements. Fo=
r
> >> sanity sake, we don't use a complex variadic macro prefixing each
> >> parameter. It requires a lot of macro boilerplate in C, and prevent
> >> readers to jump easily to definition for each parameter.
> >>
> >> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>   include/qemu/target-info.h | 11 +++++++++++
> >>   include/qom/object.h       |  5 +++++
> >>   qom/object.c               | 10 ++++++++++
> >>   rust/qom/src/qom.rs        |  1 +
> >>   stubs/meson.build          |  1 +
> >>   stubs/target-info.c        | 11 +++++++++++
> >>   target-info.c              | 13 +++++++++++++
> >>   7 files changed, 52 insertions(+)
> >>   create mode 100644 stubs/target-info.c
> >>
> >> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> >> index 6c5b714288e..6379e65bbcf 100644
> >> --- a/include/qemu/target-info.h
> >> +++ b/include/qemu/target-info.h
> >> @@ -50,6 +50,17 @@ const char *target_cpu_type(void);
> >>    */
> >>   bool target_big_endian(void);
> >>   +typedef enum TargetReq {
> >> +    /* 0 is reserved for end of array */
> >> +    TARGET_REQ_BASE_ARM =3D 1,
> >> +    TARGET_REQ_AARCH64,
> >> +    TARGET_REQ_ARM,
> >> +} TargetReq;
> >> +
> >
> > Is there a reason you're inventing Yet Another Enum, especially when
> > target_base_arm etc are based on SysEmuTarget, which itself is used to
> > create bitmasks of targets?
> >
>
> Mostly because we'll have to add CONFIG as TARGET_REQ. (CONFIG_NITRO for
> instance, please see v1), in additions to targets.
> My original implementation was using an interface with a callback, and I
> offered to have this callback as part of TypeInfo. Daniel insisted on
> having a list of constraints for (future) introspection purpose. I think
> it's solving a problem we don't have yet, but need to move on on this
> series, and happy to implement anything that satisfy the community.
>
> In all cases, I'm open to other ideas if you have something to suggest,
> which can represent both target and config knobs, with a simple and
> concise solution. Enum was the best compromise for me, price being
> duplication with existing SysEmuTarget.
>
> >
> > r~
> >
>
>

I've implement single binary for arm/riscv at
https://patchew.org/QEMU/20260823150731.896-1-luoyonggang@gmail.com/

I do not see why this is needed yet.

My patches is based on
https://patchew.org/QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualc=
omm.com/
```
+
+static TargetCpuOps target_cpu_ops;
+
+void target_info_register_cpu_op(const char *cpu_type, size_t offset,
+                                 void *impl)
+{
+    const TargetInfo *ti =3D target_info();
+    void **slot;
+
+    g_assert(ti);
+    g_assert(offset + sizeof(void *) <=3D sizeof(TargetCpuOps));
+    g_assert((offset % sizeof(void *)) =3D=3D 0);
+
+    if (strcmp(cpu_type, ti->cpu_type)) {
+        return;
+    }
+
+    slot =3D (void **)((char *)&target_cpu_ops + offset);
+    if (*slot) {
+        error_report("TargetCpuOps already registered for type '%s'
(offset %zu)",
+                     cpu_type, offset);
+        return;
+    }
+    *slot =3D impl;
+}
+
+const TargetCpuOps *target_info_cpu_ops(void)
+{
+    return &target_cpu_ops;
+}
````

To see different func for different arch

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005c73f30659c6edb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Aug 24, 2026 at 2:54=E2=80=AFPM Pierrick B=
ouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bo=
uvier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 8/22/2026 7:23 AM,=
 Richard Henderson wrote:<br>&gt; &gt; On 8/21/26 16:51, Pierrick Bouvier w=
rote:<br>&gt; &gt;&gt; With the single-binary, we start mixing types for di=
fferent targets,<br>&gt; &gt;&gt; that may or may not be available for curr=
ent one.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Previously, we implemented an ap=
proach based on interfaces, but it<br>&gt; &gt;&gt; proved to be too limite=
d. It requires duplication between<br>&gt; &gt;&gt; machines/cpus/devices, =
and does not handle specific cases where a type<br>&gt; &gt;&gt; should be =
available based on a target configuration (Kconfig).<br>&gt; &gt;&gt;<br>&g=
t; &gt;&gt; To solve this, we add a new field, available_if, to TypeInfo.<b=
r>&gt; &gt;&gt; It is an array containing a list of requirements for type t=
o be<br>&gt; &gt;&gt; available.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; For now,=
 we have only targets as requirements, but later we&#39;ll add<br>&gt; &gt;=
&gt; specific target config entries also.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;=
 We also add a TARGET_REQS macro, to declare a list of requirements. For<br=
>&gt; &gt;&gt; sanity sake, we don&#39;t use a complex variadic macro prefi=
xing each<br>&gt; &gt;&gt; parameter. It requires a lot of macro boilerplat=
e in C, and prevent<br>&gt; &gt;&gt; readers to jump easily to definition f=
or each parameter.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Signed-off-by: Pierric=
k Bouvier&lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.=
bouvier@oss.qualcomm.com</a>&gt;<br>&gt; &gt;&gt; ---<br>&gt; &gt;&gt; =C2=
=A0 include/qemu/target-info.h | 11 +++++++++++<br>&gt; &gt;&gt; =C2=A0 inc=
lude/qom/object.h =C2=A0 =C2=A0 =C2=A0 | =C2=A05 +++++<br>&gt; &gt;&gt; =C2=
=A0 qom/object.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++=
++++++<br>&gt; &gt;&gt; =C2=A0 rust/qom/src/qom.rs =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A01 +<br>&gt; &gt;&gt; =C2=A0 stubs/meson.build =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A01 +<br>&gt; &gt;&gt; =C2=A0 stubs/target-info.c =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++++++++++<br>&gt; &gt;&gt; =C2=A0 target-=
info.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 +++++++++++++<b=
r>&gt; &gt;&gt; =C2=A0 7 files changed, 52 insertions(+)<br>&gt; &gt;&gt; =
=C2=A0 create mode 100644 stubs/target-info.c<br>&gt; &gt;&gt;<br>&gt; &gt;=
&gt; diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h<b=
r>&gt; &gt;&gt; index 6c5b714288e..6379e65bbcf 100644<br>&gt; &gt;&gt; --- =
a/include/qemu/target-info.h<br>&gt; &gt;&gt; +++ b/include/qemu/target-inf=
o.h<br>&gt; &gt;&gt; @@ -50,6 +50,17 @@ const char *target_cpu_type(void);<=
br>&gt; &gt;&gt; =C2=A0 =C2=A0*/<br>&gt; &gt;&gt; =C2=A0 bool target_big_en=
dian(void);<br>&gt; &gt;&gt; =C2=A0 +typedef enum TargetReq {<br>&gt; &gt;&=
gt; + =C2=A0 =C2=A0/* 0 is reserved for end of array */<br>&gt; &gt;&gt; + =
=C2=A0 =C2=A0TARGET_REQ_BASE_ARM =3D 1,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0TAR=
GET_REQ_AARCH64,<br>&gt; &gt;&gt; + =C2=A0 =C2=A0TARGET_REQ_ARM,<br>&gt; &g=
t;&gt; +} TargetReq;<br>&gt; &gt;&gt; +<br>&gt; &gt;<br>&gt; &gt; Is there =
a reason you&#39;re inventing Yet Another Enum, especially when<br>&gt; &gt=
; target_base_arm etc are based on SysEmuTarget, which itself is used to<br=
>&gt; &gt; create bitmasks of targets?<br>&gt; &gt;<br>&gt;<br>&gt; Mostly =
because we&#39;ll have to add CONFIG as TARGET_REQ. (CONFIG_NITRO for<br>&g=
t; instance, please see v1), in additions to targets.<br>&gt; My original i=
mplementation was using an interface with a callback, and I<br>&gt; offered=
 to have this callback as part of TypeInfo. Daniel insisted on<br>&gt; havi=
ng a list of constraints for (future) introspection purpose. I think<br>&gt=
; it&#39;s solving a problem we don&#39;t have yet, but need to move on on =
this<br>&gt; series, and happy to implement anything that satisfy the commu=
nity.<br>&gt;<br>&gt; In all cases, I&#39;m open to other ideas if you have=
 something to suggest,<br>&gt; which can represent both target and config k=
nobs, with a simple and<br>&gt; concise solution. Enum was the best comprom=
ise for me, price being<br>&gt; duplication with existing SysEmuTarget.<br>=
&gt;<br>&gt; &gt;<br>&gt; &gt; r~<br>&gt; &gt;<br>&gt;<br>&gt;<br><br>I&#39=
;ve implement single binary for arm/riscv at <a href=3D"https://patchew.org=
/QEMU/20260823150731.896-1-luoyonggang@gmail.com/">https://patchew.org/QEMU=
/20260823150731.896-1-luoyonggang@gmail.com/</a><br><br>I do not see why th=
is is needed yet.<br><br>My patches is based on =C2=A0<a href=3D"https://pa=
tchew.org/QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com/">=
https://patchew.org/QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualc=
omm.com/</a><br>```<div>+<br>+static TargetCpuOps target_cpu_ops;<br>+<br>+=
void target_info_register_cpu_op(const char *cpu_type, size_t offset,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *impl)<br>+{<br>+ =C2=A0 =C2=A0=
const TargetInfo *ti =3D target_info();<br>+ =C2=A0 =C2=A0void **slot;<br>+=
<br>+ =C2=A0 =C2=A0g_assert(ti);<br>+ =C2=A0 =C2=A0g_assert(offset + sizeof=
(void *) &lt;=3D sizeof(TargetCpuOps));<br>+ =C2=A0 =C2=A0g_assert((offset =
% sizeof(void *)) =3D=3D 0);<br>+<br>+ =C2=A0 =C2=A0if (strcmp(cpu_type, ti=
-&gt;cpu_type)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=
=A0}<br>+<br>+ =C2=A0 =C2=A0slot =3D (void **)((char *)&amp;target_cpu_ops =
+ offset);<br>+ =C2=A0 =C2=A0if (*slot) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
rror_report(&quot;TargetCpuOps already registered for type &#39;%s&#39; (of=
fset %zu)&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cpu_type, offset);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
;<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0*slot =3D impl;<br>+}<br>+<br>+cons=
t TargetCpuOps *target_info_cpu_ops(void)<br>+{<br>+ =C2=A0 =C2=A0return &a=
mp;target_cpu_ops;<br>+}<br><div>````<br><br>To see different func for diff=
erent arch<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div></div></div>

--0000000000005c73f30659c6edb4--

