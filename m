Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D23BC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdf-0001KE-BC; Wed, 26 Aug 2026 10:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdZ-0001Fn-Nx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:57 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdY-0002KY-13
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93BB51F83F;
 Wed, 26 Aug 2026 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBG7zgvfo5U/tM0hH20FGaiL9Ze+m0OgHs/aAMimbio=;
 b=ZYqWLbbrtOnGUb5y3dX1ehvM+wnCPWZNzBhr/qZNLiAve48MKa8AnqmFutyHYSwOYmdR6R
 QqvRdDpljKUKEAfytSD5f6QjUvbH7BcjekEq7YxtI6LeBRcgmHy+ZLLgIOdhU/O+TUddaT
 eOnEKNCtj49UZRT8XcqPXHY6oqnClFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBG7zgvfo5U/tM0hH20FGaiL9Ze+m0OgHs/aAMimbio=;
 b=7mmHoBcqA4Iet22wlYBA7H8EjqF8yeinMl1EWpUAnCmLYwht2253plu5PVDByQ2BvXT21h
 4muE0xeE0hYUvlBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBG7zgvfo5U/tM0hH20FGaiL9Ze+m0OgHs/aAMimbio=;
 b=WK6SY5KtCuXIoEfx6k2xRKaHXtfhxK7MdNVtQq1I3EstOY0tchYPovoRnOq7mv9apvhaN2
 zjtTNVLU9Fw6649KvRqDfXFM9J78zzyp33KQst2zSnsrcxXDEvYq1z8uSD5GlHpVH+xauh
 y4wBKIKWOz5AoWpeXDNb52GXI9tccZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBG7zgvfo5U/tM0hH20FGaiL9Ze+m0OgHs/aAMimbio=;
 b=puJ3uNq4X+8RnjgGb74PQgF4GQn6zxqZCgG4CTBboVeNENl3fB4UmvkhWhWWwZc/2PRM3U
 Ulj+HqVXEu5FrUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D08D613675;
 Wed, 26 Aug 2026 14:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UPgWKFn4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 29/30] migration: Harden vmstate_size
Date: Wed, 26 Aug 2026 11:29:04 -0300
Message-ID: <20260826142905.2315503-30-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.18)[-0.906];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Protect vmstate_size against overflow of the on-stack 64bit integer
during multiplication. The data at size_indirect.offset comes from the
migration stream.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 1d028bfe009..08548ae7a1f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -113,14 +113,20 @@ static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
     return n_elems;
 }
 
-static uint64_t vmstate_size(void *opaque, const VMStateField *field)
+static bool vmstate_size(void *opaque, const VMStateField *field,
+                         uint64_t *sz, Error **errp)
 {
     uint64_t size;
 
+    *sz = 0;
+
     if (field->flags & VMS_VBUFFER) {
         size = vmstate_read_from_offset(&field->size_indirect, opaque);
-        if (field->flags & VMS_MULTIPLY) {
-            size *= field->size;
+        if ((field->flags & VMS_MULTIPLY) &&
+            umul64_overflow(size, field->size, &size)) {
+            error_setg(errp, "%s: VMState field '%s' multiply overflow",
+                       __func__, field->name);
+            return false;
         }
     } else if (field->flags & VMS_ARRAY_OF_POINTER) {
         /*
@@ -132,7 +138,8 @@ static uint64_t vmstate_size(void *opaque, const VMStateField *field)
         size = field->size;
     }
 
-    return size;
+    *sz = size;
+    return true;
 }
 
 static bool vmstate_handle_alloc(void *ptr, const VMStateField *field,
@@ -364,7 +371,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i;
             uint64_t n_elems = vmstate_n_elems(opaque, field);
-            uint64_t size = vmstate_size(opaque, field);
+            uint64_t size;
+
+            if (!vmstate_size(opaque, field, &size, errp)) {
+                return false;
+            }
 
             if (!vmstate_handle_alloc(first_elem, field, n_elems, size, errp)) {
                 return false;
@@ -682,9 +693,10 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i;
             uint64_t n_elems = vmstate_n_elems(opaque, field);
-            uint64_t size = vmstate_size(opaque, field);
+            uint64_t size;
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
+
             /*
              * When this is enabled, it means we will always push a ptr
              * marker first for each element saying if it's populated.
@@ -692,6 +704,10 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             bool use_dynamic_array =
                 field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
 
+            if (!vmstate_size(opaque, field, &size, errp)) {
+                return false;
+            }
+
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
-- 
2.53.0


