Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E68FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzbK-0001rr-FA; Thu, 23 Apr 2026 15:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbI-0001rh-1s
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbG-0001oY-D0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:35 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30BF76A891;
 Thu, 23 Apr 2026 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdvgjJWId/ztQjLwsbKadX2Wrh8lXPgRZKBKsMat1oU=;
 b=QVaSCSCarNJMYdgTrDl6gebxG74ZzWGywcRFQBTsZxbneQLZIScIpylP02Q1nm40a2Dh6s
 YAkR7UU2eSiW4Yvt3gIa/dDtfGc7MqJt4YATuIN9JDbDgHHv+2251j02bHPSgOe2iYGbrR
 U99BcGEjvOshNPuc1pyPZTEQVypPb+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdvgjJWId/ztQjLwsbKadX2Wrh8lXPgRZKBKsMat1oU=;
 b=jVYeFenIA5L+xT/OmTrW8TJV8V/q03tbVY6HBFyLeZO93nrRv5XpLLyicT2FrfLCY5btBs
 3rGsDyBka8pYlIDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdvgjJWId/ztQjLwsbKadX2Wrh8lXPgRZKBKsMat1oU=;
 b=QVaSCSCarNJMYdgTrDl6gebxG74ZzWGywcRFQBTsZxbneQLZIScIpylP02Q1nm40a2Dh6s
 YAkR7UU2eSiW4Yvt3gIa/dDtfGc7MqJt4YATuIN9JDbDgHHv+2251j02bHPSgOe2iYGbrR
 U99BcGEjvOshNPuc1pyPZTEQVypPb+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdvgjJWId/ztQjLwsbKadX2Wrh8lXPgRZKBKsMat1oU=;
 b=jVYeFenIA5L+xT/OmTrW8TJV8V/q03tbVY6HBFyLeZO93nrRv5XpLLyicT2FrfLCY5btBs
 3rGsDyBka8pYlIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 290B9593B0;
 Thu, 23 Apr 2026 19:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mByjOetw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 08/43] migration: factor out vmstate_pre_save() from
 vmstate_save_state()
Date: Thu, 23 Apr 2026 16:19:22 -0300
Message-ID: <20260423191958.1440-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Simplify vmstate_save_state() which is rather big, and simplify further
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-7-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 87e1f04959..605b5c59c7 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -435,32 +435,41 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
     return true;
 }
 
-static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                                void *opaque, JSONWriter *vmdesc,
-                                int version_id, Error **errp)
+static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
+                             Error **errp)
 {
     ERRP_GUARD();
-    int ret = 0;
-    const VMStateField *field = vmsd->fields;
-
-    trace_vmstate_save_state_top(vmsd->name);
 
     if (vmsd->pre_save_errp) {
-        ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
-        if (ret < 0) {
+        if (!vmsd->pre_save_errp(opaque, errp)) {
             error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
-            trace_vmstate_save_state_pre_save_fail(vmsd->name);
-            return ret;
+            return false;
         }
     } else if (vmsd->pre_save) {
-        ret = vmsd->pre_save(opaque);
-        if (ret) {
+        if (vmsd->pre_save(opaque) < 0) {
             error_setg(errp, "pre-save failed: %s", vmsd->name);
-            trace_vmstate_save_state_pre_save_fail(vmsd->name);
-            return ret;
+            return false;
         }
     }
 
+    return true;
+}
+
+static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                                void *opaque, JSONWriter *vmdesc,
+                                int version_id, Error **errp)
+{
+    ERRP_GUARD();
+    int ret = 0;
+    const VMStateField *field = vmsd->fields;
+
+    trace_vmstate_save_state_top(vmsd->name);
+
+    if (!vmstate_pre_save(vmsd, opaque, errp)) {
+        trace_vmstate_save_state_pre_save_fail(vmsd->name);
+        return -EINVAL;
+    }
+
     trace_vmstate_save_state_pre_save_success(vmsd->name);
 
     if (vmdesc) {
-- 
2.51.0


