Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15B3C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2uge-0008FK-B9; Thu, 10 Apr 2025 12:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2ugF-00084q-LH
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:23:10 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2ugB-0005Ab-I6
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:23:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:4191:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6A29560A8B;
 Thu, 10 Apr 2025 19:22:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7307::1:35])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pMixuJ0FWKo0-FZ4U6JzA; Thu, 10 Apr 2025 19:22:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744302172;
 bh=MEdXn7sF1X4QjPkzyIN4nH+fBSR09PGlksbNeGt5ffs=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=W3D2ndpbN7P1PLghUsdFGKkEZy8tuPac9m9B0jhNF/dprs/BR7A6nSsYEW6Ttfz7F
 PTJ8QxSP1u2pcjT8t3TWSV8jmH7vC6GsMU0ct2x2gUYMupLngjBqx2qAsWijmJiPCV
 JcI9xJoEDi7EnatS2qzLbSrMg3k6N8PgW7Fp9mII=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, lvivier@redhat.com,
 farosas@suse.de, vsementsov@yandex-team.ru
Subject: [PATCH] [for-10.1] qtest: introduce qtest_init_ext
Date: Thu, 10 Apr 2025 19:22:50 +0300
Message-ID: <20250410162250.329941-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 tests/qtest/libqtest.c            | 18 +++++-------------
 tests/qtest/libqtest.h            | 30 +++++++-----------------------
 tests/qtest/migration/framework.c |  7 +++----
 3 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index fad307d125..66ff318201 100644
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
- * @var: Environment variable from where to take the QEMU binary
- * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
- * arguments are subject to word splitting and shell evaluation.
- * @do_connect: connect to qemu monitor and qtest socket.
- *
- * Like qtest_init(), but use a different environment variable for the
- * QEMU binary.
- *
- * Returns: #QTestState instance.
- */
-QTestState *qtest_init_with_env(const char *var, const char *extra_args,
-                                bool do_connect);
-
-/**
- * qtest_init_with_env_and_capabilities:
+ * qtest_init_ext:
  * @var: Environment variable from where to take the QEMU binary
  * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
  * @capabilities: list of QMP capabilities (strings) to enable
  * @do_connect: connect to qemu monitor and qtest socket.
  *
- * Like qtest_init_with_env(), but enable specified capabilities during
- * hadshake.
+ * Like qtest_init(), but use a different environment variable for the
+ * QEMU binary, allow specify capabilities and skip connecting
+ * to QEMU monitor.
  *
  * Returns: #QTestState instance.
  */
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
index 10e1d04b58..1802304e1d 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -336,8 +336,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init_with_env_and_capabilities(QEMU_ENV_SRC, cmd_source,
-                                                     capabilities, true);
+        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
@@ -365,8 +364,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
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
2.48.1


