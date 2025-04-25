Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9CFC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RC3-0007aI-81; Fri, 25 Apr 2025 18:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAo-0003bH-2k
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAk-0001pe-Qs
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2759510b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618725; x=1746223525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0vOFqNb84AfjgrwuWgB0B+xS/L+e0BZD8i2eGNdXO4=;
 b=HK4t9Cp23Nae6ZgAn0JVbaQuELmmx1Iq2CpgXKa5pP5zbVLF7qWFxitOUbg7KETagC
 3zX+bJnT2jTyZlSvY82IqID/DsIcAc1sU8Uvt9FMtUUZwA37dZ/6U6xtmFOFaqQiiPOJ
 et1nU/bNMJzvXzP+Lm/4WrRReD0DkbQbqfcXZ3Em8aZU+JpQf+Sr32dM5oP05054yDXK
 VE+ylhswIpRG70DUtOWtOExP1dhy6MT7/2UtECh8rk8ZVB0V4tF4yrv2rl0ej2zmLm/N
 V6X1wy8bLqNBr4+pGMldIB7VCe7HBmjy33bXrzRnY9jrFlnJYbK6elK5Itf3CVVncvz+
 vYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618725; x=1746223525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0vOFqNb84AfjgrwuWgB0B+xS/L+e0BZD8i2eGNdXO4=;
 b=nV4nzS627ZV6/6TU+wc0MoGJSh9GNbhugPjIhFTTg/DvKDDWZG1du5x+eS1ThM1zkW
 TFuLBv9WU70gbbjsYnAJCIYecEko2pYmEm2yC3xlSAZ5vGMDL7muJrkVaMEtXpV+xYNG
 8QF5L01KuV1pyvJgBcwVQi3cV25lsghL7KfRAg2RC+tpq9JRhLAUCbECSZiFkb+gq6zP
 H9KFYJEo29gkvT4J6vBqSr64C3QcjTTxP+R0SIYzkm8ygqJnoiVnjseXzfzfVcyxarEh
 S9HFuuja7UZKRIxi1bWf5gnHjfSuzzMyTbdCr7azk14ULAl17eDr7F5q6pFpwoL9N9/5
 nwHA==
X-Gm-Message-State: AOJu0YyzIbV/SfyEWn7lp3ZNbWKQ/2JHkwmPsW6uPrDyhYo3FSBeR4wS
 0mC2CG1/b7Cogp1a2SqLFWbWe1Fs6Eler6C5BblTTg9ey/xDB66CyDmMnWoybsxjryZ6GIyGijp
 l
X-Gm-Gg: ASbGncsVFqQ0uWIfjCvY8Y93dwCe4JTcs2Jaj4r+Ri8g+SJ7opfflLaMuZb8scTMTyy
 MOrD/Q8/78HLCVTZQxtZLi3e4YU5RhRYGk9Iok7shTZsbi+/IK803XhcZ4KwTwO+v0MD/NBPgxm
 IHKpg3UXAifZQMK1ad/lHIpWwZ2yR+mYTMt+JrG2D3tsX/IJGZajgopjgaQ+2q7CrMJ+6PZcq7n
 fzKhdG8YjRoIjx6BcCO36p7XnUfgChXg65EUnJUXGp0HkePtoh1SgtEnWX/hRD/B92HwQ8PD+lt
 IprCI/59qcUhNQ4ewkymhNyJF9JRg6AIdMCE8VRWeQ0bpPYsHSHT6HrT9gxmjI+nRl5GR86YwDs
 =
X-Google-Smtp-Source: AGHT+IHGrij3nNxkoic31NK3X7tqh7e+FQN5WCMy9E0GuPCC7+QqxqXpOphfuEC4fOLCVFQYljCp6A==
X-Received: by 2002:a05:6a00:a14:b0:736:ab48:5b0 with SMTP id
 d2e1a72fcca58-73fd6af2868mr5168521b3a.2.1745618725528; 
 Fri, 25 Apr 2025 15:05:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 121/159] tcg: Use add carry opcodes to expand add2
Date: Fri, 25 Apr 2025 14:54:15 -0700
Message-ID: <20250425215454.886111-122-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 127338b994..f17ec658fb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1102,7 +1102,13 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-    if (TCG_TARGET_HAS_add2_i32) {
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
+        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+    } else if (TCG_TARGET_HAS_add2_i32) {
         tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2822,7 +2828,26 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-    if (TCG_TARGET_HAS_add2_i64) {
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+
+        if (TCG_TARGET_REG_BITS == 32) {
+            tcg_gen_op3_i32(INDEX_op_addco, TCGV_LOW(t0),
+                            TCGV_LOW(al), TCGV_LOW(bl));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(t0),
+                            TCGV_HIGH(al), TCGV_HIGH(bl));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(rh),
+                            TCGV_LOW(ah), TCGV_LOW(bh));
+            tcg_gen_op3_i32(INDEX_op_addci, TCGV_HIGH(rh),
+                            TCGV_HIGH(ah), TCGV_HIGH(bh));
+        } else {
+            tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
+            tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
+        }
+
+        tcg_gen_mov_i64(rl, t0);
+        tcg_temp_free_i64(t0);
+    } else if (TCG_TARGET_HAS_add2_i64) {
         tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.43.0


