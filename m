Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B08E909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkM-0003gS-GJ; Tue, 17 Feb 2026 11:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkK-0003Z7-79
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:20 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkI-0003FW-3e
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:19 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC8DB5BD26;
 Tue, 17 Feb 2026 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzX5L2b6gO/RFzY6i/QF0cqQuB1sCad9BY77Dg2YtbM=;
 b=CNSTbyFJDZ0jR6KlyZEoll/u/f7oGb/aQURpu9twe/ExDwQmfAw3iS44rhv8b0C+PnMys/
 L65ywm6IP2zfnDG316yK8Jhxz8Uwq2MryJaNmwwEgDv0FETktlh+SIhmb3387MxfnYVLMb
 +/FWDZo8RKaDpFgbAS9dSmylO7LWprY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzX5L2b6gO/RFzY6i/QF0cqQuB1sCad9BY77Dg2YtbM=;
 b=drFJAm00Lgs9s/JLEViAjxntsA9mr5TKZWCgMNEpOZC+GxkwHdZTx5mx848WQnVe0vpxbv
 7C+mnSqLI/fzemDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzX5L2b6gO/RFzY6i/QF0cqQuB1sCad9BY77Dg2YtbM=;
 b=hpbkW9cwcMyvc2R4qLCOM0MSQl4yVZOkgBOp+W3ACqpXowcMM5LSNgo3Ad+3Ugcdsq5XBK
 yNzHa8WvDDXzedb9ogj3v2WcgUncrkGFZCE4NatboqPleiMVqXMhLdypLi5mlPWamymA1p
 EJIFIHBkE3sxKIEnsX4UnQ2IL70fDR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzX5L2b6gO/RFzY6i/QF0cqQuB1sCad9BY77Dg2YtbM=;
 b=JlEqoFUKh5zuN0YgwPkTrV9wbyKEf/EOcPzOYjfHhNIoxH2XI5IjkapMny5OFVoP45pGs7
 Lg2OCaTT9qmcqZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B22C33EA66;
 Tue, 17 Feb 2026 16:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDONHSKUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 26/32] migration: Introduce qemu_savevm_state_active()
Date: Tue, 17 Feb 2026 13:14:37 -0300
Message-ID: <20260217161443.12738-27-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Peter Xu <peterx@redhat.com>

Introduce this helper to detect if a SaveStateEntry is active.

Note that this helper can actually also be used in loadvm paths, but let's
stick with this name for now because we still use SaveStateEntry for the
shared structure that both savevm/loadvm uses, where this name still suites.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-21-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 63 ++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b04a21ffc9..c16951b532 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1071,6 +1071,16 @@ void qemu_savevm_state_end(QEMUFile *f)
     qemu_put_byte(f, QEMU_VM_EOF);
 }
 
+static inline bool qemu_savevm_state_active(SaveStateEntry *se)
+{
+    /* When no is_active() hook, always treat it as ACTIVE */
+    if (!se->ops->is_active) {
+        return true;
+    }
+
+    return se->ops->is_active(se->opaque);
+}
+
 /**
  * qemu_savevm_command_send: Send a 'QEMU_VM_COMMAND' type element with the
  *                           command and associated data.
@@ -1352,12 +1362,9 @@ int qemu_savevm_state_prepare(Error **errp)
         if (!se->ops || !se->ops->save_prepare) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
-
         ret = se->ops->save_prepare(se->opaque, errp);
         if (ret < 0) {
             return ret;
@@ -1397,10 +1404,8 @@ static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
         ret = se->ops->save_setup(f, se->opaque, errp);
@@ -1450,10 +1455,8 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
         if (!se->ops || !se->ops->resume_prepare) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         ret = se->ops->resume_prepare(s, se->opaque);
         if (ret < 0) {
@@ -1481,8 +1484,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
         if (!se->ops || !se->ops->save_live_iterate) {
             continue;
         }
-        if (se->ops->is_active &&
-            !se->ops->is_active(se->opaque)) {
+        if (!qemu_savevm_state_active(se)) {
             continue;
         }
         if (se->ops->is_active_iterate &&
@@ -1543,10 +1545,8 @@ static int qemu_savevm_complete(SaveStateEntry *se, QEMUFile *f)
 {
     int ret;
 
-    if (se->ops->is_active) {
-        if (!se->ops->is_active(se->opaque)) {
-            return 0;
-        }
+    if (!qemu_savevm_state_active(se)) {
+        return 0;
     }
 
     trace_savevm_section_start(se->idstr, se->section_id);
@@ -1596,10 +1596,8 @@ bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
             continue;
         }
 
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
 
         trace_savevm_section_start(se->idstr, se->section_id);
@@ -1785,10 +1783,8 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
         if (!se->ops || !se->ops->state_pending_estimate) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
     }
@@ -1806,10 +1802,8 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
         if (!se->ops || !se->ops->state_pending_exact) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
     }
@@ -2829,12 +2823,9 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
         if (!se->ops || !se->ops->load_setup) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
-
         ret = se->ops->load_setup(f, se->opaque, errp);
         if (ret < 0) {
             error_prepend(errp, "Load state of device %s failed: ",
-- 
2.51.0


