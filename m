Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8113FE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuH-0001O4-C0; Fri, 10 Jan 2025 07:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuC-0001Mq-OH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:24 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDu9-0003J1-SB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:24 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 936951F396;
 Fri, 10 Jan 2025 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZSRB5t2E3G8kXMBdf8ePMdgnliqsqKLLrG0XDbfGJI=;
 b=Wa7NqSDrhrC0KWujK8/aKL47UpASHwvWmqzp8nRKCGJa8i1w9FLjvAH7Yp2FNj2F64jpRz
 svl6EPnawGKyGijWt0DMIhkHJWedmFN1A42ZyO7EFc8+TktRm+fDru8hRWbmrvqzuaxprF
 GxurLXBt1zef5DDkVz7WL7wT6UyYkh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZSRB5t2E3G8kXMBdf8ePMdgnliqsqKLLrG0XDbfGJI=;
 b=ZhPbcrOuPC8sIDdBaklSexFmtG8B3QIMFQeG3E7ORa9TvXW1xoSHTVMRjXvKFkHDp/cgAl
 vAfW/KzsR9eKB3CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZSRB5t2E3G8kXMBdf8ePMdgnliqsqKLLrG0XDbfGJI=;
 b=Wa7NqSDrhrC0KWujK8/aKL47UpASHwvWmqzp8nRKCGJa8i1w9FLjvAH7Yp2FNj2F64jpRz
 svl6EPnawGKyGijWt0DMIhkHJWedmFN1A42ZyO7EFc8+TktRm+fDru8hRWbmrvqzuaxprF
 GxurLXBt1zef5DDkVz7WL7wT6UyYkh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZSRB5t2E3G8kXMBdf8ePMdgnliqsqKLLrG0XDbfGJI=;
 b=ZhPbcrOuPC8sIDdBaklSexFmtG8B3QIMFQeG3E7ORa9TvXW1xoSHTVMRjXvKFkHDp/cgAl
 vAfW/KzsR9eKB3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E17613A86;
 Fri, 10 Jan 2025 12:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OAuzGBsPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 02/25] migration/multifd: Further remove the SYNC on complete
Date: Fri, 10 Jan 2025 09:13:50 -0300
Message-Id: <20250110121413.12336-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
complete()") stopped sending the RAM_SAVE_FLAG_MULTIFD_FLUSH flag at
ram_save_complete(), because the sync on the destination side is not
needed due to the last iteration of find_dirty_block() having already
done it.

However, that commit overlooked that multifd_ram_flush_and_sync() on the
source side is also not needed at ram_save_complete(), for the same
reason.

Moreover, removing the RAM_SAVE_FLAG_MULTIFD_FLUSH but keeping the
multifd_ram_flush_and_sync() means that currently the recv threads will
hang when receiving the MULTIFD_FLAG_SYNC message, waiting for the
destination sync which only happens when RAM_SAVE_FLAG_MULTIFD_FLUSH is
received.

Luckily, multifd is still all working fine because recv side cleanup
code (mostly multifd_recv_sync_main()) is smart enough to make sure even
if recv threads are stuck at SYNC it'll get kicked out. And since this
is the completion phase of migration, nothing else will be sent after
the SYNCs.

This needs to be fixed because in the future VFIO will have data to push
after ram_save_complete() and we don't want the recv thread to be stuck
in the MULTIFD_FLAG_SYNC message.

Remove the unnecessary (and buggy) invocation of
multifd_ram_flush_and_sync().

For very old binaries (multifd_flush_after_each_section==true), the
flush_and_sync is still needed because each EOS received on destination
will enforce all-channel sync once.

Stable branches do not need this patch, as no real bug I can think of
that will go wrong there.. so not attaching Fixes to be clear on the
backport not needed.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241206224755.1108686-2-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a60666d3f6..f0ddd5eabe 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_ram_flush_and_sync();
-    if (ret < 0) {
-        return ret;
+    if (migrate_multifd() &&
+        migrate_multifd_flush_after_each_section()) {
+        /*
+         * Only the old dest QEMU will need this sync, because each EOS
+         * will require one SYNC message on each channel.
+         */
+        ret = multifd_ram_flush_and_sync();
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (migrate_mapped_ram()) {
-- 
2.35.3


