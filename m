Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCEAEC145E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQuv-0001jp-Vj; Tue, 03 Mar 2026 09:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQuu-0001gA-70
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQus-0002Qm-9z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772548805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNWsxK6/NvYySeLU0trFMBVUsLLcD9gWIFbk5GtfTio=;
 b=hHoLabAe/LyouQ23yq6OtieqywE49lUKbf7/BzmWc/HGeXDFo8mJQcsL9FAhWYuwYyagNR
 lomn5TA+sF6XY0xKgdh7c4PQqBAw5i1OuRi27Gk2OEYpRALReQbAU9YQa4X324ZGFrer1A
 hZWTfSnnWDCU6D+qxVJPHqwvxLPrWNU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-YwX0zgVMNr2ntvB1o-rAqw-1; Tue,
 03 Mar 2026 09:40:01 -0500
X-MC-Unique: YwX0zgVMNr2ntvB1o-rAqw-1
X-Mimecast-MFC-AGG-ID: YwX0zgVMNr2ntvB1o-rAqw_1772548800
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E90E71800259; Tue,  3 Mar 2026 14:39:59 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC2AA30001BF; Tue,  3 Mar 2026 14:39:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 7/7] target/arm/machine: Fix detection of unknown incoming
 cpregs
Date: Tue,  3 Mar 2026 15:36:39 +0100
Message-ID: <20260303143928.1747116-8-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-1-eric.auger@redhat.com>
References: <20260303143928.1747116-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently the check of cpreg index matches fail to detect
a situation where the length of both arrays is same but
- destination has an extra register not found in the incoming stream (idx1)
- source has an extra register not found in the destination (idx2)
  where idx1 < = idx2
Normally this should fail but it does not.

Fix the logic to scan all indexes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: 721fae12536 ("target-arm: Convert TCG to using (index,value) list for cp migration")
---
 target/arm/machine.c | 61 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 13f3955be67..2108e7916bb 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1054,6 +1054,35 @@ static gchar *print_register_name(uint64_t kvm_regidx)
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
+    warn_report("%s: %s "
+                "expected by the destination but not in the incoming stream: "
+                 "skip it", __func__, name);
+}
+
+/*
+ * Handle the situation where @kvmidx is in the incoming stream
+ * but not on destination. This currently fails the migration but
+ * we plan to accomodate some exceptions, hence the boolean returned value.
+ */
+static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
+{
+    g_autofree gchar *name = print_register_name(kvmidx);
+    bool fail = true;
+
+    error_report("%s: %s in the incoming stream but unknown on the "
+                 "destination: fail migration", __func__, name);
+
+    return fail;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
@@ -1093,21 +1122,12 @@ static int cpu_post_load(void *opaque, int version_id)
     for (i = 0, v = 0; i < cpu->cpreg_array_len
              && v < cpu->cpreg_vmstate_array_len;) {
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
-            g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
-
-            warn_report("%s: %s "
-                        "expected by the destination but not in the incoming stream: "
-                        "skip it", __func__, name);
-            i++;
+            handle_cpreg_missing_in_incoming_stream(cpu, cpu->cpreg_indexes[i++]);
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
-            g_autofree gchar *name = print_register_name(cpu->cpreg_vmstate_indexes[v]);
-
-            error_report("%s: %s in the incoming stream but unknown on the destination: "
-                         "fail migration", __func__, name);
-            v++;
-            fail = true;
+            fail = handle_cpreg_only_in_incoming_stream(cpu,
+                                                        cpu->cpreg_vmstate_indexes[v++]);
             continue;
         }
         /* matching register, copy the value over */
@@ -1115,6 +1135,23 @@ static int cpu_post_load(void *opaque, int version_id)
         i++;
         v++;
     }
+
+    /*
+     * if we have reached the end of the incoming array but there are
+     * still regs in cpreg, continue parsing the regs which are missing
+     * in the input stream
+     */
+    for ( ; i < cpu->cpreg_array_len; i++) {
+        handle_cpreg_missing_in_incoming_stream(cpu, cpu->cpreg_indexes[i]);
+    }
+    /*
+     * if we have reached the end of the cpreg array but there are
+     * still regs in the input stream, continue parsing the vmstate array
+     */
+    for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
+        fail = handle_cpreg_only_in_incoming_stream(cpu,
+                                                    cpu->cpreg_vmstate_indexes[v]);
+    }
     if (fail) {
         return -1;
     }
-- 
2.53.0


