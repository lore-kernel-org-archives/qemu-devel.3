Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4221CC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSqU-0004jE-Nu; Mon, 26 May 2025 04:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSqJ-0004SM-KR
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSqF-0002GR-Uo
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748246748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QQWubjuO94P3fUnntonpJ+ZNUJGgKRETQUw3K8QkCw=;
 b=fS//g0L1QI2MEV+wgO7bwW/4cVQ09PdW+Luz7n+eLZnXeVuZdT+cRoZkQID6EhMxlqgfrd
 tqUsdlNGUFCudennLleXItzgbAhev8cFWi7lBAhpK7zEQUkKmZ9FHAeZ/7t9g9K8owYn5k
 VCbcAk563Lcp7Hs1W17CcHhckRU7n/A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-cfyQjm3cMjCAtY8VkobRfQ-1; Mon,
 26 May 2025 04:05:43 -0400
X-MC-Unique: cfyQjm3cMjCAtY8VkobRfQ-1
X-Mimecast-MFC-AGG-ID: cfyQjm3cMjCAtY8VkobRfQ_1748246742
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98A861956052; Mon, 26 May 2025 08:05:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D70C11800ECA; Mon, 26 May 2025 08:05:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/39] hw/misc/aspeed_hace: Extract SG-mode hash buffer setup
 into helper function
Date: Mon, 26 May 2025 10:04:40 +0200
Message-ID: <20250526080512.1697528-8-clg@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
commit introduces a new helper function: hash_prepare_sg_iov().

This function handles scatter-gather (SG) mode setup, including SG list
parsing, address mapping, and optional accumulation mode support with
padding detection.

No functional changes are introduced.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250515081008.583578-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 111 ++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 42c6f29f8262..22eea62693c7 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -167,6 +167,67 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov)
 
     return iov_idx;
 }
+
+static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
+                               bool acc_mode, bool *acc_final_request)
+{
+    uint32_t total_msg_len;
+    uint32_t pad_offset;
+    uint32_t len = 0;
+    uint32_t sg_addr;
+    uint32_t src;
+    int iov_idx;
+    hwaddr plen;
+    void *haddr;
+
+    for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
+        if (iov_idx == ASPEED_HACE_MAX_SG) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Failed to set end of sg list marker\n",
+                          __func__);
+            return -1;
+        }
+
+        src = s->regs[R_HASH_SRC] + (iov_idx * SG_LIST_ENTRY_SIZE);
+
+        len = address_space_ldl_le(&s->dram_as, src,
+                                   MEMTXATTRS_UNSPECIFIED, NULL);
+        sg_addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+        sg_addr &= SG_LIST_ADDR_MASK;
+
+        plen = len & SG_LIST_LEN_MASK;
+        haddr = address_space_map(&s->dram_as, sg_addr, &plen, false,
+                                  MEMTXATTRS_UNSPECIFIED);
+
+        if (haddr == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Unable to map address, sg_addr=0x%x, "
+                          "plen=0x%" HWADDR_PRIx "\n",
+                          __func__, sg_addr, plen);
+            return -1;
+        }
+
+        iov[iov_idx].iov_base = haddr;
+        if (acc_mode) {
+            s->total_req_len += plen;
+
+            if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,
+                            &pad_offset)) {
+                /* Padding being present indicates the final request */
+                *acc_final_request = true;
+                iov[iov_idx].iov_len = pad_offset;
+            } else {
+                iov[iov_idx].iov_len = plen;
+            }
+        } else {
+            iov[iov_idx].iov_len = plen;
+        }
+    }
+
+    return iov_idx;
+}
+
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
@@ -174,15 +235,8 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
     struct iovec iov[ASPEED_HACE_MAX_SG];
     bool acc_final_request = false;
     Error *local_err = NULL;
-    uint32_t total_msg_len;
     size_t digest_len = 0;
-    uint32_t sg_addr = 0;
-    uint32_t pad_offset;
-    int iov_idx = 0;
-    uint32_t len = 0;
-    uint32_t src = 0;
-    void *haddr;
-    hwaddr plen;
+    int iov_idx = -1;
 
     if (acc_mode && s->hash_ctx == NULL) {
         s->hash_ctx = qcrypto_hash_new(algo, &local_err);
@@ -196,46 +250,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
 
     /* Prepares the iov for hashing operations based on the selected mode */
     if (sg_mode) {
-        for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
-            if (iov_idx == ASPEED_HACE_MAX_SG) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                        "aspeed_hace: guest failed to set end of sg list marker\n");
-                break;
-            }
-
-            src = s->regs[R_HASH_SRC] + (iov_idx * SG_LIST_ENTRY_SIZE);
-
-            len = address_space_ldl_le(&s->dram_as, src,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-
-            sg_addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-            sg_addr &= SG_LIST_ADDR_MASK;
-
-            plen = len & SG_LIST_LEN_MASK;
-            haddr = address_space_map(&s->dram_as, sg_addr, &plen, false,
-                                      MEMTXATTRS_UNSPECIFIED);
-            if (haddr == NULL) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "%s: qcrypto failed\n", __func__);
-                return;
-            }
-            iov[iov_idx].iov_base = haddr;
-            if (acc_mode) {
-                s->total_req_len += plen;
-
-                if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,
-                                &pad_offset)) {
-                    /* Padding being present indicates the final request */
-                    acc_final_request = true;
-                    iov[iov_idx].iov_len = pad_offset;
-                } else {
-                    iov[iov_idx].iov_len = plen;
-                }
-            } else {
-                iov[iov_idx].iov_len = plen;
-            }
-        }
+        iov_idx = hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_request);
     } else {
         iov_idx = hash_prepare_direct_iov(s, iov);
     }
-- 
2.49.0


