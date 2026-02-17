Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E65DE909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkF-0003Jn-SE; Tue, 17 Feb 2026 11:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkE-0003C3-AJ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:14 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkC-0003F0-Cr
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 06D355BD20;
 Tue, 17 Feb 2026 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tK4/ttAO/SNXZmJLNh5rwp3VCdcNm1uinpaCsgNSp1M=;
 b=JyCIBlvmOFNjDkOIF2I6UI3it+Q20HnET5vec0svinR2SKiLiCqFHAoT1zj/uaAVgOz1cu
 IgXl3NJnJHM3Pc2fb4aW9A2/D1Nq5QWIsElsd++XBuezsXAqcJMamek7/GCtqIHZDQI0Xe
 gUK4AfMEGdaz+xQMXLbcweHPibdMGxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tK4/ttAO/SNXZmJLNh5rwp3VCdcNm1uinpaCsgNSp1M=;
 b=d50Tdt3Voby7qBiz12UY9lcF/5wr4AVh65rMfPunFmKRPnR80qaTWJHWtOXXch5WycY/5O
 pv/OwdU50gBchMDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JyCIBlvm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d50Tdt3V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tK4/ttAO/SNXZmJLNh5rwp3VCdcNm1uinpaCsgNSp1M=;
 b=JyCIBlvmOFNjDkOIF2I6UI3it+Q20HnET5vec0svinR2SKiLiCqFHAoT1zj/uaAVgOz1cu
 IgXl3NJnJHM3Pc2fb4aW9A2/D1Nq5QWIsElsd++XBuezsXAqcJMamek7/GCtqIHZDQI0Xe
 gUK4AfMEGdaz+xQMXLbcweHPibdMGxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tK4/ttAO/SNXZmJLNh5rwp3VCdcNm1uinpaCsgNSp1M=;
 b=d50Tdt3Voby7qBiz12UY9lcF/5wr4AVh65rMfPunFmKRPnR80qaTWJHWtOXXch5WycY/5O
 pv/OwdU50gBchMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C36F53EA66;
 Tue, 17 Feb 2026 16:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SEbNIR2UlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 23/32] migration: qemu_savevm_state_complete_precopy() take
 MigrationState*
Date: Tue, 17 Feb 2026 13:14:34 -0300
Message-ID: <20260217161443.12738-24-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 06D355BD20
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

From: Peter Xu <peterx@redhat.com>

Make it pass in MigrationState* instead of s->to_dst_file, so as to drop
the internal migrate_get_current().

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-18-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 +-
 migration/savevm.c    | 7 ++++---
 migration/savevm.h    | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b1d421953f..27e4456429 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2757,7 +2757,7 @@ static int migration_completion_precopy(MigrationState *s)
         goto out_unlock;
     }
 
-    ret = qemu_savevm_state_complete_precopy(s->to_dst_file);
+    ret = qemu_savevm_state_complete_precopy(s);
 out_unlock:
     bql_unlock();
     return ret;
diff --git a/migration/savevm.c b/migration/savevm.c
index e1918d4f38..830d8e5988 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1728,8 +1728,9 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f)
+int qemu_savevm_state_complete_precopy(MigrationState *s)
 {
+    QEMUFile *f = s->to_dst_file;
     int ret;
 
     ret = qemu_savevm_state_complete_precopy_iterable(f, false);
@@ -1742,7 +1743,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f)
         return ret;
     }
 
-    qemu_savevm_state_end_precopy(migrate_get_current(), f);
+    qemu_savevm_state_end_precopy(s, f);
 
     return qemu_fflush(f);
 }
@@ -1841,7 +1842,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_state_complete_precopy(f);
+        qemu_savevm_state_complete_precopy(ms);
         ret = qemu_file_get_error(f);
     }
     if (ret != 0) {
diff --git a/migration/savevm.h b/migration/savevm.h
index 57b96133d5..bded5e2a6c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -42,7 +42,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(QEMUFile *f);
+int qemu_savevm_state_complete_precopy(MigrationState *s);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-- 
2.51.0


