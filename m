Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810CBD637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHtW-0002yJ-3K; Wed, 13 Nov 2024 13:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBHtT-0002wD-Rg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:15:08 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBHtR-0001dp-Ln
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:15:07 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e600ae1664so4372390b6e.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731521704; x=1732126504;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DT1smMNQMocKLEt0UKyZPUGMjTIP0ZGsEMAL493ZpQc=;
 b=dByoucMTSuvYY/5bEGoU1gZ7u4EGxXg1bY8670VlVNpeWK8rJmnt5cy5gClRV9wv9g
 sj+/sYJDzOG8NUmkiqkUEdxGoqN4mvnlQJSx0FS+N6wFHXd9UI3A8SAElr0SGcj+ZsLk
 40NpjuFaOFHaHa5FNQm3Hjg2mUO+GSKnvaTgRBpY601XivUqmfsFx/O68zJkbzp8St6c
 Bx7Pfg9nea2eosE2ylmst0vM+LLXYxCUaHlwr7Md09cxV+e22NFAX0LrKsYI8hSDQHHm
 EXTHeJJ1ZJDZPi6VYgG8FM4kE+PzrvBSoBigI5/dc2OKFh1OeXS23RkPVzaZzb5WDLw6
 z9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731521704; x=1732126504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DT1smMNQMocKLEt0UKyZPUGMjTIP0ZGsEMAL493ZpQc=;
 b=KggxfiYAtihK2arM8cxm2wF45v5+re71Z4HIp67vRvwiHRDqhuF1GtnE1jqCU4mY55
 LkUXF9VXOha6Ha3Cmpg+tL+UHLRQ8FXZsR4yNOQyELKqutEyICiGwEx65jRbAu1l5gaz
 +vbA56ICR8OCk25PSLrfEEj5KbAvBdrrvp8uY6C4x/74TEwnB3CXcLTPWx5kAHU98TbZ
 DWrzpSVHA1n8bG9PTAaS1E/entfwxkstellC0J7vuRbqzjzzFdtC+cC23TXTIVeIw/LV
 KRYMblsytufM2v5XaxJ5mKJSpoG27nUnERsfmqOFHlJIbY2ydTC+YyiKK7KilbVrAhmr
 7P1g==
X-Gm-Message-State: AOJu0YzryQtvsbL/OITGxAP2bA4YrXrdcflmI6QamUhAVduAEbUnk5X4
 SaF/kjPYPV+nR3mgU+lEyL3uNOOKLqzco3jXB5lr00A2PdDnsXadpjxuVClSELxyR4VvLP6HNxq
 FukGU6zCEYUjf9GwFuJLbWsOUpB9XThN+tvxc
X-Google-Smtp-Source: AGHT+IEQeblz3HKHXteiNYxv20mVOGIs8AEZv2MfYocTOAl2BTYUkJwtO2nCUCzgi3aUiwPWThhVaY8ZbCNDsSzkMaw=
X-Received: by 2002:a05:6808:11c8:b0:3e5:f656:dd19 with SMTP id
 5614622812f47-3e7946a670cmr18969229b6e.19.1731521702100; Wed, 13 Nov 2024
 10:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20241113144923.41225-1-phil@philjordan.eu>
 <02dcb7aa-f8d7-4044-93af-24b6d2e4c688@redhat.com>
In-Reply-To: <02dcb7aa-f8d7-4044-93af-24b6d2e4c688@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 13 Nov 2024 19:14:51 +0100
Message-ID: <CAAibmn01cqyEhGNsg5XS8tFsX-iQ=ZLD_FHhiCt9HahEawT92w@mail.gmail.com>
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, mtosatti@redhat.com, 
 santosh.shukla@amd.com, suravee.suthikulpanit@amd.com
Content-Type: multipart/alternative; boundary="000000000000f99dde0626cf4f36"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::231;
 envelope-from=phil@philjordan.eu; helo=mail-oi1-x231.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000f99dde0626cf4f36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed 13. Nov 2024 at 19:06, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/13/24 15:49, Phil Dennis-Jordan wrote:
