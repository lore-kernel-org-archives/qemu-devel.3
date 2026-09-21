Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D48C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8l5u-0005yh-VK; Mon, 21 Sep 2026 16:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l5K-0005bm-2l
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l5G-0003dF-37
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790024273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OcKAVzNSosvgaJJQ9NSF540owN/x61zRhy/lSKvQ24=;
 b=JTmp/VvJmmdwg7Xl71hlj8Cx65r08qhD68iYNX9HrNcUJwEVcfsvjbY87H1Yyoe5OLxDl0
 V8iV/Hf5a3F3NHKzkHPpYpEPhc4nXYsylCkNwpzzLSVjbhot01jztq7INx3zDKkHqzmJJh
 Gk+E0Au1hFTyEnTjh1RAKRB0znjpRlo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-P_oBXvExOXKsmkTNyG8LQw-1; Mon,
 21 Sep 2026 16:57:51 -0400
X-MC-Unique: P_oBXvExOXKsmkTNyG8LQw-1
X-Mimecast-MFC-AGG-ID: P_oBXvExOXKsmkTNyG8LQw_1790024270
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50BDE19560BB; Mon, 21 Sep 2026 20:57:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D86EB1956042; Mon, 21 Sep 2026 20:57:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 10/10] qapi: split intro sections for inlinable structs
Date: Mon, 21 Sep 2026 16:57:12 -0400
Message-ID: <20260921205712.1862167-11-jsnow@redhat.com>
In-Reply-To: <20260921205712.1862167-1-jsnow@redhat.com>
References: <20260921205712.1862167-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

This patch splits the intro/details section for structs which are used
in an inlinable context; i.e. structs used either as arguments for a
command/event, or used as a branch of a union. The QAPI documentation
block for these entities will have their "intro" section removed when
inlined into other contexts, but may still display the intro section
on generated documentation *IF* these structs are also used as an
argument or return type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json |  5 ++---
 qapi/crypto.json       |  3 +--
 qapi/machine.json      | 11 ++++-------
 qapi/net.json          | 34 +++++++++++++++-------------------
 qapi/qom.json          |  9 +++------
 5 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 77459f6321b..e3cee2fb5ce 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -154,9 +154,8 @@
 
 ##
 # @BlockExportOptionsFuse:
-#
-# Options for exporting a block graph node on some (file) mountpoint
-# as a raw image.
+#     Options for exporting a block graph node on some (file)
+#     mountpoint as a raw image.
 #
 # Multi-threading note: The FUSE export supports multi-threading.
 # Currently, requests are distributed across these threads in a
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 7b4c80edae2..a8d753d360f 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -429,8 +429,7 @@
 
 ##
 # @SecretProperties:
-#
-# Properties for secret objects.
+#     Properties for secret objects.
 #
 # Either @data or @file must be provided, but not both.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index b18c6d94a38..1220116bf7d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -684,9 +684,8 @@
 
 ##
 # @NumaHmatLBOptions:
-#
-# Set the system locality latency and bandwidth information between
-# Initiator and Target proximity Domains.
+#     Set the system locality latency and bandwidth information
+#     between Initiator and Target proximity Domains.
 #
 # For more information about `NumaHmatLBOptions`, see chapter
 # 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
@@ -760,8 +759,7 @@
 
 ##
 # @NumaHmatCacheOptions:
-#
-# Set the memory side cache information for a given memory domain.
+#     Set the memory side cache information for a given memory domain.
 #
 # For more information of `NumaHmatCacheOptions`, see chapter
 # 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
@@ -926,8 +924,7 @@
 
 ##
 # @CpuInstanceProperties:
-#
-# Properties identifying a CPU.
+#     Properties identifying a CPU.
 #
 # Which members are optional and which mandatory depends on the
 # architecture and board.
diff --git a/qapi/net.json b/qapi/net.json
index b0a15fd53e2..2a186a71b93 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -719,11 +719,10 @@
 
 ##
 # @NetdevVhostVDPAOptions:
+#     Vhost-vdpa network backend
 #
-# Vhost-vdpa network backend
-#
-# vDPA device is a device that uses a datapath which complies with the
-# virtio specifications with a vendor specific control path.
+#     vDPA device is a device that uses a datapath which complies with
+#     the virtio specifications with a vendor specific control path.
 #
 # @vhostdev: path of vhost-vdpa device (default:'/dev/vhost-vdpa-0')
 #
@@ -750,11 +749,10 @@
 
 ##
 # @NetdevVmnetHostOptions:
+#     vmnet (host mode) network backend.
 #
-# vmnet (host mode) network backend.
-#
-# Allows the vmnet interface to communicate with other vmnet
-# interfaces that are in host mode and also with the host.
+#     Allows the vmnet interface to communicate with other vmnet
+#     interfaces that are in host mode and also with the host.
 #
 # @start-address: The starting IPv4 address to use for the interface.
 #     Must be in the private IP range (RFC 1918).  Must be specified
@@ -793,15 +791,14 @@
 
 ##
 # @NetdevVmnetSharedOptions:
+#     vmnet (shared mode) network backend.
 #
-# vmnet (shared mode) network backend.
-#
-# Allows traffic originating from the vmnet interface to reach the
-# Internet through a network address translator (NAT).  The vmnet
-# interface can communicate with the host and with other shared mode
-# interfaces on the same subnet.  If no DHCP settings, subnet mask and
-# IPv6 prefix specified, the interface can communicate with any of
-# other interfaces in shared mode.
+#     Allows traffic originating from the vmnet interface to reach the
+#     Internet through a network address translator (NAT).  The vmnet
+#     interface can communicate with the host and with other shared
+#     mode interfaces on the same subnet.  If no DHCP settings, subnet
+#     mask and IPv6 prefix specified, the interface can communicate
+#     with any of other interfaces in shared mode.
 #
 # @start-address: The starting IPv4 address to use for the interface.
 #     Must be in the private IP range (RFC 1918).  Must be specified
@@ -838,10 +835,9 @@
 
 ##
 # @NetdevVmnetBridgedOptions:
+#     vmnet (bridged mode) network backend.
 #
-# vmnet (bridged mode) network backend.
-#
-# Bridges the vmnet interface with a physical network interface.
+#     Bridges the vmnet interface with a physical network interface.
 #
 # @ifname: The name of the physical interface to be bridged.
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 51af9485e6d..e67cd0cd54d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -456,8 +456,7 @@
 
 ##
 # @FilterRedirectorProperties:
-#
-# Properties for filter-redirector objects.
+#     Properties for filter-redirector objects.
 #
 # At least one of @indev or @outdev must be present.  If both are
 # present, they must not refer to the same character device backend.
@@ -756,8 +755,7 @@
 
 ##
 # @MemoryBackendShmProperties:
-#
-# Properties for memory-backend-shm objects.
+#     Properties for memory-backend-shm objects.
 #
 # This memory backend supports only shared memory, which is the
 # default.
@@ -771,8 +769,7 @@
 
 ##
 # @MemoryBackendEpcProperties:
-#
-# Properties for memory-backend-epc objects.
+#     Properties for memory-backend-epc objects.
 #
 # The @merge boolean option is false by default with epc
 #
-- 
2.55.0


