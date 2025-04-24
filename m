Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0AAC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 11:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ud4-0003jo-8F; Thu, 24 Apr 2025 07:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7ud1-0003j8-06
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7ucw-00045A-PU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745493620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cmuvjoq0X1/YlD062oHnGeecfdfeh4rSoZWm/Iwgn9w=;
 b=PsS0GrXSAJ0LZi/o7HlCQdST5eh1kd0LCnMfbMClmLvWz6RMJmyw2gC4fEt2ejCu1DRUga
 9SHq9Tj5FN0bciEQZ/HsnVid4Y9vUvFHYzBemD6xeLwuutY10eUar02qMPZWu0e5hfL58L
 n5pLaI3USZ3q8Vb34irzGLyKrKgEgfU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-v5KRvS3WPmSSs9WA-kSr5g-1; Thu, 24 Apr 2025 07:20:18 -0400
X-MC-Unique: v5KRvS3WPmSSs9WA-kSr5g-1
X-Mimecast-MFC-AGG-ID: v5KRvS3WPmSSs9WA-kSr5g_1745493617
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso6231415e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 04:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745493617; x=1746098417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cmuvjoq0X1/YlD062oHnGeecfdfeh4rSoZWm/Iwgn9w=;
 b=AuIa/DuahRwzr0WTpRrjQxE2tTQKtIEzA4+Y1TW4sMGVKySoDb2cmPFKP9Xmn+zg0f
 cB/2dFhbH4Fp74aXoJBJSI+9VsHKBhgApAwUmLb66l0XYUzbQ/EHRXfSsawSyGbLcZ3T
 tCp1p3e8Ztx5JwWOT7mtrnXnIyhdOGxv+Wg5fuMmsnc3+J9h12fK5FhGqPcFX5Enhwol
 SAabD1kl/7srhFO+lLkDWrFQ4RlwonA9LgmX4ZtpOqSD6w/7wcpfrraexORLcJ8eS7uX
 2mlNEB3RW9G44UYmfQgUBv7IuCT434nM3WntYtE/gvSN8tIKSOYqCwcJQrO4wQKUFg9P
 USLQ==
X-Gm-Message-State: AOJu0YxGocULKRp1wk070MgDcmQOz4mHUUNtl0TcGg4X/8PiPyAFtz68
 JrFn2OjjLiXYiRpFgdwK4rxlijARLlf/Bv0w9cIHoGIjWf2DortkrKIRhIVuXVNr6Ym4iCK0MWc
 26k2I8gwczZtNxA2CrZ9UbF36glmLrZNZCWz32At0O8QjmapN1vJc
X-Gm-Gg: ASbGncsgsXwcavPfM5+6KCZ2CNucjuc4g2/bDFwpIdHHuB/kpFE4F3dNBicKI6DFpct
 iHYjVzus2alkjHOM+ev34pqbkJfft/I6hUkfgC45dKOuR8Bk6AFHhZ7V5HcwZTRqPOjpSDJUGMw
 z4tbewjijYtsQNRvFJ6dvnJa/ewCKjXEP3U2YjKDwWRLcQPNwr/g43RQvGLnr0KPnxxW5/kS0W8
 fs6SNsPxLZe+4x3RFu/0GGdmvWds7Oyd4W11bZlAeRJskPUdoBo/cV0tgeLduEAaBJ3/0954ycj
 4Yp5Bw==
X-Received: by 2002:a05:6000:2212:b0:391:4bcb:828f with SMTP id
 ffacd0b85a97d-3a06cf56404mr1964119f8f.14.1745493616893; 
 Thu, 24 Apr 2025 04:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6lhghdLBlaC/L7efaRhutRrCiB/CHJ9uTxVKOVsudJmhvJyrXlNBYrn7x4X5iEw33Of1oyw==
X-Received: by 2002:a05:6000:2212:b0:391:4bcb:828f with SMTP id
 ffacd0b85a97d-3a06cf56404mr1964091f8f.14.1745493616417; 
 Thu, 24 Apr 2025 04:20:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4aee19sm1802983f8f.31.2025.04.24.04.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 04:20:15 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:20:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Antoine Damhet <adamhet@scaleway.com>
