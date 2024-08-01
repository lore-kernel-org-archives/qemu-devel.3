Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B5AC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV1w-0008UG-Mv; Thu, 01 Aug 2024 08:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1p-0008Pr-FW
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:34 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1j-0000kU-EU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CECD81FB53;
 Thu,  1 Aug 2024 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlbdlyS3wD1Vr1zi5TCYT5nsVT27+ZPER/70Lu/RqYE=;
 b=Nz4pkc+HY1fm6o63I0dN6DlmF97dLc0+7KO94zJ3VPssfaiL4vflKe1uoQqaDyoKZESxIX
 WSRQzjC3OLEq8ZieQVKfOgoC12LMru6l9K+Mn8KIkwOfBEbP9rDsy3ChKEuRTKjhOMu/Kt
 g4MpqhSN6EriyXK7q3GqRv+mEf1eeFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlbdlyS3wD1Vr1zi5TCYT5nsVT27+ZPER/70Lu/RqYE=;
 b=grqDKXBlbERGyf4oWybYPPcYJJTHz2pfVE+/zR69O83F3YAMg7Sss4/tBs++Oq58vbfDYs
 T/uF5RLX6eue2TDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nz4pkc+H;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=grqDKXBl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlbdlyS3wD1Vr1zi5TCYT5nsVT27+ZPER/70Lu/RqYE=;
 b=Nz4pkc+HY1fm6o63I0dN6DlmF97dLc0+7KO94zJ3VPssfaiL4vflKe1uoQqaDyoKZESxIX
 WSRQzjC3OLEq8ZieQVKfOgoC12LMru6l9K+Mn8KIkwOfBEbP9rDsy3ChKEuRTKjhOMu/Kt
 g4MpqhSN6EriyXK7q3GqRv+mEf1eeFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlbdlyS3wD1Vr1zi5TCYT5nsVT27+ZPER/70Lu/RqYE=;
 b=grqDKXBlbERGyf4oWybYPPcYJJTHz2pfVE+/zR69O83F3YAMg7Sss4/tBs++Oq58vbfDYs
 T/uF5RLX6eue2TDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A566213946;
 Thu,  1 Aug 2024 12:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sBLhGguBq2YEYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 12:35:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 03/14] migration/multifd: Remove pages->allocated
Date: Thu,  1 Aug 2024 09:35:05 -0300
Message-Id: <20240801123516.4498-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801123516.4498-1-farosas@suse.de>
References: <20240801123516.4498-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CECD81FB53
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This value never changes and is always the same as page_count. We
don't need a copy of it per-channel plus one in the extra slot. Remove
it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 6 ++----
 migration/multifd.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 33f91c9561..b4ca135b47 100644
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


