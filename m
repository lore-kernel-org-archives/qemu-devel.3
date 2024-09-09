Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A5EECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snelK-0001Hz-UM; Mon, 09 Sep 2024 09:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelJ-0001Gz-Dp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:49:01 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelH-0000BO-O9
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:49:01 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d889207d1aso3032471a91.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725889738; x=1726494538;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMsMrxXIYF55uyEUpAg6oCulZa95qOnP3qJj8dOgMPY=;
 b=IbKr5iGaW1qjWCkggXFfb+BdX2kIT3hpuw1bkP1rPMG3VFR1kyO4bkWagFEaZOMAE5
 N9kO4xtnJ3K7yEUkxgIwt1Mr5smbs4Cuq4Wh+FceHLe36gOBclLVJYMHF/hHvp0fRuq2
 vntalflTHlxbL2ccQJMMYSczKMCblYcPw74xGeHMqwAKZkybRskiy4e7yXhL/SF7dNM6
 jWUzdX3RwSPvkU9Jc2Umu71Uw3SybbCoXj9eosa8b1kD55pnGcswH7hCVTsei960+U18
 E0owFhgwJm6SqhYW8cp50OMMrA6U+7j2iprGclM/QYe1bUlU5itYjjTYY1KM2f7jER/6
 CcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889738; x=1726494538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMsMrxXIYF55uyEUpAg6oCulZa95qOnP3qJj8dOgMPY=;
 b=QH5ZUQTC96eS5WZkR+S4HQNdMeGKDmzBpZdvzZ9VJ9Nds9W6WaRhNHsttduGl9k4L7
 zmFIreDR20kdYjErKCjx856HT6GcdTLSe6t9cNDjcVPj4rodVn5rWl4XmrnqFDZkjgem
 20aqdaqCesk5qPpDUMrY1rKY+kJbVDs4VEAGRJBxSOVcVRqppsccngUKPJigfvwU4v61
 5zuJrsO8DJUDvY2ZomQTzDyjVXRiG8H0DSuy7ugrinJFxj/69yrDLs+IXz0/JUyriglg
 MxjPlhfks2MyqfkHwlqnDHlXQXAF0tfMCuaewcrElNsshzbowJPG6HbRPwomBPVASv+R
 ScyA==
X-Gm-Message-State: AOJu0YwqXO41aru9xliN04vcb1HptUw+/1Kr/+m4y8fVth80vHazlnKa
 SWBMe9iNhT1GedxC7K6/cuk6dDF/r8qom+da/dm+EfEWe5nGclmS//qrKmHnTo1D3OytPuX6QO+
 h2JAcEA==
X-Google-Smtp-Source: AGHT+IGWssGLJxaQvufb3+G0ZMuSFcehCGYuez6+lG2DAJf+A2X7zxCL5AVHfTCkM8Cx3rDYBrx2/Q==
X-Received: by 2002:a17:90b:384e:b0:2cf:cbc7:91f8 with SMTP id
 98e67ed59e1d1-2dad50fc904mr10048579a91.19.1725889737002; 
 Mon, 09 Sep 2024 06:48:57 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dab2c6b0b9sm7841031a91.0.2024.09.09.06.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:48:56 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 07/10] tests/migration-tests: Add test case for periodic
 throttle
Date: Mon,  9 Sep 2024 21:47:19 +0800
Message-Id: <8903506e56f2c1d36cb83b54fe4875a1253b7691.1725889277.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725889277.git.yong.huang@smartx.com>
References: <cover.1725889277.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To make sure periodic throttle feature doesn't regression
any features and functionalities, enable this feature in
the auto-converge migration test.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/qtest/migration-test.c | 56 +++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 2fb10658d4..61d7182f88 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -281,6 +281,11 @@ static uint64_t get_migration_pass(QTestState *who)
     return read_ram_property_int(who, "iteration-count");
 }
 
+static uint64_t get_migration_dirty_sync_count(QTestState *who)
+{
+    return read_ram_property_int(who, "dirty-sync-count");
+}
+
 static void read_blocktime(QTestState *who)
 {
     QDict *rsp_return;
@@ -710,6 +715,11 @@ typedef struct {
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
+typedef struct {
+    /* CPU throttle parameters */
+    bool periodic;
+} AutoConvergeArgs;
+
 static int test_migrate_start(QTestState **from, QTestState **to,
                               const char *uri, MigrateStart *args)
 {
@@ -2778,12 +2788,13 @@ static void test_validate_uri_channels_none_set(void)
  * To make things even worse, we need to run the initial stage at
  * 3MB/s so we enter autoconverge even when host is (over)loaded.
  */
-static void test_migrate_auto_converge(void)
+static void test_migrate_auto_converge_args(AutoConvergeArgs *input_args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     MigrateStart args = {};
     QTestState *from, *to;
     int64_t percentage;
+    bool periodic = (input_args && input_args->periodic);
 
     /*
      * We want the test to be stable and as fast as possible.
@@ -2791,6 +2802,7 @@ static void test_migrate_auto_converge(void)
      * so we need to decrease a bandwidth.
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
+    const int64_t periodic_throttle_interval = 2;
 
     if (test_migrate_start(&from, &to, uri, &args)) {
         return;
@@ -2801,6 +2813,12 @@ static void test_migrate_auto_converge(void)
     migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
     migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
 
+    if (periodic) {
+        migrate_set_parameter_bool(from, "cpu-periodic-throttle", true);
+        migrate_set_parameter_int(from, "cpu-periodic-throttle-interval",
+                periodic_throttle_interval);
+    }
+
     /*
      * Set the initial parameters so that the migration could not converge
      * without throttling.
@@ -2827,6 +2845,29 @@ static void test_migrate_auto_converge(void)
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
+
+    if (periodic) {
+        /*
+         * Check if periodic sync take effect, set the timeout with 20s
+         * (max_try_count * 1s), if extra sync doesn't show up, fail test.
+         */
+        uint64_t iteration_count, dirty_sync_count;
+        bool extra_sync = false;
+        int max_try_count = 20;
+
+        /* Check if periodic sync take effect */
+        while (--max_try_count) {
+            usleep(1000 * 1000);
+            iteration_count = get_migration_pass(from);
+            dirty_sync_count = get_migration_dirty_sync_count(from);
+            if (dirty_sync_count > iteration_count) {
+                extra_sync = true;
+                break;
+            }
+        }
+        g_assert(extra_sync);
+    }
+
     /* Now, when we tested that throttling works, let it converge */
     migrate_ensure_converge(from);
 
@@ -2849,6 +2890,17 @@ static void test_migrate_auto_converge(void)
     test_migrate_end(from, to, true);
 }
 
+static void test_migrate_auto_converge(void)
+{
+    test_migrate_auto_converge_args(NULL);
+}
+
+static void test_migrate_auto_converge_periodic_throttle(void)
+{
+    AutoConvergeArgs args = {.periodic = true};
+    test_migrate_auto_converge_args(&args);
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
                                               QTestState *to,
@@ -3900,6 +3952,8 @@ int main(int argc, char **argv)
     if (g_test_slow()) {
         migration_test_add("/migration/auto_converge",
                            test_migrate_auto_converge);
+        migration_test_add("/migration/auto_converge_periodic_throttle",
+                           test_migrate_auto_converge_periodic_throttle);
         if (g_str_equal(arch, "x86_64") &&
             has_kvm && kvm_dirty_ring_supported()) {
             migration_test_add("/migration/dirty_limit",
-- 
2.39.1


