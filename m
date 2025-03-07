Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59AC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcFO-0000pW-73; Fri, 07 Mar 2025 13:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcFL-0000oV-Tw
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:31 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcFJ-0005MU-Sw
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:31 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2521D2118D;
 Fri,  7 Mar 2025 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrUs++PLGKZhWmWTEUi2shbFpx1DoqHEvexa17ejjMM=;
 b=1Nvp/vjVIBTWlmMooKH/z2SxDn8tjsG81X7F+JkJEDOZ2HMiTjCAWFLOiY0U2GzDKhs4qz
 JlFO4V59yXynXYXPgmXzYWN+2Trf5e8/BselY3Ifi4Kqvm22QYvw8sR6StHeAG8JRNLyxj
 VWWNtcYcU2X0n6jS9lxnmHpMkOO4ZNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrUs++PLGKZhWmWTEUi2shbFpx1DoqHEvexa17ejjMM=;
 b=xsFeeudMT4Yg/FcjmNMX+AwGV1rC4gyd5kOgkiYR99hvU3QMrxPmuu620Y9yhMFWPjtW56
 JfHPuGB5/KUBwACg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrUs++PLGKZhWmWTEUi2shbFpx1DoqHEvexa17ejjMM=;
 b=1Nvp/vjVIBTWlmMooKH/z2SxDn8tjsG81X7F+JkJEDOZ2HMiTjCAWFLOiY0U2GzDKhs4qz
 JlFO4V59yXynXYXPgmXzYWN+2Trf5e8/BselY3Ifi4Kqvm22QYvw8sR6StHeAG8JRNLyxj
 VWWNtcYcU2X0n6jS9lxnmHpMkOO4ZNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrUs++PLGKZhWmWTEUi2shbFpx1DoqHEvexa17ejjMM=;
 b=xsFeeudMT4Yg/FcjmNMX+AwGV1rC4gyd5kOgkiYR99hvU3QMrxPmuu620Y9yhMFWPjtW56
 JfHPuGB5/KUBwACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C353F13A53;
 Fri,  7 Mar 2025 18:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6BL/Huc3y2dNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 18:16:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 7/8] migration: Unfold control_save_page()
Date: Fri,  7 Mar 2025 15:15:50 -0300
Message-Id: <20250307181551.19887-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307181551.19887-1-farosas@suse.de>
References: <20250307181551.19887-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Li Zhijian <lizhijian@fujitsu.com>

control_save_page() is for RDMA only, unfold it to make the code more
clear.
In addition:
 - Similar to other branches style in ram_save_target_page(), involve RDMA
   only if the condition 'migrate_rdma()' is true.
 - Further simplify the code by removing the RAM_SAVE_CONTROL_NOT_SUPP.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-6-lizhijian@fujitsu.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c  | 34 +++++++---------------------------
 migration/rdma.c |  7 ++-----
 migration/rdma.h |  3 +--
 3 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f1..c363034c88 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1143,32 +1143,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     return len;
 }
 
-/*
- * @pages: the number of pages written by the control path,
- *        < 0 - error
- *        > 0 - number of pages written
- *
- * Return true if the pages has been saved, otherwise false is returned.
- */
-static bool control_save_page(PageSearchStatus *pss,
-                              ram_addr_t offset, int *pages)
-{
-    int ret;
-
-    ret = rdma_control_save_page(pss->pss_channel, pss->block->offset, offset,
-                                 TARGET_PAGE_SIZE);
-    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
-        return false;
-    }
-
-    if (ret == RAM_SAVE_CONTROL_DELAYED) {
-        *pages = 1;
-        return true;
-    }
-    *pages = ret;
-    return true;
-}
-
 /*
  * directly send the page to the stream
  *
@@ -1965,7 +1939,13 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
     int res;
 
     /* Hand over to RDMA first */
-    if (control_save_page(pss, offset, &res)) {
+    if (migrate_rdma()) {
+        res = rdma_control_save_page(pss->pss_channel, pss->block->offset,
+                                     offset, TARGET_PAGE_SIZE);
+
+        if (res == RAM_SAVE_CONTROL_DELAYED) {
+            res = 1;
+        }
         return res;
     }
 
diff --git a/migration/rdma.c b/migration/rdma.c
index e5b4ac599b..08eb924ffa 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3284,14 +3284,11 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma()) {
-        return RAM_SAVE_CONTROL_NOT_SUPP;
-    }
+    assert(migrate_rdma());
 
     int ret = qemu_rdma_save_page(f, block_offset, offset, size);
 
-    if (ret != RAM_SAVE_CONTROL_DELAYED &&
-        ret != RAM_SAVE_CONTROL_NOT_SUPP) {
+    if (ret != RAM_SAVE_CONTROL_DELAYED) {
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
diff --git a/migration/rdma.h b/migration/rdma.h
index f55f28bbed..8eeb0117b9 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -33,7 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-#define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
 #ifdef CONFIG_RDMA
@@ -56,7 +55,7 @@ static inline
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    return RAM_SAVE_CONTROL_NOT_SUPP;
+    g_assert_not_reached();
 }
 #endif
 #endif
-- 
2.35.3


