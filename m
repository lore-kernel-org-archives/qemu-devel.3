Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D5CC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6qk-0006R4-9Q; Wed, 16 Jul 2025 14:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uc6qP-0006LY-7v
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:27:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uc6qN-0001x0-1k
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:27:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 729881F46E;
 Wed, 16 Jul 2025 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752690420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtX1O2I9BMmRDZtXbgHZCd2O7u4o2gwwrmyJoQmcV2E=;
 b=FONIYm4j9NOedNw7usgVA6LCdcgW5zBwWtJGvuJB/NCpNDsf5SFVnyWEmVJIRwbGhf/EVv
 9qq9f+LnzHuyIaPOfjZXFtkEOX2A7utiH7bvbtCbwafyGhQ6eruIpDdSbfMpWgrw2aBlEM
 n8x3KnrGwaSzbgDpVWpZzAcQD7B61ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752690420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtX1O2I9BMmRDZtXbgHZCd2O7u4o2gwwrmyJoQmcV2E=;
 b=UKW/SUZ1VNFUi/k+NvrXvMN5Q/wKJtZc0D//0u2S/EYn6VWjT+bDNxNEnhT7R534weBw57
 j/Kdn2I5ZMl525BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FONIYm4j;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="UKW/SUZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752690420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtX1O2I9BMmRDZtXbgHZCd2O7u4o2gwwrmyJoQmcV2E=;
 b=FONIYm4j9NOedNw7usgVA6LCdcgW5zBwWtJGvuJB/NCpNDsf5SFVnyWEmVJIRwbGhf/EVv
 9qq9f+LnzHuyIaPOfjZXFtkEOX2A7utiH7bvbtCbwafyGhQ6eruIpDdSbfMpWgrw2aBlEM
 n8x3KnrGwaSzbgDpVWpZzAcQD7B61ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752690420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtX1O2I9BMmRDZtXbgHZCd2O7u4o2gwwrmyJoQmcV2E=;
 b=UKW/SUZ1VNFUi/k+NvrXvMN5Q/wKJtZc0D//0u2S/EYn6VWjT+bDNxNEnhT7R534weBw57
 j/Kdn2I5ZMl525BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 964BA138D2;
 Wed, 16 Jul 2025 18:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EHkbFfLud2hmWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Jul 2025 18:26:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 3/3] cutils: Add time_us_to_str
Date: Wed, 16 Jul 2025 15:26:48 -0300
Message-Id: <20250716182648.30202-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716182648.30202-1-farosas@suse.de>
References: <20250716182648.30202-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 729881F46E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The migration code has a function that converts a time value (us) to a
string with the proper suffix. Move it to cutils since it's generic
enough that it could be reused.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/cutils.h          |  1 +
 migration/migration-hmp-cmds.c | 17 ++---------------
 util/cutils.c                  | 13 +++++++++++++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 36c68ce86c..0e8c5f4275 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -171,6 +171,7 @@ int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
 int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
 
 char *size_to_str(uint64_t val);
+char *time_us_to_str(uint64_t us);
 
 /**
  * freq_to_str:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a8b879c9d6..1706f3a0f7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -52,19 +52,6 @@ static void migration_global_dump(Monitor *mon)
                    ms->clear_bitmap_shift);
 }
 
-static const gchar *format_time_str(uint64_t us)
-{
-    const char *units[] = {"us", "ms", "sec"};
-    int index = 0;
-
-    while (us >= 1000 && index + 1 < ARRAY_SIZE(units)) {
-        us /= 1000;
-        index++;
-    }
-
-    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
-}
-
 static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
 {
     if (info->has_postcopy_blocktime) {
@@ -121,8 +108,8 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
         monitor_printf(mon, "Postcopy Latency Distribution:\n");
 
         while (item) {
-            g_autofree const gchar *from = format_time_str(1UL << count);
-            g_autofree const gchar *to = format_time_str(1UL << (count + 1));
+            g_autofree const gchar *from = time_us_to_str(1UL << count);
+            g_autofree const gchar *to = time_us_to_str(1UL << (count + 1));
 
             monitor_printf(mon, "  [ %8s - %8s ]: %10"PRIu64"\n",
                            from, to, item->value);
diff --git a/util/cutils.c b/util/cutils.c
index 9803f11a59..dd45d33173 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1004,6 +1004,19 @@ char *freq_to_str(uint64_t freq_hz)
     return g_strdup_printf("%0.3g %sHz", freq, si_prefix(exp10));
 }
 
+char *time_us_to_str(uint64_t us)
+{
+    static const char *units[] = {"us", "ms", "sec"};
+    int index = 0;
+
+    while (us >= 1000 && index + 1 < ARRAY_SIZE(units)) {
+        us /= 1000;
+        index++;
+    }
+
+    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
+}
+
 int qemu_pstrcmp0(const char **str1, const char **str2)
 {
     return g_strcmp0(*str1, *str2);
-- 
2.35.3


