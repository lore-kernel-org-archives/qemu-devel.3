Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C07CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNb-00056m-DU; Wed, 04 Sep 2024 08:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNZ-0004x9-1W
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNX-0005bR-FJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:56 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E43EA2119F;
 Wed,  4 Sep 2024 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=yVBK7SEAyQhbK1Z8/ClRZz4G8mo8LnyWXi5IFDOvE9p0MDPmuL22yObR+8kxhEjV/LJye2
 rPHhxXUNXyimSeeUiDDf2TnSe7vCeYIENkNsF/h0OTs3kZk1rl0yojAWaYRbBzBr4dNd/H
 kjsuMQcvHTu1lqGKbjO8NPKqGaLNAPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=pLN6MR0N9aJ63UJ2d95sTyreG8ShPkunIwNdkiF/CJyKoswBI9WSjaeKWYchbV0QaEclvq
 kVA1vgfhP5kgtPCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Iux7mLF0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l7fJkt+8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=Iux7mLF09aU3B7F6eIvnyCjmNAjhiUqAD7+z+VB5XON3dKFdAbvQLOSLFeZUqZheVHDMag
 2TdL1bV2dSVHn8dMw8HhXeJvUFvdTaglf6c4QujOvbvdQSznvTKAuySD/h+6SlpG+myuyQ
 fRLTWoP7b+AwGRYcXQy1nRXyliglVQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMCk6K5d6G6+9Y8txB3BHcZSoOMR6I+KaV+SlQizkAs=;
 b=l7fJkt+8OfnVSN4O/vp0pRL2aJeUK8TJBskpUmBxqpE42ONgV3U81utRGEEzNG+IM1Ke9J
 nV+MreF70XC/AyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE4C0139D2;
 Wed,  4 Sep 2024 12:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IObxIERW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/34] migration/multifd: Move pages accounting into
 multifd_send_zero_page_detect()
Date: Wed,  4 Sep 2024 09:44:02 -0300
Message-Id: <20240904124417.14565-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E43EA2119F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


