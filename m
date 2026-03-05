Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A8F30930
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6KN-0001ss-2S; Thu, 05 Mar 2026 05:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6KK-0001s3-Nz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6KI-0005Wc-NO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ekLPVHYOVkLZAradQmSaJNW1TZzwmRdnf71YAxurjM=;
 b=aLSk1+kLGRuKPc21Jr7EQolPgGCWRFA+blww4B1292yIPKwtKuhtHCicUSxXC/SJIE1jK3
 239W0aZ5Cq1LCKkFBnjORkXdYiHT96BWx4cQQBdEFi6xhcrcSBav270TPknP6YRgC9f1nG
 IQPGG/2Y4j3q8ffeJtI4nno2RXHTxd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-O5rzmCneONaPHOuIok8u9Q-1; Thu,
 05 Mar 2026 05:53:02 -0500
X-MC-Unique: O5rzmCneONaPHOuIok8u9Q-1
X-Mimecast-MFC-AGG-ID: O5rzmCneONaPHOuIok8u9Q_1772707981
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7C09195605C; Thu,  5 Mar 2026 10:53:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5A743003E98; Thu,  5 Mar 2026 10:52:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 13/28] hw/net/virtio-net: Remove VirtIONet::mtu_bypass_backend
 field
Date: Thu,  5 Mar 2026 11:52:00 +0100
Message-ID: <20260305105215.302571-14-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtIONet::mtu_bypass_backend boolean was only set in
the hw_compat_2_9[] array, via the 'x-mtu-bypass-backend=off'
property. We removed all machines using that array, lets remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-17-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
[thuth: Adjusted patch for latest changes in the master branch]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260225092024.794595-14-thuth@redhat.com>
---
 include/hw/virtio/virtio-net.h | 1 -
 hw/net/virtio-net.c            | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5b8ab7bda79..371e3764282 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -218,7 +218,6 @@ struct VirtIONet {
     uint64_t saved_guest_offloads;
     AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
-    bool mtu_bypass_backend;
     /* primary failover device is hidden*/
     bool failover_primary_hidden;
     bool failover;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eccb48ad426..2a5d642a647 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -935,8 +935,7 @@ static void virtio_net_set_features(VirtIODevice *vdev,
     int i;
 
     virtio_features_copy(features, in_features);
-    if (n->mtu_bypass_backend &&
-            !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
+    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
         virtio_clear_feature_ex(features, VIRTIO_NET_F_MTU);
     }
 
@@ -3160,8 +3159,7 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     vhost_net_get_features_ex(get_vhost_net(nc->peer), features);
     virtio_features_copy(vdev->backend_features_ex, features);
 
-    if (n->mtu_bypass_backend &&
-            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
+    if ((n->host_features & 1ULL << VIRTIO_NET_F_MTU) != 0) {
         virtio_add_feature_ex(features, VIRTIO_NET_F_MTU);
     }
 
@@ -4251,8 +4249,6 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
                        VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
-    DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
-                     true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
-- 
2.53.0


