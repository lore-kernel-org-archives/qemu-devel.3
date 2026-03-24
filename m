Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AF7FEC102
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57fn-0003NT-6P; Tue, 24 Mar 2026 15:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fk-0003Iz-33
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:17 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fh-0008FZ-Tj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:15 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BFBF5BE1F;
 Tue, 24 Mar 2026 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7Y0B9fYyfVHM63msfI41W8dKbr2u81xFRLOCF+eFX8=;
 b=eiu1YH5y2ROoxm9/sK43I0kvlvGuRJl60enCqX+4yotiNqDJZcNDHqBoJWeLrtYZIYgvMs
 Xws7T7j0roy7YkyGxTyg3XnS+2aG74cPEarzQVy6WYz46yYj4cnmZxH14JzfJqmnXm+YIt
 3H3bZziqsYNDVvOdHfYlwtBGZUhHFz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7Y0B9fYyfVHM63msfI41W8dKbr2u81xFRLOCF+eFX8=;
 b=d8S+KYgzZF0zAx1Ud3Z6ZSze8Sl8A8nb2bTvmo6JO/3OvV/1GFPzxC4etX1US/Gao8Sc8q
 lxcIEpGQ4VcW38AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eiu1YH5y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d8S+KYgz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7Y0B9fYyfVHM63msfI41W8dKbr2u81xFRLOCF+eFX8=;
 b=eiu1YH5y2ROoxm9/sK43I0kvlvGuRJl60enCqX+4yotiNqDJZcNDHqBoJWeLrtYZIYgvMs
 Xws7T7j0roy7YkyGxTyg3XnS+2aG74cPEarzQVy6WYz46yYj4cnmZxH14JzfJqmnXm+YIt
 3H3bZziqsYNDVvOdHfYlwtBGZUhHFz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7Y0B9fYyfVHM63msfI41W8dKbr2u81xFRLOCF+eFX8=;
 b=d8S+KYgzZF0zAx1Ud3Z6ZSze8Sl8A8nb2bTvmo6JO/3OvV/1GFPzxC4etX1US/Gao8Sc8q
 lxcIEpGQ4VcW38AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6FD143FE4;
 Tue, 24 Mar 2026 19:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2AoOLXDpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 06/17] vmstate: Put array of pointers code together
Date: Tue, 24 Mar 2026 16:43:21 -0300
Message-ID: <20260324194333.30004-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1BFBF5BE1F
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

In vmstate_save|load_vmsd[_v], move the code handling
VMS_ARRAY_OF_POINTER all to the same block. These functions deal with
single elements, scalar arrays and arrays of pointers, of which the
latter is the most complex code. Group that use-case so it's easier to
reason about.

This allows for a significant design cleanup, which is to stop using
the inner_field variable in the case where there is NO pointer
marker. Now the inner_field is internal to the VMS_ARRAY_OF_POINTER
code.

By adding a save_field boolean, we can reuse the "actual field" write
for the !use_marker case. This brings the benefit of being able to
drop the field->size specialization. Like so:

===
before:
size = vmstate_size();

if (use_marker) {
   inner_field = fake;
} else {
   inner_field = field;
}

vmstate_save_field_with_vmdesc(inner_field, size)

if (use_marker && !curr) {
    vmstate_save_field_with_vmdesc(field, field->size)
}

after:
size = vmstate_size();

if (use_marker) {
   inner_field = fake;
   vmstate_save_field_with_vmdesc(inner_field, 1)
   save_field = !curr;
}

if (save_field) {
    vmstate_save_field_with_vmdesc(field, size)
}

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 193 +++++++++++++++++++++-----------------------
 1 file changed, 92 insertions(+), 101 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 7a12245d36..a190c3f63f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -277,12 +277,6 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
-            /*
-             * When this is enabled, it means we will always push a ptr
-             * marker first for each element saying if it's populated.
-             */
-            bool use_dynamic_array =
-                field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
 
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
@@ -294,36 +288,40 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                 /* If we will process the load of field? */
                 bool load_field = true;
                 bool ok = true;
-                bool use_marker_field;
                 void *curr_elem_p = first_elem + size * i;
                 void *curr_elem = curr_elem_p;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
+                    bool use_dynamic_array =
+                        field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
+                    bool use_marker_field;
+
                     curr_elem = *(void **)curr_elem_p;
-                }
 
-                use_marker_field = use_dynamic_array || (!curr_elem && size);
+                    use_marker_field = use_dynamic_array || !curr_elem;
 
-                if (use_marker_field) {
-                    /* Read the marker instead of VMSD first */
-                    if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
-                        trace_vmstate_load_field_error(field->name, -EINVAL);
-                        return false;
-                    }
+                    if (use_marker_field) {
+                        /* Read the marker instead of VMSD first */
+                        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
+                            trace_vmstate_load_field_error(field->name,
+                                                           -EINVAL);
+                            return false;
+                        }
 
-                    if (load_field) {
-                        /*
-                         * When reaching here, it means we received a
-                         * non-NULL ptr marker, so we need to populate the
-                         * field before loading it.
-                         *
-                         * NOTE: do not use vmstate_size() here, because we
-                         * need the object size, not entry size of the
-                         * array.
-                         */
-                        curr_elem = g_malloc0(field->size);
-                        /* Remember to update the root pointer! */
-                        *(void **)curr_elem_p = curr_elem;
+                        if (load_field) {
+                            /*
+                             * When reaching here, it means we received a
+                             * non-NULL ptr marker, so we need to populate the
+                             * field before loading it.
+                             *
+                             * NOTE: do not use vmstate_size() here, because we
+                             * need the object size, not entry size of the
+                             * array.
+                             */
+                            curr_elem = g_malloc0(field->size);
+                            /* Remember to update the root pointer! */
+                            *(void **)curr_elem_p = curr_elem;
+                        }
                     }
                 }
 
