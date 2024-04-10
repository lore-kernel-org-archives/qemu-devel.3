Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270D8CD129A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNE-00030j-2v; Wed, 10 Apr 2024 03:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMQ-0001Rl-8g; Wed, 10 Apr 2024 03:27:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMO-0004go-FR; Wed, 10 Apr 2024 03:27:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 977925D69B;
 Wed, 10 Apr 2024 10:25:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2F8EBB02DB;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191777 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 43/87] target/hppa: Fix assemble_12a insns for wide mode
Date: Wed, 10 Apr 2024 10:22:16 +0300
Message-Id: <20240410072303.4191455-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Tested-by: Helge Deller <deller@gmx.de>
Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 46174e140d274385b1255bc7f16a5a711853053f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9c6f92444c..5412ff9836 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -26,7 +26,7 @@
 
 %assemble_11a   4:12 0:1             !function=expand_11a
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
-%assemble_12a   0:s1 3:11            !function=expand_shl2
+%assemble_12a   3:13 0:1             !function=expand_12a
 %assemble_16    0:16                 !function=expand_16
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
@@ -314,8 +314,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 @ldstim14m      ...... b:5 t:5 ................          \
                 &ldst sp=%assemble_sp disp=%assemble_16  \
                 x=0 scale=0 m=%neg_to_m
-@ldstim12m      ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
+@ldstim12m      ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_12a \
+                x=0 scale=0 m=%pos_to_m
 
 # LDB, LDH, LDW, LDWM
 ld              010000 ..... ..... .. ..............    @ldstim14  size=0
@@ -331,15 +332,19 @@ st              011010 ..... ..... .. ..............    @ldstim14  size=2
 st              011011 ..... ..... .. ..............    @ldstim14m size=2
 st              011111 ..... ..... .. ...........10.    @ldstim12m size=2
 
-fldw            010110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fldw            010111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
-
-fstw            011110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fstw            011111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+fldw            010110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fldw            010111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
+
+fstw            011110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fstw            011111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
 
 ld              010100 ..... ..... .. ............0.    @ldstim11
 fldd            010100 ..... ..... .. ............1.    @ldstim11
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8c7a2fd331..23ff14c39b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -155,6 +155,23 @@ static int expand_11a(DisasContext *ctx, int val)
     return i;
 }
 
+/* Expander for assemble_16a(s,im11a,i). */
+static int expand_12a(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bit 0 and bits [3:15].
+     * Swizzle thing around depending on PSW.W.
+     */
+    int im11a = extract32(val, 1, 11);
+    int s = extract32(val, 12, 2);
+    int i = (-(val & 1) << 13) | (im11a << 2);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= s << 13;
+    }
+    return i;
+}
+
 /* Expander for assemble_16(s,im14). */
 static int expand_16(DisasContext *ctx, int val)
 {
-- 
2.39.2


