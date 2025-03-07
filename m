Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41450C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcFB-0000kj-B2; Fri, 07 Mar 2025 13:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcFA-0000k7-8U
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:20 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcF8-0004x9-22
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:19 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 015831F395;
 Fri,  7 Mar 2025 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nitnp15hL2jUHMEDBolqcEtudwr+GxP9TWOY8/DrRj0=;
 b=DWOr1IaAaNxiiax4BcvKMMsctEPDz8MTyvgyBxPvkgQxmmaNlQ3WPjj3AocSTpZKErwqHr
 G7c804hmrF7B6DOG5sJvZ7pa+MBhEzqYVkCMiiPu67B5fvEs0WqIf8IV6PriwfZhWXrQhV
 dQFJQhC90dno+QV5tAVyHaal6H0x+4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nitnp15hL2jUHMEDBolqcEtudwr+GxP9TWOY8/DrRj0=;
 b=O7GCwntSicCRuA3fvmD4bY3zxJ5nO08U45G7IFIy+ula/HX/Dko09vaNEsU7w/R5d6oOVT
 dVi63Guna5hfVsAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nitnp15hL2jUHMEDBolqcEtudwr+GxP9TWOY8/DrRj0=;
 b=DWOr1IaAaNxiiax4BcvKMMsctEPDz8MTyvgyBxPvkgQxmmaNlQ3WPjj3AocSTpZKErwqHr
 G7c804hmrF7B6DOG5sJvZ7pa+MBhEzqYVkCMiiPu67B5fvEs0WqIf8IV6PriwfZhWXrQhV
 dQFJQhC90dno+QV5tAVyHaal6H0x+4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nitnp15hL2jUHMEDBolqcEtudwr+GxP9TWOY8/DrRj0=;
 b=O7GCwntSicCRuA3fvmD4bY3zxJ5nO08U45G7IFIy+ula/HX/Dko09vaNEsU7w/R5d6oOVT
 dVi63Guna5hfVsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A122513A22;
 Fri,  7 Mar 2025 18:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJqyF+k3y2dNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 18:16:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 8/8] migration: Add qtest for migration over RDMA
Date: Fri,  7 Mar 2025 15:15:51 -0300
Message-Id: <20250307181551.19887-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307181551.19887-1-farosas@suse.de>
References: <20250307181551.19887-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

From: Li Zhijian <lizhijian@fujitsu.com>

This qtest requires there is a RDMA(RoCE) link in the host.
In order to make the test work smoothly, introduce a
scripts/rdma-migration-helper.sh to
- setup a new Soft-RoCE(aka RXE) if it's root
- detect existing RoCE link

Test will be skipped if there is no available RoCE link.
 # Start of rdma tests
 # Running /x86_64/migration/precopy/rdma/plain
 Command 'rdma' is not available, please install it first.
 # To enable the test:
 # (1) Run 'scripts/rdma-migration-helper.sh setup' with root and rerun the test
 # or
 # (2) Run the test with root privilege
 #
 ok 1 /x86_64/migration/precopy/rdma/plain # SKIP No rdma link available
 # End of rdma tests

Note: Remove the newly added RXE link by executing 'modprobe -r rdma_rxe'
or by specifying 'clean' within this script.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-7-lizhijian@fujitsu.com>
[reformated the message to be under 90 characters]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                           |  1 +
 scripts/rdma-migration-helper.sh      | 48 +++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 69 +++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100755 scripts/rdma-migration-helper.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 5df6020ed5..56e85adcfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3517,6 +3517,7 @@ R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
+F: scripts/rdma-migration-helper.sh
 
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
new file mode 100755
index 0000000000..08e29a52eb
--- /dev/null
+++ b/scripts/rdma-migration-helper.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+
+# Copied from blktests
+get_ipv4_addr()
+{
+    ip -4 -o addr show dev "$1" |
+        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
+        tr -d '\n'
+}
+
+has_soft_rdma()
+{
+    rdma link | grep -q " netdev $1[[:blank:]]*\$"
+}
+
+rdma_rxe_setup_detect()
+{
+    (
+        cd /sys/class/net &&
+            for i in *; do
+                [ -e "$i" ] || continue
+                [ "$i" = "lo" ] && continue
+                [ "$(<"$i/addr_len")" = 6 ] || continue
+                [ "$(<"$i/carrier")" = 1 ] || continue
+
+                has_soft_rdma "$i" && break
+                [ "$operation" = "setup" ] &&
+                    rdma link add "${i}_rxe" type rxe netdev "$i" && break
+            done
+        has_soft_rdma "$i" || return
+        get_ipv4_addr "$i"
+    )
+}
+
+operation=${1:-setup}
+
+command -v rdma >/dev/null || {
+    echo "Command 'rdma' is not available, please install it first." >&2
+    exit 1
+}
+
+if [ "$operation" == "setup" ] || [ "$operation" == "detect" ]; then
+    rdma_rxe_setup_detect
+elif [ "$operation" == "clean" ]; then
+    modprobe -r rdma_rxe
+else
+    echo "Usage: $0 [setup | detect | clean]"
+fi
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ba273d10b9..f1fe34020d 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -99,6 +99,71 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+#ifdef CONFIG_RDMA
+
+#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
+static int new_rdma_link(char *buffer, bool verbose)
+{
+    const char *argument = (geteuid() == 0) ? "setup" : "detect";
+    char cmd[1024];
+
+    snprintf(cmd, sizeof(cmd), "%s %s %s", RDMA_MIGRATION_HELPER, argument,
+             verbose ? "" : "2>/dev/null");
+
+    FILE *pipe = popen(cmd, "r");
+    if (pipe == NULL) {
+        perror("Failed to run script");
+        return -1;
+    }
+
+    int idx = 0;
+    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
+        idx += strlen(buffer);
+    }
+
+    int status = pclose(pipe);
+    if (status == -1) {
+        perror("Error reported by pclose()");
+        return -1;
+    } else if (WIFEXITED(status)) {
+        return WEXITSTATUS(status);
+    }
+
+    return -1;
+}
+
+static void test_precopy_rdma_plain(void)
+{
+    char buffer[128] = {};
+    bool verbose = g_getenv("QTEST_LOG");
+
+    if (new_rdma_link(buffer, verbose)) {
+        g_test_skip("No rdma link available");
+        if (verbose) {
+            g_test_message(
+                "To enable the test:\n"
+                "(1) Run \'" RDMA_MIGRATION_HELPER
+                " setup\' with root and rerun the test\n"
+                "or\n(2) Run the test with root privilege");
+        }
+        return;
+    }
+
+    /*
+     * TODO: query a free port instead of hard code.
+     * 29200=('R'+'D'+'M'+'A')*100
+     **/
+    g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
+
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    test_precopy_common(&args);
+}
+#endif
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -1124,6 +1189,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
+#ifdef CONFIG_RDMA
+    migration_test_add("/migration/precopy/rdma/plain",
+                       test_precopy_rdma_plain);
+#endif
 }
 
 void migration_test_add_precopy(MigrationTestEnv *env)
-- 
2.35.3


