Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E14C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcFH-0000mp-5G; Fri, 07 Mar 2025 13:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcFF-0000mU-UK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:26 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcFE-0005EK-3M
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D02A21193;
 Fri,  7 Mar 2025 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/xtH07fdrTTFdSQHkFWSKdtEQrZw0frhISX/MFn0w=;
 b=q6dsjEo6ESekgob2IslR0Gr3XpJgsK3D4Mr0npC9Lrz6xfwzu8g/MaBKCo7Oc9svut3m5U
 CXks5wBKzJe/DEOsyGdYrb+kU5NvKmHo2jUOSmflsK3mds8dVjqbxkHihc3IEzyI9B1Tk4
 NdUZ88lqgOwh/oUUpvSd80D1PasE6wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/xtH07fdrTTFdSQHkFWSKdtEQrZw0frhISX/MFn0w=;
 b=2fQiqp8bWF85i9rJkccvfDIpue16U2AqkATpv4slhfcwplFrNqOATfQVQpRqCXavj7YuSS
 bszneV8eWG0AkRDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/xtH07fdrTTFdSQHkFWSKdtEQrZw0frhISX/MFn0w=;
 b=q6dsjEo6ESekgob2IslR0Gr3XpJgsK3D4Mr0npC9Lrz6xfwzu8g/MaBKCo7Oc9svut3m5U
 CXks5wBKzJe/DEOsyGdYrb+kU5NvKmHo2jUOSmflsK3mds8dVjqbxkHihc3IEzyI9B1Tk4
 NdUZ88lqgOwh/oUUpvSd80D1PasE6wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/xtH07fdrTTFdSQHkFWSKdtEQrZw0frhISX/MFn0w=;
 b=2fQiqp8bWF85i9rJkccvfDIpue16U2AqkATpv4slhfcwplFrNqOATfQVQpRqCXavj7YuSS
 bszneV8eWG0AkRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB65F13A22;
 Fri,  7 Mar 2025 18:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ODXbJeU3y2dNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 18:16:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 6/8] migration/rdma: Remove redundant migration_in_postcopy
 checks
Date: Fri,  7 Mar 2025 15:15:49 -0300
Message-Id: <20250307181551.19887-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307181551.19887-1-farosas@suse.de>
References: <20250307181551.19887-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
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

From: Li Zhijian <lizhijian@fujitsu.com>

Since we have disabled RDMA + postcopy, it's safe to remove
the migration_in_postcopy() that follows the migrate_rdma().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-5-lizhijian@fujitsu.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb034923..e5b4ac599b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3284,7 +3284,7 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return RAM_SAVE_CONTROL_NOT_SUPP;
     }
 
@@ -3829,7 +3829,7 @@ int rdma_block_notification_handle(QEMUFile *f, const char *name)
 
 int rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return 0;
     }
 
@@ -3861,7 +3861,7 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret;
 
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return 0;
     }
 
-- 
2.35.3


