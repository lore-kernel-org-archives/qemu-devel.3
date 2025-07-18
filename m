Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82056C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucl3T-00082K-7U; Fri, 18 Jul 2025 09:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucl3O-0007yw-8K
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucl3L-0000fu-UY
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752844986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pxx04Xd6ZSgCiBTLn0MckaPvH6V0RgrK8Xn+IUV9R2I=;
 b=UMwvJubzELT1eyfMgjxBcN8LbNI2bOxskpMUgwk6m07ptBUu//nIurCpLo+H0mSikjShZV
 x+vNlXc7+aRMKzMzfFQD86vBSp2RZT5YeBBSEOHThi2X7Z/x/sErHzEXXDmuqCkX5M/tDn
 G8am38CDifPkL4w9NDOoQQFvn+kjL7I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-7n42VJMoOuaQwU_8PmjcZg-1; Fri, 18 Jul 2025 09:23:03 -0400
X-MC-Unique: 7n42VJMoOuaQwU_8PmjcZg-1
X-Mimecast-MFC-AGG-ID: 7n42VJMoOuaQwU_8PmjcZg_1752844983
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e32b9398e4so262818485a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 06:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752844983; x=1753449783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pxx04Xd6ZSgCiBTLn0MckaPvH6V0RgrK8Xn+IUV9R2I=;
 b=DbGc9ErG41MH40auPEzkwbgC1GNO9oahFPukJsXg98Q5HSHJQd43AQtIa8eftYZCl8
 7/GrGxC/uBMyFk9yVaNc9YnWMs2sayNlKFJAi/feVsGgMFknmUVEQSIoTuvuFswb4Xo6
 2uYo2JdnENvWoyNqp1Fqr0oKiSev5Vzb7sctCgVZwp+CHGtf1ixzFr3htOIsFFgvYa7U
 +bw0uBhaupswsf949F9U/QaMFT3VdCmckQpszZx2dlrWpv15/sjDILCQm9esLMtudhxf
 8DZPPfgm8qin/yab+MhDxGV0SxvfobqT4nIY6Wawfdhpec7TMTFaa8ej7w6ZKz+YtX62
 ocUQ==
X-Gm-Message-State: AOJu0Yx+AIYDc4NZ0uXvt2YME0VFsOYmTHJxgjjoP9QQgwPC4KrNqC+4
 uyQSwS0hR8MY8GJ90Whz82LteRV38947jlNdgOfz9LC1H6MpCsJNqlD9Vj3k1kJ+Nw7hCRhwOSY
 +fB5AmX0kJGdVqg7XFjDid9dmrh8ud+X2y5lFOidX5bIxrK65+bL1ea5m
X-Gm-Gg: ASbGncuUxD8QOptOJytpmy3dlt+jjkqTMaNhNB4NuPNjzdsFzQ+dWNT81bfFcwWGT+O
 ZTPbePosSkpfTc0VtbV0rI28BwHrAG87UDN5rjtnh83stBN4N/+sD69U1dIZpJR6LfRPUme7jte
 IiVwYa1F6zHgJnggGN1oX2WNxYQxcyicKr/9QvOx8ZlxUk9xbfZsfUMesv9teu0g60g5OInnDd6
 HWELE/CWN8msMyGH/XaeS69zTMrmsYCWh/CHcdz79MEJd00edx9SzkYl2kZH1NwVtWr5NFa3Gyg
 Cw/KatvLcO6fuSMlFf244aurLJIj+w3ac9ChtZSks5Lb82uKkQcQ15quCQ0McPNn93DNmCCWdR9
 I4z2h29+sYe5R65A=
X-Received: by 2002:a05:620a:63c2:b0:7d5:dbdc:ceef with SMTP id
 af79cd13be357-7e34356f48cmr1240823085a.18.1752844982783; 
 Fri, 18 Jul 2025 06:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSaFqOTa4dviz7t2rR0dSGtcmzQKchQih1hWZxvSy6vfBRJdTly7IxDu41C3vLgjcYz6cEkQ==
X-Received: by 2002:a05:620a:63c2:b0:7d5:dbdc:ceef with SMTP id
 af79cd13be357-7e34356f48cmr1240818485a.18.1752844982164; 
 Fri, 18 Jul 2025 06:23:02 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b48c97sm83728585a.24.2025.07.18.06.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 06:23:01 -0700 (PDT)
