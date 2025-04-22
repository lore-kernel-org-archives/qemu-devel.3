Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1223C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSg-0004zr-2n; Tue, 22 Apr 2025 15:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSI-0004BX-9u
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSF-0007MP-Po
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c33e5013aso64932285ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350730; x=1745955530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LpPYWP0OXO9mhIHJpVptIpUQyJvCDi5tzk8x0yv51A=;
 b=mjeM/Ze6QgoZJfG75IlyA7Tu8+u4H2MNN07WTB2ZfTOIfjABCGgIiRwgj30XZW1acB
 UnxVDTBB/ZIKu3h5tCVuo1y1PMIV6JhD4KdEchPSqMNaseWH/eVvkHMRsDiaEyZj3gsy
 6MN22xkScFE0rdHt6WxNDpQxY1c+3Q5VWmCP8FJWHUt4S++nA+bwYXxbKZXqB5UzUth0
 lRMGk1ERx/IHyAK13mHyBbihU0wWpmAULTJFDOx9cML2FbhtBvz8lYR2SpqxNsYeyAJS
 JKE2Qrm9GRYL24MVXkDGxMvTyKbeCUC2Oxn+hBzbmV33pTmbtZASG4lVtXdZh6dc9y7P
 rKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350730; x=1745955530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LpPYWP0OXO9mhIHJpVptIpUQyJvCDi5tzk8x0yv51A=;
 b=CpwPe2xYhEbXnyxLBErPZUv0L1L/34PLU083LJaByO3aK/PBXusKpE3FzduoAr0JTa
 VNKqDfeInC1pFnNSl59DIITOlEHgOtCzyd0USgD7Q6nDdqeKBCtC0VCj6GmqozKrHjfk
 De5VUQT3fG885ZPom5JeLtMnKNZwMU6NhqJmhJZHgworrAZno38FHEEinkpKX7niCCZl
 KZ8sfo3emhydJlgMrkOj5bnsdjN2tHh/QPsFzu+aG4SsK7a6q9ufhQ0dpMww+XASTnmn
 M3SC/ZJDa4cDiWfDlguTwX8VNzSn5Q5SctqOsmjM71VcALYSBidEVpAy7QNOMfM9Qc/6
 T6hQ==
X-Gm-Message-State: AOJu0YyarxOIOdvkk7eV/jcgiQfKru7PNd4bbteHE3eJ17iIlCmfYR2+
 EpTcyp421fLSLgwCgrxn13qp7OtbEUdQFOA7trqHejiDJDAul7D2Ma876vo/65XgFxc93CFARtt
 3
X-Gm-Gg: ASbGncuEMkTnPt8XEj08OybkzP+ZCSu4JeMx8A6hEvWKklv2HUUzT+kES+qQYLW77xr
 5NPlTpdakgWUDv2VUewxFwYpPRBuRL+FrHlZCSniTZPZ55z2at5JH34np0zrNtxECjSRrsKWGmJ
 bwrD+f/8kudBX/qqbA4smf3aJrVIegq30AK6RNIcBZP6n0EFJyvySqidXev2hpBopzBbAQ9dfcq
 V/xjLJkp9gudw5yUsyUsuavqmVVrA79ZF6JA7HLNIO//vVN89Y9nPAbOWhfLm/zkixp8x6Lhoyw
 Bv43d7Op7OLA5csHwiBh6DoK2699zmXGR95mgTiRu4m0HxS/QW/3O5dhKGgyidP8U27rOODGLQo
 =
X-Google-Smtp-Source: AGHT+IERtPUt19GuUOJU/foN4O88aJ+QXrXgEGn59dFcl9N8fGpBpUtYtHHuwUWh5ieD/GJz3DtXPg==
X-Received: by 2002:a17:902:e74f:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-22c5360de0amr266686055ad.32.1745350730228; 
 Tue, 22 Apr 2025 12:38:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 135/147] tcg: Remove use of TCG_GUEST_DEFAULT_MO in
 tb_gen_code()
Date: Tue, 22 Apr 2025 12:28:04 -0700
Message-ID: <20250422192819.302784-136-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use TCGCPUOps::guest_default_memory_order to set TCGContext::guest_mo.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7467255f6e..c007b9a190 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -353,7 +353,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.43.0


