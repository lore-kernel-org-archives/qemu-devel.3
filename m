Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98E606A880
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=TUPqA6DJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjF-0001UJ-Ds; Fri, 13 Nov 2026 08:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnnH-0001s7-Gg; Fri, 13 Nov 2026 04:42:03 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnnF-00021r-A2; Fri, 13 Nov 2026 04:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=nBfsD3VSLQ+mzXeB/5Dqbx0s+hX05xSMHL
 L7TQ/TiJo=; b=TUPqA6DJyZm1LYHFGo8pzqQ7TMMndDEZJWFnDyiJ4F5EDCyswp
 lXpRLb8SxZk0Cjj5OOPBhlqYS2Zm0zbsHppPmjZ+ZtCsUvn+ettNHRYJLIokZyQ8
 CHk8uydgo5O2zUs/5aCZi309dMSJcl3Jjc9JYnL7QYj4p/aUCUITnjwjE=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQDXRzhZ2_ZqWAhCAg--.45084S4;
 Fri, 13 Nov 2026 17:41:55 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me,
 kwolf@redhat.com, hreitz@redhat.com, clg@kaod.org,
 peter.maydell@linaro.org, jamin_lin@aspeedtech.com,
 kane_chen@aspeedtech.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, bin.meng@processmission.com,
 tangtao1634@phytium.com.cn, Chao Liu <chao.liu@processmission.com>,
 Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
Subject: [PATCH 3/4] hw/block/m25p80: fix block protection on erase
Date: Fri, 13 Nov 2026 17:41:42 +0800
Message-ID: <ad09e8bdaa9c4df82d2569aaaca2725de9333ffb.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQDXRzhZ2_ZqWAhCAg--.45084S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WF17XF4UCFy5uF1ftFyxZrb_yoW7WF4rpF
 97JF9Fqr42y3W7Xa97JFyjvw10y34ay3W7K347uw15WFZ5uw1UCFnIgry0qF1vyF9Iqr95
 AayDXFW5u3ZxXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
 c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GFWl
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREYhF7UUUUU==
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=w-yf22@mails.tsinghua.edu.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:52 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

The flash ignores erase commands that overlap a block-protected
region, including chip erase; otherwise protected data can be erased.

Fixes: 2113a128976f ("hw: m25p80: Add Block Protect and Top Bottom bits for write protect")
Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/block/m25p80.c              | 77 ++++++++++++++++++++++++----------
 tests/qtest/aspeed-smc-utils.c | 19 +++++++++
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index d0a8ecf1b8..15aba33bce 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -602,6 +602,52 @@ static inline void flash_sync_area(Flash *s, int64_t off, int64_t len)
     blk_aio_pwritev(s->blk, off, iov, 0, blk_sync_complete, iov);
 }
 
+static uint32_t flash_protected_sectors(const Flash *s)
+{
+    uint32_t block_protect_value = (s->block_protect3 << 3) |
+                                   (s->block_protect2 << 2) |
+                                   (s->block_protect1 << 1) |
+                                   (s->block_protect0 << 0);
+
+    if (!block_protect_value) {
+        return 0;
+    }
+
+    return MIN(1U << (block_protect_value - 1), s->pi->n_sectors);
+}
+
+static bool flash_sector_protected(const Flash *s, uint32_t sector)
+{
+    uint32_t num_protected = flash_protected_sectors(s);
+
+    if (!num_protected) {
+        return false;
+    }
+
+    if (!s->top_bottom_bit) {
+        return sector + num_protected >= s->pi->n_sectors;
+    }
+
+    return sector < num_protected;
+}
+
+static bool flash_erase_protected(const Flash *s, uint32_t offset, uint32_t len)
+{
+    uint32_t first_sector = offset / s->pi->sector_size;
+    uint64_t last = ((uint64_t)offset + len - 1) / s->pi->sector_size;
+    uint32_t num_protected = flash_protected_sectors(s);
+
+    if (!num_protected) {
+        return false;
+    }
+
+    if (!s->top_bottom_bit) {
+        return last >= s->pi->n_sectors - num_protected;
+    }
+
+    return first_sector < num_protected;
+}
+
 static void flash_erase(Flash *s, int offset, FlashCMD cmd)
 {
     uint32_t len;
@@ -663,6 +709,12 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
         qemu_log_mask(LOG_GUEST_ERROR, "M25P80: erase with write protect!\n");
         return;
     }
