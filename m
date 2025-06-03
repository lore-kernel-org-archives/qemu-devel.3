Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBBBC5B559
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMjq-00034m-My; Tue, 03 Jun 2025 04:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjd-0002Up-Fp
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMja-0005nH-Aj
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so4220915f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938257; x=1749543057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvZ9wF8gq0in8xmAGr8eSaPA7UGsf3Jvx+0+VWev78Y=;
 b=QnLSGCJDPmFmVWCBFlMPPby4lB1mVKnVpflMCxW92x9k3TKcdXOjpJzI9eg9Q7Q8oX
 XqXE5fRUYADmZppnWJ9tgmmZM5+FHYWg38Q5K7hu9taQMR7a55ETxYPzoGc9XDfyraBe
 ctW6gdueIVuCwpO2eTX7OMecJIdE6WtQJhmZXclG7kJRLRzeMSrLf55oFwDrRhxb/zGf
 dFoF4856s03DmrBSK+3vHnQn4DL+x5LcTF20ogqpcy5HwshW5ex40dOg29COXZyqgv3r
 m1jDws5DYZcFhsN2cKjmr3SmM/7bdpeJX/HAH32jPsrzelNisHvSrcylOShmyAru2fDl
 qieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938257; x=1749543057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvZ9wF8gq0in8xmAGr8eSaPA7UGsf3Jvx+0+VWev78Y=;
 b=lsYOBUfieiH8euT0HKqXwVNDSmiNxrzXCs2i2lSuuqolshz+unIqwCRcBZhleOdYJX
 LMP6x5Kje9q2l9dduN5wKmJCQ4iI8jIWFfzWxD0BIEgDoGeGY34gwu8O4dNSyTfq6ebo
 pdZ4N3dx7KHSpnMYsJAs8fFEKNHl4YRzZlj9lDQpFMSaKIc0ov6VUEby6ZFIiqqDvTnV
 27KBLc6SyXsIfPScJKldeQ/JPQ/nha0Mvb/FdHLX1iuJDjh0rlYObDT8BNcsel+DLTww
 9HFu4eO4ZYJd/8ZBnG3zqkZGGuRTMgMBVSTXErTmOva+wy/mV+Tf+QbLenHsXjqwbxsp
 y/og==
X-Gm-Message-State: AOJu0YxkOZe/DuOteA4e6+tC8/wZwK+whJMRZ24QYu4yO6mMWBe7uVBT
 T0rTqDA78VSp1Bxz4qPtrdf4aJmO0EC1nY0N8N3gWsI6OKXeAqcXMoN82XVYBl5b+4rVBmcKZHF
 XUoLDHvc=
X-Gm-Gg: ASbGnctWcjD6TPq4TwiYh+sNDq1Hu+lNFrchrdeGLgMlgPtWwWbUweCvSRzOZKTT3ua
 cA1ro9ofQkCbCyZd3jFHEivrlkC2KCC9N5eUKlSwzuVNkGmv43rnyE01t9Loe2VSUHRp7Ox+hGQ
 FRDVXr7pKOkZNYMiTtlMdykT6xT39x/BgFGdbQYfREo+tTJE6dna96cJOaVMRaYCTMMnRJxK9L/
 aY+JSqB/2yyqgsphEP1vtcTtxzZ85EwuUJGl0XPaWCl0Jxs4UdsAgZMcSqWv4Mp8ZZqkZTMueR7
 Z9iMO/T2HWHvtXbDukBZzKaPBi3cx3b3QcSFo0eB25QHZUVM0bvDLbFRaogeTkUtlBT+2mXcdNM
 9qa/6s6iXiA3Y
X-Google-Smtp-Source: AGHT+IEDmLZKr/975+RFisIcKbN+QZNvkgWf6JvPLFoNbK0VrHAUG3erq+RTNECW1zrJKi+C7l/bIA==
X-Received: by 2002:a05:6000:3109:b0:3a1:f8d1:6340 with SMTP id
 ffacd0b85a97d-3a4fe391a05mr8462056f8f.34.1748938256766; 
 Tue, 03 Jun 2025 01:10:56 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 16/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_extract2
Date: Tue,  3 Jun 2025 09:08:57 +0100
Message-ID: <20250603080908.559594-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
 tcg/optimize.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f5fc0cfff9..86d958267a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1099,6 +1099,12 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op,
     return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, -1);
 }
 
+static bool fold_masks_zo(OptContext *ctx, TCGOp *op,
+                          uint64_t z_mask, uint64_t o_mask)
+{
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, 0, -1);
+}
+
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
@@ -1982,21 +1988,27 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
 {
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t v1 = arg_const_val(op->args[1]);
-        uint64_t v2 = arg_const_val(op->args[2]);
-        int shr = op->args[3];
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    uint64_t z1 = t1->z_mask;
+    uint64_t z2 = t2->z_mask;
+    uint64_t o1 = t1->o_mask;
+    uint64_t o2 = t2->o_mask;
+    int shr = op->args[3];
 
-        if (ctx->type == TCG_TYPE_I32) {
-            v1 = (uint32_t)v1 >> shr;
-            v2 = (uint64_t)((int32_t)v2 << (32 - shr));
-        } else {
-            v1 >>= shr;
-            v2 <<= 64 - shr;
-        }
-        return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
+    if (ctx->type == TCG_TYPE_I32) {
+        z1 = (uint32_t)z1 >> shr;
+        o1 = (uint32_t)o1 >> shr;
+        z2 = (uint64_t)((int32_t)z2 << (32 - shr));
+        o2 = (uint64_t)((int32_t)o2 << (32 - shr));
+    } else {
+        z1 >>= shr;
+        o1 >>= shr;
+        z2 <<= 64 - shr;
+        o2 <<= 64 - shr;
     }
-    return finish_folding(ctx, op);
+
+    return fold_masks_zo(ctx, op, z1 | z2, o1 | o2);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
-- 
2.43.0


