Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32694C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU5h-0001Wc-Td; Tue, 04 Jun 2024 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5e-0001IE-Hd
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:38 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5c-0000Wu-6p
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717507237; x=1749043237;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XL3qUJ/s4JKxW1z/Q1moGl6f6RxBIByPE7Pu6LcLU94=;
 b=oI9c8JZz6RhouNSWOLip8ciyw9UUpmdByB7o0u+J1orcFv687ep6+CVh
 aIwG/he/Tbdie+eN9p0eB3NGzM3jTkcaBV7J7r4hegddkypjibTEeSSSc
 NMre3ZP1/NoFBDKsqz4IFutEC4b2DI3BcEYNq96guENvg7YGf3Tkq63Vu
 S5rh+KZ1q+SIjSH3gRrBFRidhRZ1MtI4T8MVC+BhiILqX57UjVGbRXdhh
 7Tc+ZTS6q8lsJuMud5N6k040DvkVUBl7+JEuAQ6XPb6IyDP6TDOImCOqj
 mkN+WNiTgZTyieEkCXng6ZUB7ve3NTieXTXS00yHQJzYGZ1OB821+nfIa Q==;
X-CSE-ConnectionGUID: llt3+7WkT3GD4crlWnxIPg==
X-CSE-MsgGUID: eoDW5JoQTzSPYlTWrLIYQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24628640"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24628640"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 06:20:35 -0700
X-CSE-ConnectionGUID: SNLlnWlYRpmKjdFVEObI0w==
X-CSE-MsgGUID: zmN9E6odTz+azEp7MIMQRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37246864"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2024 06:20:32 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v7 2/7] migration/multifd: put IOV initialization into
 compression method
Date: Mon,  3 Jun 2024 23:41:01 +0800
Message-ID: <20240603154106.764378-3-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603154106.764378-1-yuan1.liu@intel.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Different compression methods may require different numbers of IOVs.
Based on streaming compression of zlib and zstd, all pages will be
compressed to a data block, so two IOVs are needed for packet header
and compressed data block.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
2.43.0


