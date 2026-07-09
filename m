Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C2FC44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmDC-0004WD-FC; Thu, 09 Jul 2026 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmDA-0004VL-Rh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1whmD8-0001Xm-70
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783593749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWrKNQIrI5+gpJz2mocl5DDthMqXLjcl18XUsgDp394=;
 b=a09GCAumS3yX8iO4aa8LO7UZEoeaz62MMoUoTFpV+DNOk0n7N2yTPmV1r3qHP1DWjuzL6i
 tx0VcYutzjNeO3se7f2Q30vL1c1I8p6pQRXMT4vUbjXyau1e2SqdrqVtdxbNk+0r727wJK
 eIob6psg10bg7WMWh8FXslX/HI1ZH8k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-m4AfKSxaNA6-yK7cG5yA5g-1; Thu,
 09 Jul 2026 06:42:28 -0400
X-MC-Unique: m4AfKSxaNA6-yK7cG5yA5g-1
X-Mimecast-MFC-AGG-ID: m4AfKSxaNA6-yK7cG5yA5g_1783593747
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A074195605B; Thu,  9 Jul 2026 10:42:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.140])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16FF2195419F; Thu,  9 Jul 2026 10:42:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 786851801027; Thu, 09 Jul 2026 12:42:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 peter.maydell@linaro.org
Subject: [PATCH v3 5/5] hw/uefi: add post_load checks
Date: Thu,  9 Jul 2026 12:42:20 +0200
Message-ID: <20260709104223.143594-6-kraxel@redhat.com>
In-Reply-To: <20260709104223.143594-1-kraxel@redhat.com>
References: <20260709104223.143594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

Add sanity checks to uefi-vars state loaded from live migration data
stream.  Fail migration if invalid data or inconsistencies are found.

Fixes: CVE-2026-61404
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3837
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3838
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3839
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3885
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-core.c   | 14 +++++++++++++-
 hw/uefi/var-service-json.c   |  5 +++++
 hw/uefi/var-service-policy.c | 28 +++++++++++++++++++++++-----
 hw/uefi/var-service-vars.c   | 15 +++++++++++++++
 4 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 828d76007318..acecf7a8a9b1 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -5,6 +5,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/crc32c.h"
+#include "qemu/error-report.h"
 #include "system/dma.h"
 #include "migration/vmstate.h"
 
@@ -28,9 +29,20 @@ static int uefi_vars_post_load(void *opaque, int version_id)
 {
     uefi_vars_state *uv = opaque;
 
+    if (uv->buf_size > MAX_BUFFER_SIZE) {
+        error_report("invalid buffer size");
+        return -1;
+    }
+    uv->buffer = g_malloc(uv->buf_size);
+
     uefi_vars_update_storage(uv);
+    if (uv->used_storage > uv->max_storage) {
+        error_report("out of variable memory (%ld > %ld)",
+                     uv->used_storage, uv->max_storage);
+        return -1;
+    }
+
     uefi_vars_json_save(uv);
-    uv->buffer = g_malloc(uv->buf_size);
     return 0;
 }
 
diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
index 8621b86c5c5f..f90deef79b76 100644
--- a/hw/uefi/var-service-json.c
+++ b/hw/uefi/var-service-json.c
@@ -18,6 +18,7 @@
 #include "qobject/qobject.h"
 #include "qobject/qjson.h"
 
+#include "qapi/error.h"
 #include "qapi/dealloc-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
@@ -249,6 +250,10 @@ void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
     if (!(*errp)) {
         uefi_vars_from_qapi(uv, vs);
         uefi_vars_update_storage(uv);
+        if (uv->used_storage > uv->max_storage) {
+            error_setg(errp, "out of variable memory (%ld > %ld)",
+                       uv->used_storage, uv->max_storage);
+        }
     }
 
     qapi_free_UefiVarStore(vs);
diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 46c4ff2dacae..d43cc9b2500b 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -7,6 +7,7 @@
  * https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/VariablePolicyLib/ReadMe.md
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "system/dma.h"
 #include "migration/vmstate.h"
 
@@ -16,14 +17,18 @@
 
 #include "trace.h"
 
-static void calc_policy(uefi_var_policy *pol);
+static int check_calc_policy(uefi_var_policy *pol);
 
 static int uefi_var_policy_post_load(void *opaque, int version_id)
 {
     uefi_var_policy *pol = opaque;
+    int rc;
 
-    calc_policy(pol);
-    return 0;
+    rc = check_calc_policy(pol);
+    if (rc != 0) {
+        error_report("invalid uefi variable policy");
+    }
+    return rc;
 }
 
 const VMStateDescription vmstate_uefi_var_policy = {
@@ -80,32 +85,45 @@ static uefi_var_policy *wildcard_find_policy(uefi_vars_state *uv,
     return NULL;
 }
 
-static void calc_policy(uefi_var_policy *pol)
+static int check_calc_policy(uefi_var_policy *pol)
 {
     variable_policy_entry *pe = pol->entry;
     unsigned int i;
 
+    if (pol->entry_size != pe->size ||
+        pe->offset_to_name >= pe->size) {
+        return -1;
+    }
+
     pol->name = (void *)pol->entry + pe->offset_to_name;
     pol->name_size = pe->size - pe->offset_to_name;
 
+    if (!uefi_str_is_valid(pol->name, pol->name_size, false)) {
+        return -1;
+    }
+
     for (i = 0; i < pol->name_size / 2; i++) {
         if (pol->name[i] == '#') {
             pol->hashmarks++;
         }
     }
+
+    return 0;
 }
 
 uefi_var_policy *uefi_vars_add_policy(uefi_vars_state *uv,
                                       variable_policy_entry *pe)
 {
     uefi_var_policy *pol, *p;
+    int rc;
 
     pol = g_new0(uefi_var_policy, 1);
     pol->entry = g_malloc(pe->size);
     memcpy(pol->entry, pe, pe->size);
     pol->entry_size = pe->size;
 
-    calc_policy(pol);
+    rc = check_calc_policy(pol);
+    g_assert(rc == 0);
 
     /* keep list sorted by priority, add to tail of priority group */
     QTAILQ_FOREACH(p, &uv->var_policies, next) {
diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index fd07782f1e0d..e0ea3d532eb6 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -47,6 +47,20 @@ static int uefi_vars_pre_load(void *opaque)
     return 0;
 }
 
+static int uefi_vars_post_load(void *opaque, int version_id)
+{
+    uefi_variable *var = opaque;
+
+    if (!uefi_str_is_valid(var->name, var->name_size, true) ||
+        var->attributes & ~EFI_VARIABLE_ATTRIBUTE_SUPPORTED ||
+        (var->digest_size != 0 &&
+         var->digest_size != 32 /* AUTHVAR_DIGEST_SIZE */)) {
+        error_report("invalid uefi variable");
+        return -1;
+    }
+    return 0;
+}
+
 static bool uefi_vars_digest_is_needed(void *opaque)
 {
     uefi_variable *var = opaque;
@@ -72,6 +86,7 @@ const VMStateDescription vmstate_uefi_variable_digest = {
 const VMStateDescription vmstate_uefi_variable = {
     .name = "uefi-variable",
     .pre_load = uefi_vars_pre_load,
+    .post_load = uefi_vars_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8_ARRAY_V(guid.data, uefi_variable, sizeof(QemuUUID), 0),
         VMSTATE_UINT32(name_size, uefi_variable),
-- 
2.55.0


