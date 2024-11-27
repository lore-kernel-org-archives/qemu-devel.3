Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0B8D6ACFC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMmt-0006Xc-Rx; Wed, 27 Nov 2024 13:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmr-0006Wr-IK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:17 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmo-0001sn-PF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 322C41F38D;
 Wed, 27 Nov 2024 18:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBCvztvUbenC9z2xswAHK4jfRX0cPvJ+x4DpZWLwITY=;
 b=NA2JvyrWq+8A8Spep8cLOV+it/hBMd2lmfR92kMzxATR2B2/das9jJcCuDr1Hchm7Nejc/
 uFJjk3xJPIrK0i1l5WaaDOq4KH03ePZqQMZlfZhhgpov3Jtd2Lp1B+f8BNT4nDLeR8uVo1
 j0itaVZEK4rHq0tcclzn92PY0hCgGmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBCvztvUbenC9z2xswAHK4jfRX0cPvJ+x4DpZWLwITY=;
 b=t+AVoP5xrWpNabFg40DubNWR5uMdo1ZXa6fus1MAZPLLmOJrUxcxBSvKYZiyID6mn0Pc0d
 r3MAzcf5xn0qUOCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBCvztvUbenC9z2xswAHK4jfRX0cPvJ+x4DpZWLwITY=;
 b=NA2JvyrWq+8A8Spep8cLOV+it/hBMd2lmfR92kMzxATR2B2/das9jJcCuDr1Hchm7Nejc/
 uFJjk3xJPIrK0i1l5WaaDOq4KH03ePZqQMZlfZhhgpov3Jtd2Lp1B+f8BNT4nDLeR8uVo1
 j0itaVZEK4rHq0tcclzn92PY0hCgGmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBCvztvUbenC9z2xswAHK4jfRX0cPvJ+x4DpZWLwITY=;
 b=t+AVoP5xrWpNabFg40DubNWR5uMdo1ZXa6fus1MAZPLLmOJrUxcxBSvKYZiyID6mn0Pc0d
 r3MAzcf5xn0qUOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C0F413941;
 Wed, 27 Nov 2024 18:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJY2EPdkR2faYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 18:29:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/17] tests/qtest/migration: Move bootfile code to its own
 file
Date: Wed, 27 Nov 2024 15:28:48 -0300
Message-Id: <20241127182901.529-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241127182901.529-1-farosas@suse.de>
References: <20241127182901.529-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.983]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Move the code that creates the guest binary out of migration-test and
into the qtest/migration/ directory, along with the rest of the
a-b-kernel code.

That code is part of the basic infrastructure of migration tests, it
shouldn't be among the tests themselves.

Also take the chance and rename migration-test.h, which is too generic
a name for this header which contains only values related to guest
memory offsets.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                       |  8 ++-
 tests/qtest/migration-helpers.c               |  1 +
 tests/qtest/migration-test.c                  | 58 +--------------
 tests/qtest/migration/bootfile.c              | 70 +++++++++++++++++++
 .../{migration-test.h => bootfile.h}          |  9 ++-
 5 files changed, 86 insertions(+), 60 deletions(-)
 create mode 100644 tests/qtest/migration/bootfile.c
 rename tests/qtest/migration/{migration-test.h => bootfile.h} (85%)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f2f35367ae..9901209e49 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -331,7 +331,11 @@ endif
 
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
-migration_files = [files('migration-helpers.c')]
+migration_files = [files(
+  'migration-helpers.c',
+  'migration/bootfile.c',
+)]
+
 if gnutls.found()
   migration_files += [files('../unit/crypto-tls-psk-helpers.c'), gnutls]
 
@@ -357,7 +361,7 @@ qtests = {
   'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
   'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
-  'virtio-net-failover': files('migration-helpers.c'),
+  'virtio-net-failover': migration_files,
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
 }
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3f8ba7fa8e..2786f9c860 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -21,6 +21,7 @@
 #include "qemu/memalign.h"
 
 #include "migration-helpers.h"
