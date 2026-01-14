Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBC7D37E32
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0qk-0006uq-1j; Wed, 14 Jan 2026 08:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qP-0006YF-Cc
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:30 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qN-0006if-D8
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24D825C66B;
 Wed, 14 Jan 2026 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768396999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNQTdQp3G977GJsacAmbdN8CKP9bd2OWQw4XQhW6u44=;
 b=DCtYpSwDdkVeOVgfNtnZBPRjQ3u7e8QVjSFCzN2s27SkzPUoWANLn6MJMney4mZgm42dwD
 e2RGpgxOeod7EszGbNHkafCbmrG1kNIEeUH2GUC1DmGcXExkzEOfLNqab5GNZUT/C5OXJT
 xtEPWfv/csNv9wj8TiVZycKr47scMbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768396999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNQTdQp3G977GJsacAmbdN8CKP9bd2OWQw4XQhW6u44=;
 b=5wJDjlQPTocGH5Qhw+NwZrkE/lvB3Qj161oLCdkuqqikhbu/D/V5RPYXFKcmrZc7cWuVHm
 /Zv9p8+5aZgJqmBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DCtYpSwD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5wJDjlQP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768396999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNQTdQp3G977GJsacAmbdN8CKP9bd2OWQw4XQhW6u44=;
 b=DCtYpSwDdkVeOVgfNtnZBPRjQ3u7e8QVjSFCzN2s27SkzPUoWANLn6MJMney4mZgm42dwD
 e2RGpgxOeod7EszGbNHkafCbmrG1kNIEeUH2GUC1DmGcXExkzEOfLNqab5GNZUT/C5OXJT
 xtEPWfv/csNv9wj8TiVZycKr47scMbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768396999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNQTdQp3G977GJsacAmbdN8CKP9bd2OWQw4XQhW6u44=;
 b=5wJDjlQPTocGH5Qhw+NwZrkE/lvB3Qj161oLCdkuqqikhbu/D/V5RPYXFKcmrZc7cWuVHm
 /Zv9p8+5aZgJqmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A3FE3EA63;
 Wed, 14 Jan 2026 13:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2N7IFsWYZ2nxBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 13:23:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, armbru@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 3/5] qapi: Implement qapi_dealloc_present_visitor
Date: Wed, 14 Jan 2026 10:23:07 -0300
Message-ID: <20260114132309.5832-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114132309.5832-1-farosas@suse.de>
References: <20260114132309.5832-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 24D825C66B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Implement a visitor that frees the pointer members of the visited QAPI
object in the same way that qapi_dealloc_visitor does, but similarly
to qobject_input_visitor, takes an input QObject that will dictate
which members get freed and which don't. Members not present in the
input QObject will be left unchanged in the visited QAPI object.

This is useful to free memory just before perfoming a visit with
qobject_input_visitor on a pre-existing, non-null QAPI object. If the
same QObject is passed to both visitors, the pointers overwritten by
the input visitor match the ones that are freed by the dealloc
visitor.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qapi/dealloc-visitor.h |   6 ++
 qapi/qapi-dealloc-visitor.c    | 173 ++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/include/qapi/dealloc-visitor.h b/include/qapi/dealloc-visitor.h
index c36715fdf3..96c7bf35c3 100644
--- a/include/qapi/dealloc-visitor.h
+++ b/include/qapi/dealloc-visitor.h
@@ -25,4 +25,10 @@ typedef struct QapiDeallocVisitor QapiDeallocVisitor;
  */
 Visitor *qapi_dealloc_visitor_new(void);
 
+/*
+ * Like qapi_dealloc_visitor_new but visits a QObject and only frees
+ * present members.
+ */
+Visitor *qapi_dealloc_present_visitor_new(QObject *);
+
 #endif
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index 57a2c904bb..90b017cc93 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -14,14 +14,146 @@
 
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
+#include "qemu/queue.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qobject/qnull.h"
 #include "qapi/visitor-impl.h"
 
+typedef struct QStackEntry {
+    QObject *obj;               /* QDict or QList being visited */
+    void *qapi;
+    const QListEntry *entry;    /* If @obj is QList: unvisited tail */
+    QSLIST_ENTRY(QStackEntry) node;
+} QStackEntry;
+
 struct QapiDeallocVisitor
 {
     Visitor visitor;
+    QObject *root;
+    QSLIST_HEAD(, QStackEntry) stack;
 };
 
