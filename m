Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A631ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZAi-0007vZ-S7; Tue, 14 Apr 2026 04:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAG-0007he-Pg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAE-00041l-Or
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhbOaL4wUtt02SVejXfTrifRbFQpI240xrjMT6zWOWY=;
 b=FpKjdv3jbMsHXYra6ZB0V5jIgxZvJbU0O6XVBtli7e/LNoyYytknwNKly9nYkP/AbR4yiE
 ozeR4T3NfIspq3bJtz31mG4793gUE61HwfAg27k01RYkLbFSYZPM2RjXUbD8DDJjCm0dtd
 CEUCE5kmsV+iEEOWhqi4R3GhhIVhIf4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Gj4SlvAbPUKcRp_UFCrw5Q-1; Tue, 14 Apr 2026 04:30:28 -0400
X-MC-Unique: Gj4SlvAbPUKcRp_UFCrw5Q-1
X-Mimecast-MFC-AGG-ID: Gj4SlvAbPUKcRp_UFCrw5Q_1776155427
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so26861325ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155427; x=1776760227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhbOaL4wUtt02SVejXfTrifRbFQpI240xrjMT6zWOWY=;
 b=MSF3v8e/uUJk3pou6/rV8+JpD5G5S3NNJQyJ34363K+/a0PPLfMNeV4a2KFDdx8Q8i
 Z0cJba6LKIp7vPn6rVEg2JX8sDfsjHBTt4uqC6dlFO2MnqR7ez1Iorj+tH2WSn361h4E
 xI1hi5LK15PVH+Ejsq/C+JQsZo4z1N4ejt4aIjqjKr6I2MuokU3JmR0BReHGt6bj+Psc
 xDDLuHyHYzH6rn75yItdAhInrOGF/XmGRP1rLlYbvMH/5UrHr+vEEsbIiDQMmrw3tSQp
 PsFI5mFbxd+FiGnr1yAXkFaBp+rIXMAfCo7Zjlx0FdJ/nBZoeQ2D9sAgPeNgW3oowIMr
 +GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155427; x=1776760227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fhbOaL4wUtt02SVejXfTrifRbFQpI240xrjMT6zWOWY=;
 b=hlla+KrTTlnmpbXmX5tjVJSuOL5rn7CvsfuemkIwIvL62D7d8uP88KLSPoZaS4+b/g
 +Pkjze9OIB6wt/ykXOWTFWyvfLsNs2n+rLpceJTZ8jh9yQUy8R1CuHRzGUjetdbiNPZY
 ATgsp26n/wnKFO7XjbbWe9F+B/phIphnA2uEwJyUwK90+r0LvHkHvg0zFqlbqJZNSc1B
 7N/DGPOaWAdWlZNUBRhbKV/s9rLlFgXutlhlEY81DqnhzCzlHp19NUWxRUj9ocyVHtjP
 dGlNfs9JHzW6wJz3vvg5FkpHvcWIfoGYmsMU/ljFaEPQPOMlUmoaKGoYub1rpFYLN6BY
 oY9g==
X-Gm-Message-State: AOJu0Yx59z+ndHci9Udttis2sMg85SszKesNL/Y3lDl0/F0l57q5pN8i
 FLp0GSWbm034aJIl9gzYUV7XaZlOyf1v77kPK9ai9J8Y9gDAIcYB0Yh3kUEGNgkzAbxTXmV8seH
 cl5WXK4DKbtQrsTrjhHZMg5P9BLsaljfXuYZKxeT8lK+4tXUzqpcwHgaOsl3xiSdfEhhQbynkEl
 WDphC9re+Z+s1cSBNvr+mvyAx7Rf+sQKsqc4l64VU=
X-Gm-Gg: AeBDietEJ5hksTXXyCszJGcyhwy0eu8nmZmxvTG6fj2rrJQXIQxtpdKlQIMsDridslc
 ZFspwWyseY5UkY/7dxGwS8ebGc8KPU9agrXuS1aumwsxUja+SOkqzoE+OlS+AXhoYXDrriIHypP
 9MIB+7JHkvt1dSLTeWo4Q+v+6m3GHAlG8rOMStjBhYTLxaqce6Itxqv1Ye7Scyw7C08GyLR3MFe
 4aAX8j+UZSm1Zfin9zSQN5oLaLhzo3LeeQf728QqTeWj4qNFG/TlCfr6EplvIZruVtM+sG13AKV
 WywawJIpf/pf7RGN8jth0j0qGdy+VghEP+vbB5OGGIfbt181I8YDWp8hVTwtqdB7ezEyJDQ/Man
 CDkOtnooJVsBi+zr1JJqWeobt8GTi+l/RyKPE0KsfgSN8cgcQr81jbKOhvShL7Tw=
X-Received: by 2002:a17:902:7b91:b0:2b0:4c68:283f with SMTP id
 d9443c01a7336-2b2d5c55bc6mr108648625ad.5.1776155427182; 
 Tue, 14 Apr 2026 01:30:27 -0700 (PDT)
X-Received: by 2002:a17:902:7b91:b0:2b0:4c68:283f with SMTP id
 d9443c01a7336-2b2d5c55bc6mr108648305ad.5.1776155426585; 
 Tue, 14 Apr 2026 01:30:26 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:30:26 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, marcandre.lureau@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 05/10] test/qtest: Add test for tpm crb chunking
Date: Tue, 14 Apr 2026 13:59:10 +0530
Message-ID: <20260414082915.112122-6-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414082915.112122-1-armenon@redhat.com>
References: <20260414082915.112122-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 tests/qtest/tpm-crb-swtpm-test.c |  10 +++
 tests/qtest/tpm-util.c           | 110 ++++++++++++++++++++++++++-----
 tests/qtest/tpm-util.h           |   5 ++
 3 files changed, 110 insertions(+), 15 deletions(-)

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
index 2cb2dd4796..744592763f 100644
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
 
@@ -31,24 +59,76 @@ void tpm_util_crb_transfer(QTestState *s,
 
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
+    unsigned char header[10];
+    uint32_t actual_response_size = 0;
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
2.53.0


