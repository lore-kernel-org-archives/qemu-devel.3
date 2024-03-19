Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBFAC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrNz-0004Ww-0U; Wed, 20 Mar 2024 04:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNr-0004VY-1S
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:15 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNn-0005UI-Bm
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710923592; x=1742459592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6D6zFZg6n7LP7yFNxtj2KPov5L9k6CTzYGh4pC8iT8s=;
 b=bNgFWiOrc1SQOk+MKxv73FVoa7FE3K5wDZNtFNHTBjaEdvRLuU122vKr
 1ol5jsZW03YYpq/rdhjXVi4p5XE6HXZDj2PNEKLxmT5XOxN7OpdGrWgfP
 0fmxsK2QT5kdTzc8P7MKpBVOJ57RSP2rVfqIa1tNk7hNlz/972OVF8G/8
 fKkCQLg95suEVZMdpEAKV3UEAsDjxQUcDUyOKL3uvYGZrzIF/7d901YVz
 rO3G3y1CldOnIO89gVz76oSgAb7zc+wb487BtOAWCAM+MSqSW9qs+V8Ez
 fdkSybkJhUMKnayUfcz+S6cbyffFoJ8UvJoVAxHxmn8pDgeiXSrf4y4Em w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5952917"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5952917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 01:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="13986709"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa010.jf.intel.com with ESMTP; 20 Mar 2024 01:33:04 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v5 2/7] migration/multifd: put IOV initialization into
 compression method
Date: Wed, 20 Mar 2024 00:45:22 +0800
Message-Id: <20240319164527.1873891-3-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240319164527.1873891-1-yuan1.liu@intel.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.422, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 migration/multifd-zlib.c | 4 ++++
 migration/multifd-zstd.c | 6 +++++-
 migration/multifd.c      | 8 +++++---
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 99821cd4d5..8095ef8e28 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -70,6 +70,10 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_zbuff;
     }
     p->compress_data = z;
+
+    assert(p->iov == NULL);
+    /* For packet header and zlib streaming compression block */
+    p->iov = g_new0(struct iovec, 2);
     return 0;
 
 err_free_zbuff:
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 02112255ad..9c9217794e 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -52,7 +52,6 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
-    p->compress_data = z;
     z->zcs = ZSTD_createCStream();
     if (!z->zcs) {
         g_free(z);
@@ -77,6 +76,11 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         error_setg(errp, "multifd %u: out of memory for zbuff", p->id);
         return -1;
     }
+    p->compress_data = z;
+
+    assert(p->iov == NULL);
+    /* For packet header and zstd streaming compression block */
+    p->iov = g_new0(struct iovec, 2);
     return 0;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 0179422f6d..5155e02ae3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1181,9 +1181,11 @@ bool multifd_send_setup(void)
             p->packet = g_malloc0(p->packet_len);
             p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
             p->packet->version = cpu_to_be32(MULTIFD_VERSION);
-
-            /* We need one extra place for the packet header */
-            p->iov = g_new0(struct iovec, page_count + 1);
+            /* IOVs are initialized in send_setup of compression method */
+            if (!migrate_multifd_compression()) {
+                /* We need one extra place for the packet header */
+                p->iov = g_new0(struct iovec, page_count + 1);
+            }
         } else {
             p->iov = g_new0(struct iovec, page_count);
         }
-- 
2.39.3


