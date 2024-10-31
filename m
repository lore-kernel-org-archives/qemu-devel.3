Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416B7E68958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mhg-0006qd-SF; Thu, 31 Oct 2024 00:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mhc-0006in-4h
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:32 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mha-0006rS-GT
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:31 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so7304051fa.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348548; x=1730953348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMGxpn8Fe7mTj/qWvu1FAZjbLfiL4gHv/dM/0NNZ6VM=;
 b=TIuvswHA9OrgdujY36XoOGH3Vy3xhr/Ymp0gBHxQK1oL843znj5rHx/Z8+3cLG2sCt
 tFCl7OLYiiTO/Mr1+WOr8EOgXIGqRxGc8B2Y05lAzyil71FEQWe9EnlwjRnVu3aKJlNB
 rr/O5KIIX/jL1MUsXEzscHIMCJRLVTBJe8Rh2pIOVHqo+AvKz3ydTHMojgqpxLcBEVQ5
 sdfV3RGuqAtjrL9MyMfcK/7aj9IvUBchxfgrKj3z6kUSekb92dmrCGcMGhkjGmx7K9uQ
 pmrQfT4/7eJGwT9y6Su5YFXJcRBXefl2OW4kAxBCtqeMNrodf46Wj1QLEIsu4bjuDh45
 UZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348548; x=1730953348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMGxpn8Fe7mTj/qWvu1FAZjbLfiL4gHv/dM/0NNZ6VM=;
 b=oCnr7doufs0v6EGUlGnyVa6IfUU1pI02zbieYwR6B7c/tf5uMnll+WiANBHzQvpfwi
 Ow0+hvCFIOMiDTS6rQHixcenBWZvUbhKtT3Ap0RpyrzhTSLZdU4S/H/GBY26TjAzaPPJ
 F2oRBxFDHBObqcB90Q8YwNf7dlcw7PNdVRwWxTUE4oZNcZ/PBLt9M/77Eg7RFkVctI1e
 ii3ynNfB1gBaWdbjPt0osy9ozqTYL10hhlv9sW1XHzkuusFWQLgmULp/NlNtfeyeolku
 9B7W/s0lJZDp6mCjAn8RIYO2YKiGv4wl8RGTgz/CLgc1W9FhI5u6jQ5rcMggy94oQch4
 eUSw==
X-Gm-Message-State: AOJu0YzMGvDWb4eOBINVuixbuGzamWiW5o7CSvXEAohrq93rt4NM+0Rz
 ke0N2Du1TdYxgvloYai5Hy6Mi9lL5LLZQH8Z6LtPKbMl8kQj5ORJY0L4Ko1my4mjvi4MTxZb8Iy
 w
X-Google-Smtp-Source: AGHT+IHml7PnlzY70ROiQDm8q6GpTmp5IllcCLur2HKBKpWKRv8G9ePHzBOEQEuvxm3P3it5eE7oSg==
X-Received: by 2002:a2e:b8c9:0:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2fcbe0646e6mr149162631fa.28.1730348548194; 
 Wed, 30 Oct 2024 21:22:28 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef8a62d6sm965961fa.86.2024.10.30.21.22.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:22:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/14] target/mips: Extract decode_64bit_enabled() helper
Date: Thu, 31 Oct 2024 01:21:19 -0300
Message-ID: <20241031042130.98450-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Extract the decode_64bit_enabled() helper which detects
whether CPUs can run 64-bit instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241026175349.84523-2-philmd@linaro.org>
---
 target/mips/tcg/translate.h | 2 ++
 target/mips/tcg/translate.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 5d196e69ac4..ae6c25aa0c4 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -217,6 +217,8 @@ void msa_translate_init(void);
 void mxu_translate_init(void);
 bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 
+bool decode_64bit_enabled(DisasContext *ctx);
+
 /* decodetree generated */
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index d92fc418edd..6c881af5618 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1645,13 +1645,18 @@ static inline void check_ps(DisasContext *ctx)
     check_cp1_64bitmode(ctx);
 }
 
+bool decode_64bit_enabled(DisasContext *ctx)
+{
+    return ctx->hflags & MIPS_HFLAG_64;
+}
+
 /*
  * This code generates a "reserved instruction" exception if cpu is not
  * 64-bit or 64-bit instructions are not enabled.
  */
 void check_mips_64(DisasContext *ctx)
 {
-    if (unlikely((TARGET_LONG_BITS != 64) || !(ctx->hflags & MIPS_HFLAG_64))) {
+    if (unlikely((TARGET_LONG_BITS != 64) || !decode_64bit_enabled(ctx))) {
         gen_reserved_instruction(ctx);
     }
 }
-- 
2.45.2


