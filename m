Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC14C3ABDE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBfm-0000hg-14; Wed, 14 May 2025 08:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfX-00007Q-EU; Wed, 14 May 2025 08:57:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfS-0007iK-Ph; Wed, 14 May 2025 08:57:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C944D121AC4;
 Wed, 14 May 2025 15:56:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 73C2220B83C;
 Wed, 14 May 2025 15:56:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 04/18] target/avr: Fix buffer read in avr_print_insn
Date: Wed, 14 May 2025 15:56:10 +0300
Message-Id: <20250514125640.91677-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
References: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not unconditionally attempt to read 4 bytes, as there
may only be 2 bytes remaining in the translator cache.

Cc: qemu-stable@nongnu.org
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250325224403.4011975-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 070a500cc0da70c1b4c62a6c95e41f0a1b19dc0b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/avr/disas.c b/target/avr/disas.c
index b7689e8d7c..d341030174 100644
--- a/target/avr/disas.c
+++ b/target/avr/disas.c
@@ -68,28 +68,35 @@ static bool decode_insn(DisasContext *ctx, uint16_t insn);
 
 int avr_print_insn(bfd_vma addr, disassemble_info *info)
 {
-    DisasContext ctx;
+    DisasContext ctx = { info };
     DisasContext *pctx = &ctx;
     bfd_byte buffer[4];
     uint16_t insn;
     int status;
 
-    ctx.info = info;
-
-    status = info->read_memory_func(addr, buffer, 4, info);
+    status = info->read_memory_func(addr, buffer, 2, info);
     if (status != 0) {
         info->memory_error_func(status, addr, info);
         return -1;
     }
     insn = bfd_getl16(buffer);
-    ctx.next_word = bfd_getl16(buffer + 2);
-    ctx.next_word_used = false;
+
+    status = info->read_memory_func(addr + 2, buffer + 2, 2, info);
+    if (status == 0) {
+        ctx.next_word = bfd_getl16(buffer + 2);
+    }
 
     if (!decode_insn(&ctx, insn)) {
         output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
     }
 
-    return ctx.next_word_used ? 4 : 2;
+    if (!ctx.next_word_used) {
+        return 2;
+    } else if (status == 0) {
+        return 4;
+    }
+    info->memory_error_func(status, addr + 2, info);
+    return -1;
 }
 
 
-- 
2.39.5


