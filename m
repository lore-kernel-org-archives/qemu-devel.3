Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0CCC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3b-0004i5-T5; Tue, 28 Jan 2025 08:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3N-0004a4-Vg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:03 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3J-0006bB-F3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:55 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so38154805e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072491; x=1738677291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Js4tcXY+4Im8Bd7IwohrqklQy95jFm8lPyjSB87jskE=;
 b=f6CYeyWGo5k2AY2zrIcK4hr9B5p4LWdHxiUsS4ERRIScORrQFPOdYKrCsypK739oOR
 NekkF+IcC2cfPTlo2WGUd5dKcxoQ73TnrsUlJ4Vrc0q6e+6l0J6oV1n86i2HMn434QSP
 j/IB+WpcUnrjzdmmjfA1u2hWYmBSfBmcSgUJ98sfgDAcfwAydQaBUKAsI1CtFe+X9XG+
 63umuBXtNUwoRrghSVv0b3yj/wVtyEIoe6PKWQjGYOlaERzGf3TZ30Uji+I5JiMiecZg
 nkJjC+WrF7/dC8PRurFw/Y9hsS7D+tS/ZVaxtSLJlpgmRcWOE2Ox8WSFNAmDsbKLcDfn
 wLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072491; x=1738677291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Js4tcXY+4Im8Bd7IwohrqklQy95jFm8lPyjSB87jskE=;
 b=mOX5JcoFyKrv0jPGzHgmnADxfr89CteAFE4y/vH+6jqRJOk7sbGwM6xkc7k+IsVUu7
 vemh592Wg8BFcrRhJvzOksv77TI00wMunQq3MoP6AwwbUv2UAjr8zZ+lTfUBwunk5y+T
 RLCvMCd2sDfyzrSOyUZ4nbQmc0lQx8jM+ps+SQZua8ArYZzvFYFTtv4DHshMHKZs0FlT
 qLgaWzxZH2DzKVHmRKiWzY4RNWbt/zzksh80afjnf7m2JXuaLWjBnzEhNKNpXSxYGZvc
 2j8PLesVgyF86EZqBSuk6UAvC8UV4JdRG4g6LiHGzMr0xWmvHA4k4fz2/kHzfPSvWGli
 8V8g==
X-Gm-Message-State: AOJu0YzgLywAXc8ygC9WVE7mtKyhvViqyYWblex0g7SKNWWtJhlMF7Gc
 K3LDlFWau5FkOM69OmhE3PYAfhr59CfOjM26W6iDY7FeX2VdeQ2dA5mCeEtB7yezB0ysLiMMIm1
 CzNE=
X-Gm-Gg: ASbGncsE/ClF8Xifr3BTqo9h7bg1aMaPYSv6KD0QgrlGa48U0FYCDASBf5S6jf4bPNY
 sG4VNgXmqM9s1B9KgAgm86njYITC2ue+g/+zj/TzO+DExT13/FM9sQIcd+AntAzyOUiJ5lxqgfN
 cUHfKb7G2FH2n+1dUZ8TOUTPSY1XCwuWg2iVBOMfbzyyZAA3gFtSbw5aF9mlHcHIp1Iaphhe3Cy
 RYJzaFlY8bHQGB4mDb2KvJ+Cz/KTo1GTvc61V27uiNtF0CVgGj/URTiuem8JLsJ9ZH5AYZ1cIK+
 PsGd4awNuKW82IB9ymXh0IQxAkKnb1DDTKUCbEVp/hjW9wMAoh0bEWXZsQZYOvPOew==
X-Google-Smtp-Source: AGHT+IGSNtpfXCfe8dFXbxfxieTzWgmRhuWBqqoUaz0qfcTjqs3qWvQKGQNy9lJrfBfPrZaRLI1U5A==
X-Received: by 2002:a05:6000:cc3:b0:385:f47a:e9d1 with SMTP id
 ffacd0b85a97d-38bf56852bdmr28927870f8f.17.1738072490848; 
 Tue, 28 Jan 2025 05:54:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb057sm14374562f8f.62.2025.01.28.05.54.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:54:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] tests/qtest/migration: Pass accelerator arguments as
 machine option
Date: Tue, 28 Jan 2025 14:54:26 +0100
Message-ID: <20250128135429.8500-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The '-accel' CLI option is handler as sugar property as
'-machine,accel='. Replace the migration tests command
line, only using the best accelerator available (first
hardware, then software).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/migration/framework.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 38a0a1a5264..e567296b014 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -214,8 +214,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const gchar *ignore_stderr;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
-    const char *kvm_opts = NULL;
-    const char *arch = qtest_get_arch();
+    const char *accel_args = NULL;
+    const MigrationTestEnv *env = migration_get_env();
+    const char *arch = env->arch;
     const char *memory_size;
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
@@ -296,8 +297,15 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
             memory_size, shmem_path);
     }
 
-    if (args->use_dirty_ring) {
-        kvm_opts = ",dirty-ring-size=4096";
+    if (env->has_kvm) {
+        if (args->use_dirty_ring) {
+            accel_args = "kvm,dirty-ring-size=4096";
+        } else {
+            accel_args = "kvm";
+        }
+    } else {
+        assert(env->has_tcg);
+        accel_args = "tcg";
     }
 
     if (!qtest_has_machine(machine_alias)) {
@@ -311,14 +319,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
 
     g_test_message("Using machine type: %s", machine);
 
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
+    cmd_source = g_strdup_printf("-machine %s,%s,accel=%s "
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
+                                 machine, machine_opts, accel_args,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
@@ -332,15 +338,13 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                      &src_state);
     }
 
-    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
+    cmd_target = g_strdup_printf("-machine %s,%s,accel=%s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
+                                 machine, machine_opts, accel_args,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
-- 
2.47.1


