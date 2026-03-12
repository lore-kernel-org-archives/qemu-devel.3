Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187B3FED2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0XUL-00009e-Pl; Thu, 12 Mar 2026 00:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XU9-00007v-Pd
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XU7-0008No-KE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773289037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxzOKiF8RPBv/6bl3AO49sH9RYZ73DNdYBieKZ2Pg+Y=;
 b=WgZnkgNGTx5MdGbporyysRYnduqtgYGmJ6hHtxfCoeGFbpAJZhjqjAHXFFbZ0VOEyiEwZI
 KsfxdwaBbXEf7NMYxW1eb9hwiOfFZIFLwwmty3BNF3MjJeKLJdOi5kDh/iD6eVpCcc7RLJ
 xDkSmYOEbguzp0skCwlctGW9Fh+k3Sc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-fsb07u6wO0yetgQnrJ8BCQ-1; Thu, 12 Mar 2026 00:17:16 -0400
X-MC-Unique: fsb07u6wO0yetgQnrJ8BCQ-1
X-Mimecast-MFC-AGG-ID: fsb07u6wO0yetgQnrJ8BCQ_1773289036
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so345081a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773289035; x=1773893835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxzOKiF8RPBv/6bl3AO49sH9RYZ73DNdYBieKZ2Pg+Y=;
 b=BfQ8axE44rBCsBEB4tuzTaApZSWgvJM4ME2MKlCq1YMgKD+PlpcZbVxZt8dBz8Mnea
 jYzyk0s1jnjGhRGs/Rlv1m7HUOnpbCMDBIaKXTNMuLRDCar+I9wJ+k94QukbGHYGcufJ
 rCDPCJNVoJlWec/7ZWmoLMrdD91fYkcrpuq4SlbPkd9qFjND7l221TTcuTBP+qBOEy93
 uSuYXYxWcxBSB+p4gKqd78NttdM+Lt5JGRn0ka3Ks8fY2h7WY6rrpG54zS/IN99Qb0vx
 nM/mJaFo7yX1USI457EwfIuC/i0KIEKeHN1nnBZjsRgNWjQHn6Uy/68rZdZl1jjauI84
 yI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289035; x=1773893835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IxzOKiF8RPBv/6bl3AO49sH9RYZ73DNdYBieKZ2Pg+Y=;
 b=TrVXu7jZgm0pQu/sLT6uKURXG3PzwxRWOplRZAlcydeNFL6PfuIsGk1YbhYGJaNmZ6
 9qmaiiqQRLRCo4X+5NjmXc2QUDPO64a5JBPvz8U8tcB4nJoTgK/BSfTweK0URutpXfWW
 x1PyCh5uF/HpAEtYfqKkfyBMLUKPrOYRIXVadmlu/MTsl8YvmTbE4jzqbtW0WILS7SJl
 0dz3fBfQM9Wuxd0XiGsx/3VaiWIJo4LdDn2kSBSLUI+OLJF72RRCUMGDxruqr3YvuRiY
 vQq0pck0xxKGnxKVwYPLnvZQe2qesblR+e1bMJcWG93Pj27navcty8vmPQeQKFMgUd8V
 Nu+w==
X-Gm-Message-State: AOJu0YzU2/ruqIBfcZHA9lJdi3E78oV7BgMlE0ufou9yqilNimghOzQ3
 8dUKlGjc1hokliVSQZnL6nFpJqWBwvoAHf03UPE6M2DUa4gy0AFUvBcyneLk1umWpcr6lV+kT66
 20wEcnxJ+g6sPwcRhHpRohc35jwVU1UDEMtl5GOc32sC2vamlSz4XSNXEg9lN1eNBzrj94UwWs1
 J5keji7gFymx8O2hfSy9T+LEi3dC7zC/B5kP+981g=
X-Gm-Gg: ATEYQzy9NNcmPXWI1ZSRi0IDGgu5w05nnq4LiC23Mx79oLZIFKNGCovp+hxXm95vfkD
 xmKl4YYECh9vlXt7ElFSAz8iu97heINon9TfcZGmwdEoN2Sb9cqLMlwFOt0ZcYGSP9f6UBLgvse
 ZmjMJVWHTQAkyo7dUC/zJtjAYDCijDISgnSZdD2UQzhMPQsZQSDQLJ2Q0o2ICyZpWHXi/CaG5Kg
 vj89XA5ZSED8xpNdEPRL0q9Q/5NLcmVxaWZFATWWej/XRM+7oCRhOm1cJVsB1+6yfUrSrCFGQbN
 o5fYEra28UXfNXGXzXQE7sVwcvalAo39d8qqUMiCOuuW6nUXMC3wFXJG+4rHNVyNsZe+IrSaHdo
 Nm2uDWMMhmK7yNkWxfm+lsHiK/K+F3msSq2JbQQNu/rJWInjUDwinPzJlOfyDfg==
