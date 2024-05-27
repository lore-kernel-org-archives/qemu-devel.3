Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92420C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVgu-0000UH-5P; Mon, 27 May 2024 04:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVf4-0005Jb-Dg; Mon, 27 May 2024 04:24:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVf1-0001A4-Ui; Mon, 27 May 2024 04:24:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 163F86A580;
 Mon, 27 May 2024 11:22:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 42BBCD851D;
 Mon, 27 May 2024 11:21:41 +0300 (MSK)
Received: (nullmailer pid 66458 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 35/44] hw/pflash: fix block write start
Date: Mon, 27 May 2024 11:21:26 +0300
Message-Id: <20240527082138.66217-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Move the pflash_blk_write_start() call.  We need the offset of the
first data write, not the offset for the setup (number-of-bytes)
write.  Without this fix u-boot can do block writes to the first
flash block only.

While being at it drop a leftover FIXME.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2343
Fixes: 284a7ee2e290 ("hw/pflash: implement update buffer for block writes")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240516121237.534875-1-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 2563be6317fa9b5e661d79581538c704ecb90a1a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 1bda8424b9..c8f1cf5a87 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -518,10 +518,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             break;
         case 0xe8: /* Write to buffer */
             trace_pflash_write(pfl->name, "write to buffer");
-            /* FIXME should save @offset, @width for case 1+ */
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: Write to buffer emulation is flawed\n",
-                          __func__);
             pfl->status |= 0x80; /* Ready! */
             break;
         case 0xf0: /* Probe for AMD flash */
@@ -574,7 +570,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             }
             pfl->counter = value;
             pfl->wcycle++;
-            pflash_blk_write_start(pfl, offset);
             break;
         case 0x60:
             if (cmd == 0xd0) {
@@ -605,6 +600,9 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             /* FIXME check @offset, @width */
+            if (pfl->blk_offset == -1 && pfl->counter) {
+                pflash_blk_write_start(pfl, offset);
+            }
             if (!pfl->ro && (pfl->blk_offset != -1)) {
                 pflash_data_write(pfl, offset, value, width, be);
             } else {
-- 
2.39.2


