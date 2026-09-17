Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BEBC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 01:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x70VJ-0005Ct-Dt; Wed, 16 Sep 2026 21:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x70V0-0005CG-Sr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 21:01:14 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x70Uy-0002oI-Jd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 21:01:14 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a8038a9f10so457779a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 18:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789606870; cv=none;
 d=google.com; s=arc-20260327;
 b=k9hQnwvoQRC2yUHwlimS8CYeXcmPk+nm9fkCbALv3ZAa1G2nrecK6L8JnbCOzdOgkM
 vvZI8l01wc5DWFAM31rvENQRl/ABlkITZI6kUD89ctV4zTy5K1eB9AKVplJtQoUdWoLm
 r6i5BFjkSDzppWUiDEhB+/GPJxm/zSy1KKgsZXXdYqMzncKLKsmTUdfJBICV3OV/6Ett
 G9Sjq4kVrpaDjDZkf0oFqJCTwTJZ/ETMEIAeuwi5TdMnXUwWWsXgsUr0WBUlIJWq6DLd
 fe6eL6ctF08VpQ+KtPygd6QbnKH6c1lOXwZKSKtpbb6smnVS5NHhaO70bNOn1PwUzDRo
 B0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7TdRIIc93N967XDBumgh+AeyDXEC5b/XjEDz2SJJ0CU=;
 fh=odk8u6+j0B7kWyhBorijHPQvbHn1rIuhWqv+4og/0Os=;
 b=IDyRNFnHRdc3Q85U5jjMWjFYUyPl0EfBUWgJdT/mrlLdCB5tmqAwvBc05YclUBfnr9
 4MIxWpIMXayEHBb/iJlvlQRXcvn3m5qIVJ2Zu67Q19HmYHNEaXOzwbA3CF8ydvOBy9ii
 sht8R5x6FQX+sr65pVHoKZHsMecppT6WFQa4kfI/EzSYRDYKl4IYb53H1jU4xC2393f0
 BM2KYys57QK91Y+jf4KjqPdsXxtmfKFsExwSxFixg/KuwD0wafNUjtZYhHHotO6ajVHW
 IJNh7ARPFKX5kGCTZVPjtO+jXw4TxTSYPjd0SN0a7Q19KptembrhGZc4AlLNLu350n5S
 aExA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789606870; x=1790211670; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7TdRIIc93N967XDBumgh+AeyDXEC5b/XjEDz2SJJ0CU=;
 b=Jww7RSVuiX5WyNOPy/Rlhc7d4z0+SXYTOMQaoaUjViGIlZerk5osKsi1iAIT162OaQ
 6regAc9OC9bDewuA10ZJfkNj9a/pV0dC6gis8rVQxwRjxDqapBK46lK4+kTo4jjRHRMX
 D6D34AFAoDfiG7HlM9Z/hLJOZ9hI/9BvK+y4uRiWLVXFtFpHHgSu7iilLqubWMONWaJY
 vcjPlqTm0O0BSPxZzah94eCGuWeOElyrJO2yWS5xqYChBeKk2JLzX19yi4BUvsh1RVQZ
 DN8fJN1w54qYzn7eXa25nZl32OJRJTqelJXnScV1e9zp2MH/x259KAWyk1z3+brOvePJ
 lm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789606870; x=1790211670;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7TdRIIc93N967XDBumgh+AeyDXEC5b/XjEDz2SJJ0CU=;
 b=OA8mhkZaLGgwFtXl5+uQj1oEB2bgnYCQnZ5LmXCq0HBZF5BNbkY4MKAgObAqqczfLf
 t/vJladw5QM1XPGZioegRxBYNVMwi3kyzl0HZwE9pLHnj8IuDJdgBdQmkXfC10dHiWSW
 wnG/JKEr1FLYpgy1CzaUUuqyYuwr95RBCZQzqwOEmwgAXiPYW3qPti0553KO5UW5K1yn
 1s4KdcjXhNIu09rbsmvEWukxgxuIaNYGyXr21n8qawaEXLsSy/xMm0iQiysUvoWqrw9x
 FR2nD+MnEgEZZ/J0EoUrRYI9Bq5gxHjMSyAZIXayCNbzfzey59XlK2SdyghI5Gx6xFzQ
 pSkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwm/AvTsXfZ77+5GKDcDrGyUas7anPGniWy4hzNl2429rnPlwmHyMBt+xwWoo/cIfuSQQzP/1/v0Mj3@nongnu.org
