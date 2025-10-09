Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252C9CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ncK-0005tB-IT; Thu, 09 Oct 2025 06:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncG-0005o8-Ag
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncD-0007DP-Rw
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so7871305e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004675; x=1760609475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71+43E8vPDruuCBmrWgsYutOefPlp2RgYKsp/BbBfak=;
 b=sOR+8NKtIxNTFOWmmPycekmMFwTNZiy5cetqyd/Nf4DUZNUPXql/93lxQCum/E4E3Z
 kYv6TngLboCPxQJOjNM6kBIEuADusH89Uwr8Go6gtLaCAVn09VHH7oT2gnFhRFTzKmra
 JJ/byNzY9lIc3Vti3hUGYLixNErBbAdpGKF+VHhGgMtpMzi1beJJ/+WoWEaKQNDmljpA
 OT0ZRwIQKWv12sHQxHGKD3t/ueBBRHIn/S2bIOrE90Dw6f/3KQiqxQosqpPl+zPVbFP6
 rObgFXiIeMsKeDGwhNg6mPIrjlW7vxjR4Mrv6QCiWw+7med8nU7nJt/lQmbQZNZi4azc
 cjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004675; x=1760609475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71+43E8vPDruuCBmrWgsYutOefPlp2RgYKsp/BbBfak=;
 b=bT7hz7UwX74/UdD2l+QmoCfkC2mmqWRuI1wp9VbH5jwstPOltg/4IKOKytgI+DXYff
 R+mAjDeIB65Iek5PdjpHe7/g5SkRkTlIbU2rCfYZWmEq48WZk7FuJ+tZqNLRcPnAE1bT
 EFdkXGmkL52weOtCwCI6he+RXpuReqFMyuKZD+KVZ4pwZQRlzJl1ffN5eZIr0FmjQLvD
 /EdUYoIq5UzsFh0v28w27sz5Q2tXjoYfNSkWj1LDnFhuQnQaQrnhVtr/F/BATV8V0Aqn
 V/lG9RjN36p31crDwsp2zwfCiqJxBAN68vljmzIxQHd/wDyVGBE8uCOmMe426jAlhmCp
 T9lw==
X-Gm-Message-State: AOJu0YzO0hxI0xO6C0TZTskWjZ7WR+r9aigw5wC/KVMLsQuEONz9KiUa
 UNkmlhiaWQDT9ICMyiYvxmUI19N35/YcgcUsEHy3zjhK2j5RC9nePrmd1w3nIn4fEgtBEjKTSpq
 J6aLAd4J4uw==
X-Gm-Gg: ASbGncuJIq2q+EsdT9Rw8TKG3dkhJNCPgfa4sHXvSYAM9GrGVrhHuzVVmoXaokFIRsh
 Lv7iwWt5xvJFBkLeewMrhf3Okqma2DxT4mRdP7zux46egg2cQ8mTmm2G9/keYhfpTPHH4VsA5Uu
 aQ0xRVgHf6/gVe+X1v+sMLtckhBzIOf+WwH9nqT8ZTmiocKmAnV1PQLZsoUR8qpjSSPpFxNCrHT
 R6Aj9/nItYHSRa+BBcwt5IDhLGMyn8+46ORu7Shu8vNzTj+T+V+TJBZdBtqEPwE1WAlIXocETZt
 P7lP/35z4v9gxr8TCzRcyfjb8Oxraatun3NSuV0itGqgM/nfspCIvaGW57uMIeowUCHRsHJj+if
 vdfS4t3dwyq0eqsRVwtMjeak0y2QgNi8iw0obQ4nPQrX/yNZ0440VIt0FGEu+Y9hMaNYySa6RdP
 ut2V7RqHVykj3uJNSLm5nbcqyR
X-Google-Smtp-Source: AGHT+IHuZ1++aNKQsL2CiLCGn0byh036tTKqH+w1wFTYf/rnoUEaSwyTDxh4SCjzjYkq6I3EVxvHAA==
X-Received: by 2002:a05:600d:634d:b0:46e:1f92:49aa with SMTP id
 5b1f17b1804b1-46fab65d93cmr28645845e9.15.1760004674999; 
 Thu, 09 Oct 2025 03:11:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab64aed8sm32751775e9.10.2025.10.09.03.11.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:11:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] target/hppa: Conceal MO_TE within do_store_32/64()
Date: Thu,  9 Oct 2025 12:10:37 +0200
Message-ID: <20251009101040.18378-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3f78bb2a76a..92071affe47 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1637,6 +1637,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1655,6 +1656,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1739,7 +1741,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
                      int modify, MemOp mop)
 {
     nullify_over(ctx);
-    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, MO_TE | mop);
+    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
     return nullify_end(ctx);
 }
 
@@ -1752,7 +1754,7 @@ static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frw_i32(rt);
-    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
+    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
 
     return nullify_end(ctx);
 }
@@ -1772,7 +1774,7 @@ static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frd(rt);
-    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
+    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
 
     return nullify_end(ctx);
 }
-- 
2.51.0


