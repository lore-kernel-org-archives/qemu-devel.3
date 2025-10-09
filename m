Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7236ACCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vyd-0007ul-41; Thu, 09 Oct 2025 15:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vyb-0007uG-Ii
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:06:57 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vyZ-0007Bn-CE
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:06:57 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-92790f12293so58014239f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036813; x=1760641613; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNvGh78jSALi+oq6g8hAjx+8CQBlAGd5faXm34Ccqvg=;
 b=XDxV8KYuugGYgpUgCwVseyifccLLP4FkKTKmV5OLdgsv6MQs9+5INKJ6UqPd3sS7o7
 xu4j2gppwcxyzC9CNln05XQjplz4e6LTISFytbLB57zNpwFJT9MXYHRr9x9gRTtQ+j4h
 jWvn8k9NUh18U5UPRYY0/Y6SVgAj1smSHA4M1JCgg68QEKq/Jcp0qxKYs3l3O6GmSLZL
 R8j9tkVVWAJynduRhYkM0oFpZ/8pYw4GmNbj0nZwdyW7O47tQxcqf1b+f4F4F5B+JFcD
 zyFsh6tnObKIxYIERsGVH1gdkxJUSq1nd2ryP+/BcdzaOOJHX11KGFLdn2tBAmBd1qFO
 KDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036813; x=1760641613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNvGh78jSALi+oq6g8hAjx+8CQBlAGd5faXm34Ccqvg=;
 b=f2d5msT0XZWuuaSX/d079rXkta7r1IdvY2GS72Fmk+3DMVl1asSrGtPfncP83u6GkM
 Pkfcnw5x6HlcbpgK2nnkJ5a8CrR/nBVPR+5sfMwLfLhMPYxvOImo6KL3usgCmaKu14YF
 ERYWZX6VeUfUaPNbyqFPe9TwYTvABS+QuD0PhrETwqwYv8YlWHRgnKBUHMjI9+k87Cu8
 ycxa/CC0QBbV5iPml0q3xogkuXUpJcqLCHv7HlVpqJLtIYd8cjMESEqQ3kgK04M2KF9z
 9ea/j+jgsa9oLpadInqlfIXHLpHqA9iFC3SRlhl9EXcb6rPbmJhmxqxJ4ijqBXzh/YeZ
 QzfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0p5TRw3KtTcijoKjoc/RI3PIcYKYcSgOAt+p7D+U9Io/X9CBSCwMniuRwU84X2SFsmuDaBUdT+LGi@nongnu.org
X-Gm-Message-State: AOJu0YzWek4GydhLYMr3a140zm+03u3xFqLL98RVa9dHerymrJmgZ+hB
 7BN1MxkLId7jfQsaQJccH5cl41TvdDx0ED8nqeAqXj/cn/m51kFaS5ptD6iK/OhjemrqHS2S8Dx
 CA+W+9/ykc4gEWx5YzdBZwmjqjKQVhYI=
X-Gm-Gg: ASbGncvbpguZoMka+cV/DTy13StB5UjXMFUTZI2BOhqwf4TeK+j7VwcnxiEpKNzY7sy
 gjOVbawx4WW5lTNgPGh/66kHYZUEVZOcIJEorhBM98GvCMN9OLJx0kBvNvygqEh0pETwOm1XnhY
 bYGKP5A2dHNN7coOpoJOOz8hZymQVHRXznscTPBY4FsOMU5FbxDvdrAuxZ10A6ZPRYjqvTnR3RV
 4ZrHk68l5e/YCNP2CrdBJ9GyGBCWN9KRGKa++sGxg==
X-Google-Smtp-Source: AGHT+IEM/yCJZ4T2IfofqCvFqopclKW296P7ppZ7jMLCdqiegLx8lA9GnqkZUK0FrgNSIGs7rKWbl+g21fOvxMjEfxA=
X-Received: by 2002:a05:6e02:1fef:b0:42e:72ee:4164 with SMTP id
 e9e14a558f8ab-42f874215acmr70860995ab.23.1760036813405; Thu, 09 Oct 2025
 12:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-19-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-19-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:06:42 -0400
