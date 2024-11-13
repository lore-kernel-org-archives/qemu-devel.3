Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA932D41C33
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 10:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBB0S-0008SN-6h; Wed, 13 Nov 2024 05:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBB0Q-0008S9-1B
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:53:50 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBB0M-0005NJ-Sk
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:53:49 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c805a0753so66710655ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 02:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731495224; x=1732100024;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MCB4/v+ZR3IzPPUe21BgGMYxckELoFhBvMVPThwfaWA=;
 b=KCKip1rZIdBQcQrYRjJQyv1l3+mQ/mUrvsQ3JBcAFX9JKt3jsjMkl+1xJ3CDq8iOa3
 Z/8ShsgJv7mmRxTXKTqhi4x0TNCXUNic92FWx52j1aq0YCmu5iVKwRxFXbXEj8Ki+tuW
 MGAvt1QdZBSCEVAzXfv1acBZicL24Pf6PYJgUVZJWt6uKz5PpuWtoYYefiqYiCpeKypH
 L3VCvuYR5bSHcqtKJE1seInkHKa8/1WjEtjHQPY5OlArc6eUCdMXUrf4Cn+FSzw8vAvR
 sKm0lB+NP+ljbjYxxaYbFZcyaZ0M7yer3cjWl5/8tKTcPVuZK03U/zXqeHFPda1RGVCX
 x2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731495224; x=1732100024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MCB4/v+ZR3IzPPUe21BgGMYxckELoFhBvMVPThwfaWA=;
 b=uCEhVTuglx9J2o6Cc7zgk1a1BlbH3c4sv0m7NRlJwplGeOXsGQX1bK4quRbnoTp/Pg
 wTibBvOx/QC+ToTrTFhGB/YHWlNIaarCJRX6/qL618RBEQTfOeRm3h+ZywLo+/Gu99sC
 VAcTLoAO7PBmF2Fd10MFPC0tudrxIbTX0781SSIZJM/O1f6cswweM9h25WgA4axaD1YV
 b1DMu7n+t7/taYs70JG0LE7hlqPYZjV0D9nTLzERwANfyifSLf+QsFlL0UH9tWe3Gmob
 4brwodR5tBwE/3rEeksdXleO7PSMdKjqhkPQkSGUiP7Wj4LEnlacuHL99thcolUSABbk
 B7Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNQMCYSZbjXIqzd6+FutXXW4quQqoRjnp5Jdp7mHR3gTJUVhpdjFzcobIKnQvpZQlIe+LYM354PkZD@nongnu.org
X-Gm-Message-State: AOJu0Yx34uXRyPExcxtkFVRSKcMCwsQmsX+Z40lrxuk6LNNbJPZUQc+n
 EVna8zEMX9tDlk7SJa+vEjeMmhxXqR3xDI1AJfZCId+k5l7Lk4AZBo3uyCwHKBfqkl83szO8Fpk
 VLsB0jRp6mSdfUEB4c4GJjUbCzb/D8oNpb2Tv3N48Gr5Iq87vRA==
X-Google-Smtp-Source: AGHT+IG2IDrD0mjjtkTJKKoKtOBd8EMxqoG4EOTvBPDr38CWdAM3zKvbFvJ3lPFyNbWIEO5jrZIglhE8xe5hfaMYv0E=
X-Received: by 2002:a17:90b:2ecb:b0:2e5:5ab5:ba52 with SMTP id
 98e67ed59e1d1-2e9b173f1ddmr26342213a91.20.1731495223586; Wed, 13 Nov 2024
 02:53:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730754238.git.mst@redhat.com>
 <b12cb3819baf6d9ee8140d4dd6d36fa829e2c6d9.1730754238.git.mst@redhat.com>
 <CAGCz3vsrwGQ9v_ZFtteU9jeHpw7z5YATLDLbuKS=dpAzs3C_HA@mail.gmail.com>
 <cebca38a-5896-e2a5-8a68-5edad5dc9d8c@amd.com>
