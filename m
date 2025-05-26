Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9A7C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSqX-0004oF-9s; Mon, 26 May 2025 04:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSqH-0004Pl-4B
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSqA-0002GF-DJ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748246744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFM3ac5ImFtUc6fx8a1PKAPoMcRah1NDak8tF9I7FxQ=;
 b=ImsD2tnYKl0gWZg5vjgap8CCDsseM8f66YhdUWRku/tNYzSkvfj/Lg7yF5wzhq/0H5D1zI
 KgG1S6h/lIv6yoM05ZG/sNw5ZqiVqv/48ZcEhFelYUgU1cVb/9IpAg+22sHio3js+BgiRO
 XZe1vUpqVIUl5lDJPtdb4w/CY2Pa3VY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-7dvZkHhTOv-3qSeZLSfcTQ-1; Mon,
 26 May 2025 04:05:40 -0400
X-MC-Unique: 7dvZkHhTOv-3qSeZLSfcTQ-1
X-Mimecast-MFC-AGG-ID: 7dvZkHhTOv-3qSeZLSfcTQ_1748246739
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 591BD1956062; Mon, 26 May 2025 08:05:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B31031800ECA; Mon, 26 May 2025 08:05:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/39] hw/misc/aspeed_hace: Extract direct mode hash buffer
 setup into helper function
Date: Mon, 26 May 2025 10:04:39 +0200
Message-ID: <20250526080512.1697528-7-clg@redhat.com>
In-Reply-To: <20250526080512.1697528-1-clg@redhat.com>
References: <20250526080512.1697528-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

To improve code readability and maintainability of do_hash_operation(), this
commit introduces a new helper function: hash_prepare_direct_iov().
This function encapsulates the logic for setting up the I/O vector (iov)
in direct mode (non-scatter-gather).

No functional changes are introduced.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250515081008.583578-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 1256926d2276..42c6f29f8262 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -142,6 +142,31 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
     return false;
 }
 
+static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov)
+{
+    uint32_t src;
+    void *haddr;
+    hwaddr plen;
+    int iov_idx;
+
+    plen = s->regs[R_HASH_SRC_LEN];
+    src = s->regs[R_HASH_SRC];
+    haddr = address_space_map(&s->dram_as, src, &plen, false,
+                              MEMTXATTRS_UNSPECIFIED);
+    if (haddr == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unable to map address, addr=0x%x, "
+                      "plen=0x%" HWADDR_PRIx "\n",
+                      __func__, src, plen);
+        return -1;
+    }
+
+    iov[0].iov_base = haddr;
+    iov[0].iov_len = plen;
+    iov_idx = 1;
+
+    return iov_idx;
+}
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
@@ -169,6 +194,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
         }
     }
 
+    /* Prepares the iov for hashing operations based on the selected mode */
     if (sg_mode) {
         for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
             if (iov_idx == ASPEED_HACE_MAX_SG) {
@@ -211,17 +237,13 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             }
         }
     } else {
-        plen = s->regs[R_HASH_SRC_LEN];
+        iov_idx = hash_prepare_direct_iov(s, iov);
+    }
 
-        haddr = address_space_map(&s->dram_as, s->regs[R_HASH_SRC],
-                                  &plen, false, MEMTXATTRS_UNSPECIFIED);
-        if (haddr == NULL) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
-            return;
-        }
-        iov[0].iov_base = haddr;
-        iov[0].iov_len = plen;
-        iov_idx = 1;
+    if (iov_idx <= 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to prepare iov\n", __func__);
+         return;
     }
 
     if (acc_mode) {
-- 
2.49.0


