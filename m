Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595B5C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 23:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4T35-0000IO-TU; Mon, 14 Apr 2025 19:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4T34-0000I8-LA; Mon, 14 Apr 2025 19:17:06 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4T32-00059J-Dy; Mon, 14 Apr 2025 19:17:06 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so7119699a12.0; 
 Mon, 14 Apr 2025 16:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744672622; x=1745277422; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqSssSpI7m2+C3SHF6ynyr79aCBQMvzXL4JUWyS1Qsg=;
 b=GpL1+pwmeGm7q81+ST9QBV7+o1VPxTJpqDmbaMM/OvZqOWdLd9wqKllXoTq8JNunmm
 DWIdqJGI29Gs8USS3o6fAsalurY6MJUp4+LNvGE8Yj55ZmTKhwCDhEKymDOuGDgype/l
 kX6rsUC1t+sU79ZpY2YYv8xgtPhw8UK7gsCEvWBURWZd6XW2MWVIRQqsfBBs0/QwDwcb
 a2IYqFjISoBxYmkruj83bquBx3HBaTrPT6IGs6OJ2fLH2zgA1y/9wf8ZeZiMUmF4OnIu
 T2+8GAtKadLfshFBSKSkyTv8MtZwV5j1fqeWZJM1/0YJ5her+0Ey2xrp3jzwEkM7dz6Z
 oNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744672622; x=1745277422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqSssSpI7m2+C3SHF6ynyr79aCBQMvzXL4JUWyS1Qsg=;
 b=jmRW1LWuucZ16Gjx9IIyw8LLrx3uhH2KxNmYsKVgjjuKC5zD6YtGSk15DBSmATEEyc
 TKO0QIDdHF9M4k5SOrL4qe87vM8nFDx5aU+S2KhIfdH92xEmMInMGyfI1wGDzhX67X/Z
 W7/H+YYpxh1biyW5Dy+RIXsZzVuPTxk71rvUjYftNrDVOiLXLCzLfrna2AhR0I5d5Jtf
 VdEtF6T5HAVbj7BrTjgV5EV8hVllREADCHdcrqC0cXR8Rg0nHgwQrY2t1XbGFQluQ6ZP
 dBI+3nn2wgQXne+9/WGyDeXLAJKNGN5eInZNHGdVlAa6bMNLJBNTV0AYpfzOvei/9+DN
 nCyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+8HVgfLrB2GJPiRj4lwAoVD5WbD2tMYoDFRuYasQwjOBpgBNdReJD+QLfvtz9KCs56nH2IthUM74jZA==@nongnu.org
X-Gm-Message-State: AOJu0YxYqmzzhKytGVIxW7dGJqavpYQu97n0g5F9nXP/wwBq2o6bOPmp
 O1h4KnjZt8SgMkM0iqp/DBta0DbO/EnmY0jfweCXp1gxkPeT/xFckfh7JORWtxuOCDOGAYTxC32
 u1WEV/C/ip3THtJlywUDa+LfxWKMKHUkf
X-Gm-Gg: ASbGncuSzCX2spTKu4yXjUQiQ58+fA45fAoR8NyTilog4KEKHrMgXss6GTfF1NTt5QD
 8ivZQCklOrxXzIZHcCwqISWoqPvuQlMbI/VpQCI//+/VyDvt+JQ2bUhHlGUfM2ATrGpPhig6Hiv
 sebLJwTPbowE61ytDHWFxE
X-Google-Smtp-Source: AGHT+IEYUhSJdewX9ycHc6xTHJ5PmOogdj/NIccaDNYWyFgV/uBVBZllW2nAf+cbzbpjp5nZMVvThAQJj95Wrbt8YUQ=
X-Received: by 2002:a05:6402:448e:b0:5f3:7f32:3919 with SMTP id
 4fb4d7f45d1cf-5f37f323f2cmr11755858a12.16.1744672621684; Mon, 14 Apr 2025
 16:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250408145345.142947-1-adamhet@scaleway.com>
 <CAJSP0QVmT0jmbgu-fJjm78CSu-cb8ZuX5t0B25n0MG1f9W++oQ@mail.gmail.com>
 <20250414184718-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250414184718-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 14 Apr 2025 19:16:49 -0400
