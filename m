Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C69ECD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXYx-0006eF-9g; Fri, 22 May 2026 17:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXYv-0006cU-I8; Fri, 22 May 2026 17:37:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXYt-0001Tm-5X; Fri, 22 May 2026 17:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485682; bh=NcJd8nN8udITBb8kuubjKg36rc3x3Tj18jI98dI1A5o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bhKc/uB+UC3On9np0E9W6kywXJMirlz6W/PGXA6ZmpgbtbVxa2yb5JQa2PKh2iv7h
 PaaUrbCZwE9Fc9oLJEP5qNtRiXU45E7shQEs0rFUcuQ9rFuw38WDaGEmpboP8QEokF
 Ui5c5kBbXyiAO34aKlw99tKNr4+4Z40zf/ERSTibL2TaPkUNGDW/T/iGhVj9nDbr1b
 El5CTZTL6gL5NE+ayYaEiEyidbiZsisr0HRuDNPDJeGH21oAlypctGNy7ykKOLwPBs
 OEAqAjLbZjzlPIbsaTiQIDDiN4cUJ17KTZe0E3JGsWrMHz/va1qkGXu1k1DKfv5ptP
 xN0TJOy0zaPVQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 340EE1AFAF7;
 Sat, 23 May 2026 00:34:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57A253B7177;
 Sat, 23 May 2026 00:34:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 102/136] hw/uefi: fix buffer overruns
Date: Sat, 23 May 2026 00:34:10 +0300
Message-ID: <20260522213446.806182-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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

The buffer size checks do not consider the mm_header size, simliar to
CVE-2026-5744.  Factor out the repeated size check to a small helper
function, fix the check, update all places to use the new helper.

Fixes: CVE-2026-41435
Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-2-kraxel@redhat.com>
(cherry picked from commit f252769a23e67765f9b95d8944ca3da6c9edf58b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 27421c6e2d..82ff4e429a 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -260,6 +260,17 @@ static size_t uefi_vars_mm_error(mm_header *mhdr, mm_variable *mvar,
     return sizeof(*mvar);
 }
 
+static bool check_buffer_size(uefi_vars_state *uv, uint64_t length)
+{
+    /* uefi_vars_cmd_mm() checks that */
+    g_assert(uv->buf_size >= sizeof(mm_header));
+
+    if (uv->buf_size - sizeof(mm_header) < length) {
+        return false;
+    }
+    return true;
+}
+
 static size_t uefi_vars_mm_get_variable(uefi_vars_state *uv, mm_header *mhdr,
                                         mm_variable *mvar, void *func)
 {
@@ -307,7 +318,7 @@ static size_t uefi_vars_mm_get_variable(uefi_vars_state *uv, mm_header *mhdr,
     if (uadd64_overflow(length, va->data_size, &length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
@@ -377,7 +388,7 @@ uefi_vars_mm_get_next_variable(uefi_vars_state *uv, mm_header *mhdr,
     }
 
     length = sizeof(*mvar) + sizeof(*nv) + var->name_size;
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
@@ -567,7 +578,7 @@ static size_t uefi_vars_mm_variable_info(uefi_vars_state *uv, mm_header *mhdr,
     uint64_t length;
 
     length = sizeof(*mvar) + sizeof(*vi);
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
@@ -588,7 +599,7 @@ uefi_vars_mm_get_payload_size(uefi_vars_state *uv, mm_header *mhdr,
     uint64_t length;
 
     length = sizeof(*mvar) + sizeof(*ps);
-    if (uv->buf_size < length) {
+    if (!check_buffer_size(uv, length)) {
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
-- 
2.47.3