X-Gm-Features: AS18NWBNZa0-3mZff43imxq8-1zSJXZtci60249hdoufGTBE0qqX7ABIoKMXoYw
Message-ID: <CAFubqFsiqHoyMvh7OnD8yV8LX1ig0b32Us6nb=2ny_VdwJpW7g@mail.gmail.com>
Subject: Re: [PATCH 18/33] vhost: introduce check_memslots() helper
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2c.google.com
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

On Wed, Aug 13, 2025 at 12:56=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 71 ++++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 31 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index a8f8b85012..f9163ba895 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1553,11 +1553,49 @@ static void vhost_virtqueue_cleanup(struct vhost_=
virtqueue *vq)
>      }
>  }
>
> +static bool check_memslots(struct vhost_dev *hdev, Error **errp)
> +{
> +    unsigned int used, reserved, limit;
> +
> +    limit =3D hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> +    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
> +        memory_devices_memslot_auto_decision_active()) {
> +        error_setg(errp, "some memory device (like virtio-mem)"
> +            " decided how many memory slots to use based on the overall"
> +            " number of memory slots; this vhost backend would further"
> +            " restricts the overall number of memory slots");
> +        error_append_hint(errp, "Try plugging this vhost backend before"
> +            " plugging such memory devices.\n");
> +        return false;
> +    }
> +
> +    /*
> +     * The listener we registered properly setup the number of required
> +     * memslots in vhost_commit().
> +     */
> +    used =3D hdev->mem->nregions;
> +
> +    /*
> +     * We assume that all reserved memslots actually require a real mems=
lot
> +     * in our vhost backend. This might not be true, for example, if the
> +     * memslot would be ROM. If ever relevant, we can optimize for that =
--
> +     * but we'll need additional information about the reservations.
> +     */
> +    reserved =3D memory_devices_get_reserved_memslots();
> +    if (used + reserved > limit) {
> +        error_setg(errp, "vhost backend memory slots limit (%d) is less"
> +                   " than current number of used (%d) and reserved (%d)"
> +                   " memory slots for memory devices.", limit, used, res=
erved);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                     VhostBackendType backend_type, uint32_t busyloop_time=
out,
>                     Error **errp)
>  {
> -    unsigned int used, reserved, limit;
>      uint64_t features;
>      int i, r, n_initialized_vqs =3D 0;
>
> @@ -1584,19 +1622,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>          goto fail;
>      }
>
> -    limit =3D hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> -    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
> -        memory_devices_memslot_auto_decision_active()) {
> -        error_setg(errp, "some memory device (like virtio-mem)"
> -            " decided how many memory slots to use based on the overall"
> -            " number of memory slots; this vhost backend would further"
> -            " restricts the overall number of memory slots");
> -        error_append_hint(errp, "Try plugging this vhost backend before"
> -            " plugging such memory devices.\n");
> -        r =3D -EINVAL;
> -        goto fail;
> -    }
> -
>      for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
>          r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i,
>                                   busyloop_timeout);
> @@ -1655,23 +1680,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memo=
ry);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>
> -    /*
> -     * The listener we registered properly setup the number of required
> -     * memslots in vhost_commit().
> -     */
> -    used =3D hdev->mem->nregions;
> -
> -    /*
> -     * We assume that all reserved memslots actually require a real mems=
lot
> -     * in our vhost backend. This might not be true, for example, if the
> -     * memslot would be ROM. If ever relevant, we can optimize for that =
--
> -     * but we'll need additional information about the reservations.
> -     */
> -    reserved =3D memory_devices_get_reserved_memslots();
> -    if (used + reserved > limit) {
> -        error_setg(errp, "vhost backend memory slots limit (%d) is less"
> -                   " than current number of used (%d) and reserved (%d)"
> -                   " memory slots for memory devices.", limit, used, res=
erved);
> +    if (!check_memslots(hdev, errp)) {
>          r =3D -EINVAL;
>          goto fail;
>      }
> --
> 2.48.1
>
>

