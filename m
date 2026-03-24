Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EDCFEC102
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57g0-0003YK-AH; Tue, 24 Mar 2026 15:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fz-0003WF-0h
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fx-0008IL-4B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37EC85BE1C;
 Tue, 24 Mar 2026 19:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1stviN/raIeGwfKRJGzfc+zY9+icZReG+c5s58fsdo=;
 b=VXdP7x+urG6oRbRSv+cO2dKT8gYkMbhvwFXO3lrBM27R+gmNnqpkn1snxKyJsCdAaH608I
 FYhYfGCvnNtuBLUpvebB28BnjsXKdeLJHR05qyniDVDzfEdKwIibeDa56nCCJtYpglrZeY
 bapb9I9SoDXf16W5x3xqWHtF2iUqoGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1stviN/raIeGwfKRJGzfc+zY9+icZReG+c5s58fsdo=;
 b=cskHf+ukmCAfaP7umTs3ZqsGRjG8mCalhhU0tCCuBqWvQuKYXJUvspNk4yLU4KcllUjfm8
 oMVl4BiwHtdBNrBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1stviN/raIeGwfKRJGzfc+zY9+icZReG+c5s58fsdo=;
 b=VXdP7x+urG6oRbRSv+cO2dKT8gYkMbhvwFXO3lrBM27R+gmNnqpkn1snxKyJsCdAaH608I
 FYhYfGCvnNtuBLUpvebB28BnjsXKdeLJHR05qyniDVDzfEdKwIibeDa56nCCJtYpglrZeY
 bapb9I9SoDXf16W5x3xqWHtF2iUqoGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1stviN/raIeGwfKRJGzfc+zY9+icZReG+c5s58fsdo=;
 b=cskHf+ukmCAfaP7umTs3ZqsGRjG8mCalhhU0tCCuBqWvQuKYXJUvspNk4yLU4KcllUjfm8
 oMVl4BiwHtdBNrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F97743FE4;
 Tue, 24 Mar 2026 19:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eHwnNIHpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:44:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 17/17] vmstate: Reduce indentation levels
Date: Tue, 24 Mar 2026 16:43:32 -0300
Message-ID: <20260324194333.30004-18-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 R_RATELIMIT(0.00)[to_ip_from(RLuo5zndapfjusa9yqdunguuf8)];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Simply move the code out of the else branch.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 193 ++++++++++++++++++++++----------------------
 1 file changed, 96 insertions(+), 97 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 054e642ec9..22f8758960 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -306,46 +306,46 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
         if (!exists) {
             field++;
             continue;
-        } else {
-            n_elems = vmstate_n_elems(opaque, field);
-            size = vmstate_size(opaque, field);
+        }
 
-            head = vmstate_first(opaque, field, size, n_elems,
-                                 !(field->flags & VMS_ARRAY_OF_POINTER));
+        n_elems = vmstate_n_elems(opaque, field);
+        size = vmstate_size(opaque, field);
 
-            for (i = 0; i < n_elems; i++) {
-                /* If we will process the load of field? */
-                bool load_field = true;
-                void *curr_elem;
+        head = vmstate_first(opaque, field, size, n_elems,
+                             !(field->flags & VMS_ARRAY_OF_POINTER));
 
-                if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    /* Peek a possible pointer marker instead of VMSD first */
-                    ok = vmstate_ptr_marker_load(f, &load_field);
-                }
+        for (i = 0; i < n_elems; i++) {
+            /* If we will process the load of field? */
+            bool load_field = true;
+            void *curr_elem;
 
-                curr_elem = vmstate_next(head, field, size, i,
-                                         load_field && ok);
+            if (field->flags & VMS_ARRAY_OF_POINTER) {
+                /* Peek a possible pointer marker instead of VMSD first */
+                ok = vmstate_ptr_marker_load(f, &load_field);
+            }
 
-                if (load_field) {
-                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
-                }
+            curr_elem = vmstate_next(head, field, size, i, load_field && ok);
 
-                if (ok) {
-                    int ret = qemu_file_get_error(f);
-                    if (ret < 0) {
-                        error_setg(errp,
-                                   "Failed to load %s state: stream error: %d",
-                                   vmsd->name, ret);
-                        trace_vmstate_load_field_error(field->name, ret);
-                        return false;
-                    }
-                } else {
-                    qemu_file_set_error(f, -EINVAL);
-                    trace_vmstate_load_field_error(field->name, -EINVAL);
+            if (load_field) {
+                ok = vmstate_load_field(f, curr_elem, size, field, errp);
+            }
+
+            if (ok) {
+                int ret = qemu_file_get_error(f);
+                if (ret < 0) {
+                    error_setg(errp,
+                               "Failed to load %s state: stream error: %d",
+                               vmsd->name, ret);
+                    trace_vmstate_load_field_error(field->name, ret);
                     return false;
                 }
+            } else {
+                qemu_file_set_error(f, -EINVAL);
+                trace_vmstate_load_field_error(field->name, -EINVAL);
+                return false;
             }
         }
+
         field++;
     }
     assert(field->flags == VMS_END);