X-Gm-Message-State: AFuF++k5ZsV2Mxv70fz05ccDW/57B6mzn6JfbzTpfLHGr9hZpGRc51Co
 AbB6LD+mPixPzST0/1HAAf1NVdR02AzK3G6d2Jj8gnJ4KqXxIxjPeYZqHhac46rae5+0u1Fcrnz
 MRH4/QAYY2gV8a/2PIn4/8ZoWULwDqxU=
X-Gm-Gg: AYBFou0xfFDZul+NY4fHs9UXjW6HlPlelwOCAKiqg/G5ySAL5m+CRapLJLrWUIURCJR
 nl0WqvuqfMpJVoRKQ22dMgw2ZbZIdSCvQ2govLRi1Oy8ZlzJ+7mM6uFo99sa2vV1zl1fCLlxTzu
 +ZhtwhgcAt9gLdscunCs4UOmlaU52A0IiJmEGSp32zgFnlJEl2rXYQSNQbGhGZV9Fz1HhwRZtRY
 lQ2acJR5Jp5uHmwdFV1J+JIwwuwHWpAZNbODG5u8yCvN6l5dpyPzu/R/CZlNgZ/aBdR5IEaedpe
 HXfOHXcdYQzFhCBkHI10HF0+rklxt99Fx0PoviCIVK8oyKSXGfqejA4P4zoa20HrIQ==
X-Received: by 2002:a05:6402:44c5:b0:6a9:caf5:ff85 with SMTP id
 4fb4d7f45d1cf-6aa223d83d0mr2691597a12.21.1789606870354; Wed, 16 Sep 2026
 18:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-10-babc367b60f5@rev.ng>
 <f692f936-550b-4e5b-90ee-399edf21de73@oss.qualcomm.com>
In-Reply-To: <f692f936-550b-4e5b-90ee-399edf21de73@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 17 Sep 2026 09:00:56 +0800
X-Gm-Features: AcwNN1W5EMs2lJ9vOmWE26fsfTXatW42w_hZaEXWeWRvC3EIAGzqD93EgfQV1yw
Message-ID: <CAE2XoE9KkW+WPWL1g4hzT6OtkQhfYvaMAopBW4NfFMkXn9hjzQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] target-info: Introduce target_riscv32
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
Content-Type: multipart/alternative; boundary="000000000000cb8fc4065ba35152"
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
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

--000000000000cb8fc4065ba35152
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I said before, we need the `const TargetInfo*` parameter to for
is_avaiable.  I've get all accelerator and
i386/x86_64/aarch64/arm/risv32/riscv64/


 single_binary_supported_targets =3D [
   'aarch64-softmmu',
   'arm-softmmu',
+  'i386-softmmu',
   'microblaze-softmmu',
   'riscv32-softmmu',
   'riscv64-softmmu',
+  'x86_64-softmmu',
 ]


On Thu, Sep 17, 2026 at 1:03=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 9/16/2026 2:19 AM, Anton Johansson wrote:
> > Will be used in the following commit to filter machines using
> > TypeInfo::is_available, so a simple !target_riscv64() is not sufficient=
.
> >
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >  include/qemu/target-info.h | 7 +++++++
> >  target-info.c              | 5 +++++
> >  2 files changed, 12 insertions(+)
> >
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>


 include/qemu/target-info.h | 30 ++++++++++++++++++++++++++++++
 target-info.c              | 26 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 0620a3db84..560d589bcf 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -239,6 +239,36 @@ bool target_is_s390x(const TargetInfo *ti);
  */
 bool target_s390x(void);