In-Reply-To: <cebca38a-5896-e2a5-8a68-5edad5dc9d8c@amd.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 13 Nov 2024 11:53:32 +0100
Message-ID: <CAGCz3vvyc261YtS5ynhyW49ZccyNd9L2vOALJBAEVOhz1f4MgQ@mail.gmail.com>
Subject: Re: [PULL 32/65] amd_iommu: Check APIC ID > 255 for XTSup
To: "Shukla, Santosh" <santosh.shukla@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, sairaj.arunkodilkar@amd.com
Content-Type: multipart/alternative; boundary="000000000000bb94db0626c925bb"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::62a;
 envelope-from=lists@philjordan.eu; helo=mail-pl1-x62a.google.com
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

--000000000000bb94db0626c925bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Santosh,

On Mon, 11 Nov 2024 at 06:39, Shukla, Santosh <santosh.shukla@amd.com>
wrote:
>
> Hi Phil,
>
> On 11/10/2024 4:36 PM, Phil Dennis-Jordan wrote:
> > Hi,
> >
> > This commit seems to be causing link errors, likely on all platforms
> > where KVM is not available, but at minimum that's what I'm seeing when
> > trying to build the staging branch on macOS.
> >
> > ld: Undefined symbols:
> >   _kvm_enable_x2apic, referenced from:
> >       _amdvi_sysbus_realize in hw_i386_amd_iommu.c.o
> > clang: error: linker command failed with exit code 1 (use -v to see
invocation)
> >
> >
>
> Hmm,.
>
> Thank you for reporting.
>
> > On Mon, 4 Nov 2024 at 22:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >>
> >> The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
> >> to support vcpu w/ APIC ID > 255.
> >>
> >> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> >> Message-Id: <20240927172913.121477-6-santosh.shukla@amd.com>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
> >>  hw/i386/amd_iommu.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> >> index 38297376e7..13af7211e1 100644
> >> --- a/hw/i386/amd_iommu.c
> >> +++ b/hw/i386/amd_iommu.c
> >> @@ -32,6 +32,7 @@
> >>  #include "trace.h"
> >>  #include "hw/i386/apic-msidef.h"
> >>  #include "hw/qdev-properties.h"
> >> +#include "kvm/kvm_i386.h"
> >>
> >>  /* used AMD-Vi MMIO registers */
> >>  const char *amdvi_mmio_low[] =3D {
> >> @@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState
*dev, Error **errp)
> >>      memory_region_add_subregion_overlap(&s->mr_sys,
AMDVI_INT_ADDR_FIRST,
> >>                                          &s->mr_ir, 1);
> >>
> >> +    /* AMD IOMMU with x2APIC mode requires xtsup=3Don */
> >> +    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
> >> +        error_report("AMD IOMMU with x2APIC confguration requires
xtsup=3Don");
> >> +        exit(EXIT_FAILURE);
> >> +    }
> >> +    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> >> +        error_report("AMD IOMMU xtsup=3Don requires support on the KV=
M
side");
> >> +        exit(EXIT_FAILURE);
> >> +    }
> >
> > I suspect this last if() { =E2=80=A6 } block should be wrapped in an #i=
fdef
> > CONFIG_KVM block? I don't know anything about this code though, so if
> > this whole code path is generally a KVM-only feature, perhaps the KVM
> > check should be implemented at the build system dependency level?
> >
>
> Could you please try below in your target system w/ clang and confirm
back?
>
> -----
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 13af7211e1..7081d448e4 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1657,9 +1657,12 @@ static void amdvi_sysbus_realize(DeviceState *dev,
Error **errp)
>          error_report("AMD IOMMU with x2APIC confguration requires
xtsup=3Don");
>          exit(EXIT_FAILURE);
>      }
> -    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> -        error_report("AMD IOMMU xtsup=3Don requires support on the KVM
side");
> -        exit(EXIT_FAILURE);
> +
> +    if (s->xtsup) {
> +           if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +               error_report("AMD IOMMU xtsup=3Don requires support on th=
e
KVM side");
> +               exit(EXIT_FAILURE);
> +           }
>      }

Hmm, that does indeed appear to work, but it relies entirely on the call
site being optimised away by virtue of kvm_irqchip_is_split() being
#defined as 0 and triggering the short-circuit of the && operator at
compile time.
This seems rather fragile.


If kvm_enable_x2apic() needs to be used in code that's built on non-KVM
systems, you should really provide a version of it that returns an
appropriate value on such systems.

kvm_enable_x2apic() is declared in target/i386/kvm/kvm_i386.h

So, that's not a "public" cross-subsystem header in "include/=E2=80=A6", bu=
t it's
included from a file in hw/=E2=80=A6 - this already seems sub-optimal in it=
self.

Be that as it may, target/i386/kvm/kvm_i386.h already starts off with a
bunch of conditional declarations in #ifdef CONFIG_KVM =E2=80=A6 #else =E2=
=80=A6 #endif:

https://gitlab.com/qemu-project/qemu/-/blob/master/target/i386/kvm/kvm_i386=
.h#L27

Perhaps you could move the declaration inside the #ifdef CONFIG_KVM and
provide a
#define kvm_enable_x2apic() 0
for the #else case?


It looks like there are other callers of kvm_enable_x2apic() in the Intel
IOMMU and some common x86 code. They seem to rely on the same short-circuit
optimisation. If the code around those sites is correct *even when not
using KVM*, then I think the #define kvm_enable_x2apic() 0 approach would
be best.


I don't know the correct answer here though, and I can't gauge if the
calling code is correct. I'm no expert on IOMMUs nor on KVM, all I know is
this commit broke the build for me. :-)

