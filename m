Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA5FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHepM-0005AT-HF; Wed, 21 May 2025 04:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHepK-00059i-KA; Wed, 21 May 2025 04:29:26 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHepG-0001bf-95; Wed, 21 May 2025 04:29:26 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b26f67f10ddso3624977a12.3; 
 Wed, 21 May 2025 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747816157; x=1748420957; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Yq/HLt0u14BIYiMVeYiqtquSRLg0l668z+sdOxNc1o=;
 b=fo1SBL2RN5PWyL57nKAzy6mrlXOsXnx7LyzkPHwKoBT36wlDaHnw3K90mFiXyAElbH
 o12DaqaIuIrvgXg6ntFWeCIqh7oQ0gRP1CRtc/+aowFdUnAFnD9M5ldAr13doyaQPQ6P
 r17MM2dYzcV385QFgyyIFobpV2IMMDL6vrceh1ylTC1gLRnJPpPcVJGwMzab2DSFnBNK
 3dwOT3EXAVED4PuK9AmVtjyffk66bvheA3v8jHtkwTdJGe9zKxCYzArcxn/kuinTbXb6
 AwRS1Fkfwx2P60uta4/YvzhoINFf8FJlgsIbJnUnXu4LcnkAiT3dLL+wU+osYmOEPCXy
 pqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747816157; x=1748420957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Yq/HLt0u14BIYiMVeYiqtquSRLg0l668z+sdOxNc1o=;
 b=G0vkKJbd/mEiIf2AuGOsYcpqGoZRNyZ08q9S2Dhn1n8dyv4L/hUmru1Lyp/cT0/d0P
 CoMQ0IyHwGIP3dB4PKq0CmYD7PYYEDx1gv8p9hfDWMc/D03K+/Rfl65p9GxI7SG08WNx
 q7x7BVcBPv8vxfWtt/UgD/gqQE6xR95Pt2qkOrpvVia5g1Lh8LNbrJ5Y4z+HYDfqefZU
 yl0OQILF9pX+3hGuQZvbOEdFMFjXgaTUVjARPnWszQjHSF5Y6s3cU0XqcvrN9dcQQq7O
 4m47n8sc4LJmIR0qpqSpFrRV/GrS3CawZmP0Tk8rSSV4HU62ZtC1aAECesV5lPSVFoST
 /DGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4QhMLCNuBUpQqsV9DuyysQNXnenKLEyyu7QOFjR6P+nIzfMeKNkRf9UoNwxSkY2bsEgmZ2jZmsKHaEA==@nongnu.org,
 AJvYcCVrqMXH4oPOr5T0xLqOFt/eKoD0ZcvnzF9IXvai8JGaeAiT8p9FS4+o+jFdyBYiWXAQWYZIG4wRZJRINg==@nongnu.org,
 AJvYcCWmFqM5rV9gJWza6omCjzoMjCd/QXO4ZgTb0XAojyik8bw3GjHOx3R+/GzEM728H0tB44w+zUz3zg==@nongnu.org
X-Gm-Message-State: AOJu0YzNOXa/SDkiLZjgcRXJN+IA17nYYQbYAjz+f+ih5gVTD3DoLBPR
 igThEQKlD9t/j6R1GmgGJ/jlcfNxgpAkmZOJowWnY8sOTLSIzIJRYzCOrgKPEvWClq1zPhES31l
 52nN6rU/Rf6uuPCnb9K2WO/7I07Dap4Q=
X-Gm-Gg: ASbGncvGBrROa/o7NloJbXpbDdl1MHI9qoivzi7uKkPPCYpe6sr2p5DgWvTFuCQpKbT
 wGf3X3raEQrgHDHTwanhuS7BNbbbKtI2S680+4iSOVdxy/jilei/s2pB9NiOOabjvbTWVbBCDQC
 PvVrbwEFhmPDvXVUpEmAPIjeRSJb3w4dnjFP4euOIHW2trkNku+uHkK4Yy0JBdwS0=
X-Google-Smtp-Source: AGHT+IEUh3uoaveZbpcJPUlHTxMxs7OkktAMIfznj5fp70O+RYxcRAtZuaoB5EIpvZT5hUNQ7guv3tzIEtG1/4ORiHc=
X-Received: by 2002:a17:903:2284:b0:22f:b25b:8e93 with SMTP id
 d9443c01a7336-231de3b9f2cmr296656725ad.48.1747816157263; Wed, 21 May 2025
 01:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
 <d3e7e584cf61c76952f4c9d913ba80d905c80e76.1747744132.git.ktokunaga.mail@gmail.com>
 <5d54270a-51be-4462-a02d-a12432e42be4@redhat.com>
