Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A944AC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHqr-0004PI-GF; Tue, 18 Aug 2026 07:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHqq-0004P7-OW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHqp-0006IQ-3e
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5rVYWY9iCmv8W08CTUV/9fUk2iuJasytXKRmh76tf4=;
 b=blQ38+0Y+v7fLf8Nog+17EqX/Ca9hftXt7LeyBIXEnS30ubkp6Cxpj6A45yv+sZzADCYv8
 n8VwXV0vYH8fjPejQ0xMClYfWtmoioxnP2WuQnhwaHcLs10q0Bh01aIlUfdYU84ll0K49n
 VDwYrpxfCSAo4u9vbm0YHyUZzuSIUdA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-3t_QcM2VOdSoloUN9S170g-1; Tue,
 18 Aug 2026 07:19:17 -0400
X-MC-Unique: 3t_QcM2VOdSoloUN9S170g-1
X-Mimecast-MFC-AGG-ID: 3t_QcM2VOdSoloUN9S170g_1787051956
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC8DF18011FE; Tue, 18 Aug 2026 11:19:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E5221956044; Tue, 18 Aug 2026 11:19:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:53 +0400
Subject: [PATCH v3 26/74] whpx: convert OnOffAuto arch properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-26-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6648;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FZYNtwQM6zNrQ3eLAAobvVrCX2NhQNihp1W+SoVn5H8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD25ZV7Or6DBPGZP2BCcVzweRBrRKcWxlo+Zp
 UopNhAxRteJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5RCOD/kBmHPzCCUG580wNmuBobLl+gw340ga+nSGsY+tBa45Dk6B7Eoe3rA+XbyNZ3g8XAE45dw
 Vfobqh1zpgDLClybPr2FbQjkffoU0jct2DHbOYRgv2sfpXE3OgfTeIJI+9Gpicjm21h0ChUjFut
 1X48+Y8+cOweTlK4rsYeaB3YLjJ+6nYgpDwgUCUmwjuCDa3OR+hc5GywlXYlyHqXpx/Ryzprm/s
 rEA6vmSFdxZafLk/NJ577BArr9uQiEfjO+KDwlRiWMvuXuqo1uW+S/1ZDlhkMJ3PHtvelahHpkf
 mdODvzubDxAqhpBtvQG3VnUuhlBsnQYUtrFYC0zb1mJHX5MK4NLxmwyigHeUjcsuguZk/+4XXs5
 s9z2iE4rABoMspf+yXsnq87lr3YqQx+jGsHEXyTrlKp4jIEqhnJV52PNKVdQgGx8gkUoYu0ug77
 a3+waRC1sl5DL95yZkb8HFmG6EJIbwqtF5fGw5TxH/SGXZC7WW2k7rH+lHKJhvOeixMcsocAfp6
 ULQ+L2Ev03aaJKOWqoAw0EB1mV+4U/sbGNEQVv9oxyF2/Yi9kNHxx/qkMF8uN5yoTdP963cPI2O
 kaEUc3th2lor5N4rDRWPf4zA3GBx1okM+AjWVmoSCKoCT9Lu5xbY8GkpTPuI5YbFZ3KP/xM3R2L
 1h943h97HXFsdPA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/whpx/whpx-all.c | 101 +++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 67 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d5428219a..bfaa7ace7f7d 100644
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
@@ -1853,6 +1853,7 @@ void whpx_apply_breakpoints(
     }
 }
 
+
 void whpx_arch_destroy_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -1933,7 +1934,7 @@ static int whpx_handle_hyperv_guestidle(CPUState *cpu)
     return whpx_handle_halt(cpu);
 }
 
-static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
+static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu)
 {
     WHV_REGISTER_VALUE reg;
     whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
@@ -2037,7 +2038,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
                 .Vector = irq,
             };
             reg_count += 1;
-            /* 
+            /*
              * When the Hyper-V APIC is enabled, to get out of HLT we
              * either have to request an interrupt or manually get it away
              * from HLT.
@@ -2337,7 +2338,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_VALUE reg_values[3] = {0};
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
-            bool is_known_msr = 0; 
+            bool is_known_msr = 0;
             bool raises_gpf = false;
             uint64_t val;
 
@@ -2893,120 +2894,86 @@ void whpx_cpu_instance_init(CPUState *cs)
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
2.55.0.543.g5ebe2ebe4ea8


