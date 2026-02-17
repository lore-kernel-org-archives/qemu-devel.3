Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F19E909D4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjh-0001DM-5q; Tue, 17 Feb 2026 11:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjd-0001Cp-Fz
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:38 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjb-0003A1-HB
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A72263E728;
 Tue, 17 Feb 2026 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSqQyE8jOWlhQKDEeWRnmggAxcKfbhhB1Ozyl0vCABs=;
 b=s+EmT0F83l5AuMrcPRiZM/sunJxd2dPngZGuaFm9x3pepSsH36wjF/8q1QUyiWN5ZaP0hN
 Xlyt86I3lJ6PUiZsWq8Pn3CpAf/eFIDoAP9MrQGRuagU6wbsvOtGx2BOcOt+9EozX0nyyT
 wamlOeZb6Y7ArMR6hNO5+S3JK9xd5ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSqQyE8jOWlhQKDEeWRnmggAxcKfbhhB1Ozyl0vCABs=;
 b=YBwrwXdtyP8kj6h8tlRJ4lnIsQ7LoXpKBaUfE0Uvpf4WsK0A6Dcr2lUAwNs7IGrqumGRGn
 eVsCNsC/X+0N+EAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s+EmT0F8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YBwrwXdt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSqQyE8jOWlhQKDEeWRnmggAxcKfbhhB1Ozyl0vCABs=;
 b=s+EmT0F83l5AuMrcPRiZM/sunJxd2dPngZGuaFm9x3pepSsH36wjF/8q1QUyiWN5ZaP0hN
 Xlyt86I3lJ6PUiZsWq8Pn3CpAf/eFIDoAP9MrQGRuagU6wbsvOtGx2BOcOt+9EozX0nyyT
 wamlOeZb6Y7ArMR6hNO5+S3JK9xd5ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSqQyE8jOWlhQKDEeWRnmggAxcKfbhhB1Ozyl0vCABs=;
 b=YBwrwXdtyP8kj6h8tlRJ4lnIsQ7LoXpKBaUfE0Uvpf4WsK0A6Dcr2lUAwNs7IGrqumGRGn
 eVsCNsC/X+0N+EAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EB633EA66;
 Tue, 17 Feb 2026 16:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cAwcDQmUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 11/32] migration/colo: Unwrap qemu_savevm_live_state()
Date: Tue, 17 Feb 2026 13:14:22 -0300
Message-ID: <20260217161443.12738-12-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Queue-Id: A72263E728
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

It's only used in COLO path and only contains two calls.  Unwrap the
function.  It paves way for further reduce special COLO paths on sync.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-6-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/colo.c   | 3 ++-
 migration/savevm.c | 7 -------
 migration/savevm.h | 1 -
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa7..e05736ecf0 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -471,7 +471,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * TODO: We may need a timeout mechanism to prevent COLO process
      * to be blocked here.
      */
-    qemu_savevm_live_state(s->to_dst_file);
+    qemu_savevm_state_complete_precopy(s->to_dst_file, true);
+    qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
 
     qemu_fflush(fb);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f1cd8c913d..529cf310e0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1854,13 +1854,6 @@ cleanup:
     return ret;
 }
 
-void qemu_savevm_live_state(QEMUFile *f)
-{
-    /* save QEMU_VM_SECTION_END section */
-    qemu_savevm_state_complete_precopy(f, true);
-    qemu_put_byte(f, QEMU_VM_EOF);
-}
-
 /* Is a save state entry iterable (e.g. RAM)? */
 static bool qemu_savevm_se_iterable(SaveStateEntry *se)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index 5d815af742..528607f09e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
 void qemu_savevm_send_colo_enable(QEMUFile *f);
-void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
-- 
2.51.0


