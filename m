Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548A6FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUT-0007ZS-9R; Mon, 27 Apr 2026 08:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BL-QY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-0005jc-Jr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso109082875e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294103; x=1777898903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NoxPWYjE0P+COs6BRPCbb0INkdJMc1oijSaje5EH4RU=;
 b=WqZVej4KxX2UCWdTucGEqdpXMUz209N1eIayFVoSUPsS88+P7Pc9acG29+5jzTUMtD
 0XYKDMwMfLhycYQcIB5IPnYTw8NuPcZXTNH1q/NVdJt7eF0Q1AmWq8t7btzl7G7Xx84c
 dbgl20NC89a5lD4ddWr5RfCdVF/NLCXJWBuNKNtctCK6MEiKsbFrYW0eUUQ5TaAWyfM/
 Yb+jBbroW6pPfCpuLieKLsfxamvJrqAs2uhYGOKncUKbjw8T2g+xrul6a0LrayPt6Yzi
 ZP4Y/NIs2xqh0wZhRLYLl3a09gOCwlIqvrsMCN5nPaQMe1XIS4nBqxSlktaE8E1uQ8iE
 rqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294103; x=1777898903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NoxPWYjE0P+COs6BRPCbb0INkdJMc1oijSaje5EH4RU=;
 b=LV307wImKHW3K2wSmp9acedSVs8q2hjJnCXcSI00I+mixVdumnJZq7n+xz/z9SBCZK
 m5PlAmDrARCWkUjtSXPbdF1MjDkx5+Whpm1VZFXS5rmtwesxdPxwhhPHbbL3Ocrxm0ap
 +R1gsDIPtzkrooV/nSeSiAJoLINZQATtx9G6AuRkZDR5v6g1Gr+uhDsIQqC3ISJbxt5s
 Gb75lTMWZb8e47zc6VgQ5kd2mF8xuU5/QLWt9S3QIdzZKUUQ1lI5Jv/sY5m70L/bNnCe
 oNqscyyLztNku8FuhPEfBeqAFHRFNbCgPO5Pwd/DzdS7T7zOpq0KtSVKJ7Mi8ijnNERH
 3kSA==
X-Gm-Message-State: AOJu0Yxxu89K/cUwOpT8FYItleO+0fGP6qRqUNUJYEu8r5V20nqiHX/a
 zc6IySZG0wKmlw3qwrgwI9otLTLmzWaCl9z/eMd0RKBFPM0djVE0k8Ek30/qHDsOE9U+NcKlH2w
 TqzCh
X-Gm-Gg: AeBDiesrBjU3z1aYaPu2fF+6DQeqguHpVHPp8wmdsv0hlBzrxGbzEgMkKZ42RiJ2Q32
 nKeFQkRnGY4Wxzzphk/exAOKA51k13BtiKJo7AyJlKD0uMjVfFosk42iNswzvGcFESGBGGfxvM4
 LtX5QWP+g7LCZ7BB0yBl3ChAy8u1VSVhEePSgCamCa7ZyGzqXDVr2nVStnjglZ9OP7/59u+UM3Z
 EpTsrWLSavzQh8O/DHvoOWcOtaDgAmGlwaOEnkheQu9Kh9o2qgTjgcsm3tablQrnzQrkTSAiG0F
 RVJDD9JRNqDpq0zX2Y1AH3PNRderP7nNwXf3VzIN2NznDAxTqznsdqtxU5xVbDpNcqh+IlRgcWp
 QWcVtwqj4yjdiRnCLC9w6UcjV0jt/Lv2Wka0+Ux3FdVkPuMzoNos7jQXJre+qiyQmNqHwWfU9y8
 vFPx7qDS0UbzgXjw3slRpFROum3QFwe9IVVXRtabZwF28J++TsUhQvdy2DQSeyoGcJ7nlMdCe7p
 fWbMlp38aR2ZMgRoFNebHdR1EUKV/0T+B3D43g5PA==
X-Received: by 2002:a05:600c:8b8a:b0:489:149a:f9e7 with SMTP id
 5b1f17b1804b1-489149afa2bmr547774675e9.27.1777294102843; 
 Mon, 27 Apr 2026 05:48:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/63] target/arm: migrate BTI trap syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:21 +0100
Message-ID: <20260427124738.966578-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-8-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index fd8639d4f0..52a6745cb2 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -426,9 +426,18 @@ static inline uint32_t syn_pactrap(void)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a Branch Target Identification
+ * instruction.
+ */
+FIELD(BTI_ISS, BTYPE, 0, 2)
+
 static inline uint32_t syn_btitrap(int btype)
 {
-    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
+    uint32_t res = syn_set_ec(0, EC_BTITRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, BTI_ISS, BTYPE, btype);
+    return res;
 }
 
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
-- 
2.43.0


