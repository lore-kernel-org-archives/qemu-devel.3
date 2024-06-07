Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61334C27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 11:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFXUk-0006vq-5u; Fri, 07 Jun 2024 07:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFXUi-0006vN-8I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 07:10:52 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFXUg-0008PW-2x
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 07:10:51 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so38152291fa.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717758646; x=1718363446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6CFlsOipPJGOt43/QGO9L8rusSNq8HLNnmovu4CWa0U=;
 b=gv3uNeBtYzoQBgV2jxQFySZ70DRKVtNqKTVVbF23GK9YUwe+zFMLnY2T52IOqQ7XCA
 VwRWGq7Ra5YlNWA1/Ta9LTN6AsMA5K+/MppUhjmZnsuTQ5cMs7tG9nZUx5QklCVIB390
 eRPePjYrfjtqFt8JczB56msI0n/Sr/69ldImaO0MdZ9qVzTTC3Dcg9ZV55TUQ1GgCjy0
 5uEVQ5UqWuGcxyX1G5wQejKBWtZP+GLV25OkSVzf7VsDPLmZqrbZl3NVVFZN4aGd6JnK
 7OLnn3Lebi+owSRlrDjmKoZiD8p+wmYirQCU0JsV0bGQpTAWb6TKnCUuicgNvOCxwlN1
 7uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717758646; x=1718363446;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CFlsOipPJGOt43/QGO9L8rusSNq8HLNnmovu4CWa0U=;
 b=dvyZoJ0L74TDo4Nx6P6VqyyLS4u8y4r0qGc0UAVEj73TfNry1NhowZ997ifYV8yANt
 8BHJ5pquod5WQCg3cLRTp7Iw2Cqp3VLmQ+Ro5FMtOgART1QGMqOAa0/5PL7qffJeoQae
 pZOrbZmFcdMIS3Tq4KiXQNolsAQwAsK6WjG4Hy6JOZkwyrPYQ/uToachzBE5uFgQEq7T
 CmF4YDQ8+or9/wQrlIIIDEWiImOD/IdzZ3nBwin5zKd/qmybVRyxdu690s5F26L5ggA+
 6OlXwz+g5+y+115UWw01Ada4pJivZWLvjQ9vnMnhpYkwsFxTdO5llGqySKKRS0eFz0Ek
 ncxg==
X-Gm-Message-State: AOJu0YzEfncdv7MFZ8vRDXT2BuKEb2Oy9JQukENrlgxYpQfewGEEEO0D
 jNA2h4jScBpi1LUyWBAFOUmSM9+mFA1Al978R1+zMEYRzCtZSidBhMSVWhQCBpA=
X-Google-Smtp-Source: AGHT+IE5xKzM/L9JkAsU4CCo27LLOHXCLYstiUf+UasH5beKi8r5MfjyvgOHpbcbyUHEpjwh50WBbQ==
X-Received: by 2002:a2e:b4b6:0:b0:2ea:e2d2:6231 with SMTP id
 38308e7fff4ca-2eae2d2653emr8823191fa.33.1717758646019; 
 Fri, 07 Jun 2024 04:10:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806ebd12sm231153566b.135.2024.06.07.04.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 04:10:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E87F5F839;
 Fri,  7 Jun 2024 12:10:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/3] virtio-gpu: Enable virglrenderer backend for rutabaga
