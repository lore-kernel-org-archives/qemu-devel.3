Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF7FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8fH-0003B5-Vx; Thu, 04 Jun 2026 10:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wV8f9-00039Q-52
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:03:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wV8f7-000326-Ev
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:03:10 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68ae265815aso1390619a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 07:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780581788; cv=none;
 d=google.com; s=arc-20240605;
 b=Q5eqCjltFftISHs+x0oJbQjoJYBAJJJgt5F7fV/OMkJTPf/NYb+Hteuwy9daVUQkjn
 38ci8rB0i9aDceTT0ijRq6MWUZrL2isTII5fE6I/h3HASN0//8a2uT5dBq948Qc6rN05
 zfHSI+xshZ8FhODasxsl8dIcuvriRJcNcYm5uJ+vAT9rtrM24hTA2jclCQOMC2xXOvWk
 8QybAzJi69Fdt+UirI0XzINkGiS3/OnGor9AoFT0GLcl/eqMVsMuoqWm2+86lNu7sTMV
 RnyqSgGw/7/96V8uIJ7+nK4FJtJF5Y1gNid6WOivq+Ju5K1nCESM/kP785I4RnMgziDp
 jQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DRKQ5csxONxEAsGj3yGZlwH1WMIq0MUto8HiPFP77j4=;
 fh=VCry32mHH7hkgQVtJ8m+xMvReaGCR7EOuBssnL7YkvU=;
 b=QNWJZp6xfXmIVEjmrTJBsWb4meRO5xLyLECt/O2P+GhEjT7m6MWn/4xq8dBF6hDZxj
 8QhjRisXylFC0FfkbQMD3CahOw2/S9+OgBK4+15Uhk/rRSkok33zPsqniG1kXtb+Oecv
 r3tGM/emWGd4p5ZKBwHGeZsS4AKu1IZa7VKDvmGuRwHXXUPeEZsdAuQPuF9fDuXzaVl+
 kRX+gTS+1JTHoSxAkbIDEM9r56CBC/q7VVfA0F8AgsTdk1gRX9v6LwduE1qgzSsr3KmJ
 5Lbb8mQ1t9sT/jfGB6V9ktNlHWx2/auxkMkvJswQ+7YdsbwGcSHTMfUcumAhu8oD0kL4
 yDYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581788; x=1781186588; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRKQ5csxONxEAsGj3yGZlwH1WMIq0MUto8HiPFP77j4=;
 b=b7vPRs9cV+q6vZjy/dgD9A63F+y75zhfWMFNN05l/jQrHNLGoHlMPZPdWeQI2LNF+J
 7mAKHbtzNdU1a1czAfhDKpvigSUlOLl4jOZ+w7OPvOARXy5Egdh/xNvUvn4P62EpVQF0
 ecGHfxOj/omfhFsW98MIF2GDVS19PdWeTr+MkTRqtDXEvfdRQE88SueAY5QsceKZM566
 ihTL0MPz+o3E7PKmj864o79HRtY2rKrm/wZdyiQ46TbBmlE33krAfZWcpfCknZUkivg5
 JX7emA3L2Fh/NuCb8y+yKznQ9bhrxl44ja6gyZRIoQx3pqc0ZMlzb3YN7jiPKDtIYV5R
 puwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581788; x=1781186588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DRKQ5csxONxEAsGj3yGZlwH1WMIq0MUto8HiPFP77j4=;
 b=iMOksTYWthpvDpKtLUHmpD07B/1Hjzta7SeGbjFlKDOLlE6dakCZ9w6+bCe3BImokI
 XjYMcCNwmbN1muznA2tjMWXVxktD+MssiV57TQchTME9nAu2gcUgpKKu8Xa36UgzIfi7
 ePtdXfERqIBMzTk/PgvhU9n0RWVpKJRstG3jrYxU1HPoxr/pLhwoOBGdxbhVPqFwSKmC
 XO1wUWNDatvf1VCnY3vswCrc9WMkgYsghKGaQXtPycg5VdpsMmYslHAI2xGMY5VXEe4+
 SL/OC1j/eRXpFVJDjfbHspx0AIJozHTaX7Qos6nnh7uDPnIwiQgKVvToGaLzL8R5U7is
 EowA==
X-Gm-Message-State: AOJu0YyD0gxNkqONVk0g83pNauKsSQDVHsVIFs3ug54RARfJaFlzGIDt
 +mvXw9FTS2Bn2BW18QFqRc9PVOkqBa0eCvarUzRYN7UNgi5F4UvkO7WqNao0diDa0CXBhCEChRa
 taW/IDk3eve8YFF5P4HFRWjWYkvUulTU=