+static void qapi_dealloc_pop(Visitor *v, void **obj)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
+
+    assert(se && se->qapi == obj);
+    QSLIST_REMOVE_HEAD(&qdv->stack, node);
+    g_free(se);
+}
+
+static void qapi_dealloc_push(Visitor *v, QObject *obj, void *qapi)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+    QStackEntry *se = g_new0(QStackEntry, 1);
+
+    assert(obj);
+    se->obj = obj;
+    se->qapi = qapi;
+
+    if (qobject_type(obj) == QTYPE_QLIST) {
+        se->entry = qlist_first(qobject_to(QList, obj));
+    }
+
+    QSLIST_INSERT_HEAD(&qdv->stack, se, node);
+}
+
+static QObject *qapi_dealloc_try_get_object(QapiDeallocVisitor *qdv, const char *name)
+{
+    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
+    QObject *qobj;
+    QObject *ret = NULL;
+
+    if (!se) {
+        assert(qdv->root);
+        return qdv->root;
+    }
+
+    qobj = se->obj;
+    assert(qobj);
+
+    if (qobject_type(qobj) == QTYPE_QDICT) {
+        assert(name);
+        ret = qdict_get(qobject_to(QDict, qobj), name);
+    } else {
+        assert(qobject_type(qobj) == QTYPE_QLIST);
+        assert(!name);
+        if (se->entry) {
+            ret = qlist_entry_obj(se->entry);
+        }
+    }
+
+    return ret;
+}
+
+static bool qapi_dealloc_present_start_struct(Visitor *v, const char *name,
+                                              void **obj, size_t size,
+                                              Error **errp)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+    QObject *qobj = qapi_dealloc_try_get_object(qdv, name);
+
+    if (!qobj) {
+        return false;
+    }
+    assert(qobject_type(qobj) == QTYPE_QDICT);
+    qapi_dealloc_push(v, qobj, obj);
+    return true;
+}
+
+static void qapi_dealloc_present_end_struct(Visitor *v, void **obj)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
+
+    assert(qobject_type(se->obj) == QTYPE_QDICT);
+    qapi_dealloc_pop(v, obj);
+
+    if (obj) {
+        g_free(*obj);
+    }
+}
+
+static bool qapi_dealloc_present_start_list(Visitor *v, const char *name,
+                                            GenericList **list, size_t size,
+                                            Error **errp)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+    QObject *qobj = qapi_dealloc_try_get_object(qdv, name);
+
+    if (!qobj) {
+        return false;
+    }
+    assert(qobject_type(qobj) == QTYPE_QLIST);
+    qapi_dealloc_push(v, qobj, list);
+    return true;
+}
+
+static void qapi_dealloc_present_end_list(Visitor *v, void **obj)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
+
+    assert(qobject_type(se->obj) == QTYPE_QLIST);
+    qapi_dealloc_pop(v, obj);
+}
+
+static void qapi_dealloc_present_free(Visitor *v)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+
+    while (!QSLIST_EMPTY(&qdv->stack)) {
+        QStackEntry *se = QSLIST_FIRST(&qdv->stack);
+
+        QSLIST_REMOVE_HEAD(&qdv->stack, node);
+        g_free(se);
+    }
+    qobject_unref(qdv->root);
+    g_free(qdv);
+}
+
 static bool qapi_dealloc_start_struct(Visitor *v, const char *name, void **obj,
                                       size_t unused, Error **errp)
 {
@@ -35,6 +167,21 @@ static void qapi_dealloc_end_struct(Visitor *v, void **obj)
     }
 }
 
+static bool qapi_dealloc_start_alternate(Visitor *v, const char *name,
+                                         GenericAlternate **obj, size_t size,
+                                         Error **errp)
+{
+    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
+    QObject *qobj = qapi_dealloc_try_get_object(qdv, name);
+
+    if (!qobj) {
+        return false;
+    }
+    assert(*obj);
+    (*obj)->type = qobject_type(qobj);
+    return true;
+}
+
 static void qapi_dealloc_end_alternate(Visitor *v, void **obj)
 {
     if (obj) {
@@ -117,13 +264,14 @@ static void qapi_dealloc_free(Visitor *v)
     g_free(container_of(v, QapiDeallocVisitor, visitor));
 }
 
-Visitor *qapi_dealloc_visitor_new(void)
+static QapiDeallocVisitor *qapi_dealloc_visitor_new_base(void)
 {
     QapiDeallocVisitor *v;
 
     v = g_malloc0(sizeof(*v));
 
     v->visitor.type = VISITOR_DEALLOC;
+
     v->visitor.start_struct = qapi_dealloc_start_struct;
     v->visitor.end_struct = qapi_dealloc_end_struct;
     v->visitor.end_alternate = qapi_dealloc_end_alternate;
@@ -139,5 +287,28 @@ Visitor *qapi_dealloc_visitor_new(void)
     v->visitor.type_null = qapi_dealloc_type_null;
     v->visitor.free = qapi_dealloc_free;
 
+    return v;
+}
+
+Visitor *qapi_dealloc_visitor_new(void)
+{
+    QapiDeallocVisitor *v = qapi_dealloc_visitor_new_base();
+
+    return &v->visitor;
+}
+
+Visitor *qapi_dealloc_present_visitor_new(QObject *obj)
+{
+    QapiDeallocVisitor *v = qapi_dealloc_visitor_new_base();
+
+    v->visitor.start_alternate = qapi_dealloc_start_alternate;
+    v->visitor.start_list = qapi_dealloc_present_start_list;
+    v->visitor.end_list = qapi_dealloc_present_end_list;
+    v->visitor.start_struct = qapi_dealloc_present_start_struct;
+    v->visitor.end_struct = qapi_dealloc_present_end_struct;
+    v->visitor.free = qapi_dealloc_present_free;
+
+    v->root = qobject_ref(obj);
+
     return &v->visitor;
 }
-- 
2.51.0