Date: Fri, 18 Jul 2025 15:22:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC v3 13/13] net: implement UDP tunnel features offloading
Message-ID: <7eaaizkny73ki3o3ph7bi2x6y7cjtfgyupsbyywxmcismtkdvn@vtgzq3bfygzz>
References: <cover.1752828082.git.pabeni@redhat.com>
 <b59ee8e3eb926dd510a7a0f2de16f3d0380589f0.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b59ee8e3eb926dd510a7a0f2de16f3d0380589f0.1752828082.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 18, 2025 at 10:52:39AM +0200, Paolo Abeni wrote:
>When any host or guest GSO over UDP tunnel offload is enabled the
>virtio net header includes the additional tunnel-related fields,
>update the size accordingly.
>
>Push the GSO over UDP tunnel offloads all the way down to the tap
>device extending the newly introduced NetFeatures struct, and
>eventually enable the associated features.
>
>As per virtio specification, to convert features bit to offload bit,
>map the extended features into the reserved range.
>
>Finally, make the vhost backend aware of the exact header layout, to
>copy it correctly. The tunnel-related field are present if either
>the guest or the host negotiated any UDP tunnel related feature:
>add them to the kernel supported features list, to allow qemu
>transfer to the backend the needed information.
>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v2 -> v3:
>  - rebased on top of "net: Consolidate vhost feature bits into vhost_net
>    structure"
>  - _array -> _ex
>
>v1 -> v2:
>  - squashed vhost support into this patch
>  - dropped tun offload consistency checks; they are implemented in
>    the kernel side
>  - virtio_has_tnl_hdr ->virtio_has_tunnel_hdr
>---
> hw/net/virtio-net.c | 34 ++++++++++++++++++++++++++--------
> include/net/net.h   |  2 ++
> net/net.c           |  3 ++-
> net/tap-linux.c     |  6 ++++++
> net/tap.c           |  2 ++
> 5 files changed, 38 insertions(+), 9 deletions(-)
>
>diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>index 70c85f7f77..46f7efac7d 100644
>--- a/hw/net/virtio-net.c
>+++ b/hw/net/virtio-net.c
>@@ -103,6 +103,12 @@
> #define VIRTIO_NET_F2O_SHIFT          (VIRTIO_NET_OFFLOAD_MAP_MIN - \
>                                        VIRTIO_NET_FEATURES_MAP_MIN + 64)
>
>+static bool virtio_has_tunnel_hdr(const uint64_t *features)
>+{
>+    return virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
>+           virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
>+}
>+
> static const VirtIOFeature feature_sizes[] = {
>     {.flags = 1ULL << VIRTIO_NET_F_MAC,
>      .end = endof(struct virtio_net_config, mac)},
>@@ -659,7 +665,8 @@ static bool peer_has_tunnel(VirtIONet *n)
> }
>
> static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>-                                       int version_1, int hash_report)
>+                                       int version_1, int hash_report,
>+                                       int tunnel)
> {
>     int i;
>     NetClientState *nc;
>@@ -667,9 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>     n->mergeable_rx_bufs = mergeable_rx_bufs;
>
>     if (version_1) {
>-        n->guest_hdr_len = hash_report ?
>-            sizeof(struct virtio_net_hdr_v1_hash) :
>-            sizeof(struct virtio_net_hdr_mrg_rxbuf);
>+        n->guest_hdr_len = tunnel ?
>+            sizeof(struct virtio_net_hdr_v1_hash_tunnel) :
>+            (hash_report ?
>+             sizeof(struct virtio_net_hdr_v1_hash) :
>+             sizeof(struct virtio_net_hdr_mrg_rxbuf));
>         n->rss_data.populate_hash = !!hash_report;
>     } else {
>         n->guest_hdr_len = n->mergeable_rx_bufs ?
>@@ -803,6 +812,10 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>        .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>        .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>        .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
>+       .tnl  = !!(n->curr_guest_offloads &
>+                  (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED)),
>+       .tnl_csum = !!(n->curr_guest_offloads &
>+                      (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED)),
>     };
>
>     qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
>@@ -824,7 +837,9 @@ virtio_net_guest_offloads_by_features(const uint64_t *features)
>         (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
>         (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
>         (1ULL << VIRTIO_NET_F_GUEST_USO4) |
>-        (1ULL << VIRTIO_NET_F_GUEST_USO6);
>+        (1ULL << VIRTIO_NET_F_GUEST_USO6) |
>+        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) |
>+        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED);
>
>     return guest_offloads_mask & virtio_net_features_to_offload(features);
> }
>@@ -937,7 +952,8 @@ static void virtio_net_set_features(VirtIODevice *vdev,
>                                virtio_has_feature_ex(features,
>                                                   VIRTIO_F_VERSION_1),
>                                virtio_has_feature_ex(features,
>-                                                  VIRTIO_NET_F_HASH_REPORT));
>+                                                  VIRTIO_NET_F_HASH_REPORT),
>+                               virtio_has_tunnel_hdr(features));
>
>     n->rsc4_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
>         virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
>@@ -3160,13 +3176,15 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>     VirtIONet *n = opaque;
>     VirtIODevice *vdev = VIRTIO_DEVICE(n);
>     int i, link_down;
>+    bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
>
>     trace_virtio_net_post_load_device();
>     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
>                                virtio_vdev_has_feature(vdev,
>                                                        VIRTIO_F_VERSION_1),
>                                virtio_vdev_has_feature(vdev,
>-                                                       VIRTIO_NET_F_HASH_REPORT));
>+                                                      VIRTIO_NET_F_HASH_REPORT),
>+                               has_tunnel_hdr);
>
>     /* MAC_TABLE_ENTRIES may be different from the saved image */
>     if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
>@@ -3986,7 +4004,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>
>     n->vqs[0].tx_waiting = 0;
>     n->tx_burst = n->net_conf.txburst;
>-    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0);
>+    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0, 0);
>     n->promisc = 1; /* for compatibility */
>
>     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
>diff --git a/include/net/net.h b/include/net/net.h
>index 9a9084690d..72b476ee1d 100644
>--- a/include/net/net.h
>+++ b/include/net/net.h
>@@ -43,6 +43,8 @@ typedef struct NetOffloads {
>     bool ufo;
>     bool uso4;
>     bool uso6;
>+    bool tnl;
>+    bool tnl_csum;
> } NetOffloads;
>
> #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
>diff --git a/net/net.c b/net/net.c
>index 9536184a0c..27e0d27807 100644
>--- a/net/net.c
>+++ b/net/net.c
>@@ -575,7 +575,8 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
>
>     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
>            len == sizeof(struct virtio_net_hdr) ||
>-           len == sizeof(struct virtio_net_hdr_v1_hash));
>+           len == sizeof(struct virtio_net_hdr_v1_hash) ||
>+           len == sizeof(struct virtio_net_hdr_v1_hash_tunnel));
>
>     nc->vnet_hdr_len = len;
>     nc->info->set_vnet_hdr_len(nc, len);
>diff --git a/net/tap-linux.c b/net/tap-linux.c
>index e2628be798..8e275d2ea4 100644
>--- a/net/tap-linux.c
>+++ b/net/tap-linux.c
>@@ -279,6 +279,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
>         if (ol->uso6) {
>             offload |= TUN_F_USO6;
>         }
>+        if (ol->tnl) {
>+            offload |= TUN_F_UDP_TUNNEL_GSO;
>+        }
>+        if (ol->tnl_csum) {
>+            offload |= TUN_F_UDP_TUNNEL_GSO_CSUM;
>+        }
>     }
>
>     if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
>diff --git a/net/tap.c b/net/tap.c
>index 23c6c118e7..2dfa843547 100644
>--- a/net/tap.c
>+++ b/net/tap.c
>@@ -62,6 +62,8 @@ static const int kernel_feature_bits[] = {
>     VIRTIO_F_NOTIFICATION_DATA,
>     VIRTIO_NET_F_RSC_EXT,
>     VIRTIO_NET_F_HASH_REPORT,
>+    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
>+    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,

The *_GSO_CSUM are not supported by vhost-net, right?
(sorry, I don't know the details, it just occurred to me by looking at 
the fetaures we enable in the other patch.)

Thanks,
Stefano

>     VHOST_INVALID_FEATURE_BIT
> };
>
>-- 
>2.50.0
>


