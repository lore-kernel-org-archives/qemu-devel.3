Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F02C54FC6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 14:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIq6P-0005nd-CN; Sat, 24 May 2025 10:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uIq6D-0005lT-3W
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uIq6A-00083e-CT
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748097819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6J+priNGe2NN21HW8HYtdsRYNH2qk+iZOUEacs45wc=;
 b=E2P/SnG58OD9avw6XPkBpJXlHdztHRV+P+URG6aHSH1VpKUreF2ht8+DrfGzQO1PtgizES
 ZKrF2LzIgcfxQOLkJ+CTfG5pieHQ/PuHVE5Jx6UQwRerA0C8W8VxInxYGJhjurN8+kNsA+
 UtX0FhNRDjLO6BQEs/7gXZL4J4fr1k0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-IE6PaCQPN7WiXXei5JlMhA-1; Sat, 24 May 2025 10:43:37 -0400
X-MC-Unique: IE6PaCQPN7WiXXei5JlMhA-1
X-Mimecast-MFC-AGG-ID: IE6PaCQPN7WiXXei5JlMhA_1748097817
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4768f9fea35so22391541cf.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 07:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097817; x=1748702617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6J+priNGe2NN21HW8HYtdsRYNH2qk+iZOUEacs45wc=;
 b=HaMXKivj4Qmi5FaXBYFznrZtbhcvxAC1o+NtM3XV7/HvYWSEA5Zggsl72MbRMxaKL8
 ipmJhk8WriLnEIr3owmFpyymi7PEx5BW7NLQJ3iwubCV4+UVEZjMdk7sO7seJmmgTqCH
 nsb3h3AI+mnnXsmI4H8zaTAfnjF1+5QA7z+KEC0Pdex1G6D1cmqmC+cLA8pNKiEmkOZr
 QmBSbmEHUzWPg2GLHGSF19toUgZ21ONk8SNzucGe4nr5EYNpUaPpdm11OtkCoHz5jkYt
 ckt5Xt9WLpo7qIaXLrMtHLkORsUwGFXWZiZxBECAiSRwc6PQIeKYVI9apqIqoSkmy+vn
 cvfQ==
X-Gm-Message-State: AOJu0YwRVBZR9nNpERwICTOsIAe84CDdhTSFfTxsTq4kMVlsYR3x6ToU
 xrdUfJPtffP4ur4SB/7diD9o4rzRie2NMMHLGHcOoutMQee6LNIvhDPyQXAz3jczeMngQ3aRX04
 52xhWECYnSdfBP6Av00afkEYr8Zy/k9hwcp3J3QdEAFDOC4OzuooI1k2wKbeb06C5w5ov8xeo12
 yvacC33l+jloEdxoxLGO+kEOuFEDOVFHE=
X-Gm-Gg: ASbGnctXN2ZyeCYYSc7jwpY/ttwI+CEZahZEnrufilv2s5NouZjN7xJHWAwsBO5eU8s
 WP9tAYArQ7WK/HpghxNB3mJrb8vAGwOKwh7SAxzS7BZUyI94Vp/qWp4WARd3bqrJYBN3KeiaOSo
 xwC066ymmjJ9JmvzIwFfOGY2JA3Q==
X-Received: by 2002:a05:622a:114e:b0:476:8f90:b5d9 with SMTP id
 d75a77b69052e-49f4624949bmr57240461cf.5.1748097816794; 
 Sat, 24 May 2025 07:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMk6hsZlxzfsl7VsMK/GO0Qv/6TvrFQsDTs11WPyIrROWtSPuQ/RSF6xA8nhmGeWWxyDNX/AuU7SjrEqr7DaU=
X-Received: by 2002:a05:622a:114e:b0:476:8f90:b5d9 with SMTP id
 d75a77b69052e-49f4624949bmr57240071cf.5.1748097816357; Sat, 24 May 2025
 07:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
