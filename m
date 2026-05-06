Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BC3CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX9k-0005I8-08; Wed, 06 May 2026 03:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9i-0005Fq-EO
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9g-0000gy-Is
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778054331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VG1umfV8XbLQ9QjPcrnZsX2l74f6GjJZEm8Zg6nu/U=;
 b=EkrsCAhNmEi9wYTOfCZ78SXYQUTmWPbqRyzlrb6FhVkwzm14a0OAV5BxDd5NP0SD/HqtVe
 q0EBKc9of72i6r3U7IVO441IiV90Ekjh/cgMsavbEpVR2MYOn+CWobZJhMKWR9Op8qvNrT
 f0m+ZRishTg+tVLiOEjKxAysY+VYcN8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-nJe6ChdlPxGTcGIYFh6iFA-1; Wed, 06 May 2026 03:58:50 -0400
X-MC-Unique: nJe6ChdlPxGTcGIYFh6iFA-1
X-Mimecast-MFC-AGG-ID: nJe6ChdlPxGTcGIYFh6iFA_1778054329
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-365d4d2fa04so16122a91.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778054329; x=1778659129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VG1umfV8XbLQ9QjPcrnZsX2l74f6GjJZEm8Zg6nu/U=;
 b=iYx3imMmsWY5cIAD+SJ9B52icp4eHTUsNJktVxGiLJ4PGkaHv3eH70cHTe1wFVNgit
 N4pUwWLIylBKkFB5mz/W9vGOfyq/QR2myjz5/efOw7ga9HwIG/AAe6E2hAQ1srIBZ9vr
 tD/55ppsHoIXr/c68JP11XGih88ObPL2G+mgNHhrqIqLogFKQRFOQkkBSriUskS15ZGP
 oQ+yM5EDHbsz0+N1I+fqbQp0nEaOUY/M5MuWZZTVe6qzYXQ1JRi182mbewtpME4p7Tfw
 4rm3TJm0zu/jD8hIVEeVhJur243bAC16HksyG3JUkAyIDwP0oL2d8SMy3Dh1lqtl3GnM
 53ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054329; x=1778659129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8VG1umfV8XbLQ9QjPcrnZsX2l74f6GjJZEm8Zg6nu/U=;
 b=mChFS+dd8uePmtlqda8+CIP8kjg8A2AhMuUkcJ6aB90sTTnDxNYsWPoM+BuuopMm85
 1uMqJ0A3w4a15AqA3DysH0p2NwnTN2t7Q6/ubJELq20Lt8fwfadU/OOw8D6UbTCs6vqi
 /5iujmpLF6h2gv3kvq7wizm7ZF1PrlFBY819wmOG9WVBCbTm674h0RjRyEtVNE3zNSX7
 lkYjzKVFVGa8Nsh4U/aKpEFkGW5jZrdthW6fQaTEaZ0BH08uQUFKa52JcM8pq20D6x59
 5gBz54DGPSqf6p4xZl3A0xcK0peq90M8rnO1HiV5ji3ybKhg0KhggI+Ar9IeGS+DByAG
 SZeg==
X-Gm-Message-State: AOJu0Ywa+uE95R3UIRACgO/b1eeSWlh1O2zFk2a9goB/GW724iNqwhuN
 Ln7Ca3VRpcbu77PDmRB9uQyohTg/iZzLS42abpYDX+v5ezEMU+fjxs4bNRCkaNhynBNje437H+i
 iwiH6UGh9TGW3ruu0xuQxVMVEU/v5CHQxIQBjpAw2JgJLVUi0yVqrV7zs2u7nwwxF0fUptJzwv+
 kwYypYbCntJcv7Tc4kdcxof5pWmU+3qySgEXFH7cI=
