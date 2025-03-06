Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA07C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpysI-0003lj-7S; Wed, 05 Mar 2025 19:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tpysG-0003lY-Uo
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:14:04 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tpysA-0007bh-4Z
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:14:04 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e4b410e48bso68456a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741220036; x=1741824836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=41Jh2PhIyYCNxRiATCApNqTXto276bZ6p7bfaH56Uuw=;
 b=KURkm0GOdxp1K/2Pf+yFI2nDm/Hu7e847GpO3pW6DIUugCwxehgf+b3haVLrTnQ2Kb
 mgtmXLwjFxAqyOVbHNGM1wHXWM+HX95v7zKvfTONcHBsFHiUCBDRTAhSry3jJIc0bo+w
 pvhU/aQ6GBqfbLUPu2JQJxha+BdMzV7L6zbCvVH9Mn5YVPz+KWyMI/w+f49JhAZYAHiA
 iFJtURURO4enGAaaksGH/Y2i5ymfhizcj4SXNsL92rfxJ+i7gcHSvl0ZviuLulBz6Gxg
 Qh8Av0mtrfISy4bFPrLcGMP82UNjFpoD4ZJB6XifZoeFIbY8QPv1Hm4vxU7tqUWipxp0
 3G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220036; x=1741824836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=41Jh2PhIyYCNxRiATCApNqTXto276bZ6p7bfaH56Uuw=;
 b=LfeqK9D/z2DUjI+DI3HU3ZxEjSwH7xcBOGL78/+CMmMp8iHIvOz3NqHGbnJKN2cfEc
 zuCNxaP50aAOEqcG1iCDY16kwKmVr70LyutM6I7B1zdQ/uFiKcowpvP8PDMs/SBCwyCL
 e2RwTQgHAKzaDZltz6465jB3BioHq3NYo++m+f5MN2n8uHTWA0ztGKbKybzt6BWjsNMq
 4FkkqqvUX1Hs+XIe2z7/dw8/U4dX64jpbZX/dvhjK0m6JfgFoFa6xHjVkwjgf/W6B9tT
 7UWTqyxsK9ivRPFNo9UzbNUazGgaQ4ibvihZKG/5Nz3kmTJac6o6Z6s5LbqhY/ul5CWS
 YiOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgysP5ZAtsjkL2b4MWM932f1Lvjdls45acJ4ydyqBeOM00rWl40i6XwIZTNq0UN52rnLtcnxn0HdlG@nongnu.org
X-Gm-Message-State: AOJu0YweEeeadkQXR9AK+AruTeifpspR7pkdMcHZbmdsqW2fflQVtuL2
 bAUyjQJDYJBeNqlahorXoHJwXMpnsKazT5n+813tizWcEhtRdLl6DHZelNOOCcv1r+djRayEZyH
 HNPyN117/k1ZDJuiruyZZZma9vCY=
X-Gm-Gg: ASbGncvbXi+b84/IQ9T4XxrT8c/Yx9cCaBuOumw+DgD7rDlOJbdmhxZhcw5I6KIg89q
 wJIv7Cm1iZ700ripjJCz288+cKjOHFOvAzN6OSFzFXFUVM+QuTCfMNxNh84Naxe6q19/Si6f7AT
 NRvROFOXl5yumK8Abw6ZKwI4JrIA==
X-Google-Smtp-Source: AGHT+IE3xX5ZPUdyfBCVy/jxUf6eBtw2bosoPlZM/4noyX+SSYZTKgEnpv/qdStw/GlzbGgxlr+T96qyz49SDJdFDF8=
X-Received: by 2002:a05:6402:90c:b0:5e5:3a51:f23b with SMTP id
 4fb4d7f45d1cf-5e59f3c1e2amr4808038a12.13.1741220035542; Wed, 05 Mar 2025
 16:13:55 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
 <20230615235254.1366267-9-sstabellini@kernel.org>
 <a0982117-5602-49ee-9e0c-ef2f7c716e7b@linaro.org>
 <alpine.DEB.2.22.394.2503051519550.1303386@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2503051519550.1303386@ubuntu-linux-20-04-desktop>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 5 Mar 2025 18:13:43 -0600
