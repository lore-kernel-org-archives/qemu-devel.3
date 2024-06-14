Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C553C27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZC-00013J-TZ; Fri, 14 Jun 2024 13:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZB-00012L-Ik
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZ9-00043b-ME
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45401339FA;
 Fri, 14 Jun 2024 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjjpGXZWWLF+wOKcACa+P9jcUGJ2fsrBlh5BBqndgIU=;
 b=S5LRfDgCxf8p3BnvLphj/Uj5fsvKTqbWevXP+1h2c9CH4nluuUU9pMr2weUR/TMS8siSae
 j8b55IlxDeCRo4JTH1ZdOJOlGrV/vv+7ppgvzrEzHn0r/jWwEDMU7K3i++iiSxYEsKISnI
 61ElH3yuBGywNEjhm0lTGVnXDyG9Xns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjjpGXZWWLF+wOKcACa+P9jcUGJ2fsrBlh5BBqndgIU=;
 b=t7TuJaCme9GaFEMdneskIWBDenYJQC07dzKO+JJ1ZcoBqljGt+E7v8wAb1Z/3UgD2ZUHl2
 MYkQ4d/mYivWjCCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S5LRfDgC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t7TuJaCm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjjpGXZWWLF+wOKcACa+P9jcUGJ2fsrBlh5BBqndgIU=;
 b=S5LRfDgCxf8p3BnvLphj/Uj5fsvKTqbWevXP+1h2c9CH4nluuUU9pMr2weUR/TMS8siSae
 j8b55IlxDeCRo4JTH1ZdOJOlGrV/vv+7ppgvzrEzHn0r/jWwEDMU7K3i++iiSxYEsKISnI
 61ElH3yuBGywNEjhm0lTGVnXDyG9Xns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjjpGXZWWLF+wOKcACa+P9jcUGJ2fsrBlh5BBqndgIU=;
 b=t7TuJaCme9GaFEMdneskIWBDenYJQC07dzKO+JJ1ZcoBqljGt+E7v8wAb1Z/3UgD2ZUHl2
 MYkQ4d/mYivWjCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A466A13AB1;
 Fri, 14 Jun 2024 17:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0Me7Glh7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yuan Liu <yuan1.liu@intel.com>, Nanhai Zou <nanhai.zou@intel.com>
Subject: [PULL 06/18] migration/multifd: put IOV initialization into
 compression method
Date: Fri, 14 Jun 2024 14:17:50 -0300
Message-Id: <20240614171802.28451-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45401339FA
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,suse.de:dkim]
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

From: Yuan Liu <yuan1.liu@intel.com>

Different compression methods may require different numbers of IOVs.
Based on streaming compression of zlib and zstd, all pages will be
compressed to a data block, so two IOVs are needed for packet header
and compressed data block.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c |  7 +++++++
 migration/multifd-zstd.c |  8 +++++++-
 migration/multifd.c      | 22 ++++++++++++----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 737a9645d2..2ced69487e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -70,6 +70,10 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_zbuff;
     }
     p->compress_data = z;
+
+    /* Needs 2 IOVs, one for packet header and one for compressed data */
+    p->iov = g_new0(struct iovec, 2);
+
     return 0;
 
 err_free_zbuff:
@@ -101,6 +105,9 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
     z->buf = NULL;
     g_free(p->compress_data);
     p->compress_data = NULL;
+
+    g_free(p->iov);
+    p->iov = NULL;
 }
 
 /**
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 256858df0a..ca17b7e310 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -52,7 +52,6 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
-    p->compress_data = z;
     z->zcs = ZSTD_createCStream();
     if (!z->zcs) {
         g_free(z);
@@ -77,6 +76,10 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         error_setg(errp, "multifd %u: out of memory for zbuff", p->id);
         return -1;
     }
+    p->compress_data = z;
+
+    /* Needs 2 IOVs, one for packet header and one for compressed data */
+    p->iov = g_new0(struct iovec, 2);
     return 0;
 }
 
@@ -98,6 +101,9 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
     z->zbuff = NULL;
     g_free(p->compress_data);
     p->compress_data = NULL;
+
+    g_free(p->iov);
+    p->iov = NULL;
 }
 
 /**
diff --git a/migration/multifd.c b/migration/multifd.c
index f317bff077..d82885fdbb 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -137,6 +137,13 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
         p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
     }
 
+    if (multifd_use_packets()) {
+        /* We need one extra place for the packet header */
+        p->iov = g_new0(struct iovec, p->page_count + 1);
+    } else {
+        p->iov = g_new0(struct iovec, p->page_count);
+    }
+
     return 0;
 }
 
@@ -150,6 +157,8 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
  */
 static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
+    g_free(p->iov);
+    p->iov = NULL;
     return;
 }
 
@@ -228,6 +237,7 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    p->iov = g_new0(struct iovec, p->page_count);
     return 0;
 }
 
@@ -240,6 +250,8 @@ static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
  */
 static void nocomp_recv_cleanup(MultiFDRecvParams *p)
 {
+    g_free(p->iov);
+    p->iov = NULL;
 }
 
 /**
@@ -783,8 +795,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
-    g_free(p->iov);
-    p->iov = NULL;
     multifd_send_state->ops->send_cleanup(p, errp);
 
     return *errp == NULL;
@@ -1179,11 +1189,6 @@ bool multifd_send_setup(void)
             p->packet = g_malloc0(p->packet_len);
             p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
             p->packet->version = cpu_to_be32(MULTIFD_VERSION);
-
-            /* We need one extra place for the packet header */
-            p->iov = g_new0(struct iovec, page_count + 1);
-        } else {
-            p->iov = g_new0(struct iovec, page_count);
         }
         p->name = g_strdup_printf("multifdsend_%d", i);
         p->page_size = qemu_target_page_size();
@@ -1353,8 +1358,6 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
-    g_free(p->iov);
-    p->iov = NULL;
     g_free(p->normal);
     p->normal = NULL;
     g_free(p->zero);
@@ -1602,7 +1605,6 @@ int multifd_recv_setup(Error **errp)
             p->packet = g_malloc0(p->packet_len);
         }
         p->name = g_strdup_printf("multifdrecv_%d", i);
-        p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
         p->zero = g_new0(ram_addr_t, page_count);
         p->page_count = page_count;
-- 
2.35.3


