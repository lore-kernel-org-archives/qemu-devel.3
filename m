Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966B0F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kn3-0004g6-HD; Mon, 06 Apr 2026 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kn1-0004Nq-2m
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmy-00056t-Rj
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsZ0r9k1iqZjmeQjH/H2Bi1lOvYyfsSHjj2hxULrQkQ=;
 b=GnK3uGcXkAMtYpuSGiERrodjkL6goOsTVQGqVjY0VPXe/TLmoiT6cfgKIhFFH0TKvwwt9M
 HZxkhHCFUQDkH6R4Xdcsu5NoRyuCkUOcpG7WcXP2mV3auWyRrXnXrvfbPBQs+xztklS7i2
 5lkG6AgShwGR3Ibf834I458+di/4Cu0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-RQ9sWMOGOy2UL_fmva4Wcg-1; Mon, 06 Apr 2026 10:18:50 -0400
X-MC-Unique: RQ9sWMOGOy2UL_fmva4Wcg-1
X-Mimecast-MFC-AGG-ID: RQ9sWMOGOy2UL_fmva4Wcg_1775485129
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2454fc131so71220185ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485129; x=1776089929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsZ0r9k1iqZjmeQjH/H2Bi1lOvYyfsSHjj2hxULrQkQ=;
 b=KhWBD/J0Sqis0Ijiag1To/c/2IeSS9RL5RwHfVJpYg786kSA7CJGhICWk5G/4663yG
 S5Yh6BKMwPaU32KKJmzL1U2RHSx4Yd3go4L7ixG3FaIvld7BaaE+39+ZDb20TmiZKP0F
 yZewzVdIrG8EUOCv18orefl7AtkmAkyxes7aeUtJ/0RMM7x1OHVLK+KYLpBNvywXKrr9
 bEI8fYijD6OgE9Zw5OjoINRlQ+1pkhyVjHogshm7raxJlIs15c5hLNMhz5BGMcaenpKq
 8Bd7ocUHjB+ig/hA+M1wezLd98VVYoYu45JwB/CJE2Ig24Q0bNY+zmWp96eVjB24ndcJ
 ibQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485129; x=1776089929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FsZ0r9k1iqZjmeQjH/H2Bi1lOvYyfsSHjj2hxULrQkQ=;
 b=XNJ4+ggrgnejHcR2XLIwAlEYRf4lvHtq9d78tH8tzKkmQV3gupgjQOMYWxgeZAii4X
 BbKfeDeAo+pEunNeX9QuRtsx96d7fnXSiBlccI5pKYo5JIn6XxziXimN2+izTBaL6DYw
 Dz1M7OEUhbRjQlebbuU+lb+b55lu+p/ReClVNPNBwnRRFaXvlTmRj90pHQKBWmMrMLGs
 XZS6sqhKhrAdTz3OkTaaB53JUIHuOUHSbKeFI0YU6vcS+tlVXXrA1zNKPuj/0m3QhPXV
 mT2AdJ2ja+NNA6gulco9p0Lfi7bFc41+x9oNCP8dGpNXUk9GBSPzw1OAa5KUei/eo6t2
 /Sfg==
X-Gm-Message-State: AOJu0YwvdUJJpTOFKu1JFSAwlLvHCx8Pfkh349PQ6UUD8LbDlDr24VpQ
 vORIu/LXaO3lv8xQMzMNogODMeDziEGFNPx/+k9G52CKV3JVkCXnBeTqFkcA8HOiWkayyqdrswo
 gh0Z/ibDbfyJHlhT/ix/M/J6oNiyunxdHllw7VQB/0gnLDW38hWjyLw1Z764dzQzvKD7rfT2x4t
 iQiEbg7UUxXEOZ0jsB4qy7WJzw5XRScmlfPLRAjiM=
