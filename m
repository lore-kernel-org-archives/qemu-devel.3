Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A92AC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEs-00024G-IC; Sun, 04 Feb 2024 16:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEo-000238-9R
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEm-0003W2-Od
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:17 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so30947585ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082875; x=1707687675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ql63af8QTrJWvJEiTJspYZ98jeTo0xtPlbE2bH3uphk=;
 b=gw/nLbpQ+FEkCeqFGK+JPc/TSOtb7pX07V43Wg8pUKDfXXB82il/E0MOiQ0ryc2TBZ
 O1CIlz/KZ607DS2QB4GMBGE/4u/sYAHe2LwQF62zxKcmC8zhqBlImd3ahdoRbJOyggFc
 cS9+koBkMrrHlzzn2m927nfELa4zsKgQ9214czhSKSWcU+ombl04qTe3shwJiXl7bIf9
 2u25N5nmRlBGvqoEsun7Th4D2r+CVbwFpbjLuG+/QPsIqGFdNxnPd75J8DJlljORkwp9
 Bz+EibhHMLDN4Od/0gCmSF6qDpLwdaDMG3NvkMt5k8a/3/zhAv0zIwgF1iYdScX6o9bk
 UUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082875; x=1707687675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ql63af8QTrJWvJEiTJspYZ98jeTo0xtPlbE2bH3uphk=;
 b=BY37e/M0Ki33yHdhzRPljg1yYCnuE7esd0h8T3+5UfQdpcmYLKosCG86yuGe6GgHkB
 oyNquHht/osI2WEoV6D8vSCx79KrdlWfgwXOH4oUveTIg/K8v6IHuk6TeuOh9ycpfnJ6
 sD6+vc4/nN5IpnNyL48k7jqCeqGm0Zfmrk+IwLiIAstgGbs9ha8NkjmnoWBQzT5Ly2Iy
 XQWiVAV/EDIjFNWl1o8jnEGThHMYhvIYwMAFZPoqSkX7m9ifdaQP1JCz9E9YRv9tFvpX
 DdkDaZnoPSy2DfolisD/z/F2nxpcnAyIuCDE5VBv6pqWzX19sl7ds5XV/w/RLGaiS4is
 Ngwg==
X-Gm-Message-State: AOJu0YwxPlP8+64uvzV9vNk+YYR7pzy4PUOmJXTc8V/ZHl//Y7ALzrUd
 jCaG0b1+ESHMdUzakNv4A4Ma+MT82bG4TsX9HlOVrVfQWL5OBYZp1o76T97nvXSDR8oUXg94Qsa
 5IHU=
X-Google-Smtp-Source: AGHT+IEEf5u/9NcD0Fp8CCqU4OKxh9eCmcAKSrLVCrxMdIWU0KGArbw/Pzx4p1xtcOAooEq+WcR47A==
X-Received: by 2002:a17:902:8602:b0:1d3:45c8:bc0f with SMTP id
 f2-20020a170902860200b001d345c8bc0fmr10970356plo.46.1707082875496; 
 Sun, 04 Feb 2024 13:41:15 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/39] target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
Date: Mon,  5 Feb 2024 07:40:22 +1000
Message-Id: <20240204214052.5639-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231108205247.83234-2-philmd@linaro.org>
---
 target/alpha/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index e9cb623277..566adc4cd6 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -482,10 +482,10 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-                               int32_t disp, int mask)
+                               int32_t disp)
 {
     return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
-                              mask, disp);
+                              is_tst_cond(cond), disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -2820,35 +2820,35 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         break;
     case 0x38:
         /* BLBC */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTEQ, ra, disp21);
         break;
     case 0x39:
         /* BEQ */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21);
         break;
     case 0x3A:
         /* BLT */
-        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21);
         break;
     case 0x3B:
         /* BLE */
-        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21);
         break;
     case 0x3C:
         /* BLBS */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTNE, ra, disp21);
         break;
     case 0x3D:
         /* BNE */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21);
         break;
     case 0x3E:
         /* BGE */
-        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21);
         break;
     case 0x3F:
         /* BGT */
-        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21);
         break;
     invalid_opc:
         ret = gen_invalid(ctx);
-- 
2.34.1


