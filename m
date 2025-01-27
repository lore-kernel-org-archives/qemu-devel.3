Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D80DC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgXv-0004Cv-Mf; Tue, 28 Jan 2025 03:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgX9-0000vk-0W; Tue, 28 Jan 2025 03:01:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgX5-0001q8-E6; Tue, 28 Jan 2025 03:01:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94D54E1B4D;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 10A011A6300;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id E6B6952091; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 06/58] qdev: Fix set_pci_devfn() to visit option only
 once
Date: Mon, 27 Jan 2025 23:24:52 +0300
Message-Id: <20250127202547.3723716-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

pci_devfn properties accept either a string or an integer as input. To
implement this, set_pci_devfn() first tries to visit the option as a
string, and if that fails, it visits it as an integer instead. While the
QemuOpts visitor happens to accept this, it is invalid according to the
visitor interface. QObject input visitors run into an assertion failure
when this is done.

QObject input visitors are used with the JSON syntax version of -device
on the command line:

$ ./qemu-system-x86_64 -enable-kvm -M q35 -device pcie-pci-bridge,id=pci.1,bus=pcie.0 -blockdev null-co,node-name=disk -device '{ "driver": "virtio-blk-pci", "drive": "disk", "id": "virtio-disk0", "bus": "pci.1", "addr": 1 }'
qemu-system-x86_64: ../qapi/qobject-input-visitor.c:143: QObject *qobject_input_try_get_object(QObjectInputVisitor *, const char *, _Bool): Assertion `removed' failed.

The proper way to accept both strings and integers is using the
alternate mechanism, which tells us the type of the input before it's
visited. With this information, we can directly visit it as the right
type.

This fixes set_pci_devfn() by using the alternate mechanism.

Cc: qemu-stable@nongnu.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20241119120353.57812-1-kwolf@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 5102f9df4a9a7adfbd902f9515c3f8f53dba288e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index f13350b4fb..30e040f98e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -794,39 +794,57 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     Property *prop = opaque;
+    g_autofree GenericAlternate *alt;
     int32_t value, *ptr = object_field_prop_ptr(obj, prop);
     unsigned int slot, fn, n;
-    char *str;
+    g_autofree char *str = NULL;
+
+    if (!visit_start_alternate(v, name, &alt, sizeof(*alt), errp)) {
+        return;
+    }
+
+    switch (alt->type) {
+    case QTYPE_QSTRING:
+        if (!visit_type_str(v, name, &str, errp)) {
+            goto out;
+        }
 
-    if (!visit_type_str(v, name, &str, NULL)) {
+        if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
+            fn = 0;
+            if (sscanf(str, "%x%n", &slot, &n) != 1) {
+                goto invalid;
+            }
+        }
+        if (str[n] != '\0' || fn > 7 || slot > 31) {
+            goto invalid;
+        }
+        *ptr = slot << 3 | fn;
+        break;
+
+    case QTYPE_QNUM:
         if (!visit_type_int32(v, name, &value, errp)) {
-            return;
+            goto out;
         }
         if (value < -1 || value > 255) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                        name ? name : "null", "a value between -1 and 255");
-            return;
+            goto out;
         }
         *ptr = value;
-        return;
-    }
+        break;
 
-    if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
-        fn = 0;
-        if (sscanf(str, "%x%n", &slot, &n) != 1) {
-            goto invalid;
-        }
-    }
-    if (str[n] != '\0' || fn > 7 || slot > 31) {
-        goto invalid;
+    default:
+        error_setg(errp, "Invalid parameter type for '%s', expected int or str",
+                   name ? name : "null");
+        goto out;
     }
-    *ptr = slot << 3 | fn;
-    g_free(str);
-    return;
+
+    goto out;
 
 invalid:
     error_set_from_qdev_prop_error(errp, EINVAL, obj, name, str);
-    g_free(str);
+out:
+    visit_end_alternate(v, (void **) &alt);
 }
 
 static int print_pci_devfn(Object *obj, Property *prop, char *dest,
-- 
2.39.5


