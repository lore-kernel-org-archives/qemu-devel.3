Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF67D637AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKJ-0006LJ-Us; Wed, 13 Nov 2024 14:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKI-0006Kn-2u
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:46:54 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKG-00039H-BW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:46:53 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E23821109;
 Wed, 13 Nov 2024 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rbn6BZT65qOoPp8Meu3t3YUqTdAMFXy178r1Y0FmLhw=;
 b=abDocj3EAWRJccjD5G3xfzjVEVvGInxImcoCrQvhrIHeQAAB3hiR4V+/R2D7If7auQ0o1v
 DlXfmqf7FZzMIPLJOmv5c9PagzehKzz9JenTvt3QapEHevgOoSbsEtRcKz00v6efLmsBc2
 Hxwej02NOBlhH3Xqm1BQ2paTBiCrMug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rbn6BZT65qOoPp8Meu3t3YUqTdAMFXy178r1Y0FmLhw=;
 b=YOO2+Fc9GJ1yN0nLqBKNt5eeuUus+ouF2uQ3GEokifFWhaGN2EaUnaUJrgsIlCw62FvMUz
 yveA0QZThU6waZDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rbn6BZT65qOoPp8Meu3t3YUqTdAMFXy178r1Y0FmLhw=;
 b=abDocj3EAWRJccjD5G3xfzjVEVvGInxImcoCrQvhrIHeQAAB3hiR4V+/R2D7If7auQ0o1v
 DlXfmqf7FZzMIPLJOmv5c9PagzehKzz9JenTvt3QapEHevgOoSbsEtRcKz00v6efLmsBc2
 Hxwej02NOBlhH3Xqm1BQ2paTBiCrMug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rbn6BZT65qOoPp8Meu3t3YUqTdAMFXy178r1Y0FmLhw=;
 b=YOO2+Fc9GJ1yN0nLqBKNt5eeuUus+ouF2uQ3GEokifFWhaGN2EaUnaUJrgsIlCw62FvMUz
 yveA0QZThU6waZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2355B13301;
 Wed, 13 Nov 2024 19:46:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJE4NigCNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:46:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/22] tests/qtest/migration: Rename migration-helpers.c
Date: Wed, 13 Nov 2024 16:46:15 -0300
Message-Id: <20241113194630.3385-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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
 tests/qtest/meson.build                                  | 4 ++--
 tests/qtest/migration-test.c                             | 2 +-
 tests/qtest/migration/migration-qmp.c                    | 2 +-
 tests/qtest/migration/migration-qmp.h                    | 2 ++
 .../{migration-helpers.c => migration/migration-util.c}  | 4 ++--
 .../{migration-helpers.h => migration/migration-util.h}  | 9 ++++++---
 tests/qtest/virtio-net-failover.c                        | 2 +-
 7 files changed, 15 insertions(+), 10 deletions(-)
 rename tests/qtest/{migration-helpers.c => migration/migration-util.c} (99%)
 rename tests/qtest/{migration-helpers.h => migration/migration-util.h} (89%)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ca199b9491..b9f70ac32f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -331,9 +331,9 @@ endif
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
 migration_files = [files(
-  'migration-helpers.c',
   'migration/bootfile.c',
   'migration/migration-qmp.c',
+  'migration/migration-util.c',
 )]
 
 if gnutls.found()
@@ -347,7 +347,7 @@ endif
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-  'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
+  'dbus-vmstate-test': files('migration/migration-qmp.c', 'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a0c63026ed..59f02f7815 100644
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
similarity index 89%
rename from tests/qtest/migration-helpers.h
rename to tests/qtest/migration/migration-util.h
index 2cb1f78d9e..de1bc0ad0c 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration/migration-util.h
@@ -10,11 +10,14 @@
  *
  */
 
-#ifndef MIGRATION_HELPERS_H
-#define MIGRATION_HELPERS_H
+#ifndef MIGRATION_UTIL_H
+#define MIGRATION_UTIL_H
 
 #include "libqtest.h"
 
+#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
+#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+
 typedef struct QTestMigrationState {
     bool stop_seen;
     bool resume_seen;
@@ -51,4 +54,4 @@ void migration_test_add(const char *path, void (*fn)(void));
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


