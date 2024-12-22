Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9BCE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlq-0002uC-TI; Sun, 22 Dec 2024 11:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlH-0002ZZ-Dd
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:00 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlF-0002yG-D7
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:58 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2164b662090so27973845ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884696; x=1735489496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d99LqK671C6w5tPD0zg6x6YjwgfiTJxRHrOGZhb4WRw=;
 b=TluxT5tkv0ckPsei4m9v1sjRKusagz21Jy5fJKJ3vDpNXO8TWYu3vtc+IAwV7qPclo
 4dGaUWTfIhUp3Z2V5VHegmEoC7wC1q/rma8PidmdY2ZRv6tlPy1qmICdLlNBAk+VLyiv
 uOuI6bAhKUj38elpCe6SQGn6VkGu4nz9OkulNCT3RcAoTAd5xsVWJSPjam20xmAjiwev
 5WPHuTrkidPv/M/CnYjrpawSF+olffjTuXoLeya/kifgfi0xnA1fCzW8+sdD82pnWAag
 bpBtLuWTcHBo+8zaV8U91QJDdCaoPChjeugA8Ue/9WN3I6haBTlcSDRKS0vG4xWXwimo
 ax1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884696; x=1735489496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d99LqK671C6w5tPD0zg6x6YjwgfiTJxRHrOGZhb4WRw=;
 b=xHPKqd8k8WQShDu7++q+uj+yMAZfyOnDBzoltwZTQ2e6QccIHDs7W4dCWA7ts09s+1
 U/DwZ4v4yFwN03BqfLcEa9tXyIIlhu/WDLDTJ23YDJTWgeSJ8JL5hdPTJ7wzYU5qavdR
 78Hqf7o7X0d3P4fG/DdjENXllnEL0L2fhFXUChzjCry+vquBBE0LNOV8qEDtc4RsTC2U
 apkIU2yY5TIfg3SXz0ojpzH5rwqOGic5lRM0FtYDjHVymd/mvmGnq+GM1aaowGQNnNxY
 tAkSR52PVKYCT9vanMT3W5FJJGkm+iLXoNSkB8bXvv8OewmLxMF3vNeJKEkr/hBn7gd9
 j+fw==
X-Gm-Message-State: AOJu0Yw4ckcxzfSn2tVAC7kR7TmbJs4pOpOE0z4D1sh9Ent4K6WAZ1TD
 CrnCF/hfAREy40pzomSAtcd1w/QdMcJaCz1SsoivA45biAa8Mebir5KwpqyxHH887liajmBL8JS
 zvzk=
X-Gm-Gg: ASbGncslvlcRaPJhTVt7rwdnOvXOnrBBE6b2rP+ITMFRn8dVYZsUkgi8KQGGJnXmk71
 FEXJ4+UCN0YKLANIgvo2M19+KcRygDNBQ+OITtec6Li7IaTSEK8FqWVSMkmeqiT2IuUmol59bdR
 feIR3OnWj/gWn5w2V/+w5UwK3/wFyGoZD69xKFFwKEGb0PUFytxK/J/s7IuaXBjXR7uVBxOo947
 Nx8wiXhq+iy7vazLx19Li3sgMFT/8imyoZVuRCkqHN8ZCvdaTYU9I00Ei5p9N0=
X-Google-Smtp-Source: AGHT+IGAsABuC1q8p8a2SDkAWxq8FX5gKvyyNuzaJkQSi0njqe1hw7JTrUVtF8mBs7+z4aKCYwxR8A==
X-Received: by 2002:a17:902:ecd2:b0:215:89a0:416f with SMTP id
 d9443c01a7336-219e6ebd0a4mr116786005ad.30.1734884696112; 
 Sun, 22 Dec 2024 08:24:56 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 13/51] tcg/optimize: Use fold_and and fold_masks_z in
 fold_deposit
Date: Sun, 22 Dec 2024 08:24:08 -0800
Message-ID: <20241222162446.2415717-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.
When we fold to and, use fold_and.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index eb982b73cf..0f7c2c810e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1609,14 +1609,16 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    int ofs = op->args[3];
+    int len = op->args[4];
     TCGOpcode and_opc;
+    uint64_t z_mask;
 
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t t1 = arg_info(op->args[1])->val;
-        uint64_t t2 = arg_info(op->args[2])->val;
-
-        t1 = deposit64(t1, op->args[3], op->args[4], t2);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
+    if (t1->is_const && t2->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                deposit64(t1->val, ofs, len, t2->val));
     }
 
     switch (ctx->type) {
@@ -1631,30 +1633,26 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting a value into zero at offset 0. */
-    if (arg_is_const_val(op->args[1], 0) && op->args[3] == 0) {
-        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
+    if (t1->is_const && t1->val == 0 && ofs == 0) {
+        uint64_t mask = MAKE_64BIT_MASK(0, len);
 
         op->opc = and_opc;
         op->args[1] = op->args[2];
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
     /* Inserting zero into a value. */
-    if (arg_is_const_val(op->args[2], 0)) {
-        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
+    if (t2->is_const && t2->val == 0) {
+        uint64_t mask = deposit64(-1, ofs, len, 0);
 
         op->opc = and_opc;
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
-    ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
-                            op->args[3], op->args[4],
-                            arg_info(op->args[2])->z_mask);
-    return false;
+    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


