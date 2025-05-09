Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD353C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 21:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDV74-0004sP-Ry; Fri, 09 May 2025 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV71-0004rU-0K
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:31 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV6y-0004K8-V7
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F56F1F390;
 Fri,  9 May 2025 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaW8DzY7vXOWCpCXZ2QTdfLi7GLd7A6j8dye4TJUaNQ=;
 b=CRIWkq45bsPVUoAc22gEMlmsyuMWo8kp0+yU9/iUWoHWcb4lEJZS6wPSgPu750pmbvytoi
 rFGJzwcP9xfXgdeqiohpzwz8/sVP525PcTi3KwSOPPEsaoFIhyQqsEfKGJ+jpJzdDZ+YCX
 DlDilaargMc5z5kdUQXcAtkglXyOCmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaW8DzY7vXOWCpCXZ2QTdfLi7GLd7A6j8dye4TJUaNQ=;
 b=9DAYTLp/HNMDwAK9fH6L0lG1DuJNKdBK7+PXmdwk1GCHQicJm2bGfQjC2ZBmbyfPXvlnx3
 JsXOcdMoMoSNTGDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CRIWkq45;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9DAYTLp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaW8DzY7vXOWCpCXZ2QTdfLi7GLd7A6j8dye4TJUaNQ=;
 b=CRIWkq45bsPVUoAc22gEMlmsyuMWo8kp0+yU9/iUWoHWcb4lEJZS6wPSgPu750pmbvytoi
 rFGJzwcP9xfXgdeqiohpzwz8/sVP525PcTi3KwSOPPEsaoFIhyQqsEfKGJ+jpJzdDZ+YCX
 DlDilaargMc5z5kdUQXcAtkglXyOCmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaW8DzY7vXOWCpCXZ2QTdfLi7GLd7A6j8dye4TJUaNQ=;
 b=9DAYTLp/HNMDwAK9fH6L0lG1DuJNKdBK7+PXmdwk1GCHQicJm2bGfQjC2ZBmbyfPXvlnx3
 JsXOcdMoMoSNTGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D242613931;
 Fri,  9 May 2025 21:18:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uPQWIyFxHmjkNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 May 2025 21:18:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 1/3] qtest: introduce qtest_init_ext
Date: Fri,  9 May 2025 18:18:19 -0300
Message-Id: <20250509211821.23684-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250509211821.23684-1-farosas@suse.de>
References: <20250509211821.23684-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F56F1F390
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Merge qtest_init_with_env_and_capabilities() and qtest_init_with_env()
into one qtest_init_ext().

Reasons:

1. qtest_init_with_env() is just wrong: it gets do_connect parameter
   but always pass true to qtest_init_with_env_and_capabilities().
   Happily, all qtest_init_with_env() callers pass true as well.

2. qtest_init_with_env() is not used outside of libqtest.c, so no
   reason to keep it as public function

3. and in libqtest.c it's used not often, so no problem to use
   more generic function instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250410162250.329941-1-vsementsov@yandex-team.ru>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c            | 18 +++++-------------
 tests/qtest/libqtest.h            | 30 +++++++-----------------------
 tests/qtest/migration/framework.c |  7 +++----
 3 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 358580361d..94526b7f9c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -574,10 +574,8 @@ void qtest_qmp_handshake(QTestState *s, QList *capabilities)
     }
 }
 
-QTestState *qtest_init_with_env_and_capabilities(const char *var,
-                                                 const char *extra_args,
-                                                 QList *capabilities,
-                                                 bool do_connect)
+QTestState *qtest_init_ext(const char *var, const char *extra_args,
+                           QList *capabilities, bool do_connect)
 {
     QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
                                         do_connect);
@@ -594,15 +592,9 @@ QTestState *qtest_init_with_env_and_capabilities(const char *var,
     return s;
 }
 
-QTestState *qtest_init_with_env(const char *var, const char *extra_args,
-                                bool do_connect)
-{
-    return qtest_init_with_env_and_capabilities(var, extra_args, NULL, true);
-}
-
 QTestState *qtest_init(const char *extra_args)
 {
-    return qtest_init_with_env(NULL, extra_args, true);
+    return qtest_init_ext(NULL, extra_args, NULL, true);
 }
 
 QTestState *qtest_vinitf(const char *fmt, va_list ap)
@@ -1662,7 +1654,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(qemu_var, "-machine none", true);
+    qts = qtest_init_ext(qemu_var, "-machine none", NULL, true);
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
@@ -1717,7 +1709,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(NULL, "-machine none", true);
+    qts = qtest_init_ext(NULL, "-machine none", NULL, true);
     response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 930a91dcb7..b3f2e7fbef 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -57,37 +57,21 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 QTestState *qtest_init(const char *extra_args);
 
 /**
- * qtest_init_with_env:
+ * qtest_init_ext:
  * @var: Environment variable from where to take the QEMU binary
  * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
+ * @capabilities: list of QMP capabilities (strings) to enable
  * @do_connect: connect to qemu monitor and qtest socket.
  *
  * Like qtest_init(), but use a different environment variable for the
- * QEMU binary.
+ * QEMU binary, allow specify capabilities and skip connecting
+ * to QEMU monitor.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_with_env(const char *var, const char *extra_args,
-                                bool do_connect);
-
-/**
- * qtest_init_with_env_and_capabilities:
- * @var: Environment variable from where to take the QEMU binary
- * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
- * arguments are subject to word splitting and shell evaluation.
- * @capabilities: list of QMP capabilities (strings) to enable
- * @do_connect: connect to qemu monitor and qtest socket.
- *
- * Like qtest_init_with_env(), but enable specified capabilities during
- * hadshake.
- *
- * Returns: #QTestState instance.
- */
-QTestState *qtest_init_with_env_and_capabilities(const char *var,
-                                                 const char *extra_args,
-                                                 QList *capabilities,
-                                                 bool do_connect);
+QTestState *qtest_init_ext(const char *var, const char *extra_args,
+                           QList *capabilities, bool do_connect);
 
 /**
  * qtest_init_without_qmp_handshake:
@@ -102,7 +86,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
  * qtest_connect
  * @s: #QTestState instance to connect
  * Connect to qemu monitor and qtest socket, after skipping them in
- * qtest_init_with_env.  Does not handshake with the monitor.
+ * qtest_init_ext.  Does not handshake with the monitor.
  */
 void qtest_connect(QTestState *s);
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index e48b80a127..407c9023c0 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -382,8 +382,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init_with_env_and_capabilities(QEMU_ENV_SRC, cmd_source,
-                                                     capabilities, true);
+        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
@@ -411,8 +410,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_with_env_and_capabilities(QEMU_ENV_DST, cmd_target,
-                                               capabilities, !args->defer_target_connect);
+    *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
+                         !args->defer_target_connect);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
-- 
2.35.3


