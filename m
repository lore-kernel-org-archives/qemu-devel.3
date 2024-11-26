Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F41D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvRz-00013s-1b; Tue, 26 Nov 2024 08:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQz-00007q-Dt
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:54 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQv-0003jH-Sj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:52 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-382376fcc4fso3310627f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732627008; x=1733231808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1ZuRlLkL1yhuLbXRwUvfotEPQVAqZnSZGvAIWOZu34=;
 b=lcnjZ5xRLFoHH7T6rfLlL+gYkEIYyxDTyliyva8wRpZVWoxFwR21yrOv3D/OCayKO0
 SOO9ScM09lwclOfxG2p+T+P4iLj1AT8tcGFF2p2+Kr44UPuIYcuOfyuubOpsz8bL9Pap
 k5jYzYkOPLBupBxzlGGti4gx7DtuYltDTjQGwD1o0srlA6VtwkQpmETrG5gCnDECEHtv
 cx1C/BEC9h2PfZdabronuHS7GjTfux/28fQqeoTWEkrRXTm2DV0LFsH80fZGgV+BPzAn
 pY2U6aT3vkDeum1fhgCHvWeAReDltTNms0p2TER38lh9vk9jLsUs8SFUICcg7moLylKw
 A6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627008; x=1733231808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1ZuRlLkL1yhuLbXRwUvfotEPQVAqZnSZGvAIWOZu34=;
 b=UdgTfCm/6rf6qRVkRSKJw6wD59qgl2e6+tenQtIBeOdsgXAoqx8fK8D8dmcl4GA1bd
 NRwDwxq7kZq+6fAoASCOQhvfbZMigM0omzRhXBBXWIu8BrsGlP3OBtKxmfQLJwZ144HR
 h+cyTUNfk5i/Mu6CBdnkJOcsoughpRhQOiG1nXB1nKwBI3ZCt5X8AqiIHvcbgIaKpZFf
 wdZFCW8Z323fYJ2b/6bpwfbSV5ei9VJQqmLmB/zeJ9VwjKJxYtTQL+K3d5ugo9iniCQq
 WQ5HlRZHrtsW/BjDenahWw5Oq/xqhsol+9OfuaFHuOEt6ccoy9cApS2iJ7yis1jncBOL
 F8sA==
X-Gm-Message-State: AOJu0YzRy1UEvLsl4C0ZAbjFitpP72j9it9cK4EJwZeFbVJ17sEXNqe2
 EW0lFKhKMCck34kz2DRNnULFansjU/wdELxNj2VtFFNFcZmUNRzK4Tl7pXTZlAYOfeyoNPmTX1M
 t
X-Gm-Gg: ASbGncs9ctJK47BviXKTnTVlNuPwpH3l++9oNNiimlUGFYx5tfwDj24ItKish20WsCA
 H+M9UiQghhTbbc5Bic0oQodBU0KztSgf/9HY3BkafxkyPtgNpid8qcFlxDVAfBHtdPh7TOLovty
 QRxQKllUHgljpZRnfvpHDM9nYG83dVRGLsvz7Y8wFtts9PDt0Fz67HXrpx0YsilBZEul2FAy/32
 81eEbECHWVJ0+Ss9DpHjjd92pEZyadKL6Fx7Lgvq4UOyAkMqXd1FHfEgJeAJSCzRZpBAg2t
X-Google-Smtp-Source: AGHT+IE6ksKULJh7jpGq4BUWC/zS4KcPIDru/aoPbuRwEOzLRNzEUVqMedduij6bqfxBdu3W9nUTVA==
X-Received: by 2002:a5d:6dab:0:b0:382:4851:46d8 with SMTP id
 ffacd0b85a97d-38260b4d514mr13103906f8f.8.1732627008100; 
 Tue, 26 Nov 2024 05:16:48 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbed6b5sm13604378f8f.89.2024.11.26.05.16.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 10/13] target/mips: Introduce gen_move_high32_i32()
Date: Tue, 26 Nov 2024 14:15:42 +0100
Message-ID: <20241126131546.66145-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
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

Similarly to the gen_move_high32_tl() helper which sign-extract
the 32-higher bits of a target-wide TCG register, add a helper
to sign-extract from 32-bit TCG registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h | 1 +
 target/mips/tcg/translate.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index d5d74faad92..f974cf29297 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -156,6 +156,7 @@ void gen_base_offset_addr_tl(DisasContext *ctx, TCGv addr, int base, int offset)
 void gen_move_low32_tl(TCGv ret, TCGv_i64 arg);
 void gen_move_low32_i32(TCGv_i32 ret, TCGv_i64 arg);
 void gen_move_high32_tl(TCGv ret, TCGv_i64 arg);
+void gen_move_high32_i32(TCGv_i32 ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
 void gen_load_gpr_i32(TCGv_i32 t, int reg);
 void gen_store_gpr_tl(TCGv t, int reg);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 80e2a8e5256..d6be37d56d3 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1494,6 +1494,11 @@ void gen_move_high32_tl(TCGv ret, TCGv_i64 arg)
 #endif
 }
 
+void gen_move_high32_i32(TCGv_i32 ret, TCGv_i64 arg)
+{
+    tcg_gen_extrh_i64_i32(ret, arg);
+}
+
 bool check_cp0_enabled(DisasContext *ctx)
 {
     if (unlikely(!(ctx->hflags & MIPS_HFLAG_CP0))) {
-- 
2.45.2