X-Gm-Features: ATxdqUFEOubOMqMvcnA6mFP4pGSz0h2RqV5Det4ePWGJf2zM83tnqdkOLDK4t94
Message-ID: <CAJSP0QVij5ugnZi8JV=4-n2JHger=Z5dDmhsPWm2uF-UbAT2Gg@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "virtio-net: Copy received header to buffer"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-stable@nongnu.org, Antoine Damhet <adamhet@scaleway.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Mon, Apr 14, 2025 at 6:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Apr 10, 2025 at 03:00:40PM -0400, Stefan Hajnoczi wrote:
> > On Tue, Apr 8, 2025 at 10:55=E2=80=AFAM Antoine Damhet <adamhet@scalewa=
y.com> wrote:
> > >
> > > This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.
> > >
> > > The goal was to remove the need to patch the (const) input buffer
> > > with a recomputed UDP checksum by copying headers to a RW region and
> > > inject the checksum there. The patch computed the checksum only from =
the
> > > header fields (missing the rest of the payload) producing an invalid =
one
> > > and making guests fail to acquire a DHCP lease.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> > > ---
> > > v2: Rebased on master due to conflict with c17ad4b11bd2 (
> > > "virtio-net: Fix num_buffers for version 1")
> >
> > Michael: Please review this and send a pull request for 10.0 (-rc4
> > will be tagged on Tuesday). There was a conflict so this is not a
> > mechanical revert.
> >
> > Thanks!
>
>
> Backlogged because of holidays, sorry.
>
>
> Revert looks good:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> but this (userspace networking) is mostly Jason's area, not mine.

Thank you, enjoy the holidays! I will merge this patch for 10.0.

Stefan

>
>
>
> > >
> > >  hw/net/virtio-net.c | 87 +++++++++++++++++++++----------------------=
--
> > >  1 file changed, 40 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 340c6b642224..bd37651dabb0 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -1702,44 +1702,41 @@ static void virtio_net_hdr_swap(VirtIODevice =
*vdev, struct virtio_net_hdr *hdr)
> > >   * cache.
> > >   */
> > >  static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> > > -                                        size_t *hdr_len, const uint8=
_t *buf,
> > > -                                        size_t buf_size, size_t *buf=
_offset)
> > > +                                        uint8_t *buf, size_t size)
> > >  {
> > >      size_t csum_size =3D ETH_HLEN + sizeof(struct ip_header) +
> > >                         sizeof(struct udp_header);
> > >
> > > -    buf +=3D *buf_offset;
> > > -    buf_size -=3D *buf_offset;
> > > -
> > >      if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csu=
m */
> > > -        (buf_size >=3D csum_size && buf_size < 1500) && /* normal si=
zed MTU */
> > > +        (size >=3D csum_size && size < 1500) && /* normal sized MTU =
*/
> > >          (buf[12] =3D=3D 0x08 && buf[13] =3D=3D 0x00) && /* ethertype=
 =3D=3D IPv4 */
> > >          (buf[23] =3D=3D 17) && /* ip.protocol =3D=3D UDP */
> > >          (buf[34] =3D=3D 0 && buf[35] =3D=3D 67)) { /* udp.srcport =
=3D=3D bootps */
> > > -        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
> > > -        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size,=
 CSUM_UDP);
