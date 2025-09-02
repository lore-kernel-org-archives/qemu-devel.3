Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B6FCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVnC-0008JJ-Co; Tue, 02 Sep 2025 14:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1utVn7-0008HY-Jz
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:31:38 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1utVn5-0002Gm-9G
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:31:37 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b03fa5c5a89so500994266b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756837893; x=1757442693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1u0bJpfJC+oowrmHxSusUUjrpBIWVNy020IzschtC8=;
 b=aU1M/stfKxcpyWIjCz0WOXmbmKal7sPUNOfNTmm+9/7iiAPWHWLNdPAO9KcOBR8nqN
 3ssjD9PHMhGmx+h3X61PuZNLk/jBhklyCsvibtIMBkpVirEJQgvwE3bVOJdAgSHou0wq
 mp0k6fJtDJnkg+NlSVyBYfWOfnEBDHk3Ay1Fq3SEGnRM7P4AeEZmfJLlvtDPgCjPw+OE
 xi6ET1LDjIB1qtIWpeNUA/adHViD0Ns5a4YBX6Bryq3gFtEoK8+Zw9niCmEdBE0FZMpq
 2TnDxJjAI0JQ7bsd1IoKL8Lh2bjQpO+9Au8MHs7Y1vWSNhtTyMghJ9jcHjT3QFA4vbO5
 fsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756837893; x=1757442693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1u0bJpfJC+oowrmHxSusUUjrpBIWVNy020IzschtC8=;
 b=iq3l2v3ZPAjnWfLv4sE2U2TS44fVUhS6MTTKojI+CfiZ+5Uo/5gqL0Obmz/LT+OiNE
 1DifYTqaFbMl/01u/32urEjm7m1a4Gig4ZI6drDMg9iapVfKjSECBodlwHduYl34BXCd
 Dctnc05wyEfe6MdwaN4lENT5UtWgUKE0xaJT7XJ090C3acNBJmpS5ekknDwZQ+4IIQ7s
 8W+Sk9IE/11/a6qzRRsFslc2XN/L3Rl1XznbPVe3a+zgy51/hXY9ushv6r0X1Wsu+Apm
 ZIoegV5e8d0TReEbgbIRqd9AZhr6QqyLGAyEMyrHPCmZNocuElI6yfBYj/Ku86iQBq3v
 GU6Q==
X-Gm-Message-State: AOJu0YxfmXwDrCJ0PcO5WLstUwU+nadCVILbl2WeZkuYpDQ4yKelx558
 W8RQXpASHjQ/W339diPt/nAlS3JjQHhfi+V3xBc+ajfLbUBlkNlPijX0MBLQ5sPtg03FmrYGLGp
 iFQCEFd2tQCzLtE3f0v1pYoofcWl5ibs6J/OZR9WaMg==
X-Gm-Gg: ASbGncvHy9cCRqTJxgiOMZKmQ3epKeaTbPuupHru91P3af0D30XcwXSSuh67iAOoLWv
 aEUjsqIAwak5dan0CVsKtA0vpIwTJUFIqWcZmtpOh6dEemgof2mIGtECFZhGsC8dc3dn08M00um
 8JXeBBwpgk/G7jkGvtC1DXyMJE712B0p4RoAPeBPzh8F2RQcG2RrQM1fTk4JcHSMEL36DF4U3jF
 aa/CRPQ
X-Google-Smtp-Source: AGHT+IHyBYCL5zeilOHCC1mXRyi0YKc/wpPDlV3xw/SCP47b8KPNd+8/XgtbVsAvChC4GNseHOmbETiBL/L6H2pDDbg=
X-Received: by 2002:a17:907:7e85:b0:afe:9ae1:114b with SMTP id
 a640c23a62f3a-b01d973f4b0mr1213131866b.40.1756837893357; Tue, 02 Sep 2025
 11:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
 <20250902165048.1653323-2-alex.bennee@linaro.org>
In-Reply-To: <20250902165048.1653323-2-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 2 Sep 2025 21:31:07 +0300
X-Gm-Features: Ac12FXyYwxJ-dKxRFDzCNgEEb1p5i503dFhQSgavUt-ke8Rz4j1PMBjcG69C46k
Message-ID: <CAAjaMXaaoVVyd1yFjJN=tPL_EvgkV68-TSJbPUKz7YwwTOouzQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/system: split VirtIO devices from the rest
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

with a typo fix:


