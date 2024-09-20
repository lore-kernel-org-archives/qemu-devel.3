Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A848CF58E5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYHP-0008UI-OX; Fri, 20 Sep 2024 03:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYHF-0007iT-KI; Fri, 20 Sep 2024 03:42:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYHA-0000Fw-08; Fri, 20 Sep 2024 03:42:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D016A90860;
 Fri, 20 Sep 2024 10:41:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 729751409E3;
 Fri, 20 Sep 2024 10:41:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 10/22] envlist: Remove unused envlist_parse
Date: Fri, 20 Sep 2024 10:41:22 +0300
Message-Id: <20240920074134.664961-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920074134.664961-1-mjt@tls.msk.ru>
References: <20240920074134.664961-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

envlist_parse, envlist_parse_set, envlist_parse_unset were added
in 2009 but never used, see:
  04a6dfebb6 ("linux-user: Add generic env variable handling")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/envlist.h |  2 --
 util/envlist.c         | 69 ------------------------------------------
 2 files changed, 71 deletions(-)

diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h
index 6006dfae44..b2883f6659 100644
--- a/include/qemu/envlist.h
+++ b/include/qemu/envlist.h
@@ -7,8 +7,6 @@ envlist_t *envlist_create(void);
 void envlist_free(envlist_t *);
 int envlist_setenv(envlist_t *, const char *);
 int envlist_unsetenv(envlist_t *, const char *);
-int envlist_parse_set(envlist_t *, const char *);
-int envlist_parse_unset(envlist_t *, const char *);
 char **envlist_to_environ(const envlist_t *, size_t *);
 
 #endif /* ENVLIST_H */
diff --git a/util/envlist.c b/util/envlist.c
index db937c0427..15fdbb109d 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -12,9 +12,6 @@ struct envlist {
     size_t el_count;                        /* number of entries */
 };
 
-static int envlist_parse(envlist_t *envlist,
-    const char *env, int (*)(envlist_t *, const char *));
-
 /*
  * Allocates new envlist and returns pointer to it.
  */
@@ -51,72 +48,6 @@ envlist_free(envlist_t *envlist)
     g_free(envlist);
 }
 
-/*
- * Parses comma separated list of set/modify environment
- * variable entries and updates given enlist accordingly.
- *
- * For example:
- *     envlist_parse(el, "HOME=foo,SHELL=/bin/sh");
- *
- * inserts/sets environment variables HOME and SHELL.
- *
- * Returns 0 on success, errno otherwise.
- */
-int
-envlist_parse_set(envlist_t *envlist, const char *env)
-{
-    return (envlist_parse(envlist, env, &envlist_setenv));
-}
-
-/*
- * Parses comma separated list of unset environment variable
- * entries and removes given variables from given envlist.
- *
- * Returns 0 on success, errno otherwise.
- */
-int
-envlist_parse_unset(envlist_t *envlist, const char *env)
-{
-    return (envlist_parse(envlist, env, &envlist_unsetenv));
-}
-
-/*
- * Parses comma separated list of set, modify or unset entries
- * and calls given callback for each entry.
- *
- * Returns 0 in case of success, errno otherwise.
- */
-static int
-envlist_parse(envlist_t *envlist, const char *env,
-    int (*callback)(envlist_t *, const char *))
-{
-    char *tmpenv, *envvar;
-    char *envsave = NULL;
-    int ret = 0;
-    assert(callback != NULL);
-
-    if ((envlist == NULL) || (env == NULL))
-        return (EINVAL);
-
-    tmpenv = g_strdup(env);
-    envsave = tmpenv;
-
-    do {
-        envvar = strchr(tmpenv, ',');
-        if (envvar != NULL) {
-            *envvar = '\0';
-        }
-        if ((*callback)(envlist, tmpenv) != 0) {
-            ret = errno;
-            break;
-        }
-        tmpenv = envvar + 1;
-    } while (envvar != NULL);
-
-    g_free(envsave);
-    return ret;
-}
-
 /*
  * Sets environment value to envlist in similar manner
  * than putenv(3).
-- 
2.39.5


