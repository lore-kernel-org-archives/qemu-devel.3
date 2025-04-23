Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7073DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7TeT-0006Vd-S6; Wed, 23 Apr 2025 02:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7TeD-0006Sm-TW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7TeA-0003we-Ce
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745389907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1EQGRTYAm/QH8JhqTlXKA4ja9GkduCUgaHHCxWdHgI4=;
 b=C1IoPH/9HbEHvb28xqPZS3yJG7thf4hHn3EjgZjlFBCa2CzeDR/LAk0cJqoedz4o2T+eal
 pSkMFa62i9L4fx8fD0hQLBf0WxD9AYoHrneL9rWVFCCHMLyDQdMenwyOygOrUnYRz0bWsA
 q50jEJqqfpTLpRsjIPWY0/sxhUiX/W8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Nv_os66ROuW1Bpa9RkdM2Q-1; Wed, 23 Apr 2025 02:31:42 -0400
X-MC-Unique: Nv_os66ROuW1Bpa9RkdM2Q-1
X-Mimecast-MFC-AGG-ID: Nv_os66ROuW1Bpa9RkdM2Q_1745389901
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39c2da64df9so2703909f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 23:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745389901; x=1745994701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EQGRTYAm/QH8JhqTlXKA4ja9GkduCUgaHHCxWdHgI4=;
 b=DtQXNUy2hrFIpZD+jvv+123dhzhnByMTOCAFrcuz6oPtgtH20fwaVAX+mqTA+FmM33
 Fdxiw5wYzD+FZqA/mc8Ae5nrCRdLeYFEJYD2mNdDKspWOGPB4rqTLqHe9q1gCUyiiLhK
 /G9vin6KuHH6WR9rc2nvnHJjALzeZarouhJtHgNDpyILqWfnDnavr9lQr9VZczgVtwxn
 u0tYiWDwJ+dA4LRxZ6KZjzoo1B6JmxYGLUl/Ir44u3Xa31Y+8xghU2JrG4DIGvfy81bO
 gRg4/xTZvMBvPsdCCARLhSFiLv1G2UsbzBsczX4bSmjQcO9DzEWhHNtRErJ0J1Ymxl5C
 2Ymg==
X-Gm-Message-State: AOJu0Yyk93/ITu8t3Vu/fxXFp9KU7RSNKoAFvfjnJYFwWxnzcVZHBPVp
 GhAlGVKDoZAXPpqZE3cE6/UcvvtJ/pdCRnHNE/FWhpwM+oyX7i9lT8Vc71lQVFb5omIhmganzbC
 iC5mrvIa4JPvzzW3elyWPwli3VyvLf/4iAPnyYj7+YQ3CPU9+9ugf
X-Gm-Gg: ASbGncurWwkiRZurxartvXlQ3Sz6dNFgWmU13Q6HQB9kVWh6OJFfGfy7Q356t+JQvnU
 C9J/LZuXN0ZwWlqBtqWXjvmlYfJuKyQJtpg318+1BkrujgBJLjgEFbCUNYvEm7A/9NWCYbeAi08
 FPIKSLrRBSrS78lRr4KXAl9HE5cwQa2ONQZ17dJTuH4kbNstyZyheWyCzUGrGfKFSIVkMzPHJsC
 jHerF8U4IWtamn/5naIfam4R0ZSvq2jC+5Qy6pdxkEg/1GtN8as6veEY+8Z7KLSdpbFDYFavR/I
 BNPrLw==
X-Received: by 2002:a05:6000:184c:b0:39e:cbcf:9dad with SMTP id
 ffacd0b85a97d-39efba50f42mr13164627f8f.20.1745389901449; 
 Tue, 22 Apr 2025 23:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHTnNViFGtj+hE8eSS47RMTl6phnmWrOiw3RfHySOJRAaPYd7BUvEM8jxvJlxU+3Y5Lvs8Ww==
X-Received: by 2002:a05:6000:184c:b0:39e:cbcf:9dad with SMTP id
 ffacd0b85a97d-39efba50f42mr13164597f8f.20.1745389900902; 
 Tue, 22 Apr 2025 23:31:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d35bb0sm13509805e9.27.2025.04.22.23.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 23:31:40 -0700 (PDT)
Date: Wed, 23 Apr 2025 02:31:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Antoine Damhet <adamhet@scaleway.com>
Subject: Re: [PATCH] Reapply "virtio-net: Copy received header to buffer"
Message-ID: <20250423022734-mutt-send-email-mst@kernel.org>
References: <20250423-reapply-v1-1-6f4fc3027906@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-reapply-v1-1-6f4fc3027906@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On Wed, Apr 23, 2025 at 03:19:30PM +0900, Akihiko Odaki wrote:
> This reverts commit e28fbd1c525db21f0502b85517f49504c9f9dcd8.
> 
> The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
> buffer") was to remove the need to patch the (const) input buffer with a
> recomputed UDP checksum by copying headers to a RW region and inject the
> checksum there. The patch computed the checksum only from the header
> fields (missing the rest of the payload) producing an invalid one
> and making guests fail to acquire a DHCP lease.
> 
> Reapply the mentioned commit with a change to copy the entire packet
> instead of only copying the headers to acheive the original goal without

achieve

> breaking checksums.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

thanks for the patch!
yet the commit log needs improvement:

I don't think this "reverts commit
e28fbd1c525db21f0502b85517f49504c9f9dcd8" is correct.

and now it's all of the packet not the header.


So just call it:
virtio-net: copy received packet to buffer

and introduce the issue and the fixup, not the archeology.

something like:

commit e28fbd1c525db reintroduced an issue that we attempted
to fix with commit 7987d2be5a8b:
....

fix by ....



HTH



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


