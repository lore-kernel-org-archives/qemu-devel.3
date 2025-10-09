Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5482CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vwy-0006Rk-Aw; Thu, 09 Oct 2025 15:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vwu-0006Oq-KK
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:05:12 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vws-000751-Eq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:05:12 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-9335a918867so117104739f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036707; x=1760641507; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/3k6Doi+LQooUy6ZxAJHysDn76DGgRKPRrKMCxmTvI=;
 b=WoErFNidMSFwTMttbpKXjE88Ri8frRzobi5oV+HqeEk9yVGKweWBSu5sqOKlcJyQT5
 0ckcAw7nDPsyaPMT1I2vrUTIkH6Z7DA7ZpCNshDJ+DA4rUvt06m2je9L2w00LPzPVEmf
 iug7UU5lFZkn19gLla+BT/Sv4rnEPZZvher45Om1YznhN5DXfXYWDkjjdjHVcySsVBLX
 rHzSHt8F7ZOkwvIvqdP2ozkG/wM/3etrzxRcvLE9bYI8nYYqWFL+WUq7WGs6OAch+lG9
 SfX7x5xUV52A2SvopS+cUv50pCb67+3D7QGrLmJg1XnyDIFYhqeGlMUK9s6ygfK/KA8R
 TJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036707; x=1760641507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/3k6Doi+LQooUy6ZxAJHysDn76DGgRKPRrKMCxmTvI=;
 b=pD1T4FGxUMj3NjHMc/2C/9BpAg8vQtJQrvw839cBgNV6TEM8wz1rU9JjR2e9Et3dNy
 4XLWWaiUNfBEumRKBGIx39krIqo3vPJVUmJL76nkvMklDFDXobfNN6501zJm0QTmvgrw
 4fXp8qd5YkZqldGu6VaMhMKr94LgpRydQ8olcjF8daWddDxVw19ysz7Sa8JQv7qoS/uI
 Ye57Ud6YtGm6CfOEBlwayWmd8z1uZtpUZpa8hYbRVOAhTXJtbIYVCN56u6gnU/Zwo5uO
 /0k9LrkW1+xhR9MREH0O977sFcGq4w4ZnO09u+9rBonFwm2yLfPtWgrBcO1rCMkFXFaS
 ZusA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRWUVw0Mt7K3XuEYdrrsePf17ohPH9cy6w6cSFH4gcEPXEaY+HYG6gO1d6unH+IFdfAT/3OMlac/YE@nongnu.org
X-Gm-Message-State: AOJu0YxJfyX6RyhGFRagAwPO68pEObVwMpkAUrrmuj1ZIKYFOh2dCcUd
 y56huXjUwc2g10SDeNHjX3mL7VH68EtQT4gowLEnf+UR7zoIfER/SuUUv9RvEIVsvKZiCatquPl
 4/OoV3Kvnph/TzMsTnW3z7rAiS2xs9tY=
X-Gm-Gg: ASbGnctW91jx2uaX78PZ2GxV7y8MSNLsngVPXLRsLdB5iFtEmZRpX51XcoGbdfYxtJA
 nL6BCPeo1R5jEA4s6d3jEImpwRzJut/R8Oeg7EK2rgS23IZMjLGvkHVw3oG6f4bUY39ORUcWQFU
 xsbRjuT4U5E+HFLuG/qKHyGl97cM4H22FtlEPoaA4QWXJY1QKKclod9VxE/dfTQUODqNqEIJrBP
 3njabRLcZahJVc9Z05HRIhc87ZBHN8jyfTb4K+DaA==
X-Google-Smtp-Source: AGHT+IE8+RwUY2x8jBuOk/qTI0qc6BeKwqKCpxS79P+QmnfNWhIHJ/in4FWjOwnbEyd8SUlD8yGv9ab+8FfT/5wZiGQ=
X-Received: by 2002:a05:6602:7418:b0:911:8848:62a3 with SMTP id
 ca18e2360f4ac-93bd19774d8mr903123639f.16.1760036707463; Thu, 09 Oct 2025
 12:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-18-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-18-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:04:55 -0400
X-Gm-Features: AS18NWCmtQxhRJl4kMkIgmi8fHDwxQB3Cj8bSe-ea7ZBOAuiRj60qVrKujrw6Ns
Message-ID: <CAFubqFtbc4ZRVa82SgGPNm0HAFsfgp6J=trOXo8zg9PtP-pTDg@mail.gmail.com>
Subject: Re: [PATCH 17/33] vhost: move busyloop timeout initialization to
 vhost_virtqueue_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2b.google.com
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
> Let's all per-virtqueue initializations be in one place.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index a3620c82d8..a8f8b85012 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1489,7 +1489,8 @@ static void vhost_virtqueue_error_notifier(EventNot=
ifier *n)
>  }
>
>  static int vhost_virtqueue_init(struct vhost_dev *dev,
> -                                struct vhost_virtqueue *vq, int n)
> +                                struct vhost_virtqueue *vq, int n,
> +                                bool busyloop_timeout)
>  {
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, n);
>      struct vhost_vring_file file =3D {
> @@ -1526,6 +1527,14 @@ static int vhost_virtqueue_init(struct vhost_dev *=
dev,
>                                     vhost_virtqueue_error_notifier);
>      }
>
> +    if (busyloop_timeout) {
> +        r =3D vhost_virtqueue_set_busyloop_timeout(dev, n, busyloop_time=
out);
> +        if (r < 0) {
> +            VHOST_OPS_DEBUG(r, "Failed to set busyloop timeout");
> +            goto fail_err;
> +        }
> +    }
> +
>      return 0;
>
>  fail_err:
> @@ -1589,24 +1598,14 @@ int vhost_dev_init(struct vhost_dev *hdev, void *=
opaque,
>      }
>
>      for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
> -        r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i);
> +        r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i,
> +                                 busyloop_timeout);
>          if (r < 0) {
>              error_setg_errno(errp, -r, "Failed to initialize virtqueue %=
d", i);
>              goto fail;
>          }
>      }
>
> -    if (busyloop_timeout) {
> -        for (i =3D 0; i < hdev->nvqs; ++i) {
> -            r =3D vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_in=
dex + i,
> -                                                     busyloop_timeout);
> -            if (r < 0) {
> -                error_setg_errno(errp, -r, "Failed to set busyloop timeo=
ut");
> -                goto fail;
> -            }
> -        }
> -    }
> -
>      hdev->_features =3D features;
>
>      hdev->memory_listener =3D (MemoryListener) {
> --
> 2.48.1
>
>

