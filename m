Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F941C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 00:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhIar-0002f4-KT; Mon, 04 Mar 2024 19:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rhIap-0002eg-Op
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 19:23:39 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rhIan-0007fH-H2
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 19:23:39 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so283069266b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 16:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1709598214; x=1710203014; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xb4QJtvJ1KYOzTPpyh5Bw6iSo6F2yRhSe0xWbMO0uvE=;
 b=aN/2A93Y48nCpbZgOgBGwheNJUjTNYQYwoo5cGFaXX+gK5G6U2i9ldoTmIaOyn57FF
 pUOEPWXuLpAguLJcO63ueFXNm/y1LcQf0t7QUMf5xNx447hN+UVcNwuc+4src08eW9bS
 WDPh0CzfhRI544MPW+6PYaV0CmQhu+Gna7pqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709598214; x=1710203014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xb4QJtvJ1KYOzTPpyh5Bw6iSo6F2yRhSe0xWbMO0uvE=;
 b=PI7sbIzcgeusAefIf+UY+g9wcp7bEnsOA5g3UogrxcFFraYQQTx6gF8KYu4yD9aDMQ
 BCxiPiRCxaVG80LO4YoEmkFMp6BoTT5kEXeAMey09wOsK95ZrznSfNKgScd/crCdy2FQ
 uCMQGyrc/rS9IQd6YNyHJ8takVI8IEC15s9zX7YmtqBGhl4aCjQsXfiBJ/ru0ombSqNH
 K27npFor464WfdkAhZoeq90Qs8X2lhenS+m6+k45eko7olgIp90eKmG7Vg3V9ShGIl/O
 67T3eJ0gpooTE4ScSv7hQSPm2l9FMVdysoENTZ6UlLVAE8Xqt47fp7tBSltSzK42NeKy
 DXlg==
X-Gm-Message-State: AOJu0YzOyVY5XxKcVGrAeZQfGdLttNJNyz7zO+Vt4Y+OjY14Ud3+wxf2
 Abqerv5+ea7TZ5H4sV1UiTXgKWiS6I3sLpGmrtyjzrrSrkvQd8He3cLkQ0LN9tmmo/q3PaKtuP4
 tZA==
X-Google-Smtp-Source: AGHT+IEHaA0564AIK7EyymX6MuiZy6V7ZD3VEXOXqAZ467cCDNwkU0PP0fyr9YKZN35I/0JLtHve9A==
X-Received: by 2002:a17:906:894:b0:a45:5371:f0d6 with SMTP id
 n20-20020a170906089400b00a455371f0d6mr2453089eje.61.1709598214372; 
 Mon, 04 Mar 2024 16:23:34 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com.
 [209.85.208.53]) by smtp.gmail.com with ESMTPSA id
 gt25-20020a170906f21900b00a3ec216ec6csm5352047ejb.45.2024.03.04.16.23.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 16:23:33 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-566b160f6eeso3266a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 16:23:33 -0800 (PST)
X-Received: by 2002:aa7:de04:0:b0:566:e8fc:8f83 with SMTP id
 h4-20020aa7de04000000b00566e8fc8f83mr20835edv.7.1709598213628; Mon, 04 Mar
 2024 16:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
 <87cytwnqoj.fsf@alyssa.is>
 <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
 <87msssmax4.fsf@alyssa.is>
 <CAAfnVBm--wu3=ES0tY2JPXwm+Ga-tRLq=EpkZdzdVoHGUfb2KQ@mail.gmail.com>
 <CAAfnVBkk1QTAo4dT372QNFmWqFFG4TxM0OTv9XHQQf6fm11fag@mail.gmail.com>
 <ufctubdq3cyltmtgwc4ng2dn6akazaybqvz5f5a6pyvgwmsxw2@3kapq5mvvy7l>
In-Reply-To: <ufctubdq3cyltmtgwc4ng2dn6akazaybqvz5f5a6pyvgwmsxw2@3kapq5mvvy7l>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 4 Mar 2024 16:23:20 -0800
X-Gmail-Original-Message-ID: <CAAfnVBnN3jnnyszxRW4YH=39SHK=hji6RqhXAYwHEMw-pnRevw@mail.gmail.com>
Message-ID: <CAAfnVBnN3jnnyszxRW4YH=39SHK=hji6RqhXAYwHEMw-pnRevw@mail.gmail.com>
Subject: Re: rutabaga 0.1.3
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com, 
 Andrew Walbran <qwandor@google.com>, Frederick Mayle <fmayle@google.com>