+#include "migration/bootfile.h"
 
 /*
  * Number of seconds we wait when looking for migration
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 82b9170e3c..e104e44802 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -24,7 +24,7 @@
 #include "ppc-util.h"
 
 #include "migration-helpers.h"
-#include "migration/migration-test.h"
+#include "migration/bootfile.h"
 #ifdef CONFIG_GNUTLS
 # include "tests/unit/crypto-tls-psk-helpers.h"
 # ifdef CONFIG_TASN1
@@ -135,58 +135,6 @@ static bool ufd_version_check(void)
 static char *tmpfs;
 static char *bootpath;
 
-/* The boot file modifies memory area in [start_address, end_address)
- * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
- */
-#include "migration/i386/a-b-bootblock.h"
-#include "migration/aarch64/a-b-kernel.h"
-#include "migration/ppc64/a-b-kernel.h"
-#include "migration/s390x/a-b-bios.h"
-
-static void bootfile_delete(void)
-{
-    if (!bootpath) {
-        return;
-    }
-    unlink(bootpath);
-    g_free(bootpath);
-    bootpath = NULL;
-}
-
-static void bootfile_create(char *dir, bool suspend_me)
-{
-    const char *arch = qtest_get_arch();
-    unsigned char *content;
-    size_t len;
-
-    bootfile_delete();
-    bootpath = g_strdup_printf("%s/bootsect", dir);
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        /* the assembled x86 boot sector should be exactly one sector large */
-        g_assert(sizeof(x86_bootsect) == 512);
-        x86_bootsect[SYM_suspend_me - SYM_start] = suspend_me;
-        content = x86_bootsect;
-        len = sizeof(x86_bootsect);
-    } else if (g_str_equal(arch, "s390x")) {
-        content = s390x_elf;
-        len = sizeof(s390x_elf);
-    } else if (strcmp(arch, "ppc64") == 0) {
-        content = ppc64_kernel;
-        len = sizeof(ppc64_kernel);
-    } else if (strcmp(arch, "aarch64") == 0) {
-        content = aarch64_kernel;
-        len = sizeof(aarch64_kernel);
-        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
-    } else {
-        g_assert_not_reached();
-    }
-
-    FILE *bootfile = fopen(bootpath, "wb");
-
-    g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
-    fclose(bootfile);
-}
-
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -737,7 +685,7 @@ static int migrate_start(QTestState **from, QTestState **to,
 
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
-    bootfile_create(tmpfs, args->suspend_me);
+    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
@@ -3488,7 +3436,7 @@ static QTestState *dirtylimit_start_vm(void)
     QTestState *vm = NULL;
     g_autofree gchar *cmd = NULL;
 
-    bootfile_create(tmpfs, false);
+    bootpath = bootfile_create(qtest_get_arch(), tmpfs, false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
new file mode 100644
index 0000000000..8f75f64093
--- /dev/null
+++ b/tests/qtest/migration/bootfile.c
@@ -0,0 +1,70 @@
+/*
+ * Guest code setup for migration tests
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+/*
+ * The boot file modifies memory area in [start_address, end_address)
+ * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
+ */
+#include "bootfile.h"
+#include "i386/a-b-bootblock.h"
+#include "aarch64/a-b-kernel.h"
+#include "ppc64/a-b-kernel.h"
+#include "s390x/a-b-bios.h"
+
+static char *bootpath;
+
+void bootfile_delete(void)
+{
+    if (!bootpath) {
+        return;
+    }
+    unlink(bootpath);
+    g_free(bootpath);
+    bootpath = NULL;
+}
+
+char *bootfile_create(const char *arch, char *dir, bool suspend_me)
+{
+    unsigned char *content;
+    size_t len;
+
+    bootfile_delete();
+    bootpath = g_strdup_printf("%s/bootsect", dir);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        /* the assembled x86 boot sector should be exactly one sector large */
+        g_assert(sizeof(x86_bootsect) == 512);
+        x86_bootsect[SYM_suspend_me - SYM_start] = suspend_me;
+        content = x86_bootsect;
+        len = sizeof(x86_bootsect);
+    } else if (g_str_equal(arch, "s390x")) {
+        content = s390x_elf;
+        len = sizeof(s390x_elf);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        content = ppc64_kernel;
+        len = sizeof(ppc64_kernel);
+    } else if (strcmp(arch, "aarch64") == 0) {
+        content = aarch64_kernel;
+        len = sizeof(aarch64_kernel);
+        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+    } else {
+        g_assert_not_reached();
+    }
+
+    FILE *bootfile = fopen(bootpath, "wb");
+
+    g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
+    fclose(bootfile);
+
+    return bootpath;
+}
diff --git a/tests/qtest/migration/migration-test.h b/tests/qtest/migration/bootfile.h
similarity index 85%
rename from tests/qtest/migration/migration-test.h
rename to tests/qtest/migration/bootfile.h
index 194df7df6f..4f5099d765 100644
--- a/tests/qtest/migration/migration-test.h
+++ b/tests/qtest/migration/bootfile.h
@@ -5,8 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef MIGRATION_TEST_H
-#define MIGRATION_TEST_H
+#ifndef BOOTFILE_H
+#define BOOTFILE_H
 
 /* Common */
 #define TEST_MEM_PAGE_SIZE 4096
@@ -33,4 +33,7 @@
  */
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
 
-#endif /* MIGRATION_TEST_H */
+void bootfile_delete(void);
+char *bootfile_create(const char *arch, char *dir, bool suspend_me);
+
+#endif /* BOOTFILE_H */
-- 
2.35.3