In-Reply-To: <20250515024734.758335-1-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 24 May 2025 16:43:25 +0200
X-Gm-Features: AX0GCFum4Bd-c8LArm8NilLnmuwGUntp2QMoatynm3RFZP-_ZewHmo-tW-vRTG0
Message-ID: <CAMxuvayYXPg8OHEY3E_3BXo+whr7jmTghf3CWq0+EcH8WdRWtA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] ui/spice: Enable gl=on option for non-local or
 remote clients
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, 
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 Dongwon Kim <dongwon.kim@intel.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006086680635e2bdf3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006086680635e2bdf3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 15, 2025 at 4:49=E2=80=AFAM Vivek Kasireddy <vivek.kasireddy@in=
tel.com>
wrote:

> To address the limitation that this option is incompatible with
> remote clients, this patch series adds an option to select a
> preferred codec and also enable gl=3Don option for clients that
> are connected via the network. In other words, with this option
> enabled (and the below linked Spice series merged), it would be
> possible to have Qemu share a dmabuf fd with Spice, which would
> then forward it to a hardware or software based encoder and
> eventually send the data associated with the fd to a client that
> could be located on a different machine.
>
> Essentially, this patch series provides a hardware accelerated,
> opensource VDI option for users using Qemu and Spice by leveraging
> the iGPU/dGPU on the host machine to encode the Guest FB via the
> Gstreamer framework.
>
>
for v5, please fix the patches to pass scripts/checkpatch.pl.


> v3 -> v4 (suggestions from Marc-Andr=C3=A9):
> - Add a new parameter to make max_refresh_rate configurable
> - Have surface_gl_create_texture_from_fd() return bool after checking
>   for errors
> - Remove the check for PIXMAN_r5g6b5() in spice_gl_replace_fd_texture()
> - Report errors in spice_gl_replace_fd_texture() when someting fails
> - Use glGetError() correctly by adding an additional (dummy) call
>   before checking for actual errors (Dmitry)
> - Add a new patch to check fd values in egl_dmabuf_export_texture()
> - Rebase on Qemu master
>
> v2 -> v3:
> - Check for errors after invoking glImportMemoryFdEXT() using
>   glGetError() and report the error to user (Dmitry)
>
> v1 -> v2:
> - Replace the option name preferred-codec with video-codecs (Marc-Andr=C3=
=A9)
> - Add a warning when an fd cannot be created from texture (Marc-Andr=C3=
=A9)
> - Add a new patch to blit the scanout texture into a linear one to
>   make it work with virgl
> - Rebased and tested against the latest Spice master
>
> Tested with the following Qemu parameters:
> -device virtio-vga,max_outputs=3D1,xres=3D1920,yres=3D1080,blob=3Dtrue
> -spice port=3D3001,gl=3Don,disable-ticketing=3Don,video-codecs=3Dgstreame=
r:h264
>
> and remote-viewer --spice-debug spice://x.x.x.x:3001 on the client side.
>
> Associated Spice server MR (merged):
> https://gitlab.freedesktop.org/spice/spice/-/merge_requests/229
>
> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Vivek Kasireddy (7):
>   ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
>   ui/spice: Add an option for users to provide a preferred codec
>   ui/spice: Enable gl=3Don option for non-local or remote clients
>   ui/spice: Add an option to submit gl_draw requests at fixed rate
>   ui/console-gl: Add a helper to create a texture with linear memory
>     layout
>   ui/spice: Create a new texture with linear layout when gl=3Don is
>     enabled
>   ui/spice: Blit the scanout texture if its memory layout is not linear
>
>  include/ui/console.h       |   2 +
>  include/ui/spice-display.h |   5 +
>  qemu-options.hx            |  10 ++
>  ui/console-gl.c            |  32 ++++++
>  ui/egl-helpers.c           |   6 ++
>  ui/spice-core.c            |  27 +++++
>  ui/spice-display.c         | 212 ++++++++++++++++++++++++++++++++++---
>  7 files changed, 278 insertions(+), 16 deletions(-)
>
> --
> 2.49.0
>
>

