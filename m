Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998D0C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 10:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvZrk-0006wl-73; Fri, 21 Mar 2025 06:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1tvZrg-0006wG-Ug
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:44:37 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1tvZre-0004g4-7p
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:44:36 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-471fe5e0a80so14649221cf.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 03:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742553871; x=1743158671;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0kZnq3BxFYvryAcOh7IZRzu8Q1Q0L8Sh4TqIztd86s=;
 b=dVlTStKBhL2BqJgu/nhfTedexKfRl7buqOW151tQvrvlkIt96tGR7EWcpsYBQ+HeRH
 +TkOaCwgMSyN6rByS+HxPFHPbU7SVe6ZTKBXgKYNuHRNWu1bvr3oVZm9JW/cVHqWMUp9
 OmvtMPninlTcuFFVlYqaVSUbn3jiLDu5AcMY0LsjeOtBYNXvjCiZt/8ZSpTfRFCt/pBi
 yHix6S6cG60THQXHHrwQemQrB7xVV5OMxG5f8aOB1S9aYE94vNt9i3pyhz9Po0r7M/s9
 zhMIn3xzjZtAPxO6OTfYiQEYVjSsBQdQbFaYVeyvTdVnn3fSTln/8819Zeowjggq1NT2
 U3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742553871; x=1743158671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0kZnq3BxFYvryAcOh7IZRzu8Q1Q0L8Sh4TqIztd86s=;
 b=dYXCK2x2iISyHiUKzwMm44lSxd8VpFqtKewMq9d8tbNX+92VkS9IMp4jq1M4fXC4zU
 xjj0O7wrsHQf/kWOGC/YpK3dUpAf6EfqEAgA1PFkjzX1JMPoD3trW6u0i5RwhtT51kYp
 LkwA2J5IdWFluZsV8RbmWNbaLtbb0cAKQnhDjWGXJXt24UEXCRU+Yp8wzPRodNCsfBKP
 c2Wtu0zwjwaVwSIJ+rpFx+S0SocRGyYIAN3AJoa8yi1ptZ7sldseIjkUk7P63tphrpOr
 R6XwB6Ao7tyBrfKW3unFee+rm+hrPl/MbX/rBWcFLLdNoLvF2bRKE6PddtDSTQJz9zgo
 qyEQ==
X-Gm-Message-State: AOJu0Yz36WXSwZPBIfo6tI92Bq6+Y5i35vhwlLjjQLAbc1e3wJp7E0A4
 dhIoZ2D2lH51AOOix+7B8kWhVSpRDeh7EjL4+kDzP/wBKhCy9n+IG0ceLyYhkH7+R7zD8RVXqMC
 rYIWZa0ALGvyV+ndMf4XONfje0oRe/kcfN54a2Q==
X-Gm-Gg: ASbGncsUQZFgLz/etFi+BV22rpo7LK9g3iCezh7Z20I66Qp3tEoGrcEINWN7Nx7UOas
 GqDbLdQKc+SQak5E1PyH8r16RTlq0pMzoaTFB3HkPi7eTU6BcmGJ7MShHcCXChT59Z14E+HUqj3
 4FyhrrzZCzk2qYRVjhWrHm13xfSmQdqOkoVgrUkkOm4s3SU8/CMV1HWR6SVb5V
X-Google-Smtp-Source: AGHT+IEOSuBuyIaMHL+t888inE5/P8YNskfKfoAoHk1ErbDMKNlO0XTGYh+AAXKdiMiKhNtSRDkNjaf80nTrGr7yQCs=
X-Received: by 2002:a05:622a:22a5:b0:476:aa7a:2f78 with SMTP id
 d75a77b69052e-4771de5b160mr41484091cf.49.1742553871450; Fri, 21 Mar 2025
 03:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250321-vq-v1-1-6d6d285e5cbc@daynix.com>
In-Reply-To: <20250321-vq-v1-1-6d6d285e5cbc@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 21 Mar 2025 12:44:20 +0200
X-Gm-Features: AQ5f1Jrkk7KVpWkl9kXU1ICSaIl9UWJECNcm-VIH4xr9Xgr1BYKOlAVHcH6jbhA
Message-ID: <CAOEp5Od-TTWt9yAQfxpSNGg=1edXaAX8b71vd7ZQfNnr7-2ArA@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Fix the interpretation of max_tx_vq
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Mar 21, 2025 at 11:56=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> virtio-net uses the max_tx_vq field of struct virtio_net_rss_config to
> determine the number of queue pairs and emits an error message saying
> "Can't get queue_pairs". However, the field tells only about tx.
>
> Examine the indirection table to determine the number of queues required
> for rx, and correct the name of field in the error message, clarifying
> its correct semantics.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadffe1..d9ab9e1eb74d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1450,23 +1450,28 @@ static uint16_t virtio_net_handle_rss(VirtIONet *=
n,
>          err_value =3D (uint32_t)s;
>          goto error;
>      }
> -    for (i =3D 0; i < n->rss_data.indirections_len; ++i) {
> -        uint16_t val =3D n->rss_data.indirections_table[i];
> -        n->rss_data.indirections_table[i] =3D virtio_lduw_p(vdev, &val);
> -    }
>      offset +=3D size_get;
>      size_get =3D sizeof(temp);
>      s =3D iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
>      if (s !=3D size_get) {
> -        err_msg =3D "Can't get queue_pairs";
> +        err_msg =3D "Can't get max_tx_vq";
>          err_value =3D (uint32_t)s;
>          goto error;
>      }
> -    queue_pairs =3D do_rss ? virtio_lduw_p(vdev, &temp.us) : n->curr_que=
ue_pairs;
> -    if (queue_pairs =3D=3D 0 || queue_pairs > n->max_queue_pairs) {
> -        err_msg =3D "Invalid number of queue_pairs";
> -        err_value =3D queue_pairs;
> -        goto error;
> +    if (do_rss) {
> +        queue_pairs =3D virtio_lduw_p(vdev, &temp.us);
> +        for (i =3D 0; i < n->rss_data.indirections_len; ++i) {
> +            uint16_t val =3D n->rss_data.indirections_table[i];
> +            n->rss_data.indirections_table[i] =3D virtio_lduw_p(vdev, &v=
al);
> +            queue_pairs =3D MAX(queue_pairs, n->rss_data.indirections_ta=
ble[i]);
> +        }

I think this change will create a problem rather than improve something.
curr_queue_pairs is used in virtio_net_can_receive.
Let's say the device has 4 queues and 4 CPUs.
If the OS currently configures the RSS for first 2 queues only the
curr_queue_pairs becomes 2.
The packets that come to queues 2 and 3 will be dropped, see
virtio_net_receive_rcu and virtio_net_can_receive

IMO the curr_queue_pairs should not be changed after it was set by
VIRTIO_NET_CTRL_MQ / VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET

> +        if (queue_pairs =3D=3D 0 || queue_pairs > n->max_queue_pairs) {
> +            err_msg =3D "Invalid number of queue_pairs";
> +            err_value =3D queue_pairs;
> +            goto error;
> +        }
> +    } else {
> +        queue_pairs =3D n->curr_queue_pairs;
>      }
>      if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>          err_msg =3D "Invalid key size";
>
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250321-vq-87aff4f531bf
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>

