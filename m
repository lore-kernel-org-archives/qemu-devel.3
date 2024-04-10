Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9713ACD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNA-0002oA-LR; Wed, 10 Apr 2024 03:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSM3-0008Nk-1j; Wed, 10 Apr 2024 03:26:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSM1-0004gC-68; Wed, 10 Apr 2024 03:26:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A2265D699;
 Wed, 10 Apr 2024 10:25:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 025D6B02D9;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191771 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 41/87] target/hppa: Fix assemble_16 insns for wide mode
Date: Wed, 10 Apr 2024 10:22:14 +0300
Message-Id: <20240410072303.4191455-41-mjt@tls.msk.ru>
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

Reported-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 72bace2d13cb427fde3bb50ae1a71a2abe9acc0f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f5a3f02fd1..0d9f8159ec 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -27,13 +27,14 @@
 %assemble_11a   0:s1 4:10            !function=expand_shl3
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
 %assemble_12a   0:s1 3:11            !function=expand_shl2
+%assemble_16    0:16                 !function=expand_16
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
+%assemble_sp    14:2                 !function=sp0_if_wide
 
 %assemble_21    0:s1 1:11 14:2 16:5 12:2  !function=expand_shl11
 
 %lowsign_11     0:s1 1:10
-%lowsign_14     0:s1 1:13
 
 %sm_imm         16:10 !function=expand_sm_imm
 
@@ -221,7 +222,7 @@ sub_b_tsv       000010 ..... ..... .... 110100 . .....  @rrr_cf_d
 
 ldil            001000 t:5 .....................        i=%assemble_21
 addil           001010 r:5 .....................        i=%assemble_21
-ldo             001101 b:5 t:5 -- ..............        i=%lowsign_14
+ldo             001101 b:5 t:5  ................        i=%assemble_16
 
 addi            101101 ..... ..... .... 0 ...........   @rri_cf
 addi_tsv        101101 ..... ..... .... 1 ...........   @rri_cf
@@ -306,10 +307,12 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 
 @ldstim11       ...... b:5 t:5 sp:2 ..............      \
                 &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
-@ldstim14       ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%lowsign_14 x=0 scale=0 m=0
-@ldstim14m      ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%lowsign_14 x=0 scale=0 m=%neg_to_m
+@ldstim14       ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_16  \
+                x=0 scale=0 m=0
+@ldstim14m      ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_16  \
+                x=0 scale=0 m=%neg_to_m
 @ldstim12m      ...... b:5 t:5 sp:2 ..............      \
                 &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3ef39b1bd7..5d9f448acd 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -144,6 +144,28 @@ static int assemble_6(DisasContext *ctx, int val)
     return (val ^ 31) + 1;
 }
 
+/* Expander for assemble_16(s,im14). */
+static int expand_16(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bits [0:15], containing both im14 and s.
+     * Swizzle thing around depending on PSW.W.
+     */
+    int s = extract32(val, 14, 2);
+    int i = (-(val & 1) << 13) | extract32(val, 1, 13);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= s << 13;
+    }
+    return i;
+}
+
+/* The sp field is only present with !PSW_W. */
+static int sp0_if_wide(DisasContext *ctx, int sp)
+{
+    return ctx->tb_flags & PSW_W ? 0 : sp;
+}
+
 /* Translate CMPI doubleword conditions to standard. */
 static int cmpbid_c(DisasContext *ctx, int val)
 {
-- 
2.39.2


