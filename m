Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61193E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkcW-0007x7-G3; Mon, 09 Dec 2024 15:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcU-0007wY-Ln
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:42 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcT-0003wp-0T
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:42 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBF251F747;
 Mon,  9 Dec 2024 20:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sX9xfnm26PQjjM0p87FfEu678GyUY1y1nyLGSi4Qq4=;
 b=MkJon0crjFpbwAQAccemJbEmkL/sIGSfp0tHQG/I44zmgRW/MzN4M6njTqG4QnvW9xeRwK
 qbMhOMA0jIwdPX/HTU96oLOtR/f0t1zIt9DmcH7NS3EypX0OWsFLi/JqHv1kDZGsZGpXOj
 Yec/4akUAheG5fika/Iev6+ixhNKBgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sX9xfnm26PQjjM0p87FfEu678GyUY1y1nyLGSi4Qq4=;
 b=jMf/URCwF0kaOjlA3Luibb264wUQY/PNJM/tH9sizebSs8Ko2/XroCkxjbs9YzMaz+aIDh
 7oQovOXhxDttgxDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sX9xfnm26PQjjM0p87FfEu678GyUY1y1nyLGSi4Qq4=;
 b=MkJon0crjFpbwAQAccemJbEmkL/sIGSfp0tHQG/I44zmgRW/MzN4M6njTqG4QnvW9xeRwK
 qbMhOMA0jIwdPX/HTU96oLOtR/f0t1zIt9DmcH7NS3EypX0OWsFLi/JqHv1kDZGsZGpXOj
 Yec/4akUAheG5fika/Iev6+ixhNKBgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sX9xfnm26PQjjM0p87FfEu678GyUY1y1nyLGSi4Qq4=;
 b=jMf/URCwF0kaOjlA3Luibb264wUQY/PNJM/tH9sizebSs8Ko2/XroCkxjbs9YzMaz+aIDh
 7oQovOXhxDttgxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C51B138D2;
 Mon,  9 Dec 2024 20:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOEAFLZWV2ebbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 20:44:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/6] tests/qtest/qos-test: Plug a couple of leaks
Date: Mon,  9 Dec 2024 17:44:26 -0300
Message-Id: <20241209204427.17763-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241209204427.17763-1-farosas@suse.de>
References: <20241209204427.17763-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The walk_path() function of qos-test.c, which walks the graph and adds
tests to the test suite uses GLib's g_test_add_data_func_full()
function:

g_test_add_data_func_full (const char     *testpath,
                           gpointer        test_data,
                           GTestDataFunc   test_func,
                           GDestroyNotify  data_free_func)

Despite GLib's documentation stating that @data_free_func is a
destructor for @test_data, this is not the case. The destructor is
supposed to be paired with a constructor, which GLib only accepts via
g_test_create_case().

Providing externally allocated data plus a destructor function only
works if the test is guaranteed to execute, otherwise the test_data is
never deallocated.

Due to how subprocessess are implemented in qos-test, each test gets
added twice and an extra test gets added per subprocess. In a regular
run, the extra subprocess will not be executed and in a single test
run (-p), none of the other tests will be executed (+1 per
subprocess), leaking 'path_vec' and 'subprocess_path'.

Fix this by storing all the path vectors in a list and freeing them
all at the end of the program (including subprocess invocations) and
moving the allocation of 'subprocess_path' into run_one_subprocess().

While here add some documentation explaining why the graph needs to be
walked twice and tests re-added.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/qos-test.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 114f6bef27..67abc660b5 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -31,6 +31,7 @@
 #include "libqos/qos_external.h"
 
 static char *old_path;
+static GSList *path_vecs;
 
 
 /**
@@ -183,11 +184,16 @@ static void run_one_test(const void *arg)
 
 static void subprocess_run_one_test(const void *arg)
 {
-    const gchar *path = arg;
-    g_test_trap_subprocess(path, 180 * G_USEC_PER_SEC,
+    char **path_vec = (char **) arg;
+    gchar *path = g_strjoinv("/", path_vec + 1);
+    gchar *subprocess_path = g_strdup_printf("/%s/subprocess", path);
+
+    g_test_trap_subprocess(subprocess_path, 180 * G_USEC_PER_SEC,
                            G_TEST_SUBPROCESS_INHERIT_STDOUT |
                            G_TEST_SUBPROCESS_INHERIT_STDERR);
     g_test_trap_assert_passed();
+    g_free(path);
+    g_free(subprocess_path);
 }
 
 static void destroy_pathv(void *arg)
@@ -239,6 +245,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     GString *cmd_line = g_string_new("");
     GString *cmd_line2 = g_string_new("");
 
+    path_vecs = g_slist_append(path_vecs, path_vec);
     path = qos_graph_get_node(node_name); /* root */
     node_name = qos_graph_edge_get_dest(path->path_edge); /* machine name */
 
@@ -298,15 +305,15 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     path_vec[0] = g_string_free(cmd_line, false);
 
     if (path->u.test.subprocess) {
-        gchar *subprocess_path = g_strdup_printf("/%s/%s/subprocess",
-                                                 qtest_get_arch(), path_str);
-        qtest_add_data_func_full(path_str, subprocess_path,
-                                 subprocess_run_one_test, g_free);
-        g_test_add_data_func_full(subprocess_path, path_vec,
-                                  run_one_test, destroy_pathv);
+        gchar *subprocess_path = g_strdup_printf("%s/%s", path_str,
+                                                 "subprocess");
+
+        qtest_add_data_func(path_str, path_vec, subprocess_run_one_test);
+        qtest_add_data_func(subprocess_path, path_vec, run_one_test);
+
+        g_free(subprocess_path);
     } else {
-        qtest_add_data_func_full(path_str, path_vec,
-                                 run_one_test, destroy_pathv);
+        qtest_add_data_func(path_str, path_vec, run_one_test);
     }
 
     g_free(path_str);
@@ -332,6 +339,13 @@ int main(int argc, char **argv, char** envp)
 
     if (g_test_subprocess()) {
         qos_printf("qos_test running single test in subprocess\n");
+
+        /*
+         * Although this invocation was done to run a single test in a
+         * subprocess, gtester doesn't expose the test name, so still
+         * execute the rest of main(), including adding all tests once
+         * more in order for g_test_run() to find the /subprocess.
+         */
     }
 
     if (g_test_verbose()) {
@@ -354,5 +368,6 @@ int main(int argc, char **argv, char** envp)
     qtest_end();
     qos_graph_destroy();
     g_free(old_path);
+    g_slist_free_full(path_vecs, (GDestroyNotify)destroy_pathv);
     return 0;
 }
-- 
2.35.3


