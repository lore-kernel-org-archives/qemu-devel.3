Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868D9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 20:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAEuZ-0000ZW-Ex; Thu, 23 May 2024 16:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEuX-0000Xd-Rt
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:37 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEuT-0002GW-Q0
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33B2722CA1;
 Thu, 23 May 2024 20:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDaw37QeDsntTYEQfIgRI8i/Cldol1zqIA8YZR5ICoo=;
 b=TduEx3KP4n/zCrpgit8BWs/KrkDqm6XNLzCuemnVAm80x2QsDjbK6Isw1B69+inAkwgVlz
 A6eYr+rqGHzXQo5KVGpyz1pZkZtlGdOL0onmW3NYRZPAikb2Zo1uSb4JWSJCvRvf8s7gBR
 uLcCTOHe7qlKPQkY2HvJb9GZu445Fx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDaw37QeDsntTYEQfIgRI8i/Cldol1zqIA8YZR5ICoo=;
 b=MNxKl6mLsXqRlg7ZRBe2IgGV2ZRMLZV09PaaqeUitFqvHzHPc+pwg0/rsPoAVkqfHv08tC
 BM10YiVHt3qykoDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TduEx3KP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MNxKl6mL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDaw37QeDsntTYEQfIgRI8i/Cldol1zqIA8YZR5ICoo=;
 b=TduEx3KP4n/zCrpgit8BWs/KrkDqm6XNLzCuemnVAm80x2QsDjbK6Isw1B69+inAkwgVlz
 A6eYr+rqGHzXQo5KVGpyz1pZkZtlGdOL0onmW3NYRZPAikb2Zo1uSb4JWSJCvRvf8s7gBR
 uLcCTOHe7qlKPQkY2HvJb9GZu445Fx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDaw37QeDsntTYEQfIgRI8i/Cldol1zqIA8YZR5ICoo=;
 b=MNxKl6mLsXqRlg7ZRBe2IgGV2ZRMLZV09PaaqeUitFqvHzHPc+pwg0/rsPoAVkqfHv08tC
 BM10YiVHt3qykoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3B0513A6C;
 Thu, 23 May 2024 20:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MHoSKtGkT2ZqcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 20:19:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 2/4] tests/qtest/migration: Add a test that runs
 vmstate-static-checker
Date: Thu, 23 May 2024 17:19:20 -0300
Message-Id: <20240523201922.28007-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523201922.28007-1-farosas@suse.de>
References: <20240523201922.28007-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 33B2722CA1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

We have the vmstate-static-checker script that takes the output of:
'$QEMU -M $machine -dump-vmstate' for two different QEMU versions and
compares them to check for compatibility breakages. This is just too
simple and useful for us to pass on it. Add a test that runs the
script.

Since this needs to use two different QEMU versions, the test is
skipped if only one QEMU is provided. The infrastructure for passing
more than one binary is already in place:

$ PYTHON=$(which python3.11) \
 QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-x86_64 \
 QTEST_QEMU_BINARY=./qemu-system-x86_64 \
 ./tests/qtest/migration-test -p /x86_64/migration/vmstate-checker-script

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
some code duplication for now, just so we can reason about this
without too much noise
---
 tests/qtest/migration-test.c | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e8d3555f56..2253e0fc5b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -63,6 +63,7 @@ static QTestMigrationState dst_state;
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
 #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
+#define VMSTATE_CHECKER_SCRIPT "scripts/vmstate-static-checker.py"
 
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define FILE_TEST_FILENAME "migfile"
@@ -1611,6 +1612,85 @@ static void test_analyze_script(void)
     test_migrate_end(from, to, false);
     cleanup("migfile");
 }
+
+static void test_vmstate_checker_script(void)
+{
+    g_autofree gchar *cmd_src = NULL;
+    g_autofree gchar *cmd_dst = NULL;
+    g_autofree gchar *vmstate_src = NULL;
+    g_autofree gchar *vmstate_dst = NULL;
+    const char *machine_alias, *machine_opts = "";
+    g_autofree char *machine = NULL;
+    const char *arch = qtest_get_arch();
+    int pid, wstatus;
+    const char *python = g_getenv("PYTHON");
+
+    if (!getenv(QEMU_ENV_SRC) && !getenv(QEMU_ENV_DST)) {
+        g_test_skip("Test needs two different QEMU versions");
+        return;
+    }
+
+    if (!python) {
+        g_test_skip("PYTHON variable not set");
+        return;
+    }
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (g_str_equal(arch, "i386")) {
+            machine_alias = "pc";
+        } else {
+            machine_alias = "q35";
+        }
+    } else if (g_str_equal(arch, "s390x")) {
+        machine_alias = "s390-ccw-virtio";
+    } else if (strcmp(arch, "ppc64") == 0) {
+        machine_alias = "pseries";
+    } else if (strcmp(arch, "aarch64") == 0) {
+        machine_alias = "virt";
+    } else {
+        g_assert_not_reached();
+    }
+
+    if (!qtest_has_machine(machine_alias)) {
+        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
+        g_test_skip(msg);
+        return;
+    }
+
+    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
+                                      QEMU_ENV_DST);
+
+    vmstate_src = g_strdup_printf("%s/vmstate-src", tmpfs);
+    vmstate_dst = g_strdup_printf("%s/vmstate-dst", tmpfs);
+
+    cmd_dst = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
+                              machine, machine_opts, vmstate_dst);
+    cmd_src = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
+                              machine, machine_opts, vmstate_src);
+
+    qtest_init_with_env_no_handshake(QEMU_ENV_SRC, cmd_src);
+    qtest_init_with_env_no_handshake(QEMU_ENV_DST, cmd_dst);
+
+    pid = fork();
+    if (!pid) {
+        close(1);
+        open("/dev/null", O_WRONLY);
+        execl(python, python, VMSTATE_CHECKER_SCRIPT,
+              "-s", vmstate_src,
+              "-d", vmstate_dst,
+              NULL);
+        g_assert_not_reached();
+    }
+
+    g_assert(waitpid(pid, &wstatus, 0) == pid);
+    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
+        g_test_message("Failed to run vmstate-static-checker.py");
+        g_test_fail();
+    }
+
+    cleanup("vmstate-src");
+    cleanup("vmstate-dst");
+}
 #endif
 
 static void test_precopy_common(MigrateCommon *args)
@@ -3495,6 +3575,8 @@ int main(int argc, char **argv)
 #ifndef _WIN32
     if (!g_str_equal(arch, "s390x")) {
         migration_test_add("/migration/analyze-script", test_analyze_script);
+        migration_test_add("/migration/vmstate-checker-script",
+                           test_vmstate_checker_script);
     }
 #endif
     migration_test_add("/migration/precopy/unix/plain",
-- 
2.35.3


