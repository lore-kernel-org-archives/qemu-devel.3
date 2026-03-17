Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B7DFEDA03
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z5w-00053m-Iy; Tue, 17 Mar 2026 14:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z5e-0004np-0U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:24:27 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z5W-00038l-AG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:24:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C36E4D3AD;
 Tue, 17 Mar 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDlmwArkCxjTT0GX8cOvaVkFYslbsSU3puMZfR93qBQ=;
 b=0b3vkuAJowkNZPoXa5ox7aIJcGVCxumBY4FqklFyZjvauI8So+sceqEWcV+5t/smO1ek5M
 dJVj+xCIkbRWoQMlL81cTt/IZaFuXMq3NF+bwzKtyoCAdZRaoQD3Xd6IZPEjMPQVXYTM6R
 9SqneJatTvcvvXFQaCtvVQgDU1wwUD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDlmwArkCxjTT0GX8cOvaVkFYslbsSU3puMZfR93qBQ=;
 b=aR+8VCDmOZYY3XOR0cTS/X7GJJ+8PSS/dEzEh9k0m2k051el/6Uc6z13fC0Z0CTC6wAH9t
 FcJeZrvQJ2YiK0CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDlmwArkCxjTT0GX8cOvaVkFYslbsSU3puMZfR93qBQ=;
 b=0b3vkuAJowkNZPoXa5ox7aIJcGVCxumBY4FqklFyZjvauI8So+sceqEWcV+5t/smO1ek5M
 dJVj+xCIkbRWoQMlL81cTt/IZaFuXMq3NF+bwzKtyoCAdZRaoQD3Xd6IZPEjMPQVXYTM6R
 9SqneJatTvcvvXFQaCtvVQgDU1wwUD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDlmwArkCxjTT0GX8cOvaVkFYslbsSU3puMZfR93qBQ=;
 b=aR+8VCDmOZYY3XOR0cTS/X7GJJ+8PSS/dEzEh9k0m2k051el/6Uc6z13fC0Z0CTC6wAH9t
 FcJeZrvQJ2YiK0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 469664273B;
 Tue, 17 Mar 2026 18:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +H/FAyicuWnXdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 18:23:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PULL 08/10] migration: fix implicit integer division in
 migration_update_counters
Date: Tue, 17 Mar 2026 15:23:18 -0300
Message-ID: <20260317182320.31991-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317182320.31991-1-farosas@suse.de>
References: <20260317182320.31991-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Aadeshveer Singh <aadeshveer07@gmail.com>

switchover_bw is a uint64_t, so switchover_bw / 1000 results in an
integer division. This value is then assigned to expected_bw_per_ms
which is of type double. This results in losing precision and is type
unsafe. Adding explicit cast ensures floating-point division.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260316134509.157964-1-aadeshveer07@gmail.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7feeba804f..5c9aaa6e58 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3141,7 +3141,7 @@ static void migration_update_counters(MigrationState *s,
          * If the user specified a switchover bandwidth, let's trust the
          * user so that can be more accurate than what we estimated.
          */
-        expected_bw_per_ms = switchover_bw / 1000;
+        expected_bw_per_ms = (double)switchover_bw / 1000;
     } else {
         /* If the user doesn't specify bandwidth, we use the estimated */
         expected_bw_per_ms = bandwidth;
-- 
2.51.0


