Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1C8CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAz50-0001NM-In; Mon, 20 Oct 2025 19:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAz4y-0001Mb-45
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:14:16 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAz4w-0006p0-DD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:14:15 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-430ab5ee3e7so17209455ab.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002053; x=1761606853; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFu++t6nWzWsIpgTCmCuop0cyVPPR2XedjSykIyCsK8=;
 b=DaT7nLSJeCLIXF7Eh7w8LJWAqy0q9Qym6YXk2Uti2oxEFvPlzdUAv2V7fHIamodI93
 gGwHdFwoC/mnS//j2oyT6SczjQR8ctG4Obo6GPo3ljVGMbihlO0xGjCIXNplMbUnYGl5
 ccpmFF1i6wr1lHzgAx8l69Y6DyC2IZ1BD8QfkacdRSRXmNfy2ADknkNuQZERUQ1iGQmw
 vXW+tp7LXfl+jBw478lZ/C8+lAMVBPC7zzq6oB7Ofi0f81vcYDTRa0uUUmh2KhKTDbFr
 It28OJeDMpj1TKwe8/hLza+8Y2PDUM2BQfLTOtLbRSkeSTxA352n3coQdMbj25C2sHcV
 hSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002053; x=1761606853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFu++t6nWzWsIpgTCmCuop0cyVPPR2XedjSykIyCsK8=;
 b=neVhQdeFoaQdDTHWQqlErzicUBPTSHXP8AFv258bI5ipnbMO8LoBaZ6Fl23jcnSJGQ
 EvZa8+DQPn4TSx321hydP//cwNVGFhc1rjR3p/5t/Z6KFWCTRM/78wqkR6ZSbW1d6wos
 4u8qGOGjCN40/TNsqadC5L+XNgQ/6JY4zEMWc0k0xq9tP8+x/itbEc1DorVHXikSBUgv
 9t7+VLlozLIz3tlZK94pNRZAdrMgqXX+AGLXit9OpniCoClAnmUOEwcKUlu7S4VQwPNr
 so2GnjAyegDcJSZtV/d8AK84GgS8SzNCxnDH07HAkYlO8EQnXdY1zhRYgfrnGPqOxJrO
 QMqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWewl3VH+5+NuiwDMo+Sz+P9skH3UwobRgky+UxpcpLdwusPXCqeGdpwa8Lvxid5WLMd+5F7khdvzX@nongnu.org
X-Gm-Message-State: AOJu0YwtRUTFM/8Fq7sq5HFDWCWNSSOXPXsDWremS1kwIut+VlC/1LlW
 Y1Z+/innjE6ASbn9sBo1edLw0QTGaJSnOPGgTyyDwoJ+0Qq9ul5Tubb/Wwhse1/If8q1zHcUPzj
 Ka70IfvquiYLBmmKNfEJxdxvWRYJk2d0=
X-Gm-Gg: ASbGnctWwS764Hp3Kfn+in7QhFgqzhyNNVWUD5QIydp+6HERA3n2juVlmxHEkrHMtmx
 99hqbkVZ+CQ6m5s/7eto9y9cO5+n8g8Gd69zo2WdpBjDTazmWFKlOZMM8LVj8DDIfbZQ3/WG123
 KT4vgueyzG2jKEc8kRiBm6bHcgKcb/HoTHCUYY7qO8DXP9XUQDHAbLaFiIGsR7mhlBlxRts1D1Z
 YqivtpCRGr3OgMqED0Gd7ZL4C1RKhzQhKHuFYmGDErAgDA8M+0618ZOamV0
X-Google-Smtp-Source: AGHT+IE2RY/UzXR1jHhdxg21uT7quEvpf9vn9mMrdxkr1HOuzvwRWJSIpjP7zUaQm8nuPZ7oEWDAgcmC98O4v/5MxC8=
X-Received: by 2002:a05:6e02:4617:b0:430:d448:eb41 with SMTP id
 e9e14a558f8ab-430d448ee9fmr125327785ab.31.1761002052677; Mon, 20 Oct 2025
 16:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-2-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-2-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:14:00 -0400
X-Gm-Features: AS18NWDcqMYy4YkEfgLBpatU_QLBU0SpSWQSuWnDQrU8EwRaL9_E8moKQDtPdZA
Message-ID: <CAFubqFtjFfp=9JmXH+mrD7trXKW4xvPi7YOK_y-vWQVZr2B6GQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/25] vhost: store busyloop_timeout into struct
 vhost_dev
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12c.google.com
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>


On Thu, Oct 16, 2025 at 7:50=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We'll split vhost_dev_init() into _init() and _connect(), to be able
> to postpone communication with backend, to support backend-transfer
> migration of vhost-user-blk in future commit.
>
> So, instead of passing it through parameters, store it in vhost_dev
> structure.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c         | 11 +++++------
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 7ba90c24db..9fc6e7ba65 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1501,8 +1501,7 @@ static void vhost_virtqueue_error_notifier(EventNot=
ifier *n)
>  }
>
>  static int vhost_virtqueue_init(struct vhost_dev *dev,
> -                                struct vhost_virtqueue *vq, int n,
> -                                bool busyloop_timeout)
> +                                struct vhost_virtqueue *vq, int n)
>  {
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, n);
>      struct vhost_vring_file file =3D {
> @@ -1539,8 +1538,8 @@ static int vhost_virtqueue_init(struct vhost_dev *d=
ev,
>                                     vhost_virtqueue_error_notifier);
>      }
>
> -    if (busyloop_timeout) {
> -        r =3D vhost_virtqueue_set_busyloop_timeout(dev, n, busyloop_time=
out);
> +    if (dev->busyloop_timeout) {
> +        r =3D vhost_virtqueue_set_busyloop_timeout(dev, n, dev->busyloop=
_timeout);
>          if (r < 0) {
>              VHOST_OPS_DEBUG(r, "Failed to set busyloop timeout");
>              goto fail_err;
> @@ -1628,6 +1627,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>
>      hdev->vdev =3D NULL;
>      hdev->migration_blocker =3D NULL;
> +    hdev->busyloop_timeout =3D busyloop_timeout;
>
>      r =3D vhost_set_backend_type(hdev, backend_type);
>      assert(r >=3D 0);
> @@ -1650,8 +1650,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>      }
>
>      for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
> -        r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i,
> -                                 busyloop_timeout);
> +        r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i);
>          if (r < 0) {
>              error_setg_errno(errp, -r, "Failed to initialize virtqueue %=
d", i);
>              goto fail;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 1ba1af1d86..f1a7e7b971 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -105,6 +105,7 @@ struct vhost_dev {
>      VIRTIO_DECLARE_FEATURES(_features);
>      VIRTIO_DECLARE_FEATURES(acked_features);
>
> +    uint32_t busyloop_timeout;
>      uint64_t max_queues;
>      uint64_t backend_cap;
>      /* @started: is the vhost device started? */
> --
> 2.48.1
>
>