Content-Type: multipart/alternative; boundary="0000000000003bbd0c0612deda70"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000003bbd0c0612deda70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 6:38=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:

> Hi Gurchetan,
>
> > >> > Would this be a suitable commit for the 0.1.3 release of rutabaga?
> > >> >
> > >> >
> https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf441=
38def886f47cb1c7c
> > >> >
> > >> > The gfxstream/AEMU commits would remain unchanged.
> > >>
> > >> That combination works for me.
> > >
> > > Just FYI, still working on it.  Could take 1-2 more weeks.
> >
> > FYI:
> >
> >
> https://android.googlesource.com/platform/hardware/google/gfxstream/+/ref=
s/tags/v0.1.2-gfxstream-release
> >
> >
> https://android.googlesource.com/platform/hardware/google/aemu/+/refs/tag=
s/v0.1.2-aemu-release
> >
> >
> https://chromium.googlesource.com/crosvm/crosvm/+/refs/tags/v0.1.3-rutaba=
ga-release
>
> Unlike the commit I tested for you, the commit that ended up being
> tagged as v0.1.3-rutabaga-release doesn't work for me:
>
>         qemu: The errno is EBADF: Bad file number
>         qemu: CHECK failed in rutabaga_cmd_resource_map_blob()
> ../hw/display/virtio-gpu-rutabaga.c:655
>         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
>         qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob()
> ../hw/display/virtio-gpu-rutabaga.c:723
>         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
>         qemu: The errno is EBADF: Bad file number
>         qemu: CHECK failed in rutabaga_cmd_resource_map_blob()
> ../hw/display/virtio-gpu-rutabaga.c:655
>         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
>         qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob()
> ../hw/display/virtio-gpu-rutabaga.c:723
>         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
>         qemu: The errno is EBADF: Bad file number
>         qemu: CHECK failed in rutabaga_cmd_resource_map_blob()
> ../hw/display/virtio-gpu-rutabaga.c:655
>         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
>         qemu: invalid resource id
>         qemu: CHECK failed in rutabaga_cmd_submit_3d()
> ../hw/display/virtio-gpu-rutabaga.c:341
>         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x207, error 0x1200
>         qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob()
> ../hw/display/virtio-gpu-rutabaga.c:723
>         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
>

Thank you for the bug report .. does crrev.com/c/5342655 fix this for you?


I bisected it to:
>
>         commit f3dbf20eedadb135e2fd813474fbb9731d465f3a
>         Author: Andrew Walbran <qwandor@google.com>
>         Date:   Wed Nov 29 17:23:45 2023 +0000
>
>             rutabaga_gfx: Uprev nix to 0.27.1
>
>             The new version of nix uses OwnedFd in various places, which
> allows us
>             to have less unsafe code.
>
>             TEST=3DCQ
>             BUG=3Db:293289578
>
>             Change-Id: I61aa80c4105eaf1182c5c325109b5aba11cf60de
>             Reviewed-on:
> https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5072293
>             Auto-Submit: Andrew Walbran <qwandor@google.com>
>             Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
>             Reviewed-by: Frederick Mayle <fmayle@google.com>
>             Commit-Queue: Frederick Mayle <fmayle@google.com>
>

--0000000000003bbd0c0612deda70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 2, 2024 at 6:38=E2=80=AFA=
M Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Gurchetan,=
<br>
<br>
&gt; &gt;&gt; &gt; Would this be a suitable commit for the 0.1.3 release of=
 rutabaga?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; <a href=3D"https://chromium.googlesource.com/crosvm/cros=
