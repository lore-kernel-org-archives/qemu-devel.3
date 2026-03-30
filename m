Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADA1061B1C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hw2-00046R-AM; Mon, 30 Mar 2026 15:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7HvX-0003pC-EG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7HvT-0005DL-BP
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B48004D533;
 Mon, 30 Mar 2026 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbhTYF27d4quzV9aPtNfi9/ss0fDuKO62BO9wUgx+rw=;
 b=zk/NBMhhgaKzGWfe7bCQNushUCuMfWVyG4LC7o7yKGunbXwLHpZBy5PK4/EYT5GHKGTC+G
 3Qi7nUMl0BLQY3nh6QPgTAuuWZW+0/DuafmAkcLl6DcE7E5S4iDxqjxWZyQkh7edvr2hxd
 lLzj1RPevYcElwGGumWbX1adJAgXcr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbhTYF27d4quzV9aPtNfi9/ss0fDuKO62BO9wUgx+rw=;
 b=f8AtCTnn8cfFN48OwRgIfvsyzg+Ou687NzQBaFAFp8+DZpSLUCqznZSdbW3LB0g1xbotXq
 gtf93wLu6uXRk9BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zk/NBMhh";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f8AtCTnn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbhTYF27d4quzV9aPtNfi9/ss0fDuKO62BO9wUgx+rw=;
 b=zk/NBMhhgaKzGWfe7bCQNushUCuMfWVyG4LC7o7yKGunbXwLHpZBy5PK4/EYT5GHKGTC+G
 3Qi7nUMl0BLQY3nh6QPgTAuuWZW+0/DuafmAkcLl6DcE7E5S4iDxqjxWZyQkh7edvr2hxd
 lLzj1RPevYcElwGGumWbX1adJAgXcr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbhTYF27d4quzV9aPtNfi9/ss0fDuKO62BO9wUgx+rw=;
 b=f8AtCTnn8cfFN48OwRgIfvsyzg+Ou687NzQBaFAFp8+DZpSLUCqznZSdbW3LB0g1xbotXq
 gtf93wLu6uXRk9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAB1E4A0A2;
 Mon, 30 Mar 2026 19:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yPA4ImjJymlGdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Mar 2026 19:05:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 2/3] migration: Fix references to parameter names in error
 messages
Date: Mon, 30 Mar 2026 16:05:07 -0300
Message-ID: <20260330190508.8634-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330190508.8634-1-farosas@suse.de>
References: <20260330190508.8634-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B48004D533
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

From: Markus Armbruster <armbru@redhat.com>

Migration parameter names separate words with hyphens.  A number of
error messages in migrate_params_check() use underscores instead.
Wrong since day one.  Fix them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260326074247.188674-3-armbru@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3eb5b39186..7556fbc06b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1133,103 +1133,103 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->throttle_trigger_threshold < 1 ||
         params->throttle_trigger_threshold > 100) {
-        error_setg(errp, "Option throttle_trigger_threshold expects "
+        error_setg(errp, "Option throttle-trigger-threshold expects "
                    "an integer in the range of 1 to 100");
         return false;
     }
 
     if (params->cpu_throttle_initial < 1 ||
         params->cpu_throttle_initial > 99) {
-        error_setg(errp, "Option cpu_throttle_initial expects "
+        error_setg(errp, "Option cpu-throttle-initial expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->cpu_throttle_increment < 1 ||
         params->cpu_throttle_increment > 99) {
-        error_setg(errp, "Option cpu_throttle_increment expects "
+        error_setg(errp, "Option cpu-throttle-increment expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->max_bandwidth > SIZE_MAX) {
-        error_setg(errp, "Option max_bandwidth expects "
+        error_setg(errp, "Option max-bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->avail_switchover_bandwidth > SIZE_MAX) {
-        error_setg(errp, "Option avail_switchover_bandwidth expects "
+        error_setg(errp, "Option avail-switchover-bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->downtime_limit > MAX_MIGRATE_DOWNTIME) {
-        error_setg(errp, "Option downtime_limit expects "
+        error_setg(errp, "Option downtime-limit expects "
                    "an integer in the range of 0 to "
                     stringify(MAX_MIGRATE_DOWNTIME)" ms");
         return false;
     }
 
     if (params->multifd_channels < 1) {
-        error_setg(errp, "Option multifd_channels expects "
+        error_setg(errp, "Option multifd-channels expects "
                    "a value between 1 and 255");
         return false;
     }
 
     if (params->multifd_zlib_level > 9) {
-        error_setg(errp, "Option multifd_zlib_level expects "
+        error_setg(errp, "Option multifd-zlib-level expects "
                    "a value between 0 and 9");
         return false;
     }
 
     if (params->multifd_qatzip_level > 9 ||
         params->multifd_qatzip_level < 1) {
-        error_setg(errp, "Option multifd_qatzip_level expects "
+        error_setg(errp, "Option multifd-qatzip-level expects "
                    "a value between 1 and 9");
         return false;
     }
 
     if (params->multifd_zstd_level > 20) {
-        error_setg(errp, "Option multifd_zstd_level expects "
+        error_setg(errp, "Option multifd-zstd-level expects "
                    "a value between 0 and 20");
         return false;
     }
 
     if (params->xbzrle_cache_size < qemu_target_page_size() ||
         !is_power_of_2(params->xbzrle_cache_size)) {
-        error_setg(errp, "Option xbzrle_cache_size expects "
+        error_setg(errp, "Option xbzrle-cache-size expects "
                    "a power of two no less than the target page size");
         return false;
     }
 
     if (params->max_cpu_throttle < params->cpu_throttle_initial ||
         params->max_cpu_throttle > 99) {
-        error_setg(errp, "Option max_cpu_throttle expects "
-                   "an integer in the range of cpu_throttle_initial to 99");
+        error_setg(errp, "Option max-cpu-throttle expects "
+                   "an integer in the range of cpu-throttle-initial to 99");
         return false;
     }
 
     if (params->announce_initial > 100000) {
-        error_setg(errp, "Option announce_initial expects "
+        error_setg(errp, "Option announce-initial expects "
                    "a value between 0 and 100000");
         return false;
     }
     if (params->announce_max > 100000) {
-        error_setg(errp, "Option announce_max expects "
+        error_setg(errp, "Option announce-max expects "
                    "a value between 0 and 100000");
         return false;
     }
     if (params->announce_rounds > 1000) {
-        error_setg(errp, "Option announce_rounds expects "
+        error_setg(errp, "Option announce-rounds expects "
                    "a value between 0 and 1000");
         return false;
     }
     if (params->announce_step < 1 ||
         params->announce_step > 10000) {
-        error_setg(errp, "Option announce_step expects "
+        error_setg(errp, "Option announce-step expects "
                    "a value between 0 and 10000");
         return false;
     }
@@ -1264,7 +1264,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->vcpu_dirty_limit < 1) {
         error_setg(errp,
-                   "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s");
+                   "Parameter 'vcpu-dirty-limit' must be greater than 1 MB/s");
         return false;
     }
 
-- 
2.51.0


