Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51844CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ncX-0005xS-Uw; Thu, 09 Oct 2025 06:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncQ-0005w9-MF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncL-0007E8-TB
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so606213f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004680; x=1760609480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olcBu6wEWkaaUYUIK6VQi7xG178kJppBaC3zkmaYl/s=;
 b=oa72ByfM7lgbmiS+g23jZ2GGTANkIj3q69ysRPP/SsRH2VbOvD9giliOPX/X23Z409
 0JllgB53DW/in0pyqD0eNVHNcxd/qAxY0vVmSJewCf1yCvfbI18rokx2RYM0qdkTNSWh
 AC+CGbGS3OdkCRxPRSJWgW3tSqPUSkgw3/9wqylJWYdDZfGoeDQVyt+Q8rS6ejvGatxn
 oZPzJKebgTKz5ZszrvBZHFXP42Wrj70a3zUyL+tDmMAipjBRysRJGImUYvZkoZFJzrty
 JEMmrYmvlU1NOz97l4AGxSCND7lKpwe77pKujCOqmJEwqQqT/U460gMMXXlkC11t7Y/S
 xFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004680; x=1760609480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olcBu6wEWkaaUYUIK6VQi7xG178kJppBaC3zkmaYl/s=;
 b=tYHp1Z3F+iYCdDBf4UWb7k0OiPHSmOC/Llv1lafkHGT8sm7s0FLic4D5I8BoCQqf2O
 GvpuyhOxqJez3WkYy95hBNYfWWIy1CWHoa+X50Sp5pXR0LBVIuGJUbAWRkqYHqRDWYwe
 pZhqLmGL8MOnxM/yGRIxF+fjnIVZwJ38NysEHPuGEPmNnZhL+5vGfUsK08fpd8lKiXln
 +4gn9tUM2X7NKakNKpIjuaayZRxJSEaTSl3PCaEC1guZfXJAqgL1IihzR8nswkUOfziP
 T7UQXu7k1kV07E7TvoK4QNq3HHf9lez8SWc8X37m1iegeOkSHzNow/o+a0Hkgsog4/uf
 +ZIw==
X-Gm-Message-State: AOJu0YxAAOw1mXjkgdNUQ9q7FD0lc4DUBxrFbU7EHxA0y7vMXisG8Ndi
 YtY+FYClVVxWDPUjLMqMVJi5PiAEZ3A1UDdfasp9ENcTvxaGdz0Sm4v4pLoRkU6zr43OakU87sH
 N0vyFMa7VXg==
X-Gm-Gg: ASbGncvFckgrqhFvKvFEeX1GT+7r7HmuJZW6OCXVEHCMmZbMMQ0JoLdg4IcosjBMXzw
 J0GlXmQACIj+9VSlAL0IfLEDo+jaQp3NvuJFY5ki57ogWMBLbo+PMzs/Rt3sjXUlnoKhsXMp+TZ
 d9Cx6kaL3jPRrHFyTB/Ll1sxP5nAEytog4ZPwbcnneegGZFl7a24oWA2jtO0BC/qDOgIZMt/CXv
 utqaEw86OgjEyxY3f55T0WkePek+KHPX1RCNolqaAgzw8do4/Z+u8P93Gddh+ATK9Gledvsep1h
 i0yGH+PHpIickxfKRu2zYvnP65b5l0UBfubwJ3J4QPX/QImdPjwK6PIKS2xCQnQuwD2dQexfos4
 v2XR91G+kbjPTBEqBgedb8RNeSMikrXLXQ1UgNccQBdUkCJPP+RurMuqjffrGBXDzNeAIiv+QWg
 TKdtoiK1vRl4UPS52LwcB60sC2
X-Google-Smtp-Source: AGHT+IFlPzNCBIfX/lM4gniteRjIR72+zblpwo0ZRDHw88A7ktL8KJOuMKJ7Lvmzlo65EtnVo+1iTg==
X-Received: by 2002:a5d:5f83:0:b0:3e4:f194:2872 with SMTP id
 ffacd0b85a97d-4266e8d7756mr4613241f8f.31.1760004679772; 
 Thu, 09 Oct 2025 03:11:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d629casm76769665e9.16.2025.10.09.03.11.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:11:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] target/hppa: Introduce mo_endian() helper
Date: Thu,  9 Oct 2025 12:10:38 +0200
Message-ID: <20251009101040.18378-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

mo_endian() returns the target endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 92071affe47..6fec63cb433 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -104,6 +104,11 @@ typedef struct DisasContext {
 #define MMU_DISABLED(C)  MMU_IDX_MMU_DISABLED((C)->mmu_idx)
 #endif
 
+static inline MemOp mo_endian(DisasContext *ctx)
+{
+    return MO_TE;
+}
+
 /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
 static int expand_sm_imm(DisasContext *ctx, int val)
 {
@@ -1599,7 +1604,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1618,7 +1623,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1637,7 +1642,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1656,7 +1661,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -3320,7 +3325,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
 
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
-    MemOp mop = MO_TE | MO_ALIGN | a->size;
+    MemOp mop = mo_endian(ctx) | MO_ALIGN | a->size;
     TCGv_i64 dest, ofs;
     TCGv_i64 addr;
 
-- 
2.51.0


