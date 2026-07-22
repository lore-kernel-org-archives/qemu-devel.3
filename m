Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A2BC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLv-0002Rh-BB; Wed, 22 Jul 2026 08:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLm-0002Qz-St; Wed, 22 Jul 2026 08:47:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLl-0001d2-1L; Wed, 22 Jul 2026 08:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=5JVO+pPSjSrvdlJiOQfVav6GX/cDOleDJ4yBYo3AJ80=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZEwvuDBvGNhms19txeEYWaCEj+wGZK31iPvRsxcLi5iL8zkFpTyuM0JsLmlEDdMDq
 bo3NADZg7l9WsMLAVDhk5ZIkNajD5Zn6wqlWw462qLxrXtDx7H0LeLasIgbsNFIUkV
 3ZOMKcDM41JzIfDGkUyg3fS5r/k3nWN/Jd92TvLwvhKyqV5HkjIPiYm8nf1Jcs7WyR
 TctHvYSL8YDy1SczyAAvypqbTc5TZRBaxX5fj1O2w9OJicPSxC9mzUiT2nadRqDMsK
 5YDXrefgd7EondqOV/oXDDDWYSP/QRZJ2OoEsqaeq/R+2zJ6hq8AVwrSlEdA5ORypP
 /zfMmTJqHyiBw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5617F1C3AFC;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9CB183F3756;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 482C017EE1; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 083/122] hw/display/sm501: Don't allow guest to
 set ram size larger than it is
Date: Wed, 22 Jul 2026 15:45:32 +0300
Message-ID: <20260722124622.31034-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

The SM501 DRAM_CONTROL register has a 7 bit Size field which allows
the guest to change the local memory size.  We use the local memory
size in bounds checks calculations for 2D operations. Currently we
have no check on the validity of the value the guest programs to
this field, which means that the guest can:
 - set it to a reserved value (6 or 7) which will cause
   get_local_mem_size() to read outside sm501_mem_local_size[]
 - set it to a value corresponding to more RAM than the card
   was created with, so that the 2D bounds check will let 2D
   operations access off the end of the memory region

Fix this by decoupling the value the guest reads and writes to this
field from the internal size we consider the local memory to have.
We validate changes and ignore them except for readback if they would
be reserved values or values for more memory than the card has.

Cc: qemu-stable@nongnu.org
Reported-by: Heechan Kang
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260707150933.1410507-4-peter.maydell@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3811
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2ac2cf0483d090f2f2d795ed06a94cc865b972fe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index d451a1fe7d7..da22f8e75f5 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -570,6 +570,25 @@ static uint32_t get_local_mem_size_index(uint32_t size)
     return index;
 }
 
+static void set_new_local_mem_size_index(SM501State *s, uint32_t idx)
+{
+    /*
+     * Update local_mem_size_index on guest write. We don't allow this
+     * to be set to larger than the actual RAM size. (The guest will
+     * still read back the SYSTEM_CONTROL.Size bits that it wrote.)
+     */
+    if (idx < ARRAY_SIZE(sm501_mem_local_size) &&
+        sm501_mem_local_size[idx] <= memory_region_size(&s->local_mem_region)) {
+        s->local_mem_size_index = idx;
+        return;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "sm501: Guest set DRAM_CONTROL.Size to 0x%x but "
+                  "local memory is not that large\n",
+                  idx);
+    /* Don't change the effective size, leave it as whatever it was */
+}
+
 static ram_addr_t get_fb_addr(SM501State *s, int crt)
 {
     return (crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr) & 0x3FFFFF0;
@@ -989,7 +1008,7 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
         ret = 0x050100A0;
         break;
     case SM501_DRAM_CONTROL:
-        ret = (s->dram_control & 0x07F107C0) | s->local_mem_size_index << 13;
+        ret = (s->dram_control & 0x07F1E7C0);
         break;
     case SM501_ARBTRTN_CONTROL:
         ret = s->arbitration_control;
@@ -1048,8 +1067,7 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         s->gpio_63_32_control = value & 0xFF80FFFF;
         break;
     case SM501_DRAM_CONTROL:
-        s->local_mem_size_index = (value >> 13) & 0x7;
-        /* TODO : check validity of size change */
+        set_new_local_mem_size_index(s, (value >> 13) & 0x7);
         s->dram_control &= 0x80000000;
         s->dram_control |= value & 0x7FFFFFC3;
         break;
-- 
2.47.3


