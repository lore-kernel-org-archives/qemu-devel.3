Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CEDCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vt8-0003Wr-04; Thu, 09 Oct 2025 15:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vt6-0003Ti-FT
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:01:16 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vt2-0006iM-UG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:01:15 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-92c781fd73aso120011639f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036470; x=1760641270; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ot3sChwYtWpudcTaNMo+EI+gXM+26Ybar7Cz3mLkAI=;
 b=B7BUE8C9NcwDAcLRitGLSJrbys04+vUvWu6Gc9COwWeIqhyewXBnVtNJGAdgaM0QQQ
 Nt4kx4QOgzqTDZmyl2fcJr9BDbu8qaLZKDeFRBR4mTj158JkX4JjOClXxdFs+pzSJZRA
 YncMGXQ3i4lhU3FNZ76VixJwvnBtXr5S/TCX+JX9B8WFHgS9ERK6wIupgnWNXrYXoTBk
 x8t4HMDT+yYZrAJwNR+OOmJ5gfJNQ0qHPIAmAQX8JFnJiid4+Kl47COkawMHmWTJODU/
 Sl+j3PgYVOzSghpyGR8+jC/tHdkXx1IN7U2ctK7CfzdEDJ2zImtzVrDaemMOiLYD2hvX
 3tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036470; x=1760641270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ot3sChwYtWpudcTaNMo+EI+gXM+26Ybar7Cz3mLkAI=;
 b=ur9rhBHTHN9QFPuERW/bBxLfdEarB77NHYGArF6kL7E0DswRX0oJp/aiLNYaZk4SFv
 uz/zvOAfCwwUmRGbJl0N35ogqLvTWsjFUSyuQJHJHNcqJpS7kD6Xpzssqv+SKjhdVQNz
 cHPBh/0WQJd3cume1uvgK9lrs0puk6Vv1Bqyi1M5Xa+uvdfaBxknWKgiZ5wEQ8QmyHpY
 9PSjqkauNYZqrjhgXTxhe1mxVzVnEA1VVHJLBTRpMxV/RNtb7XfJpYJc/jboBKyOxfK2
 hxe/OF3DPAm8JeRDZ/2x05pyMzvTs0IcdLMam3ZtXJqPrkU66DxpcXQrltsaTdCO0CUl
 1lYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf5P8boJ/Dl/1FBuAGdlyBc3sS0jo7E8sW8vScVlRPYRIqEpAcFhS0Wx9fY9/rh+BpzzGv8Bqg8e2u@nongnu.org
X-Gm-Message-State: AOJu0YywOp0rkHiB5FZvpOqC6J/KMJrYwMtqG4G8FrFicG9nibXSigtP
 oWa/8RFL+VojOtg40oXp8Qy+ocluJecb89Ny1/Yp04SlndjbEHX7fxNydyP4epXSUqrqUEE/hRt
 2U30EuazhTAwCl+rM6N9MiL1MdihRfI0=
X-Gm-Gg: ASbGncsIWw855M4XeyjeDr4W2Ypv4n6xm0MJssJzCCQDvAipiIVRfomMBMwkqSIz4MV
 DScgOtnsneC+CXYwGmJ4U0VOEVq3fBsFpOLPSsVm2epjCrSEZIGvVXNBC+TFLHhdYXLJuq/q59B
 MgT92otI+USHe/MwAt9hLAg1tX7Z729FsZJ06PO2QtPngf1VQwrbbEwLkmSdDXoRpM728k+qANu
 +L8u8Zr6LbBHgarbDhOcETDxJfyDmM=
X-Google-Smtp-Source: AGHT+IFqP1J3cmPrDLlRp53HqlkpvV0p1upaVfOiU3frrWcsfIOodz26quogAH/CcNSttxLFjYJYqBWORm3xTIldjak=
X-Received: by 2002:a05:6e02:491c:b0:42f:8fef:a610 with SMTP id
 e9e14a558f8ab-42f8fefa8bamr45185245ab.20.1760036470203; Thu, 09 Oct 2025
 12:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-13-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-13-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:00:59 -0400
X-Gm-Features: AS18NWA3ET-arIvbnGxm8aS5RHPMOzGu1nXxkXvMvfBUqBGGPTgtpHCqL5utJRQ
Message-ID: <CAFubqFs_NsizYtbQDVary5hr59HTR8Xs68ytMcUmR=81tmH5Ww@mail.gmail.com>
Subject: Re: [PATCH 12/33] vhost: simplify calls to vhost_memory_unmap()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I=E2=80=99m happy with this modulo comments for patch 11/33.

On Wed, Aug 13, 2025 at 12:52=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> No reason to calculate memory size again, as we have corresponding
> variable for each vring.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1fdc1937b6..bc1821eadd 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1370,12 +1370,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      return 0;
>
>  fail:
> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, i=
dx),
> -                       0, 0);
> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev,=
 idx),
> -                       0, 0);
> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, i=
dx),
> -                       0, 0);
> +    vhost_memory_unmap(dev, vq->used, vq->used_size, 0, 0);
> +    vhost_memory_unmap(dev, vq->avail, vq->avail_size, 0, 0);
> +    vhost_memory_unmap(dev, vq->desc, vq->desc_size, 0, 0);
>      return r;
>  }
>
> @@ -1422,12 +1419,9 @@ static int do_vhost_virtqueue_stop(struct vhost_de=
v *dev,
>                                                  vhost_vq_index);
>      }
>
> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, i=
dx),
> -                       1, virtio_queue_get_used_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev,=
 idx),
> -                       0, virtio_queue_get_avail_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, i=
dx),
> -                       0, virtio_queue_get_desc_size(vdev, idx));
> +    vhost_memory_unmap(dev, vq->used, vq->used_size, 1, vq->used_size);
> +    vhost_memory_unmap(dev, vq->avail, vq->avail_size, 0, vq->avail_size=
);
> +    vhost_memory_unmap(dev, vq->desc, vq->desc_size, 0, vq->desc_size);
>      return r;
>  }
>
> --
> 2.48.1
>
>

