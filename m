Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18515D0E6C8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nfH-0001Vv-He; Mon, 21 Oct 2024 04:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2nfF-0001VW-KQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2nfD-000429-VV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729498878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fG463XsjR/y1zdPc142o2YqIaQrClk+NkQH8wDiP54=;
 b=cmj0Bb4LgpfH850hadRsstkwKdBzZaa/3X38B5fUGxZoWTPPYBRsqaLOIs5mAEjuSTkdr6
 Png/mU8EdKHs+Esw/8Ie+wmmfd8uZHoN+JvCyIrP0JuR/RJHj2NN8StigiMOyWmbTtq0+K
 xghwKo4MRjtiq442sGpbaHjLuvORfzo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-hMeYyzIGNHK_GOuXeiOZxQ-1; Mon, 21 Oct 2024 04:21:16 -0400
X-MC-Unique: hMeYyzIGNHK_GOuXeiOZxQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-71e51a31988so4534718b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498875; x=1730103675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fG463XsjR/y1zdPc142o2YqIaQrClk+NkQH8wDiP54=;
 b=bOsvLIwu0MJhVTLrC3koFdWbzjN6hdB/4egSvXbECKpp6mCAHUza4lATg0szx19W5Y
 ztPAwBnNNWMRe9X7wUbZiWx916UcdktTUAP9FhHnwqMHo0ui8oPdzD8MAQuy38H810MN
 qa8o7zhUb0nYa6/bHY+V5/DKty9Ok3SWfIuuEQzzDGwP3AGGhFbenw8GsPjsS7S2RvO2
 gDgAA584Ba7YfxWwZsMwObxu8tvlVUC4e+rj7rNX25aMowpM31NVtwMngDrVL8k9ekDN
 cCOMS1MWS+vJA0CJQEIt2C9KyrgOqYwCSuZvwqfuHFwqmtrKHHyoPdtjgncOva/BTx26
 UEAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW981fcRQBzb0hMbsqnwcyM6ahNaCvUDFaVoL+UR35TD+dkpgU48bqDthpfESuxGo6xXnkZOr1FVXLE@nongnu.org
X-Gm-Message-State: AOJu0YzsK27sGjG2RbIVKMFgabs/3yis1A/NuYe2bDT5Tl8KCYIKhC9W
 VckKkr5sovGouTFSa+3KCADvSTsKYGAoCrfQAMJlnQxiIGY+H9WEhI0ZaN1UbhvtDQtPGYMhInq
 l7kYYbiDcmSzLJ1dGM4m0YzRRwuLwbM67+NssRAdJA9ESWfLhobSIHtY4ELwWhKMcPdaie/XXm2
 hMyhi+LUVJA91RcqEQkySvr7LF1iOqWlNCXWYywZ2LjrY=
X-Received: by 2002:a05:6a00:4f96:b0:71d:e93e:f542 with SMTP id
 d2e1a72fcca58-71ea31e4e84mr15587675b3a.21.1729498875019; 
 Mon, 21 Oct 2024 01:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvZCDlwNsFlTbRv83zhtEN4NdbK8f2zRNRPh6/ov3gcqj0bORAxekLMrU9OpPqaDCO5bzPcGFVRXUTzYBlpkg=
X-Received: by 2002:a05:6a00:4f96:b0:71d:e93e:f542 with SMTP id
 d2e1a72fcca58-71ea31e4e84mr15587655b3a.21.1729498874512; Mon, 21 Oct 2024
 01:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
 <20240915-queue-v1-6-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-6-b49bd49b926d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Oct 2024 16:21:03 +0800
Message-ID: <CACGkMEvT0ANv1XY24kQW6urJzA87fQ2DqgPHSUi=r8SREpanxA@mail.gmail.com>
Subject: Re: [PATCH 6/7] virtio-net: Copy received header to buffer
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Sep 15, 2024 at 9:07=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> receive_header() used to cast the const qualifier of the pointer to the
> received packet away to modify the header. Avoid this by copying the
> received header to buffer.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 85 +++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 3fc1d10cb9e0..ca4e22344f78 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1685,41 +1685,44 @@ static void virtio_net_hdr_swap(VirtIODevice *vde=
v, struct virtio_net_hdr *hdr)
>   * cache.
>   */
>  static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> -                                        uint8_t *buf, size_t size)
> +                                        size_t *hdr_len, const uint8_t *=
buf,
> +                                        size_t buf_size, size_t *buf_off=
set)
>  {
>      size_t csum_size =3D ETH_HLEN + sizeof(struct ip_header) +
>                         sizeof(struct udp_header);
>
> +    buf +=3D *buf_offset;
> +    buf_size -=3D *buf_offset;
> +
>      if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
> -        (size >=3D csum_size && size < 1500) && /* normal sized MTU */
> +        (buf_size >=3D csum_size && buf_size < 1500) && /* normal sized =
MTU */
>          (buf[12] =3D=3D 0x08 && buf[13] =3D=3D 0x00) && /* ethertype =3D=
=3D IPv4 */
>          (buf[23] =3D=3D 17) && /* ip.protocol =3D=3D UDP */
>          (buf[34] =3D=3D 0 && buf[35] =3D=3D 67)) { /* udp.srcport =3D=3D=
 bootps */
> -        net_checksum_calculate(buf, size, CSUM_UDP);
> +        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> +        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSU=
M_UDP);
>          hdr->flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> +        *hdr_len +=3D csum_size;
> +        *buf_offset +=3D csum_size;
>      }
>  }
>
> -static void receive_header(VirtIONet *n, const struct iovec *iov, int io=
v_cnt,
> -                           const void *buf, size_t size)
> +static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
> +                             const void *buf, size_t buf_size,
> +                             size_t *buf_offset)
>  {
> -    if (n->has_vnet_hdr) {
> -        /* FIXME this cast is evil */
> -        void *wbuf =3D (void *)buf;
> -        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> -                                    size - n->host_hdr_len);
> +    size_t hdr_len =3D n->guest_hdr_len;
>
> -        if (n->needs_vnet_hdr_swap) {
> -            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> -        }
> -        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr)=
);
> -    } else {
> -        struct virtio_net_hdr hdr =3D {
> -            .flags =3D 0,
> -            .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> -        };
> -        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
> +    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
> +
> +    *buf_offset =3D n->host_hdr_len;
> +    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset=
);
> +
> +    if (n->needs_vnet_hdr_swap) {
> +        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
>      }
> +
> +    return hdr_len;
>  }
>
>  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> @@ -1887,6 +1890,13 @@ static int virtio_net_process_rss(NetClientState *=
nc, const uint8_t *buf,
>      return (index =3D=3D new_index) ? -1 : new_index;
>  }
>
> +typedef struct Header {
> +    struct virtio_net_hdr_v1_hash virtio_net;
> +    struct eth_header eth;
> +    struct ip_header ip;
> +    struct udp_header udp;
> +} Header;

I don't see too much value in having this structure especially
considering eth/ip/udp is not even used.

Any reason we can simply use an array as a buffer in virtio_net_receive_rcu=
()?

Thanks


