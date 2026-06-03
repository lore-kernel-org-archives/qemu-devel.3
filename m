Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84DBCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 19:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUrKZ-0006Fp-DD; Wed, 03 Jun 2026 15:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUrKW-0006FC-9i
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:32:44 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUrKU-0002tJ-P3
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:32:44 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68be16c61d1so11687380a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 12:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780515160; cv=none;
 d=google.com; s=arc-20240605;
 b=P4ipBYabuZ0UlCiEiV8tKuLl3iSRJifi8thl97gb82Q+Jgk1Ddfvb++RzwWXINcv8L
 3JiN5rsJvrEy6kz0YTJ6Pkr1mzxvwxPg9LhMAWmVatAhGw+BAWdrZzY885iUoDabfZgW
 YIVvQ+QcRUuMtkgR4zDIWlQl9k7MqP+389pQe9nmvr+wcxPqqkQBlwYd8K63dsMVkzVd
 defNeIv1OwOCWjNh5ZzZjscBqwlGlAptQ52D9kgtFZz5/5dIyy67rnRzoXLFluomfb4U
 aaJynd0S7RD3kJkdzDhZD4xP80ZZP5I1OFd9H4OdwOewsLgXEOfdkt1CsRTLTvUmDEs3
 1hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MiLDmCKfkJ9J4tVABJDyJ7TDyjFkSVo3cc24YELnkjk=;
 fh=I4bPGmFuSJAUDPPBcEbiWZt2Bp8JKDYHn7NU1zWWO5c=;
 b=hmgrxWb0UdLaNRy6Zy68SUVXkFvfEs72EtaooakOT22/T9B/FYEP/HNfFt/7AGnDY+
 eSjRiWs0xicdu6PBBDFid36YXhHW/SBvH/uq0qWy2QMuNOJcCt/Nfnw0wZh+Bt9qAh2M
 3cMsh5RnodhlJPCtDHUA4RRNN8wq+oRWkcdv43EIp0gidAa3uQEaqe1hk/Q/DoCmqQl0
 9t9gZn/cgSujaK+5L1TXcSNCeyEtoFSAPRuylZKjnhtblnKDGrQPj7GUK8DbCfjYJ/Zc
 gchz/aOjwek6m/xrEKd3hL8gVufLMzlNVgmSzuuCWNtcRcChHk30Cd8RFhJiUdy5tW0H
 3/Pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780515160; x=1781119960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiLDmCKfkJ9J4tVABJDyJ7TDyjFkSVo3cc24YELnkjk=;
 b=TFY6gGZ7hyMn+1BeAUKSzsxJ4wIjc6jg3e/zTuqYhJECIqOEo8xslpjYHDIH8unaVe
 dTZeV+lfWnUzlIR38MVEpBUA4SkDsBwYpjaBS02nO5xOT6719S/VTmEXJmUy+2hbyC/r
 3IIwbjsZfhszaV55v9XJEtVqc6lqK1AidK1PvisKdSnJ63QQSf4/G2igSimBVTyu1ytI
 PsfetaeLTe93UbJSHSW2ZJYBIryUyBvIJWuyu9P4O7SZYmIr3APhqIJmVbWxUxkAwOij
 N/SJi8jkxy5VbFK2ZpBxduCZeETK3Pe/Re+cT2ozwHd9r7g+lnwEoArU65R9SXFCnPNv
 uNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780515160; x=1781119960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MiLDmCKfkJ9J4tVABJDyJ7TDyjFkSVo3cc24YELnkjk=;
 b=HqhPYk6wLVgWeTmdbE7wyZfSN8fC1PwFFSNuGbN9JxYbo+tzmhkiJ/09PNU2pZzqao
 mGEebPVkXv3/8hPivc1MbcZ1Nvmb8pn9NQcp8pyT0fahGXDlBXBSi5C5vfcW8YWxdqAm
 uf2Na0qaR4v9Ak70Ld+dhVO3KZ9j2ivxrm+GldR/kVN5gECWW3yvPI0BE305lC509T3p
 HCvcGx8vfNY2z+FQtdnE7nTYjapakk+/RKyN78zwgU6Zrc/vZ2Lvm1jv26fVNyVLrf8g
 +FtRtwNnF7OGWEWMpNDN36KHqYb6d1VdkE4fRobEKyiqwJFNWwbRN85FwGBogkRoFiP/
 oafQ==
