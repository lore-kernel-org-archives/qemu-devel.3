Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A758109022A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Dpc-00069U-3R; Thu, 19 Mar 2026 09:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dou-0005nj-NU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dot-0001Al-2Q
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQPI6WkJx9rs4KYo3QAUSEyEpqdbt7RFH0oOqRA2y6E=;
 b=RoJpWO7IQ3aYdSoZQzyO7w/ahEzRl7z4mZhSef/TbbkNMvY7IPWSw8c1059gp0ETt6UyUh
 e2lbzDd3aPYx8srkz/pVHYvtu+AAslSlbZ6wMqEjtEBvhv4DNoQxrqAW6tYpEGTYecX8C6
 AUin8741KYO+PSVDcVR6YbLNxi7FwTA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-PmSxEuzkPy6Nkr0fQlcpGg-1; Thu, 19 Mar 2026 09:53:49 -0400
X-MC-Unique: PmSxEuzkPy6Nkr0fQlcpGg-1
X-Mimecast-MFC-AGG-ID: PmSxEuzkPy6Nkr0fQlcpGg_1773928428
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b064f043adso10987145ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928428; x=1774533228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQPI6WkJx9rs4KYo3QAUSEyEpqdbt7RFH0oOqRA2y6E=;
 b=YiC5le898MdzhVk4aEXh4K+aILf8jsSjh6smUhsDd5SReLaLxvSGIym6SMQ4KmFcXP
 pxZpt9ENrbg0vMM0eFySCuxoJ7TfJ9xF4mPVNf+eqmOv2swFBqRZ5QANsVuJB3NWmlQE
 xNk3kDsnMYBJWmLi4AwU3WDRwqOhpraxHX0SYuQmMbRpAgYCdpZ/qKFBgblKXmAvA6/A
 tPhHrst+gbiqAw7YYtv+xF2PyZvIV4fvQ4osLT3YHFr1jf9B3/Ze5UWY4JeHH116iIta
 KWFjL3Bi5mv7Qdtl3EMuHaMd2CUswa5Bk903yXttJ7WyU+AK9SGUo8n9cXAcdHWwGWTc
 Nedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928428; x=1774533228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gQPI6WkJx9rs4KYo3QAUSEyEpqdbt7RFH0oOqRA2y6E=;
 b=elSFHvdiiKQv3vwLxmp8wl3XYHzYVOMfk0KHHPJQjxdR+cbSrxddp5bkJMZ1IqorP6
 8Sq227eoENCULFIogjfgNaH1VHGHPoO75aea343e30QSRa7v9x/FbqDWOPFUACcSTVFS
 2oXpeRoLxwRET4Xxvczaa7HZeZ9yEWfJm/zNc2hkPUTE4PqZKQptgJ9co41xm2xDbrUF
 N2z9JfgH4oBJ7nWGY2a/QJc3R6/WiyZnQFWEMI7L9kAItg7Z83ppNsVD2EJ2k5V/xhUw
 WTRgHz/o722JC44dplg0haC0/Uz7zr5vMxzp/V0wcpITy8LSvUnnVOFUZakJaRjhoLeW
 o2Vg==
X-Gm-Message-State: AOJu0YxrpBETGQz1ems08Jdr5zRU71wGMMV/Ut/OJOmaMBpFttzk4vnF
 NC3+5MNfnaDDlIEuqgcWIJ1rkhbCbfI8l+WHQmLmIVtgclTbGZei+lFG8uOsTFm2ypOSuUrlOrH
 hjcDZyykwfjttqSk9CXY6plU+WVuzVIHaEe8o3PM7KCIrMpKpLzQDwav+qeE5gf6bLKHoZ5OH83
 wp69lowjvYqRHWLuVjRLBLQ51lsrSylSiM1jrfo6E=
X-Gm-Gg: ATEYQzxvjmmIOYmtjBeLN7Y0H4gErt9DTUV0DIKsB6hmSF40ieueF+NtkNaOJ6AyPPB
 8eu8du1+qDxf04WHkLnTyaXSJNbN5ahyWHdmxUDe79b00P2bYnh7QlcR1a3r/on3Q9jL8YyWGzf
 AqnOecYiGckaNFRp0BXoCIgl7uR0wPHqE+xCyBK9zM6y22y5vRugjDYN0nMY4H58NvLaFBQG7s4
 ABK90qTfqqfsCxn52IdRJbuVP2re7eTuuW02gXiIzXpdOZ/A9QYmCs4CGm1vnXse7qHMNkK54mX
 sG7JPhKHValTBUe+cfYnEyuLxYmhZ5QA+Bhg7twgVfgmbtD/4HYFS5pQA9w/CSgoW2oUDoYR0Ov
 K6UXPKHkklPgwDpmfZAMQEK+TWVDtXRwJBGQn8PTh0X2WnUBXktFo66c5eEZaIg==
X-Received: by 2002:a17:902:ce12:b0:2b0:692d:78bd with SMTP id
 d9443c01a7336-2b06e4307aamr66616795ad.46.1773928427983; 
 Thu, 19 Mar 2026 06:53:47 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2b0:692d:78bd with SMTP id
 d9443c01a7336-2b06e4307aamr66616415ad.46.1773928427488; 
 Thu, 19 Mar 2026 06:53:47 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:47 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC v2 5/7] test/qtest: Add test for tpm crb chunking
Date: Thu, 19 Mar 2026 19:23:14 +0530
Message-ID: <20260319135316.37412-6-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319135316.37412-1-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
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
index 2cb2dd4796..dfc1fd70b7 100644
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
+                       ? actual_response_size - i
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


