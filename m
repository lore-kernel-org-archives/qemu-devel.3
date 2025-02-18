Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80349C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkRKj-0004Xr-CX; Tue, 18 Feb 2025 12:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tkRKg-0004Wu-WA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:24:31 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tkRKf-00080d-EU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:24:30 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220d39a5627so85176985ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 09:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739899468; x=1740504268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3K22+YVskyblSXAB4oUB8qk58s8rMjdxRxPhzIex0rc=;
 b=Pw/LkEpZQcMjsnX4wtbx/ODYz3r1mUn7+h9UW40QdmQQG+Qm4QgbnkRQN+hSx7AI9K
 nLhg7tn6u+PxKcxsNDPMK7M/wYcDT5n4e1mvVJRjFypHqE1CjF1Nza+wy+NecgtECDmi
 Lje+OkMOM1GFOhgXsNT5hKMYn9f7N2Bk8I72UgPV2PaxeqhUsfl1jfUE9HEBEoyg+sAh
 O2Q9cfJa9p+WVW3vE5buVgfahOQubqzWruV+SiZ3cV4zU2SEeqrP7IrW3sBdpooevtww
 nlZWXD2soZ8A/bn9IlZSB7VnIWFgYg0aIaK5t0P+PpovK3U30whKzvLcX7FC2IpUy2An
 ZvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739899468; x=1740504268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3K22+YVskyblSXAB4oUB8qk58s8rMjdxRxPhzIex0rc=;
 b=jWqVoQX8V2wLUydfNw8nnwv+q1WC+2Gb7Udzx+gCeilRyFkaHI3Czc9BIincJYTQi+
 zUS4HQsVCqIFnFVooPwBTT/3RQ+JpUpskoA5TQ/zIDljOoUUn3Z+lvaOQNjuDDwAbuWA
 dvuJAr4e4Qyvb3V1aUeXbcrzavBRJ44jkP9drvceOL+k7eP4yQPzOo8q36g6xQO4J877
 VuCHowAMccc4zUUgSC4LduJDdK6qH17u4WutfC4xR9MYu9CyKxKolNuNSUnWh4UEqCkA
 99Ms71u/mb8amL539qdugxinBzE1Xo8NsDHs2WGoWOg4FuKAs4hhCJf1z85qtNej6l0V
 NPCA==
X-Gm-Message-State: AOJu0Yyzk1SnRF7tLraCer2qJY8/hj5f1sCnb097QdXYc96+QcLMkNf+
 7jODYQY6KiZ4GXybD0kPL5ksfzNCdhNiPyA3vYHW6vDaUmTMCBe+NyktFHT1YbWFRriz4Rps/Q2
 +
X-Gm-Gg: ASbGncuKamNcy6Nb1SKccCboHZnYv/rXbO6cnXRTWu6c93P/C0w74pJeFOv/vGQuyQx
 GuaYwj2eolsEYIcRt6yTHaj7Ddv1nLnbOmY4h6XOV3TIcujYchWsQ99gFedRvZZaK+T2Czc9j7v
 d9Kb2DQ26KlYI2jaxAAAgHDFEmHeL5mRy8dMznUutfZjux5z9cKe3mpIQH3DuSzmkwaQNcAbH1X
 c+yjL85rz48dtNEsw9w0NJ8o9tk1WP4E3TgvWIc06P+7XilhIH2DDXP+I/YQVPPInJwb7XpvwJY
 GDfKRlxw/PVUyDIyQ5LtP8DI1Q+0JXEfYf8AKoxlbExNvqM=
X-Google-Smtp-Source: AGHT+IFSXeZTLwdIYFr69OeMH/Bgq0wYtit3BMaUKxMXaf5EXNPTz9DrTt9hz5RU1PL/O/v/A0+k3g==
X-Received: by 2002:a05:6a00:3d04:b0:728:e906:e45a with SMTP id
 d2e1a72fcca58-73261958231mr21956982b3a.24.1739899468036; 
 Tue, 18 Feb 2025 09:24:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73261a0c0b8sm7015981b3a.164.2025.02.18.09.24.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 09:24:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 13/28] target/mips: Use VADDR_PRIx for logging pc_next
Date: Tue, 18 Feb 2025 09:24:26 -0800
Message-ID: <20250218172426.81706-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218172426.81706-1-richard.henderson@linaro.org>
References: <20250218172426.81706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

DisasContextBase.pc_next has type vaddr; use the correct log format.

Fixes: 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase for virtual addresses")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e25c4cbaa0..d9eb43716e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -18,8 +18,8 @@ static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
     TCGv p;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
-                  TARGET_FMT_lx "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%" VADDR_PRIx "\n",
+                  ctx->base.pc_next);
         generate_exception_end(ctx, EXCP_RI);
         return true;
     }
-- 
2.43.0