X-Gm-Gg: AeBDiesUlZMuSKb8eD4Os4nW/6QvkvVavVK0Don0hvq22Mm2W70MDxkcb56mA7zLktZ
 nZncdHv7G7rAcz5SH/KNipVrYQvAjqM7PQ54Hyl2QejJEKGvc4GMF/GguUgPfpQHdQ5ViQZttoR
 5iVIMdLrjTHzgNvUeurL1CCROW5t/kcXc6EFyPsDzx2lvRtyxdSlw0f/XdfkSFrIEN4MEbMBZ/q
 jCQOrzqbYbiFkfgnsjxYW1CHuOfCQk6vFObpgA1pMJNTZyI6XY4cRdMzdNVhY6cmEmyVj42sCVL
 YQarzts/+j4aAcxpKys8owdLyEXWZNoFx7DWbJ+EINS+FxV9iFUk/RuaLcMC6XZZM6vSzW9mu/u
 IfnCreLFPNnz3YEWNdUDpG05GCEzCsBbUImLNNi9xNEx2rlyBCymfXP5TGBNsWPkzlnTZPeJb
X-Received: by 2002:a17:90b:5207:b0:364:919c:b52f with SMTP id
 98e67ed59e1d1-365ac775c4cmr2178923a91.24.1778054328974; 
 Wed, 06 May 2026 00:58:48 -0700 (PDT)
X-Received: by 2002:a17:90b:5207:b0:364:919c:b52f with SMTP id
 98e67ed59e1d1-365ac775c4cmr2178877a91.24.1778054328326; 
 Wed, 06 May 2026 00:58:48 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca29f9dsm15439865ad.78.2026.05.06.00.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:58:47 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 5/6] test/qtest: Add test for tpm crb chunking
Date: Wed,  6 May 2026 13:28:12 +0530
Message-ID: <20260506075813.120781-6-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506075813.120781-1-armenon@redhat.com>
References: <20260506075813.120781-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

From: Arun Menon <armenon@redhat.com>

- New test case added to the swtpm test. Data is written and read from
  the buffer in chunks.
- The chunk size is dynamically calculated by reading the
  CRB_CTRL_CMD_SIZE address. This can be changed manually to test.
- Add a helper function tpm_wait_till_bit_clear()
- Note that this commit does not yet exercise the chunked read/write
  logic, as current transfer sizes remain small. Testing for large
  transfers is introduced in a subsequent patch: 'tests: Use ML-DSA-87
  operations to cause large TPM transfers with CRB'

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/tpm-crb-swtpm-test.c |  10 +++
 tests/qtest/tpm-util.c           | 109 ++++++++++++++++++++++++++-----
 tests/qtest/tpm-util.h           |   5 ++
 3 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index ffeb1c396b..050c7b0c1f 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -33,6 +33,14 @@ static void tpm_crb_swtpm_test(const void *data)
                         "tpm-crb", NULL);
 }
 
+static void tpm_crb_chunk_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_chunk_transfer,
+                        "tpm-crb", NULL);
+}
+
 static void tpm_crb_swtpm_migration_test(const void *data)
 {
     const TestState *ts = data;
@@ -54,6 +62,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
+    qtest_add_data_func("/tpm/crb-chunk-swtpm/test", &ts,
+                        tpm_crb_chunk_swtpm_test);
     qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
                         tpm_crb_swtpm_migration_test);
     ret = g_test_run();
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 2cb2dd4796..b0763d86b3 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -14,16 +14,44 @@
 
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
+#include "qemu/bswap.h"
 
 #include "hw/acpi/tpm.h"
 #include "libqtest.h"
 #include "tpm-util.h"
 #include "qobject/qdict.h"
 
