Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001D7CCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDste-00031w-Ap; Tue, 28 Oct 2025 19:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDsta-000308-2I
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:30 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstM-00017j-0R
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:29 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 04FE281769;
 Wed, 29 Oct 2025 02:14:04 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-BtA4HKAb; Wed, 29 Oct 2025 02:14:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693243;
 bh=ZFgV8LSqGvshmmzDjsgrPq5Un6VZfE1YlTpXK2OqD6g=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wnZQgMS8XpHZ1SmrRO57vEULX1e/8gr+/WI4/BYmIwx5k8Jx8fYwYB+mLbR85NdAh
 K6PA8gnfTHiLRuRMkJ+Farkap96AcDQ3lk2i529HlFo6DGDW+RllHlQSSRUOebxmVL
 myxsJO6noQj8+u51TdKrPA1AFPhW5Nks1JE0dwqE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 17/22] migration/cpr: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:41 +0300
Message-ID: <20251028231347.194844-18-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/cpr.h |  4 ++--
 migration/cpr.c         | 32 ++++++++++++++------------------
 migration/migration.c   |  2 +-
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index a412d6663c..f930fdb5b0 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -41,8 +41,8 @@ MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
 
-int cpr_state_save(MigrationChannel *channel, Error **errp);
-int cpr_state_load(MigrationChannel *channel, Error **errp);
+bool cpr_state_save(MigrationChannel *channel, Error **errp);
+bool cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index 22dbac7c72..b8d6c0cead 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -176,9 +176,8 @@ bool cpr_is_incoming(void)
     return incoming_mode != MIG_MODE_NONE;
 }
 
-int cpr_state_save(MigrationChannel *channel, Error **errp)
+bool cpr_state_save(MigrationChannel *channel, Error **errp)
 {
-    int ret;
     QEMUFile *f;
     MigMode mode = migrate_mode();
 
@@ -190,19 +189,18 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     } else if (mode == MIG_MODE_CPR_EXEC) {
         f = cpr_exec_output(errp);
     } else {
-        return 0;
+        return true;
     }
     if (!f) {
-        return -1;
+        return false;
     }
 
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
 
-    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
-    if (ret) {
+    if (!vmstate_save_vmsd(f, &vmstate_cpr_state, &cpr_state, 0, errp)) {
         qemu_fclose(f);
-        return ret;
+        return false;
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
@@ -217,12 +215,11 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
                          NULL);
     cpr_state_file = f;
-    return 0;
+    return true;
 }
 
-int cpr_state_load(MigrationChannel *channel, Error **errp)
+bool cpr_state_load(MigrationChannel *channel, Error **errp)
 {
-    int ret;
     uint32_t v;
     QEMUFile *f;
     MigMode mode = 0;
@@ -238,10 +235,10 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         cpr_set_incoming_mode(mode);
         f = cpr_transfer_input(channel, errp);
     } else {
-        return 0;
+        return true;
     }
     if (!f) {
-        return -1;
+        return false;
     }
 
     trace_cpr_state_load(MigMode_str(mode));
@@ -251,19 +248,18 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     if (v != QEMU_CPR_FILE_MAGIC) {
         error_setg(errp, "Not a migration stream (bad magic %x)", v);
         qemu_fclose(f);
-        return -EINVAL;
+        return false;
     }
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_VERSION) {
         error_setg(errp, "Unsupported migration stream version %d", v);
         qemu_fclose(f);
-        return -ENOTSUP;
+        return false;
     }
 
-    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
-    if (ret) {
+    if (!vmstate_load_vmsd(f, &vmstate_cpr_state, &cpr_state, 1, errp)) {
         qemu_fclose(f);
-        return ret;
+        return false;
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
@@ -277,7 +273,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
      */
     cpr_state_file = f;
 
-    return ret;
+    return true;
 }
 
 void cpr_state_close(void)
diff --git a/migration/migration.c b/migration/migration.c
index a63b46bbef..c8a5712993 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2301,7 +2301,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (cpr_state_save(cpr_channel, &local_err)) {
+    if (!cpr_state_save(cpr_channel, &local_err)) {
         goto out;
     }
 
-- 
2.48.1


