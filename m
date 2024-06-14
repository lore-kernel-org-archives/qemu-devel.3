Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C2FC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZa-0001Ba-2c; Fri, 14 Jun 2024 13:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZW-0001At-IM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZU-00048S-Ep
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CC39227EA;
 Fri, 14 Jun 2024 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiYfKzaoqYgWx2X7V35EUZ3Y/jAjSllIfrc0d1B/zZ0=;
 b=bTJEz1v6aNPt38+BmX06Emra1hagcg3M1pvmK4mE89nrhxAINRWS/wItxRxcgK5la+6pTN
 2yEgJU/1XcBUeYGzEbR/07sKaxqkPm8kZxmhJw25n60XN6tOVOu+spGjqBXskTLM8jCjPk
 p+pr42Gdh7gb0BI0c2ppEOsKbFtrlMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiYfKzaoqYgWx2X7V35EUZ3Y/jAjSllIfrc0d1B/zZ0=;
 b=OLYmx9lum2Alouxkiz1VJrXR/emxR4cyDSqWMFWRe0wkd6vD3kayI0lhHxgLhQFxdKTFBh
 5Iy6e3/ErQQ6XnAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bTJEz1v6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OLYmx9lu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiYfKzaoqYgWx2X7V35EUZ3Y/jAjSllIfrc0d1B/zZ0=;
 b=bTJEz1v6aNPt38+BmX06Emra1hagcg3M1pvmK4mE89nrhxAINRWS/wItxRxcgK5la+6pTN
 2yEgJU/1XcBUeYGzEbR/07sKaxqkPm8kZxmhJw25n60XN6tOVOu+spGjqBXskTLM8jCjPk
 p+pr42Gdh7gb0BI0c2ppEOsKbFtrlMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiYfKzaoqYgWx2X7V35EUZ3Y/jAjSllIfrc0d1B/zZ0=;
 b=OLYmx9lum2Alouxkiz1VJrXR/emxR4cyDSqWMFWRe0wkd6vD3kayI0lhHxgLhQFxdKTFBh
 5Iy6e3/ErQQ6XnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A14313AB1;
 Fri, 14 Jun 2024 17:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iEJCDG17bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PULL 16/18] migration/multifd: Add UADK based compression and
 decompression
Date: Fri, 14 Jun 2024 14:18:00 -0300
Message-Id: <20240614171802.28451-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CC39227EA
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Uses UADK wd_do_comp_sync() API to (de)compress a normal page using
hardware accelerator.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-uadk.c | 132 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 535411a405..70bba92eaa 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "exec/ramblock.h"
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
@@ -142,6 +143,15 @@ static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
     p->compress_data = NULL;
 }
 
+static inline void prepare_next_iov(MultiFDSendParams *p, void *base,
+                                    uint32_t len)
+{
+    p->iov[p->iovs_num].iov_base = (uint8_t *)base;
+    p->iov[p->iovs_num].iov_len = len;
+    p->next_packet_size += len;
+    p->iovs_num++;
+}
+
 /**
  * multifd_uadk_send_prepare: prepare data to be able to send
  *
@@ -155,7 +165,56 @@ static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    return -1;
+    struct wd_data *uadk_data = p->compress_data;
+    uint32_t hdr_size;
+    uint8_t *buf = uadk_data->buf;
+    int ret = 0;
+
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
+
+    hdr_size = p->pages->normal_num * sizeof(uint32_t);
+    /* prepare the header that stores the lengths of all compressed data */
+    prepare_next_iov(p, uadk_data->buf_hdr, hdr_size);
+
+    for (int i = 0; i < p->pages->normal_num; i++) {
+        struct wd_comp_req creq = {
+            .op_type = WD_DIR_COMPRESS,
+            .src     = p->pages->block->host + p->pages->offset[i],
+            .src_len = p->page_size,
+            .dst     = buf,
+            /* Set dst_len to double the src in case compressed out >= page_size */
+            .dst_len = p->page_size * 2,
+        };
+
+        ret = wd_do_comp_sync(uadk_data->handle, &creq);
+        if (ret || creq.status) {
+            error_setg(errp, "multifd %u: failed compression, ret %d status %d",
+                       p->id, ret, creq.status);
+            return -1;
+        }
+        if (creq.dst_len < p->page_size) {
+            uadk_data->buf_hdr[i] = cpu_to_be32(creq.dst_len);
+            prepare_next_iov(p, buf, creq.dst_len);
+            buf += creq.dst_len;
+        } else {
+            /*
+             * Send raw data if compressed out >= page_size. We might be better
+             * off sending raw data if output is slightly less than page_size
+             * as well because at the receive end we can skip the decompression.
+             * But it is tricky to find the right number here.
+             */
+            uadk_data->buf_hdr[i] = cpu_to_be32(p->page_size);
+            prepare_next_iov(p, p->pages->block->host + p->pages->offset[i],
+                             p->page_size);
+            buf += p->page_size;
+        }
+    }
+out:
+    p->flags |= MULTIFD_FLAG_UADK;
+    multifd_send_fill_packet(p);
+    return 0;
 }
 
 /**
@@ -208,7 +267,76 @@ static void multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
  */
 static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 {
-    return -1;
+    struct wd_data *uadk_data = p->compress_data;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    uint32_t hdr_len = p->normal_num * sizeof(uint32_t);
+    uint32_t data_len = 0;
+    uint8_t *buf = uadk_data->buf;
+    int ret = 0;
+
+    if (flags != MULTIFD_FLAG_UADK) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_ZLIB);
+        return -1;
+    }
+
+    multifd_recv_zero_page_process(p);
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
+    /* read compressed data lengths */
+    assert(hdr_len < in_size);
+    ret = qio_channel_read_all(p->c, (void *) uadk_data->buf_hdr,
+                               hdr_len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    for (int i = 0; i < p->normal_num; i++) {
+        uadk_data->buf_hdr[i] = be32_to_cpu(uadk_data->buf_hdr[i]);
+        data_len += uadk_data->buf_hdr[i];
+        assert(uadk_data->buf_hdr[i] <= p->page_size);
+    }
+
+    /* read compressed data */
+    assert(in_size == hdr_len + data_len);
+    ret = qio_channel_read_all(p->c, (void *)buf, data_len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    for (int i = 0; i < p->normal_num; i++) {
+        struct wd_comp_req creq = {
+            .op_type = WD_DIR_DECOMPRESS,
+            .src     = buf,
+            .src_len = uadk_data->buf_hdr[i],
+            .dst     = p->host + p->normal[i],
+            .dst_len = p->page_size,
+        };
+
+        if (uadk_data->buf_hdr[i] == p->page_size) {
+            memcpy(p->host + p->normal[i], buf, p->page_size);
+            buf += p->page_size;
+            continue;
+        }
+
+        ret = wd_do_comp_sync(uadk_data->handle, &creq);
+        if (ret || creq.status) {
+            error_setg(errp, "multifd %u: failed decompression, ret %d status %d",
+                       p->id, ret, creq.status);
+            return -1;
+        }
+        if (creq.dst_len != p->page_size) {
+            error_setg(errp, "multifd %u: decompressed length error", p->id);
+            return -1;
+        }
+        buf += uadk_data->buf_hdr[i];
+     }
+
+    return 0;
 }
 
 static MultiFDMethods multifd_uadk_ops = {
-- 
2.35.3


