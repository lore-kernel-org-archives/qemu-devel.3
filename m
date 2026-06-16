Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45782CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTpT-00079x-2b; Tue, 16 Jun 2026 09:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZTpS-00078m-4T
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZTpQ-0005yn-G3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781616463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWqDgY6YptJE+OeZiINF/nTpYHVswL+HXXlWl6zC+ZM=;
 b=duEaGQ7skqySfE8TK8WbSgWscxsX9AGqNWhObaH3wDmDv1z+KtwZZmK2o6WfUDKTt/q20B
 gn8305i6WMoolA4ZkXpJtSf9rhEP1yKqWkmY70Mn5EoCBRdPw0OGrb8l4z8DJE4TIMILEt
 aGiGrKGjL8oK+G/Z3XP7npNbSl88l3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-D9dqYA-wNueUcUxByP4iTQ-1; Tue,
 16 Jun 2026 09:27:40 -0400
X-MC-Unique: D9dqYA-wNueUcUxByP4iTQ-1
X-Mimecast-MFC-AGG-ID: D9dqYA-wNueUcUxByP4iTQ_1781616458
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4195C19560BC; Tue, 16 Jun 2026 13:27:38 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 851373000203; Tue, 16 Jun 2026 13:27:31 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v6 09/17] target/arm/cpu_idregs: generate tables for Arm64
 ID registers and fields
Date: Tue, 16 Jun 2026 15:16:56 +0200
Message-ID: <20260616132625.1732031-10-eric.auger@redhat.com>
In-Reply-To: <20260616132625.1732031-1-eric.auger@redhat.com>
References: <20260616132625.1732031-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Shaju Abraham <shaju.abraham@nutanix.com>

Include cpu-idregs.h.inc multiple times with different definitions for the
X-macros. This will generate tables for all Arm64 ID registers and their
fields. Additionally, initialize the tables with all architecturally defined
values. These tables will be consumed by the property layer in future
patches.

Co-authored-by: Khushit Shah <khushit.shah@nutanix.com>
Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5 -> v6
- restored support of enum values
---
 target/arm/cpu-idregs.c | 96 +++++++++++++++++++++++++++++++++++++++++
 target/arm/meson.build  |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 target/arm/cpu-idregs.c

diff --git a/target/arm/cpu-idregs.c b/target/arm/cpu-idregs.c
new file mode 100644
index 0000000000..c41d0ab0c4
--- /dev/null
+++ b/target/arm/cpu-idregs.c
@@ -0,0 +1,96 @@
+/*
+ *   ARM ID register field table.
+ *
+ *   Builds the per-id-register field descriptor arrays and the global
+ *   arm_idregs[] table.
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "cpu-idregs.h"
+
+/*
+ * Generate an array of architecturely defined values for each field
+ * associated with enum values
+ */
+
+#define IDREG_START(reg)
+#define IDREG_END(reg)
+#define IDREG_FIELD(reg, field, shift, length)
+#define IDREG_FIELD_START(reg, field, shift, length) \
+    static const ArmIdRegArchVal reg##_##field##_arch_vals[] = {
+#define IDREG_FIELD_ARCH_VAL(v) { (v), "" },
+#define IDREG_FIELD_END(reg, field) \
+    };
+
+#include "cpu-idregs.h.inc"
+
+#undef IDREG_START
+#undef IDREG_END
+#undef IDREG_FIELD
+#undef IDREG_FIELD_START
+#undef IDREG_FIELD_END
+#undef IDREG_FIELD_ARCH_VAL
+
+/* generate an array of per-register ArmIdRegField[] descriptors */
+
+#define IDREG_START(reg) \
+    static ARM64SysRegField reg##_fields[] = {
+
+#define IDREG_END(reg) \
+    };
+
+#define IDREG_FIELD_START(reg, field, _shift, _length)  \
+    {                                                                 \
+        .name = #field, \
+        .index = reg##_IDX, \
+        .shift = (_shift),                                            \
+        .length = (_length),                                          \
+        .arch_vals = (ArmIdRegArchVal *)reg##_##field##_arch_vals,    \
+        .arch_vals_count = ARRAY_SIZE(reg##_##field##_arch_vals),     \
+    },
+
+#define IDREG_FIELD(reg, field, _shift, _length) \
+    { \
+        .name = #field, \
+        .index = reg##_IDX, \
+        .shift = (_shift), \
+        .length = (_length), \
+    },
+
+#define IDREG_FIELD_ARCH_VAL(v)
+
+#define IDREG_FIELD_END(reg, field)
+
+#include "cpu-idregs.h.inc"
+
+#undef IDREG_START
+#undef IDREG_END
+#undef IDREG_FIELD
+#undef IDREG_FIELD_START
+#undef IDREG_FIELD_END
+#undef IDREG_FIELD_ARCH_VAL
+
+/* generate an array of top level ID registers */
+
+#define IDREG_END(reg)
+#define IDREG_FIELD(reg, field, shift, length)
+#define IDREG_FIELD_START(reg, field, shift, length)
+#define IDREG_FIELD_ARCH_VAL(v)
+#define IDREG_FIELD_END(reg, field)
+
+#define IDREG_START(reg) \
+    [reg##_IDX] = { \
+        .name = #reg, \
+        .index = reg##_IDX, \
+        .fields = reg##_fields, \
+        .fields_count = ARRAY_SIZE(reg##_fields), \
+    },
+
+ARM64SysReg arm64_id_regs[NUM_ID_IDX] = {
+#include "cpu-idregs.h.inc"
+};
+
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 4412fde065..ed8535192c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -30,6 +30,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
+  'cpu-idregs.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-- 
2.53.0


