Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB2DC5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiT8-0003ie-OT; Wed, 04 Jun 2025 03:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uMiT7-0003iO-34
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:23:25 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uMiT4-0007z8-W7
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:23:24 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7c922169051so346876985a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749021801; x=1749626601; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtiViquYzfifAHYiXsBxym8lzyMcwa/kxHqOyU88xpI=;
 b=QrdNXLfI+Ae6A8/YCp31HilpcHx2jdWnN0ySp9tfqtkHPLzAPmBv8bIa4yw8Z86zTi
 uzNdWXLdGS7GXs/Mq4ksXkHW1oApYUpG0AZ4ALGKwH67cq0dudxHXc7Xrz3h7K2GKavC
 k5rwttmnFAjvLFsWZbPkwFGyfPgTsXM6ZoS8CJvRMS9cxoGbcPTmidnfFmZz00RsbMq6
 dsAxWuGlosdMSTK7bPmRECwoamQpx7R7TZ2MBPWp1y6MObf9YJSI2wDgQAdC8PK+CRD/
 4zssZQCzBwSbw8I/pptfaKUblVr6H7yeh+rRQGFa+yg80dpi5jlXxTOirMze8nGvFe/+
 2i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749021801; x=1749626601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtiViquYzfifAHYiXsBxym8lzyMcwa/kxHqOyU88xpI=;
 b=nwLSYGArIBNlKymFA8r43aRV3gtoC8AV8dGYWsZwTbhLQSTIz8TWh2WUp+YLzzg5EB
 yYygIcPqwV+AogOHvf/TJbXTQwjr7J39cfqbScOkQWJdf4BF6EQJr2fEU5/b3TdMWxOe
 lw6wdpx6tdq5qAMt/7JMIV4ErJRkXt1cCDTpn2yA+nfYp7taiVoz0DIOUDvwZQxhr2g+
 NZJST53dRR5KwEXk1LkypqVJH7vgpiIZtpngNNotJDoEkp10pc55/rPwP1ufCBi+wBvl
 8zFeFfgYrjIxxWwpN6HrQZESR961cptueiWSMWBv8rjAe5mTXCeAM7qlTsPZqYr8MtRF
 f8sA==
X-Gm-Message-State: AOJu0YyZbX7dVzwhXf08ZX2Ozv4iLmOVLFP66a3gmdG9tZPMKYipIO5U
 eKEo8mb87xjLlIRWeSPA1ECNnfs16MfTf0vGoGOpEWTIiaHan5jd9yGnv5uIpaxH3G7L+Xq0P3T
 1DNZ+ARY+KOPlrsu8E4T7phaWmVTyi9w=
X-Gm-Gg: ASbGnctKqXtDlhFEzxYAi7YIEEyDmEegDHo/SsLVgkJi2kiHhm3zV6zDG6jPgN6y/Ou
 BOiqJEctLVCNcwlJLxbtYTZ3NTlIf9nwy+q0yiYyOV++2Y/ZdgWzvwzYeYKJljXffs7y/5Rqcvp
 4tdYDh6g2LunpzfeYA9MTcE5/PwT+uB2w3YLAPsJ8ora32WTTALbGdHpfdhuMd5E8QgNlJ3whk7
 LIO
X-Google-Smtp-Source: AGHT+IHcAj3Bu0wRdpl/xOOO44AyWlwHVq+q6gciW4BFjkgrnXV8KH679BhRJ3X+PZSyOidoG13BIBzhY6FxGIHN0Xg=
X-Received: by 2002:a05:620a:1918:b0:7d0:9d56:48b6 with SMTP id
 af79cd13be357-7d219819291mr300507685a.9.1749021801278; Wed, 04 Jun 2025
 00:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
In-Reply-To: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Jun 2025 11:23:10 +0400
X-Gm-Features: AX0GCFugzp0z3MZTvDTDS3rVMM_zPKng8tUr1HznGMDgdTq738q2cMIaQ0mjcHU
Message-ID: <CAJ+F1CKWKEg+80PVcmytOEDzrrvCv7FjvPsHooHQrE3eiHqy1Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] ui/spice: Enable gl=on option for non-local or
 remote clients
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, 
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 Dongwon Kim <dongwon.kim@intel.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Vivek

On Thu, May 29, 2025 at 9:16=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
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

I tested the series on fedora with intel-media-driver installed from rpmfus=
ion.

Without explicit video-codecs argument I get:
qemu-system-x86_64: warning: Spice:
../server/dcc-send.cpp:1780:red_marshall_gl_draw_stream: No video
encoder available for this stream
qemu-system-x86_64: warning: spice: no gl-draw-done within one second

If I specify video-codecs=3Dgstreamer:h264, then it seems to work fine.

I wish all of this would be better documented or more explicit, as
each step took me a while to figure out (why it didn't pick a
compatible encoder, what was the argument for video-codecs, why gst
didn't support h264enc, where to find the encoder, ...). I am not even
sure I am doing all this  correctly. Maybe there should be some
docs/interop/spice.rst to document qemu -spice and video-codecs
usages? (and move docs/spice-port-fqdn.txt content there too)

I suppose the issue with better default for video-codecs is on
spice-server side, so for this series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> v4  -> v5 (suggestions from Marc-Andr=C3=A9):
> - Fix the errors (mostly 80 chars limit violations) identified by
>   scripts/checkpatch.pl
> - Rename the globals to have a spice_ prefix for consistency
> - Rename MAX_REFRESH_RATE to DEFAULT_MAX_REFRESH_RATE
> - Added comments to explain how/when the gl_draw request is submitted
>   to spice server in the remote clients case
> - Fix the mem_obj leak that would occur when the associated texture
>   is destroyed or when an error is encountered while creating a
>   texture from an fd (Dmitry and Michael)
> - Merged Michael's patch to fix the mem_obj leak into this series and
>   added his Co-developed-by tag to the relevant patches
>
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
>  include/ui/console.h       |   3 +
>  include/ui/spice-display.h |   5 +
>  include/ui/surface.h       |   1 +
>  qemu-options.hx            |  10 ++
>  ui/console-gl.c            |  54 +++++++++
>  ui/egl-helpers.c           |   6 +
>  ui/spice-core.c            |  28 +++++
>  ui/spice-display.c         | 226 ++++++++++++++++++++++++++++++++++---
>  8 files changed, 317 insertions(+), 16 deletions(-)
>
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

