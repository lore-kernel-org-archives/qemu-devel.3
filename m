Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528D6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxJu-00038U-RD; Mon, 22 Jul 2024 13:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJt-00034F-K6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJp-00037c-Rw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8080C21B11;
 Mon, 22 Jul 2024 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F8uqsyx4QWoTlzopVcW8Z9o1ZrQmpekAfO9pBHU+Sw=;
 b=sEcYDgA0WzEnIyO7IlIog2vzJmT83jXNiz7JDKCELVNOzzwWk3yMxBLi+PqdfQqViFMzKK
 3BGzt7JoibwBkhqecR3yi+yRGimVGSSJMJXXDaP3yjHmtxVZwpah+O8jv4oMnRwSe0Ejpq
 vOWEp+/0xobjwzlD1CiFqaNvvl2qmfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F8uqsyx4QWoTlzopVcW8Z9o1ZrQmpekAfO9pBHU+Sw=;
 b=Fbr7djNGbJ9P+RQYAlyX5mIAApT98tOJoXBgRcQJ8mOSbWj6pTMyQLxRzYi6rYToLKJIux
 DnFW7xO05C0VGzCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sEcYDgA0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fbr7djNG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F8uqsyx4QWoTlzopVcW8Z9o1ZrQmpekAfO9pBHU+Sw=;
 b=sEcYDgA0WzEnIyO7IlIog2vzJmT83jXNiz7JDKCELVNOzzwWk3yMxBLi+PqdfQqViFMzKK
 3BGzt7JoibwBkhqecR3yi+yRGimVGSSJMJXXDaP3yjHmtxVZwpah+O8jv4oMnRwSe0Ejpq
 vOWEp+/0xobjwzlD1CiFqaNvvl2qmfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F8uqsyx4QWoTlzopVcW8Z9o1ZrQmpekAfO9pBHU+Sw=;
 b=Fbr7djNGbJ9P+RQYAlyX5mIAApT98tOJoXBgRcQJ8mOSbWj6pTMyQLxRzYi6rYToLKJIux
 DnFW7xO05C0VGzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58E4D13996;
 Mon, 22 Jul 2024 17:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEwhCP+dnmYnCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 17:59:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH v2 6/9] migration/multifd: Move pages accounting into
 multifd_send_zero_page_detect()
Date: Mon, 22 Jul 2024 14:59:11 -0300
Message-Id: <20240722175914.24022-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722175914.24022-1-farosas@suse.de>
References: <20240722175914.24022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.19 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8080C21B11
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

All references to pages are being removed from the multifd worker
threads in order to allow multifd to deal with different payload
types.

multifd_send_zero_page_detect() is called by all multifd migration
paths that deal with pages and is the last spot where zero pages and
normal page amounts are adjusted. Move the pages accounting into that
function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zero-page.c | 7 ++++++-
 migration/multifd.c           | 2 --
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index efc0424f74..899e8864c6 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -14,6 +14,7 @@
 #include "qemu/cutils.h"
 #include "exec/ramblock.h"
 #include "migration.h"
+#include "migration-stats.h"
 #include "multifd.h"
 #include "options.h"
 #include "ram.h"
@@ -53,7 +54,7 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
 
     if (!multifd_zero_page_enabled()) {
         pages->normal_num = pages->num;
-        return;
+        goto out;
     }
 
     /*
@@ -74,6 +75,10 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
     }
 
     pages->normal_num = i;
+
+out:
+    stat64_add(&mig_stats.normal_pages, pages->normal_num);
+    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
 }
 
 void multifd_recv_zero_page_process(MultiFDRecvParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index f64b053e44..fcdb12e04f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -972,8 +972,6 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
-            stat64_add(&mig_stats.normal_pages, pages->normal_num);
-            stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
 
             multifd_pages_reset(pages);
             p->next_packet_size = 0;
-- 
2.35.3


