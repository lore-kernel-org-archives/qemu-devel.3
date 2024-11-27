Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EB7D6ACFE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMmw-0006Yi-Bd; Wed, 27 Nov 2024 13:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmu-0006Xz-LP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:20 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmt-0001uo-1Q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A52171F38D;
 Wed, 27 Nov 2024 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4Yx9BX0swdFqGTIRBMrwUurPnxcsMtjnYmEpqKaSFg=;
 b=gPPE05TE7OW/VGtTah47wtB5mOSCvmxa7AfMIjf/ZceMVVGHqxYwuytY0d3hCRmYb7UukW
 QMe1F2Xiz7Qc0A5KLVnIb1BQHL3jkl25tHlKxlGWw6dlVkhT7q74jB2X1iitMWJ7DYqH8A
 SNzW+ryajZVhv7cNshgV1AtDKhsJ53E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4Yx9BX0swdFqGTIRBMrwUurPnxcsMtjnYmEpqKaSFg=;
 b=VHGm6cmFRCMft4eN6VO8rYahNCHM1RRu++JlEmZfILMLplJnsFdWPFzPhxzm/UtSI2Ekzt
 aMuUxBktUxS/zeBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gPPE05TE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VHGm6cmF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4Yx9BX0swdFqGTIRBMrwUurPnxcsMtjnYmEpqKaSFg=;
 b=gPPE05TE7OW/VGtTah47wtB5mOSCvmxa7AfMIjf/ZceMVVGHqxYwuytY0d3hCRmYb7UukW
 QMe1F2Xiz7Qc0A5KLVnIb1BQHL3jkl25tHlKxlGWw6dlVkhT7q74jB2X1iitMWJ7DYqH8A
 SNzW+ryajZVhv7cNshgV1AtDKhsJ53E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4Yx9BX0swdFqGTIRBMrwUurPnxcsMtjnYmEpqKaSFg=;
 b=VHGm6cmFRCMft4eN6VO8rYahNCHM1RRu++JlEmZfILMLplJnsFdWPFzPhxzm/UtSI2Ekzt
 aMuUxBktUxS/zeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04DC113941;
 Wed, 27 Nov 2024 18:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2F0PLvtkR2faYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 18:29:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 06/17] tests/qtest/migration: Rename migration-helpers.c
Date: Wed, 27 Nov 2024 15:28:50 -0300
Message-Id: <20241127182901.529-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241127182901.529-1-farosas@suse.de>
References: <20241127182901.529-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A52171F38D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Rename migration-helpers.c to migration-util.c to make its purpose
more explicit and avoid the "helper" terminology.

Move the file to the qtest/migration/ directory along with the rest of
the migration files.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                                     | 4 ++--
 tests/qtest/migration-test.c                                | 2 +-
 tests/qtest/migration/migration-qmp.c                       | 2 +-
 tests/qtest/migration/migration-qmp.h                       | 2 ++
 .../{migration-helpers.c => migration/migration-util.c}     | 4 ++--
 .../{migration-helpers.h => migration/migration-util.h}     | 6 +++---
 tests/qtest/virtio-net-failover.c                           | 2 +-
 7 files changed, 12 insertions(+), 10 deletions(-)
 rename tests/qtest/{migration-helpers.c => migration/migration-util.c} (99%)
 rename tests/qtest/{migration-helpers.h => migration/migration-util.h} (94%)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 97d515b81f..030146c69a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -332,9 +332,9 @@ endif
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
 migration_files = [files(
-  'migration-helpers.c',
   'migration/bootfile.c',
   'migration/migration-qmp.c',
+  'migration/migration-util.c',
 )]
 
 if gnutls.found()
@@ -349,7 +349,7 @@ qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
   'dbus-vmstate-test': files('migration/migration-qmp.c',
-                             'migration-helpers.c') + dbus_vmstate1,
+                             'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 489fca7071..e295bd3081 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -22,9 +22,9 @@
 #include "crypto/tlscredspsk.h"
 #include "ppc-util.h"
 
-#include "migration-helpers.h"
 #include "migration/bootfile.h"
 #include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
 #ifdef CONFIG_GNUTLS
 # include "tests/unit/crypto-tls-psk-helpers.h"
 # ifdef CONFIG_TASN1
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 20be46fdf6..71b14b51b2 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -12,8 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "migration-helpers.h"
 #include "migration-qmp.h"
+#include "migration-util.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index ed927cf408..caaa78722a 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -2,6 +2,8 @@
 #ifndef MIGRATION_QMP_H
 #define MIGRATION_QMP_H
 
+#include "migration-util.h"
+
 G_GNUC_PRINTF(4, 5)
 void migrate_qmp_fail(QTestState *who, const char *uri,
                       const char *channels, const char *fmt, ...);
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration/migration-util.c
similarity index 99%
rename from tests/qtest/migration-helpers.c
rename to tests/qtest/migration/migration-util.c
index 218ee4e59f..8a974ded22 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration/migration-util.c
@@ -1,5 +1,5 @@
 /*
- * QTest migration helpers
+ * QTest migration utilities
  *
  * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
  *   based on the vhost-user-test.c that is:
@@ -19,8 +19,8 @@
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 
-#include "migration-helpers.h"
 #include "migration/bootfile.h"
+#include "migration/migration-util.h"
 
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration/migration-util.h
similarity index 94%
rename from tests/qtest/migration-helpers.h
rename to tests/qtest/migration/migration-util.h
index 2cb1f78d9e..0fa3676235 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration/migration-util.h
@@ -10,8 +10,8 @@
  *
  */
 
-#ifndef MIGRATION_HELPERS_H
-#define MIGRATION_HELPERS_H
+#ifndef MIGRATION_UTIL_H
+#define MIGRATION_UTIL_H
 
 #include "libqtest.h"
 
@@ -51,4 +51,4 @@ void migration_test_add(const char *path, void (*fn)(void));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
 
-#endif /* MIGRATION_HELPERS_H */
+#endif /* MIGRATION_UTIL_H */
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 28a6147d9a..08365ffa11 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -11,8 +11,8 @@
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
-#include "migration-helpers.h"
 #include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qjson.h"
-- 
2.35.3


