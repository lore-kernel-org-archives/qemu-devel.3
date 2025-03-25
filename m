Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06409C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twy7r-0004h4-RV; Tue, 25 Mar 2025 02:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7p-0004f6-4w; Tue, 25 Mar 2025 02:51:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7m-0001fz-1E; Tue, 25 Mar 2025 02:51:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE37E107D66;
 Tue, 25 Mar 2025 09:49:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5104C1D5E75;
 Tue, 25 Mar 2025 09:50:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3CB0957032; Tue, 25 Mar 2025 09:50:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 34/34] hw/misc/aspeed_hace: Fix buffer overflow in
 has_padding function
Date: Tue, 25 Mar 2025 09:50:28 +0300
Message-Id: <20250325065031.3263718-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.17-20250325094839@cover.tls.msk.ru>
References: <qemu-stable-7.2.17-20250325094839@cover.tls.msk.ru>
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The maximum padding size is either 64 or 128 bytes and should always be smaller
than "req_len". If "padding_size" exceeds "req_len", then
"req_len - padding_size" underflows due to "uint32_t" data type, leading to a
large incorrect value (e.g., `0xFFXXXXXX`). This causes an out-of-bounds memory
access, potentially leading to a buffer overflow.

Added a check to ensure "padding_size" does not exceed "req_len" before
computing "pad_offset". This prevents "req_len - padding_size" from underflowing
and avoids accessing invalid memory.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Fixes: 5cd7d8564a8b563da724b9e6264c967f0a091afa ("aspeed/hace: Support AST2600 HACE ")
Link: https://lore.kernel.org/qemu-devel/20250321092623.2097234-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 78877b2e06464f49f777e086845e094ea7bc82ef)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 69175e972d..11bd25708e 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -123,6 +123,11 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
     if (*total_msg_len <= s->total_req_len) {
         uint32_t padding_size = s->total_req_len - *total_msg_len;
         uint8_t *padding = iov->iov_base;
+
+        if (padding_size > req_len) {
+            return false;
+        }
+
         *pad_offset = req_len - padding_size;
         if (padding[*pad_offset] == 0x80) {
             return true;
-- 
2.39.5