--0000000000006086680635e2bdf3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 15, 2025 at 4:49=
=E2=80=AFAM Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com=
">vivek.kasireddy@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">To address the limitation that this option is in=
compatible with<br>
remote clients, this patch series adds an option to select a<br>
preferred codec and also enable gl=3Don option for clients that<br>
are connected via the network. In other words, with this option<br>
enabled (and the below linked Spice series merged), it would be<br>
possible to have Qemu share a dmabuf fd with Spice, which would<br>
then forward it to a hardware or software based encoder and<br>
eventually send the data associated with the fd to a client that<br>
could be located on a different machine.<br>
<br>
Essentially, this patch series provides a hardware accelerated,<br>
opensource VDI option for users using Qemu and Spice by leveraging<br>
the iGPU/dGPU on the host machine to encode the Guest FB via the<br>
Gstreamer framework.<br>
<br></blockquote><div><br></div><div>for v5, please fix the patches to pass=
=C2=A0scripts/<a href=3D"http://checkpatch.pl">checkpatch.pl</a>.</div><div=
>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
v3 -&gt; v4 (suggestions from Marc-Andr=C3=A9):<br>
- Add a new parameter to make max_refresh_rate configurable<br>
- Have surface_gl_create_texture_from_fd() return bool after checking<br>
=C2=A0 for errors<br>
- Remove the check for PIXMAN_r5g6b5() in spice_gl_replace_fd_texture()<br>
- Report errors in spice_gl_replace_fd_texture() when someting fails<br>
- Use glGetError() correctly by adding an additional (dummy) call<br>
=C2=A0 before checking for actual errors (Dmitry)<br>
- Add a new patch to check fd values in egl_dmabuf_export_texture()<br>
- Rebase on Qemu master<br>
<br>
v2 -&gt; v3:<br>
- Check for errors after invoking glImportMemoryFdEXT() using<br>
=C2=A0 glGetError() and report the error to user (Dmitry)<br>
<br>
v1 -&gt; v2:<br>
- Replace the option name preferred-codec with video-codecs (Marc-Andr=C3=
=A9)<br>
- Add a warning when an fd cannot be created from texture (Marc-Andr=C3=A9)=
<br>
- Add a new patch to blit the scanout texture into a linear one to<br>
=C2=A0 make it work with virgl<br>
- Rebased and tested against the latest Spice master<br>
<br>
Tested with the following Qemu parameters:<br>
-device virtio-vga,max_outputs=3D1,xres=3D1920,yres=3D1080,blob=3Dtrue<br>
-spice port=3D3001,gl=3Don,disable-ticketing=3Don,video-codecs=3Dgstreamer:=
h264<br>
<br>
and remote-viewer --spice-debug spice://x.x.x.x:3001 on the client side.<br=
>
<br>
Associated Spice server MR (merged):<br>
<a href=3D"https://gitlab.freedesktop.org/spice/spice/-/merge_requests/229"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/spice/=
spice/-/merge_requests/229</a><br>
<br>
---<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com" ta=
rget=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
Cc: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" target=3D"_bl=
ank">freddy77@gmail.com</a>&gt;<br>
Cc: Michael Scherle &lt;<a href=3D"mailto:michael.scherle@rz.uni-freiburg.d=
e" target=3D"_blank">michael.scherle@rz.uni-freiburg.de</a>&gt;<br>
Cc: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_bla=
nk">dongwon.kim@intel.com</a>&gt;<br>
Cc: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=
=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
Vivek Kasireddy (7):<br>
=C2=A0 ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()<b=
r>
=C2=A0 ui/spice: Add an option for users to provide a preferred codec<br>
=C2=A0 ui/spice: Enable gl=3Don option for non-local or remote clients<br>
=C2=A0 ui/spice: Add an option to submit gl_draw requests at fixed rate<br>
=C2=A0 ui/console-gl: Add a helper to create a texture with linear memory<b=
r>
=C2=A0 =C2=A0 layout<br>
=C2=A0 ui/spice: Create a new texture with linear layout when gl=3Don is<br=
>
=C2=A0 =C2=A0 enabled<br>
=C2=A0 ui/spice: Blit the scanout texture if its memory layout is not linea=
r<br>
<br>
=C2=A0include/ui/console.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0include/ui/spice-display.h |=C2=A0 =C2=A05 +<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +=
+<br>
=C2=A0ui/console-gl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 32 +=
+++++<br>
=C2=A0ui/egl-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 ++<br>
=C2=A0ui/spice-core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 +=
++++<br>
=C2=A0ui/spice-display.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 212 +++++++++++=
+++++++++++++++++++++++---<br>
=C2=A07 files changed, 278 insertions(+), 16 deletions(-)<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--0000000000006086680635e2bdf3--


