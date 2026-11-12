Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA92606A32D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PUUpuo12
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUth-0005qJ-JV; Thu, 12 Nov 2026 08:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtR-0005h4-36
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtP-0000pw-Al
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNhVyDQV08ndeLXfuw+LM4WtU1I1yz5fWjVBYtZZV7M=;
 b=PUUpuo12m6kU6mDFVf6CJxPxGiolUatdQNW6QL956rDLWHyX03ZqUkKuqxZuh8is2hBCL1
 R2TLD37BjYGQIa8g/B6koaC9lQpaO8O+FbnYmvFLcqm8WimPo9O9abYJeopx/7UCuS3TQE
 45W6e+PbXj8UUF1stReZ7OsLgKaJcjM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-sfdRJEF3NoC3UpaQipnpEg-1; Thu,
 12 Nov 2026 08:31:02 -0500
X-MC-Unique: sfdRJEF3NoC3UpaQipnpEg-1
X-Mimecast-MFC-AGG-ID: sfdRJEF3NoC3UpaQipnpEg_1794490261
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74C8F1800A79; Thu, 12 Nov 2026 13:31:01 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 042911956087; Thu, 12 Nov 2026 13:30:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/48] target-info: add target_mask_selected()
Date: Thu, 12 Nov 2026 13:30:08 +0000
Message-ID: <20261112133054.1977618-3-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yonggang Luo <luoyonggang@gmail.com>

Return the QEMU_ARCH_* mask of the selected target. System mode
returns QEMU_ARCH_ALL until a target is selected. User mode returns
that target's bit. Tools return 0.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-init.h | 15 ++++++++++-----
 include/qemu/target-info.h      |  9 +++++++++
 stubs/meson.build               |  1 +
 stubs/target-mask-selected.c    | 13 +++++++++++++
 target-info-def.c               |  3 +++
 target-info-qom.c               | 10 ++++++++++
 6 files changed, 46 insertions(+), 5 deletions(-)
 create mode 100644 stubs/target-mask-selected.c

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index b7024c9faef..84929868328 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -24,12 +24,17 @@ module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
 
 /*
  * User mode does not support multiple targets in the same binary, so just
- * define target_info().
+ * define target_info() and target_mask_selected(). The target is always
+ * selected.
  */
-#define target_info_init(ti_var)        \
-const TargetInfo *target_info(void)     \
-{                                       \
-    return &ti_var;                     \
+#define target_info_init(ti_var)                           \
+const TargetInfo *target_info(void)                        \
+{                                                          \
+    return &ti_var;                                        \
+}                                                          \
+uint64_t target_mask_selected(void)                        \
+{                                                          \
+    return QEMU_ARCH_BIT((ti_var).target_arch);            \
 }
 
 #else /* CONFIG_USER_ONLY */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 2cd4cc5671b..5673d10ebae 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -134,4 +134,13 @@ bool target_base_riscv(void);
  */
 bool target_riscv64(void);
 
+/**
+ * target_mask_selected:
+ *
+ * Returns the QEMU_ARCH_* mask of the selected target. System mode
+ * returns QEMU_ARCH_ALL until a target is selected. User mode returns
+ * that target's bit. Tools return 0.
+ */
+uint64_t target_mask_selected(void);
+
 #endif
diff --git a/stubs/meson.build b/stubs/meson.build
index 744fb759a2f..49cede8582f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -12,6 +12,7 @@ stub_ss.add(files('monitor-hmp.c'))
 stub_ss.add(files('qapi-event-emit.c'))
 stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('trace-control.c'))
+stub_ss.add(files('target-mask-selected.c'))
 
 if have_block
   stub_ss.add(files('bdrv-next-monitor-owned.c'))
diff --git a/stubs/target-mask-selected.c b/stubs/target-mask-selected.c
new file mode 100644
index 00000000000..510a515851c
--- /dev/null
+++ b/stubs/target-mask-selected.c
@@ -0,0 +1,13 @@
+/*
+ * Tools have no selected target.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+
+uint64_t target_mask_selected(void)
+{
+    return 0;
+}
diff --git a/target-info-def.c b/target-info-def.c
index bcf9cfe1e43..a9920196266 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -9,6 +9,9 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
+#ifdef CONFIG_USER_ONLY
+#include "qemu/base-arch-defs.h"
+#endif
 #include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
diff --git a/target-info-qom.c b/target-info-qom.c
index aeeedb7e818..fb4c9835e5a 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,6 +9,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "qemu/base-arch-defs.h"
+#include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
@@ -40,6 +42,14 @@ const TargetInfo *target_info(void)
     return target_info_ptr;
 }
 
+uint64_t target_mask_selected(void)
+{
+    if (!target_info_ptr) {
+        return QEMU_ARCH_ALL;
+    }
+    return QEMU_ARCH_BIT(target_info_ptr->target_arch);
+}
+
 void target_info_qom_set_target(void)
 {
     g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-- 
2.56.1


