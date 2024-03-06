Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF724C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhxyK-0004Ud-Js; Wed, 06 Mar 2024 15:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhxyB-0004PZ-J5
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhxyA-0001rG-1q
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709757269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chKv2cBabJOJEUIJJ5A4r+Q2wAgq0Jq23Cv/UF3W8pk=;
 b=KKsnoLbvZVf8QvaLU2iQdWXNKQH0LEeqipX3Sgxmw/UP1ntk/aN+U527foQg5rEW04moMF
 3tUOe/X0vvSoNaaNnfY4MnQWl//bahNg16GlnhjgSmpJDQ43Vim7Xc9mtZgZC29wXZ6DmT
 PXHP6tKkC6StNV3xHWRG/g2wngP85Qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-ouZLYDpaMCyNnVR3ywvG_w-1; Wed, 06 Mar 2024 15:34:25 -0500
X-MC-Unique: ouZLYDpaMCyNnVR3ywvG_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B69E78007A1;
 Wed,  6 Mar 2024 20:34:24 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5556736FF;
 Wed,  6 Mar 2024 20:34:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 imammedo@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v7 8/9] hw/arm/virt: Set virtio-iommu aw-bits default value to
 48
Date: Wed,  6 Mar 2024 21:32:47 +0100
Message-ID: <20240306203348.65776-9-eric.auger@redhat.com>
In-Reply-To: <20240306203348.65776-1-eric.auger@redhat.com>
References: <20240306203348.65776-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Zhenzhong Duan <Zhenzhong.duan@intel.com>

---

v6 -> v7
turn arm_virt_compat and arm_virt_compat_len static
---
 hw/arm/virt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0af1943697..e5cd935232 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -85,11 +85,28 @@
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
 
+static GlobalProperty arm_virt_compat[] = {
+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
+};
+static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
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


