Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2482FCCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzBv-0006St-Sn; Mon, 20 Oct 2025 19:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzBk-0006QY-2f
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:21:16 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzBi-0007fa-CN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:21:15 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-430e1f19a1aso6697945ab.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002473; x=1761607273; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO1qBNylAidQji0t0OGUHyI0nQj6u5lFJ86Komnwup4=;
 b=ivr4Zs2ZVhQ0hHWu5NsKiBf29Tdc+5hz+zvhRbPo6eBXh+U6B7xOgyRiGPVRNNTkux
 7ZJnqqDZBhYR2UEli3hL8cQwfL+WE50GR0FiyckXcxPiNYYqXT8fMAiVqsGpvnpVlroE
 VWe1LYHOq3eKTI32mfnmqHleVf5zVzj4AbsNoLh28NNpiqR3Rbm9kTX27O5sx09he3z3
 jn4J87fyRag6L7paG+xvLUHK2nXKny6LZbJ3rby3IsOsGGT4QGfmbf+3dZvedy4rAZU+
 n7LE2rGU4N1G7f6nGpcQbCMdMRvR7i+p99sjijNj16U9aGs+/urxJ2HU2z+qPm1Mnokr
 pYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002473; x=1761607273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eO1qBNylAidQji0t0OGUHyI0nQj6u5lFJ86Komnwup4=;
 b=KENYhvMvJpNpvOQLr905gDNWhxnG6orVx6nPEZ4nz4b9TDkegOjMZFISq04H17otee
 WbvDreXvJ1qQu6nBVR4+KC6p5/8Eb5XI30at4b6ivjQMG/YLPeItQ/MWZBI8HsbA6AR0
 t0p0ik4boh3+tZbKlLL0mpNZnCcDRIeDOWVvuUlcqDM2+xiaarQguq+Slx3ZpfsOQdhL
 M7PLaRCl80n9ij+hZ29ZodLUDKdExvIdwWPZ9+qI18AidV8ziAtNNKZnY5i89R2YA3ES
 xJyBpbNQj94MLz5zdj25lwXE5Zw8yhNFNhyRhIcbsCujOok9zQsOsoUmKxu/vR4EF+My
 gQzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuEkcSEu0W2dpU54NANsfmRuA9Ur2oQpOcCUYqmNnUIbdBfafnTnWSdKUd5E4yk0bfAL8MZMtegzcD@nongnu.org
X-Gm-Message-State: AOJu0YzYqUpS8aQOr3jLirEXeoMv0Use1SI5OMdtPjYLUdowwsgObVgW
 3fMbI+MMRrIslegTJxuewJcFFaZ6j6NMV6QWlSiaP7gGfrQ+eo49ugsti3UkdDFuX/6eoXwL5Zo
 BJD2CTTMFfTSJfZHFnPpfo3aDGLbHuWY=
X-Gm-Gg: ASbGncvpqrJzUeEqA4ZR+503IFsjJygpZiytyvYzwt51n3rUSagp3QeHkKfLSq4OjWt
 3xHGWT6WZaXpb9tLNQy06dJnmVH1QCwVzbWFzLK/D7u6uuuIWvdNHwZ9BtZRMix2p8GdcV/0ha0
 mxVaueO1XRRY9Uv9pLChdM6bORNyN+NU9Ol6JTKmW0YtQ+QW8hQHMAc88UnWyzpo4/GWs/ITuu/
 VicLeW+9p2FiA/hO9zxvTJnO1bFXqxpoyD5RcMSruotuJN8t0z3OETV0O1/
X-Google-Smtp-Source: AGHT+IEu41zqVI4r9Mx18UU8oLFJU/xhWif4eDr7xkoWO5Rx51vLVNTupVSUncbzWdFMwRlBkBYLWtKIhUM7PcG/1bA=
X-Received: by 2002:a05:6e02:1563:b0:42f:a72e:e179 with SMTP id
 e9e14a558f8ab-430b43675e3mr268276735ab.11.1761002473094; Mon, 20 Oct 2025
 16:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-6-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-6-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:21:02 -0400
X-Gm-Features: AS18NWCG7J8BZzbaIhfxw5jeHYvigtg-GNWuZ9V15cwlQrcvBgVNU1tSKpzqzhc
Message-ID: <CAFubqFtwJtzSzpXgBUxuEvrKGsx8R6sJ-0cG5YEJjCBs=NEMHw@mail.gmail.com>
Subject: Re: [PATCH v2 05/25] vhost: split vhost_dev_connect() out of
 vhost_dev_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12f.google.com
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

Just a tracepoint suggestion. Otherwise LGTM.

On Thu, Oct 16, 2025 at 7:46=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Split vhost_dev_init() so that the first part will do early
> initialization of QEMU structures, but don't communicate with backend,
> and the second part will do backend communication.
>
> We need this for future support for backend-transfer migration support
> for vhost-user-blk (backend will not be available in the early
> initialization point).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c         | 27 +++++++++++++++++++++------
>  include/hw/virtio/vhost.h |  2 ++
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f733e98b4a..09d00e4d98 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1619,7 +1619,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>                     VhostBackendType backend_type, uint32_t busyloop_time=
out,
>                     bool connect, Error **errp)
>  {
> -    int i, r, n_initialized_vqs =3D 0;
> +    int i, r;
>
>      trace_vhost_dev_init_in(hdev);
>
> @@ -1640,9 +1640,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>       */
>      assert(connect || hdev->vhost_ops->vhost_backend_connect);
>
> -    /* TDDO: support connect=3Dfalse */
> -    assert(connect);
> -
>      r =3D hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
>      if (r < 0) {
>          goto fail;
> @@ -1678,6 +1675,26 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memo=
ry);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>
> +    trace_vhost_dev_init_out(hdev);
> +
> +    return connect ? vhost_dev_connect(hdev, errp) : 0;
> +
> +fail:
> +    vhost_dev_cleanup(hdev);
> +    return r;
> +}
> +
> +int vhost_dev_connect(struct vhost_dev *hdev, Error **errp)
> +{
> +    int i, r, n_initialized_vqs =3D 0;
> +

Let's add tracepoints for connect here?

> +    if (hdev->vhost_ops->vhost_backend_connect) {
> +        r =3D hdev->vhost_ops->vhost_backend_connect(hdev, errp);
> +        if (r < 0) {
> +            goto fail;
> +        }
> +    }
> +
>      r =3D hdev->vhost_ops->vhost_set_owner(hdev);
>      if (r < 0) {
>          error_setg_errno(errp, -r, "vhost_set_owner failed");
> @@ -1720,8 +1737,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          goto fail;
>      }
>
> -    trace_vhost_dev_init_out(hdev);
> -
>      return 0;
>
>  fail:
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 74ed24232e..af46d4b5f2 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -158,6 +158,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaq=
ue,
>                     uint32_t busyloop_timeout,
>                     bool connect, Error **errp);
>
> +int vhost_dev_connect(struct vhost_dev *hdev, Error **errp);
> +
>  /**
>   * vhost_dev_cleanup() - tear down and cleanup vhost interface
>   * @hdev: the common vhost_dev structure
> --
> 2.48.1
>
>