@@ -625,13 +623,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             bool is_null_prev = false;
             bool use_vmdesc = true;
 
-            /*
-             * When this is enabled, it means we will always push a ptr
-             * marker first for each element saying if it's populated.
-             */
-            bool use_dynamic_array =
-                field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
-
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
@@ -639,83 +630,83 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             for (i = 0; i < n_elems; i++) {
+                bool save_field = true;
                 void *curr_elem = first_elem + size * i;
-                const VMStateField *inner_field;
-                bool use_marker_field, is_null = false;
                 int max_elems = n_elems - i;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
+                    const VMStateField *inner_field;
+                    bool use_marker_field, is_null, use_dynamic_array;
+
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
+
                     is_null = !curr_elem;
-                }
 
-                use_marker_field = use_dynamic_array || is_null;
-
-                if (use_marker_field) {
-                    inner_field = vmsd_create_ptr_marker_field(field);
-                } else {
-                    inner_field = field;
-                }
-
-                /*
-                 * This logic only matters when dumping VM Desc, and only
-                 * when the VMSD field can be compressed.
-                 *
-                 * Due to the fake nullptr handling above, if there's mixed
-                 * null/non-null data, it doesn't make sense to emit a
-                 * compressed array representation spanning the entire array
-                 * because the field types will be different (e.g. struct
-                 * vs. nullptr). Search ahead for the next null/non-null element
-                 * and start a new compressed array if found.
-                 */
-                if (vmdesc && vmsd_can_compress(field) &&
-                    (field->flags & VMS_ARRAY_OF_POINTER) &&
-                    is_null != is_null_prev) {
-
-                    is_null_prev = is_null;
-                    use_vmdesc = true;
-
-                    for (int j = i + 1; j < n_elems; j++) {
-                        void *elem = *(void **)(first_elem + size * j);
-                        bool elem_is_null = !elem;
-
-                        if (is_null != elem_is_null) {
-                            max_elems = j - i;
-                            break;
-                        }
-                    }
-                }
-
-                if (use_dynamic_array) {
-                    use_vmdesc = true;
-                }
-
-                ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
-                                                    inner_field,
-                                                    use_vmdesc ? vmdesc : NULL,
-                                                    i, max_elems, errp);
-
-                /* If we used a fake temp field.. free it now */
-                if (use_marker_field) {
-                    g_clear_pointer((gpointer *)&inner_field, g_free);
-                }
-
-                if (!ok) {
-                    goto out;
-                }
-
-                /*
-                 * If we're using dynamic array and the element is
-                 * populated, dump the real object right after the marker.
-                 */
-                if (use_dynamic_array && curr_elem) {
                     /*
-                     * NOTE: do not use vmstate_size() here because we want
-                     * to dump the real VMSD object now.
+                     * When this is enabled, it means we will always push a ptr
+                     * marker first for each element saying if it's populated.
                      */
+                    use_dynamic_array =
+                        field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
+
+                    use_marker_field = use_dynamic_array || is_null;
+
+                    if (vmdesc && vmsd_can_compress(field)) {
+                        /*
+                         * This logic only matters when dumping VM
+                         * Desc, and only when the VMSD field can be
+                         * compressed.
+                         *
+                         * Due to the fake nullptr handling above, if
+                         * there's mixed null/non-null data, it
+                         * doesn't make sense to emit a compressed
+                         * array representation spanning the entire
+                         * array because the field types will be
+                         * different (e.g. struct vs. nullptr). Search
+                         * ahead for the next null/non-null element
+                         * and start a new compressed array if found.
+                         */
+                        if (is_null != is_null_prev) {
+                            is_null_prev = is_null;
+                            use_vmdesc = true;
+
+                            for (int j = i + 1; j < n_elems; j++) {
+                                void *elem = *(void **)(first_elem + size * j);
+                                bool elem_is_null = !elem;
+
+                                if (is_null != elem_is_null) {
+                                    max_elems = j - i;
+                                    break;
+                                }
+                            }
+                        }
+                    }
+
+                    if (use_dynamic_array) {
+                        use_vmdesc = true;
+                    }
+
+                    if (use_marker_field) {
+                        inner_field = vmsd_create_ptr_marker_field(field);
+
+                        ok = vmstate_save_field_with_vmdesc(
+                            f, curr_elem, 1, vmsd, inner_field,
+                            use_vmdesc ? vmdesc : NULL, i, max_elems, errp);
+
+                        g_clear_pointer((gpointer *)&inner_field, g_free);
+
+                        if (!ok) {
+                            goto out;
+                        }
+
+                        save_field = !!curr_elem;
+                    }
+                }
+
+                if (save_field) {
                     ok = vmstate_save_field_with_vmdesc(
-                        f, curr_elem, field->size, vmsd, field,
+                        f, curr_elem, size, vmsd, field,
                         use_vmdesc ? vmdesc : NULL, i, max_elems, errp);
 
                     if (!ok) {
-- 
2.51.0


