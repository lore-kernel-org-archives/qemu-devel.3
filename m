Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF7DE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMP-0008Rt-Cs; Thu, 19 Dec 2024 23:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMD-0008Oy-0v
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:22 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMA-0006KL-Uj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:20 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso1245588a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667877; x=1735272677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYuC+YHXS7R+2bMWumhxixewSDDRoEnZD362H6THvd0=;
 b=T19GeWlWwO+8frr3L2RM4FGFtIb2S8RldA8yT8RlGx8IQ7vCqqk1J4l0xdnQmyLOfY
 Xczxrw2FKgEdZzdYGMs1Q/1OWTuh2xlBQJsIpPNC/tPUNSgcl6Pp+hGBj8XnZLPZKz3H
 9PezAS+iUL6LE8fE+HFe8cXWQ7hOn8FLgY3yZGCOySPrirp8EtE0+SIbpekTV7YWGzSa
 c9I/slwGF8jvQr+9mJ4z8McL0kmw7NTY58SNuPNcZLfGODAsET70IPENj1mZVYMLGVfF
 46g/W0rDTks6tkfnXQGhjETvtDSwQHcESe0Gm0Gc/hbUu/R5DUtnenjoIOZrmiJCCuHl
 YSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667877; x=1735272677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYuC+YHXS7R+2bMWumhxixewSDDRoEnZD362H6THvd0=;
 b=o0lD4SV9D9F3EggvR9YSj7dWxUcaP4TpFxS0giQQKRXuwAisQDCOYa2nTbtOI10wfo
 Zwh+OP50JL3NMFL8t9sA72mGjzU35bRFVeEuz1PtAbC5Z2g9Eqmi3aBm9C42IIRUst5+
 9KeT/PyqYTC4d9jLWLAko9bKwKzI7+VDq7FDUsRYgkjGAz51UzhIUrg934Wi8yXpPbIP
 AP+1shaQaW+rwuQdaylAHLsYbFCavusu3v4cXXoR4ppYhoTwPDrHG+h0LjaEv4NnhSd4
 nx4whfCYdBIhEROZvSszQOzRPYEuE06WcEBMCiWoOM30GZ6vvLzYGxnqq3zC7ILhLFkV
 BOPw==
X-Gm-Message-State: AOJu0YyqGefKEXOiCcEhCzmr2ZkleiOTwMaoON9SEN7Ad2ZtJJM/kgAa
 GD4Yh5gvBxNYzJMO2OxKOBc9gI3Ubl3Iv3qCp5wga+mpo/En5nwbPYBuy781qK+kxyYyWl9qGVt
 f
X-Gm-Gg: ASbGnctl4dImm9AGJZi6Fzzc6hshF6v0lJJQhMxk2eACRL/O6Ve4YvK/CPSK37d8NXV
 g5nln4l0vP2HoeNnYlHAYKm8y5tkJgH7DEXX6rC68jCFm4Ik7Am92S1fdbJ71oR8uI1u7nVgj3X
 9g5MH5AYaBFboL/JE28BzrRrVusr3GDRncrrGm5SX1AUJGFQ/WqlRu+DZptUsmex+PZHsR229b6
 SG0sgbcn8xOue9k29eu7jTbtzOTSMB+btnBtpe6j8Ep4XM1EeXiHqIWHCN4LaM=
X-Google-Smtp-Source: AGHT+IH7e8S4eyWlb3ERXkwe9Yc5QTrMBWKO26w7CfUIfZ1z8JJkkegL5kSyFGWKhsUG96gJnWJLJQ==
X-Received: by 2002:a17:90b:2f45:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2f452e1cc5cmr2464537a91.16.1734667877385; 
 Thu, 19 Dec 2024 20:11:17 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 17/51] tcg/optimize: Use fold_masks_z in fold_extract
Date: Thu, 19 Dec 2024 20:10:29 -0800
Message-ID: <20241220041104.53105-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 56043a02e0..6f7166414f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1755,25 +1755,22 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
 static bool fold_extract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask_old, z_mask;
+    TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t;
-
-        t = arg_info(op->args[1])->val;
-        t = extract64(t, pos, len);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (t1->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                extract64(t1->val, pos, len));
     }
 
-    z_mask_old = arg_info(op->args[1])->z_mask;
+    z_mask_old = t1->z_mask;
     z_mask = extract64(z_mask_old, pos, len);
     if (pos == 0 && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
         return true;
     }
-    ctx->z_mask = z_mask;
 
-    return fold_masks(ctx, op);
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


