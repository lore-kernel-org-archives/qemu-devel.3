Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB4ACF885B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swotQ-0007rM-2G; Fri, 04 Oct 2024 16:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swotN-0007qu-Lk
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:27:13 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swotK-0007tA-Vz
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:27:12 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53959a88668so3320405e87.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728073629; x=1728678429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUsPeVexK7asij6TfYF+Aiq2DyuAOkGHn9+wVeNiNpk=;
 b=xOtzEeFHtubyncTFlXlVPCgcXzBTW0U4H16rf9mqrLFaAsOcTa3vWToECp9ZBOg4MG
 LqX544g+xY0IUWN8AGhdrjqEYSmSeemCLuxzpF+3ObO/RTAWc2wpNowhVGYVpdmKRi0r
 YhA5Jez4cZpdcppJv0KxbapABeC7we07VYz58xr3htCKIIq89cVJZGWGc1RiLEvwven3
 evde6TbjRM4Te/3yIFzDrAOaI5G5IgK9F1UopItFaAOI1roDS2qy+Acbn6Qa5VJwVY2U
 hCdO7u7TYPPXoCiYJXG2Wu7PosbYnXNCERFXVtEyke2Et3LFGKobuglS+GuAxI6Z4ER+
 GXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728073629; x=1728678429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FUsPeVexK7asij6TfYF+Aiq2DyuAOkGHn9+wVeNiNpk=;
 b=cGnPxaSXk+oxbtpdwQpqrj8uwSo5kQ5TO6ogqlKNOARcyLrgofcpLVT13A9jbUapa5
 w1OmD4NAR7KxHDyhKT8SebYveBmZR2y2AQT1vaxFby2cd6WzhODX+JnhwZZi3oEio/fR
 +XgP9Uj2Vu6XFTmwX5tULGqSCT7pJHxyHruzE/xAlze9UDbb4mqltWextI8DqL2wj4v6
 2ldIPzI05lIEahKlrDPeFQhOewkUHyR2JwILSGY3Rut4kSiUp0W8tKpgHovKXv3Lm/+g
 VITR2dR0wYVPae5twYAA8OqeR3eAKhMHkbt0lwfhbh0WIi0FMXhUOJLEwx3dnvthiReQ
 TwYA==
X-Gm-Message-State: AOJu0YwMhX4xHuEWyqsE8eiZ34DBtrW/CEVecBp/8PuthVMoEZCC2VV+
 rasgnooj8IwRVHQb6//brQ7llj2Px8U9UQMAeowZ4KjIU8PahzlqXVHwlwBsFZzoxlFh9OOMM77
 9RqnfMA==
X-Google-Smtp-Source: AGHT+IEyJjbCt+orkucSr2CP88ORt2E284bOK1nK4ihn0otiOKjYfJXHNhmnAsA+WFBH+apa4TG+0Q==
X-Received: by 2002:a05:6512:2821:b0:52c:d753:2829 with SMTP id
 2adb3069b0e04-539ab8778aemr2814936e87.19.1728073628795; 
 Fri, 04 Oct 2024 13:27:08 -0700 (PDT)
Received: from localhost.localdomain ([91.209.212.135])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff1d277sm49688e87.155.2024.10.04.13.27.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 13:27:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] target/ppc: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
Date: Fri,  4 Oct 2024 17:26:21 -0300
Message-ID: <20241004202621.4321-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004202621.4321-1-philmd@linaro.org>
References: <20241004202621.4321-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Directly use tcg_constant_tl() for constant integer,
this save a call to tcg_gen_movi_tl() and a temp register.

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/translate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 71513ba9646..7689b2ac2e1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1588,16 +1588,13 @@ static opc_handler_t invalid_handler = {
 static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
 {
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
     TCGv_i32 t = tcg_temp_new_i32();
 
-    tcg_gen_movi_tl(t0, CRF_EQ);
-    tcg_gen_movi_tl(t1, CRF_LT);
     tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU),
-                       t0, arg0, arg1, t1, t0);
-    tcg_gen_movi_tl(t1, CRF_GT);
+                       t0, arg0, arg1,
+                       tcg_constant_tl(CRF_LT), tcg_constant_tl(CRF_EQ));
     tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU),
-                       t0, arg0, arg1, t1, t0);
+                       t0, arg0, arg1, tcg_constant_tl(CRF_GT), t0);
 
     tcg_gen_trunc_tl_i32(t, t0);
     tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
@@ -2974,8 +2971,8 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
 
     /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
-    tcg_gen_movi_tl(u, 1 << (memop_size(memop) * 8 - 1));
-    tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t, u);
+    tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t,
+                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
 }
 
 static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
-- 
2.45.2


