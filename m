Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720BDF46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kmn-0003yt-VM; Mon, 06 Apr 2026 10:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kme-0003xN-O0
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmd-00054D-2A
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttNPQjucCKVQbYkQ9ZTni+I2TfWnxEihEhccHWw+Qk8=;
 b=D1s/ZwTT2wtGY2ZY1wWUbhXPRP1A+FTerBExdMYut6RWEDHN/+FzLFhGg0V+t5UHYeuvaV
 AKGovvL9cosFhnkMW+i0a0VY/44yb5nBvoYUb4C1Cd4iotjQFEZkZvumtVm8JspJgBjqFh
 PH0Otz3a4qdXL1CFrhhc3yYHvuZiIs0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-3jB7nS24MSKqNmcDT1LJ9A-1; Mon, 06 Apr 2026 10:18:27 -0400
X-MC-Unique: 3jB7nS24MSKqNmcDT1LJ9A-1
X-Mimecast-MFC-AGG-ID: 3jB7nS24MSKqNmcDT1LJ9A_1775485106
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2523e0299so102847745ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485106; x=1776089906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttNPQjucCKVQbYkQ9ZTni+I2TfWnxEihEhccHWw+Qk8=;
 b=UT/ky7HlM8el54jjF2a3rfnPbAsKqFgVatAXw3R7315KHUQJg28XzSs+sZUXNyplBX
 UmkK6zbX2bugvruV2UlkrKjKE7W1dG0v/GyebdBCevNyMbOszvuu/k/4wHdvb0un7Ajw
 Es+OhOm2+Zj71CACS8wbJ6W+jfNB0BtFeLKWWwed2dFaw3fpFwRnGbBxl2VayteOlOZM
 FEfIGDHs86u12tmBMsZXXZ+hbInwLss9ZZyxeF5kid9y2pJYYYVChbROKsuxeFFKLttV
 TutkuKu8y+JC8NAL83RlWy/49kb4LYMKvBfGUy33A20VarfEyemAp+w3pe2/8+DogBK5
 bd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485106; x=1776089906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ttNPQjucCKVQbYkQ9ZTni+I2TfWnxEihEhccHWw+Qk8=;
 b=J90gHdOP/t/X+n2Awa2w4bAuK84AJoX7gIFF91dW4HSBMYERh0yYrHdh7nDnPF/IiM
 HpWEmx14DzkYrWikzX9j8iRikXIlxDljpCGj5QG/v4VEor0FCje0HKY27IRxcTBlq+DY
 MLVzhOGA92OLjqG/Z9EwYxu4emxhwgSld/l4sniAGUQT8RdnMRm/QvqWQfJ8AFwmt/3m
 Jqj5JKF+kl78ML4w/5fUbfsdYnAvHjAgWhcowS62MsmqpndaOxFQopMVi/m1xSFzOAvi
 cMmnne6PXod1b8yGskxib0/o3ZMLK09yF6D5eRyIBiflQZpG9psXZxwWG6RII3coFrJS
 tYzQ==
X-Gm-Message-State: AOJu0Yy9nFMbiNbv7M0XdBecBQppUQAk9qk/0R6RUFaVZ6tCbjrLndqP
 DtN3W0ykiTnNsYsKyTTFS8qxAVjIAy89ZUsfPvsPGm/E5eUVeuNzXfzpwxdSehiTW6r8EgKpUPo
 QOiVYPd63IvpnlQttAw7G7NuQlENXKQA/2GZRV5GTwVNuw//HIf5mkM5yikmkEtOZBb/gPDmFqx
 2ObvqMqJDoHnozLHWf+GaRnXpZoW+aP+/PNKngWS8=
X-Gm-Gg: AeBDievHs8JkS265huPu3Q08NWdbNLGhr7S7R47wBEteuRtMd8kjcDViLLQuSPjBBIB
 mcy2xXZ4Z8+VdofEopRjCyK7jbKq+d8cnPyelzDV4av63OTAx6YBk4WofTEFOpTGWaNLqWV8T+i
 WbTgeNXVOBNdLvfmDBFNMRuJJUFIlVBxiLl+BiGR3PJ6/JJksuC8U19drdOxfrdSHJ8ZLN8rqkp
 AQstxWX5sdd6TVk+4fMjXRM2tKw63uOUm01qMe/1Ys2HQFvNTxtM6Z0AzlE7hnRCshGMVb/bvgC
 wAebXvrFoZ+S+8sZv4P3pXsQ3pctZ6Ar6iI9bWIhDuufzqv32jrM0J+e7tF3k1E7yo8HnFGeWBd
 YcUGlfAvjth0ThrjZfwxThoVk1oZuH602ZwuBmdJBJSdrstrxF3DqJbCnQdLi1D5N9Q4=
X-Received: by 2002:a17:903:1108:b0:2b2:5491:e32b with SMTP id
 d9443c01a7336-2b2817fbb01mr141426665ad.23.1775485106250; 
 Mon, 06 Apr 2026 07:18:26 -0700 (PDT)
X-Received: by 2002:a17:903:1108:b0:2b2:5491:e32b with SMTP id
 d9443c01a7336-2b2817fbb01mr141426095ad.23.1775485105522; 
 Mon, 06 Apr 2026 07:18:25 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:24 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 05/10] test/qtest: Add test for tpm crb chunking
Date: Mon,  6 Apr 2026 19:47:30 +0530
Message-ID: <20260406141735.25844-6-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-crb-swtpm-test.c |  10 +++
 tests/qtest/tpm-util.c           | 108 ++++++++++++++++++++++++++-----
 tests/qtest/tpm-util.h           |   5 ++
 3 files changed, 108 insertions(+), 15 deletions(-)

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
index 2cb2dd4796..603c5a825d 100644
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
 
@@ -31,24 +59,74 @@ void tpm_util_crb_transfer(QTestState *s,
 
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
+
+    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
+    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+    uint32_t crb_ctrl_cmd_size = qtest_readl(s, CRB_ADDR_CTRL_CMD_SIZE);
+
+    size_t chunk_size = crb_ctrl_cmd_size;
+
+    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
+
+    for (size_t i = 0 ; i < req_size; i += chunk_size) {
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
+            qtest_writel(s, CRB_ADDR_START , CRB_START_NEXT_CHUNK);
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