vm/+/5dfd74a0680d317c6edf44138def886f47cb1c7c" rel=3D"noreferrer" target=3D=
"_blank">https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c=
6edf44138def886f47cb1c7c</a><br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The gfxstream/AEMU commits would remain unchanged.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; That combination works for me.<br>
&gt; &gt;<br>
&gt; &gt; Just FYI, still working on it.=C2=A0 Could take 1-2 more weeks.<b=
r>
&gt;<br>
&gt; FYI:<br>
&gt;<br>
&gt; <a href=3D"https://android.googlesource.com/platform/hardware/google/g=
fxstream/+/refs/tags/v0.1.2-gfxstream-release" rel=3D"noreferrer" target=3D=
"_blank">https://android.googlesource.com/platform/hardware/google/gfxstrea=
m/+/refs/tags/v0.1.2-gfxstream-release</a><br>
&gt;<br>
&gt; <a href=3D"https://android.googlesource.com/platform/hardware/google/a=
emu/+/refs/tags/v0.1.2-aemu-release" rel=3D"noreferrer" target=3D"_blank">h=
ttps://android.googlesource.com/platform/hardware/google/aemu/+/refs/tags/v=
0.1.2-aemu-release</a><br>
&gt;<br>
&gt; <a href=3D"https://chromium.googlesource.com/crosvm/crosvm/+/refs/tags=
/v0.1.3-rutabaga-release" rel=3D"noreferrer" target=3D"_blank">https://chro=
mium.googlesource.com/crosvm/crosvm/+/refs/tags/v0.1.3-rutabaga-release</a>=
<br>
<br>
Unlike the commit I tested for you, the commit that ended up being<br>
tagged as v0.1.3-rutabaga-release doesn&#39;t work for me:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: The errno is EBADF: Bad file number<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: CHECK failed in rutabaga_cmd_resource_map=
_blob() ../hw/display/virtio-gpu-rutabaga.c:655<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x2=
08, error 0x1200<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: CHECK failed in rutabaga_cmd_resource_unm=
ap_blob() ../hw/display/virtio-gpu-rutabaga.c:723<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x2=
09, error 0x1200<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: The errno is EBADF: Bad file number<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: CHECK failed in rutabaga_cmd_resource_map=
_blob() ../hw/display/virtio-gpu-rutabaga.c:655<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x2=
08, error 0x1200<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: CHECK failed in rutabaga_cmd_resource_unm=
ap_blob() ../hw/display/virtio-gpu-rutabaga.c:723<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x2=
09, error 0x1200<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: The errno is EBADF: Bad file number<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: CHECK failed in rutabaga_cmd_resource_map=
_blob() ../hw/display/virtio-gpu-rutabaga.c:655<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x2=
08, error 0x1200<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: invalid resource id<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: CHECK failed in rutabaga_cmd_submit_3d() =
../hw/display/virtio-gpu-rutabaga.c:341<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x2=
07, error 0x1200<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: CHECK failed in rutabaga_cmd_resource_unm=
ap_blob() ../hw/display/virtio-gpu-rutabaga.c:723<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x2=
09, error 0x1200<br>
</blockquote><div><br></div><div>Thank you for the bug report .. does <a hr=
ef=3D"http://crrev.com/c/5342655">crrev.com/c/5342655</a> fix this for you?=
=C2=A0<br></div><div><br></div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
I bisected it to:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 commit f3dbf20eedadb135e2fd813474fbb9731d465f3a=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Author: Andrew Walbran &lt;<a href=3D"mailto:qw=
andor@google.com" target=3D"_blank">qwandor@google.com</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Date:=C2=A0 =C2=A0Wed Nov 29 17:23:45 2023 +000=
0<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rutabaga_gfx: Uprev nix to 0.27.1=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The new version of nix uses Owned=
Fd in various places, which allows us<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to have less unsafe code.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST=3DCQ<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG=3Db:293289578<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Change-Id: I61aa80c4105eaf1182c5c=
325109b5aba11cf60de<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Reviewed-on: <a href=3D"https://c=
hromium-review.googlesource.com/c/crosvm/crosvm/+/5072293" rel=3D"noreferre=
r" target=3D"_blank">https://chromium-review.googlesource.com/c/crosvm/cros=
vm/+/5072293</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Auto-Submit: Andrew Walbran &lt;<=
a href=3D"mailto:qwandor@google.com" target=3D"_blank">qwandor@google.com</=
a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Reviewed-by: Gurchetan Singh &lt;=
<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurchetans=
ingh@chromium.org</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Reviewed-by: Frederick Mayle &lt;=
<a href=3D"mailto:fmayle@google.com" target=3D"_blank">fmayle@google.com</a=
>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Commit-Queue: Frederick Mayle &lt=
;<a href=3D"mailto:fmayle@google.com" target=3D"_blank">fmayle@google.com</=
a>&gt;<br>
</blockquote></div></div>

--0000000000003bbd0c0612deda70--

