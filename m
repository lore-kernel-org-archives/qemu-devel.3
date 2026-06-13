Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F796CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUS0-0008Ve-TN; Sat, 13 Jun 2026 15:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYURq-0008Rp-26; Sat, 13 Jun 2026 15:55:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYURn-0004fO-R9; Sat, 13 Jun 2026 15:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380260; bh=L7RCWWMvQS+EFrMDUd1cQg3OODBBHJtF30sWO9d+Tds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w6O2a+ajSmo2TgJjg7dM5wwuV35Wer6GhFTO2V0pY4RSFfoS7HtjukKrdW55GjXnn
 jnZ6HP+RQDQ8HJqJ7+ah1+YCXZ7ICut8XUr7z/qRMzaXXxfXpxW+VjHAbDv5Yj1Q4X
 hYr9Nk3NPCAUGvm9tkwuvbyB98Wyz+T665NRJYjXBczbNTPZYYug/aoCbJDnCiSGMK
 LWebTgMYORLVNu/HtW153bLc3y6zvaOgqiUCM5quMPz9i1DvLVJwLQTu6sULmiz2UN
 MZ4Ga/7Avl1UfCt0LnRetKwR326byktT5ZPyl+5ZO/VQ4hVqxy6DNXW82tVdD1CoSE
 1ISYyCvAAO3kg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B54071B6E39;
 Sat, 13 Jun 2026 22:51:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 17F8B3CE8B3;
 Sat, 13 Jun 2026 22:51:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 42/56] util/envlist: fix prefix-match in
 envlist_unsetenv() name lookup
Date: Sat, 13 Jun 2026 22:50:56 +0300
Message-ID: <20260613195116.1807273-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

envlist_unsetenv() looked up the entry to remove with
strncmp(entry->ev_var, env, strlen(env)). The comparison length is
the requested name's length, so any stored entry whose name *starts*
with that name compares equal. envlist_setenv() inserts at the head
of the list, so the first hit wins: with FOO=... stored first and
FOOBAR=... stored afterward, envlist_unsetenv("FOO") iterates from
the head, matches FOOBAR=... on the prefix, and drops it instead of
FOO=...

linux-user and bsd-user reach this code via the -U command-line
switch, so the bug is reachable from a normal qemu-user invocation.

envlist_setenv() used the same strncmp pattern but with
envname_len = (eq_sign - env + 1), so the '=' byte sat inside the
compared window and acted as an implicit boundary. setenv was
therefore not buggy -- but the safety lived in the byte layout of
ev_var rather than in the entry, so a future edit could easily
drift the two sites apart again.

Store the name length on each entry at insertion time and compare
with explicit length equality plus memcmp via a small helper. Use
the helper at both lookup sites so the boundary becomes a
structural property of the entry: envlist_unsetenv() stops
prefix-matching, and envlist_setenv()'s self-search no longer
depends on the '=' byte serving as a sentinel.

Fixes: 04a6dfebb6b5 ("linux-user: Add generic env variable handling")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260520212628.479772-2-den@openvz.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit c131ae56c13ffe6bd7089cf0d9bd00a7c2dbc71f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/envlist.c b/util/envlist.c
index 15fdbb109d..196c92c190 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -3,7 +3,8 @@
 #include "qemu/envlist.h"
 
 struct envlist_entry {
-    const char *ev_var;            /* actual env value */
+    const char *ev_var;            /* actual env value: "NAME=VALUE" */
+    size_t ev_name_len;            /* length of NAME (offset of '=') */
     QLIST_ENTRY(envlist_entry) ev_link;
 };
 
@@ -12,6 +13,13 @@ struct envlist {
     size_t el_count;                        /* number of entries */
 };
 
+static inline bool envlist_name_eq(const struct envlist_entry *entry,
+                                   const char *name, size_t name_len)
+{
+    return entry->ev_name_len == name_len &&
+           memcmp(entry->ev_var, name, name_len) == 0;
+}
+
 /*
  * Allocates new envlist and returns pointer to it.
  */
@@ -67,7 +75,7 @@ envlist_setenv(envlist_t *envlist, const char *env)
     /* find out first equals sign in given env */
     if ((eq_sign = strchr(env, '=')) == NULL)
         return (EINVAL);
-    envname_len = eq_sign - env + 1;
+    envname_len = eq_sign - env;
 
     /*
      * If there already exists variable with given name
@@ -76,8 +84,9 @@ envlist_setenv(envlist_t *envlist, const char *env)
      */
     for (entry = envlist->el_entries.lh_first; entry != NULL;
         entry = entry->ev_link.le_next) {
-        if (strncmp(entry->ev_var, env, envname_len) == 0)
+        if (envlist_name_eq(entry, env, envname_len)) {
             break;
+        }
     }
 
     if (entry != NULL) {
@@ -90,6 +99,7 @@ envlist_setenv(envlist_t *envlist, const char *env)
 
     entry = g_malloc(sizeof(*entry));
     entry->ev_var = g_strdup(env);
+    entry->ev_name_len = envname_len;
     QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
 
     return (0);
@@ -119,8 +129,9 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
     envname_len = strlen(env);
     for (entry = envlist->el_entries.lh_first; entry != NULL;
         entry = entry->ev_link.le_next) {
-        if (strncmp(entry->ev_var, env, envname_len) == 0)
+        if (envlist_name_eq(entry, env, envname_len)) {
             break;
+        }
     }
     if (entry != NULL) {
         QLIST_REMOVE(entry, ev_link);
-- 
2.47.3


