Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E4CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVrM-00027M-6j; Tue, 02 Sep 2025 14:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1utVrK-00026r-2Z
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:35:58 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1utVrH-0003J7-NZ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:35:57 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b043da5a55fso282753266b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756838154; x=1757442954; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgJ5LmNZbCJRpe9P9fG+HETolPxEF+ToTGvGrxZxzgI=;
 b=dIavvW60UMbPbtvhdLsihqlwfsxuO5Xp/173KaUOTs47LTjLczrBV4K+ne2EOJHMP0
 xS8q2ZbWqSUMhwQ8IL7jzllRA/GzDmRlTrEakZlsxbTZ7mNSgXsdE5C1MzevBi039s9q
 W7mY/uaaYKXrG8uIkZg+D5MLakypceowoNFoaBcLEIw2XZM3y1xaVl6UL874QtlEin4L
 olbkBepl3HTbQoSWwEmAR4UKZ/FIRy087dEwNJv5IaRWQxdes7iYBs4eAtkqI8mlB5AR
 EVEd7L6VXPCxMBrlWdaNggTqNSGK/xf1+5Eblbqkx0HvfwYesaPPqa+0TkHdq3pwQ93Y
 Jp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756838154; x=1757442954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgJ5LmNZbCJRpe9P9fG+HETolPxEF+ToTGvGrxZxzgI=;
 b=o2IDxvwMJULc5a6ZmXIgs/vahEqQMTBj+Cg0CYmq7Rz41+y45GxlRiZlnR//KASLAW
 utfcrw16whSafMfoJkY0AyKidWTOvEv5goBhWW3EN2PjDRhKAYQntrfqNmmN9V65J/Dd
 s5wC+Et2fOL4Kp7MmxvmpHlqUzcCHIwII1hKxOwwBZU02fnfN+bjnSDOT2gUK4xtdhDj
 PxOXerw6z/7gbedVpTqbPrT5canV2KZtQ/u1y8BAa0zW6KLz+lSRuvYSH0+TMsanVPao
 WRLMp6CVtRYwU9/xxr4xeAu60/Hfx0Q4bu9v3Mlqr7yzndpoPXmK5z0jux/cYeXwJ6Te
 2raA==
X-Gm-Message-State: AOJu0YyniWNg51frTbohpDcVpknT+eX6ZVtyq8uu9N03dkuN0Y6wLqWe
 TpkAT0dc639FBU/wJ1j+ir7aLWRYQA/GA6Cz6+IdTM8rAGV7lI/c12embWXTf7xSkiuuFUPUNOh
 32qtzL2l/ya4z9UyZ20AX+mGMw6KWHHsCpN5cUtVhlw==
X-Gm-Gg: ASbGncv9Iz7ljHEox/4CRehsMAAM8WLUZ1qT8DsYVp6QpkbWkvCMW5ycPXVefn8U1zq
 uVcUaO1IQxRjpn+nxiWa080+c1cA59DPgfApK4fbOdPimOSDwS/TySK1Way+zwX9g2uHNDd+yqc
 7+7K3yv9mq5lC30VLe75QkrrVb33KC9+DnHLQej2IEX6Dr9kzd7IK4nuUZhjtkaCizToKPZh7zb
 /lQ63Tj
X-Google-Smtp-Source: AGHT+IHdeNwfrUhhjhEH+wcyP6Pge72iO1Oj6w5uMSohjoJf4Vvrw8jDO8L/HlKdr9Muus2A/2Jm6m7x8Kwelm2+i4s=
X-Received: by 2002:a17:907:9810:b0:b04:3fe2:23c4 with SMTP id
 a640c23a62f3a-b043fe2249fmr575593266b.19.1756838154089; Tue, 02 Sep 2025
 11:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
 <20250902165048.1653323-5-alex.bennee@linaro.org>
In-Reply-To: <20250902165048.1653323-5-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 2 Sep 2025 21:35:27 +0300
X-Gm-Features: Ac12FXxGbEnY85UZwdj9Fd_NnAfPhsSz8hBXi0VAAfCgOl9g3y_mi_WNm4z-CCc
Message-ID: <CAAjaMXbXwuMWOqpEk-iR+moPmxq8TjezcuEToDPwp5QXb6Bj-g@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs/system: merge vhost-user-input into
 vhost-user-contrib
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

With typo fixes:

