Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D75CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuU9-0006dK-LB; Tue, 12 May 2026 17:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuTw-0006QF-Uq; Tue, 12 May 2026 17:17:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuTv-0006nu-0b; Tue, 12 May 2026 17:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619307; bh=tGCFPzas1hHKzOl+cALrD/N2SyuwGyZAQXj2RFisqsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QtpBWJRghYCaRaTJBDbRiB+exmg15JB6y0Xxh+ph8g1iArrVN/R/d4Bb9cMgIvEC5
 OjtHomyJrkZCMCaNFQdFSYn+3QyZG/ax6oQU0p0gF7lP5jtmQ/hR0EmeqKLQ3nkCG0
 zq6GS88Dm1ZAgNfcrS5UnZ8Uzw6J+xtfHssJbpMysbtc4yZTUULfdh5mY1R65qdpn9
 AR9SZz1T3bn4eglMKhdrlx5Ovx8PtDYxJBYh9dkWostmlDETD/pEnkZc1H/N90GjUM
 STD9I4exnmI1JEw6Oo3NphAJjVUnEobUjCfk9i+BHB5rJ8GZjWB34oXhId2mUnuXZr
 129rlHvcTVCHg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 71CB01AA3B0;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E3DD3ABD1F;
 Tue, 12 May 2026 23:55:11 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 114/117] hw/uefi: fix ucs2 string helper functions
Date: Tue, 12 May 2026 23:54:56 +0300
Message-ID: <20260512205503.361097-114-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

The length passed in is in bytes not characters.  Rename the
parameters to make that clear.  Calculate the number of chars
if needed.  Fix length checks to use the number of chars not
bytes to avoid OOB reads.

Fixes: CVE-2026-41437
Fixes: 1ebc319c8ca7 ("hw/uefi: add var-service-utils.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-4-kraxel@redhat.com>
(cherry picked from commit 5247b3034c23bdfd91a7f78587c3b3e37f90568c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-utils.c b/hw/uefi/var-service-utils.c
index 258013f436..489321a26c 100644
--- a/hw/uefi/var-service-utils.c
+++ b/hw/uefi/var-service-utils.c
@@ -19,13 +19,18 @@
  * sometimes when they are not (for example in variable policies).
  */
 
-gboolean uefi_str_is_valid(const uint16_t *str, size_t len,
+gboolean uefi_str_is_valid(const uint16_t *str, size_t bytes,
                            gboolean must_be_null_terminated)
 {
+    size_t chars = bytes / 2;
     size_t pos = 0;
 
+    if ((bytes % 2) != 0) {
+        return false;
+    }
+
     for (;;) {
-        if (pos == len) {
+        if (pos == chars) {
             if (must_be_null_terminated) {
                 return false;
             } else {
@@ -47,12 +52,13 @@ gboolean uefi_str_is_valid(const uint16_t *str, size_t len,
     }
 }
 
-size_t uefi_strlen(const uint16_t *str, size_t len)
+size_t uefi_strlen(const uint16_t *str, size_t bytes)
 {
+    size_t chars = bytes / 2;
     size_t pos = 0;
 
     for (;;) {
-        if (pos == len) {
+        if (pos == chars) {
             return pos;
         }
         if (str[pos] == 0) {
@@ -62,25 +68,25 @@ size_t uefi_strlen(const uint16_t *str, size_t len)
     }
 }
 
-gboolean uefi_str_equal_ex(const uint16_t *a, size_t alen,
-                           const uint16_t *b, size_t blen,
+gboolean uefi_str_equal_ex(const uint16_t *a, size_t a_bytes,
+                           const uint16_t *b, size_t b_bytes,
                            gboolean wildcards_in_a)
 {
+    size_t a_chars = a_bytes / 2;
+    size_t b_chars = b_bytes / 2;
     size_t pos = 0;
 
-    alen = alen / 2;
-    blen = blen / 2;
     for (;;) {
-        if (pos == alen && pos == blen) {
+        if (pos == a_chars && pos == b_chars) {
             return true;
         }
-        if (pos == alen && b[pos] == 0) {
+        if (pos == a_chars && b[pos] == 0) {
             return true;
         }
-        if (pos == blen && a[pos] == 0) {
+        if (pos == b_chars && a[pos] == 0) {
             return true;
         }
-        if (pos == alen || pos == blen) {
+        if (pos == a_chars || pos == b_chars) {
             return false;
         }
         if (a[pos] == 0 && b[pos] == 0) {
@@ -100,18 +106,18 @@ gboolean uefi_str_equal_ex(const uint16_t *a, size_t alen,
     }
 }
 
-gboolean uefi_str_equal(const uint16_t *a, size_t alen,
-                        const uint16_t *b, size_t blen)
+gboolean uefi_str_equal(const uint16_t *a, size_t a_bytes,
+                        const uint16_t *b, size_t b_bytes)
 {
-    return uefi_str_equal_ex(a, alen, b, blen, false);
+    return uefi_str_equal_ex(a, a_bytes, b, b_bytes, false);
 }
 
-char *uefi_ucs2_to_ascii(const uint16_t *ucs2, uint64_t ucs2_size)
+char *uefi_ucs2_to_ascii(const uint16_t *ucs2, uint64_t ucs2_bytes)
 {
-    char *str = g_malloc0(ucs2_size / 2 + 1);
+    char *str = g_malloc0(ucs2_bytes / 2 + 1);
     int i;
 
-    for (i = 0; i * 2 < ucs2_size; i++) {
+    for (i = 0; i * 2 < ucs2_bytes; i++) {
         if (ucs2[i] == 0) {
             break;
         }
-- 
2.47.3


