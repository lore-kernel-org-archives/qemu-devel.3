Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A650C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfXX-0005zq-Cg; Tue, 15 Jul 2025 09:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ubf3F-00016y-B9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:46:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ubf3A-0004sO-B5
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:46:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40B981F38F;
 Tue, 15 Jul 2025 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752583570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ue/1ZT8MzZ8v7guZM96vxMTgrZWJ6Tz5qKYXtjRr3Y=;
 b=MpiSwF84Lcj3ITwfRCp1aGH/YwrPXg7BAm7gt/1UEX8RGd8iR9Vv7KVY/34QyJudBZYz++
 1xjdzsLE2Mq0Stkebgk7a6CGZ+gye6C5/DHEsdNP1a2CBU8pkE8cqZALwwJq3hL+svvHll
 mEumSAnzaxf3srGPmcq492zsmbXz5GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752583570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ue/1ZT8MzZ8v7guZM96vxMTgrZWJ6Tz5qKYXtjRr3Y=;
 b=yZji1Avdg94PEmqf/XWEGbJ7S5/ZjSNp1n/sR7yWtPdafCuFT1FpbIyoqdFiZBeAVAApv9
 5C+zY8clL2v7Z7DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MpiSwF84;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yZji1Avd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752583570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ue/1ZT8MzZ8v7guZM96vxMTgrZWJ6Tz5qKYXtjRr3Y=;
 b=MpiSwF84Lcj3ITwfRCp1aGH/YwrPXg7BAm7gt/1UEX8RGd8iR9Vv7KVY/34QyJudBZYz++
 1xjdzsLE2Mq0Stkebgk7a6CGZ+gye6C5/DHEsdNP1a2CBU8pkE8cqZALwwJq3hL+svvHll
 mEumSAnzaxf3srGPmcq492zsmbXz5GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752583570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ue/1ZT8MzZ8v7guZM96vxMTgrZWJ6Tz5qKYXtjRr3Y=;
 b=yZji1Avdg94PEmqf/XWEGbJ7S5/ZjSNp1n/sR7yWtPdafCuFT1FpbIyoqdFiZBeAVAApv9
 5C+zY8clL2v7Z7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BD4413306;
 Tue, 15 Jul 2025 12:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wB8tFpBNdmiKKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Jul 2025 12:46:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] cutils: Add time_us_to_str
Date: Tue, 15 Jul 2025 09:45:52 -0300
Message-Id: <20250715124552.28038-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250715124552.28038-1-farosas@suse.de>
References: <20250715124552.28038-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40B981F38F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/cutils.h          |  1 +
 migration/migration-hmp-cmds.c | 17 ++---------------
 util/cutils.c                  | 13 +++++++++++++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 36c68ce86c..7621726621 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -171,6 +171,7 @@ int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
 int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
 
 char *size_to_str(uint64_t val);
+char *time_us_to_str(uint64_t val);
 
 /**
  * freq_to_str:
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index bb954881d7..1706f3a0f7 100644
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
-    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
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
index 9803f11a59..023793211a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1004,6 +1004,19 @@ char *freq_to_str(uint64_t freq_hz)
     return g_strdup_printf("%0.3g %sHz", freq, si_prefix(exp10));
 }
 
+char *time_us_to_str(uint64_t us)
+{
+    const char *units[] = {"us", "ms", "sec"};
+    int index = 0;
+
+    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
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


