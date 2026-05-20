Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77273CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoR0-0006iD-MP; Wed, 20 May 2026 17:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPoQz-0006hy-7B
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:26:33 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPoQx-0005YG-CN
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=C9VDCBZBoAIEzbXAJnmyhl/vTrWXdh18LhUxlVY1cCU=; b=KZcyV53G9D+X
 FxMKO6vNeBJy2XcZieLiR8QrvEsPwpF2lC3WnYITFCpTJnUbiHAeSeERLvKmFmnLC04zWRIqVnwbc
 Qtb0wNXjxqWZH7nr9hoN1RaWA69bjpCB4mVo0XjkDneqj9Kp/vUNa+LjviuY00bWeZe11aidcppmj
 fHfhDIO3Tk3fS8BC9pOobCM8oPMzCqrsXL3honoRIvcijB/H/MAlbJxoy8rrPSMBZHOcsO5TCeZA0
 s0TPRT9A9XS0oDluUsTMI8y0l9SfNwAkRDRCb1BUy9XDmrE0R/9aWY++AcGGW1/+CReCNHOe2qHDe
 +v6Ek3oq/b0lHRPLL5yEzw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8]
 helo=iris.astra-academy.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wPoNa-003Cdo-0d;
 Wed, 20 May 2026 23:26:28 +0200
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] util/envlist: fix prefix-match in envlist_unsetenv() name
 lookup
Date: Wed, 20 May 2026 23:26:27 +0200
Message-ID: <20260520212628.479772-2-den@openvz.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520212628.479772-1-den@openvz.org>
References: <20260520212628.479772-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 util/envlist.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

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
2.51.0


