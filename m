Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E559C27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 05:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJoCv-0005Iy-AY; Wed, 19 Jun 2024 01:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJoCt-0005Il-KH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:50:07 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJoCr-0001Xl-If
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:50:07 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-711b1512aeaso146536a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718776203; x=1719381003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q87yEelvlvLrbbH45z9fgatLb5Vc2yZq2nrn8gRhdVI=;
 b=WGDdx2kVk1rRyT0ipJNnsSheCfVWFhj7PuHOPMz5M7k0BoPuXAG0TH5uEJ3CZ16U+Q
 F/aDEfTuQWvmeSi3+SLi3aZJ+TskLs2HIK0GLmStsH6hgjJcyaQDvC6Fl54wA+e+OwDd
 4hjENLcF8nHW+7XjUEb4auFaPL4FSsD7JdwvgmiHK8YZY/pL/nmzm7F9QUYlADphb1WN
 /SnsGcyPWHyCu1tFkoLqxRc9PgsrumYKQfCoevCP7bP75VR7m4LgeDBoPzTSA7OCxezy
 r0VMo1QBc7pjbk52M1VTLqyxnA4NhhNWlPTkoZ7RDLg4LlX8jZUVW5tWAO2mPyu+LT5X
 usuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718776203; x=1719381003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q87yEelvlvLrbbH45z9fgatLb5Vc2yZq2nrn8gRhdVI=;
 b=VTlhRCp/t6hXNiHoYJMADzQyPlTv2qSTN4cc2/LPjZl0wLKlDzSyhHJ7Jd3FhWlzKH
 nEo7nRDgggpQhFbt/Kg0dUCYGVkjtZPLDpPSscJ+RCOsewCsAQSnyZvB7sLHW/GqdWYH
 CiBKUS7xE06VY0E6TOpQYqSZwpVLbEyV46g63Y58YCt/SADCzLihY2+zjIhJ8xSjXvys
 TyEOt5kxSWD3/qbLqf9XUoZMTfpI0S5zwNoh9aIRj838WC/prH5+StZJxrhaB0uPjMLE
 g9dz/j5Q8255705wXO0p0DPjazxyH3hE3YXob/hZQQYtpp8vtCXbE+XsnRkpG5G3avL1
 NR4Q==
X-Gm-Message-State: AOJu0YxZGMztp519syzChkaSHh4BcKINLG9QX3UimkDLhClVWSVs8Lmh
 5acC4vpo6HtrVoKSJ/+LPKLNRWaJD0FSEhbQqnxpsnLbtIgT7KF3AX0VwP2C61NUpKhO4LyHsqh
 C
X-Google-Smtp-Source: AGHT+IFmcFRat3hc5Hc84QMPp6j0HN8hw4EIVYty/OrX2EjtCgp5ITwp5Ml9HE/sPGiwrAVYA297Lw==
X-Received: by 2002:a05:6a20:968e:b0:1b6:bb61:3784 with SMTP id
 adf61e73a8af0-1bcbb60d5b2mr1776280637.55.1718776203444; 
 Tue, 18 Jun 2024 22:50:03 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f15231sm107430885ad.220.2024.06.18.22.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 22:50:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
Subject: [PATCH v2] tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
Date: Tue, 18 Jun 2024 22:50:02 -0700
Message-Id: <20240619055002.119042-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Simplify the logic for two-part, 32-bit pc-relative addresses.
Rather than assume all such fit in int32_t, do some arithmetic
and assert a result, do some arithmetic first and then check
to see if the pieces are in range.

Reported-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Hi Song.  I was not thrilled by the "goto out" that you introduced in

  20240618125044.687443-1-gaosong@loongson.cn

Instead, I copied the logic from tcg/aarch64/ for adrp+add.


r~

---
 tcg/loongarch64/tcg-target.c.inc | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 7ca52d0248..e915e97bba 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -382,8 +382,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
      * back to the slow path.
      */
 
-    intptr_t pc_offset;
-    tcg_target_long val_lo, val_hi, pc_hi, offset_hi;
+    intptr_t src_rx, pc_offset;
     tcg_target_long hi12, hi32, hi52;
 
     /* Value fits in signed i32.  */
@@ -393,24 +392,23 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     }
 
     /* PC-relative cases.  */
-    pc_offset = tcg_pcrel_diff(s, (void *)val);
-    if (pc_offset == sextreg(pc_offset, 0, 22) && (pc_offset & 3) == 0) {
-        /* Single pcaddu2i.  */
-        tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
-        return;
+    src_rx = (intptr_t)tcg_splitwx_to_rx(s->code_ptr);
+    if ((val & 3) == 0) {
+        pc_offset = val - src_rx;
+        if (pc_offset == sextreg(pc_offset, 0, 22)) {
+            /* Single pcaddu2i.  */
+            tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
+            return;
+        }
     }
 
-    if (pc_offset == (int32_t)pc_offset) {
-        /* Offset within 32 bits; load with pcalau12i + ori.  */
-        val_lo = sextreg(val, 0, 12);
-        val_hi = val >> 12;
-        pc_hi = (val - pc_offset) >> 12;
-        offset_hi = val_hi - pc_hi;
-
-        tcg_debug_assert(offset_hi == sextreg(offset_hi, 0, 20));
-        tcg_out_opc_pcalau12i(s, rd, offset_hi);
+    pc_offset = (val >> 12) - (src_rx >> 12);
+    if (pc_offset == sextreg(pc_offset, 0, 20)) {
+        /* Load with pcalau12i + ori.  */
+        tcg_target_long val_lo = val & 0xfff;
+        tcg_out_opc_pcalau12i(s, rd, pc_offset);
         if (val_lo != 0) {
-            tcg_out_opc_ori(s, rd, rd, val_lo & 0xfff);
+            tcg_out_opc_ori(s, rd, rd, val_lo);
         }
         return;
     }
-- 
2.34.1


