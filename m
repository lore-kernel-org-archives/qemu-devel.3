Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11386080A6E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y8QXnSGL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDk-0003V9-Nj; Mon, 02 Nov 2026 09:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDH-0003G1-Pe
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD9-0008UD-7v
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXA7kp9FKVpEc3owtkP7EX+ANDz9pYk4uyTaAYljun0=;
 b=Y8QXnSGLmbWD6pDEMS33FWjLNK7yISPMYVNWJS8OEGRlJkdmP/d5wJn5DcWCn85gsrSErZ
 MHy68Gr801I+wglx4N4PZTha+LQuZg8R7wyLdbAFtm4fWGy3/UQFu3L/dYKzD7mTsge/ir
 FKVWzzh3pgmF1NrFGcab3w9fGRzKnhE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-fTzuLUfMNoS8buK6ZQbxCA-1; Mon,
 02 Nov 2026 09:40:31 -0500
X-MC-Unique: fTzuLUfMNoS8buK6ZQbxCA-1
X-Mimecast-MFC-AGG-ID: fTzuLUfMNoS8buK6ZQbxCA_1793630430
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 449321805A0F; Mon,  2 Nov 2026 14:40:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B92FB1803A44; Mon,  2 Nov 2026 14:40:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B010121E683B; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 46/74] whpx: convert OnOffAuto arch properties to QAPI-aware
 registration
Date: Mon,  2 Nov 2026 15:39:50 +0100
Message-ID: <20261102144018.3212223-47-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert the ignore-unknown-msr, intercept-msr-gp, and ssd OnOffAuto
properties from manual visitor-based callbacks to
object_class_property_add_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-30-armbru@redhat.com>
---
 target/i386/whpx/whpx-all.c | 84 ++++++++++---------------------------
 1 file changed, 23 insertions(+), 61 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 778da68bf4..c459138c7e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -30,7 +30,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-common.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "migration/blocker.h"
 #include "host-cpu.h"
 #include "accel/accel-cpu-target.h"
@@ -1875,6 +1875,7 @@ void whpx_apply_breakpoints(
     }
 }
 
+
 void whpx_arch_destroy_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -1955,7 +1956,7 @@ static int whpx_handle_hyperv_guestidle(CPUState *cpu)
     return whpx_handle_halt(cpu);
 }
 
-static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
+static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu)
 {
     WHV_REGISTER_VALUE reg;
     whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
@@ -2059,7 +2060,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
                 .Vector = irq,
             };
             reg_count += 1;
-            /* 
+            /*
              * When the Hyper-V APIC is enabled, to get out of HLT we
              * either have to request an interrupt or manually get it away
              * from HLT.
@@ -2359,7 +2360,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_VALUE reg_values[3] = {0};
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
-            bool is_known_msr = 0; 
+            bool is_known_msr = 0;
             bool raises_gpf = false;
             uint64_t val;
 
@@ -2911,118 +2912,79 @@ void whpx_cpu_instance_init(CPUState *cs)
  * Partition support
  */
 
-static void whpx_set_unknown_msr(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
+static void whpx_set_unknown_msr(Object *obj, int value, Error **errp)
 {
     struct whpx_state *whpx = &whpx_global;
-    OnOffAuto mode;
 
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
-
-    switch (mode) {
+    switch (value) {
     case ON_OFF_AUTO_ON:
         whpx->ignore_unknown_msr = true;
         break;
-
     case ON_OFF_AUTO_OFF:
         whpx->ignore_unknown_msr = false;
         break;
-
     case ON_OFF_AUTO_AUTO:
         whpx->ignore_unknown_msr = true;
         break;
     default:
-        /*
-         * The value was checked in visit_type_OnOffAuto() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
-static void whpx_set_intercept_msr_gp(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
+static void whpx_set_intercept_msr_gp(Object *obj, int value, Error **errp)
 {
     struct whpx_state *whpx = &whpx_global;
-    OnOffAuto mode;
 
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
-
-    switch (mode) {
+    switch (value) {
     case ON_OFF_AUTO_ON:
         whpx->intercept_msr_gp = true;
         break;
-
     case ON_OFF_AUTO_OFF:
         whpx->intercept_msr_gp = false;
         break;
-
     case ON_OFF_AUTO_AUTO:
         whpx->intercept_msr_gp = false;
         break;
     default:
-        /*
-         * The value was checked in visit_type_OnOffAuto() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
-static void whpx_set_ssd(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
+static void whpx_set_ssd(Object *obj, int value, Error **errp)
 {
     struct whpx_state *whpx = &whpx_global;
-    OnOffAuto mode;
 
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
-
-    switch (mode) {
+    switch (value) {
     case ON_OFF_AUTO_ON:
         whpx->separate_security_domain = true;
         break;
-
     case ON_OFF_AUTO_OFF:
         whpx->separate_security_domain = false;
         break;
-
     case ON_OFF_AUTO_AUTO:
         whpx->separate_security_domain = true;
         break;
     default:
-        /*
-         * The value was checked in visit_type_OnOffAuto() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
 
 void whpx_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto", NULL,
-                              NULL, whpx_set_unknown_msr,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, "ignore-unknown-msr", "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   NULL, whpx_set_unknown_msr);
     object_class_property_set_description(oc, "ignore-unknown-msr",
         "Configure unknown MSR behavior");
-    object_class_property_add(oc, "intercept-msr-gp", "OnOffAuto", NULL,
-                              NULL, whpx_set_intercept_msr_gp,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, "intercept-msr-gp", "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   NULL, whpx_set_intercept_msr_gp);
     object_class_property_set_description(oc, "intercept-msr-gp",
         "Intercept #GP to log erroring MSR accesses.");
-    object_class_property_add(oc, "ssd", "OnOffAuto", NULL,
-                              NULL, whpx_set_ssd,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, "ssd", "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   NULL, whpx_set_ssd);
     object_class_property_set_description(oc, "ssd",
         "Separate security domain");
 }
-- 
2.55.0