> > > +        net_checksum_calculate(buf, size, CSUM_UDP);
> > >          hdr->flags &=3D ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> > > -        *hdr_len +=3D csum_size;
> > > -        *buf_offset +=3D csum_size;
> > >      }
> > >  }
> > >
> > > -static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hd=
r,
> > > -                             const void *buf, size_t buf_size,
> > > -                             size_t *buf_offset)
> > > +static void receive_header(VirtIONet *n, const struct iovec *iov, in=
t iov_cnt,
> > > +                           const void *buf, size_t size)
> > >  {
> > > -    size_t hdr_len =3D n->guest_hdr_len;
> > > -
> > > -    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
> > > -
> > > -    *buf_offset =3D n->host_hdr_len;
> > > -    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_of=
fset);
> > > +    if (n->has_vnet_hdr) {
> > > +        /* FIXME this cast is evil */
> > > +        void *wbuf =3D (void *)buf;
> > > +        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> > > +                                    size - n->host_hdr_len);
> > >
> > > -    if (n->needs_vnet_hdr_swap) {
> > > -        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
> > > +        if (n->needs_vnet_hdr_swap) {
> > > +            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> > > +        }
> > > +        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_=
hdr));
> > > +    } else {
> > > +        struct virtio_net_hdr hdr =3D {
> > > +            .flags =3D 0,
> > > +            .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> > > +        };
> > > +        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
> > >      }
> > > -
> > > -    return hdr_len;
> > >  }
> > >
> > >  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size=
)
> > > @@ -1907,13 +1904,6 @@ static int virtio_net_process_rss(NetClientSta=
te *nc, const uint8_t *buf,
> > >      return (index =3D=3D new_index) ? -1 : new_index;
> > >  }
> > >
> > > -typedef struct Header {
> > > -    struct virtio_net_hdr_v1_hash virtio_net;
> > > -    struct eth_header eth;
> > > -    struct ip_header ip;
> > > -    struct udp_header udp;
> > > -} Header;
> > > -
> > >  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint=
8_t *buf,
> > >                                        size_t size)
> > >  {
> > > @@ -1923,15 +1913,15 @@ static ssize_t virtio_net_receive_rcu(NetClie=
ntState *nc, const uint8_t *buf,
> > >      VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
> > >      size_t lens[VIRTQUEUE_MAX_SIZE];
> > >      struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
> > > -    Header hdr;
> > > +    struct virtio_net_hdr_v1_hash extra_hdr;
> > >      unsigned mhdr_cnt =3D 0;
> > >      size_t offset, i, guest_offset, j;
> > >      ssize_t err;
> > >
> > > -    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
> > > +    memset(&extra_hdr, 0, sizeof(extra_hdr));
> > >
> > >      if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
> > > -        int index =3D virtio_net_process_rss(nc, buf, size, &hdr.vir=
tio_net);
> > > +        int index =3D virtio_net_process_rss(nc, buf, size, &extra_h=
dr);
> > >          if (index >=3D 0) {
> > >              nc =3D qemu_get_subqueue(n->nic, index % n->curr_queue_p=
airs);
> > >          }
> > > @@ -1996,20 +1986,23 @@ static ssize_t virtio_net_receive_rcu(NetClie=
ntState *nc, const uint8_t *buf,
> > >              if (n->mergeable_rx_bufs) {
> > >                  mhdr_cnt =3D iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
> > >                                      sg, elem->in_num,
> > > -                                    offsetof(typeof(hdr),
> > > -                                             virtio_net.hdr.num_buff=
ers),
> > > -                                    sizeof(hdr.virtio_net.hdr.num_bu=
ffers));
> > > +                                    offsetof(typeof(extra_hdr), hdr.=
num_buffers),
> > > +                                    sizeof(extra_hdr.hdr.num_buffers=
));
> > >              } else {
> > > -                hdr.virtio_net.hdr.num_buffers =3D cpu_to_le16(1);
> > > +                extra_hdr.hdr.num_buffers =3D cpu_to_le16(1);
> > >              }
> > >
> > > -            guest_offset =3D n->has_vnet_hdr ?
> > > -                           receive_header(n, (struct virtio_net_hdr =
*)&hdr,
> > > -                                          buf, size, &offset) :
> > > -                           n->guest_hdr_len;
> > > -
> > > -            iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
> > > -            total +=3D guest_offset;
> > > +            receive_header(n, sg, elem->in_num, buf, size);
> > > +            if (n->rss_data.populate_hash) {
> > > +                offset =3D offsetof(typeof(extra_hdr), hash_value);
> > > +                iov_from_buf(sg, elem->in_num, offset,
> > > +                             (char *)&extra_hdr + offset,
> > > +                             sizeof(extra_hdr.hash_value) +
> > > +                             sizeof(extra_hdr.hash_report));
> > > +            }
> > > +            offset =3D n->host_hdr_len;
> > > +            total +=3D n->guest_hdr_len;
> > > +            guest_offset =3D n->guest_hdr_len;
> > >          } else {
> > >              guest_offset =3D 0;
> > >          }
> > > @@ -2035,11 +2028,11 @@ static ssize_t virtio_net_receive_rcu(NetClie=
ntState *nc, const uint8_t *buf,
> > >      }
> > >
> > >      if (mhdr_cnt) {
> > > -        virtio_stw_p(vdev, &hdr.virtio_net.hdr.num_buffers, i);
> > > +        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
> > >          iov_from_buf(mhdr_sg, mhdr_cnt,
> > >                       0,
> > > -                     &hdr.virtio_net.hdr.num_buffers,
> > > -                     sizeof hdr.virtio_net.hdr.num_buffers);
> > > +                     &extra_hdr.hdr.num_buffers,
> > > +                     sizeof extra_hdr.hdr.num_buffers);
> > >      }
> > >
> > >      for (j =3D 0; j < i; j++) {
> > > --
> > > 2.49.0
> > >
> > >
>

