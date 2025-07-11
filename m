Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5E6C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua95v-0001pW-FG; Fri, 11 Jul 2025 04:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xc-0004ii-2Y; Fri, 11 Jul 2025 04:18:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xa-00042A-5p; Fri, 11 Jul 2025 04:18:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B84D31356D5;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AFC6E23FA4A;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 10/39] ui/vnc: fix tight palette pixel encoding for
 8/16-bpp formats
Date: Fri, 11 Jul 2025 11:16:06 +0300
Message-ID: <20250711081745.1785806-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When sending a tight rectangle with the palette filter, if the client
format was 8/16bpp, the colours on big endian hosts are not set as
we're sending the wrong bytes. We must first cast the 32-bit colour
to a 16/8-bit value, and then send the result.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 63d320909220a90647c484263ae5e2f26eb54587)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index a5bdc19ebb..25c7b2c788 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1001,16 +1001,24 @@ static int send_mono_rect(VncState *vs, int x, int y,
         break;
     }
     case 2:
-        vnc_write(vs, &bg, 2);
-        vnc_write(vs, &fg, 2);
+    {
+        uint16_t bg16 = bg;
+        uint16_t fg16 = fg;
+        vnc_write(vs, &bg16, 2);
+        vnc_write(vs, &fg16, 2);
         tight_encode_mono_rect16(vs->tight->tight.buffer, w, h, bg, fg);
         break;
+    }
     default:
-        vnc_write_u8(vs, bg);
-        vnc_write_u8(vs, fg);
+    {
+        uint8_t bg8 = bg;
+        uint8_t fg8 = fg;
+        vnc_write_u8(vs, bg8);
+        vnc_write_u8(vs, fg8);
         tight_encode_mono_rect8(vs->tight->tight.buffer, w, h, bg, fg);
         break;
     }
+    }
     vs->tight->tight.offset = bytes;
 
     bytes = tight_compress_data(vs, stream, bytes, level, Z_DEFAULT_STRATEGY);
-- 
2.47.2


