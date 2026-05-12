Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D9CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqhk-0007fc-SH; Tue, 12 May 2026 13:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgb-0006ne-9n
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgS-0000td-4n
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778606052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmYeEfhR+gNeyUlbslHqcOhionCHuWh/odLQyvFxQhk=;
 b=ZR/ZEMrSvBOn+chnPeaydM1kiFOyNmlz2U4VmU9N5ErHybE35gSYCXnNnXE3sZl7VLccnR
 8pQmMp2V7iICnzoLDH6qQjCIiN6PI8fKkWhM1d0Lv3wpAh62ZpyDLGGt5zn4pO9nwmFxM8
 HBfRkrIBm5/ZANUKqgXyGy36BwUC7vM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-KxzuKOpyO8-8h3tPkRtxWg-1; Tue,
 12 May 2026 13:14:09 -0400
X-MC-Unique: KxzuKOpyO8-8h3tPkRtxWg-1
X-Mimecast-MFC-AGG-ID: KxzuKOpyO8-8h3tPkRtxWg_1778606048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E07B180061E; Tue, 12 May 2026 17:14:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B10B1953947; Tue, 12 May 2026 17:14:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/9] aspeed/hace: Fix mapped address may not be unmapped issue
Date: Tue, 12 May 2026 19:13:49 +0200
Message-ID: <20260512171354.4183887-5-clg@redhat.com>
In-Reply-To: <20260512171354.4183887-1-clg@redhat.com>
References: <20260512171354.4183887-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane Chen <kane_chen@aspeedtech.com>

In the do_hash_operation, the code may be returned earlier because
hash_prepare_sg_iov or hash_prepare_direct_iov may return a failure.
When this condition is happened, current code flow doesn't go through
later code segments. Finally, it causes the mapped address isn't
unmapped properly.

This change unmaps any mapped addresses when an error occurs,
preventing a resource leak.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260512065002.1516704-2-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 63 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 0504d61cbf0a..a322905cb37b 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -218,8 +218,19 @@ static bool hash_accumulate_len(AspeedHACEState *s, hwaddr plen)
     return true;
 }
 
+static void hash_iov_unmap(AspeedHACEState *s, struct iovec *iov,
+                           hwaddr *mapped_lens, int iov_count)
+{
+    for (; iov_count > 0; iov_count--) {
+        address_space_unmap(&s->dram_as, iov[iov_count - 1].iov_base,
+                            mapped_lens[iov_count - 1], false,
+                            mapped_lens[iov_count - 1]);
+    }
+}
+
 static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
-                                   bool acc_mode, bool *acc_final_request)
+                                   bool acc_mode, bool *acc_final_request,
+                                   hwaddr *mapped_lens)
 {
     uint32_t total_msg_len;
     uint32_t pad_offset;
@@ -243,9 +254,11 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
 
     iov[0].iov_base = haddr;
     iov_idx = 1;
+    mapped_lens[0] = plen;
 
     if (acc_mode) {
         if (!hash_accumulate_len(s, plen)) {
+            hash_iov_unmap(s, iov, mapped_lens, 1);
             return -1;
         }
 
@@ -265,7 +278,8 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
 }
 
 static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
-                               bool acc_mode, bool *acc_final_request)
+                               bool acc_mode, bool *acc_final_request,
+                               hwaddr *mapped_lens)
 {
     uint32_t total_msg_len;
     uint32_t pad_offset;
@@ -275,6 +289,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
     int iov_idx;
     hwaddr plen;
     void *haddr;
+    int iov_mapped = 0;
 
     src = hash_get_source_addr(s);
     for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
@@ -282,7 +297,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Failed to set end of sg list marker\n",
                           __func__);
-            return -1;
+            goto fail;
         }
 
         len = address_space_ldl_le(&s->dram_as, src,
@@ -307,15 +322,17 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
                           "%s: Unable to map address, sg_addr=0x%x, "
                           "plen=0x%" HWADDR_PRIx "\n",
                           __func__, sg_addr, plen);
