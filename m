Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0063C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 18:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhZD7-0002AZ-Fl; Tue, 05 Mar 2024 13:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhZD4-00025y-Pt
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 13:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhZD3-00009l-Ea
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 13:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709662092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaYMvUYAW68FZKxiZnuqrn5CwWP/VqklI1W2luIlxrA=;
 b=hpyp+1vjMZDJu3URho431yOcsCjWpHYx2L3hnlguAIsTqPKljojrCZE/AuXyX8bmtRFHBq
 WGDdrbGAMKKk3NwGER0Z+UMYLCUzTIQjWpf1O5/TLxpjis0pohhJuYz4n8ujPdHnExa+we
 onaJ5dX4l5l/ELj9sehY6usRWxElBXU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-LPZp8DnaNmmeoLsodz_5MA-1; Tue,
 05 Mar 2024 13:08:11 -0500
X-MC-Unique: LPZp8DnaNmmeoLsodz_5MA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D775838000A2;
 Tue,  5 Mar 2024 18:08:10 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF7AC041F0;
 Tue,  5 Mar 2024 18:08:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 imammedo@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v6 8/9] hw/arm/virt: Set virtio-iommu aw-bits default value to
 48
Date: Tue,  5 Mar 2024 19:06:26 +0100
Message-ID: <20240305180734.48515-9-eric.auger@redhat.com>
In-Reply-To: <20240305180734.48515-1-eric.auger@redhat.com>
References: <20240305180734.48515-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On ARM we set 48b as a default (matching SMMUv3 SMMU_IDR5.VAX == 0).

hw_compat_8_2 is used to handle the compatibility for machine types
before 9.0 (default was 64 bits).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0af1943697..dcfb25369b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -85,11 +85,28 @@
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
 
+GlobalProperty arm_virt_compat[] = {
+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
+};
+const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
+
+/*
+ * This cannot be called from the virt_machine_class_init() because
+ * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
+ * only is called on virt non abstract class init.
+ */
+static void arm_virt_compat_set(MachineClass *mc)
+{
+    compat_props_add(mc->compat_props, arm_virt_compat,
+                     arm_virt_compat_len);
+}
+
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
                                                     void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
+        arm_virt_compat_set(mc); \
         virt_machine_##major##_##minor##_options(mc); \
         mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
         if (latest) { \
-- 
2.41.0


