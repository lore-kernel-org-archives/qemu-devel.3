Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FE1FEC102
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57fq-0003P0-Qu; Tue, 24 Mar 2026 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fo-0003OP-N8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:20 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fn-0008GZ-2J
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C6915BD6E;
 Tue, 24 Mar 2026 19:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+ZyLFL7XlyGoLVRwdhBcneEFYHFSurRSuZsKKjaQzM=;
 b=JNwstzZxCnYm0p6VIp9LTV+kXazLqhgRrBkPt6oldb1H1eS2DlSkFOWYNZdU7Sdc+ARfqG
 OdlV1ocq3poz6wc4CG0q8/1eYTPwQ7BfYKxyc7hmGu2teZrpXAIyd7GS+/rlivkAuCRN2x
 mmOi7pco85kRacR2sZ0R54BRgRmmFKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+ZyLFL7XlyGoLVRwdhBcneEFYHFSurRSuZsKKjaQzM=;
 b=xRppBspih78ISK0tY7lDs70KoAoLvDGQbpRljEV+M6ts0WTYtqD84tZur+bSd0uCzIBWIy
 NyQj+rWNm0GHzwBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+ZyLFL7XlyGoLVRwdhBcneEFYHFSurRSuZsKKjaQzM=;
 b=JNwstzZxCnYm0p6VIp9LTV+kXazLqhgRrBkPt6oldb1H1eS2DlSkFOWYNZdU7Sdc+ARfqG
 OdlV1ocq3poz6wc4CG0q8/1eYTPwQ7BfYKxyc7hmGu2teZrpXAIyd7GS+/rlivkAuCRN2x
 mmOi7pco85kRacR2sZ0R54BRgRmmFKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+ZyLFL7XlyGoLVRwdhBcneEFYHFSurRSuZsKKjaQzM=;
 b=xRppBspih78ISK0tY7lDs70KoAoLvDGQbpRljEV+M6ts0WTYtqD84tZur+bSd0uCzIBWIy
 NyQj+rWNm0GHzwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45B5343FE4;
 Tue, 24 Mar 2026 19:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0KqsBXrpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 12/17] vmstate: Introduce vmstate_next
Date: Tue, 24 Mar 2026 16:43:27 -0300
Message-ID: <20260324194333.30004-13-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Similarly to vmstate_first(), introduce a vmstate_next(), which does
the necessary dereferencing of pointers to get to the leaf element. On
the load side, allow the caller to pass a flag indicating whether
allocation is expected and call the allocation function if so.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 84 +++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index ab7c6fa4ab..c1ad0ef9a5 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -127,24 +127,51 @@ static void *vmstate_first(void *opaque, const VMStateField *field,
     return first;
 }
 
-static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
-                                    Error **errp)
+static void *vmstate_next(void **first, const VMStateField *field,
+                          int size, int i, bool alloc)
 {
-    int byte = qemu_get_byte(f);
+    void **array_elem;
+    void *next;
+
+    if (!(field->flags & VMS_ARRAY_OF_POINTER)) {
+        next = (void *)first + size * i;
+        return next;
+    }
+
+    array_elem = first + i;
+    next = *array_elem;
+
+    if (alloc) {
+        if (!next || field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
+            /*
+             * NOTE: do not use vmstate_size() here, because we
+             * need the object size, not entry size of the
+             * array.
+             */
+            next = vmstate_handle_alloc(array_elem, field->size, 1);
+        }
+    }
+    return next;
+}
+
+static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field)
+{
+    int byte = qemu_peek_byte(f, 0);
 
     if (byte == VMS_MARKER_PTR_NULL) {
         /* When it's a null ptr marker, do not continue the load */
         *load_field = false;
+        qemu_file_skip(f, 1);
         return true;
     }
 
     if (byte == VMS_MARKER_PTR_VALID) {
         /* We need to load this field right after the marker */
         *load_field = true;
+        qemu_file_skip(f, 1);
         return true;
     }
 
-    error_setg(errp, "Unexpected ptr marker: %d", byte);
     return false;
 }
 
@@ -273,41 +300,13 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    void **array_elem = (void **)head + i;
-                    bool use_dynamic_array =
-                        field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
-                    bool use_marker_field;
-
-                    curr_elem = *array_elem;
-                    use_marker_field = use_dynamic_array || !curr_elem;
-
-                    if (use_marker_field) {
-                        /* Read the marker instead of VMSD first */
-                        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
-                            trace_vmstate_load_field_error(field->name,
-                                                           -EINVAL);
-                            return false;
-                        }
-
-                        if (load_field) {
-                            /*
-                             * When reaching here, it means we received a
-                             * non-NULL ptr marker, so we need to populate the
-                             * field before loading it.
-                             *
-                             * NOTE: do not use vmstate_size() here, because we
-                             * need the object size, not entry size of the
-                             * array.
-                             */
-                            assert(!curr_elem);
-                            curr_elem = vmstate_handle_alloc(array_elem,
-                                                             field->size, 1);
-                        }
-                    }
-                } else {
-                    curr_elem = head + size * i;
+                    /* Peek a possible pointer marker instead of VMSD first */
+                    ok = vmstate_ptr_marker_load(f, &load_field);
                 }
 
+                curr_elem = vmstate_next(head, field, size, i,
+                                         load_field && ok);
+
                 if (load_field) {
                     ok = vmstate_load_field(f, curr_elem, size, field, errp);
                 }
@@ -647,15 +646,11 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
             for (i = 0; i < n_elems; i++) {
                 bool save_field = true;
-                void *curr_elem;
+                void *curr_elem = vmstate_next(head, field, size, i, false);
                 int max_elems = n_elems - i;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     bool use_marker_field, is_null, use_dynamic_array;
-                    void **array_elem = (void **)head + i;
-
-                    assert(array_elem);
-                    curr_elem = *array_elem;
 
                     is_null = !curr_elem;
 
@@ -688,7 +683,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                             use_vmdesc = true;
 
                             for (int j = i + 1; j < n_elems; j++) {
-                                void *elem = *(void **)(head + size * j);
+                                void *elem = vmstate_next(head, field, size, j,
+                                                          false);
                                 bool elem_is_null = !elem;
 
                                 if (is_null != elem_is_null) {
@@ -713,8 +709,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                         save_field = !!curr_elem;
                     }
-                } else {
-                    curr_elem = head + size * i;
                 }
 
                 if (save_field) {
-- 
2.51.0


