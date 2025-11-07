Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1BCCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 02:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHBoT-0001rO-Bk; Thu, 06 Nov 2025 21:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHBoR-0001rD-CC
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 21:02:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHBoO-0001qg-Ct
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 21:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762480966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lUzEpz5kGOdPdDJlLTFr3b8YB9vkZu4jiNYvdmwIlzk=;
 b=GMf74LwIk35dN3m9oF7WIjb1FbELoEafLXPQYC4CgwjQJm5XIJkvtZdxpDpoVb/s+7q1TO
 kfsvUgwGqIFjSr+aJMK/p4LQ7hSm8aKxRw28w1yPJ+nfLTztptKL4w+9mVgI4ulxbd1u/C
 ceIyU7I89Y7wQ3cM31nlEWyXa/i/qFw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-UOKMSpdSO6Ozu4j_Or2KcA-1; Thu,
 06 Nov 2025 21:02:44 -0500
X-MC-Unique: UOKMSpdSO6Ozu4j_Or2KcA-1
X-Mimecast-MFC-AGG-ID: UOKMSpdSO6Ozu4j_Or2KcA_1762480963
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 914561884A9C; Fri,  7 Nov 2025 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F9191971EC1; Fri,  7 Nov 2025 02:01:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 jasowang@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com
Cc: farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: [RFC PATCH] virtio-net: introduce strict peer feature check
Date: Fri,  7 Nov 2025 10:01:49 +0800
Message-ID: <20251107020149.3223-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We used to clear features silently in virtio_net_get_features() even
if it is required. This complicates the live migration compatibility
as the management layer may think the feature is enabled but in fact
not.

Let's add a strict feature check to make sure if there's a mismatch
between the required feature and peer, fail the get_features()
immediately instead of waiting until the migration to fail. This
offload the migration compatibility completely to the management
layer.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/core/machine.c              |   1 +
 hw/net/virtio-net.c            | 153 +++++++++++++++++++++++++--------
 include/hw/virtio/virtio-net.h |   1 +
 3 files changed, 119 insertions(+), 36 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 681adbb7ac..a9e43c4990 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@
 
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+    { TYPE_VIRTIO_NET, "strict-peer-feature-check", "false"},
 };
 const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 33116712eb..3acc5ed4a6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3090,53 +3090,120 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
 
     if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
-
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
-
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
-
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
-        virtio_clear_feature_ex(features,
-                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
-        virtio_clear_feature_ex(features,
-                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+        if (n->strict_peer_feature_check) {
+            if (virtio_has_feature_ex(features, VIRTIO_NET_F_CSUM) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_TSO4) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_TSO6) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_ECN) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_ECN) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_HASH_REPORT)) {
+                error_setg(errp, "virtio_net: peer doesn't support vnet hdr");
+                return;
+            }
+        } else {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
+
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
+
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
+
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+            virtio_clear_feature_ex(features,
+                                    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+            virtio_clear_feature_ex(features,
+                                    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
 
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
+        }
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
+        if (n->strict_peer_feature_check) {
+            if (virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UFO) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UFO)) {
+                error_setg(errp, "virtio_net: peer doesn't support UFO");
+                return;
+            }
+        } else {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
+        }
     }
     if (!peer_has_uso(n)) {
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
+        if (n->strict_peer_feature_check) {
+            if (virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6)) {
+                error_setg(errp, "virtio_net: peer doesn't support USO");
+                return;
+            }
+        } else {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
+        }
     }
 
     if (!peer_has_tunnel(n)) {
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
-        virtio_clear_feature_ex(features,
-                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
-        virtio_clear_feature_ex(features,
-                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+        if (n->strict_peer_feature_check) {
+            if (virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM) |
+                virtio_has_feature_ex(features,
+                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM)) {
+                error_setg(errp, "virtio_net: peer doesn't support tunnel GSO");
+                return;
+            }
+        } else {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
+            virtio_clear_feature_ex(features,
+                                    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
+            virtio_clear_feature_ex(features,
+                                    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
+        }
     }
 
     if (!get_vhost_net(nc->peer)) {
         if (!use_own_hash) {
-            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
-            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
+            if (n->strict_peer_feature_check) {
+                if (virtio_has_feature_ex(features, VIRTIO_NET_F_HASH_REPORT) |
+                    virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
+                    error_setg(errp,
+                               "virtio_net: peer doesn't support RSS/HASH_REPORT");
+                    return;
+                }
+            } else {
+                virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
+                virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
+            }
         } else if (virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
             virtio_net_load_ebpf(n, errp);
         }
@@ -3145,14 +3212,26 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 
     if (!use_peer_hash) {
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
+        if (n->strict_peer_feature_check &&
+            virtio_has_feature_ex(features, VIRTIO_NET_F_HASH_REPORT)) {
+            error_setg(errp, "virtio_net: peer doesn't HASH_REPORT");
+            return;
+        } else {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
+        }
 
         if (!use_own_hash || !virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
             if (!virtio_net_load_ebpf(n, errp)) {
                 return;
             }
 
-            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
+            if (n->strict_peer_feature_check &&
+                virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
+                error_setg(errp, "virtio_net: fail to attach eBPF for RSS");
+                return;
+            } else {
+                virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
+            }
         }
     }
 
@@ -4313,6 +4392,8 @@ static const Property virtio_net_properties[] = {
                                host_features_ex,
                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
                                false),
+    DEFINE_PROP_BOOL("strict-peer-feature-check", VirtIONet,
+                     strict_peer_feature_check, true),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5b8ab7bda7..abd4ca4bb0 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -222,6 +222,7 @@ struct VirtIONet {
     /* primary failover device is hidden*/
     bool failover_primary_hidden;
     bool failover;
+    bool strict_peer_feature_check;
     DeviceListener primary_listener;
     QDict *primary_opts;
     bool primary_opts_from_json;
-- 
2.34.1


