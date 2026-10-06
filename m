Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AC3CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENBl-0000vj-Fn; Wed, 07 Oct 2026 04:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xEIsw-0008Vd-UV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:11 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xEIsr-0004ZV-Ki
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:04 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.46])
 by linux.microsoft.com (Postfix) with ESMTPSA id F25D220B7168;
 Tue,  6 Oct 2026 09:48:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F25D220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791305314;
 bh=EUCWfuW0peymBNY/EsRl+OrEPqZyXHIPcNkVNlx/pMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P/I2AG4p33fM+dnGY1QgDK0CoYlUV8QDRvbKUfrHjorQhCEkS1na0tBBJFOio70Ur
 YS3WMVBF5MzAZpJi6mugXoU/+AzJOPKjyGy3pgvuvyARbSEryol2wUbrrsyPF/OCr9
 OcK+J+ty/eMstwkAoH4bJPKfyANlIJVFbw0PXhmg=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/11] target/i386/mshv: fix read/write memory across the page
 boundary
Date: Tue,  6 Oct 2026 18:48:55 +0200
Message-Id: <20261006164905.776466-2-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
References: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

Previously, read_memory and write_memory performed a single GVA-to-GPA
translation for the entire buffer. If the buffer spanned a page
boundary, the translated GPA was only valid for the first page, causing
incorrect reads/writes for the remainder.

Fix both functions to loop over pages, translating and accessing each
page-aligned chunk separately.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Fixes: 6dec60528c (target/i386/mshv: Implement mshv_vcpu_run())
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 69 +++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f528dd2b9a..b8a6924088 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1831,21 +1831,38 @@ static int read_memory(const CPUState *cpu, uint64_t initial_gva,
 {
     int ret;
     uint64_t gpa, flags;
+    uint64_t cur_gva = gva;
+    size_t page_left, chunk;
+    uint8_t *cur_data = data;
 
-    if (gva == initial_gva) {
-        gpa = initial_gpa;
-    } else {
-        flags = HV_TRANSLATE_GVA_VALIDATE_READ;
-        ret = translate_gva(cpu, gva, &gpa, flags);
-        if (ret < 0) {
-            return -1;
+    /*
+     * If the read spans multiple pages,
+     * we need to translate and read each page separately
+     */
+    while (len > 0) {
+        page_left = HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE - 1));
+        chunk = MIN(len, page_left);
+
+        if (cur_gva == initial_gva) {
+            gpa = initial_gpa;
+        } else {
+            flags = HV_TRANSLATE_GVA_VALIDATE_READ;
+            ret = translate_gva(cpu, cur_gva, &gpa, flags);
+            if (ret < 0) {
+                return -1;
+            }
         }
 
-        ret = mshv_guest_mem_read(gpa, data, len, false, false);
+        ret = mshv_guest_mem_read(gpa, cur_data, chunk,
+                                  false, false);
         if (ret < 0) {
             error_report("failed to read guest mem");
             return -1;
         }
+
+        cur_gva += chunk;
+        cur_data += chunk;
+        len -= chunk;
     }
 
     return 0;
@@ -1856,18 +1873,34 @@ static int write_memory(const CPUState *cpu, uint64_t gva, const uint8_t *data,
 {
     int ret;
     uint64_t gpa, flags;
+    uint64_t cur_gva = gva;
+    size_t page_left, chunk;
+    const uint8_t *cur_data = data;
 
-    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
-    ret = translate_gva(cpu, gva, &gpa, flags);
-    if (ret < 0) {
-        error_report("failed to translate gva to gpa");
-        return -1;
-    }
+    /*
+     * If the write spans multiple pages,
+     * we need to translate and write each page separately
+     */
+    while (len > 0) {
+        page_left = HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE - 1));
+        chunk = MIN(len, page_left);
 
-    ret = mshv_guest_mem_write(gpa, data, len, false);
-    if (ret != MEMTX_OK) {
-        error_report("failed to write to mmio");
-        return -1;
+        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
+        ret = translate_gva(cpu, cur_gva, &gpa, flags);
+        if (ret < 0) {
+            error_report("failed to translate gva to gpa");
+            return -1;
+        }
+
+        ret = mshv_guest_mem_write(gpa, cur_data, chunk, false);
+        if (ret != MEMTX_OK) {
+            error_report("failed to write to mmio");
+            return -1;
+        }
+
+        cur_gva += chunk;
+        cur_data += chunk;
+        len -= chunk;
     }
 
     return 0;
-- 
2.34.1