+
+    if (flash_erase_protected(s, offset, len)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "M25P80: erase with write protect!\n");
+        return;
+    }
+
     memset(s->storage + offset, 0xff, len);
     flash_sync_area(s, offset, len);
 }
@@ -680,34 +732,15 @@ void flash_write8(Flash *s, uint32_t addr, uint8_t data)
 {
     uint32_t page = addr / s->pi->page_size;
     uint8_t prev = s->storage[s->cur_addr];
-    uint32_t block_protect_value = (s->block_protect3 << 3) |
-                                   (s->block_protect2 << 2) |
-                                   (s->block_protect1 << 1) |
-                                   (s->block_protect0 << 0);
 
     if (!s->write_enable) {
         qemu_log_mask(LOG_GUEST_ERROR, "M25P80: write with write protect!\n");
         return;
     }
 
-    if (block_protect_value > 0) {
-        uint32_t num_protected_sectors = 1 << (block_protect_value - 1);
-        uint32_t sector = addr / s->pi->sector_size;
-
-        /* top_bottom_bit == 0 means TOP */
-        if (!s->top_bottom_bit) {
-            if (s->pi->n_sectors <= sector + num_protected_sectors) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "M25P80: write with write protect!\n");
-                return;
-            }
-        } else {
-            if (sector < num_protected_sectors) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "M25P80: write with write protect!\n");
-                return;
-            }
-        }
+    if (flash_sector_protected(s, addr / s->pi->sector_size)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "M25P80: write with write protect!\n");
+        return;
     }
 
     if ((prev ^ data) & data) {
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index 146332240d..ac54385958 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -173,6 +173,13 @@ static void flash_reset(const AspeedSMCTestData *data)
 {
     spi_conf(data, 1 << (CONF_ENABLE_W0 + data->cs));
 
+    /* Chip erase is ignored while any memory region is protected. */
+    spi_ctrl_start_user(data);
+    flash_writeb(data, 0, WREN);
+    flash_writeb(data, 0, WRSR);
+    flash_writeb(data, 0, 0);
+    spi_ctrl_stop_user(data);
+
     spi_ctrl_start_user(data);
     flash_writeb(data, 0, RESET_ENABLE);
     flash_writeb(data, 0, RESET_MEMORY);
@@ -595,6 +602,12 @@ void aspeed_smc_test_write_block_protect(const void *data)
     for (int i = 0; i < 16; i++) {
         bp_bits = ((i & 0b1000) << 3) | ((i & 0b0111) << 2);
 
+        spi_ctrl_start_user(test_data);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, WRSR);
+        flash_writeb(test_data, 0, 0);
+        spi_ctrl_stop_user(test_data);
+
         spi_ctrl_start_user(test_data);
         flash_writeb(test_data, 0, WREN);
         flash_writeb(test_data, 0, BULK_ERASE);
@@ -641,6 +654,12 @@ void aspeed_smc_test_write_block_protect_bottom_bit(const void *data)
     for (int i = 0; i < 16; i++) {
         bp_bits = (((i & 0b1000) | 0b0100) << 3) | ((i & 0b0111) << 2);
 
+        spi_ctrl_start_user(test_data);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, WRSR);
+        flash_writeb(test_data, 0, 0);
+        spi_ctrl_stop_user(test_data);
+
         spi_ctrl_start_user(test_data);
         flash_writeb(test_data, 0, WREN);
         flash_writeb(test_data, 0, BULK_ERASE);
-- 
2.53.0


