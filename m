Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A3FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxKd-0008Lr-T6; Mon, 04 May 2026 13:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKU-00087j-M7
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKQ-0007ot-8V
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PErGi0I1XqID5q8HKlQNmc+sGgy3pO+HdWtIS8h3lWI=;
 b=ezuC/3LeGKesT2iiZzjrnlPl0OTVf+0c5SSQBb5vFznKGYrULCoowzIGewmSE/UcHVyV2V
 w8TsqFP4cxuXZkyPx3mrEpTNtMX2Cts6ZO20Q6XMx9VbbUxaukvN5Q4qf7LbTLqe4Wtzlx
 GBIgDDMqNiAYhP8ORFp7uZmbzx+Haq4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-DDuokzivOfGtSK5R1yh6zw-1; Mon, 04 May 2026 13:43:28 -0400
X-MC-Unique: DDuokzivOfGtSK5R1yh6zw-1
X-Mimecast-MFC-AGG-ID: DDuokzivOfGtSK5R1yh6zw_1777916607
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2e91add2aso42490605ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916607; x=1778521407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PErGi0I1XqID5q8HKlQNmc+sGgy3pO+HdWtIS8h3lWI=;
 b=WphLqcBAAcVvq0pR/KAME6KJf5BrdgNTprgyJwTZmFcl2s3avNPrkykGhWuIwCzA6M
 ZS2qJcXdcZIyaW+xGDxDZTK+Z21FcihRITI9Dzfgi/4YVCLWul7KeCBlNhxfL+mKJlZK
 zLrVDkTebAuyyOpv9hy/x2p0YnwLpWsi3DAAtd5ixBOLsz5NO5CHfgsq9LSfdn0zmmiX
 sK/GRpChgmEDxPXkGrk9f4aXDYWzuLY7r5+obMae8qmrbbhmYqbPXqoMjD4d4rKlUl+f
 99RU/vCCA5l79kE+Z392Iom4uJKUR2ha3RThJRYIUi8yVfZwjHsDZ6H0PkpebxL6IcCI
 KDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916607; x=1778521407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PErGi0I1XqID5q8HKlQNmc+sGgy3pO+HdWtIS8h3lWI=;
 b=bZyX4EJM4tY2N9cJqcs6opXmTtmt7wa5QDnzYnTYH+yY0ryTHGb/Kac+q3qToN7851
 tS5p1cpqEK6Vgapa80Dz3ZzMpj8vyMldj/7OtCJrf2GIg7ZgfG5uHKTq/M+CTGm/PQbz
 7Q8QdzgY4Ut5uFziJWelupB9nCYsSlqCTB9ZvnkLZooaekLdDg/s9IwZKGSj9/sEo2NJ
 zb5DE0QH9W8MJmsxKiK7TgUyaSbS/OuYG1IT8UG4utV9FgDZgo8R1amVgobvexYFhL3S
 tOLmzgwn+FeSrA/t2KRJy5Iij6e3s3E/6uzYzf3mY79q4OXF5AUVWP5di+rjt8TV6xAH
 VLNg==
X-Gm-Message-State: AOJu0Yy3SematAxObBjwesVjIs89JvskbmgPKRbh7d5vFbjJiYcjXFLs
 KNbuiOW8IDcxOllVL7sNQFHrR/eN37YI8dRbyO6LWrVzouNadW1O1bKikRJwifnuatAO2PO46Q1
 Ju02ziRP8Ve9R5cQJ9UecSPFEUp9aUAfh9jhbZrMMb4vbCoOCBa6XD6+GDT3GM6TZ53hSndv4AK
 1WGkmBc7w4crygPXQwlkihmDH5ECeBcOGtJ4SG0gg=
X-Gm-Gg: AeBDies3MI8DD8i7W6H8RHM7mP984Ssktc7+tbUmeweoU7f7u5MZnYM+fH5Zxp4UcW6
 0NWIyc59je2gPwIlkxsUHSfXrsJagLpAXoIeV9+sfVYtkbWxeggwB6pSheKi24TQRsAQ+9FW/89
 RxgE4JNTqay7sBuJ+9Jp6I+a3q02lUEInHN0TjNRom0bxbEIi1bsrYyL0ksxwgfP0eMrUBvGSMq
 6gt59hN5grNC/5ao2l/nhK93cyC9NLz10T1SqczgsKs7rMBgWuKdPZo46nfmJLwfuQBYcrlfuT0
 s/9JpHv+Hm9nVKxWP1XEpTmOOK3zQRDrT7XVqRSe8tyshHrEl63h4rjotgyTVJ+mM+hjWmNb6HE
 +zox4KiMWbOX6DJb9tvYW6vIfN+Yp4d3hhhPjol5KgmeEhRCQUPhyIukY5or72zwptkxBnG/c
X-Received: by 2002:a17:902:f087:b0:2b2:ebed:7af8 with SMTP id
 d9443c01a7336-2b9f252f63amr74489215ad.1.1777916606397; 
 Mon, 04 May 2026 10:43:26 -0700 (PDT)
X-Received: by 2002:a17:902:f087:b0:2b2:ebed:7af8 with SMTP id
 d9443c01a7336-2b9f252f63amr74488855ad.1.1777916605796; 
 Mon, 04 May 2026 10:43:25 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm112765315ad.24.2026.05.04.10.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:43:25 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 5/6] test/qtest: Add test for tpm crb chunking
Date: Mon,  4 May 2026 23:12:33 +0530
Message-ID: <20260504174234.13556-6-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174234.13556-1-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
2.54.0


