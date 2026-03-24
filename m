Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBF9FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57ff-0003GK-Dc; Tue, 24 Mar 2026 15:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fb-0003Fs-Ud
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:07 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w57fZ-0008ED-C1
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:44:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD94B4D29A;
 Tue, 24 Mar 2026 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iifD1ZJD/OWYjxjW9swI71sEK/kXSYVXV76A7LYh7TE=;
 b=2JnBfOIP9DGBdFlcWWiWp5pgNV5JHX6ZUocBdBduuAQ+pQ2H6Dto2JvTniZbmwXdrUqXU7
 7Lk/j4OM7nntLX0yBECYt+V75UVhRfD84rRvPhn+1NsVBQ8Sy2yCwqMWFUKXVa949CFi9B
 fJrHPsOc3fBhDdpGmTj+SvJgD0A/YVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iifD1ZJD/OWYjxjW9swI71sEK/kXSYVXV76A7LYh7TE=;
 b=pSMLDsIuhtm0udwUAyunS8GM30xC2BEw6EZUiRsQ847jNTLVuJ69wrA2YZG2Q8fOT+NbOr
 8N9AECTdfsZblhCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774381430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iifD1ZJD/OWYjxjW9swI71sEK/kXSYVXV76A7LYh7TE=;
 b=2JnBfOIP9DGBdFlcWWiWp5pgNV5JHX6ZUocBdBduuAQ+pQ2H6Dto2JvTniZbmwXdrUqXU7
 7Lk/j4OM7nntLX0yBECYt+V75UVhRfD84rRvPhn+1NsVBQ8Sy2yCwqMWFUKXVa949CFi9B
 fJrHPsOc3fBhDdpGmTj+SvJgD0A/YVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774381430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iifD1ZJD/OWYjxjW9swI71sEK/kXSYVXV76A7LYh7TE=;
 b=pSMLDsIuhtm0udwUAyunS8GM30xC2BEw6EZUiRsQ847jNTLVuJ69wrA2YZG2Q8fOT+NbOr
 8N9AECTdfsZblhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 950C443FE4;
 Tue, 24 Mar 2026 19:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6DwcGXXpwmlkMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Mar 2026 19:43:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [RFC PATCH v1 09/17] vmstate: Increase scope of vmstate_handle_alloc
Date: Tue, 24 Mar 2026 16:43:24 -0300
Message-ID: <20260324194333.30004-10-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324194333.30004-1-farosas@suse.de>
References: <20260324194333.30004-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
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

Move more code into vmstate_handle_alloc. If it's going to handle,
make it handle it all.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 8437b5ef3e..0cdfde2232 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -100,15 +100,23 @@ static int vmstate_size(void *opaque, const VMStateField *field)
     return size;
 }
 
-static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
+static void *vmstate_handle_alloc(void *ptr, const VMStateField *field,
                                  int size, int n_elems)
 {
-    if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
-        size *= n_elems;
-        if (size) {
-            *(void **)ptr = g_malloc(size);
+    void *new = ptr;
+
+    if (field->flags & VMS_POINTER) {
+        if (field->flags & VMS_ALLOC) {
+            size *= n_elems;
+            if (size) {
+                new = g_malloc(size);
+                *(void **)ptr = new;
+            }
         }
+        assert(new || !n_elems || !size);
+        return *(void **)ptr;
     }
+    return new;
 }
 
 static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
@@ -247,11 +255,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
 
-            vmstate_handle_alloc(first_elem, field, size, n_elems);
-            if (field->flags & VMS_POINTER) {
-                first_elem = *(void **)first_elem;
-                assert(first_elem || !n_elems || !size);
-            }
+            first_elem = vmstate_handle_alloc(first_elem, field, size, n_elems);
 
             for (i = 0; i < n_elems; i++) {
                 /* If we will process the load of field? */
-- 
2.51.0


