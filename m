Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A02F55102
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 11:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzCU9-0006RZ-ON; Sun, 08 Mar 2026 07:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ikerjosemartinez26@gmail.com>)
 id 1vzCU2-0006Ih-5W
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 07:39:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ikerjosemartinez26@gmail.com>)
 id 1vzCTz-0007cg-SE
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 07:39:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so7282175e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 04:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772969976; cv=none;
 d=google.com; s=arc-20240605;
 b=hZkwh6ykeATtCrcrGvEBYD+jjoPLK6xYOptXs4wLWINIzHfgBBUcowsuDjjBc3KiYQ
 I5JuxuiWOGlawDZWerZY7xMIv7/KlSuUJ3JGwxaXgmV/PhS91tqqdKIUW9Z7isz2QZPI
 jd8w8fa7B8DjxDXMWDSYOyOcoPEpv0UXS4KP/92eXbHZztyumXMpf0bkCIwkWjqDfHIJ
 3zdpWcERpS1+ax/8ujF0dhcz0ShKeIrEI4EfiSr28y7xVOBZpCPoT4HllWrAtEtsYQAm
 J9GJyzJUns41j/pvb4Ohu5BfRg34uWhoX/vbaa1OW7hXyLojTbM8mQqIllLN/mPo25dD
 D9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h/tnMWRBgygzNtuzTH0P2dD/SeY7Z8vprToMX46vSl4=;
 fh=ToF0T0xSsWdnwGnhkVLJfniB0IXSpNUL8J/nfdNKpUM=;
 b=LQJUJtLNItQQAq+Q9FeJmPlYFKM9dob0xff8VRRRsBcoZLpDUzkxAp1c6knL6+ABlz
 sDtgSo/9q6/UrfYbcdFrOJ7ZS8dnJVi4Qk8VcY7GXXApwpAtTny0ONGQzay3LTBvvuJu
 ff3AjCCt0AY04ZveaO14Oyh+ekRdCrXJSqWRzXCWHqcrwRDDeHsCny73AVMsdgBPfD5U
 bDhLbCWono+Vamcw7mtmTKjrsSk8TBU4KuXhimUMfcCuU0ayEX6pEn9FviToq+itvOqQ
 1dUNVUsRFiapVZXS2QihsO1AFAceU2Esq9Fmf6KN2J4DgKCylLU1esVbKh3V5do1hS3J
 tbvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772969976; x=1773574776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h/tnMWRBgygzNtuzTH0P2dD/SeY7Z8vprToMX46vSl4=;
 b=TZxWm9LkMgGcNSeo8ZSGLyTFwuzEGLChsNBMEgtpouc2XA34l+Uo3ecumNwMD1APKS
 y5589Wwpksi7rqdhzB7CPlERxC/KzJhkE457vGyiQnpYEWmmiSKEjVsVAPwKx+nhQd+1
 0zck/CkLoka5ysZSxQPtJFbKqrJ8q8eXl0oT1bo+vwDGP1wtXMDaKtUeBjz0DrD+l4FR
 jGMwkcy24cmjmGRF93J/Jy2qWVNJSk+/YoKIDKqLQ9SPdoyeqf7b8q/yYRrZszufPhG3
 w8+sN8xsWoii0+uAOtdKwhLrEqptKIvHHTUPUSqcjJ5wevIzjApDbhNhnauPdiqFKVIp
 FSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772969976; x=1773574776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/tnMWRBgygzNtuzTH0P2dD/SeY7Z8vprToMX46vSl4=;
 b=GKy3S9aZasT+bNbcbqMf6MTPu7/1sDXGhGNZj9v6GRHV0jb9FamVSKfZt6OjgBiHxW
 M2in+EtZpVdQwJaA/sJ3Qcx+3WMRqDmIt2epAfduTiKdAWbbaCpJpLHckDKnhRHX+vLb
 aBbCYEW8+UKmadaY61oILM5dsX6SliF3ATzkJR8Eu9O2ZvVJvfavbY/CWBwKZB0mzhOF
 q/+NX8VicGlHN1RPV7KM1P+VvT6eoFuluXaLINhpbmvBCYY6ApRMnuLxc77hBwWzpF3k
 PQfNy077/+AXmwioW0JDrQpy8eEqKOqo1vn/LrSUYbdpk77clWsji7CjgF7UIMcw1rLB
 j2qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnFFx915j/5rT2LEXmCZ1MLtaytKAsPWLMkJDPi4Xa+HShdEUUdurQV5gAzsz/MjDwt3EqpKoXD3UT@nongnu.org
