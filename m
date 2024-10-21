Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D092D0E6C8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ngI-0001po-GC; Mon, 21 Oct 2024 04:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2ngC-0001oT-JB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2ng9-000442-6Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729498935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knIHUtk8NE+ApdRLFMyqM/PJAthef2VNpqVkOGCiXrY=;
 b=U3KHIcd8/7IUKQKIq8W9/xKq8kPVWuABV6hcPR+GltFP9MC0RroDDXNkqO2Qwrs+piNJse
 A46ZM/spl1+P/kJarNEodB2xDTGsd314zDXD7YVYxeu0C2/H5SX1lsfIZguTIzTYM2O86K
 gIJPd9WxNcdo67PfgxHDMac+S7aK8vc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-2y3dKJdyNDWZ9zntUk92HQ-1; Mon, 21 Oct 2024 04:22:13 -0400
X-MC-Unique: 2y3dKJdyNDWZ9zntUk92HQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7eaac1e95ffso3716065a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498932; x=1730103732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knIHUtk8NE+ApdRLFMyqM/PJAthef2VNpqVkOGCiXrY=;
 b=o9FLbSymVatgYqyTxZQZnfKW7Q0RE5qyDDnjGTcooT78Opzcn5SMToqYcdbpvmHTSq
 S0Ut0/QSh0Kqiy2EyHlC8c9+N/9uu/j03kX7lwsBJHBgank+Oi2Pdj565alSz3cLhK3c
 22poqoXiU/dkNbApIcd1lEWR3lyERa9F2j5yEzFXtOOafUkWJPNBkJA4pYcHHJVrnF7I
 Q/zy/U4/gTwpqIH64JAqlgyfa7Skl12E5AFEB8AFF6SaDIul2UKkAQi6CB6VpaMm7JS4
 CQEqpUfwpLrXXBOnzhYNdQDO4U+Bvo94UNmP2ZDqNu7AqnMBqTIiQK3N9SNepfxYgHVi
 DstA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEmYmc4SJlp02B/igUojhi6VWcUhU83p/z/wwWw09+bS/Uhcs32wyBgI7VoSgDhbI8vbWD88myKKNC@nongnu.org
X-Gm-Message-State: AOJu0Yz2l+HvLPtLZ3rLWQA2GW1FbnKHHYDkSN37uB4jqzvQGIZ5xpB1
 jxNA3mN4bUKmDkXMQr9Qjfx6LTE6GsuCP/+/BtD8iJUN513PLNzwigNvo2coxzwhjzJ8RwTFHgB
 vt/PiyRIOQa6K50GCtgWBiATOlmjajHfTSgKl58zl4ugeUmHIA4wPH4M9Rcp4AUPQjbz7nK8OOZ
 xbk53h9ka1Xc/m55c152Q2fGNc/Yk=
X-Received: by 2002:a05:6a21:1693:b0:1d8:a49b:ee71 with SMTP id
 adf61e73a8af0-1d92c51e66dmr16487613637.29.1729498932357; 
 Mon, 21 Oct 2024 01:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENXCmjKteobbj5KlEGaj2V6dVe2Na6MpledNBTTgznYJ/kr/hthPHGxWEUQNj8ohqoUtQeNEKnLXdDqR0FpyE=
X-Received: by 2002:a05:6a21:1693:b0:1d8:a49b:ee71 with SMTP id
 adf61e73a8af0-1d92c51e66dmr16487589637.29.1729498931879; Mon, 21 Oct 2024
 01:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
 <20240915-queue-v1-6-b49bd49b926d@daynix.com>
 <CACGkMEvT0ANv1XY24kQW6urJzA87fQ2DqgPHSUi=r8SREpanxA@mail.gmail.com>
In-Reply-To: <CACGkMEvT0ANv1XY24kQW6urJzA87fQ2DqgPHSUi=r8SREpanxA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Oct 2024 16:22:00 +0800
Message-ID: <CACGkMEvtNPQk9gU7KPsTN=4ghdiZWyV2feYpEj+_1uAGvrMvKw@mail.gmail.com>
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

