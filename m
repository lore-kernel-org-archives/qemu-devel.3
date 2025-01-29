Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C5EC02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWP-0004Bp-U3; Wed, 29 Jan 2025 11:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW2-0003YV-8a
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW0-0005NZ-BH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:09 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E53C1F365;
 Wed, 29 Jan 2025 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPfLlcV5lpOA+fgRPN8dIAoJoP4HcL/I1+65LvMu2ao=;
 b=T8bYsq+D+y3hlqa/C+SeXw00jqME+wcbIkdfLmsfxHpwrBrv/SbiMamLsFKmCc8WrZ3tyS
 MMyXWFSXB7KIBuRYtU5abC1vVD5G/ni71xretZPu4Fr7SylC1TSDqlKZjXcNvYGNRzxAtk
 pcWci4dvfJDcgY9TgYNbIoRUr3aab6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPfLlcV5lpOA+fgRPN8dIAoJoP4HcL/I1+65LvMu2ao=;
 b=VDiLJEqy/xMTbl1nRvD1PazeiYVeyIJon7CZBpek7uD4po0XGCyOPIYbXoUPKMfSLb2Ieq
 1H4wn75oIFidwxAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPfLlcV5lpOA+fgRPN8dIAoJoP4HcL/I1+65LvMu2ao=;
 b=T8bYsq+D+y3hlqa/C+SeXw00jqME+wcbIkdfLmsfxHpwrBrv/SbiMamLsFKmCc8WrZ3tyS
 MMyXWFSXB7KIBuRYtU5abC1vVD5G/ni71xretZPu4Fr7SylC1TSDqlKZjXcNvYGNRzxAtk
 pcWci4dvfJDcgY9TgYNbIoRUr3aab6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPfLlcV5lpOA+fgRPN8dIAoJoP4HcL/I1+65LvMu2ao=;
 b=VDiLJEqy/xMTbl1nRvD1PazeiYVeyIJon7CZBpek7uD4po0XGCyOPIYbXoUPKMfSLb2Ieq
 1H4wn75oIFidwxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A284A137DB;
 Wed, 29 Jan 2025 16:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2AV4GP1QmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 31/42] migration: Synchronize all CPU states only for
 non-iterable dump
Date: Wed, 29 Jan 2025 13:00:48 -0300
Message-Id: <20250129160059.6987-32-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

From: Peter Xu <peterx@redhat.com>

Do one shot cpu sync at qemu_savevm_state_complete_precopy_non_iterable(),
instead of coding it separately in two places.

Note that in the context of qemu_savevm_state_complete_precopy(), this
patch is also an optimization for postcopy path, in that we can avoid sync
cpu twice during switchover: before this patch, postcopy_start() invokes
twice on qemu_savevm_state_complete_precopy(), each of them will try to
sync CPU info.  In reality, only one of them would be enough.

For background snapshot, there's no intended functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-7-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 6 +-----
 migration/savevm.c    | 5 +++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d8a6bc12e0..46e30a4814 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3749,11 +3749,7 @@ static void *bg_migration_thread(void *opaque)
     if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
         goto fail;
     }
-    /*
-     * Put vCPUs in sync with shadow context structures, then
-     * save their state to channel-buffer along with devices.
-     */
-    cpu_synchronize_all_states();
+
     if (qemu_savevm_state_complete_precopy_non_iterable(fb, false)) {
         goto fail;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 5e56a5d9fc..92e77ca92b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1531,6 +1531,9 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     Error *local_err = NULL;
     int ret;
 
+    /* Making sure cpu states are synchronized before saving non-iterable */
+    cpu_synchronize_all_states();
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             /* Already saved during qemu_savevm_state_setup(). */
@@ -1584,8 +1587,6 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 
     trace_savevm_state_complete_precopy();
 
-    cpu_synchronize_all_states();
-
     if (!in_postcopy || iterable_only) {
         ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy);
         if (ret) {
-- 
2.35.3