X-Gm-Features: AQ5f1JpUjbbjfz4zDHABCyfv6UTJ_jL9Oj1MBdTy7SLPxMfaJs08zygEKS-w4_A
Message-ID: <CAJy5ezrx8mYWfE1Ty16g-Do9-itWN2qn36pqM9u0mNDw5SbaLw@mail.gmail.com>
Subject: Re: [PULL v5 09/11] hw/arm: introduce xenpvh machine
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 peter.maydell@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 vikram.garhwal@amd.com, Stefano Stabellini <stefano.stabellini@amd.com>,
 Edgar.Iglesias@amd.com
Content-Type: multipart/alternative; boundary="000000000000b1c971062fa16167"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52d.google.com
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

--000000000000b1c971062fa16167
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:22=E2=80=AFPM Stefano Stabellini <sstabellini@kern=
el.org>
wrote:

> +Edgar
>
> On Wed, 5 Mar 2025, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 16/6/23 01:52, Stefano Stabellini wrote:
> > > From: Vikram Garhwal <vikram.garhwal@amd.com>
> > >
> > > Add a new machine xenpvh which creates a IOREQ server to
> register/connect
> > > with
> > > Xen Hypervisor.
> > >
> > > Optional: When CONFIG_TPM is enabled, it also creates a
> tpm-tis-device, adds
> > > a
> > > TPM emulator and connects to swtpm running on host machine via charde=
v
> > > socket
> > > and support TPM functionalities for a guest domain.
> > >
> > > Extra command line for aarch64 xenpvh QEMU to connect to swtpm:
> > >      -chardev socket,id=3Dchrtpm,path=3D/tmp/myvtpm2/swtpm-sock \
> > >      -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> > >      -machine tpm-base-addr=3D0x0c000000 \
> > >
> > > swtpm implements a TPM software emulator(TPM 1.2 & TPM 2) built on
> libtpms
> > > and
> > > provides access to TPM functionality over socket, chardev and CUSE
> > > interface.
> > > Github repo: https://github.com/stefanberger/swtpm
> > > Example for starting swtpm on host machine:
> > >      mkdir /tmp/vtpm2
> > >      swtpm socket --tpmstate dir=3D/tmp/vtpm2 \
> > >      --ctrl type=3Dunixio,path=3D/tmp/vtpm2/swtpm-sock &
> > >
> > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
> > > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > > ---
> > >   docs/system/arm/xenpvh.rst    |  34 +++++++
> > >   docs/system/target-arm.rst    |   1 +
> > >   hw/arm/meson.build            |   2 +
> > >   hw/arm/xen_arm.c              | 181
> ++++++++++++++++++++++++++++++++++
> > >   include/hw/arm/xen_arch_hvm.h |   9 ++
> > >   include/hw/xen/arch_hvm.h     |   2 +
> > >   6 files changed, 229 insertions(+)
> > >   create mode 100644 docs/system/arm/xenpvh.rst
> > >   create mode 100644 hw/arm/xen_arm.c
> > >   create mode 100644 include/hw/arm/xen_arch_hvm.h
> >
> >
> > > diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
> > > index 26674648d8..c7c515220d 100644
> > > --- a/include/hw/xen/arch_hvm.h
> > > +++ b/include/hw/xen/arch_hvm.h
> > > @@ -1,3 +1,5 @@
> > >   #if defined(TARGET_I386) || defined(TARGET_X86_64)
> > >   #include "hw/i386/xen_arch_hvm.h"
> > > +#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
> >
> > I suppose this is a typo and you meant TARGET_AARCH64 :)
> > Luckily TARGET_AARCH64 defines TARGET_ARM.
>
> Hi Philippe, it looks like this is an older patch.
>
> Edgar, is this patch still valid?


Hi,

Yes, I think Phil is right, this works by luck and should have been
TARGET_AARCH64.
Phil, will you send a patch?

Best regards,
Edgar

--000000000000b1c971062fa16167
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, 2025=
 at 5:22=E2=80=AFPM Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@ke=
