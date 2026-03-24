Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1BFFEC102
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57fU-0003DA-SG; Tue, 24 Mar 2026 15:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fN-0003CD-FQ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:43:55 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fI-00085S-SE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:43:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2A6B4D217;
 Tue, 24 Mar 2026 19:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYM15ZCEzaavHO8mCOfxSzn/Gfj4uM9ceO5chRfQkKE=;
 b=TABpM8iwc2H4gQwKsgCPnGx/irZo567NFpkHyMvvphLCZJ30PC9cDzs1ZvaAL7Gi4hle4m
 zZTuRQUe+msMk17u0FXKQ12uH+nIxBbzAhnzX1VabFs6RPDoFTvnYK3zI2BLmrsUGeeH2h
 9oZ9+N5w60XrLhaG6z0kjXMvtMrnP8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYM15ZCEzaavHO8mCOfxSzn/Gfj4uM9ceO5chRfQkKE=;
 b=/8a1gdHFNDnUXPkzAKbp5tKs18MeYli+pR3dwqvDcJ2Sn3OxgcdfCYa9e9O55DbQxq0cAe
 VhCvi5YnEcTEK0Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TABpM8iw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/8a1gdHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYM15ZCEzaavHO8mCOfxSzn/Gfj4uM9ceO5chRfQkKE=;
 b=TABpM8iwc2H4gQwKsgCPnGx/irZo567NFpkHyMvvphLCZJ30PC9cDzs1ZvaAL7Gi4hle4m
 zZTuRQUe+msMk17u0FXKQ12uH+nIxBbzAhnzX1VabFs6RPDoFTvnYK3zI2BLmrsUGeeH2h
 9oZ9+N5w60XrLhaG6z0kjXMvtMrnP8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYM15ZCEzaavHO8mCOfxSzn/Gfj4uM9ceO5chRfQkKE=;
 b=/8a1gdHFNDnUXPkzAKbp5tKs18MeYli+pR3dwqvDcJ2Sn3OxgcdfCYa9e9O55DbQxq0cAe
 VhCvi5YnEcTEK0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B8C343FE4;
 Tue, 24 Mar 2026 19:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OPnZEnLpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 07/17] vmstate: Create and save ptr marker in same
 function
Date: Tue, 24 Mar 2026 16:43:22 -0300
Message-ID: <20260324194333.30004-8-farosas@suse.de>
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
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A2A6B4D217
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Move the creation of the pointer marker along with the vmstate_save
call that writes it to the stream.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 78 ++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index a190c3f63f..0975d10793 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -54,36 +54,6 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
     return result;
 }
 
-/*
- * Create a ptr marker field when there's a NULL pointer detected in the
- * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
- * can't dereference the NULL pointer.
- */
-static const VMStateField *
-vmsd_create_ptr_marker_field(const VMStateField *field)
-{
-    VMStateField *fake = g_new0(VMStateField, 1);
-
-    /* It can only happen on an array of pointers! */
-    assert(field->flags & VMS_ARRAY_OF_POINTER);
-
-    /* Some of fake's properties should match the original's */
-    fake->name = field->name;
-    fake->version_id = field->version_id;
-
-    /* Do not need "field_exists" check as it always exists (which is null) */
-    fake->field_exists = NULL;
-
-    /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
-    fake->size = 1;
-    fake->info = &vmstate_info_ptr_marker;
-    fake->flags = VMS_SINGLE;
-
-    /* All the rest fields shouldn't matter.. */
-
-    return (const VMStateField *)fake;
-}
-
 static int vmstate_n_elems(void *opaque, const VMStateField *field)
 {
     int n_elems = 1;
@@ -592,6 +562,42 @@ vmstate_save_field_with_vmdesc(QEMUFile *f, void *pv, size_t size,
     return ok;
 }
 
+/*
+ * Create a ptr marker field to precede an element of a
+ * VMS_ARRAY_OF_POINTER VMSD field. This indicates whether the
+ * following element is a NULL pointer or a valid pointer. This is
+ * used to know whether a pointer needs to be followed when loading
+ * the data.
+ */
+static bool vmstate_ptr_marker_save(QEMUFile *f, void *opaque,
+                                    const VMStateDescription *vmsd,
+                                    const VMStateField *field,
+                                    JSONWriter *vmdesc,
+                                    int i, int max, Error **errp)
+{
+    g_autofree VMStateField *fake = g_new0(VMStateField, 1);
+
+    /* It can only happen on an array of pointers! */
+    assert(field->flags & VMS_ARRAY_OF_POINTER);
+
+    /* Some of fake's properties should match the original's */
+    fake->name = field->name;
+    fake->version_id = field->version_id;
+
+    /* Do not need "field_exists" check as it always exists */
+    fake->field_exists = NULL;
+
+    /* use 1 byte for the marker */
+    fake->size = 1;
+    fake->info = &vmstate_info_ptr_marker;
+    fake->flags = VMS_SINGLE;
+
+    /* All the rest fields shouldn't matter.. */
+
+    return vmstate_save_field_with_vmdesc(f, opaque, field->size, vmsd, fake,
+                                          vmdesc, i, max, errp);
+}
+
 static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
@@ -635,7 +641,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 int max_elems = n_elems - i;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    const VMStateField *inner_field;
                     bool use_marker_field, is_null, use_dynamic_array;
 
                     assert(curr_elem);
@@ -688,14 +693,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     }
 
                     if (use_marker_field) {
-                        inner_field = vmsd_create_ptr_marker_field(field);
-
-                        ok = vmstate_save_field_with_vmdesc(
-                            f, curr_elem, 1, vmsd, inner_field,
-                            use_vmdesc ? vmdesc : NULL, i, max_elems, errp);
-
-                        g_clear_pointer((gpointer *)&inner_field, g_free);
-
+                        ok = vmstate_ptr_marker_save(f, curr_elem, vmsd, field,
+                                                     use_vmdesc ? vmdesc : NULL,
+                                                     i, max_elems, errp);
                         if (!ok) {
                             goto out;
                         }
-- 
2.51.0


