Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8269AC8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRa-0000QK-2z; Mon, 30 Jun 2025 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0000MU-N4
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:14 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRL-0008C8-QV
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:07 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c14138668so1388551a34.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297340; x=1751902140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYFMkZRnODWXYI8aKbzMijakPdkXTuLx1FksNfTSw70=;
 b=mNFFzk6hqi4jSI9e710xJ+PswnurkwhTkGrCFJIHAu429/bx1cvAchNepG2dp8b52L
 rl+G5QjOSRScPBWnNRXB9Xr0aCoNMhS3Ku6oWsdPzSYN6znCCRH7n03En7HufLmxe20r
 JeY9+fPZhRiQZbnGsPmhIhWffRFdn1/v58VmRMOdK+6yAYOb4stQ23YB4LqRI5qmLQNu
 jC47A07I1HZjdMXeDC6K4WokQdpsO8iz4+qP7aJgu1meJI0ft+NYWRqJGmFNiR5XyQTN
 Mrw3zd2x3Jryu/QzAyzWh6DNnwgWoKlvsq9PeUeYD0s2L/f0WVwRVtgLANIsdADxAmZz
 jl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297340; x=1751902140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYFMkZRnODWXYI8aKbzMijakPdkXTuLx1FksNfTSw70=;
 b=nXU0kJq7KbxugGsxf/s9xnxboWdVN0QUT79ki/UUdRm6K836Zn/IdLs5tsMdytCgoU
 kGJdoVCauLECvm/RsJa59FzxSu6Lu7QN1Tr/6H+20xt1RgZBZB9NtwDtdf2namWN1WHN
 uoPCQqtjdQ6MRfjbPtnFM5mPrm1cjjypGToFKh5asb/LLHKs1hQv+0I+yYjQPlujd3Hy
 +eHLy73fZk5hmRbzqn61PClLwV1qHveKCjeHojx1pe9jwU/psap3K27QI34wnm6mcJv3
 DTvZED7eZAZOnC+i9DyYATIAohhvVkihNGWfEwg9eg8VglcEr9L3LKa+9KBILx7B2e1g
 6ngA==
X-Gm-Message-State: AOJu0YxriLHaUcXsDRdmaCn/aM/CVY8zquJrm95KmqHbJIvF5zZJ1Jj1
 7OuXXD5XNZbYtAi0vHTQnwNqpx6NHjoSmqVEUhym17CdkpR91RNfMAALD6zqk/YjOxIf36gUtvA
 WHDnI
X-Gm-Gg: ASbGncvo6IlVabS2ejyfsSE3C6jNMHBRzLFUAL0r1Nn2VoBB07vlSafYcPe7T+0CDpb
 IbnIdCh8/MZvLMLN6lllLY8lY6+Nq3rx9Pb3vRhXhn44ds0r7pMP2oUzT4exWALAz5w4kVpIAp0
 cvUUXxLRCGNQfuWuKy3tKkR0TInIsWQOcSpTyqA7n+5ciTm+IHWF79P+Ns1xp4OeRyzRqruWmaN
 FFQzdx1/JHaO96dSNWwfzcbZKN2rotLRxxgtHj3MdSt/VQSk8nkQFlqC9QDLddKgL0U+MKnmGHX
 UhvCVb9zn1vpqvI5IKvd1925o76afvxzQh70JQC6zHsT5CAmU8/ji6KV6cOw3BV/L2LvIw==
X-Google-Smtp-Source: AGHT+IEf3Tgf9IdmLblcBIjNPX9XRYSmcfMfEYooXUB94kSuEdAeqahqvETES6LuV6DYtxflUFLNGQ==
X-Received: by 2002:a05:6830:2c01:b0:739:f7a5:66c with SMTP id
 46e09a7af769-73afc2cf333mr8472664a34.0.1751297339937; 
 Mon, 30 Jun 2025 08:28:59 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:28:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/29] tcg/optimize: Introduce fold_masks_zosa
Date: Mon, 30 Jun 2025 09:28:29 -0600
Message-ID: <20250630152855.148018-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

Add a new function with an affected mask.  This will allow
folding to a constant to happen before folding to a copy,
without having to mind the ordering in all users.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ce3cb4d7bc..49ef039932 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1039,8 +1039,8 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
  * If z_mask allows, fold the output to constant zero.
  * The passed s_mask may be augmented by z_mask.
  */
-static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
-                           uint64_t o_mask, int64_t s_mask)
+static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
+                            uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
@@ -1061,6 +1061,7 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
         z_mask = (int32_t)z_mask;
         o_mask = (int32_t)o_mask;
         s_mask |= INT32_MIN;
+        a_mask = (uint32_t)a_mask;
     }
 
     /* Bits that are known 1 and bits that are known 0 must not overlap. */
@@ -1071,6 +1072,11 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
         return tcg_opt_gen_movi(ctx, op, op->args[0], o_mask);
     }
 
+    /* If no bits are affected, the operation devolves to a copy. */
+    if (a_mask == 0) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+    }
+
     ts = arg_temp(op->args[0]);
     reset_ts(ctx, ts);
 
@@ -1090,17 +1096,17 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
-    return fold_masks_zos(ctx, op, z_mask, 0, s_mask);
+    return fold_masks_zosa(ctx, op, z_mask, 0, s_mask, -1);
 }
 
 static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
 {
-    return fold_masks_zos(ctx, op, z_mask, 0, 0);
+    return fold_masks_zosa(ctx, op, z_mask, 0, 0, -1);
 }
 
 static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
 {
-    return fold_masks_zos(ctx, op, -1, 0, s_mask);
+    return fold_masks_zosa(ctx, op, -1, 0, s_mask, -1);
 }
 
 /*
-- 
2.43.0


