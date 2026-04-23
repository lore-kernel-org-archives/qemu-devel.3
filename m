Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B804DFDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcs-0004qo-BL; Thu, 23 Apr 2026 15:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcL-0003Bw-9j
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:41 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcJ-00027I-Bg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4C285BD8F;
 Thu, 23 Apr 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSE7um/bB6HXlabEMCP8ZpFG/3SzyZrOvtKbDelG4/g=;
 b=o2J3aGfmZrO8yh6aDcv9ff7buX3QlbDEBonPG7UnG0wPxMI2WYpIZ/sKGo/cV7r+DCr2EE
 +PjBPaza5Tz76micM2Nc6oiW054pRiXAmZpg5N+/bH0Fo1llj18xtrsQ/6YD2oEczVDtrl
 54mkQAGlaD4bikw+kZUB9k6ELQnFXlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSE7um/bB6HXlabEMCP8ZpFG/3SzyZrOvtKbDelG4/g=;
 b=/4FPKCk+YBvFb24jd+ChoIULklyhObYhr3lRxBwy9ncCWhUV8t08eIDCtiSbuQNbNiaDWC
 qfysEbH6ONqi4BAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RvJIVEsP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0bwMSfnS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSE7um/bB6HXlabEMCP8ZpFG/3SzyZrOvtKbDelG4/g=;
 b=RvJIVEsPBlRoKPePNWvKgbxYG0xvvLra6kYvpIy5GxvvSZKqapamBD4S3rCOw1GPF+7h12
 bcSX6wIOlNWYCqlpWLAO8F3iFN1HsMS33fuJZk/NX/eEm/1VUt0oRIOSiWV7DqUiKkM4LP
 GjxyOMB0KWHwdtY+e2i4nqHGJq9lF9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSE7um/bB6HXlabEMCP8ZpFG/3SzyZrOvtKbDelG4/g=;
 b=0bwMSfnS4ePHW0wIZpOdQJb3k/ww/47H3kZm04bZV2Oo0Yb41z4iAPljC3VZa+RkSSxZ4z
 8jQzSHHhEHpGCzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6E5B593A3;
 Thu, 23 Apr 2026 19:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GIN6HA9x6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 31/43] vmstate: Implement load of ptr marker in vmstate core
Date: Thu, 23 Apr 2026 16:19:45 -0300
Message-ID: <20260423191958.1440-32-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E4C285BD8F
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The loader side of ptr marker is pretty straightforward, instead of playing
the inner_field trick, just do the load manually assuming the marker layout
is a stable ABI (which it is true already).

This will remove some logic while loading VMSD, and hopefully it makes it
slightly easier to read.  Unfortunately, we still need to keep the sender
side because of the JSON blob we're maintaining..

This paves way for future processing of non-NULL markers as well.

When at it, not check "size" anymore for existing NULL markers, and move it
under the same VMS_ARRAY_OF_POINTER section because that's the only place
that NULL marker can happen (which guarantess size==host ptr size, which is
non-zero).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-9-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate-types.c | 12 ++++------
 migration/vmstate.c       | 46 ++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index b31689fc3c..ae465c5c2c 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
                             const VMStateField *field, Error **errp)
 
 {
-    int byte = qemu_get_byte(f);
-
-    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
-        /* TODO: process PTR_VALID case */
-        return true;
-    }
-
-    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
+    /*
+     * Load is done in vmstate core, see vmstate_ptr_marker_load().
+     */
+    g_assert_not_reached();
     return false;
 }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index b333aa1744..47812eb882 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
     }
 }
 
+static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
+                                    Error **errp)
+{
+    int byte = qemu_get_byte(f);
+
+    if (byte == VMS_MARKER_PTR_NULL) {
+        /* When it's a null ptr marker, do not continue the load */
+        *load_field = false;
+        return true;
+    }
+
+    error_setg(errp, "Unexpected ptr marker: %d", byte);
+    return false;
+}
+
 static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
                              Error **errp)
 {
@@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             for (i = 0; i < n_elems; i++) {
-                bool ok;
+                /* If we will process the load of field? */
+                bool load_field = true;
+                bool ok = true;
                 void *curr_elem = first_elem + size * i;
-                const VMStateField *inner_field;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
+                    if (!curr_elem) {
+                        /* Read the marker instead of VMSD itself */
+                        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
+                            trace_vmstate_load_field_error(field->name,
+                                                           -EINVAL);
+                            return false;
+                        }
+                    }
                 }
 
-                if (!curr_elem && size) {
-                    /*
-                     * If null pointer found (which should only happen in
-                     * an array of pointers), use null placeholder and do
-                     * not follow.
-                     */
-                    inner_field = vmsd_create_ptr_marker_field(field);
-                } else {
-                    inner_field = field;
-                }
-
-                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
-
-                /* If we used a fake temp field.. free it now */
-                if (inner_field != field) {
-                    g_clear_pointer((gpointer *)&inner_field, g_free);
+                if (load_field) {
+                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
                 }
 
                 if (ok) {
-- 
2.51.0