X-Gm-Gg: Acq92OH2I9Aq2Fx6ZosPfoqZ62xJ7mzSWlEKIcd4STEi8Vjcwp0aOQ+QP2jjrxo9qOd
 YiCyqCtM0+c6ZImKCmtKmt8M+o+f5+3QXHX7wlA56l8xRiKDU+pV8ymYYbOVaYiSYLv59Uw91Qz
 gd0WUc+j1AM9wFr7TQ4pe3ITC/DRGklTTgMAf9bWyUMf1LGF5Z6x6Z4qjQDfMM/d+ZLutCkEVJc
 KhU76o6bBvuuijYz+CEd16KrtcwRUjoPCLecrTF1IE7sCAvSjLvuv4TY3+vmZ6thvWY+Xyswsvj
 I4fuS7GrYXBh+TTdNe0xGHEYqMKMw/QwAYDlC5SwukrV07EWcyOd
X-Received: by 2002:a05:6402:e9f:b0:687:ece2:aac6 with SMTP id
 4fb4d7f45d1cf-68e713e302fmr4097041a12.15.1780581787345; Thu, 04 Jun 2026
 07:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260603223430.3311916-1-connorkite@gmail.com>
In-Reply-To: <20260603223430.3311916-1-connorkite@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 4 Jun 2026 10:02:54 -0400
X-Gm-Features: AVHnY4IYL9xqBWnO6foyS0QmMUJfnpLH4pT4QKZOhZQXRHQpI7wc7Zvp7V0d4Hk
Message-ID: <CAJSP0QVYq1PL2s1YeS7WW46BC+7zkCe85Foh-Q-jjB01B3Nqgg@mail.gmail.com>
Subject: Re: [PATCH 0/2] vhost-user: Add and consolidate qdev properties
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, ConKite <connorkite@gmail.com>, 
 Alex Bennee <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 3, 2026 at 6:34=E2=80=AFPM ConKite <connorkite@gmail.com> wrote=
:
>
> [1/2] Consolidate chardev qdev property definitions in the
> VHostUserBase family of devices.  Now, the definition only takes place
> within VHostUserBase initialization and is inherited by children.

This patch can be merged right away. It's a cleanup for vhost-user-base.

>
> [2/2] In support of future work to add a memory isolation mode to vhost-u=
ser
> devices, a qdev property, "memory-isolation", is added to all vhost-user
> devices.  This is simply a bool representing whether the mode is active
> or not.

This patch will need to wait until the memory isolation work is
completed since the qdev property currently does nothing.

>
> These patches are grouped together as they both touch on qdev properties
> held in common by all vhost-user devices.  Taken together, these patches
> ensure that commmon properties are defined in the same location and way.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
> ConKite (2):
>   vhost-user: Consolidate chardev property definitions
>   vhost-user: Add memory-isolation qdev property to vhost-user devices
>
>  hw/block/vhost-user-blk.c            |  1 +
>  hw/display/vhost-user-gpu.c          |  1 +
>  hw/scsi/vhost-user-scsi.c            |  1 +
>  hw/virtio/vhost-user-base.c          | 10 ++++++++++
>  hw/virtio/vhost-user-fs.c            |  1 +
>  hw/virtio/vhost-user-gpio.c          |  4 ----
>  hw/virtio/vhost-user-i2c.c           |  5 -----
>  hw/virtio/vhost-user-input.c         |  5 -----
>  hw/virtio/vhost-user-rng.c           |  5 -----
>  hw/virtio/vhost-user-rtc.c           |  4 ----
>  hw/virtio/vhost-user-scmi.c          |  1 +
>  hw/virtio/vhost-user-snd.c           |  1 -
>  hw/virtio/vhost-user-spi.c           |  5 -----
>  hw/virtio/vhost-user-test-device.c   |  1 -
>  hw/virtio/vhost-user-vsock.c         |  1 +
>  include/hw/virtio/vhost-user-base.h  |  1 +
>  include/hw/virtio/vhost-user-blk.h   |  1 +
>  include/hw/virtio/vhost-user-fs.h    |  1 +
>  include/hw/virtio/vhost-user-scmi.h  |  1 +
>  include/hw/virtio/vhost-user-vsock.h |  1 +
>  include/hw/virtio/virtio-gpu.h       |  1 +
>  include/hw/virtio/virtio-scsi.h      |  1 +
>  22 files changed, 23 insertions(+), 30 deletions(-)
>
> --
> 2.43.0
>

