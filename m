Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDA5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44nw-00026o-1n; Wed, 01 Oct 2025 17:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44nu-00025U-S5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:56:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44ng-0006QD-9V
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:56:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E3A033776;
 Wed,  1 Oct 2025 21:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYbF+mK6+XSmJY4HiMNqIX50UUS762vpm0ptrwaOcsw=;
 b=X30zZzBS0+egwqKPgrUBAydb1oh3HqyC80OEKJ8Uulyh+fat84heH6gyNgGfyYkjVqB3ev
 FKtVei4NyisXCres3NkQ1RXXHdBokze7VR5Exm7tho0ciqMUuR9LsxS+xeyc0P8qvszaIS
 JHKVwONQa1icGJfAlgLNbJI6VfbWkn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYbF+mK6+XSmJY4HiMNqIX50UUS762vpm0ptrwaOcsw=;
 b=YIEv62c9DE6hdwGIEZ0xfOBQ7ENnK8BmAr6+lUokdjWcwfXa3qyI9IO67zRKYsMritdgUD
 RnZTEQP0N9gl0LCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYbF+mK6+XSmJY4HiMNqIX50UUS762vpm0ptrwaOcsw=;
 b=X30zZzBS0+egwqKPgrUBAydb1oh3HqyC80OEKJ8Uulyh+fat84heH6gyNgGfyYkjVqB3ev
 FKtVei4NyisXCres3NkQ1RXXHdBokze7VR5Exm7tho0ciqMUuR9LsxS+xeyc0P8qvszaIS
 JHKVwONQa1icGJfAlgLNbJI6VfbWkn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYbF+mK6+XSmJY4HiMNqIX50UUS762vpm0ptrwaOcsw=;
 b=YIEv62c9DE6hdwGIEZ0xfOBQ7ENnK8BmAr6+lUokdjWcwfXa3qyI9IO67zRKYsMritdgUD
 RnZTEQP0N9gl0LCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE10313A3F;
 Wed,  1 Oct 2025 21:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aOBhI8Gi3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 05/13] tests/qtest: qtest_qemu_args
Date: Wed,  1 Oct 2025 18:52:46 -0300
Message-Id: <20251001215254.2863-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Define an accessor that returns all the arguments used to exec QEMU.
Collect the arguments that were passed to qtest_spawn_qemu, plus the trace
arguments that were composed inside qtest_spawn_qemu, and move them to a
new function qtest_qemu_args.

This will be needed to test the cpr-exec migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-11-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 54 ++++++++++++++++++++++++------------------
 tests/qtest/libqtest.h |  8 +++++++
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 6f76be12a4..551bc8c1b8 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -409,20 +409,12 @@ static pid_t qtest_create_process(char *cmd)
 }
 #endif /* _WIN32 */
 
-static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
-                                                        const char *fmt, ...)
+static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
 {
-    va_list ap;
     QTestState *s = g_new0(QTestState, 1);
-    const char *trace = g_getenv("QTEST_TRACE");
-    g_autofree char *tracearg = trace ?
-        g_strdup_printf("-trace %s ", trace) : g_strdup("");
     g_autoptr(GString) command = g_string_new("");
 
-    va_start(ap, fmt);
-    g_string_append_printf(command, CMD_EXEC "%s %s", qemu_bin, tracearg);
-    g_string_append_vprintf(command, fmt, ap);
-    va_end(ap);
+    g_string_printf(command, CMD_EXEC "%s %s", qemu_bin, args);
 
     qtest_add_abrt_handler(kill_qemu_hook_func, s);
 
@@ -466,6 +458,33 @@ static char *qtest_socket_path(const char *suffix)
     return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix);
 }
 
+gchar *qtest_qemu_args(const char *extra_args)
+{
+    g_autofree gchar *socket_path = qtest_socket_path("sock");
+    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
+    const char *trace = g_getenv("QTEST_TRACE");
+    g_autofree char *tracearg = trace ? g_strdup_printf("-trace %s ", trace) :
+                                        g_strdup("");
+    gchar *args = g_strdup_printf(
+                      "%s"
+                      "-qtest unix:%s "
+                      "-qtest-log %s "
+                      "-chardev socket,path=%s,id=char0 "
+                      "-mon chardev=char0,mode=control "
+                      "-display none "
+                      "-audio none "
+                      "%s"
+                      " -accel qtest",
+
+                      tracearg,
+                      socket_path,
+                      getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
+                      qmp_socket_path,
+                      extra_args ?: "");
+
+    return args;
+}
+
 static QTestState *qtest_init_internal(const char *qemu_bin,
                                        const char *extra_args,
                                        bool do_connect)
@@ -474,6 +493,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     int sock, qmpsock, i;
     g_autofree gchar *socket_path = qtest_socket_path("sock");
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
+    g_autofree gchar *args = qtest_qemu_args(extra_args);
 
     /*
      * It's possible that if an earlier test run crashed it might
@@ -488,19 +508,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-    s = qtest_spawn_qemu(qemu_bin,
-                         "-qtest unix:%s "
-                         "-qtest-log %s "
-                         "-chardev socket,path=%s,id=char0 "
-                         "-mon chardev=char0,mode=control "
-                         "-display none "
-                         "-audio none "
-                         "%s"
-                         " -accel qtest",
-                         socket_path,
-                         getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
-                         qmp_socket_path,
-                         extra_args ?: "");
+    s = qtest_spawn_qemu(qemu_bin, args);
 
     qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index dc2cdd0b60..7f8dd0a912 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -56,6 +56,14 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
  */
 const char *qtest_qemu_binary(const char *var);
 
+/**
+ * qtest_qemu_args:
+ * @extra_args: Other arguments to pass to QEMU.
+ *
+ * Return the command line used to start QEMU, sans binary.
+ */
+gchar *qtest_qemu_args(const char *extra_args);
+
 /**
  * qtest_init:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
-- 
2.35.3