In-Reply-To: <53a0c7590b6c382d4e3d22d8b53394f03f2d4038.camel@gmail.com>
 (Weifeng Liu's message of "Fri, 07 Jun 2024 14:47:03 +0800")
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
 <87ikyml5c6.fsf@draig.linaro.org>
 <53a0c7590b6c382d4e3d22d8b53394f03f2d4038.camel@gmail.com>
Date: Fri, 07 Jun 2024 12:10:44 +0100
Message-ID: <87ed99knyj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

> Hi Alex,
>
> On Thu, 2024-06-06 at 11:43 +0100, Alex Benn=C3=A9e wrote:
>> Weifeng Liu <weifeng.liu.z@gmail.com> writes:
>>=20
>> > Greetings,
>> >=20
>> > I'd like to introduce you my attempt to enable virglrenderer backend f=
or
>> > rutabaga empowered virtio-gpu device.  I am aware that there have been
>> > effort in supporting venus in virtio-gpu-virgl.c [1], but there is no
>> > reason to prevent us from leveraging the virglrenderer component in
>> > rutabaga_gfx, especially it being not very hard to add this
>> > functionality.
>> >=20
>> > Generally, the gap is the polling capability, i.e., virglrenderer
>> > requires the main thread (namely the GPU command handling thread) to
>> > poll virglrenderer at proper moments, which is not yet supported in
>> > virtio-gpu-rutabaga device. This patch set try to add this so that
>> > virglrenderer backend (including virgl and venus) can work as expected.
>> >=20
>> > Slight change to rutabaga_gfx_ffi is also a requirement, which is
>> > included in [2].
>> >=20
>> > Further effort is required to tune the performance, since copying is
>> > present before the rendered images get displayed. But I still think th=
is
>> > patch set could be a good starting point for the pending work.
>> >=20
>> > For those interested in setting up environment and playing around with
>> > this patch set, here is guideline in brief:
>> >=20
>> > 1. Clone the master/main branch of virglrenderer, compile and install =
it.
>> >=20
>> > 	git clone https://gitlab.freedesktop.org/virgl/virglrenderer
>> > 	cd virglrenderer
>> > 	meson setup builddir \
>> > 	  --prefix=3D$INSTALL_DIR/virglrenderer \
>> > 	  -Dvenus=3Dtrue
>> > 	ninja -C builddir install
>> >=20
>> > 2. Clone the patched CrosVM, build and install rutabaga_gfx_ffi.
>> >=20
>> > 	git clone -b rutabaga_ffi_virgl https://github.com/phreer/crosvm.git
>> > 	cd crosvm/rutabaga_gfx/ffi
>> > 	export PKG_CONFIG_PATH=3D$INSTALL_DIR/virglrenderer/lib64/pkgconfig/
>> > 	meson setup builddir/ \
>> > 	  --prefix $HOME/install/rutabaga_gfx/rutabaga_gfx_ffi/ \
>> > 	  -Dvirglrenderer=3Dtrue
>> > 	ninja -C builddir install
>>=20
>> Is there a PR going in for this? The moving parts for rutabaga are
>> complex enough I think we need support upstream before merging this.
>>=20
>
> It's true that this patch set depends on the change of
> rutabaga_gfx_ffi. I am trying get the modifications of
> crosvm/rubataga_gfx_ffi merged in upstream, please refer to this link:
> https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5599645
>
>> Is this branch where I should be getting the poll helpers from?
>>=20
>>   cc -m64 @qemu-system-arm.rsp
>>   /usr/bin/ld: libcommon.fa.p/hw_display_virtio-gpu-rutabaga.c.o: in fun=
ction `virtio_gpu_fence_poll':
>>   /home/alex/lsrc/qemu.git/builds/vulkan/../../hw/display/virtio-gpu-rut=
abaga.c:909: undefined reference to `rutabaga_poll'
>>   /usr/bin/ld: libcommon.fa.p/hw_display_virtio-gpu-rutabaga.c.o: in fun=
ction `virtio_gpu_rutabaga_init':
>>   /home/alex/lsrc/qemu.git/builds/vulkan/../../hw/display/virtio-gpu-rut=
abaga.c:1122: undefined reference to `rutabaga_poll_descriptor'
>>   collect2: error: ld returned 1 exit status
>>   ninja: build stopped: subcommand failed.
>>=20
>
> The required patches are applied to the rutabaga_ffi_virgl branch of my
> clone of crosvm already, so please check out to that branch.

I thought I had - maybe my install got polluted. I shall try again.

>
>>=20
>> > 3. Applied this patch set to QEMU, build and install it:
>> >=20
>> > 	cd qemu=09
>> > 	# Apply this patch set atop main branch ...
>> > 	mkdir builddir; cd builddir
>> > 	../configure --prefix=3D$INSTALL_DIR/qemu \
>> > 	  --target-list=3Dx86_64-softmmu \
>> > 	  --disable-virglrenderer \
>> > 	  --enable-rutabaga_gfx
>> > 	ninja -C builddir install
>> >=20
>> > 4. If you are lucky and everything goes fine, you are prepared to laun=
ch
>> >    VM with virglrenderer backed virtio-gpu-rutabaga device:
>> >=20
>> > 	export LD_LIBRARY_PATH=3D$INSTALL_DIR/virglrenderer/lib64/:$LD_LIBRAR=
Y_PATH
>> > 	export LD_LIBRARY_PATH=3D$INSTALL_DIR/rutabaga_gfx_ffi/lib64/:$LD_LIB=
RARY_PATH
>> > 	$INSTALL_DIR/qemu/bin/qemu-system-x86_64
>> > 	$QEMU -d guest_errors -enable-kvm -M q35 -smp 4 -m $MEM \
>> > 	  -object memory-backend-memfd,id=3Dmem1,size=3D$MEM \
>> > 	  -machine memory-backend=3Dmem1 \
>> > 	  -device virtio-vga-rutabaga,venus=3Don,virgl2=3Don,wsi=3Dsurfaceles=
s,hostmem=3D$MEM \
>> >=20
>>=20
>> This should go into docs/system/devices/virtio-gpu.rst with some
>> explanation. Is there anything we need on the guest side or does this
>> skip the encapsulating requirements of wayland?
>>=20
>
> Yeah, it's a good idea to add doc to explain the usage, thanks!
>
> Best regards,
> Weifeng
>
>> > Note:
>> >=20
>> > - You might need this patch set [3] to avoid KVM bad address error when
>> >   you are running on a GPU using TTM for memory management.
>> >=20
>> > [1] https://lore.kernel.org/all/dba6eb97-e1d1-4694-bfb6-e72db95715dd@d=
aynix.com/T/
>> > [2] https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5599645=
/1
>> > [3] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@goog=
le.com/
>> >=20
>> > Weifeng Liu (3):
>> >   virtio-gpu: rutabaga: Properly set stride when copying resources
>> >   virtio-gpu: rutabaga: Poll rutabaga upon events
>> >   virtio-gpu: rutabaga: Add options to enable virgl and venus contexts
>> >=20
>> >  hw/display/virtio-gpu-rutabaga.c | 104 ++++++++++++++++++++++++++++++-
>> >  include/hw/virtio/virtio-gpu.h   |   1 +
>> >  2 files changed, 104 insertions(+), 1 deletion(-)
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

