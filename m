Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ADAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAaR-0007xM-4l; Thu, 06 Jun 2024 06:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFAaP-0007vM-5P
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:43:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFAaK-0003cQ-EL
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:43:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57a50ac2ca1so966395a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717670587; x=1718275387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y1+pniKZ8HaPoeUEfkoq2AGSC/ogq1hupfYKEEXZbMo=;
 b=wXIMii6BYIWpDGiOxFfEM1QKujw1SSozzNZB8GwmSWbaYYvfPUC5mMVTsdck9RUSir
 x+qHIRnAUlxgjUSueiV0MPTbkPdEl/EwqaBf6EhGBKt6mKzJG0P6i3+g/i9bGGDuP/Ah
 rrKJWHv8dRtwTrHk9hsfFEGAL22LRgHWREUP9WtxzCHaJEg7c0iiB46GyevU0p6uQFnx
 cKFYDkvnhzCS3nl3Aa8nLu0pxWmkLNa65c/2dHXSIxhgB18BkayjWfnAAyz9bfUryT4v
 7g1pUImws4C1SB62ABDom1KkB5z6sXa6qtJW6Xx/cuL3pgGmVatdJauUG3PqgVFmddcK
 pIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717670587; x=1718275387;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1+pniKZ8HaPoeUEfkoq2AGSC/ogq1hupfYKEEXZbMo=;
 b=pE/mINNqXQDZbysD9GfYqeN7wrL/m/ew/KLkDlLcsoFQ7UgvMRpbbTe6OSSgNNfVhX
 ZmNB5AI7L88aaaelSUOtYnFUwLnQP2P51fNPr4JcoPRmLgweAivNvgAiEs+xjE0ZwDXv
 j/U4kit3DHd1qWVixmP7rQupQIQUg8oVbiDWGQ8myijCieAusAkmAvTMnHm/DvcJkBlb
 u8XFrPdSuJWdjzQnCooTznV2t86MeKWwC6efMGRglC6/cMFesjggrlTV2DM3JnP4g9tw
 34TcQ+4n2jYWH8oxcDAtFwUJx6QcbhOojBr2BHy19PolbUzfEIKt1/IbLwp+gxXgrIj2
 PyAQ==
X-Gm-Message-State: AOJu0Yz0fHkqIi8yOndfTG/QxarPW14kSefeEWTl5C2gtlakwTc9tGd4
 rahK/EMN13pxFkCj0ZB/U/rAdg8jgdcy0m2zYe47YOZTSMF7i7j74EO5QGPWOt8=
X-Google-Smtp-Source: AGHT+IHzStjhq/SaEwxB1lQutgWcsUb5nVSIGedfL3SxHywAHrAAaOHooXZ+lDLI03ktmJwFnbSWKA==
X-Received: by 2002:a50:ab1c:0:b0:57c:46cb:a984 with SMTP id
 4fb4d7f45d1cf-57c46cba9admr397522a12.5.1717670586644; 
 Thu, 06 Jun 2024 03:43:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0caa1asm882764a12.31.2024.06.06.03.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 03:43:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B69D95F7AD;
 Thu,  6 Jun 2024 11:43:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/3] virtio-gpu: Enable virglrenderer backend for rutabaga
In-Reply-To: <20240605152832.11618-1-weifeng.liu.z@gmail.com> (Weifeng Liu's
 message of "Wed, 5 Jun 2024 23:28:27 +0800")
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
Date: Thu, 06 Jun 2024 11:43:05 +0100
Message-ID: <87ikyml5c6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Weifeng Liu <weifeng.liu.z@gmail.com> writes:

> Greetings,
>
> I'd like to introduce you my attempt to enable virglrenderer backend for
> rutabaga empowered virtio-gpu device.  I am aware that there have been
> effort in supporting venus in virtio-gpu-virgl.c [1], but there is no
> reason to prevent us from leveraging the virglrenderer component in
> rutabaga_gfx, especially it being not very hard to add this
> functionality.
>
> Generally, the gap is the polling capability, i.e., virglrenderer
> requires the main thread (namely the GPU command handling thread) to
> poll virglrenderer at proper moments, which is not yet supported in
> virtio-gpu-rutabaga device. This patch set try to add this so that
> virglrenderer backend (including virgl and venus) can work as expected.
>
> Slight change to rutabaga_gfx_ffi is also a requirement, which is
> included in [2].
>
> Further effort is required to tune the performance, since copying is
> present before the rendered images get displayed. But I still think this
> patch set could be a good starting point for the pending work.
>
> For those interested in setting up environment and playing around with
> this patch set, here is guideline in brief:
>
> 1. Clone the master/main branch of virglrenderer, compile and install it.
>
> 	git clone https://gitlab.freedesktop.org/virgl/virglrenderer
> 	cd virglrenderer
> 	meson setup builddir \
> 	  --prefix=3D$INSTALL_DIR/virglrenderer \
> 	  -Dvenus=3Dtrue
> 	ninja -C builddir install
>
> 2. Clone the patched CrosVM, build and install rutabaga_gfx_ffi.
>
> 	git clone -b rutabaga_ffi_virgl https://github.com/phreer/crosvm.git
> 	cd crosvm/rutabaga_gfx/ffi
> 	export PKG_CONFIG_PATH=3D$INSTALL_DIR/virglrenderer/lib64/pkgconfig/
> 	meson setup builddir/ \
> 	  --prefix $HOME/install/rutabaga_gfx/rutabaga_gfx_ffi/ \
> 	  -Dvirglrenderer=3Dtrue
> 	ninja -C builddir install

Is there a PR going in for this? The moving parts for rutabaga are
complex enough I think we need support upstream before merging this.

Is this branch where I should be getting the poll helpers from?

  cc -m64 @qemu-system-arm.rsp
  /usr/bin/ld: libcommon.fa.p/hw_display_virtio-gpu-rutabaga.c.o: in functi=
on `virtio_gpu_fence_poll':
  /home/alex/lsrc/qemu.git/builds/vulkan/../../hw/display/virtio-gpu-rutaba=
ga.c:909: undefined reference to `rutabaga_poll'
  /usr/bin/ld: libcommon.fa.p/hw_display_virtio-gpu-rutabaga.c.o: in functi=
on `virtio_gpu_rutabaga_init':
  /home/alex/lsrc/qemu.git/builds/vulkan/../../hw/display/virtio-gpu-rutaba=
ga.c:1122: undefined reference to `rutabaga_poll_descriptor'
  collect2: error: ld returned 1 exit status
  ninja: build stopped: subcommand failed.


> 3. Applied this patch set to QEMU, build and install it:
>
> 	cd qemu=09
> 	# Apply this patch set atop main branch ...
> 	mkdir builddir; cd builddir
> 	../configure --prefix=3D$INSTALL_DIR/qemu \
> 	  --target-list=3Dx86_64-softmmu \
> 	  --disable-virglrenderer \
> 	  --enable-rutabaga_gfx
> 	ninja -C builddir install
>
> 4. If you are lucky and everything goes fine, you are prepared to launch
>    VM with virglrenderer backed virtio-gpu-rutabaga device:
>
> 	export LD_LIBRARY_PATH=3D$INSTALL_DIR/virglrenderer/lib64/:$LD_LIBRARY_P=
ATH
> 	export LD_LIBRARY_PATH=3D$INSTALL_DIR/rutabaga_gfx_ffi/lib64/:$LD_LIBRAR=
Y_PATH
> 	$INSTALL_DIR/qemu/bin/qemu-system-x86_64
> 	$QEMU -d guest_errors -enable-kvm -M q35 -smp 4 -m $MEM \
> 	  -object memory-backend-memfd,id=3Dmem1,size=3D$MEM \
> 	  -machine memory-backend=3Dmem1 \
> 	  -device virtio-vga-rutabaga,venus=3Don,virgl2=3Don,wsi=3Dsurfaceless,h=
ostmem=3D$MEM \
>

This should go into docs/system/devices/virtio-gpu.rst with some
explanation. Is there anything we need on the guest side or does this
skip the encapsulating requirements of wayland?

> Note:
>
> - You might need this patch set [3] to avoid KVM bad address error when
>   you are running on a GPU using TTM for memory management.
>
> [1] https://lore.kernel.org/all/dba6eb97-e1d1-4694-bfb6-e72db95715dd@dayn=
ix.com/T/
> [2] https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5599645/1
> [3] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.=
com/
>
> Weifeng Liu (3):
>   virtio-gpu: rutabaga: Properly set stride when copying resources
>   virtio-gpu: rutabaga: Poll rutabaga upon events
>   virtio-gpu: rutabaga: Add options to enable virgl and venus contexts
>
>  hw/display/virtio-gpu-rutabaga.c | 104 ++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-gpu.h   |   1 +
>  2 files changed, 104 insertions(+), 1 deletion(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