Subject: Re: [PATCH v2] virtio-net: Copy received packet to buffer
Message-ID: <20250424071930-mutt-send-email-mst@kernel.org>
References: <20250424-reapply-v2-1-d0ba763ac782@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-reapply-v2-1-d0ba763ac782@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Apr 24, 2025 at 06:49:57PM +0900, Akihiko Odaki wrote:
> Commit e28fbd1c525d ("Revert "virtio-net: Copy received header to
> buffer"") reverted commit 7987d2be5a8b, which attempted to remove the
> need to patch the (const) input buffer.
> 
> Achieve the original goal by copying the header or the entire packet to
> a writable buffer as necessary. Copy the virtio-net header when patching
> it. Copy the entire packet when filling the UDP checksum as required by
> net_checksum_calculate().
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Thank you. Given the original has caused some much trouble,
could you pls document in more detail what is the problem
being solved here?
Thanks!

> ---
> Supersedes: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
> ("[PATCH] virtio-net: Copy all for dhclient workaround")
> 
> This reapplies commit 7987d2be5a8b ("virtio-net: Copy all for dhclient
> workaround"), which was reverted by commit e28fbd1c525d ("Revert
> "virtio-net: Copy received header to buffer""), with a fix in the
> superseded patch. It also renames identifiers according to the
> discussion with Antoine Damhet.
> ---
> Changes in v2:
> - Rewrote the message avoiding archeology as suggested by
>   Michael S. Tsirkin.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250423-reapply-v1-1-6f4fc3027906@daynix.com
> ---
>  hw/net/virtio-net.c | 91 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 48 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index bd37651dabb0..f1688e0b2536 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1687,6 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
>      virtio_tswap16s(vdev, &hdr->csum_offset);
>  }
>  
> +typedef struct PacketPrefix {
> +    struct virtio_net_hdr_v1_hash virtio_net;
> +    uint8_t payload[1500];
> +} PacketPrefix;
> +
>  /* dhclient uses AF_PACKET but doesn't pass auxdata to the kernel so
>   * it never finds out that the packets don't have valid checksums.  This
>   * causes dhclient to get upset.  Fedora's carried a patch for ages to
> @@ -1701,42 +1706,46 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
>   * we should provide a mechanism to disable it to avoid polluting the host
>   * cache.
>   */
> -static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
> -                                        uint8_t *buf, size_t size)
> +static void work_around_broken_dhclient(struct PacketPrefix *prefix,
> +                                        size_t *prefix_len, const uint8_t *buf,
> +                                        size_t buf_size, size_t *buf_offset)
>  {
>      size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
>                         sizeof(struct udp_header);
> +    uint8_t *payload = (uint8_t *)prefix + *prefix_len;
> +
> +    buf += *buf_offset;
> +    buf_size -= *buf_offset;
>  
> -    if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
> -        (size >= csum_size && size < 1500) && /* normal sized MTU */
> +    if ((prefix->virtio_net.hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
> +        (buf_size >= csum_size && buf_size < sizeof(prefix->payload)) && /* normal sized MTU */
>          (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
>          (buf[23] == 17) && /* ip.protocol == UDP */
>          (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
> -        net_checksum_calculate(buf, size, CSUM_UDP);
> -        hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> +        memcpy(payload, buf, buf_size);
> +        net_checksum_calculate(payload, buf_size, CSUM_UDP);
> +        prefix->virtio_net.hdr.flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
> +        *prefix_len += buf_size;
> +        *buf_offset += buf_size;
>      }
>  }
>  
> -static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
> -                           const void *buf, size_t size)
> +static size_t receive_prefix(VirtIONet *n, PacketPrefix *prefix,
> +                             const void *buf, size_t buf_size,
> +                             size_t *buf_offset)
>  {
> -    if (n->has_vnet_hdr) {
> -        /* FIXME this cast is evil */
> -        void *wbuf = (void *)buf;
> -        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> -                                    size - n->host_hdr_len);
> +    size_t prefix_len = n->guest_hdr_len;
>  
> -        if (n->needs_vnet_hdr_swap) {
> -            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> -        }
> -        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
> -    } else {
> -        struct virtio_net_hdr hdr = {
> -            .flags = 0,
> -            .gso_type = VIRTIO_NET_HDR_GSO_NONE
> -        };
> -        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
> +    memcpy(prefix, buf, sizeof(struct virtio_net_hdr));
> +
> +    *buf_offset = n->host_hdr_len;
> +    work_around_broken_dhclient(prefix, &prefix_len, buf, buf_size, buf_offset);
> +
> +    if (n->needs_vnet_hdr_swap) {
> +        virtio_net_hdr_swap(VIRTIO_DEVICE(n), (struct virtio_net_hdr *)prefix);
>      }
> +
> +    return prefix_len;
>  }
>  
>  static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> @@ -1913,15 +1922,15 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>      VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
>      size_t lens[VIRTQUEUE_MAX_SIZE];
>      struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
> -    struct virtio_net_hdr_v1_hash extra_hdr;
> +    PacketPrefix prefix;
>      unsigned mhdr_cnt = 0;
>      size_t offset, i, guest_offset, j;
>      ssize_t err;
>  
> -    memset(&extra_hdr, 0, sizeof(extra_hdr));
> +    memset(&prefix.virtio_net, 0, sizeof(prefix.virtio_net));
>  
>      if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
> -        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
> +        int index = virtio_net_process_rss(nc, buf, size, &prefix.virtio_net);
>          if (index >= 0) {
>              nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
>          }
> @@ -1986,23 +1995,19 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>              if (n->mergeable_rx_bufs) {
>                  mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
>                                      sg, elem->in_num,
> -                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
> -                                    sizeof(extra_hdr.hdr.num_buffers));
> +                                    offsetof(typeof(prefix),
> +                                             virtio_net.hdr.num_buffers),
> +                                    sizeof(prefix.virtio_net.hdr.num_buffers));
>              } else {
> -                extra_hdr.hdr.num_buffers = cpu_to_le16(1);
> +                prefix.virtio_net.hdr.num_buffers = cpu_to_le16(1);
>              }
>  
> -            receive_header(n, sg, elem->in_num, buf, size);
> -            if (n->rss_data.populate_hash) {
> -                offset = offsetof(typeof(extra_hdr), hash_value);
> -                iov_from_buf(sg, elem->in_num, offset,
> -                             (char *)&extra_hdr + offset,
> -                             sizeof(extra_hdr.hash_value) +
> -                             sizeof(extra_hdr.hash_report));
> -            }
> -            offset = n->host_hdr_len;
> -            total += n->guest_hdr_len;
> -            guest_offset = n->guest_hdr_len;
> +            guest_offset = n->has_vnet_hdr ?
> +                           receive_prefix(n, &prefix, buf, size, &offset) :
> +                           n->guest_hdr_len;
> +
> +            iov_from_buf(sg, elem->in_num, 0, &prefix, guest_offset);
> +            total += guest_offset;
>          } else {
>              guest_offset = 0;
>          }
> @@ -2028,11 +2033,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>      }
>  
>      if (mhdr_cnt) {
> -        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
> +        virtio_stw_p(vdev, &prefix.virtio_net.hdr.num_buffers, i);
>          iov_from_buf(mhdr_sg, mhdr_cnt,
>                       0,
> -                     &extra_hdr.hdr.num_buffers,
> -                     sizeof extra_hdr.hdr.num_buffers);
> +                     &prefix.virtio_net.hdr.num_buffers,
> +                     sizeof prefix.virtio_net.hdr.num_buffers);
>      }
>  
>      for (j = 0; j < i; j++) {
> 
> ---
> base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
> change-id: 20250423-reapply-63176514d76d
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


