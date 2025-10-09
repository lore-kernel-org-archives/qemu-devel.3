Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1628CCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w0U-0002Cx-LY; Thu, 09 Oct 2025 15:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w0S-0002BA-Rq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:52 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w0N-0007K5-QA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:52 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-42e2c336adcso4905935ab.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036926; x=1760641726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8C3dtav+h3RSE8hr86Bb+ORjEBNjaKenGTx0JbnF18=;
 b=krurQ3slv/lNSSMtEeOmWTybj5PG/YFdaCOyQY3383XFiCK5btcKeIcAvhFx99goOk
 3/X1r/W44vCZKRJh0BZCBgYHrMzF9YH5MKeMXf+cvwoqxosTCyPmSEICxCFY/8Sky5rI
 1D9LOqT82y54TGAubpuTGORDz14MEaX2JxhjTLoo0zaSQoaGHBqgkJIR0DvyALONoe70
 I229mzL5DXq7Oaet259OQMQ1VX1S/Ezqvj32RKTQmJO0zaMd9k0dR24cv4xEF0oB5S99
 76FY9gGdSFpPr9I4ISeBLc2sMh1vriWzVBbHc9ukOL/7jeb1K+sZerTQoYZBclkSTudW
 6UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036926; x=1760641726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8C3dtav+h3RSE8hr86Bb+ORjEBNjaKenGTx0JbnF18=;
 b=l3x2y/KS6trrFQ4+RYZ4PxUsSFXM+onD+xxAZUH/JrHIjHTLU5oA264VwxedbgaBeh
 IrJb8BcCubfJeSJ0duPwWBn/qfl4pQJnSAha2/Wvd3k5YLbxdtCH5MzINNGQwoYF3LMF
 j8Cth8x6DL0yhCtlw6p6w8rNZxucGTXD5Y+UGi2oC863ZmOOS7Vdj/rKQayOEiMV7sAS
 vs5/ZqK+YfuhFQXv2Y+c+mRq5MZKp2B0g0vkcHKCxbroHIx4XoCFQhySFgJ3Lu7KeIhM
 4SO+LZi+/2z/1sG8VCSGqfKNsSgT+amGZzhxXNJSfj6bHJ+bl4k8gxt+mBc30zTKIa1X
 W1lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/6P0iLSy749/esUaT3P21waLCCW259ZtMmLYbu6KbKDPvACpinGSIOFwn0Peyld4wCYmHTmN6VkQu@nongnu.org
X-Gm-Message-State: AOJu0Yyrtp3Mi2nx77uWypSrGR/63Y+u9X4yhhi0pga78IT+HG7ySqdg
 H8BLRoVqFYRfFyftrvVK9IATQhz0tC558nC8vt3okQJizxPQOJnoKIIKtqgbpSoyaicrY4OACMG
 Vv80efo+7cxI86BCrTmIxh5UxMX8XlUg=
X-Gm-Gg: ASbGncuNXPbPzXpYJAPXLbaC2RGgIXJil0mTRO07VDAdKvhGSsyq1nYGonoNVtGoPuP
 y3KWtOmXDkVnMjF/T+NunSpj3Sk3fX6o8Diern3JU61RzmfwgWVwQKWfVvM+Rw8LI3hTc46o/PD
 zZ95+JFyH8O3FJqdXSiAnmYU8dNmshcQsaZtChuEftufIPoXmMRJ1stD3byheLJcr5PfQwgyLyJ
 YqyeEWYjsfRUQXqJK8PJMh5fy+iwG8=
X-Google-Smtp-Source: AGHT+IEZROvLjYMsf3VTrdQXXr0t+9dbC6OPWvC82KA6l83h+EurmdDYA2KANkjIecIM8d0A618yVTUDXIbzPKE6utU=
X-Received: by 2002:a05:6e02:4417:10b0:42f:8d6c:f523 with SMTP id
 e9e14a558f8ab-42f8d6cf8e3mr47371025ab.20.1760036926287; Thu, 09 Oct 2025
 12:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-26-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-26-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:08:34 -0400
X-Gm-Features: AS18NWB5BHwVZCZlfVxAwUd-vIyVoFBD-HAd-HPW-CO-8uK5MzUS842DR9FdZNo
Message-ID: <CAFubqFvSsZCzJViJDEi7j_Sv3ssy=XmS9MoYGW-Tm3RNrDDnLA@mail.gmail.com>
Subject: Re: [PATCH 25/33] virtio: introduce .skip_vhost_migration_log()
 handler
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x135.google.com
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

Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 1:00=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> For vhost user backend migration we'll need to disable memory
> logging on the device. Let's prepare a corresponding handler for
> the device.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c          | 10 ++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e7c809400b..0427fc29b2 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1134,6 +1134,16 @@ static int vhost_migration_log(MemoryListener *lis=
tener, bool enable)
>      struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
>                                           memory_listener);
>      int r;
> +
> +    if (dev->vdev) {
> +        VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(dev->vdev);
> +
> +        if (vdc->skip_vhost_migration_log &&
> +            vdc->skip_vhost_migration_log(dev->vdev)) {
> +            return 0;
> +        }
> +    }
> +
>      if (enable =3D=3D dev->log_enabled) {
>          return 0;
>      }
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 8b9db08ddf..9a4a0a94aa 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -234,6 +234,8 @@ struct VirtioDeviceClass {
>      /* May be called even when vdev->vhost_started is false */
>      struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
>      void (*toggle_device_iotlb)(VirtIODevice *vdev);
> +
> +    bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
>  };
>
>  void virtio_instance_init_common(Object *proxy_obj, void *data,
> --
> 2.48.1
>
>

