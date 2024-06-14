Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C98C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZd-0001FI-Rj; Fri, 14 Jun 2024 13:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZa-0001Bb-7o
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:46 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZW-00048m-Jh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 236FB228B2;
 Fri, 14 Jun 2024 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xtlv/iJp31EbgfFZ2ZGN/+gGwSneOADkPzuBXNQmve4=;
 b=rOZMCK/Z7LbLDFGBHCteAVndhSKVyzGZJqrvIoTT6W9ZSq81BpMWtS8d2OrnsHXUvZTmhm
 paVhe5k2aCRua1GP0IURuWsnMGwXbjUV5yN4KeqZmtMrgYYyfX905l7xwM0f2/q47YwkQZ
 z8xE51L9LcJcHBXVMEYLWOOCQJ8SHIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xtlv/iJp31EbgfFZ2ZGN/+gGwSneOADkPzuBXNQmve4=;
 b=mkwgXbW0qcJLHJUqnGMSBXcOAsXRy9miLVSot+FDDaM7DL/5CdhRr2dqVsn8v7wA9ohx3/
 OETf3KTiYtUK+AAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rOZMCK/Z";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mkwgXbW0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xtlv/iJp31EbgfFZ2ZGN/+gGwSneOADkPzuBXNQmve4=;
 b=rOZMCK/Z7LbLDFGBHCteAVndhSKVyzGZJqrvIoTT6W9ZSq81BpMWtS8d2OrnsHXUvZTmhm
 paVhe5k2aCRua1GP0IURuWsnMGwXbjUV5yN4KeqZmtMrgYYyfX905l7xwM0f2/q47YwkQZ
 z8xE51L9LcJcHBXVMEYLWOOCQJ8SHIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xtlv/iJp31EbgfFZ2ZGN/+gGwSneOADkPzuBXNQmve4=;
 b=mkwgXbW0qcJLHJUqnGMSBXcOAsXRy9miLVSot+FDDaM7DL/5CdhRr2dqVsn8v7wA9ohx3/
 OETf3KTiYtUK+AAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7695613AB1;
 Fri, 14 Jun 2024 17:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mDQkD297bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PULL 17/18] migration/multifd: Switch to no compression when no
 hardware support
Date: Fri, 14 Jun 2024 14:18:01 -0300
Message-Id: <20240614171802.28451-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 236FB228B2
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Send raw packets over if UADK hardware support is not available. This is to
satisfy  Qemu qtest CI which may run on platforms that don't have UADK
hardware support. Subsequent patch will add support for uadk migration
qtest.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-uadk.c | 92 +++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 70bba92eaa..d12353fb21 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -17,6 +17,7 @@
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
+#include "qemu/error-report.h"
 #include "uadk/wd_comp.h"
 #include "uadk/wd_sched.h"
 
@@ -48,29 +49,29 @@ static struct wd_data *multifd_uadk_init_sess(uint32_t count,
     uint32_t size = count * page_size;
     struct wd_data *wd;
 
-    if (!uadk_hw_init()) {
-        error_setg(errp, "multifd: UADK hardware not available");
-        return NULL;
-    }
-
     wd = g_new0(struct wd_data, 1);
-    ss.alg_type = WD_ZLIB;
-    if (compress) {
-        ss.op_type = WD_DIR_COMPRESS;
-        /* Add an additional page for handling output > input */
-        size += page_size;
+
+    if (uadk_hw_init()) {
+        ss.alg_type = WD_ZLIB;
+        if (compress) {
+            ss.op_type = WD_DIR_COMPRESS;
+            /* Add an additional page for handling output > input */
+            size += page_size;
+        } else {
+            ss.op_type = WD_DIR_DECOMPRESS;
+        }
+        /* We use default level 1 compression and 4K window size */
+        param.type = ss.op_type;
+        ss.sched_param = &param;
+
+        wd->handle = wd_comp_alloc_sess(&ss);
+        if (!wd->handle) {
+            error_setg(errp, "multifd: failed wd_comp_alloc_sess");
+            goto out;
+        }
     } else {
-        ss.op_type = WD_DIR_DECOMPRESS;
-    }
-
-    /* We use default level 1 compression and 4K window size */
-    param.type = ss.op_type;
-    ss.sched_param = &param;
-
-    wd->handle = wd_comp_alloc_sess(&ss);
-    if (!wd->handle) {
-        error_setg(errp, "multifd: failed wd_comp_alloc_sess");
-        goto out;
+        /* For CI test use */
+        warn_report_once("UADK hardware not available. Switch to no compression mode");
     }
 
     wd->buf = g_try_malloc(size);
@@ -82,7 +83,9 @@ static struct wd_data *multifd_uadk_init_sess(uint32_t count,
     return wd;
 
 out_free_sess:
-    wd_comp_free_sess(wd->handle);
+    if (wd->handle) {
+        wd_comp_free_sess(wd->handle);
+    }
 out:
     wd_comp_uninit2();
     g_free(wd);
@@ -91,7 +94,9 @@ out:
 
 static void multifd_uadk_uninit_sess(struct wd_data *wd)
 {
-    wd_comp_free_sess(wd->handle);
+    if (wd->handle) {
+        wd_comp_free_sess(wd->handle);
+    }
     wd_comp_uninit2();
     g_free(wd->buf);
     g_free(wd->buf_hdr);
@@ -188,23 +193,26 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
             .dst_len = p->page_size * 2,
         };
 
-        ret = wd_do_comp_sync(uadk_data->handle, &creq);
-        if (ret || creq.status) {
-            error_setg(errp, "multifd %u: failed compression, ret %d status %d",
-                       p->id, ret, creq.status);
-            return -1;
+        if (uadk_data->handle) {
+            ret = wd_do_comp_sync(uadk_data->handle, &creq);
+            if (ret || creq.status) {
+                error_setg(errp, "multifd %u: failed compression, ret %d status %d",
+                           p->id, ret, creq.status);
+                return -1;
+            }
+            if (creq.dst_len < p->page_size) {
+                uadk_data->buf_hdr[i] = cpu_to_be32(creq.dst_len);
+                prepare_next_iov(p, buf, creq.dst_len);
+                buf += creq.dst_len;
+            }
         }
-        if (creq.dst_len < p->page_size) {
-            uadk_data->buf_hdr[i] = cpu_to_be32(creq.dst_len);
-            prepare_next_iov(p, buf, creq.dst_len);
-            buf += creq.dst_len;
-        } else {
-            /*
-             * Send raw data if compressed out >= page_size. We might be better
-             * off sending raw data if output is slightly less than page_size
-             * as well because at the receive end we can skip the decompression.
-             * But it is tricky to find the right number here.
-             */
+        /*
+         * Send raw data if no UADK hardware or if compressed out >= page_size.
+         * We might be better off sending raw data if output is slightly less
+         * than page_size as well because at the receive end we can skip the
+         * decompression. But it is tricky to find the right number here.
+         */
+        if (!uadk_data->handle || creq.dst_len >= p->page_size) {
             uadk_data->buf_hdr[i] = cpu_to_be32(p->page_size);
             prepare_next_iov(p, p->pages->block->host + p->pages->offset[i],
                              p->page_size);
@@ -323,6 +331,12 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
             continue;
         }
 
+        if (unlikely(!uadk_data->handle)) {
+            error_setg(errp, "multifd %u: UADK HW not available for decompression",
+                       p->id);
+            return -1;
+        }
+
         ret = wd_do_comp_sync(uadk_data->handle, &creq);
         if (ret || creq.status) {
             error_setg(errp, "multifd %u: failed decompression, ret %d status %d",
-- 
2.35.3


