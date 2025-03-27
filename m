Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F52C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoOi-0006V8-1b; Thu, 27 Mar 2025 10:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOZ-0006UF-TH
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:48 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOX-0005Z8-Rk
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22D792117A;
 Thu, 27 Mar 2025 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJh18vi4S8VW/S7WC4c3Cmkh0hz+w8GARbqarPZ7238=;
 b=E/GwY7Tuipqoisjwi2ZzJyv6zNoa87FY3ForjvI5QTgfvy+5En6qetEUKpr6NrzFxO13N1
 F/NU4+OlYUoSAwOlkDbDXZwYsG+MAglRWCdAeq0+dpA1QoQ7ab1fMZIA8hIXxRaNXAioAi
 NgbL7iED8/PADEvFihsbDdpvrzQoppM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJh18vi4S8VW/S7WC4c3Cmkh0hz+w8GARbqarPZ7238=;
 b=K/+T6SUBU7VafipPW+v9qJskKxIfeRJ9BKkRHFnv2NbTpDUoEVZmYLg7ADsnf6c0fZ/4qs
 yJSaxmpmfpWTwABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJh18vi4S8VW/S7WC4c3Cmkh0hz+w8GARbqarPZ7238=;
 b=E/GwY7Tuipqoisjwi2ZzJyv6zNoa87FY3ForjvI5QTgfvy+5En6qetEUKpr6NrzFxO13N1
 F/NU4+OlYUoSAwOlkDbDXZwYsG+MAglRWCdAeq0+dpA1QoQ7ab1fMZIA8hIXxRaNXAioAi
 NgbL7iED8/PADEvFihsbDdpvrzQoppM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJh18vi4S8VW/S7WC4c3Cmkh0hz+w8GARbqarPZ7238=;
 b=K/+T6SUBU7VafipPW+v9qJskKxIfeRJ9BKkRHFnv2NbTpDUoEVZmYLg7ADsnf6c0fZ/4qs
 yJSaxmpmfpWTwABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 188D1139D4;
 Thu, 27 Mar 2025 14:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sM9wMi1j5WcVZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:39:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, berrange@redhat.com,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 2/4] tests/qtest/migration: Extract machine type resolution
Date: Thu, 27 Mar 2025 11:39:32 -0300
Message-Id: <20250327143934.7935-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327143934.7935-1-farosas@suse.de>
References: <20250327143934.7935-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Move the machine type resolution code to a separate function, along
with the machine alias, which is only used for this purpose.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 52 +++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 10e1d04b58..2311100dd6 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -207,6 +207,38 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
     return capabilities;
 }
 
+static char *migrate_resolve_alias(const char *arch)
+{
+    const char *machine_alias;
+
+    if (g_str_equal(arch, "i386")) {
+        machine_alias = "pc";
+
+    } else if (g_str_equal(arch, "x86_64")) {
+        machine_alias = "q35";
+
+    } else if (g_str_equal(arch, "s390x")) {
+        machine_alias = "s390-ccw-virtio";
+
+    } else if (g_str_equal(arch, "ppc64")) {
+        machine_alias = "pseries";
+
+    } else if (g_str_equal(arch, "aarch64")) {
+        machine_alias = "virt";
+
+    } else {
+        g_assert_not_reached();
+    }
+
+    if (!qtest_has_machine(machine_alias)) {
+        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
+        g_test_skip(msg);
+        return NULL;
+    }
+
+    return resolve_machine_version(machine_alias, QEMU_ENV_SRC, QEMU_ENV_DST);
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -220,7 +252,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
-    const char *machine_alias, *machine_opts = "";
+    const char *machine_opts = "";
     g_autofree char *machine = NULL;
     const char *bootpath;
     g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
@@ -241,12 +273,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
-
-        if (g_str_equal(arch, "i386")) {
-            machine_alias = "pc";
-        } else {
-            machine_alias = "q35";
-        }
         arch_opts = g_strdup_printf(
             "-drive if=none,id=d0,file=%s,format=raw "
             "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
@@ -254,7 +280,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         memory_size = "128M";
-        machine_alias = "s390-ccw-virtio";
         arch_opts = g_strdup_printf("-bios %s", bootpath);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
@@ -262,14 +287,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         memory_size = "256M";
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
-        machine_alias = "pseries";
         machine_opts = "vsmt=8";
         arch_opts = g_strdup_printf(
             "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES " "
             "-bios %s", bootpath);
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
-        machine_alias = "virt";
         machine_opts = "gic-version=3";
         arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
@@ -311,15 +334,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
-    if (!qtest_has_machine(machine_alias)) {
-        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
-        g_test_skip(msg);
+    machine = migrate_resolve_alias(arch);
+    if (!machine) {
         return -1;
     }
-
-    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
-                                      QEMU_ENV_DST);
-
     g_test_message("Using machine type: %s", machine);
 
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-- 
2.35.3


