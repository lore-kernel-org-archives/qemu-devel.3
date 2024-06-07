Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2029CC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFTQS-0002AH-QE; Fri, 07 Jun 2024 02:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sFTQQ-00029X-Il
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:50:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sFTQO-0004UD-El
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:50:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7025cb09553so1645164b3a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717743007; x=1718347807; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+K9h/f//QdF5KAN//kW5uCdI3FhRC+BybNazKGlHu3U=;
 b=Y+3yihyktAjPjMkAE5XQ/O36TynTEkruDKBfgVn9Y9a2mMFJtgHnUw24zMrFua62AU
 cpgplXKGkndzc6EckGB7N/klfayIKhUwO27RzLbljQEQWOyaCUuMCJU8FzYM2golhjd3
 +qc4Y0SFTk/3K9KV3Bgftj+pKmywQa7PlOaKyQ/zuoz0OEIR7/p/qUo8RmwJ5Q2ozwud
 mWOegxIMf0O6RdYjfcFjhm+0t9jHxeZ9jMDjGbvI8xvxRUTOfxyxxuT4BBEMS+8AhW1n
 4JTGBHuwBZMO53de583+mBwtNKJJSa0SvoDq4RmLJySEti0gelY3Cwula/ahZ+av/Ne1
 1AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717743007; x=1718347807;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+K9h/f//QdF5KAN//kW5uCdI3FhRC+BybNazKGlHu3U=;
 b=h07TFv3TA/nEv/OA+dZO4pRatyWTHb+o7uFhi02WNqyMiomgq70SW1VkhOtkoijeGR
 Lp8f2OEXJkqWpanfVAWFdwyXGKc53OJ32JKUZLESMzpnhN71IsqTJ1glfpaiPzYArCEf
 ilst0AfO1Y8miM5jIFGapMPsPauBNwGcDpWI8SxQHuFXdjUSqQ6xH0FMBSktHJzgymHV
 v+hqGm8VAuFJ8sPNiQ2IKFpY1p/ImJhXqfl/GsdbUqrBXTqpXHjSdLZszi6eQKd0Z0TL
 5OTuIB2pZqFIiLnhY5RGrjkKtPIbvE7yHb4UkgW/GPtbcvRSJqgvSQ8PFD6Uj18ntT2c
 KVBw==
X-Gm-Message-State: AOJu0YzABqwEvMk//3Rfnl+SnSom+Bj7ZKPVJDLSHKx48eWuua5BBrG2
 7BbSoFa9+BIiV1OZINxZAJKtl37x3Rulz2o9Qt18qtQyWRUmYwST
X-Google-Smtp-Source: AGHT+IFQREd39wOphgtYUSKnqrYRmGVFF1pDdoWQHqeY4C5qGOH8qtFh/e3eefBcB/vplzIfHB1rNQ==
X-Received: by 2002:a05:6a21:998a:b0:1b1:d7a3:a76b with SMTP id
 adf61e73a8af0-1b2f9a70c5dmr2053800637.33.1717743005061; 
 Thu, 06 Jun 2024 23:50:05 -0700 (PDT)
Received: from liuweife-desk1.sh.intel.com ([192.55.54.45])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7e5cc4sm27070525ad.235.2024.06.06.23.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 23:50:04 -0700 (PDT)
Message-ID: <53a0c7590b6c382d4e3d22d8b53394f03f2d4038.camel@gmail.com>
Subject: Re: [PATCH 0/3] virtio-gpu: Enable virglrenderer backend for rutabaga
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>, Huang Rui
 <ray.huang@amd.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Date: Fri, 07 Jun 2024 14:47:03 +0800
In-Reply-To: <87ikyml5c6.fsf@draig.linaro.org>
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
 <87ikyml5c6.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Alex,

On Thu, 2024-06-06 at 11:43 +0100, Alex Benn=C3=A9e wrote:
> Weifeng Liu <weifeng.liu.z@gmail.com> writes:
>=20
> > Greetings,
> >=20
> > I'd like to introduce you my attempt to enable virglrenderer backend fo=
r
> > rutabaga empowered virtio-gpu device.  I am aware that there have been
> > effort in supporting venus in virtio-gpu-virgl.c [1], but there is no
> > reason to prevent us from leveraging the virglrenderer component in
> > rutabaga_gfx, especially it being not very hard to add this
> > functionality.
> >=20
> > Generally, the gap is the polling capability, i.e., virglrenderer
> > requires the main thread (namely the GPU command handling thread) to
> > poll virglrenderer at proper moments, which is not yet supported in
> > virtio-gpu-rutabaga device. This patch set try to add this so that
> > virglrenderer backend (including virgl and venus) can work as expected.
> >=20
> > Slight change to rutabaga_gfx_ffi is also a requirement, which is
> > included in [2].
> >=20
> > Further effort is required to tune the performance, since copying is
> > present before the rendered images get displayed. But I still think thi=
s
> > patch set could be a good starting point for the pending work.
> >=20
> > For those interested in setting up environment and playing around with
> > this patch set, here is guideline in brief:
> >=20
> > 1. Clone the master/main branch of virglrenderer, compile and install i=
t.
> >=20
> > 	git clone https://gitlab.freedesktop.org/virgl/virglrenderer
> > 	cd virglrenderer
> > 	meson setup builddir \
> > 	  --prefix=3D$INSTALL_DIR/virglrenderer \
> > 	  -Dvenus=3Dtrue
> > 	ninja -C builddir install
> >=20
> > 2. Clone the patched CrosVM, build and install rutabaga_gfx_ffi.
> >=20
> > 	git clone -b rutabaga_ffi_virgl https://github.com/phreer/crosvm.git
> > 	cd crosvm/rutabaga_gfx/ffi
> > 	export PKG_CONFIG_PATH=3D$INSTALL_DIR/virglrenderer/lib64/pkgconfig/
> > 	meson setup builddir/ \
> > 	  --prefix $HOME/install/rutabaga_gfx/rutabaga_gfx_ffi/ \
> > 	  -Dvirglrenderer=3Dtrue
> > 	ninja -C builddir install
>=20
> Is there a PR going in for this? The moving parts for rutabaga are
> complex enough I think we need support upstream before merging this.
>=20

