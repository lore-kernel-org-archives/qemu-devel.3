Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCB7FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzb2-0001p2-FA; Thu, 23 Apr 2026 15:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzb1-0001od-9q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzaz-0001l0-H2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 545266A890;
 Thu, 23 Apr 2026 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3aWhIjFyONuWGGwD79YRRSoT53jbvuQ0JXXq/gW2Zo=;
 b=1oI+yadsBuTWk0wch2wEJyW/H2EhxS6hhsaIlpiWrjnWqxvEx024nZgwXG4zujnH5hOybB
 p1qPsOKcQ4SJpw05Xry3/m30paSgShYTdADgefx3JNjneXPAE6C/CApQ8QOgXY7CGtJdiY
 1aYuulusUXFCdofhTCY1I1TSil6Icbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3aWhIjFyONuWGGwD79YRRSoT53jbvuQ0JXXq/gW2Zo=;
 b=/oFt4a/Du+CiCABpZTzbJgDHqffFpLSoRUmMHA76R5D0M3BQYAET2s0BJii24sV+csxCk6
 dK/RQTsofPCa5YBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1oI+yads;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/oFt4a/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3aWhIjFyONuWGGwD79YRRSoT53jbvuQ0JXXq/gW2Zo=;
 b=1oI+yadsBuTWk0wch2wEJyW/H2EhxS6hhsaIlpiWrjnWqxvEx024nZgwXG4zujnH5hOybB
 p1qPsOKcQ4SJpw05Xry3/m30paSgShYTdADgefx3JNjneXPAE6C/CApQ8QOgXY7CGtJdiY
 1aYuulusUXFCdofhTCY1I1TSil6Icbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3aWhIjFyONuWGGwD79YRRSoT53jbvuQ0JXXq/gW2Zo=;
 b=/oFt4a/Du+CiCABpZTzbJgDHqffFpLSoRUmMHA76R5D0M3BQYAET2s0BJii24sV+csxCk6
 dK/RQTsofPCa5YBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EABA593A3;
 Thu, 23 Apr 2026 19:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPZCB+Zw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 04/43] migration: make vmstate_save_state_v() static
Date: Thu, 23 Apr 2026 16:19:18 -0300
Message-ID: <20260423191958.1440-5-farosas@suse.de>
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
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 545266A890
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

It's used only in vmstate.c.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-3-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h |  3 ---
 migration/vmstate.c         | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 62c2abd0c4..78d97151bd 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1244,9 +1244,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc,
-                         int version_id, Error **errp);
 
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index fccd030dfd..651c3fe011 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -420,15 +420,9 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
     return true;
 }
 
-
-int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
-{
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
-}
-
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
+static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                                void *opaque, JSONWriter *vmdesc,
+                                int version_id, Error **errp)
 {
     ERRP_GUARD();
     int ret = 0;
@@ -608,6 +602,13 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
     return NULL;
 }
 
+int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
+{
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id,
+                                errp);
+}
+
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, Error **errp)
 {
-- 
2.51.0


