Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23E8CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Muz-0007FE-R5; Thu, 16 Oct 2025 08:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuY-0006dp-8D
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuI-0008ED-CS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so12126625e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616988; x=1761221788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LqIYxi7w289CH6LqefYW5R9jv/7obqdL+LRwzXHSleY=;
 b=wAoT8lDFqKRE+Xu50uCcORyk40pP+KLkUp3CKrfS/LhYqIw5LT79nikN4w6lku9uvd
 XFT/ZrL7IUs0hQhYXdcTtpy5bhS0En5VzdpBeN4HLflMFaysT0EgRmRj/O0oFe23kFXz
 pwi05eQRaBm/1URJCizbMiNhNDQHsPwJKWPD//l36giF/fqc6cgchzPE8TNdWiZzeCb3
 BI4xUOIWiT/ydJ45iGFEiFIHVZsaDkpcRhIoFepiWHKaoblu7k89gAA26lDCrtjMc1O6
 g2f2FruQ+rRqbjTitpuN1wFXwlpVO8tkCoSL5BdK3bj6ChceAPZELBf85S0DP+aWi2En
 ZJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616988; x=1761221788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqIYxi7w289CH6LqefYW5R9jv/7obqdL+LRwzXHSleY=;
 b=tO0EV0dQYoPg+m+beYgMV2x9NVDS/G5Q+qqreWbp7+VdOUX9r43+kTlxI72FWcGfbK
 dw5S76tm7QRONOAoySOALheDzZwIkW0f18CMILLKc1RP8s7CYNyIgt/vxH2mec6Nz0JR
 vb4c6v5pVz4+fBJZTv5wcc6tcIcVAa4TSqJBlX2MfKLTg30fAFDDiOm/GPsS6E3YTVfk
 2rwgwQIKzxVV9llQ1UyYUuUpoXfPIjqTRWRpQ3d24DIDvUgvoFeABkPnM3+ofLX7ZWlN
 w/Hflw1nmTvqmYw5y8Yi0FLYPKnE/7Urj/3Ue+l8Ax7siW9XoEy1sBKVWZeAq05MQ0rJ
 AWTQ==
X-Gm-Message-State: AOJu0YyvYDuX0WHwfvA6TqDPG4w6WHBNeIsJHpFsK7mMsQoDbA0AQil4
 HPbAecKb/LCnR+RX7fgc3nax53ydr1P+sHujl7ZIMVRDxaxKUKqRjOoOER+DAxipTgegH5Tnh7T
 LwCBp070=
X-Gm-Gg: ASbGnct1TBD6BVS6+CYRFF8yUxnvLM9+A4CBNZ61Jnhlobt9BRvoGgU3QR5RBNilMxz
 zdgfkjc9GWGLbbyIL9zEY8n78yfXQ7Ctvt5LunjUL85UV3+fFGr08TpKOOLPZU5LLsv/3rA9F54
 A1avccv+KZQ9A/U05fhx3wmlB+x80eUxqA2Ro2oNmN94bR7HDlDwSuQQjJQGIDeCWL8cjqcGY3P
 Q1Utn0X9lM1vsMcS7Y/Dwp1AVFZivJWEeY2NLaBgLpd/kcaxqAvxl+JUtw1sQMsDpA3rDE7xbzl
 bRewfMesIu4T6WLGaEMVU5OMZ8tT+015vjhSMO290Ig/WTesRGk9kMUqZN0h7N+UBr4ByEGRQx8
 wyH0VnmM9zbBXnA/ciH7O4C5nctn5nuBih7TWsaCCoQR/3ujVfzNoMz0W6qRWnZelRhFGKJbUCL
 o6VyskzBvvt6wPb/HjKCCi/QMZUSlTr2QB/iSjMZH4T102uB/dHwqOiw==
X-Google-Smtp-Source: AGHT+IE1JGkOQWsBQto+jIRLp0Hlbi1ZnT5VyhB7Xid6tBCGYh/uAIn3cJOf9C3SgDhYIfgrl//N2g==
X-Received: by 2002:a05:600c:468b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47109b23dacmr28068605e9.11.1760616987691; 
 Thu, 16 Oct 2025 05:16:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582abcsm34370676f8f.17.2025.10.16.05.16.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/75] target/hppa: Introduce mo_endian() helper
Date: Thu, 16 Oct 2025 14:14:27 +0200
Message-ID: <20251016121532.14042-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-9-philmd@linaro.org>
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


