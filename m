Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61EEC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1z-0005uw-3W; Sat, 12 Sep 2026 06:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1K-0004n4-2g
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:42 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1I-0007GH-1W
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:41 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so249142a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209097; x=1789813897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bFnQG3GrVobV8mM4B0HhYTSgdDJqvmG6Q7KBTqXiyLs=;
 b=MYorhicRYMVm4aqfRNMtHjDNO6yoM/N5DgdvY5Hc7EE1PJ1L8Cham6ZwsDsS4MnPM/
 ADWdPhn+L1hnu60O+WyPUU59Qad6YOlkLtmU6PzAg+LKUHFuJ/9K7/Px94lyWZdAx/rJ
 2ws0als3NrJmdO1N+ZYk61gbjMWyFG95YyuKdqeZxRnK2PqAJ1LkAGbB2YMEd9KbkUxc
 3J37LCOBPfYo11xWBJs33SmA1L0jok8szwsXiqt44I/tQrtQdlzu48vjQznLtF1kbWNV
 ZXeHCsgdKx2AIrcziz4DQWdyj9pooiYct2WtTuSG3XGc+GRrWt3ymLQutMhLz4Eqz6Kv
 2A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209097; x=1789813897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bFnQG3GrVobV8mM4B0HhYTSgdDJqvmG6Q7KBTqXiyLs=;
 b=rhcQLKdFaDHO6PLXRarUatbcPALpA4cV95P9W/Co+YRa4VGiyUtpLpSUREtWJo0Owc
 AcQsdnodSkdfHYCFEJiim8fKvKQ4hW4mUNudBbLPKwOi1oNx6WiKFZgo7U8WVU0XZVlh
 AJH67dc3M2hgaIC/SVYj85x0YU78smyrwF6BiBiufXYHC1ngQ/xirjJRCIElQOzAsHjo
 urS4EQc0Z4Yu8kJciLy2B/ksjtqaOm9EfoUBsycRNa4ZWJAI0Xz0WY3FDXMfz/DE6t5q
 UAwPfXdtL08ohCkd4ZQ5mw79vFUD4w9MLjgkiaIpbUC2UY2Ma/x7cFSQowglQGqqhvzP
 fuhA==
X-Gm-Message-State: AFuF++lkkD2KD2KK55VbvO4sRsrzAUZawp87V9gPUDm0hsCiE+wiXV8D
 TgQRxvSO2tOfWTw1vCKFzHXYgY4rfaYfk014Mcb+Iw+IcEqCtChk3jyhctVpnwKcgGMZZq5EjgZ
 HvZrE
X-Gm-Gg: AYBFou3h5uLxZokJ6sIUW6E4VePnyRnBhvGAP0ivxdddhzoCjph2nwNlHd3zrOpBnav
 kx79Kv9sIsNWZlBbmVXICHjfpgrH8qOXnnu7Ei3OxCyIpudPdxbYrXdLZRDz/LkML/qeIG6474A
 8lqz0zeyl8WJ5+woS4O8d7545JPU847Gt/sEPdLIiw5WJ/s1465bwfePXHVOSkrupvF1CTn9LE6
 KufBFQL7eXmLG2KOkhoEBkvO91ppuqv2KypeLf+Q3L0Wa+q7Dl27Q1cvEhnl170Hn8hIB4ol9vC
 kQjq72B8qyCUdwMkJehiEUva8Z0obAy5BRnxg/KFZ2e+Ms5GSDlal9tuRLWF4drD2skIOnXPw7u
 zo8NvTMa8Uel+q6cavdGb0R282u508dB2q7hdhjMDeKo+idXQVMKRr4SV/tFmQKUvZ7QAztKD/i
 C1g2J1iWzIjhOuMXkJWtq5R8Uxm5TDT6HfIbSrrIrnjE4Vi9JI8M1BtUYKXOoRi+hF6yFyjZFe2
 vIGBMc=
X-Received: by 2002:a17:90b:53cf:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-39dbbeb3c67mr3930253a91.6.1789209097496; 
 Sat, 12 Sep 2026 03:31:37 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/82] tcg: Generic expansion of tcg_gen_subi_*
Date: Sat, 12 Sep 2026 00:30:13 -1000
Message-ID: <20260912103126.598030-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 497a9e2c3c6..145197b6fc0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -118,7 +118,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -219,7 +218,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* 64 bit ops */
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 5770bfcccb8..71c81429cd9 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -4,5 +4,6 @@ DEF_R(discard)
 DEF_RI(movi)
 DEF_RR(mov)
 DEF_RRI(addi)
+DEF_RRI(subi)
 DEF_RRR(add)
 DEF_RRR(sub)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dfa97036780..78e711fffa1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -385,6 +385,11 @@ static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_addi(type, dst, src1, -src2);
+}
+
 /*
  * Templated operations.
  */
@@ -428,11 +433,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_addi_i32(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
@@ -1555,11 +1555,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_addi_i64(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-- 
2.53.0


