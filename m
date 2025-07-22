Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF2FC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 23:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueMd6-0002Hx-LL; Tue, 22 Jul 2025 19:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMd0-0002Bq-Pe
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:34 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMcy-0007qF-J1
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB1401F78A;
 Tue, 22 Jul 2025 23:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+XAgmDBTmks2GsZR1QW1XdUNlqAMMzX8BRwPw+gsOQ=;
 b=mT3j9EHZNx1MSa5EKhUoaFfKqKuvEVDU8ggh+4eupXUGIH8SHoS41/v4ImSknCmsYA0WCv
 kPBcY/VpiV9CDhKXJ8F4DjfbZIL8Cq/EfIDtgL4Frslz/HGIlb5T8d1T4hrVQeRzq2jtxn
 X+P9gKZRWLkhv8qQdKFjPeq8MH2XkEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+XAgmDBTmks2GsZR1QW1XdUNlqAMMzX8BRwPw+gsOQ=;
 b=3WxXdwSq+F9Zz+MZCWUBkyd6OuaKFAZ4ujFpL6tR+tuOwT+qV5h6gZXyXHnIBAv/k4jR7Z
 3UFJcEOhHbXdsADw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mT3j9EHZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3WxXdwSq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+XAgmDBTmks2GsZR1QW1XdUNlqAMMzX8BRwPw+gsOQ=;
 b=mT3j9EHZNx1MSa5EKhUoaFfKqKuvEVDU8ggh+4eupXUGIH8SHoS41/v4ImSknCmsYA0WCv
 kPBcY/VpiV9CDhKXJ8F4DjfbZIL8Cq/EfIDtgL4Frslz/HGIlb5T8d1T4hrVQeRzq2jtxn
 X+P9gKZRWLkhv8qQdKFjPeq8MH2XkEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+XAgmDBTmks2GsZR1QW1XdUNlqAMMzX8BRwPw+gsOQ=;
 b=3WxXdwSq+F9Zz+MZCWUBkyd6OuaKFAZ4ujFpL6tR+tuOwT+qV5h6gZXyXHnIBAv/k4jR7Z
 3UFJcEOhHbXdsADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 193E313AF1;
 Tue, 22 Jul 2025 23:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YOwhMtshgGiqOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Jul 2025 23:42:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/7] migration: HMP: Fix possible out-of-bounds access
Date: Tue, 22 Jul 2025 20:42:09 -0300
Message-Id: <20250722234215.6807-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250722234215.6807-1-farosas@suse.de>
References: <20250722234215.6807-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: AB1401F78A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Coverity has caught a bug in the formatting of time intervals for
postcopy latency distribution display in 'info migrate'.

While bounds checking the labels array, sizeof is incorrectly being
used. ARRAY_SIZE is the correct form of obtaining the size of an
array.

Fixes: 3345fb3b6d ("migration/postcopy: Add latency distribution report for blocktime")
Resolves: Coverity CID 1612248
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250716182648.30202-2-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index cef5608210..bb954881d7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -57,11 +57,9 @@ static const gchar *format_time_str(uint64_t us)
     const char *units[] = {"us", "ms", "sec"};
     int index = 0;
 
-    while (us > 1000) {
+    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
         us /= 1000;
-        if (++index >= (sizeof(units) - 1)) {
-            break;
-        }
+        index++;
     }
 
     return g_strdup_printf("%"PRIu64" %s", us, units[index]);
-- 
2.35.3


