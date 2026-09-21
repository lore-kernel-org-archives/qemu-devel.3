Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE8BC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8jJ2-0003RO-BZ; Mon, 21 Sep 2026 15:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8jIz-0003Qy-Pj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 15:03:57 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8jIx-0001mX-Jt
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 15:03:57 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b2522so2293828f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790017434; x=1790622234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=op01wSzx++PxzGWlywLCMk6UcO5p6EFFiioUSSIGFPg=;
 b=bmr/U7IjcFfVWppcjG8krUerYCqRaDURBp08stbGl4wsI2MbAn2J5YZqyWcpHy4olR
 r4vOhaP1e+VuqilJtAF0K1vIcnZj6CCWpfAUXyCRsjGdXEOFegBmv+pX5hXGeSI2GKfP
 KKvqs/2AcQgySSDrJRHD+xPoSba39eNt8rVYZXNroN9QH/jcCQRUC7Drz5SFFaL0W/r/
 qqwNcOpYl/D05lisgWrotorHWsDTEQ5EHzpKQBnbqAN3/uCUGvaAxyYUXUiqvkU3bDYG
 MdphD8Q+znXiwLJhYC6T7mym1L+VMr038esUUNwVUrq2owcSRrQY145QicoiYl+VMX6X
 W94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790017434; x=1790622234;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=op01wSzx++PxzGWlywLCMk6UcO5p6EFFiioUSSIGFPg=;
 b=Assos59E8o/qUq26udbabDbTHDKcEf/5Ch3B/bdhe7dWqQ5jEATfB7Ek5iwzBqJEzq
 pFfyW9kwMTzTbGVM47/CPp+7Zo/6aDhWnUUKucJyUcviNu8YJUQ5UoVnIjelJDZp8JUm
 x5YacUacI3ng3oCOovT0lORbWGydPBgicI6b4cr04BWEbARynZxBtTPqzSAcPo+Dv+dB
 cPct9v0JDgYL9bSyRxxq08TIJKEj8nHRmcAUreN7C4CXWD/TH170EaIVqsLxxw05n2je
 gTOwnP5GhiL23Pa73tT453t42NIXr44AJLVuJn2XUKLPY3n0CUs5Br4I78o0BM6jp2mD
 5wmw==
X-Gm-Message-State: AFuF++kamHoBGsTrs0uTB5H0mMH6eW41hQ+DJpKiW3T8+7e6u5UEHXgf
 2b79unJQUTO6im33+if4HCWHb7QYiww3zi9ojg8I1mt4T372W4LnFKK4wOhRsfj4/io=
X-Gm-Gg: AYBFou2o5qvDmYFY1cTO+6+onYxngIbXfOXg8bEKEjbqDWUDL/xngs2EKvld6Ry6owZ
 I+veHo8KoYZP1KCbuQdBbmKWtohd0fa4h2o0OsSDxnFF0vVhnFNeXe/LEDbsdoUNnOXtcNcEoKq
 d5DeLLuQX8mbuNjsDuqzjNhh2ktrmGlwQknUhrsWCFZrmLtz3SL1EgujgbUHt7B4DZmZn9BP7i/
 nrueYg2FgJ+gBpoiAuyMxMDRwxPMv62xUTAFZ0eAfs6F/8QnG03iG+2tvSLcfrA540BE062UCux
 SdTBNhREuexwAK0dh4JT864iVYKCOaNPbE7go5d1r1cFYdQ2Ztu+YKFbz+uUGrz0RQHwv8JW+Fj
 tIt8EeR04qNWDPHgCNRfSDDaEP6FqHMqDsZlj/QYf69oQix8Z8MknGcYLOvM/vagKJ7IBIoPvV9
 cdZLDOZZ7ndacYOuEyVVJtNtce6WeDlpZddVuOIrAPmR/vWNQrhHhHwkp9ETQ19YfuBSwUKfBrV
 N5CtPijdBCYrrpHP9V49Q==
X-Received: by 2002:a05:6000:38f:b0:487:27f9:839 with SMTP id
 ffacd0b85a97d-48727f90af1mr9585316f8f.46.1790017434021; 
 Mon, 21 Sep 2026 12:03:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724460978sm24315770f8f.11.2026.09.21.12.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 12:03:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1BEA5F871;
 Mon, 21 Sep 2026 20:03:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org (open list:nvme)
Subject: [RFC PATCH] tests/functional: add migration diagnostics and pace nvme
 activity (HACK!)
Date: Mon, 21 Sep 2026 20:03:45 +0100
Message-ID: <20260921190345.1709227-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a hacky patch for comment but I've included the diagnostic
hacks to the migration test as well as my workaround to get itworking.

This test was failing on my KVM system. On investigation I found the
nVME activity meant the migration never completed. I ended up
inserting some sleeps into the workload script until I was able to
get it to run.

*NOTE*: obviously this can't be merged as is but I think we could
certainly do with more tracking in the test to see when things aren't
working with possibly the sleep as another patch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/migration.py                 | 37 +++++++++++++++----
 .../functional/x86_64/test_nvme_migration.py  |  1 +
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 8d2428efc24..e51a82c22f4 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -22,18 +22,41 @@ class MigrationTest(QemuSystemTest):
     timeout = 10
 
     @staticmethod
-    def migration_finished(vm):
-        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
+    def migration_finished(query):
+        return query['status'] in ('completed', 'failed')
 
-    def assert_migration(self, src_vm, dst_vm):
+    def wait_for_vm(self, src_or_dst, vm):
+        "Track the state of one VM in the migration"
+        current_state = last_state = vm.cmd('query-migrate')
 
-        end = time.monotonic() + self.timeout
-        while time.monotonic() < end and not self.migration_finished(src_vm):
-            time.sleep(0.1)
+        self.log.info(f"waiting for {src_or_dst} to complete")
 
         end = time.monotonic() + self.timeout
-        while time.monotonic() < end and not self.migration_finished(dst_vm):
+        while time.monotonic() < end:
+            if self.migration_finished(current_state):
+                break
+            else:
+                last_remain = last_state['remaining']
+                current_remain = current_state['remaining']
+
+                if current_remain > last_remain:
+                    self.log.warning(f"slow migration {current_remain} > {last_remain}")
+
             time.sleep(0.1)
+            last_state = current_state
+            current_state = vm.cmd('query-migrate')
+
+
+    def assert_migration(self, src_vm, dst_vm):
+
+        self.wait_for_vm("src", src_vm)
+
+        # if we hit this we never completed...
+        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
+
+        self.wait_for_vm("dst", dst_vm)
+
+        self.log.info("checking everything is OK")
 
         self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
index 890f0aab6d6..58596f63cd3 100755
--- a/tests/functional/x86_64/test_nvme_migration.py
+++ b/tests/functional/x86_64/test_nvme_migration.py
@@ -109,6 +109,7 @@ def launch_source_vm(self, vm):
                 rm -f /tmp/test_nvme_mig_workload.iter_finished; \
                 echo 3 > /proc/sys/vm/drop_caches; \
                 find /usr/bin -type f -exec cksum {} \\;; \
+                sleep 0.3; \
                 touch /tmp/test_nvme_mig_workload.iter_finished; \
             done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &",
             prompt, vm=vm)
-- 
2.47.3


