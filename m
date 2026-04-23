Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4FEFDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzb9-0001qK-2A; Thu, 23 Apr 2026 15:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzb7-0001px-Lo
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:25 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzb5-0001mT-Pz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 688B15BD72;
 Thu, 23 Apr 2026 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLrq5vYRQzUEjpc8nDFyc527zDnf568anUwnKtbHDA4=;
 b=xP5kueji0NMII7sLVqVg+mW2PfP1GRf4lagwzZAB3UjeKsS8yVpDN2BuEkJrvJDSGaG6tY
 +83FQq7e+g+33FcUJzpJ670+ZOcANtGqLvucIJRn2xD9Cwx/Ca2+q+UfarqT4uQ1zCW5CM
 qUj+dJQMJDmpFXdQd9R5BuTueLPqyJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLrq5vYRQzUEjpc8nDFyc527zDnf568anUwnKtbHDA4=;
 b=9LoG355OTy97v8LDlec9/k6vCdXvAKTL4pnpnXGNV5/3DIZiWAZ/KVwB8tJtT1DhmdxOS/
 2U2kHwAT3iVGfQCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xP5kueji;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9LoG355O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLrq5vYRQzUEjpc8nDFyc527zDnf568anUwnKtbHDA4=;
 b=xP5kueji0NMII7sLVqVg+mW2PfP1GRf4lagwzZAB3UjeKsS8yVpDN2BuEkJrvJDSGaG6tY
 +83FQq7e+g+33FcUJzpJ670+ZOcANtGqLvucIJRn2xD9Cwx/Ca2+q+UfarqT4uQ1zCW5CM
 qUj+dJQMJDmpFXdQd9R5BuTueLPqyJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLrq5vYRQzUEjpc8nDFyc527zDnf568anUwnKtbHDA4=;
 b=9LoG355OTy97v8LDlec9/k6vCdXvAKTL4pnpnXGNV5/3DIZiWAZ/KVwB8tJtT1DhmdxOS/
 2U2kHwAT3iVGfQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61D19593A3;
 Thu, 23 Apr 2026 19:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sJj7C/Bw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 11/43] migration: factor out vmstate_load_field() from
 vmstate_load_state()
Date: Thu, 23 Apr 2026 16:19:25 -0300
Message-ID: <20260423191958.1440-12-farosas@suse.de>
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
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 688B15BD72
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Simplify vmstate_load_state() which is rather big, and simplify further
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-10-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 35dbe1550e..32944c0444 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -161,6 +161,27 @@ static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
     return true;
 }
 
+static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, Error **errp)
+{
+    if (field->flags & VMS_STRUCT) {
+        return vmstate_load_state(f, field->vmsd, pv, field->vmsd->version_id,
+                                  errp) >= 0;
+    } else if (field->flags & VMS_VSTRUCT) {
+        return vmstate_load_state(f, field->vmsd, pv, field->struct_version_id,
+                                  errp) >= 0;
+    }
+
+    if (field->info->get(f, pv, size, field) < 0) {
+        error_setg(errp,
+                   "Failed to load element of type %s for %s",
+                   field->info->name, field->name);
+        return false;
+    }
+
+    return true;
+}
+
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
@@ -225,24 +246,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                     inner_field = field;
                 }
 
-                if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->vmsd->version_id,
-                                             errp);
-                } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->struct_version_id,
-                                             errp);
-                } else {
-                    ret = inner_field->info->get(f, curr_elem, size,
-                                                 inner_field);
-                    if (ret < 0) {
-                        error_setg(errp,
-                                   "Failed to load element of type %s for %s: "
-                                   "%d", inner_field->info->name,
-                                   inner_field->name, ret);
-                    }
-                }
+                ret = vmstate_load_field(f, curr_elem, size, inner_field,
+                                         errp) ? 0 : -EINVAL;
 
                 /* If we used a fake temp field.. free it now */
                 if (inner_field != field) {
-- 
2.51.0