X-Gm-Gg: AeBDiev6J0kS+XZqxRzjMki6bnhaLPT9dRwbT1/2/uy6ZfDW5d2MmMQFgz/rrtbmLc8
 EgI4PhwJNiYXSJHPHV0GaJ5xDNroAggNBRNz7FVZubljWbYf570GE990WqkIv3ZgUTKP/x2xI+B
 Jk+8g5u5PdmpUxNW705d6oWBjooJMrkfKL/YjepBwdsS480VQf+QN9D3eG/Axq9YzjuZZXK3xyv
 CsLGvVwPwPdZ+DZsqPP6bFS03iEzCRNZYNH6NEzDmWEfwbMcPhFzhfN131zNX+U3+ze2ZIMjhSr
 On1P8stsR3vhUWBBvdtiRbyBtXOU44uc2TLjV7l5hiQkd6+2t5Vfb98maSaUHqFb6200Ktv5ihI
 oDxKOozslS4r+bMA6CKAJdP/PMM7+dyYhw2nBLCpjr2NXbYNTsjwajzilJJaJuZBgoro=
X-Received: by 2002:a17:903:1248:b0:2b2:5857:601c with SMTP id
 d9443c01a7336-2b281888579mr136946185ad.18.1775485129215; 
 Mon, 06 Apr 2026 07:18:49 -0700 (PDT)
X-Received: by 2002:a17:903:1248:b0:2b2:5857:601c with SMTP id
 d9443c01a7336-2b281888579mr136945655ad.18.1775485128537; 
 Mon, 06 Apr 2026 07:18:48 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 08/10] tests: Use ML-DSA-87 operations to caused large TPM
 transfers with CRB
Date: Mon,  6 Apr 2026 19:47:33 +0530
Message-ID: <20260406141735.25844-9-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Stefan Berger <stefanb@linux.ibm.com>

To test large data transfers (receiving and sending) that make us of a CRB
chunked transfer, create an ML-DSA-87 key and sign some data with it and
receive the 4627 bytes signature. After this send the signature back to the
TPM to have the TPM verify the signature.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-crb-swtpm-test.c |  5 +-
 tests/qtest/tpm-tests.c          | 96 ++++++++++++++++++++++++++++++++
 tests/qtest/tpm-tests.h          |  4 ++
 tests/qtest/tpm-util.c           | 37 ++++++++++++
 tests/qtest/tpm-util.h           |  2 +
 5 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index 050c7b0c1f..541fd58133 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -37,8 +37,9 @@ static void tpm_crb_chunk_swtpm_test(const void *data)
 {
     const TestState *ts = data;
 
-    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_chunk_transfer,
-                        "tpm-crb", NULL);
+    tpm_test_swtpm_large_tx_test(ts->src_tpm_path,
+                                 tpm_util_crb_chunk_transfer,
+                                 "tpm-crb", NULL);
 }
 
 static void tpm_crb_swtpm_migration_test(const void *data)
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index f71d882990..21811f3a2e 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/tpm_util.h"
 #include <glib/gstdio.h>
 
 #include "libqtest-single.h"
@@ -130,3 +131,98 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     g_unlink(src_tpm_addr->u.q_unix.path);
     qapi_free_SocketAddress(src_tpm_addr);
 }
