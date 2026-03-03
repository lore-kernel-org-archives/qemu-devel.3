Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388B1EC145E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQun-0001cj-7A; Tue, 03 Mar 2026 09:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQul-0001b0-Iw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQuj-0002Cw-UZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772548797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqEFRcehEOqfJB6L6KH6l941FvMcz+lCVI77QQ4Ra1c=;
 b=f2nqUblZT10kTX1g9ErSJ3eP6yepe1BojcqfgDUpotz6/uxytdYIjtXwpwAguYCqJDfQar
 aBo3JcrThe5DZ1D0DYHd/5Fb1sxbvcX2tSQdWy9Yl6q8C0bQsoxh23hXicoU2OU0bWzW2U
 EW3Qrlj9YxH4iXW6mOySRe+a7KB3Y9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-hQa4N-Z0PDyxOlacah-3qw-1; Tue,
 03 Mar 2026 09:39:54 -0500
X-MC-Unique: hQa4N-Z0PDyxOlacah-3qw-1
X-Mimecast-MFC-AGG-ID: hQa4N-Z0PDyxOlacah-3qw_1772548792
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C71661800266; Tue,  3 Mar 2026 14:39:52 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C3CB30001B9; Tue,  3 Mar 2026 14:39:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 5/7] target/arm/machine: Trace cpreg names which do not
 match on migration
Date: Tue,  3 Mar 2026 15:36:37 +0100
Message-ID: <20260303143928.1747116-6-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-1-eric.auger@redhat.com>
References: <20260303143928.1747116-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Whenever there is a mismatch between cpreg indexes in the incoming
stream and cpregs exposed by the destination output the name of
the register. We use a print_register_name() wrapper helper. At the
moment we are only able to do a nice decoding of the index for
KVM regs.

Without this patch, the error would be:
qemu-system-aarch64: load of migration failed: Operation not permitted:
error while loading state for instance 0x0 of device 'cpu': post load
hook failed for: cpu, version_id: 22, minimum_version: 22, ret: -1
which is not helpful for the end user to understand the actual
issue.

This patch adds the actual information about the probme:
qemu-system-aarch64: cpu_post_load: system register
op0:3 op1:0 crn:2 crm:0 op2:3 in the incoming stream but
unknown on the destination, fail migration

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v1 -> v2:
- replaced ',' by ':' in the traces
- added system register in print_register_name when kvm is not enabled
---
 target/arm/machine.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index aa617dd64db..7dd649e8f64 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "cpregs.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
@@ -1044,6 +1045,15 @@ static int cpu_pre_load(void *opaque)
     return 0;
 }
 
+static gchar *print_register_name(uint64_t kvm_regidx)
+{
+    if (kvm_enabled()) {
+        return kvm_print_register_name(kvm_regidx);
+    } else {
+        return g_strdup_printf("system register 0x%x", kvm_to_cpreg_id(kvm_regidx));
+    }
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
@@ -1082,11 +1092,18 @@ static int cpu_post_load(void *opaque, int version_id)
     for (i = 0, v = 0; i < cpu->cpreg_array_len
              && v < cpu->cpreg_vmstate_array_len; i++) {
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
-            /* register in our list but not incoming : skip it */
+            g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
+
+            warn_report("%s: %s "
+                        "expected by the destination but not in the incoming stream: "
+                        "skip it", __func__, name);
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
-            /* register in their list but not ours: fail migration */
+            g_autofree gchar *name = print_register_name(cpu->cpreg_vmstate_indexes[v]);
+
+            error_report("%s: %s in the incoming stream but unknown on the destination: "
+                         "fail migration", __func__, name);
             return -1;
         }
         /* matching register, copy the value over */
-- 
2.53.0


