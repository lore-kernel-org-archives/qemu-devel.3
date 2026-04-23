Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1602FDEE47
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzbv-00022X-UM; Thu, 23 Apr 2026 15:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbO-0001sT-Dq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:45 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbM-0001pw-NI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93D866A8A0;
 Thu, 23 Apr 2026 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18fjL14Ng1FIiFptO1WgrOoN/4au2W6z2AZR18y3h0A=;
 b=wEdSQ1+6XsyBH56KSUgfuubFhNmA6gSIN4pJPwwDZqlmWgP+n0R1WmYxh7uajY+htFdz+R
 Lp2m21eDXIU1LNDr6AZ6PTp2/U+6Uo5TNH6VHsdA78TjbbmmIb2RGcOYfo552AXCgiT5u/
 2GuK/BqDqcLmVKGr/7PPlxGtDRli76Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18fjL14Ng1FIiFptO1WgrOoN/4au2W6z2AZR18y3h0A=;
 b=5/lCWhPZliylw5RcGqx6QdpSzFGSzKuJJhA/O0/p+fiVNQ9WXkFnKucNH3ZOHaViaWrZQg
 bZ1WQKBmkwLBNEDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wEdSQ1+6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5/lCWhPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18fjL14Ng1FIiFptO1WgrOoN/4au2W6z2AZR18y3h0A=;
 b=wEdSQ1+6XsyBH56KSUgfuubFhNmA6gSIN4pJPwwDZqlmWgP+n0R1WmYxh7uajY+htFdz+R
 Lp2m21eDXIU1LNDr6AZ6PTp2/U+6Uo5TNH6VHsdA78TjbbmmIb2RGcOYfo552AXCgiT5u/
 2GuK/BqDqcLmVKGr/7PPlxGtDRli76Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18fjL14Ng1FIiFptO1WgrOoN/4au2W6z2AZR18y3h0A=;
 b=5/lCWhPZliylw5RcGqx6QdpSzFGSzKuJJhA/O0/p+fiVNQ9WXkFnKucNH3ZOHaViaWrZQg
 bZ1WQKBmkwLBNEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F19C593A3;
 Thu, 23 Apr 2026 19:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qJqrFu1w6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 09/43] migration: factor out vmstate_save_field() from
 vmstate_save_state()
Date: Thu, 23 Apr 2026 16:19:23 -0300
Message-ID: <20260423191958.1440-10-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 93D866A8A0
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Simplify vmstate_save_state() which is rather big, and simplify further
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-8-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 605b5c59c7..2ce2652712 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -26,6 +26,9 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, Error **errp);
+static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                                void *opaque, JSONWriter *vmdesc,
+                                int version_id, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -455,6 +458,26 @@ static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
     return true;
 }
 
+static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field,
+                               JSONWriter *vmdesc, Error **errp)
+{
+    if (field->flags & VMS_STRUCT) {
+        return vmstate_save_state(f, field->vmsd, pv, vmdesc, errp) >= 0;
+    } else if (field->flags & VMS_VSTRUCT) {
+        return vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
+                                    field->struct_version_id,
+                                    errp) >= 0;
+    }
+
+    if (field->info->put(f, pv, size, field, vmdesc) < 0) {
+        error_setg(errp, "put failed");
+        return false;
+    }
+
+    return true;
+}
+
 static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
@@ -548,21 +571,8 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
                                       i, max_elems);
 
-                if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_save_state(f, inner_field->vmsd,
-                                             curr_elem, vmdesc_loop, errp);
-                } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_save_state_v(f, inner_field->vmsd,
-                                               curr_elem, vmdesc_loop,
-                                               inner_field->struct_version_id,
-                                               errp);
-                } else {
-                    ret = inner_field->info->put(f, curr_elem, size,
-                                                 inner_field, vmdesc_loop);
-                    if (ret < 0) {
-                        error_setg(errp, "put failed");
-                    }
-                }
+                ret = vmstate_save_field(f, curr_elem, size, inner_field,
+                                         vmdesc_loop, errp) ? 0 : -EINVAL;
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
-- 
2.51.0


