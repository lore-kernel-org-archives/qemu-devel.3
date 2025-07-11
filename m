Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DAFC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEZU-0003i5-98; Fri, 11 Jul 2025 10:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETB-0001XR-Dh
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET9-0006fZ-5I
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FB571F385;
 Fri, 11 Jul 2025 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LEnV05GAdxAxtoxmlpP5GQRyBBCmk1hTN15A8D+Gww=;
 b=TxAGTiwCKMxs7XInMYI/5qUiu7F+eI/Yuq2wj7grWoXoA/bCmBcbfCOeFFHzJLng36Olb0
 HAVkKIHA8DgLLOLrd+TEU1jARW5WZJldd+SODR7pTKUMAvORTOwxDTcYOozlGDJIyhXdVm
 H8AhWCAahDxeg9ao6u4Sx+jHrOhXWBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LEnV05GAdxAxtoxmlpP5GQRyBBCmk1hTN15A8D+Gww=;
 b=MSKg/sTW2GiuhDDYqApINJ5rwd4JXCG9I/lMXaku9qFj5+XrQkyZ1A41bLfwJOflpU+IK6
 VG9KJEuUfX0IzuDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TxAGTiwC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MSKg/sTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LEnV05GAdxAxtoxmlpP5GQRyBBCmk1hTN15A8D+Gww=;
 b=TxAGTiwCKMxs7XInMYI/5qUiu7F+eI/Yuq2wj7grWoXoA/bCmBcbfCOeFFHzJLng36Olb0
 HAVkKIHA8DgLLOLrd+TEU1jARW5WZJldd+SODR7pTKUMAvORTOwxDTcYOozlGDJIyhXdVm
 H8AhWCAahDxeg9ao6u4Sx+jHrOhXWBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LEnV05GAdxAxtoxmlpP5GQRyBBCmk1hTN15A8D+Gww=;
 b=MSKg/sTW2GiuhDDYqApINJ5rwd4JXCG9I/lMXaku9qFj5+XrQkyZ1A41bLfwJOflpU+IK6
 VG9KJEuUfX0IzuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DE0A1388B;
 Fri, 11 Jul 2025 14:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNsTA2sbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 08/26] migration/ram: One less indent for
 ram_find_and_save_block()
Date: Fri, 11 Jul 2025 11:10:13 -0300
Message-Id: <20250711141031.423-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FB571F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

The check over PAGE_DIRTY_FOUND isn't necessary. We could indent one less
and assert that instead.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250613140801.474264-9-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ffd839f57c..aa76f0a53f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2286,16 +2286,18 @@ static int ram_find_and_save_block(RAMState *rs)
         if (!get_queued_page(rs, pss)) {
             /* priority queue empty, so just search for something dirty */
             int res = find_dirty_block(rs, pss);
-            if (res != PAGE_DIRTY_FOUND) {
-                if (res == PAGE_ALL_CLEAN) {
-                    break;
-                } else if (res == PAGE_TRY_AGAIN) {
-                    continue;
-                } else if (res < 0) {
-                    pages = res;
-                    break;
-                }
+
+            if (res == PAGE_ALL_CLEAN) {
+                break;
+            } else if (res == PAGE_TRY_AGAIN) {
+                continue;
+            } else if (res < 0) {
+                pages = res;
+                break;
             }
+
+            /* Otherwise we must have a dirty page to move */
+            assert(res == PAGE_DIRTY_FOUND);
         }
         pages = ram_save_host_page(rs, pss);
         if (pages) {
-- 
2.35.3


