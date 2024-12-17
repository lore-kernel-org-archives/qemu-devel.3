Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813FFE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYZo-0001Gy-9x; Tue, 17 Dec 2024 09:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZN-0000xc-Fo
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZL-0004wY-8G
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734445742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4wK3v+/PfbFX1aitYHsoHtsQk/8x2gQh7RTaACX+R0=;
 b=MQu+IKpLoD348uepTeoPULsZskUBkczFXBelz7l1oItbZllOUy9e9vSsSV1A6H0h4un4Sx
 qoH2L07sTNaqmU5mSXiUqFQKp/ubtk77FAyeBTlPWE/MspkWdgoiXQ7CWpxaKeTA8JPN0+
 TlpV1VB5thfyd9zrc+fj0mKbmXXzlF8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-gcwfWr0wPiqrNlsqhCpcOQ-1; Tue,
 17 Dec 2024 09:29:01 -0500
X-MC-Unique: gcwfWr0wPiqrNlsqhCpcOQ-1
X-Mimecast-MFC-AGG-ID: gcwfWr0wPiqrNlsqhCpcOQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41FEC195605A; Tue, 17 Dec 2024 14:29:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 023FF19560B0; Tue, 17 Dec 2024 14:28:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 197B321EC340; Tue, 17 Dec 2024 15:28:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Subject: [PATCH 6/6] qdev: Improve a few more PropertyInfo @description members
Date: Tue, 17 Dec 2024 15:28:54 +0100
Message-ID: <20241217142855.3805068-7-armbru@redhat.com>
In-Reply-To: <20241217142855.3805068-1-armbru@redhat.com>
References: <20241217142855.3805068-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/xen-block.c             | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 hw/core/qdev-properties.c        | 1 +
 hw/s390x/ccw-device.c            | 4 ++--
 target/sparc/cpu.c               | 1 +
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 1303c9dcc9..722e8723f5 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -661,7 +661,7 @@ invalid:
  */
 const PropertyInfo xen_block_prop_vdev = {
     .type  = "str",
-    .description = "Virtual Disk specifier: d*p*/xvd*/hd*/sd*",
+    .description = "Virtual Disk specifier (d*p*/xvd*/hd*/sd*)",
     .get = xen_block_get_vdev,
     .set = xen_block_set_vdev,
 };
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 9d1f358263..986123d188 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -985,7 +985,7 @@ inval:
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
     .type = "str",
-    .description = "Address (bus/device/function) of "
+    .description = "Address (bus:device.function) of "
                    "the host device, example: 04:10.0",
     .get = get_pci_host_devaddr,
     .set = set_pci_host_devaddr,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 67b17848b8..02f9b0850a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -247,6 +247,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_bool = {
     .type  = "bool",
+    .description = "on/off",
     .get   = get_bool,
     .set   = set_bool,
     .set_default_value = set_default_value_bool,
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index ecf735e9fe..ae66d846b3 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -75,8 +75,8 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
 
 const PropertyInfo ccw_loadparm = {
     .type  = "str",
-    .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
-            " to the guest loader/kernel",
+    .description = "Up to 8 chars in set of [A-Za-z0-9. ] to select"
+            " a guest kernel",
     .get = ccw_device_get_loadparm,
     .set = ccw_device_set_loadparm,
 };
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index c3572b8a57..7d2833b2b2 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -870,6 +870,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
 
 static PropertyInfo qdev_prop_nwindows = {
     .type  = "int",
+    .description = "Number of register windows",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,
 };
-- 
2.47.0