X-Gm-Message-State: AOJu0YyTlT8WLlS4eMMWR1/AQdEDHL6nhBAWfyVylN31WYQRfGCrhd3S
 x5cqsQGS3+8eKmABgj/DzGLvVUA30Hk0cP+cL29Srb17p5NORlubB7mly6FwSbaHJdciFkZaxqA
 ScjSzaiPRqYTx0zjRmGFKysrrNw35hkY=
X-Gm-Gg: ATEYQzzxokdZuE1jj/nOn+Cr3jrvyKtLZQ36OQjCXLcZRpEmKT86q/OVV/XZPh8KGir
 7rTJRKR2sqTEEbJw7hMfZQubDN718BPB96WEIgzaV9gm/l6421mtb7esU3ZZz7SL4vvDUdJLvWm
 rFw+VtRvIw4JflqAdPUWxCXwBonpUbyfVb3pQ/TjTCTwcSASxIN7VMJwb9J2KMx7b0y70/HMhTU
 I/LUvTEqKA9x8j7Fiw99f84PfSTt1m5OjfsijeMhkbXpIeLFWUC9++XzaeW9qNBWIDXEd94uS4g
 WS7xvdCbdsgaXRMO6QNG
X-Received: by 2002:a05:600c:8b5b:b0:480:4ae2:def1 with SMTP id
 5b1f17b1804b1-485269305e5mr122402845e9.13.1772969976161; Sun, 08 Mar 2026
 04:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260307150042.78030-1-philmd@linaro.org>
 <20260307150042.78030-3-philmd@linaro.org>
 <16ced31c-6d4b-417f-92de-386bfee9dcf8@redhat.com>
In-Reply-To: <16ced31c-6d4b-417f-92de-386bfee9dcf8@redhat.com>
From: "noreply77-demartz@thinocorp.com" <ikerjosemartinez26@gmail.com>
Date: Sun, 8 Mar 2026 05:39:24 -0600
X-Gm-Features: AaiRm50yI2713ETrNq6iQ7DhOEbFNrO1mIVSGSVBlortzGW1ERKNeqwnj-1CAF4
Message-ID: <CAMLMkj2zz3+_TE7UU-UkW2MNomVRw7pfHOiBz-pXz0W0aByV7g@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/i386/pc: Remove pc_compat_3_0[] array
To: Thomas Huth <thuth@redhat.com>, martz_jose@mi.com
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a068f0064c81bdba"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=ikerjosemartinez26@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, POSSIBLE_GMAIL_PHISHER=2.591,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000a068f0064c81bdba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

   - Philippe propuso eliminar la matriz pc_compat_3_0[] del c=C3=B3digo i3=
86/pc.
   - Thomas Huth revis=C3=B3 y aprob=C3=B3 el parche propuesto por Philippe=
.





sales@thinocorp.com

El dom, 8 de mar de 2026, 05:37, Thomas Huth <thuth@redhat.com> escribi=C3=
=B3:

