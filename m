Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC73CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DsA-0006my-A8; Fri, 10 Oct 2025 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v7Ds7-0006md-Dz
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v7Drz-0002U9-Qq
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760105598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jfP37OrjzP6BVstZ4NrGxVQQoLpknKDn+l6jJXJ50kQ=;
 b=iYvoxvKakLiWkO4Y4DBZqmoTo1ESE3ZCJ6ALBadBssLDInXuakcHzf7f+drM5iyJLr2rea
 0JLuWpMGa8pIVL0azWw/I7VG4Caa1RGulnDFTOIwHwaEQPRluRtVoQu/nAgl7qU5a8z5EV
 66wgj2I9T4lZttYbvkjb/ztnlGUYxgk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-HXWvEBtHOV-J4zBEqs4GAQ-1; Fri,
 10 Oct 2025 10:13:14 -0400
X-MC-Unique: HXWvEBtHOV-J4zBEqs4GAQ-1
X-Mimecast-MFC-AGG-ID: HXWvEBtHOV-J4zBEqs4GAQ_1760105593
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 062011800452; Fri, 10 Oct 2025 14:13:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.164])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7FE01800452; Fri, 10 Oct 2025 14:13:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] virtio-net: Advertise UDP tunnel GSO support by default
Date: Fri, 10 Oct 2025 16:12:57 +0200
Message-ID: <9c500fbcd2cf29afd1826b1ac906f9d5beac3601.1760104079.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

Allow bidirection aggregated traffic for UDP encapsulated flows.

Add the needed compatibility entries to avoid migration issues
vs older QEMU instances.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/core/machine.c   | 4 ++++
 hw/net/virtio-net.c | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 681adbb7ac..0cd44a95b6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,10 @@
 
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+    { TYPE_VIRTIO_NET, "host_tunnel", "off"},
+    { TYPE_VIRTIO_NET, "host_tunnel_csum", "off"},
+    { TYPE_VIRTIO_NET, "guest_tunnel", "off"},
+    { TYPE_VIRTIO_NET, "guest_tunnel_csum", "off"},
 };
 const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 33116712eb..d8f5c5b81d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4300,19 +4300,19 @@ static const Property virtio_net_properties[] = {
     VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
-                               false),
+                               true),
     VIRTIO_DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
-                               false),
+                               true),
     VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
-                               false),
+                               true),
     VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
-                               false),
+                               true),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
-- 
2.51.0