On Tue, Sep 2, 2025 at 7:51=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> We might as well group all the contrib submissions together and gently
> dissuade people from using them in production. Update the references in
> vhost-user to neatly refer to the storage daemon and the various
> external rust backends.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/devices/virtio/index.rst          |  2 +-
>  .../devices/virtio/vhost-user-contrib.rst     | 87 +++++++++++++++++++
>  .../devices/virtio/vhost-user-input.rst       | 45 ----------
>  docs/system/devices/virtio/vhost-user.rst     | 22 ++---
>  docs/system/devices/virtio/virtio-gpu.rst     |  2 +
>  5 files changed, 101 insertions(+), 57 deletions(-)
>  create mode 100644 docs/system/devices/virtio/vhost-user-contrib.rst
>  delete mode 100644 docs/system/devices/virtio/vhost-user-input.rst
>
> diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/v=
irtio/index.rst
> index 7f931737cc1..04588fa78ab 100644
> --- a/docs/system/devices/virtio/index.rst
> +++ b/docs/system/devices/virtio/index.rst
> @@ -24,6 +24,6 @@ can also be off-loaded to an external process via :ref:=
`vhost user
>     virtio-pmem.rst
>     virtio-snd.rst
>     vhost-user.rst
> -   vhost-user-input.rst
> +   vhost-user-contrib.rst
>
>  .. _VirtIO specification: https://docs.oasis-open.org/virtio/virtio/v1.3=
/virtio-v1.3.html
> diff --git a/docs/system/devices/virtio/vhost-user-contrib.rst b/docs/sys=
tem/devices/virtio/vhost-user-contrib.rst
> new file mode 100644
> index 00000000000..10a92c19e82
> --- /dev/null
> +++ b/docs/system/devices/virtio/vhost-user-contrib.rst
> @@ -0,0 +1,87 @@
> +vhost-user daemons in contrib
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +QEMU provides a number of :ref:`vhost_user` daemons in the contrib
> +directory. They were often written when vhost-user was initially added
> +to the code base. You should also consider if other vhost-user daemons
> +such as those from the rust-vmm `vhost-device repository`_ are better
> +suited for production use.
> +
> +.. _vhost-device repository: https://github.com/rust-vmm/vhost-device
> +
> +.. _vhost_user_block:
> +
> +vhost-user-block - block device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +vhost-user-block is a backed for exposing block devices. It can

s/backed/backend

> +present a flat file or block device as a simple block device to the
> +guest. You almost certainly want to use the :ref:`storage-daemon`

s/the//

?

> +instead which supports the wide variety of storage modes and exports a

s/the/a/

> +number of interfaces include vhost-user.

s/include/including


> +
> +.. _vhost_user_gpu:
> +
> +vhost-user-gpu - gpu device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +vhost-user-gpu presents a paravirtualized GPU and display controller.
> +You probably want to use the internal :ref:`virtio_gpu` implementation
> +if you want the latest features. There is also a `vhost_device_gpu`_
> +daemon as part of the rust-vmm project.
> +
> +.. _vhost_device_gpu: https://github.com/rust-vmm/vhost-device/tree/main=
/vhost-device-gpu
> +
> +.. _vhost_user_input:
> +
> +vhost-user-input - Input emulation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Virtio input device is a paravirtualized device for input events.
> +
> +Description
> +-----------
> +
> +The vhost-user-input device implementation was designed to work with a d=
aemon
> +polling on input devices and passes input events to the guest.
> +
> +QEMU provides a backend implementation in contrib/vhost-user-input.
> +
> +Linux kernel support
> +--------------------
> +
> +Virtio input requires a guest Linux kernel built with the
> +``CONFIG_VIRTIO_INPUT`` option.
> +
> +Examples
> +--------
> +
> +The backend daemon should be started first:
> +
> +::
> +
> +  host# vhost-user-input --socket-path=3Dinput.sock      \
> +      --evdev-path=3D/dev/input/event17
> +
> +The QEMU invocation needs to create a chardev socket to communicate with=
 the
> +backend daemon and access the VirtIO queues with the guest over the
> +:ref:`shared memory <shared_memory_object>`.
> +
> +::
> +
> +  host# qemu-system                                                     =
       \
> +      -chardev socket,path=3D/tmp/input.sock,id=3Dmouse0                =
           \
> +      -device vhost-user-input-pci,chardev=3Dmouse0                     =
         \
> +      -m 4096                                                           =
       \
> +      -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm=
,share=3Don    \
> +      -numa node,memdev=3Dmem                                           =
         \
> +      ...
> +
> +
> +.. _vhost_user_scsi:
> +
> +vhost-user-scsi - SCSI controller
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The vhost-user-scsi daemon can proxy iSCSI devices onto a virtualized
> +SCSI controller.
> diff --git a/docs/system/devices/virtio/vhost-user-input.rst b/docs/syste=
m/devices/virtio/vhost-user-input.rst
> deleted file mode 100644
> index 118eb78101c..00000000000
> --- a/docs/system/devices/virtio/vhost-user-input.rst
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -.. _vhost_user_input:
> -
> -QEMU vhost-user-input - Input emulation
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -This document describes the setup and usage of the Virtio input device.
> -The Virtio input device is a paravirtualized device for input events.
> -
> -Description
> ------------
> -
> -The vhost-user-input device implementation was designed to work with a d=
aemon
> -polling on input devices and passes input events to the guest.
> -
> -QEMU provides a backend implementation in contrib/vhost-user-input.
> -
> -Linux kernel support
> ---------------------
> -
> -Virtio input requires a guest Linux kernel built with the
> -``CONFIG_VIRTIO_INPUT`` option.
> -
> -Examples
> ---------
> -
> -The backend daemon should be started first:
> -
> -::
> -
> -  host# vhost-user-input --socket-path=3Dinput.sock      \
> -      --evdev-path=3D/dev/input/event17
> -
> -The QEMU invocation needs to create a chardev socket to communicate with=
 the
> -backend daemon and access the VirtIO queues with the guest over the
> -:ref:`shared memory <shared_memory_object>`.
> -
> -::
> -
> -  host# qemu-system                                                     =
       \
> -      -chardev socket,path=3D/tmp/input.sock,id=3Dmouse0                =
           \
> -      -device vhost-user-input-pci,chardev=3Dmouse0                     =
         \
> -      -m 4096                                                           =
       \
> -      -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm=
,share=3Don    \
> -      -numa node,memdev=3Dmem                                           =
         \
> -      ...
> diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devi=
ces/virtio/vhost-user.rst
> index 9c9a28df380..f556a840e99 100644
> --- a/docs/system/devices/virtio/vhost-user.rst
> +++ b/docs/system/devices/virtio/vhost-user.rst
> @@ -27,37 +27,37 @@ platform details for what sort of virtio bus to use.
>      - Notes
>    * - vhost-user-blk
>      - Block storage
> -    - See contrib/vhost-user-blk
> +    - :ref:`storage-daemon`
>    * - vhost-user-fs
>      - File based storage driver
> -    - See https://gitlab.com/virtio-fs/virtiofsd
> +    - `virtiofsd <https://gitlab.com/virtio-fs/virtiofsd>`_
>    * - vhost-user-gpio
>      - Proxy gpio pins to host
> -    - See https://github.com/rust-vmm/vhost-device
> +    - `vhost-device-gpio <https://github.com/rust-vmm/vhost-device/tree/=
main/vhost-device-gpio>`_
>    * - vhost-user-gpu
>      - GPU driver
> -    - See contrib/vhost-user-gpu
> +    - `vhost-device-gpu <https://github.com/rust-vmm/vhost-device/tree/m=
ain/vhost-device-gpu>`_ or :ref:`vhost_user_gpu`
>    * - vhost-user-i2c
>      - Proxy i2c devices to host
> -    - See https://github.com/rust-vmm/vhost-device
> +    - `vhost-device-i2c <https://github.com/rust-vmm/vhost-device/tree/m=
ain/vhost-device-i2c>`_
>    * - vhost-user-input
>      - Generic input driver
> -    - :ref:`vhost_user_input`
> +    - `vhost-device-input <https://github.com/rust-vmm/vhost-device/tree=
/main/vhost-device-input>`_ or :ref:`vhost_user_input`
>    * - vhost-user-rng
>      - Entropy driver
> -    - See https://github.com/rust-vmm/vhost-device
> +    - `vhost-device-rng <https://github.com/rust-vmm/vhost-device/tree/m=
ain/vhost-device-rng>`_
>    * - vhost-user-scmi
>      - System Control and Management Interface
> -    - See https://github.com/rust-vmm/vhost-device
> +    - `vhost-device-scmi <https://github.com/rust-vmm/vhost-device/tree/=
main/vhost-device-scmi>`_
>    * - vhost-user-snd
>      - Audio device
> -    - See https://github.com/rust-vmm/vhost-device/staging
> +    - `vhost-device-sound <https://github.com/rust-vmm/vhost-device/tree=
/main/vhost-device-sound>`_
>    * - vhost-user-scsi
>      - SCSI based storage
> -    - See contrib/vhost-user-scsi
> +    - :ref:`vhost_user_scsi`
>    * - vhost-user-vsock
>      - Socket based communication
> -    - See https://github.com/rust-vmm/vhost-device
> +    - `vhost-device-vsock <https://github.com/rust-vmm/vhost-device/tree=
/main/vhost-device-vsock>`_
>
>  The referenced *daemons* are not exhaustive, any conforming backend
>  implementing the device and using the vhost-user protocol should work.
> diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devi=
ces/virtio/virtio-gpu.rst
> index 39d2fd2d21c..0f4bb304a9b 100644
> --- a/docs/system/devices/virtio/virtio-gpu.rst
> +++ b/docs/system/devices/virtio/virtio-gpu.rst
> @@ -1,6 +1,8 @@
>  ..
>     SPDX-License-Identifier: GPL-2.0-or-later
>
> +.. _virtio_gpu:
> +
>  VirtIO GPU
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.47.2
>
>