> On 07/03/2026 16.00, Philippe Mathieu-Daud=C3=A9 wrote:
> > The pc_compat_3_0[] array was only used by the pc-q35-3.0
> > and pc-i440fx-3.0 machines, which got removed. Remove it.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   include/hw/i386/pc.h | 3 ---
> >   hw/i386/pc.c         | 7 -------
> >   2 files changed, 10 deletions(-)
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 113813c07d7..5623660f5dd 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -277,9 +277,6 @@ extern const size_t pc_compat_4_0_len;
> >   extern GlobalProperty pc_compat_3_1[];
> >   extern const size_t pc_compat_3_1_len;
> >
> > -extern GlobalProperty pc_compat_3_0[];
> > -extern const size_t pc_compat_3_0_len;
> > -
> >   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
> >       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
> >                                                    const void *data) \
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 819e729a6e3..a38634e3577 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -214,13 +214,6 @@ GlobalProperty pc_compat_3_1[] =3D {
> >   };
> >   const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
> >
> > -GlobalProperty pc_compat_3_0[] =3D {
> > -    { TYPE_X86_CPU, "x-hv-synic-kvm-only", "on" },
> > -    { "Skylake-Server" "-" TYPE_X86_CPU, "pku", "off" },
> > -    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "pku", "off" },
> > -};
> > -const size_t pc_compat_3_0_len =3D G_N_ELEMENTS(pc_compat_3_0);
> > -
> >   /*
> >    * @PC_FW_DATA:
> >    * Size of the chunk of memory at the top of RAM for the BIOS ACPI
> tables
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>
>

--000000000000a068f0064c81bdba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><ul><li>Philippe propuso eliminar la matriz <code>pc_comp=
at_3_0[]</code>=C2=A0del c=C3=B3digo i386/pc.</li><li>Thomas Huth revis=C3=
=B3 y aprob=C3=B3 el parche propuesto por Philippe.</li></ul><br><br><br><b=
r><div data-smartmail=3D"gmail_signature"><font color=3D"#2196f3"><a href=
=3D"mailto:sales@thinocorp.com">sales@thinocorp.com</a></font></div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">El dom, 8 de mar de 2026, 05:37, Thomas Huth &lt;<a href=3D=
"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; escribi=C3=B3:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 07/03/2026 16.00, Philippe Mathieu-Daud=
=C3=A9 wrote:<br>
&gt; The pc_compat_3_0[] array was only used by the pc-q35-3.0<br>
&gt; and pc-i440fx-3.0 machines, which got removed. Remove it.<br>
&gt; <br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/i386/pc.h | 3 ---<br>
&gt;=C2=A0 =C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 7 -------<=
br>
&gt;=C2=A0 =C2=A02 files changed, 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
&gt; index 113813c07d7..5623660f5dd 100644<br>
&gt; --- a/include/hw/i386/pc.h<br>
&gt; +++ b/include/hw/i386/pc.h<br>
&gt; @@ -277,9 +277,6 @@ extern const size_t pc_compat_4_0_len;<br>
&gt;=C2=A0 =C2=A0extern GlobalProperty pc_compat_3_1[];<br>
&gt;=C2=A0 =C2=A0extern const size_t pc_compat_3_1_len;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -extern GlobalProperty pc_compat_3_0[];<br>
&gt; -extern const size_t pc_compat_3_0_len;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn)=
 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static void pc_machine_##suffix##_class_init=
(ObjectClass *oc, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const void *data) \<br>
&gt; diff --git a/hw/i386/pc.c b/hw/i386/pc.c<br>
&gt; index 819e729a6e3..a38634e3577 100644<br>
&gt; --- a/hw/i386/pc.c<br>
&gt; +++ b/hw/i386/pc.c<br>
&gt; @@ -214,13 +214,6 @@ GlobalProperty pc_compat_3_1[] =3D {<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_=
3_1);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -GlobalProperty pc_compat_3_0[] =3D {<br>
&gt; -=C2=A0 =C2=A0 { TYPE_X86_CPU, &quot;x-hv-synic-kvm-only&quot;, &quot;=
on&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Skylake-Server&quot; &quot;-&quot; TYPE_X86_CPU=
, &quot;pku&quot;, &quot;off&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Skylake-Server-IBRS&quot; &quot;-&quot; TYPE_X8=
6_CPU, &quot;pku&quot;, &quot;off&quot; },<br>
&gt; -};<br>
&gt; -const size_t pc_compat_3_0_len =3D G_N_ELEMENTS(pc_compat_3_0);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * @PC_FW_DATA:<br>
&gt;=C2=A0 =C2=A0 * Size of the chunk of memory at the top of RAM for the B=
IOS ACPI tables<br>
<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
<br>
</blockquote></div>

--000000000000a068f0064c81bdba--

