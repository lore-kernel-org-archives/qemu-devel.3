Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5220FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLp-0008Et-1O; Wed, 22 Apr 2026 17:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLf-00086X-D0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:08 -0400
Received: from p-east2-cluster1-host12-snip4-1.eps.apple.com ([57.103.76.54]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLb-0007J4-Uk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:07 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 F3C3B1800232; Wed, 22 Apr 2026 21:43:01 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloKXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894183; x=1779486183;
 bh=a4bAw1HDBgRU0T/rl/EmfzkgG6FT8af3C1AcP0W3dJM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZS+if+h0jlXQhDcZj7ZqjSsDX1R/rjyvnoyahsxVqQg/0b44kk9Upzy3rCGONx4zFfCbLc+ivuyWRkAQuYiTlBE9jgJCFBqgibWqcGaDFC3C0grhKDjE3YsUNAF8lo3EJMPQXl2QXqm+dWxfJrYbiNx86dyTJ3YmK+dsTwMEDLF0AVfh/PMT4FYLbG+Pmv5EGZYdCZo+AJdV711zkMWpAHoMtfXV1xgnJSvrw3ruEQXYaI3435O4P34D/VXYIfmDKgK0gV8H88tqc4+LWesdkFDY80GjSH2bp6320V4uxMWWP1+CiR+UkGUVANbciBXYAIyUAdCZNR/La0/LGDW0jw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 D1AE91800950; Wed, 22 Apr 2026 21:42:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 17/37] whpx: i386: unknown MSR configurability
Date: Wed, 22 Apr 2026 23:42:05 +0200
Message-ID: <20260422214225.2242-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=JK02csKb c=1 sm=1 tr=0 ts=69e940e7
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XlFqsGflGfdv-AKn0wkA:9
X-Proofpoint-ORIG-GUID: qjlvJY7nUid2hSQe8IWh0Ic60j_pSCgl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX+dvJ6D8g5jNF
 ndtfi03LhcR8b/VsbQ2l8AWcxpQkiSIErswDAjjcG4alGjUREkvDj4brrAaCTHC+SXc8pv9Mb3L
 hWPT/G9DBpeynoww/gJYt2eSU12GuFYaPuFcFfwf+rInNxtxJpQ5DMPK6QrkwKlvTTLskVx0C4V
 wOwwlHGn+4zmmWUUDPLLm788KQtF2sO0FzfEo70n2hIzBvt8GgBnLOpt3ir2nvlc2eWiRe0K2xM
 mcKB9oVP7kQ2vxI+uwtR0AlpYYTWjxm8b3Bat+Or4iE6SidItn//fqF7hks7ajXB885QZFeSphd
 uQ8lgwM5/wVLI/hrjmZajQh/gTIZDqmY/UkZSBoLJMm1aOKQveGQDu24PF5G2o=
X-Proofpoint-GUID: qjlvJY7nUid2hSQe8IWh0Ic60j_pSCgl
Received-SPF: pass client-ip=57.103.76.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Add an option to inject back a GPF for unknown MSRs.

Keep it on by default for now as Linux expects accesses to some
AMD-specific MSRs to always succeed when on an AMD host.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       |  3 +++
 include/system/whpx-all.h      |  1 +
 include/system/whpx-internal.h |  1 +
 target/arm/whpx/whpx-all.c     |  4 +++
 target/i386/whpx/whpx-all.c    | 45 ++++++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 59be996aef..497c03138e 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -538,6 +538,8 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "hyperv",
         "Configure Hyper-V enlightenments");
+
+    whpx_arch_accel_class_init(oc);
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -552,6 +554,7 @@ static void whpx_accel_instance_init(Object *obj)
     whpx->hyperv_enlightenments_required = false;
     /* Value determined at whpx_accel_init */
     whpx->hyperv_enlightenments_enabled = false;
+    whpx->ignore_unknown_msr = true;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 2cbea71b14..4022571fff 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -20,6 +20,7 @@ void whpx_translate_cpu_breakpoints(
     CPUState *cpu,
     int cpu_breakpoint_count);
 void whpx_arch_destroy_vcpu(CPUState *cpu);
+void whpx_arch_accel_class_init(ObjectClass *oc);
 
 /* called by whpx-accel-ops */
 bool whpx_arch_supports_guest_debug(void);
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index cf782cf5f8..86639627b3 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -47,6 +47,7 @@ struct whpx_state {
     bool hyperv_enlightenments_required;
     bool hyperv_enlightenments_enabled;
 
+    bool ignore_unknown_msr;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 4019a513aa..94304a4230 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -823,6 +823,10 @@ void whpx_cpu_instance_init(CPUState *cs)
 {
 }
 
+void whpx_arch_accel_class_init(ObjectClass *oc)
+{
+}
+
 int whpx_accel_init(AccelState *as, MachineState *ms)
 {
     struct whpx_state *whpx;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3426811c48..7f0ad6a24f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2133,6 +2133,10 @@ int whpx_vcpu_run(CPUState *cpu)
                     vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
             }
 
+            if (!is_known_msr && !whpx->ignore_unknown_msr) {
+                x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+            }
+
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
@@ -2532,6 +2536,47 @@ void whpx_cpu_instance_init(CPUState *cs)
  * Partition support
  */
 
+static void whpx_set_unknown_msr(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->ignore_unknown_msr = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->ignore_unknown_msr = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->ignore_unknown_msr = true;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
+void whpx_arch_accel_class_init(ObjectClass *oc)
+{
+    object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
+        NULL, whpx_set_unknown_msr,
+        NULL, NULL);
+    object_class_property_set_description(oc, "ignore-unknown-msr",
+        "Configure unknown MSR behavior");
+}
+
 int whpx_accel_init(AccelState *as, MachineState *ms)
 {
     struct whpx_state *whpx;
-- 
2.50.1 (Apple Git-155)


