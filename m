Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04961E909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjY-0001Bv-3R; Tue, 17 Feb 2026 11:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjW-0001Bc-Ne
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:30 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjS-00039E-Rb
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CDAC3E718;
 Tue, 17 Feb 2026 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12dko+5B3CXqUql9h4MUpE37+TD98BvnCR9Kf7nwxg8=;
 b=bR7FZYuKM9SltfKzD1ysqHZelKQe5UscxPjU0ihx3EDiF85RP6IpHSM/GSBkzkhCu86fVq
 kXm4YrXatVXwE2S+nAB/X8RlFNxq4GisXHl/5VK9ZMaeqEB7mFs+HsYeYYeNGNBfl2q/gB
 kEiCNY8YPPDqXEEZmONOQXFGr81rT7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12dko+5B3CXqUql9h4MUpE37+TD98BvnCR9Kf7nwxg8=;
 b=rKwfyPjTqKdidDijM2kNOBUsTb28S/54xevOWr7weGMlXU6C1iaRCU+uKIlJJ1UB/NbkY9
 uDkbq8RQ2fXGLVDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12dko+5B3CXqUql9h4MUpE37+TD98BvnCR9Kf7nwxg8=;
 b=bR7FZYuKM9SltfKzD1ysqHZelKQe5UscxPjU0ihx3EDiF85RP6IpHSM/GSBkzkhCu86fVq
 kXm4YrXatVXwE2S+nAB/X8RlFNxq4GisXHl/5VK9ZMaeqEB7mFs+HsYeYYeNGNBfl2q/gB
 kEiCNY8YPPDqXEEZmONOQXFGr81rT7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12dko+5B3CXqUql9h4MUpE37+TD98BvnCR9Kf7nwxg8=;
 b=rKwfyPjTqKdidDijM2kNOBUsTb28S/54xevOWr7weGMlXU6C1iaRCU+uKIlJJ1UB/NbkY9
 uDkbq8RQ2fXGLVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4E263EA66;
 Tue, 17 Feb 2026 16:15:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EBYcIgeUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 10/32] migration/savevm: Remove SaveStateEntry.is_ram
Date: Tue, 17 Feb 2026 13:14:21 -0300
Message-ID: <20260217161443.12738-11-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Peter Xu <peterx@redhat.com>

It's neither accurate nor necessary.  Use a proper helper to detect if it's
an iterable savevm state entry instead.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-5-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 61e873d90c..f1cd8c913d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -249,7 +249,6 @@ typedef struct SaveStateEntry {
     const VMStateDescription *vmsd;
     void *opaque;
     CompatEntry *compat;
-    int is_ram;
 } SaveStateEntry;
 
 typedef struct SaveState {
@@ -816,10 +815,6 @@ int register_savevm_live(const char *idstr,
     se->ops = ops;
     se->opaque = opaque;
     se->vmsd = NULL;
-    /* if this is a live_savem then set is_ram */
-    if (ops->save_setup != NULL) {
-        se->is_ram = 1;
-    }
 
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
 
@@ -1866,6 +1861,12 @@ void qemu_savevm_live_state(QEMUFile *f)
     qemu_put_byte(f, QEMU_VM_EOF);
 }
 
+/* Is a save state entry iterable (e.g. RAM)? */
+static bool qemu_savevm_se_iterable(SaveStateEntry *se)
+{
+    return se->ops && se->ops->save_setup;
+}
+
 int qemu_save_device_state(QEMUFile *f)
 {
     Error *local_err = NULL;
@@ -1876,7 +1877,7 @@ int qemu_save_device_state(QEMUFile *f)
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         int ret;
 
-        if (se->is_ram) {
+        if (qemu_savevm_se_iterable(se)) {
             continue;
         }
         ret = vmstate_save(f, se, NULL, &local_err);
@@ -2648,7 +2649,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
     se->load_section_id = section_id;
 
     /* Validate if it is a device's state */
-    if (xen_enabled() && se->is_ram) {
+    if (xen_enabled() && qemu_savevm_se_iterable(se)) {
         error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
-- 
2.51.0


