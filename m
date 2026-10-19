Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D138CCF2E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoDf-0002P5-LY; Mon, 19 Oct 2026 10:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDM-0002EU-IM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDI-0005Zl-4s
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GOtG6AD+QWyjb9ovmdvkGuKXzqSO9qFcWGVmfZzpss=;
 b=YEZLNanoCTXdPogsFmDksjrzRyCF3MI8q3/NqEigoE4VFFkAJjcnCWwDWU4LGlSPZk9K4E
 CJnsBehhjE7cETW8D5DVRi9TV/l2Q/X/8S5lxiX1+dhf9qMgDLrKf21UqCJPleT/G0FBwV
 y4cQoApKt4Mbhexin8j8+6y/qpSlALQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-aEOQdQXXPtSMkiiWE2MJJw-1; Mon,
 19 Oct 2026 14:19:39 +0000
X-MC-Unique: aEOQdQXXPtSMkiiWE2MJJw-1
X-Mimecast-MFC-AGG-ID: aEOQdQXXPtSMkiiWE2MJJw_1792419578
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55E101955E82; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE4291955E7D; Mon, 19 Oct 2026 14:19:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01E3421E68A2; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 30/65] whpx: convert OnOffAuto arch properties to
 QAPI-aware registration
Date: Mon, 19 Oct 2026 16:18:54 +0200
Message-ID: <20261019141929.1594337-31-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert the ignore-unknown-msr, intercept-msr-gp, and ssd OnOffAuto
properties from manual visitor-based callbacks to
property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/i386/whpx/whpx-all.c | 101 ++++++++++++------------------------
 1 file changed, 34 insertions(+), 67 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 113f79afb9..64fa389a2f 100644
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
 
@@ -2911,120 +2912,86 @@ void whpx_cpu_instance_init(CPUState *cs)
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
-    object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
-        NULL, whpx_set_unknown_msr,
-        NULL, NULL);
-    object_class_property_set_description(oc, "ignore-unknown-msr",
-        "Configure unknown MSR behavior");
-    object_class_property_add(oc, "intercept-msr-gp", "OnOffAuto",
-        NULL, whpx_set_intercept_msr_gp,
-        NULL, NULL);
-    object_class_property_set_description(oc, "intercept-msr-gp",
-        "Intercept #GP to log erroring MSR accesses.");
-    object_class_property_add(oc, "ssd", "OnOffAuto",
-        NULL, whpx_set_ssd,
-        NULL, NULL);
-    object_class_property_set_description(oc, "ssd",
-        "Separate security domain");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "ignore-unknown-msr",
+        .description = "Configure unknown MSR behavior",
+        .qapi_type = &OnOffAuto_type_info,
+        .set = whpx_set_unknown_msr,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "intercept-msr-gp",
+        .description = "Intercept #GP to log erroring MSR accesses.",
+        .qapi_type = &OnOffAuto_type_info,
+        .set = whpx_set_intercept_msr_gp,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "ssd",
+        .description = "Separate security domain",
+        .qapi_type = &OnOffAuto_type_info,
+        .set = whpx_set_ssd,
+    ));
 }
 
 int whpx_accel_init(AccelState *as, MachineState *ms)
-- 
2.55.0


