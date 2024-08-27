Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA7CC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Gt-0000t9-HQ; Tue, 27 Aug 2024 13:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj0Gq-0000pv-N1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:46:20 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj0Gn-0000Ua-P6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:46:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D40F21B20;
 Tue, 27 Aug 2024 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724780776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0HSli6qqhvsrwlkZtUULc7TpZRojqiByjP50yocx8g=;
 b=Ow5kmJae5dc2oLzoehT11nab0TzfZVp6plBP1n6hJUvKgcwL+qMTjeZX+x6N9MTjac8yxp
 2Iy4bJKIkjgsOtvNEa6t9MmEWeJftAghdO1ABk/GHrXASiMxYWhCtCQSVfX1qQCPrdLKHF
 yC1D3f0JWRJ845eljb7nEGW9npW8ZzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724780776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0HSli6qqhvsrwlkZtUULc7TpZRojqiByjP50yocx8g=;
 b=YRLMfoJhPbIWsX5TzLIBYqGH41B9z0M1ERy2Hpn/r7o9J5Y0RK89v79m/XR3o5uECBCXYa
 4BWOIDW0jMCtakCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ow5kmJae;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YRLMfoJh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724780776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0HSli6qqhvsrwlkZtUULc7TpZRojqiByjP50yocx8g=;
 b=Ow5kmJae5dc2oLzoehT11nab0TzfZVp6plBP1n6hJUvKgcwL+qMTjeZX+x6N9MTjac8yxp
 2Iy4bJKIkjgsOtvNEa6t9MmEWeJftAghdO1ABk/GHrXASiMxYWhCtCQSVfX1qQCPrdLKHF
 yC1D3f0JWRJ845eljb7nEGW9npW8ZzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724780776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0HSli6qqhvsrwlkZtUULc7TpZRojqiByjP50yocx8g=;
 b=YRLMfoJhPbIWsX5TzLIBYqGH41B9z0M1ERy2Hpn/r7o9J5Y0RK89v79m/XR3o5uECBCXYa
 4BWOIDW0jMCtakCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1B9313A20;
 Tue, 27 Aug 2024 17:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WGRILeYQzma+UAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Aug 2024 17:46:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 03/19] migration/multifd: Remove pages->allocated
Date: Tue, 27 Aug 2024 14:45:50 -0300
Message-Id: <20240827174606.10352-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240827174606.10352-1-farosas@suse.de>
References: <20240827174606.10352-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D40F21B20
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This value never changes and is always the same as page_count. We
don't need a copy of it per-channel plus one in the extra slot. Remove
it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 6 ++----
 migration/multifd.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3dfed8a005..30e5c687d3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -396,7 +396,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
 {
     MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
 
-    pages->allocated = n;
     pages->offset = g_new0(ram_addr_t, n);
 
     return pages;
@@ -405,7 +404,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
 static void multifd_pages_clear(MultiFDPages_t *pages)
 {
     multifd_pages_reset(pages);
-    pages->allocated = 0;
     g_free(pages->offset);
     pages->offset = NULL;
     g_free(pages);
@@ -420,7 +418,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     int i;
 
     packet->flags = cpu_to_be32(p->flags);
-    packet->pages_alloc = cpu_to_be32(pages->allocated);
+    packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
     packet->normal_pages = cpu_to_be32(pages->normal_num);
     packet->zero_pages = cpu_to_be32(zero_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
@@ -651,7 +649,7 @@ static inline bool multifd_queue_empty(MultiFDPages_t *pages)
 
 static inline bool multifd_queue_full(MultiFDPages_t *pages)
 {
-    return pages->num == pages->allocated;
+    return pages->num == multifd_ram_page_count();
 }
 
 static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
diff --git a/migration/multifd.h b/migration/multifd.h
index a2bba23af9..660a9882c2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -76,8 +76,6 @@ typedef struct {
     uint32_t num;
     /* number of normal pages */
     uint32_t normal_num;
-    /* number of allocated pages */
-    uint32_t allocated;
     /* offset of each page */
     ram_addr_t *offset;
     RAMBlock *block;
-- 
2.35.3


