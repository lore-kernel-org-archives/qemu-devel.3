Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B5AF9B60C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrV-0006mC-1C; Wed, 22 Apr 2026 06:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrH-0006kH-UD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrF-0006uM-QZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhbOaL4wUtt02SVejXfTrifRbFQpI240xrjMT6zWOWY=;
 b=f5eGd1UoiGwpjCxZMev34vTS8ViWHZ+ZUyvsNyUMhO5hpl6YWppwd382k3/UQlI1xrj0Hi
 nxqlJ9dvCP86I94SMqwqfrfWC2sdM/YzI6xK5CzazVn5GWHSPG7h5WqolblmVaTeoR0qBL
 UAaW41GfF0aSFbmyTq4+hGTuUNJSIKA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-ovMs-HqcMIabfF6hPgVH2A-1; Wed, 22 Apr 2026 06:30:59 -0400
X-MC-Unique: ovMs-HqcMIabfF6hPgVH2A-1
X-Mimecast-MFC-AGG-ID: ovMs-HqcMIabfF6hPgVH2A_1776853859
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso3686083a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853858; x=1777458658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhbOaL4wUtt02SVejXfTrifRbFQpI240xrjMT6zWOWY=;
 b=QCgYEqI78QDGT4CZGy656JyNoJ2PFtLfmIeU33k5qap41UvhXZf7tco+T4kEHGOZDb
 BVCmjLzcZN821UhpR7Q9jZ4MSvKSXHrQ6l1WMBI9Vty1kBH2XvoivO6uqTTjFhKGST9g
 dEtazdkU+lGD1XbFtIacufbw/0aBVnMK3BVTaAik0uAIxatGWX8GbNi7uYS3+Q/rUYIO
 5Nj7biTBGYlitxNvPgeP5UtAX57yVmyhqt0Fgvuje2rc6yt/yagkSmVqXFCm8UXrTNJ2
 jDnFrdtmMDFI+g/jLhGdL9unH1rQdoKYwv3kzbku+pYLG74WoRZm3S3JVySEQ5Nafdxx
 TQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853858; x=1777458658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fhbOaL4wUtt02SVejXfTrifRbFQpI240xrjMT6zWOWY=;
 b=ZGR6yJ1Sxm9ykQPo+yv88SC6O7mk/Q6ARjgbCgu5gIN6rOTT9PtLIZo66zFKxNwvfe
 mY79/YTlYXeZedpyof4AYh9ffmv6zMSH0cBRqEqDemJzL21bbMbSaLTDWe1Y1OA3MAS0
 oAEgIp6jL4T7oiR2yMvuO32JGkmYrqkyadY7ulNIn7N+QBjI2yK3yPEsNEEPAuCtdvOo
 c1yTrFMqj+X9hxSfo+MxQLyB3GpZEdZKWZxq3bgoyQEGAY6KSfZWATCzVK89SKojY3RN
 BEk05qXouA2Ow19/Lw8iryHf2WI5vFvTweY5ETk/yQDn94viara+4+86WItCYCZcNuNc
 2WmQ==
X-Gm-Message-State: AOJu0YxLsNV2iNAJgsmYPJv9oUWGzK4RT07LylpNCuK4E9ThuqfUU2wj
 oc0RgO5f1clfdjuHEGYvGw2FBEsnt17sRYxFHaKCMhuZxxCcPrYCRDJYlSy/g3uBejucsWQ4yjg
 6bd2VVqO84PsO6U081xIfV7U1lgd/V7g/aY8uwPovUrcJ1IrBvD8xJo2ujNmKu5LDla/TbNgRkK
 N5CSnbmavCwQD0mBg+TnnnKXuvzkeUEHbR/bGSxx4=
X-Gm-Gg: AeBDieuiyKRFDzQwVJlmWFpPorDKrbWhSL8XmqYBFE5gJ8ubTXlXqtT32j12Zt+tK6S
 kO5/PYik4IJGxo+K4ZyuOKOzHHkD/k5sBis9x1+3ilxWAcUBxMZdZTp+rGbS4oMPUB//TFoSJak
 27XgZANcORVFsd32oGTkLnCToIJMZ0t+ADDC2FDaRPB3FjYXoqSw/Kcbg1UclGHQ/m5lQAZp43b
 8/qSBQjnupdVeCg5NIjOW1MOcjboQnAYlSFeN0F5pxa/raiy/LQ3UIbrf06TpaisgFcYYkXyDCp
 99MhfBUugC+KfyrEACBcKXMkaaAxB3YpW6dcjM1wbjNanAmt4ubZI3LbPXAsFnrkYSfeFR9gi0M
 Y0GWAdo1eWKx0ceCPeXvT7D5Ahf0jF8cO5NUk6B32Jhe/mI6an3LzwWpGIWIUvApwujKXC5kA8g
 ==
X-Received: by 2002:a05:6a20:3c90:b0:39c:cdb:5d85 with SMTP id
 adf61e73a8af0-3a08d909cd0mr25433106637.46.1776853858241; 
 Wed, 22 Apr 2026 03:30:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c90:b0:39c:cdb:5d85 with SMTP id
 adf61e73a8af0-3a08d909cd0mr25433044637.46.1776853857613; 
 Wed, 22 Apr 2026 03:30:57 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:57 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 05/10] test/qtest: Add test for tpm crb chunking
Date: Wed, 22 Apr 2026 16:00:13 +0530
Message-ID: <20260422103018.123608-6-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