X-Received: by 2002:a05:6a21:1309:b0:38e:9220:ebbe with SMTP id
 adf61e73a8af0-398c5f49f5dmr4698944637.23.1773289035301; 
 Wed, 11 Mar 2026 21:17:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:1309:b0:38e:9220:ebbe with SMTP id
 adf61e73a8af0-398c5f49f5dmr4698918637.23.1773289034799; 
 Wed, 11 Mar 2026 21:17:14 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf0e498sm3634490a12.3.2026.03.11.21.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:17:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC 5/5] test/qtest: Add test for tpm crb chunking
Date: Thu, 12 Mar 2026 09:46:50 +0530
Message-ID: <20260312041650.181411-6-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312041650.181411-1-armenon@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

- New test case added to the swtpm test. Data is written and read from
  the buffer in chunks.
- The chunk size is dynamically calculated by reading the
  CRB_CTRL_CMD_SIZE address. This can be changed manually to test.
- Add a helper function tpm_wait_till_bit_clear()

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-crb-swtpm-test.c |  10 +++
 tests/qtest/tpm-util.c           | 106 ++++++++++++++++++++++++++-----
 tests/qtest/tpm-util.h           |   5 ++
 3 files changed, 106 insertions(+), 15 deletions(-)

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
index 2cb2dd4796..0a861a9e69 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -14,16 +14,42 @@
 
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
+#include "system/memory.h"
 
 #include "hw/acpi/tpm.h"
 #include "libqtest.h"
 #include "tpm-util.h"
 #include "qobject/qdict.h"
 
+#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
+#define CRB_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
+#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)
+
+#define BIT_START_INVOKE  (1 << 0)
+#define BIT_RETRY_RESPONSE (1 << 1)
+#define BIT_NEXT_CHUNK (1 << 2)
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
+            break;
+        }
+    }
+}
+
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size)
 {
+    uint32_t tpmSts;
     uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
     uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
 
@@ -31,24 +57,74 @@ void tpm_util_crb_transfer(QTestState *s,
 
     qtest_memwrite(s, caddr, req, req_size);
 
-    uint32_t sts, start = 1;
-    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
-    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
-    while (true) {
-        start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
-        if ((start & 1) == 0) {
-            break;
+    qtest_writel(s, CRB_ADDR_START, BIT_START_INVOKE);
+    tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_START_INVOKE);
+
+    tpmSts = qtest_readl(s, CRB_CTRL_STS);
+    g_assert_cmpint(tpmSts & 1, ==, 0);
+
+    qtest_memread(s, raddr, rsp, rsp_size);
+}
+
+void tpm_util_crb_chunk_transfer(QTestState *s,
+                                 const unsigned char *req, size_t req_size,
+                                 unsigned char *rsp, size_t rsp_size)
+{
+    uint32_t tpmSts;
+
+    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
+    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+    uint32_t crb_ctrl_cmd_size = qtest_readl(s, CRB_CTRL_CMD_SIZE);
+
+    size_t chunk_size = crb_ctrl_cmd_size;
+
+    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
+
+    for (size_t i = 0 ; i < req_size; i += chunk_size) {
+        bool last_chunk = false;
+        size_t current_chunk_size = chunk_size ;
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
+            qtest_writel(s, CRB_ADDR_START , BIT_START_INVOKE);
+            tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_START_INVOKE);
+        } else {
+            qtest_writel(s, CRB_ADDR_START , BIT_NEXT_CHUNK);
+            tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_NEXT_CHUNK);
         }
-    };
-    start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
-    g_assert_cmpint(start & 1, ==, 0);
-    sts = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-    g_assert_cmpint(sts & 1, ==, 0);
+    }
+    tpmSts = qtest_readl(s, CRB_CTRL_STS);
+    g_assert_cmpint(tpmSts & 1, ==, 0);
 
-    qtest_memread(s, raddr, rsp, rsp_size);
+    /*
+     * Read response in chunks
+     */
+
+    unsigned char header[10];
+    qtest_memread(s, raddr, header, sizeof(header));
+
+    uint32_t actual_response_size = ldl_be_p(&header[2]);
+
+    if (actual_response_size > rsp_size) {
+        actual_response_size = rsp_size;
+    }
+
+    for (size_t i = 0; i < actual_response_size; i += chunk_size) {
+        size_t to_read = i + chunk_size > actual_response_size
+                       ? (actual_response_size - i)
+                       : chunk_size;
+        if (i > 0) {
+            qtest_writel(s, CRB_ADDR_START, BIT_NEXT_CHUNK);
+            tpm_wait_till_bit_clear(s, CRB_ADDR_START, BIT_NEXT_CHUNK);
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


