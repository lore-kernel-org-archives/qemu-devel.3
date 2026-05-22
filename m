Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A146CCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXmu-0003Zd-NH; Fri, 22 May 2026 17:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmW-0002oS-9g; Fri, 22 May 2026 17:51:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmN-00049G-DK; Fri, 22 May 2026 17:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486560; bh=ciabHIWCm6x1U3XoGnS5ewmf2ya228L/LGLe4l4K5CA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mEtRNQtZkRHNR6BGOg7WYfkRBBsVlLLHTFoNNw7SvRk8SiDaqXeCO4vfQsvpl8IQR
 Yp3jV5a0b0SyP4Z1EZsjnDLUbfae/ZAyLXzMHRCTgSOa+dWyZsVC5levDC5Ja7hxBk
 F9q/nzAOW/tSCc4+CK30Cim5BAdP7zBFl8ygqjUYLjCzmFYJvE3pUZz0vRpMrD7MQp
 aRUj9BHaaV2im7Fa2wZHQxiiY253WdU6vjsoHx5KxS6qE+56XMXeQQiPq+Uw1MZe4A
 FrCwfHYcw5U4p1C6JHGjxF2gU2rd39P4RqlDclgMy72ysq5u32RTwtvGAk1HWXfURw
 FfkvIiI1Izdcw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CCF241AFB74;
 Sat, 23 May 2026 00:49:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F361F3B71C3;
 Sat, 23 May 2026 00:49:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 126/149] hw/misc/aspeed_sbc: Add bounds checking for
 OTP write operations
Date: Sat, 23 May 2026 00:48:58 +0300
Message-ID: <20260522214923.807017-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit ff36712da5ae73aca5a044fe5e61c585d427013a)
(Mjt: actual Fixes: tag is this one)
Fixes: 9f58dd0a8c30 ("hw/misc/aspeed_sbc: Connect ASPEED OTP memory device to SBC")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 2fc5db749d..db92364fb8 100644
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
index dcf8ed3917..605e96139a 100644
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
2.47.3