On Tue, Sep 2, 2025 at 7:51=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> In an effort to tidy up our device documentation split the VirtIO docs
> from the rest of the index and put the index to them at the front of
> the list. Sort the remaining entries alphabetically and tweak the
> references appropriately.
>
> Add a short preface to the VirtIO section nudging users to use VirtIO
> unless they specifically want a particular piece of hardware
> emulation.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/device-emulation.rst              | 18 +++++------
>  docs/system/devices/vfio-user.rst             |  2 +-
>  docs/system/devices/virtio/index.rst          | 30 +++++++++++++++++++
>  .../devices/{ =3D> virtio}/vhost-user-input.rst |  0
>  .../devices/{ =3D> virtio}/vhost-user-rng.rst   |  0
>  .../devices/{ =3D> virtio}/vhost-user.rst       |  0
>  .../devices/{ =3D> virtio}/virtio-gpu.rst       |  0
>  .../devices/{ =3D> virtio}/virtio-pmem.rst      |  0
>  .../devices/{ =3D> virtio}/virtio-snd.rst       |  0
>  9 files changed, 38 insertions(+), 12 deletions(-)
>  create mode 100644 docs/system/devices/virtio/index.rst
>  rename docs/system/devices/{ =3D> virtio}/vhost-user-input.rst (100%)
>  rename docs/system/devices/{ =3D> virtio}/vhost-user-rng.rst (100%)
>  rename docs/system/devices/{ =3D> virtio}/vhost-user.rst (100%)
>  rename docs/system/devices/{ =3D> virtio}/virtio-gpu.rst (100%)
>  rename docs/system/devices/{ =3D> virtio}/virtio-pmem.rst (100%)
>  rename docs/system/devices/{ =3D> virtio}/virtio-snd.rst (100%)
>
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulat=
ion.rst
> index 911381643f1..db714ad47aa 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -82,22 +82,18 @@ Emulated Devices
>  .. toctree::
>     :maxdepth: 1
>
> +   devices/virtio/index.rst
> +
>     devices/can.rst
> +   devices/canokey.rst
>     devices/ccid.rst
>     devices/cxl.rst
> -   devices/vfio-user.rst
> -   devices/ivshmem.rst
> +   devices/igb.rst
>     devices/ivshmem-flat.rst
> +   devices/ivshmem.rst
>     devices/keyboard.rst
>     devices/net.rst
>     devices/nvme.rst
> -   devices/usb.rst
> -   devices/vhost-user.rst
> -   devices/virtio-gpu.rst
> -   devices/virtio-pmem.rst
> -   devices/virtio-snd.rst
> -   devices/vhost-user-input.rst
> -   devices/vhost-user-rng.rst
> -   devices/canokey.rst
>     devices/usb-u2f.rst
> -   devices/igb.rst
> +   devices/usb.rst
> +   devices/vfio-user.rst
> diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio=
-user.rst
> index b6dcaa5615e..30c2215f4ea 100644
> --- a/docs/system/devices/vfio-user.rst
> +++ b/docs/system/devices/vfio-user.rst
> @@ -6,7 +6,7 @@ vfio-user
>
>  QEMU includes a ``vfio-user`` client. The ``vfio-user`` specification al=
lows for
>  implementing (PCI) devices in userspace outside of QEMU; it is similar t=
o
> -``vhost-user`` in this respect (see :doc:`vhost-user`), but can emulate =
arbitrary
> +``vhost-user`` in this respect (see :doc:`virtio/vhost-user`), but can e=
mulate arbitrary
>  PCI devices, not just ``virtio``. Whereas ``vfio`` is handled by the hos=
t
>  kernel, ``vfio-user``, while similar in implementation, is handled entir=
ely in
>  userspace.
> diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/v=
irtio/index.rst
> new file mode 100644
> index 00000000000..bb44b14423e
> --- /dev/null
> +++ b/docs/system/devices/virtio/index.rst
> @@ -0,0 +1,30 @@
> +VirtIO Devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +VirtIO devices are paravirtualized devices designed to be efficient to
> +emulate and virtualize. Unless you are specifically trying to exercise
> +a driver for some particular hardware they are the recommend device

s/recommend/recommended

> +models to use for virtual machines.
> +
> +The `VirtIO specification`_ is an open standard managed by OASIS. It
> +describes how a *driver* in a guest operating system interacts with
> +the *device* model provided by QEMU. Multiple Operating Systems
> +support drivers for VirtIO with Linux perhaps having the widest range
> +of device types supported.
> +
> +The device implementation can either be provided wholly by QEMU, or in
> +concert with the kernel (known as *vhost*). The device implementation
> +can also be off-loaded to an external process via :ref:`vhost user
> +<vhost_user>`.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   virtio-gpu.rst
> +   virtio-pmem.rst
> +   virtio-snd.rst
> +   vhost-user.rst
> +   vhost-user-input.rst
> +   vhost-user-rng.rst
> +
> +.. _VirtIO specification: https://docs.oasis-open.org/virtio/virtio/v1.3=
/virtio-v1.3.html
> diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devic=
es/virtio/vhost-user-input.rst
> similarity index 100%
> rename from docs/system/devices/vhost-user-input.rst
> rename to docs/system/devices/virtio/vhost-user-input.rst
> diff --git a/docs/system/devices/vhost-user-rng.rst b/docs/system/devices=
/virtio/vhost-user-rng.rst
> similarity index 100%
> rename from docs/system/devices/vhost-user-rng.rst
> rename to docs/system/devices/virtio/vhost-user-rng.rst
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vir=
tio/vhost-user.rst
> similarity index 100%
> rename from docs/system/devices/vhost-user.rst
> rename to docs/system/devices/virtio/vhost-user.rst
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/vir=
tio/virtio-gpu.rst
> similarity index 100%
> rename from docs/system/devices/virtio-gpu.rst
> rename to docs/system/devices/virtio/virtio-gpu.rst
> diff --git a/docs/system/devices/virtio-pmem.rst b/docs/system/devices/vi=
rtio/virtio-pmem.rst
> similarity index 100%
> rename from docs/system/devices/virtio-pmem.rst
> rename to docs/system/devices/virtio/virtio-pmem.rst
> diff --git a/docs/system/devices/virtio-snd.rst b/docs/system/devices/vir=
tio/virtio-snd.rst
> similarity index 100%
> rename from docs/system/devices/virtio-snd.rst
> rename to docs/system/devices/virtio/virtio-snd.rst
> --
> 2.47.2
>
>