On Mon, Oct 21, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Sep 15, 2024 at 9:07=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> >
> > receive_header() used to cast the const qualifier of the pointer to the
> > received packet away to modify the header. Avoid this by copying the
> > received header to buffer.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  hw/net/virtio-net.c | 85 +++++++++++++++++++++++++++++----------------=
--------
> >  1 file changed, 46 insertions(+), 39 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 3fc1d10cb9e0..ca4e22344f78 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -1685,41 +1685,44 @@ static void virtio_net_hdr_swap(VirtIODevice *v=
dev, struct virtio_net_hdr *hdr)
> >   * cache.
> >   */
> >  static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> > -                                        uint8_t *buf, size_t size)
> > +                                        size_t *hdr_len, const uint8_t=
 *buf,
> > +                                        size_t buf_size, size_t *buf_o=
ffset)
> >  {
> >      size_t csum_size =3D ETH_HLEN + sizeof(struct ip_header) +
> >                         sizeof(struct udp_header);
> >
> > +    buf +=3D *buf_offset;
> > +    buf_size -=3D *buf_offset;
> > +
> >      if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum =
*/
> > -        (size >=3D csum_size && size < 1500) && /* normal sized MTU */
> > +        (buf_size >=3D csum_size && buf_size < 1500) && /* normal size=
d MTU */
> >          (buf[12] =3D=3D 0x08 && buf[13] =3D=3D 0x00) && /* ethertype =
=3D=3D IPv4 */
> >          (buf[23] =3D=3D 17) && /* ip.protocol =3D=3D UDP */
> >          (buf[34] =3D=3D 0 && buf[35] =3D=3D 67)) { /* udp.srcport =3D=
=3D bootps */
> > -        net_checksum_calculate(buf, size, CSUM_UDP);
> > +        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> > +        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, C=
SUM_UDP);
> >          hdr->flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> > +        *hdr_len +=3D csum_size;
> > +        *buf_offset +=3D csum_size;
> >      }
> >  }
> >
> > -static void receive_header(VirtIONet *n, const struct iovec *iov, int =
iov_cnt,
> > -                           const void *buf, size_t size)
> > +static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
> > +                             const void *buf, size_t buf_size,
> > +                             size_t *buf_offset)
> >  {
> > -    if (n->has_vnet_hdr) {
> > -        /* FIXME this cast is evil */
> > -        void *wbuf =3D (void *)buf;
> > -        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> > -                                    size - n->host_hdr_len);
> > +    size_t hdr_len =3D n->guest_hdr_len;
> >
> > -        if (n->needs_vnet_hdr_swap) {
> > -            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> > -        }
> > -        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hd=
r));
> > -    } else {
> > -        struct virtio_net_hdr hdr =3D {
> > -            .flags =3D 0,
> > -            .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> > -        };
> > -        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
> > +    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
> > +
> > +    *buf_offset =3D n->host_hdr_len;
> > +    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offs=
et);
> > +
> > +    if (n->needs_vnet_hdr_swap) {
> > +        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
> >      }
> > +
> > +    return hdr_len;
> >  }
> >
> >  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> > @@ -1887,6 +1890,13 @@ static int virtio_net_process_rss(NetClientState=
 *nc, const uint8_t *buf,
> >      return (index =3D=3D new_index) ? -1 : new_index;
> >  }
> >
> > +typedef struct Header {
> > +    struct virtio_net_hdr_v1_hash virtio_net;
> > +    struct eth_header eth;
> > +    struct ip_header ip;
> > +    struct udp_header udp;
> > +} Header;
>
> I don't see too much value in having this structure especially
> considering eth/ip/udp is not even used.
>
> Any reason we can simply use an array as a buffer in virtio_net_receive_r=
cu()?

Btw, since the code was for ancient guests and userspace, I wonder how
it is tested.

Thanks

>
> Thanks


