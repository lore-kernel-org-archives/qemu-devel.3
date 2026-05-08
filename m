Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39045CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHvp-0007FK-Su; Fri, 08 May 2026 05:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvo-0007Do-CW
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvl-0000cY-JZ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778234136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cGJ5THQYtgZPxxVQ4uI5u9kDWc8cMjKeF9r+LCS3Dz0=;
 b=ejuYgcDdKnnMi2cGEd+xjC4jElU5L3LcNU6U/MrQp8MiAD8Me45zQfrIPdXIDmm2eJtsG+
 weceMR1x6E0JPa9deTvnM1HZrEVslmbzv9Qr30qgNPE8fbthc4TNkRnzpbJR4eysAM+WVk
 I3DFR3Rr8e0ddpKvtOHHk2qblAPNYlU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-EYpa2dRYP2mR1-bgGrPh7A-1; Fri,
 08 May 2026 05:55:35 -0400
X-MC-Unique: EYpa2dRYP2mR1-bgGrPh7A-1
X-Mimecast-MFC-AGG-ID: EYpa2dRYP2mR1-bgGrPh7A_1778234134
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FC4C180034E; Fri,  8 May 2026 09:55:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.50.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02852300019F; Fri,  8 May 2026 09:55:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A99761800D46; Fri, 08 May 2026 11:55:31 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: [PULL 3/6] hw/uefi: fix ucs2 string helper functions
Date: Fri,  8 May 2026 11:55:28 +0200
Message-ID: <20260508095531.570979-4-kraxel@redhat.com>
In-Reply-To: <20260508095531.570979-1-kraxel@redhat.com>
References: <20260508095531.570979-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The length passed in is in bytes not characters.  Rename the
parameters to make that clear.  Calculate the number of chars
if needed.  Fix length checks to use the number of chars not
bytes to avoid OOB reads.

Fixes: CVE-2026-41437
Fixes: 1ebc319c8ca7 ("hw/uefi: add var-service-utils.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-4-kraxel@redhat.com>
---
 hw/uefi/var-service-utils.c | 42 +++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/hw/uefi/var-service-utils.c b/hw/uefi/var-service-utils.c
index 258013f436af..489321a26ccb 100644
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
2.54.0


