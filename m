Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E53CE7FDCC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzuD-00016G-3a; Mon, 02 Feb 2026 14:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzu0-0000wu-Iv; Mon, 02 Feb 2026 14:48:05 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztz-0003KU-3t; Mon, 02 Feb 2026 14:48:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 00EE11850A6;
 Mon, 02 Feb 2026 22:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A77DF35B288;
 Mon, 02 Feb 2026 22:46:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zesen Liu <ftyghome@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 20/69] qdev: fix error handling in set_uint64_checkmask
Date: Mon,  2 Feb 2026 22:45:43 +0300
Message-ID: <20260202194638.939438-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zesen Liu <ftyghome@gmail.com>

When specifying lbr_fmt=VALUE in cpu options with an invalid VALUE, error_setg() gets triggered twice, causing an assertion failure in error_setv() which requires *errp to be NULL, preventing meaningful error messages from being displayed.

Fix this by checking visit_type_uint64()'s return value and returning early on failure, consistent with other property setters like set_string().

Fixes: 18c22d7112a7 (qdev-properties: Add a new macro with bitmask check for uint64_t property)
Cc: qemu-stable@nongnu.org
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
Message-ID: <20251217-qdev-fix-v1-1-bd33ea463220@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Add Fixes: and Cc:]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit 00829ae3845fd11e56239390924e3e74c3a4c144)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 147b3ffd16..05e1fae183 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -429,7 +429,9 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
     const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_uint64(v, name, ptr, errp);
+    if (!visit_type_uint64(v, name, ptr, errp)) {
+        return;
+    }
     if (*ptr & ~prop->bitmask) {
         error_setg(errp, "Property value for '%s' has bits outside mask '0x%" PRIx64 "'",
                    name, prop->bitmask);
-- 
2.47.3


