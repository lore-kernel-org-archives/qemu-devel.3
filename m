Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250D6C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAIh-0004dr-2c; Wed, 12 Aug 2026 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIL-0004Sl-BR; Wed, 12 Aug 2026 10:51:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIH-0006hE-Rp; Wed, 12 Aug 2026 10:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546230; bh=8aDWynrhjRlgS8nQ+L/uLuFtJEBg4LWeWYwBCkv7YrE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mvURG8RTSJny1YfIHEDKDFtxIeLw6UH0ww+sty2xBFwsYc1+wY5KK7W6m3WCTmuI4
 HR+AkgAdQ1CSMzEYU5jgUnYMq3Bu3z/QG+Mb66F+gO99MJsEkpn77NHuyG4hnwNDeD
 wRMLNB4h84s62NhnWZgnve0T8ofMil0e7dsTSWsHqqSe0A4xsCirMJO5tfh7BqqPvj
 l0plYRDEoa8ayE5NNMlMz0Fo9EuKvt2pkt4rU1CWqDrsJFj7OkXKJ9nyramQsrjhFD
 BP1aP4B5YOaGpxc9d42RkzNtRKX4eb6SwlzTmt9f7W9hCQSUP4TA7bx31sQz06OZhc
 a9AaTP2dRJPTA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C262D1CA609;
 Wed, 12 Aug 2026 17:50:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2906F409D42;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 896ED2F96D; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 005/120] hw/uefi: add post_load checks
Date: Wed, 12 Aug 2026 17:47:48 +0300
Message-ID: <20260812144955.649205-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Add sanity checks to uefi-vars state loaded from live migration data
stream.  Fail migration if invalid data or inconsistencies are found.

Fixes: CVE-2026-61404
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3837
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3838
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3839
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3885
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-6-kraxel@redhat.com>
(cherry picked from commit acba2d78176d8235b81fd886b37642ae6c464982)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 828d7600731..65da71029a6 100644
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
+        error_report("out of variable memory (%" PRId64 " > %" PRId64 ")",
+                     uv->used_storage, uv->max_storage);
+        return -1;
+    }
+
     uefi_vars_json_save(uv);
-    uv->buffer = g_malloc(uv->buf_size);
     return 0;
 }
 
diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
index 8621b86c5c5..88757d58b6f 100644
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
+            error_setg(errp, "out of variable memory (%" PRId64 " > %" PRId64 ")",
+                       uv->used_storage, uv->max_storage);
+        }
     }
 
     qapi_free_UefiVarStore(vs);
diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 46c4ff2daca..d43cc9b2500 100644
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
index fd07782f1e0..e0ea3d532eb 100644
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
2.47.3