+/**
+ * target_is_base_riscv:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 32-bit or 64-bit.
+ */
+bool target_is_base_riscv(const TargetInfo *ti);
+
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
+/**
+ * target_is_riscv32:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 32-bit.
+ */
+bool target_is_riscv32(const TargetInfo *ti);
+
+/**
+ * target_riscv32:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit.
+ */
+bool target_riscv32(void);
+
 /**
  * target_is_riscv64:
  * @ti: TargetInfo to inspect
diff --git a/target-info.c b/target-info.c
index 9083b7bca6..a9fcd1c07b 100644
--- a/target-info.c
+++ b/target-info.c
@@ -250,6 +250,32 @@ bool target_s390x(void)
     return target_is_s390x(target_info());
 }

+bool target_is_base_riscv(const TargetInfo *ti)
+{
+    switch (ti->target_arch) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_base_riscv(void)
+{
+    return target_is_base_riscv(target_info());
+}
+
+bool target_is_riscv32(const TargetInfo *ti)
+{
+    return ti->target_arch =3D=3D SYS_EMU_TARGET_RISCV32;
+}
+
+bool target_riscv32(void)
+{
+    return target_is_riscv32(target_info());
+}
+
 bool target_is_riscv64(const TargetInfo *ti)
 {
     return ti->target_arch =3D=3D SYS_EMU_TARGET_RISCV64;


These are the helpers I needed, that are very important.for subsequent
work, otherwise the latter work will be repeated again. and split
target_is_* out again.

Those is_avaiable should use target_is_*, that's differ from
target_riscv32 and so on.
--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000cb8fc4065ba35152
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As I said before, we need the `const TargetInfo*` paramete=
r to for is_avaiable.=C2=A0 I&#39;ve get all accelerator and i386/x86_64/aa=
rch64/arm/risv32/riscv64/<br><br><br>=C2=A0single_binary_supported_targets =
=3D [<br>=C2=A0 =C2=A0&#39;aarch64-softmmu&#39;,<br>=C2=A0 =C2=A0&#39;arm-s=
oftmmu&#39;,<br>+ =C2=A0&#39;i386-softmmu&#39;,<br>=C2=A0 =C2=A0&#39;microb=
laze-softmmu&#39;,<br>=C2=A0 =C2=A0&#39;riscv32-softmmu&#39;,<br>=C2=A0 =C2=
=A0&#39;riscv64-softmmu&#39;,<br>+ =C2=A0&#39;x86_64-softmmu&#39;,<br>=C2=
=A0]<br>=C2=A0<br><br>On Thu, Sep 17, 2026 at 1:03=E2=80=AFAM Pierrick Bouv=
ier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouvi=
er@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 9/16/2026 2:19 AM, An=
ton Johansson wrote:<br>&gt; &gt; Will be used in the following commit to f=
ilter machines using<br>&gt; &gt; TypeInfo::is_available, so a simple !targ=
et_riscv64() is not sufficient.<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: An=
ton Johansson &lt;<a href=3D"mailto:anjo@rev.ng">anjo@rev.ng</a>&gt;<br>&gt=
; &gt; ---<br>&gt; &gt; =C2=A0include/qemu/target-info.h | 7 +++++++<br>&gt=
; &gt; =C2=A0target-info.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 5 +++++<br>&gt; &gt; =C2=A02 files changed, 12 insertions(+)<br>&gt; &gt;=
<br>&gt;<br>&gt; Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierri=
ck.bouvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>&=
gt;<br><br><br>=C2=A0include/qemu/target-info.h | 30 ++++++++++++++++++++++=
++++++++<br>=C2=A0target-info.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 26 ++++++++++++++++++++++++++<br>=C2=A02 files changed, 56 insertio=
ns(+)<br><br>diff --git a/include/qemu/target-info.h b/include/qemu/target-=
info.h<br>index 0620a3db84..560d589bcf 100644<br>--- a/include/qemu/target-=
info.h<br>+++ b/include/qemu/target-info.h<br>@@ -239,6 +239,36 @@ bool tar=
get_is_s390x(const TargetInfo *ti);<br>=C2=A0 */<br>=C2=A0bool target_s390x=
(void);<br>=C2=A0<br>+/**<br>+ * target_is_base_riscv:<br>+ * @ti: TargetIn=
fo to inspect<br>+ *<br>+ * Returns whether @ti is RISC-V 32-bit or 64-bit.=
<br>+ */<br>+bool target_is_base_riscv(const TargetInfo *ti);<br>+<br>+/**<=
br>+ * target_base_riscv:<br>+ *<br>+ * Returns whether the target architec=
ture is RISC-V 32-bit or 64-bit.<br>+ */<br>+bool target_base_riscv(void);<=
br>+<br>+/**<br>+ * target_is_riscv32:<br>+ * @ti: TargetInfo to inspect<br=
>+ *<br>+ * Returns whether @ti is RISC-V 32-bit.<br>+ */<br>+bool target_i=
s_riscv32(const TargetInfo *ti);<br>+<br>+/**<br>+ * target_riscv32:<br>+ *=
<br>+ * Returns whether the target architecture is RISC-V 32-bit.<br>+ */<b=
r>+bool target_riscv32(void);<br>+<br>=C2=A0/**<br>=C2=A0 * target_is_riscv=
64:<br>=C2=A0 * @ti: TargetInfo to inspect<br>diff --git a/target-info.c b/=
target-info.c<br>index 9083b7bca6..a9fcd1c07b 100644<br>--- a/target-info.c=
<br>+++ b/target-info.c<br>@@ -250,6 +250,32 @@ bool target_s390x(void)<br>=
=C2=A0 =C2=A0 =C2=A0return target_is_s390x(target_info());<br>=C2=A0}<br>=
=C2=A0<br>+bool target_is_base_riscv(const TargetInfo *ti)<br>+{<br>+ =C2=
=A0 =C2=A0switch (ti-&gt;target_arch) {<br>+ =C2=A0 =C2=A0case SYS_EMU_TARG=
ET_RISCV32:<br>+ =C2=A0 =C2=A0case SYS_EMU_TARGET_RISCV64:<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return true;<br>+ =C2=A0 =C2=A0default:<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return false;<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+bool target_=
base_riscv(void)<br>+{<br>+ =C2=A0 =C2=A0return target_is_base_riscv(target=
_info());<br>+}<br>+<br>+bool target_is_riscv32(const TargetInfo *ti)<br>+{=
<br>+ =C2=A0 =C2=A0return ti-&gt;target_arch =3D=3D SYS_EMU_TARGET_RISCV32;=
<br>+}<br>+<br>+bool target_riscv32(void)<br>+{<br>+ =C2=A0 =C2=A0return ta=
rget_is_riscv32(target_info());<br>+}<br>+<br>=C2=A0bool target_is_riscv64(=
const TargetInfo *ti)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0return ti-&gt;targe=
t_arch =3D=3D SYS_EMU_TARGET_RISCV64;<br><br><br>These are the helpers I ne=
eded, that are very important.for subsequent work, otherwise the latter wor=
k will be repeated again. and split=C2=A0

target_is_* out again.<div><br></div><div>Those is_avaiable should use targ=
et_is_*, that&#39;s differ from=C2=A0

target_riscv32 and so on.<br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=
=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0=
 =C2=A0 sincerely,<br>Yonggang Luo
</div></div>

--000000000000cb8fc4065ba35152--

