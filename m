Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C12FC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPR-00067c-33; Tue, 11 Aug 2026 12:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOo-0005NN-6X
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOm-000115-E5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFX32VsFrQj1DVHS5LiWf7EmdNCU8YdGzEwTm9Ip2qY=;
 b=DsmOlo/eAEc6bwUMDcKdH0RgnCDEu7RraEX7GLzxNX1oabcVjLLrpLMNVHdLONyOXajZrj
 J1Rft25o4F6iM8GwAsqtcF9Uq8ivlaZW7nuv5Qd8EXhwkBtlfIBuymyJVXMPZ67beTyj55
 HqR5fGQxbed9nM6ECdQwpJeHn1wh4o8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-jwevBUoVNlWat8Z2WsCyDQ-1; Tue,
 11 Aug 2026 12:32:13 -0400
X-MC-Unique: jwevBUoVNlWat8Z2WsCyDQ-1
X-Mimecast-MFC-AGG-ID: jwevBUoVNlWat8Z2WsCyDQ_1786465932
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 924BA1800644; Tue, 11 Aug 2026 16:32:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE9EC195DF91; Tue, 11 Aug 2026 16:32:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 70/83] hw/misc/aspeed_hace: Support scatter-gather mode for the
 crypto command
Date: Tue, 11 Aug 2026 18:29:25 +0200
Message-ID: <20260811162938.1403216-71-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST2600 and later crypto engines drive the source and destination
through scatter-gather lists (HACE10[18]/[19]) rather than the single
contiguous buffers used by the AST2500 direct access mode. Each SG list
entry is a length word (SG_LIST_LEN_LAST marks the final entry) followed
by a DRAM address, matching the hash engine layout.

Add a crypt_prepare_sg() helper that gathers the source into / scatters
the destination out of the bounce buffer by walking the SG list, and
select it or the existing crypt_prepare_direct() from do_crypt_operation
based on HACE10[18], mirroring the hash engine's direct/scatter-gather
dispatch.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 70 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 0f35d74137b1..646ff504762d 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -608,13 +608,58 @@ static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,
 }
 
 /*
- * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the source
- * and destination are single contiguous buffers (HACE00/HACE04) and the IV/key
- * come from the context buffer (HACE08). For CBC the resulting chaining IV is
- * written back to the context buffer so the driver can continue the chain.
+ * Scatter-gather mode: the source/destination register points at an SG list
+ * whose entries are a length word (SG_LIST_LEN_LAST flags the final entry)
+ * followed by a DRAM address, matching the hash engine layout. Gather @len
+ * bytes into @buf, or scatter @buf back out when @to_dram is true.
+ * Returns true on success.
+ */
+static bool crypt_prepare_sg(AspeedHACEState *s, uint64_t addr,
+                             uint8_t *buf, uint32_t len, bool to_dram)
+{
+    uint32_t copied = 0;
+    uint32_t sg_addr;
+    uint32_t sg_len;
+    uint32_t entry;
+    int i;
+
+    for (i = 0; i < ASPEED_HACE_MAX_SG && copied < len; i++) {
+        entry = address_space_ldl_le(&s->dram_as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
+        sg_addr = address_space_ldl_le(&s->dram_as, addr + SG_LIST_LEN_SIZE,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
+        sg_len = entry & SG_LIST_LEN_MASK;
+
+        sg_addr &= SG_LIST_ADDR_MASK;
+        addr += SG_LIST_ENTRY_SIZE;
+
+        if (sg_len > len - copied) {
+            sg_len = len - copied;
+        }
+        if (address_space_rw(&s->dram_as, sg_addr, MEMTXATTRS_UNSPECIFIED,
+                             buf + copied, sg_len, to_dram)) {
+            return false;
+        }
+        copied += sg_len;
+
+        if (entry & SG_LIST_LEN_LAST) {
+            break;
+        }
+    }
+
+    return copied == len;
+}
+
+/*
+ * Perform an AES/DES/3DES ECB/CBC operation. The source and destination are
+ * either single contiguous buffers (direct access mode) or scatter-gather
+ * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come from
+ * the context buffer (HACE08). For CBC the resulting chaining IV is written
+ * back to the context buffer so the driver can continue the chain.
  */
 static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
 {
+    bool sg_mode = cmd & CRYPT_CMD_SRC_SG_CTRL;
     uint32_t len = s->regs[R_CRYPT_DATA_LEN];
     bool encrypt = cmd & CRYPT_CMD_ENCRYPT;
     g_autoptr(QCryptoCipher) cipher = NULL;
@@ -631,6 +676,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     size_t iv_offset;
     size_t blocklen;
     size_t keylen;
+    bool status;
 
     if (len == 0) {
         return;
@@ -684,8 +730,14 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     src_buf = g_malloc0(len);
     dst_buf = g_malloc0(len);
 
+    /* Gather the source into the bounce buffer, per the selected mode. */
     src_addr = s->regs[R_CRYPT_SRC];
-    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {
+    if (sg_mode) {
+        status = crypt_prepare_sg(s, src_addr, src_buf, len, false);
+    } else {
+        status = crypt_prepare_direct(s, src_addr, src_buf, len, false);
+    }
+    if (!status) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Failed to read src, addr=0x%" HWADDR_PRIx "\n",
                       __func__, src_addr);
@@ -714,8 +766,14 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
         }
     }
 
+    /* Scatter the result back out, per the selected mode. */
     dst_addr = s->regs[R_CRYPT_DEST];
-    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {
+    if (sg_mode) {
+        status = crypt_prepare_sg(s, dst_addr, dst_buf, len, true);
+    } else {
+        status = crypt_prepare_direct(s, dst_addr, dst_buf, len, true);
+    }
+    if (!status) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Failed to write dst, addr=0x%" HWADDR_PRIx "\n",
                       __func__, dst_addr);
-- 
2.55.0