In-Reply-To: <5d54270a-51be-4462-a02d-a12432e42be4@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 21 May 2025 17:29:05 +0900
X-Gm-Features: AX0GCFtHiLrQRJyVIZfjX9qmk5k560ZlxcMBQ7lCVV5Zt-BYXWrNvzA8wIBXYI0
Message-ID: <CAEDrbUYGOfY5EPB2g-+VxFYhwrNUFKsGR8Lm4dxML0HwsAD_3A@mail.gmail.com>
Subject: Re: [PATCH 23/33] include/exec: Allow using 64bit guest addresses on
 emscripten
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002fbbd40635a1292d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
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

--0000000000002fbbd40635a1292d
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> On 5/20/25 14:51, Kohei Tokunaga wrote:
> >     target_kconfig = []
> >     foreach sym: accelerators
> > -    # Disallow 64-bit on 32-bit emulation and virtualization
> > -    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
> > -      continue
> > +    if host_arch != 'wasm32'
> > +      # Disallow 64-bit on 32-bit emulation and virtualization
> > +      if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
> > +        continue
> > +      endif
> >       endif
> >       if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym,
[])
> >         config_target += { sym: 'y' }
>
> I'd prefer something like
>
> # Detect host pointer size for the target configuration loop.
> host_long_bits = cc.sizeof('void *') * 8
> tcg_vaddr_bits = host_arch == 'wasm32' ? 64 : host_long_bits
> ...
> config_host_data.set('TCG_VADDR_BITS', tcg_vaddr_bits)
>
> Then in the target configuration loop
>
> -    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
> +    if tcg_vaddr_bits < config_target['TARGET_LONG_BITS'].to_int()
>
> and throughout the code you can have
>
> #ifdef TCG_VADDR_BITS == 32
> ...
> #else
> ...
> #endif
>
> instead of
>
> #ifdef EMSCRIPTEN
> ...
> #else
> ...
> #endif
>
> In fact, I think this patch would be acceptable as a separate
> submission, because it could be tested using TCI already.

Thank you for the feedback. I'll work on implementing this using
TCG_VADDR_BITS and submit it as a separated series.

--0000000000002fbbd40635a1292d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo,<br><br>&gt; On 5/20/25 14:51, K=
ohei Tokunaga wrote:<br>&gt; &gt; =C2=A0 =C2=A0 target_kconfig =3D []<br>&g=
t; &gt; =C2=A0 =C2=A0 foreach sym: accelerators<br>&gt; &gt; - =C2=A0 =C2=
=A0# Disallow 64-bit on 32-bit emulation and virtualization<br>&gt; &gt; - =
=C2=A0 =C2=A0if host_long_bits &lt; config_target[&#39;TARGET_LONG_BITS&#39=
;].to_int()<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0continue<br>&gt; &gt; + =C2=
=A0 =C2=A0if host_arch !=3D &#39;wasm32&#39;<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0# Disallow 64-bit on 32-bit emulation and virtualization<br>&gt; &gt;=
 + =C2=A0 =C2=A0 =C2=A0if host_long_bits &lt; config_target[&#39;TARGET_LON=
G_BITS&#39;].to_int()<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br=
>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 en=
dif<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 if sym =3D=3D &#39;CONFIG_TCG&#39; or=
 target in accelerator_targets.get(sym, [])<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 config_target +=3D { sym: &#39;y&#39; }<br>&gt; <br>&gt; I&#39;d=
 prefer something like<br>&gt; <br>&gt; # Detect host pointer size for the =
target configuration loop.<br>&gt; host_long_bits =3D cc.sizeof(&#39;void *=
&#39;) * 8<br>&gt; tcg_vaddr_bits =3D host_arch =3D=3D &#39;wasm32&#39; ? 6=
4 : host_long_bits<br>&gt; ...<br>&gt; config_host_data.set(&#39;TCG_VADDR_=
BITS&#39;, tcg_vaddr_bits)<br>&gt; <br>&gt; Then in the target configuratio=
n loop<br>&gt; <br>&gt; - =C2=A0 =C2=A0if host_long_bits &lt; config_target=
[&#39;TARGET_LONG_BITS&#39;].to_int()<br>&gt; + =C2=A0 =C2=A0if tcg_vaddr_b=
its &lt; config_target[&#39;TARGET_LONG_BITS&#39;].to_int()<br>&gt; <br>&gt=
; and throughout the code you can have<br>&gt; <br>&gt; #ifdef TCG_VADDR_BI=
TS =3D=3D 32<br>&gt; ...<br>&gt; #else<br>&gt; ...<br>&gt; #endif<br>&gt; <=
br>&gt; instead of<br>&gt; <br>&gt; #ifdef EMSCRIPTEN<br>&gt; ...<br>&gt; #=
else<br>&gt; ...<br>&gt; #endif<br>&gt; <br>&gt; In fact, I think this patc=
h would be acceptable as a separate<br>&gt; submission, because it could be=
 tested using TCI already.<br><br>Thank you for the feedback. I&#39;ll work=
 on implementing this using<br>TCG_VADDR_BITS and submit it as a separated =
series.</div></div>

--0000000000002fbbd40635a1292d--