+
+void tpm_test_swtpm_large_tx_test(const char *src_tpm_path, tx_func *tx,
+                                  const char *ifmodel,
+                                  const char *machine_options)
+{
+    unsigned char signature[2 + 2 + 4627]; /* TPMT_SIGNATURE */
+    unsigned char response[8192];
+    unsigned char request[8192];
+    SocketAddress *addr = NULL;
+    GError *error = NULL;
+    char *args = NULL;
+    GPid swtpm_pid;
+    QTestState *s;
+    gboolean succ;
+
+    if (tpm_test_swtpm_skip()) {
+        return;
+    }
+
+    /* Large transfers based on ML-DSA operations required default-v2 profile */
+    if (!tpm_util_swtpm_has_profile("default-v2", "ml-dsa")) {
+        return;
+    }
+
+    succ = tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, "default-v2",
+                                &error);
+    g_assert_true(succ);
+
+    args = g_strdup_printf(
+        "%s "
+        "-chardev socket,id=chr,path=%s "
+        "-tpmdev emulator,id=dev,chardev=chr "
+        "-device %s,tpmdev=dev",
+        machine_options ? : "", addr->u.q_unix.path, ifmodel);
+
+    s = qtest_start(args);
+    g_free(args);
+
+    tpm_util_startup(s, tx);
+
+    static const unsigned char tpm_createprimary_mldsa[] =
+        "\x80\x02\x00\x00\x00\x38\x00\x00\x01\x31\x40\x00\x00\x07\x00\x00"
+        "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00"
+        "\x00\x00\x0f\x00\xa1\x00\x0b\x00\x04\x04\x72\x00\x00\x00\x03\x00"
+        "\x00\x00\x00\x00\x00\x00\x00\x00";
+    tx(s, tpm_createprimary_mldsa, sizeof(tpm_createprimary_mldsa),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 2831);
+
+    static const unsigned char tpm_signsequencestart[] =
+        "\x80\x01\x00\x00\x00\x12\x00\x00\x01\xaa\x80\x00\x00\x00\x00\x00"
+        "\x00\x00";
+    tx(s, tpm_signsequencestart, sizeof(tpm_signsequencestart),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 14);
+
+    /* Complete sequence and get signature */
+    static const unsigned char tpm_signsequencecomplete[] =
+        "\x80\x02\x00\x00\x00\x2a\x00\x00\x01\xa4\x80\x00\x00\x01\x80\x00"
+        "\x00\x00\x00\x00\x00\x12\x40\x00\x00\x09\x00\x00\x00\x00\x00\x40"
+        "\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00";
+    tx(s, tpm_signsequencecomplete, sizeof(tpm_signsequencecomplete),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 4655);
+
+    /* TPMT_SIGNATURE found at offset 14 */
+    memcpy(signature, &response[14], sizeof(signature));
+
+    static const unsigned char tpm_verifysequencestart[] =
+        "\x80\x01\x00\x00\x00\x14\x00\x00\x01\xa9\x80\x00\x00\x00\x00\x00"
+        "\x00\x00\x00\x00";
+    tx(s, tpm_verifysequencestart, sizeof(tpm_verifysequencestart),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 14);
+
+    /* TPM2_VerifySequenceComplete */
+    memcpy(request,
+           "\x80\x02\x00\x00\x12\x36\x00\x00\x01\xa3\x80\x00\x00\x01\x80\x00"
+           "\x00\x00\x00\x00\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00",
+           31);
+    memcpy(&request[31], signature, sizeof(signature));
+    tx(s, request, 31 + sizeof(signature), response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 27);
+
+    qtest_end();
+    tpm_util_swtpm_kill(swtpm_pid);
+
+    g_unlink(addr->u.q_unix.path);
+    qapi_free_SocketAddress(addr);
+}
diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index 07ba60d26e..6993ce40dc 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -24,4 +24,8 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *ifmodel,
                                    const char *machine_options);
 
+void tpm_test_swtpm_large_tx_test(const char *src_tpm_path, tx_func *tx,
+                                  const char *ifmodel,
+                                  const char *machine_options);
+
 #endif /* TESTS_TPM_TESTS_H */
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 24243065c1..6163f5a533 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -209,6 +209,43 @@ bool tpm_util_swtpm_has_tpm2(void)
     return has_tpm2;
 }
 
+bool tpm_util_swtpm_has_profile(const char *profilename,
+                                const char *content)
+{
+    bool has_profile = false;
+    char *out = NULL;
+    static const char *argv[] = {
+        "swtpm", "socket", "--tpm2", "--print-profiles", NULL
+    };
+
+    if (!tpm_util_swtpm_has_tpm2()) {
+        return false;
+    }
+
+    if (!g_spawn_sync(NULL /* working_dir */,
+                      (char **)argv,
+                      NULL /* envp */,
+                      G_SPAWN_SEARCH_PATH,
+                      NULL /* child_setup */,
+                      NULL /* user_data */,
+                      &out,
+                      NULL /* err */,
+                      NULL /* exit_status */,
+                      NULL)) {
+        return false;
+    }
+
+    if (strstr(out, profilename)) {
+        has_profile = true;
+    }
+    if (has_profile && content && strstr(out, content) == NULL) {
+        has_profile = false;
+    }
+
+    g_free(out);
+    return has_profile;
+}
+
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
                               SocketAddress **addr, const char *profilename,
                               GError **error)
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index ca2d7d173f..90790f30db 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -39,6 +39,8 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
                       const unsigned char *exp_resp, size_t exp_resp_size);
 
 bool tpm_util_swtpm_has_tpm2(void);
+bool tpm_util_swtpm_has_profile(const char *profilename,
+                                const char *content);
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
                               SocketAddress **addr, const char *profilename,
-- 
2.53.0


