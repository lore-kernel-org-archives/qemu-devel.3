Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85BEC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYGF-0000Ge-9d; Fri, 23 Aug 2024 13:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYG3-0007ys-5J
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYG1-0008VR-AD
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07559226F4;
 Fri, 23 Aug 2024 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=EHZG1DGlwq0/8ruhvgbn4le962rVpdsGae2BoQqle18SVGXovLB7N8MRafozh7fVZ/+s/P
 zK8gyRgB2OmruiF3WByoavp+Q//M6JAUqOWVikDrSD+0n+uhDnUZKVGmZlomI5vqSHEJ/9
 WkRRfosb71Y/R4VQIc16OeSNGf2OU1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=D/SRf68a76v5aDtQj5ufWE4Y7PH1LXjYJ+l+Ki/vZsJBOlgAt6nwKHlyeDmS2UwV7cU52/
 5cAhSwPV6lyoujDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=EHZG1DGlwq0/8ruhvgbn4le962rVpdsGae2BoQqle18SVGXovLB7N8MRafozh7fVZ/+s/P
 zK8gyRgB2OmruiF3WByoavp+Q//M6JAUqOWVikDrSD+0n+uhDnUZKVGmZlomI5vqSHEJ/9
 WkRRfosb71Y/R4VQIc16OeSNGf2OU1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=D/SRf68a76v5aDtQj5ufWE4Y7PH1LXjYJ+l+Ki/vZsJBOlgAt6nwKHlyeDmS2UwV7cU52/
 5cAhSwPV6lyoujDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF9DC1333E;
 Fri, 23 Aug 2024 17:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ANnjJE7JyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 08/16] migration/multifd: Move pages accounting into
 multifd_send_zero_page_detect()
Date: Fri, 23 Aug 2024 14:39:03 -0300
Message-Id: <20240823173911.6712-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823173911.6712-1-farosas@suse.de>
References: <20240823173911.6712-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.985];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zero-page.c | 7 ++++++-
 migration/multifd.c           | 2 --
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index 6506a4aa89..f1e988a959 100644
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
index c310d28532..410b7e12cc 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -989,8 +989,6 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
-            stat64_add(&mig_stats.normal_pages, pages->normal_num);
-            stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
 
             multifd_pages_reset(pages);
             p->next_packet_size = 0;
-- 
2.35.3


