Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC15C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxqs-0002M9-Pa; Tue, 25 Feb 2025 11:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxq6-000193-K8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxq3-0006cD-A3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740501077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LerVMLCO2g0uxpoATuHSnU0aK0p7jxOiA6jhHk9aNQ=;
 b=P5rZt0rP37kHzGDJmng+U4G915lCYkCVsT/Zr49mhsUb4pgEwhsiavmJDNWdL0sVKpv5f3
 YCsVJHEtVo/PRTYQ+yXwqP2xRoP92TJ+IFfwLk3/uMuhIFQoOJ3P6Mg3vbCvR7F5eWdWqZ
 jVld17yJ4VHsK4mDgTOIngPt/nH5buw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-l3WcQJdJO5u_z4qVFDJxmg-1; Tue,
 25 Feb 2025 11:31:13 -0500
X-MC-Unique: l3WcQJdJO5u_z4qVFDJxmg-1
X-Mimecast-MFC-AGG-ID: l3WcQJdJO5u_z4qVFDJxmg_1740501071
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EFA418E6952; Tue, 25 Feb 2025 16:31:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CD3E1800367; Tue, 25 Feb 2025 16:31:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 14A1318007A1; Tue, 25 Feb 2025 17:30:33 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 22/24] hw/uefi-vars-sysbus: allow for pc and q35
Date: Tue, 25 Feb 2025 17:30:26 +0100
Message-ID: <20250225163031.1409078-23-kraxel@redhat.com>
In-Reply-To: <20250225163031.1409078-1-kraxel@redhat.com>
References: <20250225163031.1409078-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

Allow the device being added to x86_64 pc and q35 VMs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/pc_piix.c | 2 ++
 hw/i386/pc_q35.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04d2957adcd7..6c91e2d29298 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -65,6 +65,7 @@
 #include "system/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/uefi/var-service-api.h"
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
 
@@ -468,6 +469,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
 
     object_class_property_add_enum(oc, "x-south-bridge", "PCSouthBridgeOption",
                                    &PCSouthBridgeOption_lookup,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 77536dd697f5..fd96d0345c7d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -58,6 +58,7 @@
 #include "system/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/uefi/var-service-api.h"
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
 
@@ -355,6 +356,7 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
     compat_props_add(m->compat_props,
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
-- 
2.48.1