>
>      pci_setup_iommu(bus, &amdvi_iommu_ops, s);
> -----
>
> Thank you!
> Santosh
>

--000000000000bb94db0626c925bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Santosh,<br><br>On Mon, 11 Nov 2024 at 06:39, Shukla, S=
antosh &lt;<a href=3D"mailto:santosh.shukla@amd.com">santosh.shukla@amd.com=
</a>&gt; wrote:<br>&gt;<br>&gt; Hi Phil,<br>&gt;<br>&gt; On 11/10/2024 4:36=
 PM, Phil Dennis-Jordan wrote:<br>&gt; &gt; Hi,<br>&gt; &gt;<br>&gt; &gt; T=
his commit seems to be causing link errors, likely on all platforms<br>&gt;=
 &gt; where KVM is not available, but at minimum that&#39;s what I&#39;m se=
eing when<br>&gt; &gt; trying to build the staging branch on macOS.<br>&gt;=
 &gt;<br>&gt; &gt; ld: Undefined symbols:<br>&gt; &gt; =C2=A0 _kvm_enable_x=
2apic, referenced from:<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 _amdvi_sysbus_rea=
lize in hw_i386_amd_iommu.c.o<br>&gt; &gt; clang: error: linker command fai=
led with exit code 1 (use -v to see invocation)<br>&gt; &gt;<br>&gt; &gt;<b=
r>&gt;<br>&gt; Hmm,.<br>&gt;<br>&gt; Thank you for reporting.<br>&gt;<br>&g=
t; &gt; On Mon, 4 Nov 2024 at 22:10, Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &=
gt;&gt; From: Suravee Suthikulpanit &lt;<a href=3D"mailto:suravee.suthikulp=
anit@amd.com">suravee.suthikulpanit@amd.com</a>&gt;<br>&gt; &gt;&gt;<br>&gt=
; &gt;&gt; The XTSup mode enables x2APIC support for AMD IOMMU, which is ne=
eded<br>&gt; &gt;&gt; to support vcpu w/ APIC ID &gt; 255.<br>&gt; &gt;&gt;=
<br>&gt; &gt;&gt; Reviewed-by: Alejandro Jimenez &lt;<a href=3D"mailto:alej=
andro.j.jimenez@oracle.com">alejandro.j.jimenez@oracle.com</a>&gt;<br>&gt; =
&gt;&gt; Signed-off-by: Suravee Suthikulpanit &lt;<a href=3D"mailto:suravee=
.suthikulpanit@amd.com">suravee.suthikulpanit@amd.com</a>&gt;<br>&gt; &gt;&=
gt; Signed-off-by: Santosh Shukla &lt;<a href=3D"mailto:santosh.shukla@amd.=
com">santosh.shukla@amd.com</a>&gt;<br>&gt; &gt;&gt; Message-Id: &lt;<a hre=
f=3D"mailto:20240927172913.121477-6-santosh.shukla@amd.com">20240927172913.=
121477-6-santosh.shukla@amd.com</a>&gt;<br>&gt; &gt;&gt; Reviewed-by: Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;<=
br>&gt; &gt;&gt; Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:ms=
t@redhat.com">mst@redhat.com</a>&gt;<br>&gt; &gt;&gt; ---<br>&gt; &gt;&gt; =
=C2=A0hw/i386/amd_iommu.c | 11 +++++++++++<br>&gt; &gt;&gt; =C2=A01 file ch=
anged, 11 insertions(+)<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; diff --git a/hw/i=
386/amd_iommu.c b/hw/i386/amd_iommu.c<br>&gt; &gt;&gt; index 38297376e7..13=
af7211e1 100644<br>&gt; &gt;&gt; --- a/hw/i386/amd_iommu.c<br>&gt; &gt;&gt;=
 +++ b/hw/i386/amd_iommu.c<br>&gt; &gt;&gt; @@ -32,6 +32,7 @@<br>&gt; &gt;&=