+#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
+#define CRB_ADDR_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
+#define CRB_ADDR_CTRL_CMD_SIZE \
+    (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)
+
+#define CRB_START_INVOKE  (1 << 0)
+#define CRB_START_RSP_RETRY (1 << 1)
+#define CRB_START_NEXT_CHUNK (1 << 2)
+
+void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask)
+{
+    uint32_t sts;
+    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+
+    while (true) {
+        sts = qtest_readl(s, addr);
+        if ((sts & mask) == 0) {
+            break;
+        }
+        if (g_get_monotonic_time() >= end_time) {
+            g_assert_cmphex(sts & mask, ==, 0);
+            break;
+        }
+    }
+}
+
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size)
 {
+    uint32_t tpm_sts;
     uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
     uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
 
@@ -31,24 +59,75 @@ void tpm_util_crb_transfer(QTestState *s,
 
     qtest_memwrite(s, caddr, req, req_size);
 
-    uint32_t sts, start = 1;
-    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
-    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
-    while (true) {
-        start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
-        if ((start & 1) == 0) {
-            break;
+    qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
+    tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOKE);
+
+    tpm_sts = qtest_readl(s, CRB_ADDR_CTRL_STS);
+    g_assert_cmpint(tpm_sts & 1, ==, 0);
+
+    qtest_memread(s, raddr, rsp, rsp_size);
+}
+
+void tpm_util_crb_chunk_transfer(QTestState *s,
+                                 const unsigned char *req, size_t req_size,
+                                 unsigned char *rsp, size_t rsp_size)
+{
+    uint32_t tpm_sts;
+    size_t chunk_size;
+    unsigned char header[10];
+    uint32_t actual_response_size = 0;
+
+    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
+    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+    uint32_t crb_ctrl_cmd_size = qtest_readl(s, CRB_ADDR_CTRL_CMD_SIZE);
+
+    chunk_size = crb_ctrl_cmd_size;
+
+    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
+
+    for (size_t i = 0; i < req_size; i += chunk_size) {
+        bool last_chunk = false;
+        size_t current_chunk_size = chunk_size;
+
+        if (i + chunk_size > req_size) {
+            last_chunk = true;
+            current_chunk_size = req_size - i;
         }
-        if (g_get_monotonic_time() >= end_time) {
-            break;
+
+        qtest_memwrite(s, caddr, req + i, current_chunk_size);
+
+        if (last_chunk) {
+            qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
+            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOKE);
+        } else {
+            qtest_writel(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
+            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
         }
-    };
-    start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
-    g_assert_cmpint(start & 1, ==, 0);
-    sts = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-    g_assert_cmpint(sts & 1, ==, 0);
+    }
+    tpm_sts = qtest_readl(s, CRB_ADDR_CTRL_STS);
+    g_assert_cmpint(tpm_sts & 1, ==, 0);
 
-    qtest_memread(s, raddr, rsp, rsp_size);
+    /*
+     * Read response in chunks
+     */
+
+    qtest_memread(s, raddr, header, sizeof(header));
+    actual_response_size = ldl_be_p(&header[2]);
+
+    if (actual_response_size > rsp_size) {
+        actual_response_size = rsp_size;
+    }
+
+    for (size_t i = 0; i < actual_response_size; i += chunk_size) {
+        size_t to_read = i + chunk_size > actual_response_size
+                       ? actual_response_size - i
+                       : chunk_size;
+        if (i > 0) {
+            qtest_writel(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
+            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
+        }
+        qtest_memread(s, raddr, rsp + i, to_read);
+    }
 }
 
 void tpm_util_startup(QTestState *s, tx_func *tx)
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 0cb28dd6e5..681544e7d8 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -24,10 +24,15 @@ typedef void (tx_func)(QTestState *s,
                        const unsigned char *req, size_t req_size,
                        unsigned char *rsp, size_t rsp_size);
 
+void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask);
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size);
 
+void tpm_util_crb_chunk_transfer(QTestState *s,
+                                 const unsigned char *req, size_t req_size,
+                                 unsigned char *rsp, size_t rsp_size);
+
 void tpm_util_startup(QTestState *s, tx_func *tx);
 void tpm_util_pcrextend(QTestState *s, tx_func *tx);
 void tpm_util_pcrread(QTestState *s, tx_func *tx,
-- 
2.54.0


