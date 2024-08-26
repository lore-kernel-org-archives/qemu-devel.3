Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CEEC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifmd-0007DC-3X; Mon, 26 Aug 2024 15:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmW-0006w4-FT
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:53:42 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmU-0002De-Ql
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:53:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9410521AE0;
 Mon, 26 Aug 2024 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39t9Cv16AimeidENCBivcEBi5CMLaC52094MjW94ySo=;
 b=eLaSyKHAZd5ddzcv9WoaiQZuRpCRFTcgdQiw73xtRJ1AVjh/qqSNUlDst0acZDMuz5TGUX
 9Xyud3lWBfW39MR4EEFbpHjRcbX6sGD38xqOaj5W9K0zPRWTuW85UwwSSo8w8f7ZSpK+sG
 gSXOYS/Eo3uQMuyyCq4QAjkJ7+i+lMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39t9Cv16AimeidENCBivcEBi5CMLaC52094MjW94ySo=;
 b=qK4lqKQ5d8GQW/zEUlb5qhkZx4WRVhxpLq/Q36b9/Awbfe+6E/lQcJP3+5mumAn8E8SE4c
 NEAgpuaHoXzH2bBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39t9Cv16AimeidENCBivcEBi5CMLaC52094MjW94ySo=;
 b=eLaSyKHAZd5ddzcv9WoaiQZuRpCRFTcgdQiw73xtRJ1AVjh/qqSNUlDst0acZDMuz5TGUX
 9Xyud3lWBfW39MR4EEFbpHjRcbX6sGD38xqOaj5W9K0zPRWTuW85UwwSSo8w8f7ZSpK+sG
 gSXOYS/Eo3uQMuyyCq4QAjkJ7+i+lMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39t9Cv16AimeidENCBivcEBi5CMLaC52094MjW94ySo=;
 b=qK4lqKQ5d8GQW/zEUlb5qhkZx4WRVhxpLq/Q36b9/Awbfe+6E/lQcJP3+5mumAn8E8SE4c
 NEAgpuaHoXzH2bBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 331D01398D;
 Mon, 26 Aug 2024 19:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPaHOj/dzGY5PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 19:53:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 06/18] migration/multifd: Make MultiFDPages_t:offset a
 flexible array member
Date: Mon, 26 Aug 2024 16:53:10 -0300
Message-Id: <20240826195322.16532-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240826195322.16532-1-farosas@suse.de>
References: <20240826195322.16532-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

We're about to use MultiFDPages_t from inside the MultiFDSendData
payload union, which means we cannot have pointers to allocated data
inside the pages structure, otherwise we'd lose the reference to that
memory once another payload type touches the union. Move the offset
array into the end of the structure and turn it into a flexible array
member, so it is allocated along with the rest of MultiFDSendData in
the next patches.

Note that other pointers, such as the ramblock pointer are still fine
as long as the storage for them is not owned by the migration code and
can be correctly released at some point.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 19 ++++++++++++-------
 migration/multifd.h |  4 ++--
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 640e4450ff..717e71f539 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -98,6 +98,17 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+static size_t multifd_ram_payload_size(void)
+{
+    uint32_t n = multifd_ram_page_count();
+
+    /*
+     * We keep an array of page offsets at the end of MultiFDPages_t,
+     * add space for it in the allocation.
+     */
+    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
+}
+
 static bool multifd_use_packets(void)
 {
     return !migrate_mapped_ram();
@@ -394,18 +405,12 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
 
 static MultiFDPages_t *multifd_pages_init(uint32_t n)
 {
-    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
-
-    pages->offset = g_new0(ram_addr_t, n);
-
-    return pages;
+    return g_malloc0(multifd_ram_payload_size());
 }
 
 static void multifd_pages_clear(MultiFDPages_t *pages)
 {
     multifd_pages_reset(pages);
-    g_free(pages->offset);
-    pages->offset = NULL;
     g_free(pages);
 }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 7bb4a2cbc4..a7fdd97f70 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -77,9 +77,9 @@ typedef struct {
     uint32_t num;
     /* number of normal pages */
     uint32_t normal_num;
+    RAMBlock *block;
     /* offset of each page */
-    ram_addr_t *offset;
-    RAMBlock *block;
+    ram_addr_t offset[];
 } MultiFDPages_t;
 
 struct MultiFDRecvData {
-- 
2.35.3