> > It appears that existing call sites for the kvm_enable_x2apic()
> > function rely on the compiler eliding the calls during optimisation
> > when building with KVM disabled, or on platforms other than Linux,
> > where that function is declared but not defined.
> >
> > This fragile reliance recently broke down when commit b12cb38 added
> > a new call site which apparently failed to be optimised away when
> > building QEMU on macOS with clang, resulting in a link error.
>
> That's weird, can you check the preprocessor output?  The definition
> of kvm_irqchip_in_kernel() should be just "false" on macOS, in fact
> even the area you're changing should be simplified like
>

Yeah, to be honest this header file seems a bit of a mess. It=E2=80=99s bei=
ng
#included by a bunch of .c files in hw/ despite being located in target/
not include/ which suggests to me that some of the declarations ought to be
moved.

As I=E2=80=99m not really familiar with any of the KVM code base I would no=
t
normally be attempting to clean this up but the staging & master branches
currently don=E2=80=99t build on macOS, so I was aiming for the simplest fi=
x
possible for the immediate problem.

(I will test your patch shortly however.)


> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 9de9c0d3038..7edb154a16e 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -13,8 +13,7 @@
>
>   #include "sysemu/kvm.h"
>
> -#ifdef CONFIG_KVM
> -
> +/* always false if !CONFIG_KVM */
>   #define kvm_pit_in_kernel() \
>       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
>   #define kvm_pic_in_kernel()  \
> @@ -22,14 +21,6 @@
>   #define kvm_ioapic_in_kernel() \
>       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
>
> -#else
> -
> -#define kvm_pit_in_kernel()      0
> -#define kvm_pic_in_kernel()      0
> -#define kvm_ioapic_in_kernel()   0
> -
> -#endif  /* CONFIG_KVM */
> -
>   bool kvm_has_smm(void);
>   bool kvm_enable_x2apic(void);
>
> Paolo
>
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   target/i386/kvm/kvm_i386.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> > index 9de9c0d3038..7ce47388d90 100644
> > --- a/target/i386/kvm/kvm_i386.h
> > +++ b/target/i386/kvm/kvm_i386.h
> > @@ -21,17 +21,18 @@
> >       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> >   #define kvm_ioapic_in_kernel() \
> >       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> > +bool kvm_enable_x2apic(void);
> >
> >   #else
> >
> >   #define kvm_pit_in_kernel()      0
> >   #define kvm_pic_in_kernel()      0
> >   #define kvm_ioapic_in_kernel()   0
> > +#define kvm_enable_x2apic()      0
> >
> >   #endif  /* CONFIG_KVM */
> >
> >   bool kvm_has_smm(void);
> > -bool kvm_enable_x2apic(void);
> >   bool kvm_hv_vpindex_settable(void);
> >   bool kvm_enable_hypercall(uint64_t enable_mask);
> >
>
>

--000000000000f99dde0626cf4f36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed 13. Nov 2024 at 19:06, Paolo Bonzini &lt;<a href=3D"=
mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(=
204,204,204)">On 11/13/24 15:49, Phil Dennis-Jordan wrote:<br>
&gt; It appears that existing call sites for the kvm_enable_x2apic()<br>
&gt; function rely on the compiler eliding the calls during optimisation<br=
>
&gt; when building with KVM disabled, or on platforms other than Linux,<br>
&gt; where that function is declared but not defined.<br>
&gt; <br>
&gt; This fragile reliance recently broke down when commit b12cb38 added<br=
>
&gt; a new call site which apparently failed to be optimised away when<br>
&gt; building QEMU on macOS with clang, resulting in a link error.<br>
<br>
That&#39;s weird, can you check the preprocessor output?=C2=A0 The definiti=
on<br>
of kvm_irqchip_in_kernel() should be just &quot;false&quot; on macOS, in fa=
ct<br>
even the area you&#39;re changing should be simplified like<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, to be hone=
st this header file seems a bit of a mess. It=E2=80=99s being #included by =
a bunch of .c files in hw/ despite being located in target/ not include/ wh=
ich suggests to me that some of the declarations ought to be moved.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">As I=E2=80=99m not really famil=
iar with any of the KVM code base I would not normally be attempting to cle=
an this up but the staging &amp; master branches currently don=E2=80=99t bu=
ild on macOS, so I was aiming for the simplest fix possible for the immedia=
te problem.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(I will test=
 your patch shortly however.)</div><div dir=3D"auto"><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,2=