X-Gm-Message-State: AOJu0YxOR/JpGngD9yAFLYNvYy2h4qE3IrIKS4mmIcv+9vmnjmekQY8F
 IedO8XID15d834Ft8L9alQtcZcExLTH2pnoFb2S2D/Zq5xoruQ/FZVhsj1ybrltTEbVY3yfejjq
 hcuGksx2+JGGrFWVs2Ytw+C6mhf5hQlg=
X-Gm-Gg: Acq92OGwFVXdx59NGdNLVAJe6YUJo16MDkaNJSTwzffjekHHK23FJ4DGXiFIjojtT6D
 3YEZ+12MKP1kRn6sQWOMjPndYeUoTQ73aZcpxZJdHxIdJ+lAOiYUioAeIwbIhU2SjDg1OA8QalA
 8tBSQpoPYU4v7i5qb1LVu0BvAqreGChxQorc1dkkfDz1hw/ZLdzKbgvgwLcLNp1UtOi3UBk6KDv
 RYdn7xZ7qRS7JK+5wUWQ4Ptx3rm073vLE8dfB7yqGsAqyYu5TSuB1Dmi72N1r4x/Xi8TR5dcC5f
 Tw9RyKE8phB3KO+R4GiuJZGWVsUl0k2kCjlIevmroZC1MQu4xULq
X-Received: by 2002:a05:6402:5018:b0:67b:4e46:f12f with SMTP id
 4fb4d7f45d1cf-68e714dbf07mr2524578a12.25.1780515160399; Wed, 03 Jun 2026
 12:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260603173239.3189102-1-connorkite@gmail.com>
In-Reply-To: <20260603173239.3189102-1-connorkite@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 3 Jun 2026 15:32:26 -0400
X-Gm-Features: AVHnY4ILFxQf-lOnRxA7QyQV9iwiOx0GcTBIOiO-V9IubAe_jtsZ4Md6akgj4C4
Message-ID: <CAJSP0QVU=aU_QY8jjEAoeXhEwkbeREMV8gmQwuzNh1PSANwRPQ@mail.gmail.com>
Subject: Re: [RFC] vhost-user: Add memoryIsolation qdev property to vhost-user
 devices
To: ConKite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
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

On Wed, Jun 3, 2026 at 1:33=E2=80=AFPM ConKite <connorkite@gmail.com> wrote=
:
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 01ab9ca56b..cbc5792ac7 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -353,9 +353,17 @@ static void vub_device_unrealize(DeviceState *dev)
>      do_vhost_user_cleanup(vdev, vub);
>  }
>
> +//Define common properties
> +static const Property vub_properties[] =3D {
> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memoryIsolation,=
 false),

From docs/devel/style.rst:

- "We use traditional C-style /``*`` ``*``/ comments and avoid // comments.=
"
- "Variables are lower_case_with_underscores". memoryIsolation ->
memory_isolation.

You can run scripts/checkpatch.pl to catch many coding style issues.
Here is a git-hook to automatically do that when you commit:
https://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.htm=
l

> diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
> index d473f87077..33b8752282 100644
> --- a/hw/virtio/vhost-user-gpio.c
> +++ b/hw/virtio/vhost-user-gpio.c
> @@ -14,9 +14,6 @@
>  #include "standard-headers/linux/virtio_ids.h"
>  #include "standard-headers/linux/virtio_gpio.h"
>
> -static const Property vgpio_properties[] =3D {
> -    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> -};
>
>  static void vgpio_realize(DeviceState *dev, Error **errp)
>  {
> @@ -42,7 +39,6 @@ static void vu_gpio_class_init(ObjectClass *klass, cons=
t void *data)
>      VHostUserBaseClass *vubc =3D VHOST_USER_BASE_CLASS(klass);
>
>      dc->vmsd =3D &vu_gpio_vmstate;
> -    device_class_set_props(dc, vgpio_properties);
>      device_class_set_parent_realize(dc, vgpio_realize,
>                                      &vubc->parent_realize);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);

Moving chardev into the base class is a nice refactoring in itself and
its independent of introducing the memory-isolation property.
Separating self-contained changes into their own commits makes it
easier for reviewers to understand your patch series and it helps with
backporting and bisection (e.g. which change caused the breakage:
introducing memory-isolation or moving chardev?).

I suggest splitting this commit into two commits:
1. Move chardev into the base class.
2. Add the memory-isolation property.