It's true that this patch set depends on the change of
rutabaga_gfx_ffi. I am trying get the modifications of
crosvm/rubataga_gfx_ffi merged in upstream, please refer to this link:
https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5599645

> Is this branch where I should be getting the poll helpers from?
>=20
>   cc -m64 @qemu-system-arm.rsp
>   /usr/bin/ld: libcommon.fa.p/hw_display_virtio-gpu-rutabaga.c.o: in func=
tion `virtio_gpu_fence_poll':
>   /home/alex/lsrc/qemu.git/builds/vulkan/../../hw/display/virtio-gpu-ruta=
baga.c:909: undefined reference to `rutabaga_poll'
>   /usr/bin/ld: libcommon.fa.p/hw_display_virtio-gpu-rutabaga.c.o: in func=
tion `virtio_gpu_rutabaga_init':
>   /home/alex/lsrc/qemu.git/builds/vulkan/../../hw/display/virtio-gpu-ruta=
baga.c:1122: undefined reference to `rutabaga_poll_descriptor'
>   collect2: error: ld returned 1 exit status
>   ninja: build stopped: subcommand failed.
>=20

The required patches are applied to the rutabaga_ffi_virgl branch of my
clone of crosvm already, so please check out to that branch.

>=20
> > 3. Applied this patch set to QEMU, build and install it:
> >=20
> > 	cd qemu=09
> > 	# Apply this patch set atop main branch ...
> > 	mkdir builddir; cd builddir
> > 	../configure --prefix=3D$INSTALL_DIR/qemu \
> > 	  --target-list=3Dx86_64-softmmu \
> > 	  --disable-virglrenderer \
> > 	  --enable-rutabaga_gfx
> > 	ninja -C builddir install
> >=20
> > 4. If you are lucky and everything goes fine, you are prepared to launc=
h
> >    VM with virglrenderer backed virtio-gpu-rutabaga device:
> >=20
> > 	export LD_LIBRARY_PATH=3D$INSTALL_DIR/virglrenderer/lib64/:$LD_LIBRARY=
_PATH
> > 	export LD_LIBRARY_PATH=3D$INSTALL_DIR/rutabaga_gfx_ffi/lib64/:$LD_LIBR=
ARY_PATH
> > 	$INSTALL_DIR/qemu/bin/qemu-system-x86_64
> > 	$QEMU -d guest_errors -enable-kvm -M q35 -smp 4 -m $MEM \
> > 	  -object memory-backend-memfd,id=3Dmem1,size=3D$MEM \
> > 	  -machine memory-backend=3Dmem1 \
> > 	  -device virtio-vga-rutabaga,venus=3Don,virgl2=3Don,wsi=3Dsurfaceless=
,hostmem=3D$MEM \
> >=20
>=20
> This should go into docs/system/devices/virtio-gpu.rst with some
> explanation. Is there anything we need on the guest side or does this
> skip the encapsulating requirements of wayland?
>=20

Yeah, it's a good idea to add doc to explain the usage, thanks!

Best regards,
Weifeng

> > Note:
> >=20
> > - You might need this patch set [3] to avoid KVM bad address error when
> >   you are running on a GPU using TTM for memory management.
> >=20
> > [1] https://lore.kernel.org/all/dba6eb97-e1d1-4694-bfb6-e72db95715dd@da=
ynix.com/T/
> > [2] https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5599645/=
1
> > [3] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@googl=
e.com/
> >=20
> > Weifeng Liu (3):
> >   virtio-gpu: rutabaga: Properly set stride when copying resources
> >   virtio-gpu: rutabaga: Poll rutabaga upon events
> >   virtio-gpu: rutabaga: Add options to enable virgl and venus contexts
> >=20
> >  hw/display/virtio-gpu-rutabaga.c | 104 ++++++++++++++++++++++++++++++-
> >  include/hw/virtio/virtio-gpu.h   |   1 +
> >  2 files changed, 104 insertions(+), 1 deletion(-)
>=20


