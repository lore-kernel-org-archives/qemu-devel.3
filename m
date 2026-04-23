Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD42FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdR-0007Iw-Ln; Thu, 23 Apr 2026 15:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcf-0004b9-BB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:02 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcd-0002Hm-KR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E8596A895;
 Thu, 23 Apr 2026 19:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtD9R39osz5Yw6zLx6fAJZEvdDrA61iRI14Z4AjFJ4o=;
 b=rNAXuRoBklZ+75BBhEHndV6JLBQ33xVsBJ2ZG36875NFaFlHSGurFn/UyRFK8T6kOynCWn
 C2+fSxuKmG/zCWH8Sjovp2LJbdNp9TIwwb/8kBoVfPF9C1f0tBfqC2K+oo0fdcV3OLlg6Y
 PzckwjO1027/W2QFtbtuvIoR/ZGuw9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtD9R39osz5Yw6zLx6fAJZEvdDrA61iRI14Z4AjFJ4o=;
 b=iez0f+7PgTF3m3LxR7WmCa429+RAVQZvNLj6tOJv63l+othUuzRl/KLoE3ePswLKVZThid
 ez8mv0AyLXWqMsBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rNAXuRoB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iez0f+7P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtD9R39osz5Yw6zLx6fAJZEvdDrA61iRI14Z4AjFJ4o=;
 b=rNAXuRoBklZ+75BBhEHndV6JLBQ33xVsBJ2ZG36875NFaFlHSGurFn/UyRFK8T6kOynCWn
 C2+fSxuKmG/zCWH8Sjovp2LJbdNp9TIwwb/8kBoVfPF9C1f0tBfqC2K+oo0fdcV3OLlg6Y
 PzckwjO1027/W2QFtbtuvIoR/ZGuw9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtD9R39osz5Yw6zLx6fAJZEvdDrA61iRI14Z4AjFJ4o=;
 b=iez0f+7PgTF3m3LxR7WmCa429+RAVQZvNLj6tOJv63l+othUuzRl/KLoE3ePswLKVZThid
 ez8mv0AyLXWqMsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68639593A3;
 Thu, 23 Apr 2026 19:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ALqNDQxx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 29/43] vmstate: Introduce vmstate_save_field_with_vmdesc()
Date: Thu, 23 Apr 2026 16:19:43 -0300
Message-ID: <20260423191958.1440-30-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9E8596A895
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Introduce a helper to do both the JSON blob generations and save vmstate.
This further shrinks the function a bit.  More importantly, we'll need to
save two fields in one loop very soon in the future with the JSON blob.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-7-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 05badef42f..b274204e66 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -514,6 +514,35 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
     return true;
 }
 
+/*
+ * Save a whole VMSD field, including its JSON blob separately when @vmdesc
+ * is specified.
+ */
+static inline bool
+vmstate_save_field_with_vmdesc(QEMUFile *f, void *pv, size_t size,
+                               const VMStateDescription *vmsd,
+                               const VMStateField *field, JSONWriter *vmdesc,
+                               int i, int max, Error **errp)
+{
+    uint64_t old_offset, written_bytes;
+    bool ok;
+
+    vmsd_desc_field_start(vmsd, vmdesc, field, i, max);
+
+    old_offset = qemu_file_transferred(f);
+    ok = vmstate_save_field(f, pv, size, field, vmdesc, errp);
+    written_bytes = qemu_file_transferred(f) - old_offset;
+
+    vmsd_desc_field_end(vmsd, vmdesc, field, written_bytes);
+
+    if (!ok) {
+        error_prepend(errp, "Save of field %s/%s failed: ",
+                      vmsd->name, field->name);
+    }
+
+    return ok;
+}
+
 static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
@@ -542,7 +571,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
-            uint64_t old_offset, written_bytes;
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
 
@@ -559,7 +587,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 /* maximum number of elements to compress in the JSON blob */
                 int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
 
-                old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
@@ -606,15 +633,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     }
                 }
 
-                vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
-                                      i, max_elems);
-
-                ok = vmstate_save_field(f, curr_elem, size, inner_field,
-                                        vmdesc_loop, errp);
-
-                written_bytes = qemu_file_transferred(f) - old_offset;
-                vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
-                                    written_bytes);
+                ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
+                                                    inner_field, vmdesc_loop,
+                                                    i, max_elems, errp);
 
                 /* If we used a fake temp field.. free it now */
                 if (is_null) {
@@ -622,8 +643,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 if (!ok) {
-                    error_prepend(errp, "Save of field %s/%s failed: ",
-                                  vmsd->name, field->name);
                     goto out;
                 }
 
-- 
2.51.0


