Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9FCC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoOq-0006XR-Na; Thu, 27 Mar 2025 10:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOg-0006VL-5Q
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:55 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOd-0005aB-LJ
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EB902119B;
 Thu, 27 Mar 2025 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8Aa/7lfvtNeiQpq20QkviAb2ltlW4xgHZk21dTHB6U=;
 b=UjEExAtoQR38GnzeYdjkjJjCBmrqJRRoyKHwYeTJMuWDHi8cxcVV4YY9mkhlGj3MYsMO8V
 bwHf5g8SbSAzgmZeaWr12vh1CfEOlTja2rew2/t1nT0wBxTgE2lBA9N93rcUam4yzTIaOC
 3d54T+DBZonF/mKthyr7lYuV24LxM9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8Aa/7lfvtNeiQpq20QkviAb2ltlW4xgHZk21dTHB6U=;
 b=GQZPXPy3y8uicf6nYOFqXIVYGYjmwP5S9HVdVHkWMKk598Ag5HSz/qVlaXDIA5jcWtPF5j
 DaJEJjbjb58QM4Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UjEExAto;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GQZPXPy3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8Aa/7lfvtNeiQpq20QkviAb2ltlW4xgHZk21dTHB6U=;
 b=UjEExAtoQR38GnzeYdjkjJjCBmrqJRRoyKHwYeTJMuWDHi8cxcVV4YY9mkhlGj3MYsMO8V
 bwHf5g8SbSAzgmZeaWr12vh1CfEOlTja2rew2/t1nT0wBxTgE2lBA9N93rcUam4yzTIaOC
 3d54T+DBZonF/mKthyr7lYuV24LxM9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8Aa/7lfvtNeiQpq20QkviAb2ltlW4xgHZk21dTHB6U=;
 b=GQZPXPy3y8uicf6nYOFqXIVYGYjmwP5S9HVdVHkWMKk598Ag5HSz/qVlaXDIA5jcWtPF5j
 DaJEJjbjb58QM4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A1F3139D4;
 Thu, 27 Mar 2025 14:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GKiDFjBj5WcVZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:39:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, berrange@redhat.com,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 3/4] tests/qtest/migration: Add QMP helpers for snapshot
Date: Thu, 27 Mar 2025 11:39:33 -0300
Message-Id: <20250327143934.7935-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327143934.7935-1-farosas@suse.de>
References: <20250327143934.7935-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9EB902119B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add helpers to call QMP snapshot commands and monitor the snapshot
job.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-qmp.c | 120 ++++++++++++++++++++++++++
 tests/qtest/migration/migration-qmp.h |   4 +
 2 files changed, 124 insertions(+)

diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index fb59741b2c..f5941e9473 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -518,3 +518,123 @@ void migrate_postcopy_start(QTestState *from, QTestState *to,
     wait_for_stop(from, src_state);
     qtest_qmp_eventwait(to, "RESUME");
 }
+
+static void job_status_wait(QTestState *s, const char *id, const char *target)
+{
+    QDict *response, *data;
+    const char *status, *name;
+    bool found;
+
+    do {
+        response = qtest_qmp_eventwait_ref(s, "JOB_STATUS_CHANGE");
+        data = qdict_get_qdict(response, "data");
+        g_assert(data);
+
+        name = qdict_get_str(data, "id");
+        if (g_str_equal(name, id)) {
+            status = qdict_get_str(data, "status");
+            found = (strcmp(status, target) == 0);
+        }
+
+        qobject_unref(response);
+    } while (!found);
+}
+
+static bool job_check_status(QTestState *qts, const char *id, char **msg)
+{
+    QDict *rsp, *info;
+    QList *list;
+    const QListEntry *p;
+    gchar *status;
+    const char *job_msg, *job_id;
+
+    rsp = qtest_qmp(qts, "{ 'execute': 'query-jobs' }");
+    g_assert(rsp);
+    g_assert(qdict_haskey(rsp, "return"));
+
+    list = qdict_get_qlist(rsp, "return");
+    g_assert(list);
+
+    for (p = qlist_first(list); p; p = qlist_next(p)) {
+        info = qobject_to(QDict, qlist_entry_obj(p));
+
+        g_assert(qdict_haskey(info, "id"));
+        job_id = qdict_get_str(info, "id");
+
+        if (g_str_equal(job_id, id)) {
+            break;
+        }
+    }
+
+    /* otherwise job not found */
+    g_assert(p);
+
+    g_assert(qdict_haskey(info, "status"));
+    status = g_strdup(qdict_get_str(info, "status"));
+    g_assert(g_str_equal(status, "concluded"));
+
+    if (qdict_haskey(info, "error")) {
+        job_msg = qdict_get_str(info, "error");
+
+        g_assert(msg);
+        *msg = g_strdup(job_msg);
+
+        return false;
+    }
+
+    qobject_unref(rsp);
+
+    return true;
+}
+
+static void snapshot_cmd_qmp(QTestState *qts, const char *cmd, const char *id)
+{
+    if (g_str_equal(cmd, "snapshot-delete")) {
+        qtest_qmp_assert_success(qts, "{ 'execute': %s,"
+                                 "'arguments': { "
+                                 "'job-id': %s,"
+                                 "'tag': 'my-snap',"
+                                 "'devices': [ 'disk0' ] } }",
+                                 cmd, id);
+    } else {
+        qtest_qmp_assert_success(qts, "{ 'execute': %s,"
+                                 "'arguments': { "
+                                 "'job-id': %s,"
+                                 "'tag': 'my-snap',"
+                                 "'devices': [ 'disk0' ],"
+                                 "'vmstate': 'disk0' } }",
+                                 cmd, id);
+    }
+}
+
+static bool snapshot_cmd_qmp_sync(QTestState *qts, const char *cmd, const char* id,
+                                  char **error_str)
+{
+    bool ret;
+
+    snapshot_cmd_qmp(qts, cmd, id);
+    job_status_wait(qts, id, "concluded");
+    ret = job_check_status(qts, id, error_str);
+
+    qtest_qmp_assert_success(qts,
+                             "{ 'execute': 'job-dismiss',"
+                             "'arguments': { "
+                             "'id': %s } }", id);
+    return ret;
+}
+
+bool snapshot_delete_qmp_sync(QTestState *qts, char **error_str)
+{
+    return snapshot_cmd_qmp_sync(qts, "snapshot-delete", "snapdelete0",
+                                 error_str);
+}
+
+bool snapshot_load_qmp_sync(QTestState *qts, char **error_str)
+{
+    return snapshot_cmd_qmp_sync(qts, "snapshot-load", "snapload0", error_str);
+}
+
+bool snapshot_save_qmp_sync(QTestState *qts, char **error_str)
+{
+    return snapshot_cmd_qmp_sync(qts, "snapshot-save", "snapsave0", error_str);
+}
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index faa8181d91..9033828f7d 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -44,5 +44,9 @@ void migrate_recover(QTestState *who, const char *uri);
 void migrate_cancel(QTestState *who);
 void migrate_postcopy_start(QTestState *from, QTestState *to,
                             QTestMigrationState *src_state);
+bool snapshot_delete_qmp_sync(QTestState *qts, char **error_str);
+bool snapshot_load_qmp_sync(QTestState *qts, char **error_str);
+bool snapshot_save_qmp_sync(QTestState *qts, char **error_str);
+
 
 #endif /* MIGRATION_QMP_H */
-- 
2.35.3


