Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EAEC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3N-0004Xi-IJ; Tue, 28 Jan 2025 08:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3A-0004VD-7A
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:45 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm38-0006ZY-Iu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:43 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so3220240f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072481; x=1738677281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OqktqB1rxHpsEBpE3GI7u9cs3EXThVaOGL6hvU5oq0=;
 b=QdTFiorpnz4xoVyrlqvbL0rCTvbLC3NbggRrQwpnwt9+7ebnRwUBWJigMmP/CHvUVV
 2usHeWa1EGHOOMTqTJsO2xVc9e9J/lhZ20QVKmxm4jQ5c8LaYO0Pl/PYI+QmeIXFzT2x
 CKJ/8znJb6wWG++Fy+bQVK2I9fWqwB6nmJwns8DDu91FssSSgolGYy7U3QjEYnDEcm0C
 Yp6bE1UYwTe01bLtJ2fLBuou95gOeY/q84kKoeBzuva6pGjANMOIadUrdgpecQ+uzXKy
 y+7pMuZqVd5YRWG8nloJ/gWJMTlyz9TqCGM525IyOWjjuTA54V6IquynPGLIFBR/fipE
 yI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072481; x=1738677281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OqktqB1rxHpsEBpE3GI7u9cs3EXThVaOGL6hvU5oq0=;
 b=YtH625zOe61r9UpkerGYqZJPK3/yIvPIjIkZH0I6rs6irofjQ2D+nXe6zQOhE6u+yv
 vbD5HB79VtbZkaz11c32kw07vQXxtu8hiNbh/mMjUEYh4fR8/hc/ks0PU9S9Muodt5ig
 hHtJhReyYq3h7cHRdz39Kmv/zCpbMF2JolizY9sVoWKftDsXn1bUoAjqT1R8YZJ8QyLk
 4KjBx9RIMUtYheDQvcSNti37zKimC3W5d1ckjqLjBI5m/A7a4+qLIoNwn4LeYjdvB0tf
 Ny2pPb+M4V039C89UE+PDwFHGuMlQTliK+ZOkJdFELQCZjrysn38Ewh57e6gK07WUAHi
 3Kyw==
X-Gm-Message-State: AOJu0YwYOmeP7Fd8SZqDyDTJaSJ0nBtcMJIEDaYYsuagknTZzptmnTn4
 n93kXdIgn6ufTH+V6JepO0HowqywOcTWWUIyKSu4d6xR62+YTDXmsDv3hLI8aXxmTt81St10rPS
 Gqco=
X-Gm-Gg: ASbGncsb4koew173mNDk2OvvRzHmBS8DmjNoeOaBR7gn6nmKSmix7fy6ZoEbvMDJH2O
 3xaxnxwJEbcya6dl9dKe9FTrQfUqRMMpP19125TyQxH+lOWQMS4iawjnTKqs/ZR/9O/0sGzpsGp
 yPJtwwhdCUrESSDO8XwdhJom+NcRhCAGMU6YMYQXDDXm6E0kKyDAL2dgihZ9WhOexSP9OK0PiMS
 8Y7nuACb9iFNB0OcqdZzpAZxNSRCbpi6/9q5JKeDMjHKgl6npaX1yw8sgy2GArcKVFcXdI0zRuu
 Q2yW1tC5/OAkxpd0DMvrjPizWs9vQ0ol5zcl5Gs196x8EkibnBFaAuFp09O/nJIdIg==
X-Google-Smtp-Source: AGHT+IFPyEpMlGMTXs6HfcBqLlnki84bRZf617fpYYAcbcHARWj7MLspbW+kvULKg0jfVY1MiFvUVw==
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38bf56555f4mr37657628f8f.5.1738072480797; 
 Tue, 28 Jan 2025 05:54:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c3ec83e20sm7499727f8f.23.2025.01.28.05.54.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:54:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] tests/qtest/migration: Make 'has_dirty_ring' generic
Date: Tue, 28 Jan 2025 14:54:24 +0100
Message-ID: <20250128135429.8500-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Keep accelerator knowledge limited within MigrationTestEnv,
expose a generic %has_dirty_ring value, only checking for
KVM when initializing it in migration_get_env().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/migration/framework.c     | 2 +-
 tests/qtest/migration/precopy-tests.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4550cda129c..a3bd92a9519 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -946,7 +946,7 @@ MigrationTestEnv *migration_get_env(void)
         return env;
     }
 
-    env->has_dirty_ring = kvm_dirty_ring_supported();
+    env->has_dirty_ring = env->has_kvm && kvm_dirty_ring_supported();
     env->has_uffd = ufd_version_check(&env->uffd_feature_thread_id);
     env->arch = qtest_get_arch();
     env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 23599b29ee2..8dcd0ad2660 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -983,8 +983,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
     if (g_test_slow()) {
         migration_test_add("/migration/auto_converge",
                            test_auto_converge);
-        if (g_str_equal(env->arch, "x86_64") &&
-            env->has_kvm && env->has_dirty_ring) {
+        if (g_str_equal(env->arch, "x86_64") && env->has_dirty_ring) {
             migration_test_add("/dirty_limit",
                                test_dirty_limit);
         }
@@ -999,8 +998,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                        test_multifd_tcp_no_zero_page);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
-    if (g_str_equal(env->arch, "x86_64")
-        && env->has_kvm && env->has_dirty_ring) {
+    if (g_str_equal(env->arch, "x86_64") && env->has_dirty_ring) {
 
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
-- 
2.47.1