rnel.org">sstabellini@kernel.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">+Edgar<br>
<br>
On Wed, 5 Mar 2025, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; On 16/6/23 01:52, Stefano Stabellini wrote:<br>
&gt; &gt; From: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com=
" target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; Add a new machine xenpvh which creates a IOREQ server to register=
/connect<br>
&gt; &gt; with<br>
&gt; &gt; Xen Hypervisor.<br>
&gt; &gt; <br>
&gt; &gt; Optional: When CONFIG_TPM is enabled, it also creates a tpm-tis-d=
evice, adds<br>
&gt; &gt; a<br>
&gt; &gt; TPM emulator and connects to swtpm running on host machine via ch=
ardev<br>
&gt; &gt; socket<br>
&gt; &gt; and support TPM functionalities for a guest domain.<br>
&gt; &gt; <br>
&gt; &gt; Extra command line for aarch64 xenpvh QEMU to connect to swtpm:<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 -chardev socket,id=3Dchrtpm,path=3D/tmp/myvtp=
m2/swtpm-sock \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 -machine tpm-base-addr=3D0x0c000000 \<br>
&gt; &gt; <br>
&gt; &gt; swtpm implements a TPM software emulator(TPM 1.2 &amp; TPM 2) bui=
lt on libtpms<br>
&gt; &gt; and<br>
&gt; &gt; provides access to TPM functionality over socket, chardev and CUS=
E<br>
&gt; &gt; interface.<br>
&gt; &gt; Github repo: <a href=3D"https://github.com/stefanberger/swtpm" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/stefanberger/swtpm</a=
><br>
&gt; &gt; Example for starting swtpm on host machine:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 mkdir /tmp/vtpm2<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 swtpm socket --tpmstate dir=3D/tmp/vtpm2 \<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 --ctrl type=3Dunixio,path=3D/tmp/vtpm2/swtpm-=
sock &amp;<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwa=
l@amd.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Stefano Stabellini &lt;<a href=3D"mailto:stefano.s=
tabellini@amd.com" target=3D"_blank">stefano.stabellini@amd.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini=
@kernel.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0docs/system/arm/xenpvh.rst=C2=A0 =C2=A0 |=C2=A0 34 ++=
+++++<br>
&gt; &gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 +<br>
&gt; &gt;=C2=A0 =C2=A0hw/arm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +<br>
&gt; &gt;=C2=A0 =C2=A0hw/arm/xen_arm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 181 ++++++++++++++++++++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0include/hw/arm/xen_arch_hvm.h |=C2=A0 =C2=A09 ++<br>
&gt; &gt;=C2=A0 =C2=A0include/hw/xen/arch_hvm.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A02 +<br>
&gt; &gt;=C2=A0 =C2=A06 files changed, 229 insertions(+)<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 docs/system/arm/xenpvh.rst<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 hw/arm/xen_arm.c<br>
&gt; &gt;=C2=A0 =C2=A0create mode 100644 include/hw/arm/xen_arch_hvm.h<br>
&gt; <br>
&gt; <br>
&gt; &gt; diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.=
h<br>
&gt; &gt; index 26674648d8..c7c515220d 100644<br>
&gt; &gt; --- a/include/hw/xen/arch_hvm.h<br>
&gt; &gt; +++ b/include/hw/xen/arch_hvm.h<br>
&gt; &gt; @@ -1,3 +1,5 @@<br>
&gt; &gt;=C2=A0 =C2=A0#if defined(TARGET_I386) || defined(TARGET_X86_64)<br=
>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/i386/xen_arch_hvm.h&quot;<br>
&gt; &gt; +#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)<br>
&gt; <br>
&gt; I suppose this is a typo and you meant TARGET_AARCH64 :)<br>
&gt; Luckily TARGET_AARCH64 defines TARGET_ARM.<br>
<br>
Hi Philippe, it looks like this is an older patch.<br>
<br>
Edgar, is this patch still valid?</blockquote><div><br></div><div>Hi,</div>=
<div><br></div><div>Yes, I think Phil is right, this works by luck and shou=
ld have been TARGET_AARCH64.</div><div>Phil, will you send a patch?</div><d=
iv><br></div><div>Best regards,</div><div>Edgar</div></div></div>

--000000000000b1c971062fa16167--

