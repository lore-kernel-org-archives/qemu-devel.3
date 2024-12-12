Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B120E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpQ-0003y6-1E; Thu, 12 Dec 2024 10:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpO-0003xB-2P
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:10 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpL-0003CQ-Ti
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E7C42110B;
 Thu, 12 Dec 2024 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c34O0s8cvvREoCu74KKiwvWOaxypT573z19i+LkUMJI=;
 b=TLQH+p8R4hWZjHKIv7eZN/iz3BDbHVftoLAznq2AELAQtR80kbCsBvWVPnJ5zmkGMR7/mE
 XArscYoNTiUWd6JtAXwvs2YqNyBv/9IuuvThhMaXVkUGX1D7kmu8x/c3WJclh5JdW2Y9v7
 hYu9WHpb2QZVcd9dzGf8RVZW/bKtLDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c34O0s8cvvREoCu74KKiwvWOaxypT573z19i+LkUMJI=;
 b=1q3WPaHUIlKGcMvqfR/5jfOx1vWHJywE/t+J/Cj9Xu6RsZEkIaN+rbdSWX4ia/eRAqi3MO
 L/AarkPsP8nCVdCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TLQH+p8R;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1q3WPaHU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c34O0s8cvvREoCu74KKiwvWOaxypT573z19i+LkUMJI=;
 b=TLQH+p8R4hWZjHKIv7eZN/iz3BDbHVftoLAznq2AELAQtR80kbCsBvWVPnJ5zmkGMR7/mE
 XArscYoNTiUWd6JtAXwvs2YqNyBv/9IuuvThhMaXVkUGX1D7kmu8x/c3WJclh5JdW2Y9v7
 hYu9WHpb2QZVcd9dzGf8RVZW/bKtLDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c34O0s8cvvREoCu74KKiwvWOaxypT573z19i+LkUMJI=;
 b=1q3WPaHUIlKGcMvqfR/5jfOx1vWHJywE/t+J/Cj9Xu6RsZEkIaN+rbdSWX4ia/eRAqi3MO
 L/AarkPsP8nCVdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD90013508;
 Thu, 12 Dec 2024 15:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WIhgKMz8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/22] tests/qtest/migration: Move bootfile code to its own file
Date: Thu, 12 Dec 2024 12:09:35 -0300
Message-Id: <20241212150949.16806-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E7C42110B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
index 89db3ecf2f..c3712a9e36 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -332,7 +332,11 @@ endif
 
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
-migration_files = [files('migration-helpers.c')]
+migration_files = [files(
+  'migration-helpers.c',
+  'migration/bootfile.c',
+)]
+
 if gnutls.found()
   migration_files += [files('../unit/crypto-tls-psk-helpers.c'), gnutls]
 
@@ -358,7 +362,7 @@ qtests = {
   'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
   'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
-  'virtio-net-failover': files('migration-helpers.c'),
+  'virtio-net-failover': migration_files,
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
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


