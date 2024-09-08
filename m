Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2ACCD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 18:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snN0H-0006gU-4g; Sun, 08 Sep 2024 14:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snN0F-0006g1-Ru
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 14:51:15 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snN0E-00046M-4U
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 14:51:15 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718d985b6bbso1957316b3a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725821472; x=1726426272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l3PkiTPZdZV5iv60Yi1PrmXCPch8NjwfokpkeXBcdOw=;
 b=uZuZaRqRsTf9dfjHJNFgxxjBpfkXpZkg2dgt41YH1kKY7qsau14A96wB2Lfb5VtyCw
 2BiuO2IiFp/023ShwVmHx+6CQi4LhfWY73JlTrJzz7dJUOyX84QYrleoyiDRW/kzYbjZ
 Vu3/0PU1qsF2FtzNrR/U5K7uJEXVvkTHni2T1v3+xTbUlVBPeq/Y6ECn8+80qW8nawNw
 DZfds4GRgtrp87shawJPMfc6mB1lQBmLraxy9F2C4VomKOx6YSq/eIhQseKeqtCbc1hZ
 mXXVsrokHkO4alckmAMCx3tAT3erOGJ6tzUUl2jUjjct4WY8qOZGCUDYQOwljHCchsdD
 q6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725821472; x=1726426272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3PkiTPZdZV5iv60Yi1PrmXCPch8NjwfokpkeXBcdOw=;
 b=LxKTjuaNviaUGxEnz2kKea3R0ot+ulc55UDA8VHgWRQKZwdzLnK0qDfxvNlqdL4eRx
 c6aisXcvVm45X3Nn1MVia6q7P0e+1+SnJptwU3x3VMRdhJijK4XxL/ofzeE8DtIIMCM4
 ouYjvpj1TLh91H4ULkDhDAPp78EUcXJdBuMBz36XMX6fagdSi+StyazqO5KrrUNoSwel
 7R31+c8L+EwJbjzCSzLnuBKu+gCuf/h8ow3m4qJRXee/Ya20RjwQ8FJrY1g9TvJZLOxC
 uw4kFALiw/WCj5ZABJjV3MD303FbXTMp1aRKK24f7WqCMd0d5JOpVQTSLx0vcqxBXyk9
 wq+Q==
X-Gm-Message-State: AOJu0Yzqo1/8eoSJ7y10q39/8XasIb1RQHSYlGPUmH2DEqL38YmIp9PB
 X0+da0p3g6/MyD795VSVMnLix7bWs++LJticpeu7Xon1VXsai5mH3fmxBGHbxofVtjmKMgCXL0s
 T
X-Google-Smtp-Source: AGHT+IHhkVrN0bnmsM6aVgl8iIngJSS/KI+Ixuu9SiTYWDKj8c/jDZcxn+26DxhxZdCk1TkojrlulQ==
X-Received: by 2002:a05:6a21:1706:b0:1c6:ed5e:241 with SMTP id
 adf61e73a8af0-1cf1d0acadcmr8914395637.15.1725821472104; 
 Sun, 08 Sep 2024 11:51:12 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e5982ec5sm2299834b3a.169.2024.09.08.11.51.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 11:51:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/i386: Implement vector TST{EQ,NE} for avx512
Date: Sun,  8 Sep 2024 11:51:10 -0700
Message-ID: <20240908185110.485573-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Based-on: <20240908022632.459477-1-richard.henderson@linaro.org>
("tcg: Improve support for cmpsel_vec")

---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.c.inc | 31 ++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 342be30c4c..c68ac023d8 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -224,7 +224,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
 #define TCG_TARGET_HAS_cmpsel_vec       1
-#define TCG_TARGET_HAS_tst_vec          0
+#define TCG_TARGET_HAS_tst_vec          have_avx512bw
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8c363b7bfc..afeaab313a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -462,6 +462,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_VPSRLVD     (0x45 | P_EXT38 | P_DATA16)
 #define OPC_VPSRLVQ     (0x45 | P_EXT38 | P_DATA16 | P_VEXW)
 #define OPC_VPTERNLOGQ  (0x25 | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTMB    (0x26 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPTESTMW    (0x26 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTMD    (0x27 | P_EXT38 | P_DATA16 | P_EVEX)
+#define OPC_VPTESTMQ    (0x27 | P_EXT38 | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPTESTNMB   (0x26 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPTESTNMW   (0x26 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
+#define OPC_VPTESTNMD   (0x27 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPTESTNMQ   (0x27 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
 #define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 #define OPC_XCHG_EvGv   (0x87)
@@ -3145,6 +3153,13 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
         { OPC_VPCMPB, OPC_VPCMPW, OPC_VPCMPD, OPC_VPCMPQ },
         { OPC_VPCMPUB, OPC_VPCMPUW, OPC_VPCMPUD, OPC_VPCMPUQ }
     };
+    static const int testm_insn[4] = {
+        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ
+    };
+    static const int testnm_insn[4] = {
+        OPC_VPTESTMB, OPC_VPTESTMW, OPC_VPTESTMD, OPC_VPTESTMQ
+    };
+
     static const int cond_ext[16] = {
         [TCG_COND_EQ] = 0,
         [TCG_COND_NE] = 4,
@@ -3160,9 +3175,19 @@ static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
         [TCG_COND_ALWAYS] = 7,
     };
 
-    tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
-                           /* k1 */ 1, v1, v2, type);
-    tcg_out8(s, cond_ext[cond]);
+    switch (cond) {
+    case TCG_COND_TSTNE:
+        tcg_out_vex_modrm_type(s, testm_insn[vece], /* k1 */ 1, v1, v2, type);
+        break;
+    case TCG_COND_TSTEQ:
+        tcg_out_vex_modrm_type(s, testnm_insn[vece], /* k1 */ 1, v1, v2, type);
+        break;
+    default:
+        tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
+                               /* k1 */ 1, v1, v2, type);
+        tcg_out8(s, cond_ext[cond]);
+        break;
+    }
 }
 
 static void tcg_out_k1_to_vec(TCGContext *s, TCGType type,
-- 
2.43.0