-            return -1;
+            goto fail;
         }
 
         src += SG_LIST_ENTRY_SIZE;
 
         iov[iov_idx].iov_base = haddr;
+        iov_mapped = iov_idx + 1;
+        mapped_lens[iov_idx] = plen;
         if (acc_mode) {
             if (!hash_accumulate_len(s, plen)) {
-                return -1;
+                goto fail;
             }
 
             if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,
@@ -332,6 +349,10 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
     }
 
     return iov_idx;
+
+fail:
+    hash_iov_unmap(s, iov, mapped_lens, iov_mapped);
+    return -1;
 }
 
 static uint64_t hash_get_digest_addr(AspeedHACEState *s)
@@ -350,6 +371,7 @@ static uint64_t hash_get_digest_addr(AspeedHACEState *s)
 static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
                                             struct iovec *iov,
                                             int iov_idx,
+                                            hwaddr *mapped_lens,
                                             uint8_t *digest_buf,
                                             size_t digest_len)
 {
@@ -369,15 +391,12 @@ static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
         hace_hexdump("digest", (char *)digest_buf, digest_len);
     }
 
-    for (; iov_idx > 0; iov_idx--) {
-        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,
-                            iov[iov_idx - 1].iov_len, false,
-                            iov[iov_idx - 1].iov_len);
-    }
+    hash_iov_unmap(s, iov, mapped_lens, iov_idx);
 }
 
 static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
-                                      struct iovec *iov, int iov_idx)
+                                      struct iovec *iov, int iov_idx,
+                                      hwaddr *mapped_lens)
 {
     g_autofree uint8_t *digest_buf = NULL;
     Error *local_err = NULL;
@@ -389,15 +408,17 @@ static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
                       "%s: qcrypto hash bytesv failed : %s",
                       __func__, error_get_pretty(local_err));
         error_free(local_err);
+        hash_iov_unmap(s, iov, mapped_lens, iov_idx);
         return;
     }
 
-    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,
+                                    digest_buf, digest_len);
 }
 
 static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
                                   struct iovec *iov, int iov_idx,
-                                  bool final_request)
+                                  bool final_request, hwaddr *mapped_lens)
 {
     g_autofree uint8_t *digest_buf = NULL;
     Error *local_err = NULL;
@@ -411,6 +432,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
             qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash new failed : %s",
                           __func__, error_get_pretty(local_err));
             error_free(local_err);
+            hash_iov_unmap(s, iov, mapped_lens, iov_idx);
             return;
         }
     }
@@ -419,6 +441,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash updatev failed : %s",
                       __func__, error_get_pretty(local_err));
         error_free(local_err);
+        hash_iov_unmap(s, iov, mapped_lens, iov_idx);
         return;
     }
 
@@ -438,22 +461,25 @@ static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
         s->total_req_len = 0;
     }
 
-    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,
+                                    digest_buf, digest_len);
 }
 
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
     QEMU_UNINITIALIZED struct iovec iov[ASPEED_HACE_MAX_SG];
+    hwaddr mapped_lens[ASPEED_HACE_MAX_SG] = { 0 };
     bool acc_final_request = false;
     int iov_idx = -1;
 
     /* Prepares the iov for hashing operations based on the selected mode */
     if (sg_mode) {
-        iov_idx = hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_request);
+        iov_idx = hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_request,
+                                      mapped_lens);
     } else {
         iov_idx = hash_prepare_direct_iov(s, iov, acc_mode,
-                                          &acc_final_request);
+                                          &acc_final_request, mapped_lens);
     }
 
     if (iov_idx <= 0) {
@@ -468,9 +494,10 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
 
     /* Executes the hash operation */
     if (acc_mode) {
-        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);
+        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request,
+                              mapped_lens);
     } else {
-        hash_execute_non_acc_mode(s, algo, iov, iov_idx);
+        hash_execute_non_acc_mode(s, algo, iov, iov_idx, mapped_lens);
     }
 }
 
-- 
2.54.0