04)"><br>
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h<br>
index 9de9c0d3038..7edb154a16e 100644<br>
--- a/target/i386/kvm/kvm_i386.h<br>
+++ b/target/i386/kvm/kvm_i386.h<br>
@@ -13,8 +13,7 @@<br>
<br>
=C2=A0 #include &quot;sysemu/kvm.h&quot;<br>
<br>
-#ifdef CONFIG_KVM<br>
-<br>
+/* always false if !CONFIG_KVM */<br>
=C2=A0 #define kvm_pit_in_kernel() \<br>
=C2=A0 =C2=A0 =C2=A0 (kvm_irqchip_in_kernel() &amp;&amp; !kvm_irqchip_is_sp=
lit())<br>
=C2=A0 #define kvm_pic_in_kernel()=C2=A0 \<br>
@@ -22,14 +21,6 @@<br>
=C2=A0 #define kvm_ioapic_in_kernel() \<br>
=C2=A0 =C2=A0 =C2=A0 (kvm_irqchip_in_kernel() &amp;&amp; !kvm_irqchip_is_sp=
lit())<br>
<br>
-#else<br>
-<br>
-#define kvm_pit_in_kernel()=C2=A0 =C2=A0 =C2=A0 0<br>
-#define kvm_pic_in_kernel()=C2=A0 =C2=A0 =C2=A0 0<br>
-#define kvm_ioapic_in_kernel()=C2=A0 =C2=A00<br>
-<br>
-#endif=C2=A0 /* CONFIG_KVM */<br>
-<br>
=C2=A0 bool kvm_has_smm(void);<br>
=C2=A0 bool kvm_enable_x2apic(void);<br>
<br>
Paolo<br>
<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/kvm/kvm_i386.h | 3 ++-<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h<b=
r>
&gt; index 9de9c0d3038..7ce47388d90 100644<br>
&gt; --- a/target/i386/kvm/kvm_i386.h<br>
&gt; +++ b/target/i386/kvm/kvm_i386.h<br>
&gt; @@ -21,17 +21,18 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(kvm_irqchip_in_kernel() &amp;&amp; !kvm_irq=
chip_is_split())<br>
&gt;=C2=A0 =C2=A0#define kvm_ioapic_in_kernel() \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(kvm_irqchip_in_kernel() &amp;&amp; !kvm_irq=
chip_is_split())<br>
&gt; +bool kvm_enable_x2apic(void);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define kvm_pit_in_kernel()=C2=A0 =C2=A0 =C2=A0 0<br>
&gt;=C2=A0 =C2=A0#define kvm_pic_in_kernel()=C2=A0 =C2=A0 =C2=A0 0<br>
&gt;=C2=A0 =C2=A0#define kvm_ioapic_in_kernel()=C2=A0 =C2=A00<br>
&gt; +#define kvm_enable_x2apic()=C2=A0 =C2=A0 =C2=A0 0<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif=C2=A0 /* CONFIG_KVM */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0bool kvm_has_smm(void);<br>
&gt; -bool kvm_enable_x2apic(void);<br>
&gt;=C2=A0 =C2=A0bool kvm_hv_vpindex_settable(void);<br>
&gt;=C2=A0 =C2=A0bool kvm_enable_hypercall(uint64_t enable_mask);<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div></div>

--000000000000f99dde0626cf4f36--

