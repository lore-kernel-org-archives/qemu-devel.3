Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0F9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuE-0001NE-RY; Fri, 10 Jan 2025 07:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuB-0001MZ-EC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:24 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDu9-0003If-PH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FC9F21176;
 Fri, 10 Jan 2025 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEplQfT+yNi2INrr+tAujXmMK9gQpBsqLlBhgcXapZs=;
 b=uwvBhOrr7I0PXS88TCPMF6bdb0MuEOdePl3W37dc8ZkCxL/0eTprHm5HgJjx2hnPqcCE4E
 SySM++UAPAhuA+3ENmJQmlHWqwYuoR1jI5cRCZ3bTYMf9beRInub3ue3gOMQKhdUphfgre
 5w+/YF9lMhVu+WdPWwKHl5MxyARerzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEplQfT+yNi2INrr+tAujXmMK9gQpBsqLlBhgcXapZs=;
 b=hkCb40wqlzbooTU8FlogUMbr9WkfCeldqnL/5SHK3elmNUrEadk/l0UZEATjNMpqdWgrAR
 h3Mf8CfisSJRUvCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEplQfT+yNi2INrr+tAujXmMK9gQpBsqLlBhgcXapZs=;
 b=uwvBhOrr7I0PXS88TCPMF6bdb0MuEOdePl3W37dc8ZkCxL/0eTprHm5HgJjx2hnPqcCE4E
 SySM++UAPAhuA+3ENmJQmlHWqwYuoR1jI5cRCZ3bTYMf9beRInub3ue3gOMQKhdUphfgre
 5w+/YF9lMhVu+WdPWwKHl5MxyARerzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEplQfT+yNi2INrr+tAujXmMK9gQpBsqLlBhgcXapZs=;
 b=hkCb40wqlzbooTU8FlogUMbr9WkfCeldqnL/5SHK3elmNUrEadk/l0UZEATjNMpqdWgrAR
 h3Mf8CfisSJRUvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0066D13A86;
 Fri, 10 Jan 2025 12:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MBbhLRkPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PULL 01/25] migration/multifd: Fix compile error caused by page_size
 usage
Date: Fri, 10 Jan 2025 09:13:49 -0300
Message-Id: <20250110121413.12336-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

>From Commit 90fa121c6c07 ("migration/multifd: Inline page_size and
page_count") onwards page_size is not part of MutiFD*Params but uses
an inline constant instead.

However, it missed updating an old usage, causing a compile error.

Fixes: 90fa121c6c07 ("migration/multifd: Inline page_size and page_count")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241203124943.52572-1-shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-uadk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 6e6a290ae9..6895c1f65a 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -169,7 +169,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
             .src_len = page_size,
             .dst     = buf,
             /* Set dst_len to double the src in case compressed out >= page_size */
-            .dst_len = p->page_size * 2,
+            .dst_len = page_size * 2,
         };
 
         if (uadk_data->handle) {
-- 
2.35.3


