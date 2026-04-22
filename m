Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C98F9B60C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrh-0006pD-0O; Wed, 22 Apr 2026 06:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUre-0006ox-Nz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrc-000748-AO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oB2qQatP86NDHo/fOW4g+asa3pzyhpj3nK6Gfp6npWc=;
 b=It/SdsLej7xrK7ix/JtRUUStxOaTRICrI0JH1xTIlINgWCE800sEdM/AM9vnrmCLoDtpoW
 boM1OhEIOPIteemSHwxmy1Lx1yWUXTgZyES8G9ouw9sKJp/th/rpe2U3FHFUfFHmTVi23n
 BQKYsDS7YbS5yOzsa4UvuL9IXjEWQyk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-D__6adXPM6CSdjbWf2Damw-1; Wed, 22 Apr 2026 06:31:21 -0400
X-MC-Unique: D__6adXPM6CSdjbWf2Damw-1
X-Mimecast-MFC-AGG-ID: D__6adXPM6CSdjbWf2Damw_1776853880
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c7ada7b25f0so45838a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853880; x=1777458680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oB2qQatP86NDHo/fOW4g+asa3pzyhpj3nK6Gfp6npWc=;
 b=fZsL8P1IgXszNEoEzBGduD1DHwW0tEejqQoLLVjWR+jnC/aU1L2TZh6gL3XE+Rim55
 HckXJfZtxSgvGIRL7NBtXkLvRRlddx8qaG0nuJDXurQPxfDWONYfLoKNkK+IHXtEasfn
 bsTajbbvNmntK1Aw3beVyPlOknfMygogKcwTIITMhA1nlvohwVxhKiNZtekyzpLud9NO
 OaSWZ4FWpkr46R7Mgyid6sU70ouw28GYnSbtKUKobL9HctouyIwh4R5ZLIiuf85NDOVn
 PUNiJtUMs51D4uo4vw90/J7HhxWaDbKOlfOsmHsyb+8OaejqQ9Gg6x/o9saNB9ZYHpci
 a8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853880; x=1777458680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oB2qQatP86NDHo/fOW4g+asa3pzyhpj3nK6Gfp6npWc=;
 b=Ivv4uMvb0WQJaq1jaqJGjAKeDVLSN4yPN/PaZraL39avLN9iMqdqfldhRHw+x9z3ss
 V13CcIaqPpE3HZDo62FMqavKBmTOzTqULpQe6mJ3SFAppPfS5R3MRZB9oO3Y81MrrmF/
 9HQqG/0mczbJRJU+Ksidqi1YxDyyCnI7gtKB6ZV4NgwqaPA+9Vrdz4ppJ2mitH4+v5uO
 06vnx4XNTbk9ZarVg0AL8prSYRdbavaZ/FWxWw+6jBEuR5hfkYDlAaxcKJjsuwpw7aQZ
 iOWpyqEVmth6BmFdRCc7ive9vGaUu9E/8FXRdc6IgsWjNbnZf9QFV7SttO01FD5O1S7Y
 KlZg==
X-Gm-Message-State: AOJu0YxO+6DZ/V73Eit/rR9bUrIs5jYMOInLrK9M7YZ8Ka5PVtJUHYT9
 d1TddTgHeWYyADz1ut5giPjqR6KBEGCd6Sphh2N22+BlzFIgjjHUs+WakqY7eazoJ9ida04/mnB
 1ZG8+kAa7fEA4z7oe3mBQZKgbGPKBmdKQ96UpY8z2jQ5Q+4dNOHwPW6Q7z+J/P82wZa9Zq9RrV/
 OAazvCSWpgoZ9F2BAt1tek5mIj+DuWiR6dFqzzRiM=
X-Gm-Gg: AeBDieswH2HGxDeEE2ryMOpuUO3nR00nCC0CNTJKyu1fUuzTS41GN5gbF4RpUCoxq/O
 Nyq8idvHE0u6Pi/7Fnodh3SjB1xlUTnQCrmK8Uww4j8zYqOoYdPIEHUc6T+TnV1YoKP5kUfokiJ
 rAJKWh4jDOlCxfyXykKWvW2K/IbuVoXmMzEI0zynumw7rRn4oSebGGjXgXZjwS/SG3J1tcSTn7p
 Fm5Q2SlO5OvQfM7e164iYirdeqDtalkwBPV97JgaEZKqEzABLjZWwbzgkyEu6T1JvNEHtG4eQ7W
 UhfXSiYCxqCJwn5L+rejtizFoFf+dJB1MmY2wODMm9/pydh8JaqbqzzSH1oBEbUFQrCX/bqrCL3
 iq85+F2ZeXdGyrTuw/zYTei27UUkrikJcDAFuYsBwdb2sPWR9qhm7FpXsdw4XpKWbvwuz7c/5Ng
 ==
X-Received: by 2002:a05:6a20:a12b:b0:3a2:d79c:4161 with SMTP id
 adf61e73a8af0-3a2d79c44a2mr13037933637.47.1776853874782; 
 Wed, 22 Apr 2026 03:31:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:a12b:b0:3a2:d79c:4161 with SMTP id
 adf61e73a8af0-3a2d79c44a2mr13037881637.47.1776853874086; 
 Wed, 22 Apr 2026 03:31:14 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:31:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 08/10] tests: Use ML-DSA-87 operations to caused large TPM
 transfers with CRB
Date: Wed, 22 Apr 2026 16:00:16 +0530
Message-ID: <20260422103018.123608-9-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

To test large data transfers (receiving and sending) that make use of a CRB
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
index cbba5b1c1f..ad4325aade 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -211,6 +211,43 @@ bool tpm_util_swtpm_has_tpm2(void)
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