@@ -663,93 +663,92 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
         if (!exists) {
             field++;
             continue;
-        } else {
-            n_elems = vmstate_n_elems(opaque, field);
-            size = vmstate_size(opaque, field);
+        }
 
-            trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
-            head = vmstate_first(opaque, field, size, n_elems, false);
+        n_elems = vmstate_n_elems(opaque, field);
+        size = vmstate_size(opaque, field);
 
-            for (i = 0; i < n_elems; i++) {
-                bool save_field = true;
-                void *curr_elem = vmstate_next(head, field, size, i, false);
-                int max_elems = n_elems - i;
+        trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
+        head = vmstate_first(opaque, field, size, n_elems, false);
 
-                if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    bool use_marker_field, is_null, use_dynamic_array;
+        for (i = 0; i < n_elems; i++) {
+            bool save_field = true;
+            void *curr_elem = vmstate_next(head, field, size, i, false);
+            int max_elems = n_elems - i;
 
-                    is_null = !curr_elem;
+            if (field->flags & VMS_ARRAY_OF_POINTER) {
+                bool use_marker_field, is_null, use_dynamic_array;
 
+                is_null = !curr_elem;
+
+                /*
+                 * When this is enabled, it means we will always push a ptr
+                 * marker first for each element saying if it's populated.
+                 */
+                use_dynamic_array =
+                    field->flags & VMS_ARRAY_OF_POINTER &&
+                    field->flags & VMS_ALLOC;
+
+                use_marker_field = use_dynamic_array || is_null;
+
+                if (vmdesc && vmsd_can_compress(field)) {
                     /*
-                     * When this is enabled, it means we will always push a ptr
-                     * marker first for each element saying if it's populated.
+                     * This logic only matters when dumping VM
+                     * Desc, and only when the VMSD field can be
+                     * compressed.
+                     *
+                     * Due to the fake nullptr handling above, if
+                     * there's mixed null/non-null data, it
+                     * doesn't make sense to emit a compressed
+                     * array representation spanning the entire
+                     * array because the field types will be
+                     * different (e.g. struct vs. nullptr). Search
+                     * ahead for the next null/non-null element
+                     * and start a new compressed array if found.
                      */
-                    use_dynamic_array =
-                        field->flags & VMS_ARRAY_OF_POINTER &&
-                        field->flags & VMS_ALLOC;
-
-                    use_marker_field = use_dynamic_array || is_null;
-
-                    if (vmdesc && vmsd_can_compress(field)) {
-                        /*
-                         * This logic only matters when dumping VM
-                         * Desc, and only when the VMSD field can be
-                         * compressed.
-                         *
-                         * Due to the fake nullptr handling above, if
-                         * there's mixed null/non-null data, it
-                         * doesn't make sense to emit a compressed
-                         * array representation spanning the entire
-                         * array because the field types will be
-                         * different (e.g. struct vs. nullptr). Search
-                         * ahead for the next null/non-null element
-                         * and start a new compressed array if found.
-                         */
-                        if (is_null != is_null_prev) {
-                            is_null_prev = is_null;
-                            use_vmdesc = true;
-
-                            for (int j = i + 1; j < n_elems; j++) {
-                                void *elem = vmstate_next(head, field, size, j,
-                                                          false);
-                                bool elem_is_null = !elem;
-
-                                if (is_null != elem_is_null) {
-                                    max_elems = j - i;
-                                    break;
-                                }
-                            }
-                        }
-                    }
-
-                    if (use_dynamic_array) {
+                    if (is_null != is_null_prev) {
+                        is_null_prev = is_null;
                         use_vmdesc = true;
-                    }
 
-                    if (use_marker_field) {
-                        ok = vmstate_ptr_marker_save(f, curr_elem, vmsd, field,
-                                                     use_vmdesc ? vmdesc : NULL,
-                                                     i, max_elems, errp);
-                        if (!ok) {
-                            goto out;
+                        for (int j = i + 1; j < n_elems; j++) {
+                            void *elem = vmstate_next(head, field, size, j,
+                                                      false);
+                            bool elem_is_null = !elem;
+
+                            if (is_null != elem_is_null) {
+                                max_elems = j - i;
+                                break;
+                            }
                         }
-
-                        save_field = !!curr_elem;
                     }
                 }
 
-                if (save_field) {
-                    ok = vmstate_save_field_with_vmdesc(
-                        f, curr_elem, size, vmsd, field,
-                        use_vmdesc ? vmdesc : NULL, i, max_elems, errp);
+                if (use_dynamic_array) {
+                    use_vmdesc = true;
+                }
 
+                if (use_marker_field) {
+                    ok = vmstate_ptr_marker_save(f, curr_elem, vmsd, field,
+                                                 use_vmdesc ? vmdesc : NULL,
+                                                 i, max_elems, errp);
                     if (!ok) {
                         goto out;
                     }
+
+                    save_field = !!curr_elem;
                 }
+            }
 
-                use_vmdesc = false;
+            if (save_field) {
+                ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
+                                                    field,
+                                                    use_vmdesc ? vmdesc : NULL,
+                                                    i, max_elems, errp);
+                if (!ok) {
+                    goto out;
+                }
             }
+            use_vmdesc = false;
         }
         field++;
     }
-- 
2.51.0


