Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F24CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9m-0006V4-0q; Wed, 29 Apr 2026 20:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9X-0006Ni-6e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:18 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9V-0006GU-Mz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:14 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-83177129e28so162064b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508472; x=1778113272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0cgKbjERVeOkuhp8HI+EMvkfqkw4Lr29AuXT6VGnEc=;
 b=QEz8GXYDdgp1IuaJwORM5NG/vMpjKZxYI31hros+zeerOdRYf7ApJPhxIFm6T8sNl+
 eAuyPOZifX0xGBba3DRqp/GyMQBRFwpMj3rhO4Cex+mIiJD+8gSkwCTv21z5V5rSXGT8
 crXmklM8tL+p/d5dbToRwslYXPE0vluGUJFJQ1e5NQNQiPo3HcZ3oeI6iowiiBb7mavs
 hynlYtk7B7FoKruBEkGnG0jyAjkk6yO106BtN+dJ+LhEzxCnd1ElciphbtL5zHCCk8uk
 OaxQdmVrxYFNxhKCcMgcStY7eVcgLUe4qOojLHT+Qm1exT3fx5pAdgJEXdOaX6qccI6E
 yZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508472; x=1778113272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e0cgKbjERVeOkuhp8HI+EMvkfqkw4Lr29AuXT6VGnEc=;
 b=rAyNJpwNlMsNWm+XfE/tCd18XqRLyPs3+G2IQo7a36DyaZXebp6uYCMI0tINjlfVyk
 EBMgmB0fuwBVCp+ktiyByTkeJIRRyQdiwgwnewjBgFF7gH2Ihkl87iM6r3Qgv4zgsR7E
 kMaPhc9f1eVRJT+1t34zrDbkga3VSeNcoQzf9olnUqWy2Oi2/L8u0Mxm1qAoVJlkxa7B
 P19O759TsLXmOK6x4CvfxltPh48aV0pSXMNV4m0N5uJezmEum/fPoaCCRU6oWFLMkGeP
 hMaLHZfFtQtSVdqlg3ZLobPDZpwKgU33+icMTnOwPxDGXPIahItFmiz1kcK+q0Rjw679
 mAqA==
X-Gm-Message-State: AOJu0YxJy1ZUYsUusW1PSShm45ZGLuApX02y3JUohOwcggU3Al66x3/9
 MPiVzN5eHFDFCaqM2qgwIPw+HHae40YciFlmpPxTBeS7uLxq84ja9KHZRT3Bjw20O1/QjkVUOrK
 3DrQr5wI=
X-Gm-Gg: AeBDievY+5dAQSKSe8/cJwmAXaZtcVnUfNVdadANA+mT9mw6CUx65/Yheqztygv3xMQ
 VQLcWZ//0pRcop4TlzBxp1IEDrPlF2ftMNkC6GVqisqH+Ot5AcmRv/0WDHawgbvvNOJn7h8DqL3
 1KJ1Q/7b7t1QqEP2oWwYkNS65X4niKq2Hcfm/bm9R5RIw/yGY28xEbotQ1HQjaSDpqVDmsnYt6n
 pJqlRUYSYO6Q/z4ZutvqFt6i/FgbXqJjqU34k2ptiy80tlBf8wqLKObUv9VU49SbB0E9cOf62b7
 2IcWVpKu9ZEb2Lp40xMphkfrD/7Rn+Cb72q1+NBkiEjdlzzcTa2EgllqJ55WzhxEXJmVIrYxwiw
 akwBmYgcF7JIpfMYu2BAclETNQMFKN9FO3UGje/UL3MtymgZumsWFJP5Z9bSRtA0g2Mpf6EP1/g
 z+UVhs07oaTpxbZH+Y+k9rUS2kz3zMKiVGR/Xmr68B
X-Received: by 2002:a05:6a00:1c85:b0:82f:74dc:5f48 with SMTP id
 d2e1a72fcca58-834fdb58909mr844546b3a.2.1777508472103; 
 Wed, 29 Apr 2026 17:21:12 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 09/47] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Thu, 30 Apr 2026 10:20:08 +1000
Message-ID: <20260430002046.59739-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1a55275e80..25cae59878 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1461,6 +1461,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


