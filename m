Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F84CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE6H-0001hU-2r; Mon, 15 Jun 2026 16:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6E-0001SY-CO
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6C-0002fw-Bl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HE0K4FWAFLU/nTUXlylWqdn6JEHOpkgSeYBgtcj3Ews=;
 b=ebAdL0Lb2xJAe4U8KuV9kO4QRaZke2NFX/vCWKHCrzQr402t3lYxfJ5WMtHbA35ABUpDG9
 YbLSvdgAFkrg3Kc5gDtJFIYv9MfritXoRffXlqH9dzlSp4J8MZdb4K8m4y21nEPprIaDm5
 Ox5p0jW6VsIVoNzqAblJoWSGi0+/p6g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-5VT564HwNPStkg-BO2n0UA-1; Mon,
 15 Jun 2026 16:39:56 -0400
X-MC-Unique: 5VT564HwNPStkg-BO2n0UA-1
X-Mimecast-MFC-AGG-ID: 5VT564HwNPStkg-BO2n0UA_1781555994
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D625419560AA; Mon, 15 Jun 2026 20:39:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5CE63008B37; Mon, 15 Jun 2026 20:39:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:51 +0400
Subject: [PATCH v2 25/53] whpx: convert OnOffAuto arch properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-25-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6655;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BzBiTMpuo1MafDbjkgRY9tNBSnfuxdeq+gbfJzPWWY4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPWYmBQeOQsxPaOTWeMCBKW5JdCUPjtvrs1
 9BLIxYWkxGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5S5OEACSLs8P6AOzqCdPFNl+QBOoS0xaEq+I4lxjFxJOr2AR5fqL2/xVGYESSE0iaFxILJ4FByD
 eXjVmCmZ4Q+UKCm8UMILHZ4aJxBKC/ruN7UL/oNjsNmz17SXYBS1s3Xo8vbI6CRth3WaY+b9BnT
 jcGDESCvtqGFPtDjuNlBuACLOkLAWmf4mYkX99BXLMLKcBZuA9td/cSYNiSHuztjJfwvYVf3GYE
 dBBScaPbsR5AlINBpxCsZpPrzMbgJM/8+49GOACKGyscrSSS3F/RlYl+pAqWrbibvEF6dzGs11q
 P+xIo/Ea063uctSe5IuZUo9r5NCvflTeQQUpZgYt+mgAfBoZsY2WF8Amf+t8+g3TPfYEC8ER0gv
 G5l/KewTWL6whh9lwknoDYoLgnIsEa/r+Oe+pOunAkaWERA4b4pIgkESolippQb7psM2e9Es0aS
 OE9QBiW+u81f4o3bmHBSKaTPBAGSyCd6Uk8gJTY9/QsBL90eSb4adt+zYzwsX8wWCV0G3TLUlJq
 c4pqbtPJC3zxsxK6gw8XU7cgTJI3rmKbdmcB853r5WhUuF6rxOL9hjMe7IV/Utm2sZjwTCtwO2A
 vaDMJivAgyBQMzD4+rrTz0u98fnluIkBE/cNxn94++q5ZySwqFk6x9f6zfz1N8w7xqokIij8LJk
 XBUo+CIE7Rrdusg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Convert the ignore-unknown-msr, intercept-msr-gp, and ssd OnOffAuto
properties from manual visitor-based callbacks to
property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/whpx/whpx-all.c | 102 +++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 68 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..08714248b1f 100644
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
@@ -1853,7 +1853,7 @@ void whpx_apply_breakpoints(
     }
 }
 
-bool whpx_arch_supports_guest_debug(void) 
+bool whpx_arch_supports_guest_debug(void)
 {
     return true;
 }
@@ -1938,7 +1938,7 @@ static int whpx_handle_hyperv_guestidle(CPUState *cpu)
     return whpx_handle_halt(cpu);
 }
 
-static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
+static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu)
 {
     WHV_REGISTER_VALUE reg;
     whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
@@ -2042,7 +2042,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
                 .Vector = irq,
             };
             reg_count += 1;
-            /* 
+            /*
              * When the Hyper-V APIC is enabled, to get out of HLT we
              * either have to request an interrupt or manually get it away
              * from HLT.
@@ -2342,7 +2342,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_VALUE reg_values[3] = {0};
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
-            bool is_known_msr = 0; 
+            bool is_known_msr = 0;
             bool raises_gpf = false;
             uint64_t val;
 
@@ -2898,120 +2898,86 @@ void whpx_cpu_instance_init(CPUState *cs)
  * Partition support
  */
 
-static void whpx_set_unknown_msr(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
+static void whpx_set_unknown_msr(Object *obj, int value, Error **errp)
 {
     struct whpx_state *whpx = &whpx_global;
-    OnOffAuto mode;
-
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
 
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
-
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
 
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
-
-    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
-        return;
-    }
 
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
2.54.0


