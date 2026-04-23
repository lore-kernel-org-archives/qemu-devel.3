Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC3FFDEE49
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdK-0006Qa-JI; Thu, 23 Apr 2026 15:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzd7-0005PX-Vr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:31 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzd5-0002Tv-Ay
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 566AB6A8B0;
 Thu, 23 Apr 2026 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsC0tAJU0vPUAdnXpmAN2YzSuLZ8Ne5Etd51mKJ9OnE=;
 b=JpIV7OW1MnIZkmAFwYZOyVotq/KrMRFP2Dk9JMty+LMdFKiKKWpm7EvkWFnG9Ixpw7XqKS
 GNqg0rZ7MquIlSWh2juHkP7zdUD8WioEZVHgE/pA8pRJn4+BLy2jzJQsOjNviqXFhkwQKu
 pfUlYJPBwuxz0PGYVw/0E5poccUmR1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsC0tAJU0vPUAdnXpmAN2YzSuLZ8Ne5Etd51mKJ9OnE=;
 b=zyolQZB/q8PtIQk5sdD1mJbyuuqDzQ0/hB7BfbTrBnkQdzfdjaXmrDEQK7cSu6ui2c1V/y
 5fZaZ5HzjOZ1D2DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JpIV7OW1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="zyolQZB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsC0tAJU0vPUAdnXpmAN2YzSuLZ8Ne5Etd51mKJ9OnE=;
 b=JpIV7OW1MnIZkmAFwYZOyVotq/KrMRFP2Dk9JMty+LMdFKiKKWpm7EvkWFnG9Ixpw7XqKS
 GNqg0rZ7MquIlSWh2juHkP7zdUD8WioEZVHgE/pA8pRJn4+BLy2jzJQsOjNviqXFhkwQKu
 pfUlYJPBwuxz0PGYVw/0E5poccUmR1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsC0tAJU0vPUAdnXpmAN2YzSuLZ8Ne5Etd51mKJ9OnE=;
 b=zyolQZB/q8PtIQk5sdD1mJbyuuqDzQ0/hB7BfbTrBnkQdzfdjaXmrDEQK7cSu6ui2c1V/y
 5fZaZ5HzjOZ1D2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49699593A3;
 Thu, 23 Apr 2026 19:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kCaoBRZx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Trieu Huynh <vikingtc4@gmail.com>
Subject: [PULL 35/43] migration: validate page_size in mapped-ram header
 before use
Date: Thu, 23 Apr 2026 16:19:49 -0300
Message-ID: <20260423191958.1440-36-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 566AB6A8B0
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

From: Trieu Huynh <vikingtc4@gmail.com>

mapped_ram_read_header() reads page_size from the migration stream and
stores it in MappedRamHeader, but does not validate that the value is
non-zero before it is later used in parse_ramblock_mapped_ram():

num_pages = length / header.page_size;

If a corrupted or malformed migration stream provides invalid, guest
resumes either with corrupted memory or crashes unexpectedly (eg.
page_size = 0)

Add validation in mapped_ram_read_header() to reject invalid page_size
values early and return an error instead of continuing with an invalid
header.

Steps to reproduce:

Create a migration snapshot with mapped-ram enabled:
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate file:/tmp/qemu-snapshots/snapshot.bin
Modify the snapshot so that MappedRamHeader.page_size becomes diff with
target psize. (0/512/8192/1GB).
Restore the snapshot:
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate_incoming file:/tmp/qemu-snapshots/snapshot.bin

As-is:
* [0]: Floating point exception (core dumped)
* [512/8192]: Silent corruption
* [1GB]: "post load hook failed for: kvm-tpr-opt" (EPERM)
To-be:
* All: qemu-system-x86_64: Migration mapped-ram header has invalid
  page_size [val] (expected 4096)

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260405094447.11347-1-viking4@gmail.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 979751f61b..2046f16caa 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3088,6 +3088,12 @@ static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
     }
 
     header->page_size = be64_to_cpu(header->page_size);
+    if (header->page_size != TARGET_PAGE_SIZE) {
+        error_setg(errp, "Migration mapped-ram header has invalid "
+                   "page_size %" PRIu64 " (expected %d)",
+                   header->page_size, TARGET_PAGE_SIZE);
+        return false;
+    }
     header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
     header->pages_offset = be64_to_cpu(header->pages_offset);
 
-- 
2.51.0


