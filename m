Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64A4CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqgl-0006p6-U3; Tue, 12 May 2026 13:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgK-0006lw-8N
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgI-0000Wg-Lm
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778606046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nnQ+167Es5iiTjdWMQe264cnGv+oMNfn1MihRhaMM0=;
 b=IFjDKFSAliX8ImfQTdG0OjlnmGgga0Mm8v+Q3lwr0x7Mq+TH0vrZaIrb29K/ownz6kXWSS
 QG+fIJv1NfAs6VS3fmmtFB2NTWpOa/+Lrk5MKJe7UxMbKRplS5arpFScCgiVosN51L8nj/
 YY/nvwCtAeVFkI/1mrwPDnkl0Bu/znE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206--ugWvLIzOJCtJchfoYN8rg-1; Tue,
 12 May 2026 13:14:02 -0400
X-MC-Unique: -ugWvLIzOJCtJchfoYN8rg-1
X-Mimecast-MFC-AGG-ID: -ugWvLIzOJCtJchfoYN8rg_1778606041
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB92F18002DC; Tue, 12 May 2026 17:14:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2BB01955D84; Tue, 12 May 2026 17:13:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/9] hw/misc/aspeed_sbc: Add bounds checking for OTP write
 operations
Date: Tue, 12 May 2026 19:13:46 +0200
Message-ID: <20260512171354.4183887-2-clg@redhat.com>
In-Reply-To: <20260512171354.4183887-1-clg@redhat.com>
References: <20260512171354.4183887-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is a mismatch between the Aspeed OTP model and the Aspeed SBC
model in how the guest-provided address is handled.
aspeed_sbc_otp_prog() passes a word-indexed address directly
to address_space_write() without converting it to a byte offset,
whereas aspeed_otp_write() expects a byte offset and applies an
additional shift (otp_addr << 2). This double-shift confusion means
that an out-of-range word address can lead to a write beyond the
allocated storage.

Fix this by adding bounds checking on the word offset before
converting to byte offset and passing to address_space_write().
This matches the existing bounds check in aspeed_sbc_otp_read().

Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>
Cc: qemu-stable@nongnu.org
Fixes: 1a00754ccf15 ("hw/misc: Add Aspeed Secure Boot Controller model")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3436
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260428055254.76581-2-kane_chen@aspeedtech.com
[ clg: Kept otp_addr in event logged in aspeed_sbc_otp_prog() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sbc.c  | 12 ++++++++++--
 hw/nvram/aspeed_otp.c | 13 ++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 065e822e70d9..e5dab1c7bb7c 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -159,9 +159,17 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
     MemTxResult ret;
     AspeedOTPState *otp = &s->otp;
     uint32_t value = s->regs[R_CAMP1];
+    uint32_t otp_offset = otp_addr << 2;
 
-    ret = address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFIED,
-                        &value, sizeof(value));
+    if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid OTP addr 0x%x\n",
+                      otp_addr);
+        return false;
+    }
+
+    ret = address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
+                              &value, sizeof(value));
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Failed to write OTP memory, addr = %x\n",
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
index a60289000c37..1a9d3841b8d6 100644
--- a/hw/nvram/aspeed_otp.c
+++ b/hw/nvram/aspeed_otp.c
@@ -57,12 +57,12 @@ static bool valid_program_data(uint32_t otp_addr,
     return has_programmable_bits != 0;
 }
 
-static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
+static bool program_otpmem_data(void *opaque, hwaddr otp_offset,
                              uint32_t prog_bit, uint32_t *value)
 {
     AspeedOTPState *s = opaque;
+    uint32_t otp_addr = otp_offset >> 2;
     bool is_odd = otp_addr & 1;
-    uint32_t otp_offset = otp_addr << 2;
 
     memcpy(value, s->storage + otp_offset, sizeof(uint32_t));
 
@@ -79,26 +79,25 @@ static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
     return true;
 }
 
-static void aspeed_otp_write(void *opaque, hwaddr otp_addr,
+static void aspeed_otp_write(void *opaque, hwaddr otp_offset,
                                 uint64_t val, unsigned size)
 {
     AspeedOTPState *s = opaque;
-    uint32_t otp_offset, value;
+    uint32_t value;
 
-    if (!program_otpmem_data(s, otp_addr, val, &value)) {
+    if (!program_otpmem_data(s, otp_offset, val, &value)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Failed to program data, value = %x, bit = %"PRIx64"\n",
                       __func__, value, val);
         return;
     }
 
-    otp_offset = otp_addr << 2;
     memcpy(s->storage + otp_offset, &value, size);
 
     if (s->blk) {
         if (blk_pwrite(s->blk, otp_offset, size, &value, 0) < 0) {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: Failed to write %x to %x\n",
+                          "%s: Failed to write %x to %"HWADDR_PRIx"\n",
                           __func__, value, otp_offset);
 
             return;
-- 
2.54.0


