Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFFEC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMjk-0002dY-K2; Tue, 03 Jun 2025 04:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjN-0002Io-RW
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjG-0005l3-3D
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451e24dfe1aso9120045e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938235; x=1749543035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JC+LOnHAVgWdjSaAq/ZSXpa/AKiqqGPj5EsBUAOGzFY=;
 b=pvd01jf9vXS889JgG061+TJ4rlERV10Lb3TMmyKaw8/cMyCDM8oCUNxgx6EPE4vga0
 PgA6drJWtqYhYyoE6W97YqS2lFYynmQv2Cp01bCGgvAh5FYMPURaarqVtGXU2ILojA1X
 4LV0mkSV7JA0Cy3D6sYvZuNZ+5EROoEo5dCmK0hRVhwn/9tRpNvyJ/ijR7BM8DnLzyUm
 s3foHINZGunrVhDU6hIlQGCG35LJ6thjIk+U6JmwNjVd/Eaau0aTrLjeZ5klKLEErTRl
 lhd/pfnuXnRXFzr2Vy07qHomGadOMtxmH0+dVz3eQ0Deem5Ng2fxVHtQTh9ZMaEnOHiX
 fNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938235; x=1749543035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JC+LOnHAVgWdjSaAq/ZSXpa/AKiqqGPj5EsBUAOGzFY=;
 b=kmjWf7eOVyoJFCjfezs+vjCaV7luEO5Lk+UJojQlJNMKKbsuQ70sD/qbMwnNIvNaVE
 vuFoA4iSGVLbxWWufuCrw9cbfHDgha4mS++BinaoumCYQ+Iro1T+u7yOa0WIwtDarXaL
 SvQSp3nCF0eCU/165aCHLPg//M2KkDqbi+plZfFqUFW+mXCeflXZiRibYMQKfDVbuP/B
 DyNHjH7MnnjsgWS95LRp2VkmRnL20S86OsAV/zkgZrmwQ3BSMHn21YNLFWwkNHJW/sac
 zz/q9nIrQ9VT4CuY+6Sc1oYgYUSnv+NIohL3/u4Y2gRyqtRs6pn9o2/xEuSPRjwFIPPM
 Ubgg==
X-Gm-Message-State: AOJu0YxpeCurg3UKHPFESsjyIBUbXXSPcbUJCXVoWRDCG3N53hVTlbGy
 DgIYGXD6a72CwBsWaCAv9MWi0ow45g0MZbqONGw2ApIyuQQ4I5tvfsbN/Mjjfq1aTDG6SzqbIk+
 14y/q0pk=
X-Gm-Gg: ASbGncuWK8uno7rONU5z/5eSMUZUInARbuM29b48H/dhxSu8CA16iMOMNyjnALcF7jh
 HmYfNxVDZ2RGnW9qmu9Joh5qn69dIAVkdZ0CX55pjSI4MX6MUeuc9p+RM0UIFiJeGCB1JVKgR+g
 rR0IyaBxZ4paX9uqeK+5HW4h6fBrE9tr9vXUIsEc/S8881CcAZlCxmCTpZVJA9C5cOXKEgNa7Bz
 9MUqB6kGEPtsvv/PDKc7B1f6YxMcBYP+GB4HII198fvUrvNxwOtpR4FyTZ6gOh1FREz+x2PajX1
 48QBv8UvItWlxrY/IIA+8r90U/VsWR8M53q22C1W+q9KysEXwbBzrjrisQgY8GUOuUS9PqwM/DZ
 9v+R59HjY9IhM
X-Google-Smtp-Source: AGHT+IH+ZNTR86kdc3sOnxlfEzUkMkmJS5R90pHkvdAk6Ks9UCc3nkhkOC9W5TLNiQjlu5vyBsIBPQ==
X-Received: by 2002:a05:6000:310a:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a4f7a6d223mr14390259f8f.39.1748938235195; 
 Tue, 03 Jun 2025 01:10:35 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 12/27] tcg/optimize: Build and use o_bits in fold_xor
Date: Tue,  3 Jun 2025 09:08:53 +0100
Message-ID: <20250603080908.559594-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 tcg/optimize.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 795f1c900e..572d314578 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3039,7 +3039,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -3051,9 +3051,12 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z_mask = t1->z_mask | t2->z_mask;
+
+    z_mask = (t1->z_mask | t2->z_mask) & ~(t1->o_mask & t2->o_mask);
+    o_mask = (t1->o_mask & ~t2->z_mask) | (t2->o_mask & ~t1->z_mask);
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 /* Propagate constants and copies, fold constant expressions. */
-- 
2.43.0