gt; =C2=A0#include &quot;trace.h&quot;<br>&gt; &gt;&gt; =C2=A0#include &quo=
t;hw/i386/apic-msidef.h&quot;<br>&gt; &gt;&gt; =C2=A0#include &quot;hw/qdev=
-properties.h&quot;<br>&gt; &gt;&gt; +#include &quot;kvm/kvm_i386.h&quot;<b=
r>&gt; &gt;&gt;<br>&gt; &gt;&gt; =C2=A0/* used AMD-Vi MMIO registers */<br>=
&gt; &gt;&gt; =C2=A0const char *amdvi_mmio_low[] =3D {<br>&gt; &gt;&gt; @@ =
-1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Erro=
r **errp)<br>&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_=
overlap(&amp;s-&gt;mr_sys, AMDVI_INT_ADDR_FIRST,<br>&gt; &gt;&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&g=
t;mr_ir, 1);<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; + =C2=A0 =C2=A0/* AMD IOMMU =
with x2APIC mode requires xtsup=3Don */<br>&gt; &gt;&gt; + =C2=A0 =C2=A0if =
(x86ms-&gt;apic_id_limit &gt; 255 &amp;&amp; !s-&gt;xtsup) {<br>&gt; &gt;&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;AMD IOMMU with x2APIC co=
nfguration requires xtsup=3Don&quot;);<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0exit(EXIT_FAILURE);<br>&gt; &gt;&gt; + =C2=A0 =C2=A0}<br>&gt; &gt=
;&gt; + =C2=A0 =C2=A0if (s-&gt;xtsup &amp;&amp; kvm_irqchip_is_split() &amp=
;&amp; !kvm_enable_x2apic()) {<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0error_report(&quot;AMD IOMMU xtsup=3Don requires support on the KVM side=
&quot;);<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<=
br>&gt; &gt;&gt; + =C2=A0 =C2=A0}<br>&gt; &gt;<br>&gt; &gt; I suspect this =
last if() { =E2=80=A6 } block should be wrapped in an #ifdef<br>&gt; &gt; C=
ONFIG_KVM block? I don&#39;t know anything about this code though, so if<br=
>&gt; &gt; this whole code path is generally a KVM-only feature, perhaps th=
e KVM<br>&gt; &gt; check should be implemented at the build system dependen=
cy level?<br>&gt; &gt;<br>&gt;<br>&gt; Could you please try below in your t=
arget system w/ clang and confirm back?<br>&gt;<br>&gt; -----<br>&gt; diff =
--git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c<br>&gt; index 13af7211e1.=
.7081d448e4 100644<br>&gt; --- a/hw/i386/amd_iommu.c<br>&gt; +++ b/hw/i386/=
amd_iommu.c<br>&gt; @@ -1657,9 +1657,12 @@ static void amdvi_sysbus_realize=
(DeviceState *dev, Error **errp)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
error_report(&quot;AMD IOMMU with x2APIC confguration requires xtsup=3Don&q=
uot;);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>&gt=
; =C2=A0 =C2=A0 =C2=A0}<br>&gt; - =C2=A0 =C2=A0if (s-&gt;xtsup &amp;&amp; k=
vm_irqchip_is_split() &amp;&amp; !kvm_enable_x2apic()) {<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0error_report(&quot;AMD IOMMU xtsup=3Don requires suppor=
t on the KVM side&quot;);<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FA=
ILURE);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (s-&gt;xtsup) {<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_irqchip_is_split() &amp;&amp; !kvm_=
enable_x2apic()) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 error_report(&quot;AMD IOMMU xtsup=3Don requires support on the KVM sid=
e&quot;);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(E=
XIT_FAILURE);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0=
 =C2=A0 =C2=A0}<br><br>Hmm, that does indeed appear to work, but it relies =
