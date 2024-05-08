Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA934C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpF-0002cs-CB; Wed, 08 May 2024 19:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpD-0002c5-0N
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpB-0002GU-CU
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C62555D38B;
 Wed,  8 May 2024 23:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yox7412cGTtUL2CQXPQpWip+SE1+94y2VLTqWSN6JyE=;
 b=GhWijWCoz+ufrq5nZCOJXYv8SczYD/uzMQVz0efy9we/GdYjFeZeiyk/C6OymVfa8OjXIk
 x16zQya2Z9GMd4YKWDZA0X6nYnSABw8sC3V2FcAHv9oZYe/rRH5bSRvRryVSRl1icJfF2R
 M6Qwe7U522h7ySY2wiDHaWnExr4BOfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yox7412cGTtUL2CQXPQpWip+SE1+94y2VLTqWSN6JyE=;
 b=zQYjyuwxsgYwvYtGDPqPZFQ1pwjR3bcXkmEQ64L0iJPzh6P98u+fU42SFqg/2fPyCpQqRZ
 vPYaakYbakmSt/Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GhWijWCo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zQYjyuwx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yox7412cGTtUL2CQXPQpWip+SE1+94y2VLTqWSN6JyE=;
 b=GhWijWCoz+ufrq5nZCOJXYv8SczYD/uzMQVz0efy9we/GdYjFeZeiyk/C6OymVfa8OjXIk
 x16zQya2Z9GMd4YKWDZA0X6nYnSABw8sC3V2FcAHv9oZYe/rRH5bSRvRryVSRl1icJfF2R
 M6Qwe7U522h7ySY2wiDHaWnExr4BOfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yox7412cGTtUL2CQXPQpWip+SE1+94y2VLTqWSN6JyE=;
 b=zQYjyuwxsgYwvYtGDPqPZFQ1pwjR3bcXkmEQ64L0iJPzh6P98u+fU42SFqg/2fPyCpQqRZ
 vPYaakYbakmSt/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6741813A27;
 Wed,  8 May 2024 23:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QOCDC1EMPGZ7FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 23:35:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Will Gyda <vilhelmgyda@gmail.com>
Subject: [PULL v2 01/13] migration/ram.c: API Conversion qemu_mutex_lock(),
 and qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro
Date: Wed,  8 May 2024 20:35:29 -0300
Message-Id: <20240508233541.2403-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508233541.2403-1-farosas@suse.de>
References: <20240508233541.2403-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C62555D38B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Will Gyda <vilhelmgyda@gmail.com>

migration/ram.c: API Conversion qemu_mutex_lock(),
and qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro

Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a975c5af16..50df1e9cd2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1066,14 +1066,14 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     trace_migration_bitmap_sync_start();
     memory_global_dirty_log_sync(last_stage);
 
-    qemu_mutex_lock(&rs->bitmap_mutex);
-    WITH_RCU_READ_LOCK_GUARD() {
-        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-            ramblock_sync_dirty_bitmap(rs, block);
+    WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
+        WITH_RCU_READ_LOCK_GUARD() {
+            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+                ramblock_sync_dirty_bitmap(rs, block);
+            }
+            stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
         }
-        stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
     }
-    qemu_mutex_unlock(&rs->bitmap_mutex);
 
     memory_global_after_dirty_log_sync();
     trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
-- 
2.35.3


