Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB997CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTZ-0005sK-Ns; Thu, 15 Oct 2026 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTU-0005Ya-Bp
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTS-0005bP-32
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNoELrlgMsrXFiUnOLWVdQdQwMaebCX35+/HiwhaaW0=;
 b=WS/nMZ6lj3uYSXk8zjSvDE+fBRsEMJFMp3x9j6Se7eYkM4omFLM5hqHa9/idbA5E1sUoay
 x90pS2h+xG6McW482a6B6n1oXntcZUf4grI9Ugk3Jxv2jKeIGdImYzbwf32uT4XgTLudNa
 X1DvlfcRB/6367jWvIflm4mF6xuYg+k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-XgBs26-VNJeLWQcVFCZsBQ-1; Thu,
 15 Oct 2026 12:22:14 +0000
X-MC-Unique: XgBs26-VNJeLWQcVFCZsBQ-1
X-Mimecast-MFC-AGG-ID: XgBs26-VNJeLWQcVFCZsBQ_1792066933
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A9081955F0C; Thu, 15 Oct 2026 12:22:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DF817D9; Thu, 15 Oct 2026 12:22:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/21] hw/misc/unimp: Add create_unimplemented_devices() helper
Date: Thu, 15 Oct 2026 14:21:39 +0200
Message-ID: <20261015122151.889017-10-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Several boards and SoCs create many unimplemented devices. Each of them
uses its own structure and helper to describe and map these devices.

Add an UnimplementedDeviceConfig structure and a
create_unimplemented_devices() helper. The helper creates an
unimplemented device for each entry of a table, adds it as a QOM child
of the parent object, and maps it in a memory region container with
the given priority. The table is terminated by an empty entry.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/unimp.h | 21 +++++++++++++++++++++
 hw/misc/unimp.c         | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 77a5077511f2..073575159d60 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -25,6 +25,27 @@ struct UnimplementedDeviceState {
     uint64_t size;
 };
 
+typedef struct UnimplementedDeviceConfig {
+    const char *qom_name;
+    const char *region_name;
+    uint64_t offset;
+    uint64_t size;
+    int priority;
+} UnimplementedDeviceConfig;
+
+/**
+ * create_unimplemented_devices:
+ * @parentobj: the parent object
+ * @container: a #MemoryRegion within which @addr is a relative address
+ * @devconfigs: NULL terminated array of #UnimplementedDeviceConfig
+ *
+ * For each entries in @devconfigs, create a TYPE_UNIMPLEMENTED_DEVICE
+ * and mmap it in @container at UnimplementedDeviceConfig::offset.
+ * @container is expected to be a QOM child of @parentobj.
+ */
+void create_unimplemented_devices(Object *parentobj, MemoryRegion *container,
+                                  const UnimplementedDeviceConfig *devconfigs);
+
 /**
  * create_unimplemented_device: create and map a dummy device
  * @name: name of the device for debug logging
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 521b84bf20bf..4c8dcbdff336 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -96,3 +96,23 @@ static void unimp_register_types(void)
 }
 
 type_init(unimp_register_types)
+
+void create_unimplemented_devices(Object *parentobj, MemoryRegion *container,
+                                  const UnimplementedDeviceConfig *devconfigs)
+{
+    const UnimplementedDeviceConfig *cfg;
+
+    for (cfg = devconfigs; cfg->qom_name; cfg++) {
+        DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+        object_property_add_child(parentobj, cfg->qom_name, OBJECT(dev));
+        qdev_prop_set_string(dev, "name", cfg->region_name);
+        qdev_prop_set_uint64(dev, "size", cfg->size);
+        sysbus_realize_and_unref(sbd, &error_fatal);
+
+        memory_region_add_subregion_overlap(container, cfg->offset,
+                                            sysbus_mmio_get_region(sbd, 0),
+                                            cfg->priority);
+    }
+}
-- 
2.56.0


