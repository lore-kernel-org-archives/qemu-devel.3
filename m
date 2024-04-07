Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA58CD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 22:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtahY-00074t-Mw; Sun, 07 Apr 2024 18:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtahV-00074i-V5
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 18:09:22 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtahT-0002fl-40
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 18:09:20 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78d6021e2e3so67743185a.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712527757; x=1713132557;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tk5r66Wt2SdiTARSA6hEEL9NEInJMzLqDpdTdC8muLs=;
 b=g7AY03C/SoNTUdwa2krqp/iU60th3AkiZ7f8DVQOw8xj5fFSFUTS2QuKGzt41Dji2J
 MyIvSsLRWgdWKeTkyhfNXi588Wnp1iACFBQKZ9dc+pOt+YkPZ3RAK0UUn+sVxOtuoBHH
 CfZvG4BcXrbpxH57gw1e52oQZXZLerzX4+UPsSfRjA9o5c4+ehnqoVgyS4/2lXWikxtQ
 RZg7C71L6vSJekexsP/dYMsCcbK7IjiIWOkyclomfxtxAIusmzblgidNQjyb2LTIvysl
 zp0UkSm88D54vL8l7kGoxoiwGeapabQNb6lFjsmPW/VxzZSMqsuqATtecL5YsAuRDUwM
 Hsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712527757; x=1713132557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tk5r66Wt2SdiTARSA6hEEL9NEInJMzLqDpdTdC8muLs=;
 b=cYrg703t01qgRAqRksKjUI1+iy1yBRYyyJFrb9AiDh1Xe4pDXwhhh9sqJNu8E4n8it
 kR4UUeKLDKE6MaTX2k7+wk5fGoFzEO1WGx/BmPLUutj6dBuR130Ut9EfmF/+xTRLnLBt
 kaAwgb9o8sQyDkjKSaSc5TlMdnfCFQWhPo01X0c3pB6YaatuiwViOG4ma7dSnEsj8gyi
 Bjpa5scaPzlOh5bvCS31MxfhFcXjS3Ns9IBi+8Ea65IQ2oaguCzTrBzG3CTAGBUmTJq2
 boDCmkaIyL3bg0B5lsxSvblrtczdtEQRSd/O1SAU5uEZhX+py17goAJfuCXde5sKZOeP
 9hHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKT72kjODVr5meBxwiEec5d2dCED0NRip7/7pLr8spfaw9N0Q6OzC6QMyGAvGasnzF9V15R+Tp5znVFkPvnEClAYVrI9I=
X-Gm-Message-State: AOJu0YxFVYiI//4vq5X+icB7SHnzPY6irK0x9rsoKuukUAINBoXsa2RE
 gkgZC2UtXF2Wf08+a/sTeeIl/rzNjxBvt/4kP8tgs7ET3IwiEZNExARXvBhsY0LlInU0AQIEbZP
 vDvzD7nr7b+nXBiSK80oQvqZt4z81u05WSlLUVw==
X-Google-Smtp-Source: AGHT+IHxXmOSRAUv4vyquzkhBuA8V1FRvKeEqzlrmHjjfQYdrqm0TzWp+JEnP2riNTDmI28a1PQ+U4H+23+PX0Cd0x0=
X-Received: by 2002:a05:622a:110b:b0:432:d303:9ec with SMTP id
 e11-20020a05622a110b00b00432d30309ecmr9921752qty.52.1712527757676; Sun, 07
 Apr 2024 15:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-16-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-16-c6d87e69d38b@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 8 Apr 2024 01:09:05 +0300
Message-ID: <CAOEp5Od=KUTHnikVBA7iWfdFPJ=T7hbJrSu4zwCiB_Q1P-Sz+Q@mail.gmail.com>
Subject: Re: [PATCH v9 16/20] virtio-net: Do not write hashes to peer buffer
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::72e;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 3, 2024 at 2:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> The peer buffer is qualified with const and not meant to be modified.

IMHO, this buffer is not so 'const' (although the prototype states so),
it is allocated in net.c
btw, another procedure in this file also modifies the buffer
(work_around_broken_dhclient)

> It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
> virtio-net header support.