entirely on the call site being optimised away by virtue of kvm_irqchip_is_=
split() being #defined as 0 and triggering the short-circuit of the &amp;&a=
mp; operator at compile time.<br>This seems rather fragile.<br><br><br>If k=
vm_enable_x2apic() needs to be used in code that&#39;s built on non-KVM sys=
tems, you should really provide a version of it that returns an appropriate=
 value on such systems.<br><br>kvm_enable_x2apic() is declared in target/i3=
86/kvm/kvm_i386.h<br><br>So, that&#39;s not a &quot;public&quot; cross-subs=
ystem header in &quot;include/=E2=80=A6&quot;, but it&#39;s included from a=
 file in hw/=E2=80=A6 - this already seems sub-optimal in itself.<br><br>Be=
 that as it may, target/i386/kvm/kvm_i386.h already starts off with a bunch=
 of conditional declarations in #ifdef CONFIG_KVM =E2=80=A6 #else =E2=80=A6=
 #endif:<br><br><a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/mast=
er/target/i386/kvm/kvm_i386.h#L27">https://gitlab.com/qemu-project/qemu/-/b=
lob/master/target/i386/kvm/kvm_i386.h#L27</a><br><br>Perhaps you could move=
 the declaration inside the #ifdef CONFIG_KVM and provide a<br>#define kvm_=
enable_x2apic() 0<br>for the #else case?<br><br><br>It looks like there are=
 other callers of kvm_enable_x2apic() in the Intel IOMMU and some common x8=
6 code. They seem to rely on the same short-circuit optimisation. If the co=
de around those sites is correct <b>even when not using KVM</b>, then I thi=
nk the #define kvm_enable_x2apic() 0 approach would be best.<br>=C2=A0<br><=
br>I don&#39;t know the correct answer here though, and I can&#39;t gauge i=
f the calling code is correct. I&#39;m no expert on IOMMUs nor on KVM, all =
I know is this commit broke the build for me. :-)<br><br>&gt;<br>&gt; =C2=
=A0 =C2=A0 =C2=A0pci_setup_iommu(bus, &amp;amdvi_iommu_ops, s);<br>&gt; ---=
--<br>&gt;<br>&gt; Thank you!<br>&gt; Santosh<br>&gt;</div>

--000000000000bb94db0626c925bb--

