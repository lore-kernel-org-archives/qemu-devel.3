Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FC1E9B35B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0eP-00035t-0m; Mon, 02 Mar 2026 05:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0e9-0002zp-Tl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0e8-0001rf-As
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772447823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKLoRoIQCgZ0YUK0eGLnjmDfdwRAbjP+XkZjC4Q6bw8=;
 b=RgGThNvG/BzmkDEdCmJBRWil4VfqgqNJEiAjcTFiGPIu6PwEZfHFLUzOQY2v+BXPgntmGh
 D6uD+ssMsYtPvDtvApQaIhk+8xzbcZFkV4ZE5kE0VTTEioy1rB9u7d/YDOdpK4NyqGg/ZT
 2/JtNmdV177036uvPpx5s5pLDY9SkF4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-XlscyT2hMmOD5CDO-hlMBQ-1; Mon,
 02 Mar 2026 05:36:59 -0500
X-MC-Unique: XlscyT2hMmOD5CDO-hlMBQ-1
X-Mimecast-MFC-AGG-ID: XlscyT2hMmOD5CDO-hlMBQ_1772447818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21CBE19560A5; Mon,  2 Mar 2026 10:36:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 144181800666; Mon,  2 Mar 2026 10:36:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v7 3/7] target/arm/machine: Take account cpreg mig tolerances
 in case of mismatch
Date: Mon,  2 Mar 2026 11:35:25 +0100
Message-ID: <20260302103640.1362564-4-eric.auger@redhat.com>
In-Reply-To: <20260302103640.1362564-1-eric.auger@redhat.com>
References: <20260302103640.1362564-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_PASS=-0.001,
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

If there is a mismatch between the cpreg indexes found on both ends,
check whether a tolerance was registered for the given kvmidx. If any,
silence warning/errors.

Create dedicated helper functions that print the name of the culprit reg
and analyze whether a tolerance is set. According set the level of traces
and analyze whether the migration must eventually fail.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/machine.c    | 67 +++++++++++++++++++++++++++--------------
 target/arm/trace-events |  2 ++
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 9297a8f5b41..abc66448cef 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1046,6 +1046,45 @@ static gchar *print_register_name(uint64_t kvm_regidx)
     }
 }
 
+/*
+ * Handle the situation where @kvmidx is on destination but not
+ * in the incoming stream. This never fails the migration.
+ */
+static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
+{
+    g_autofree gchar *name = print_register_name(kvmidx);
+
+    if (!arm_cpu_cpreg_has_mig_tolerance(cpu, kvmidx,
+                                         0, 0, ToleranceNotOnBothEnds)) {
+        warn_report("%s: %s "
+                    "expected by the destination but not in the incoming stream, "
+                     "skip it", __func__, name);
+    } else {
+        trace_tolerate_cpreg_missing_in_incoming_stream(name);
+    }
+}
+
+/*
+ * Handle the situation where @kvmidx is in the incoming
+ * stream but not on destination. This fails the migration if
+ * no cpreg mig tolerance is set for this @kvmidx
+ */
+static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
+{
+    g_autofree gchar *name = print_register_name(kvmidx);
+    bool fail = false;
+
+    if (!arm_cpu_cpreg_has_mig_tolerance(cpu, kvmidx,
+                                        0, 0, ToleranceNotOnBothEnds)) {
+        error_report("%s: %s in the incoming stream but unknown on the "
+                     "destination, fail migration", __func__, name);
+        fail = true;
+    } else {
+        trace_tolerate_cpreg_only_in_incoming_stream(name);
+    }
+    return fail;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
@@ -1085,21 +1124,12 @@ static int cpu_post_load(void *opaque, int version_id)
     for (i = 0, v = 0; i < cpu->cpreg_array_len
              && v < cpu->cpreg_vmstate_array_len;) {
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
-            g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
-
-            warn_report("%s: %s "
-                        "expected by the destination but not in the incoming stream, "
-                        "skip it", __func__, name);
-            i++;
+            handle_cpreg_missing_in_incoming_stream(cpu, cpu->cpreg_indexes[i++]);
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
-            g_autofree gchar *name = print_register_name(cpu->cpreg_vmstate_indexes[v]);
-
-            error_report("%s: %s in the incoming stream but unknown on the destination, "
-                         "fail migration", __func__, name);
-            v++;
-            fail = true;
+            fail = handle_cpreg_only_in_incoming_stream(cpu,
+                                                        cpu->cpreg_vmstate_indexes[v++]);
             continue;
         }
         /* matching register, copy the value over */
@@ -1113,22 +1143,15 @@ static int cpu_post_load(void *opaque, int version_id)
      * in the input stream
      */
     for ( ; i < cpu->cpreg_array_len; i++) {
-        g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
-
-        warn_report("%s: %s "
-                    "expected by the destination but not in the incoming stream, "
-                    "skip it", __func__, name);
+        handle_cpreg_missing_in_incoming_stream(cpu, cpu->cpreg_indexes[i]);
     }
     /*
      * if we have reached the end of the cpreg array but there are
      * still regs in the input stream, continue parsing the vmstate array
      */
     for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
-        g_autofree gchar *name = print_register_name(cpu->cpreg_vmstate_indexes[v]);
-
-        error_report("%s: %s in the incoming stream but unknown on the destination, "
-                     "fail migration", __func__, name);
-        fail = true;
+        fail = handle_cpreg_only_in_incoming_stream(cpu,
+                                                    cpu->cpreg_vmstate_indexes[v]);
     }
     if (fail) {
         return -1;
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 2de0406f784..dceb3c63f77 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -29,3 +29,5 @@ arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
 
 # machine.c
 cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
+tolerate_cpreg_missing_in_incoming_stream(char *name) "cpreg %s is missing in incoming stream but this is explicitly tolerated"
+tolerate_cpreg_only_in_incoming_stream(char *name) "cpreg %s is in incoming stream but not on destination but this is explicitly tolerated"
-- 
2.53.0