Does it mean _this commit_ prevents enabling VIRTIO_NET_F_HASH_REPORT
for peers without
virtio-net header support? Where?

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2de073ce18fd..ff1884564d0d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1823,16 +1823,9 @@ static uint8_t virtio_net_get_hash_type(bool hasip=
4,
>      return 0xff;
>  }
>
> -static void virtio_set_packet_hash(const uint8_t *buf, uint8_t report,
> -                                   uint32_t hash)
> -{
> -    struct virtio_net_hdr_v1_hash *hdr =3D (void *)buf;
> -    hdr->hash_value =3D hash;
> -    hdr->hash_report =3D report;
> -}
> -
>  static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf=
,
> -                                  size_t size)
> +                                  size_t size,
> +                                  struct virtio_net_hdr_v1_hash *hdr)
>  {
>      VirtIONet *n =3D qemu_get_nic_opaque(nc);
>      unsigned int index =3D nc->queue_index, new_index =3D index;
> @@ -1863,7 +1856,8 @@ static int virtio_net_process_rss(NetClientState *n=
c, const uint8_t *buf,
>                                               n->rss_data.hash_types);
>      if (net_hash_type > NetPktRssIpV6UdpEx) {
>          if (n->rss_data.populate_hash) {
> -            virtio_set_packet_hash(buf, VIRTIO_NET_HASH_REPORT_NONE, 0);
> +            hdr->hash_value =3D VIRTIO_NET_HASH_REPORT_NONE;
> +            hdr->hash_report =3D 0;
>          }
>          return n->rss_data.redirect ? n->rss_data.default_queue : -1;
>      }
> @@ -1871,7 +1865,8 @@ static int virtio_net_process_rss(NetClientState *n=
c, const uint8_t *buf,
>      hash =3D net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.ke=
y);
>
>      if (n->rss_data.populate_hash) {
> -        virtio_set_packet_hash(buf, reports[net_hash_type], hash);
> +        hdr->hash_value =3D hash;
> +        hdr->hash_report =3D reports[net_hash_type];
>      }
>
>      if (n->rss_data.redirect) {
> @@ -1891,7 +1886,7 @@ static ssize_t virtio_net_receive_rcu(NetClientStat=
e *nc, const uint8_t *buf,
>      VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
>      size_t lens[VIRTQUEUE_MAX_SIZE];
>      struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
> -    struct virtio_net_hdr_mrg_rxbuf mhdr;
> +    struct virtio_net_hdr_v1_hash extra_hdr;
>      unsigned mhdr_cnt =3D 0;
>      size_t offset, i, guest_offset, j;
>      ssize_t err;
> @@ -1901,7 +1896,7 @@ static ssize_t virtio_net_receive_rcu(NetClientStat=
e *nc, const uint8_t *buf,
>      }
>
>      if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_r=
ss) {
> -        int index =3D virtio_net_process_rss(nc, buf, size);
> +        int index =3D virtio_net_process_rss(nc, buf, size, &extra_hdr);
>          if (index >=3D 0) {
>              NetClientState *nc2 =3D qemu_get_subqueue(n->nic, index);
>              return virtio_net_receive_rcu(nc2, buf, size, true);
> @@ -1961,15 +1956,17 @@ static ssize_t virtio_net_receive_rcu(NetClientSt=
ate *nc, const uint8_t *buf,
>              if (n->mergeable_rx_bufs) {
>                  mhdr_cnt =3D iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
>                                      sg, elem->in_num,
> -                                    offsetof(typeof(mhdr), num_buffers),
> -                                    sizeof(mhdr.num_buffers));
> +                                    offsetof(typeof(extra_hdr), hdr.num_=
buffers),
> +                                    sizeof(extra_hdr.hdr.num_buffers));
>              }
>
>              receive_header(n, sg, elem->in_num, buf, size);
>              if (n->rss_data.populate_hash) {
> -                offset =3D sizeof(mhdr);
> +                offset =3D offsetof(typeof(extra_hdr), hash_value);
>                  iov_from_buf(sg, elem->in_num, offset,
> -                             buf + offset, n->host_hdr_len - sizeof(mhdr=
));
> +                             (char *)&extra_hdr + offset,
> +                             sizeof(extra_hdr.hash_value) +
> +                             sizeof(extra_hdr.hash_report));
>              }
>              offset =3D n->host_hdr_len;
>              total +=3D n->guest_hdr_len;
> @@ -2015,10 +2012,11 @@ static ssize_t virtio_net_receive_rcu(NetClientSt=
ate *nc, const uint8_t *buf,
>      }
>
>      if (mhdr_cnt) {
> -        virtio_stw_p(vdev, &mhdr.num_buffers, i);
> +        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
>          iov_from_buf(mhdr_sg, mhdr_cnt,
>                       0,
> -                     &mhdr.num_buffers, sizeof mhdr.num_buffers);
> +                     &extra_hdr.hdr.num_buffers,
> +                     sizeof extra_hdr.hdr.num_buffers);
>      }
>
>      for (j =3D 0; j < i; j++) {
>
> --
> 2.44.0
>

