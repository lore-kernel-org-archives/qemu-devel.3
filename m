Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F02AD5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kTo-0005cv-08; Sat, 09 Nov 2024 07:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRC-0002DB-Ua; Sat, 09 Nov 2024 07:19:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRB-0005Wk-1q; Sat, 09 Nov 2024 07:19:34 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88987A1657;
 Sat,  9 Nov 2024 15:08:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5086C167FDD;
 Sat,  9 Nov 2024 15:09:04 +0300 (MSK)
Received: (nullmailer pid 3296266 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 45/58] hw/ssi/pnv_spi: Return early in transfer()
Date: Sat,  9 Nov 2024 15:08:46 +0300
Message-Id: <20241109120901.3295995-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Return early to simplify next commit.
No logical change intended.

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 3feabc18ad4d4bdc178a205b986353a54dbfcf20)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 13a47f07e7..05e6afc11e 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -217,6 +217,9 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
     PnvXferBuffer *rsp_payload = NULL;
 
     rsp_payload = pnv_spi_xfer_buffer_new();
+    if (!rsp_payload) {
+        return;
+    }
     for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
         tx = 0;
         for (int i = 0; i < s->transfer_len; i++) {
@@ -235,9 +238,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
                     (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
         }
     }
-    if (rsp_payload != NULL) {
-        spi_response(s, s->N1_bits, rsp_payload);
-    }
+    spi_response(s, s->N1_bits, rsp_payload);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
-- 
2.39.5


