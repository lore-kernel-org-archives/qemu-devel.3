Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B41C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBk-00028l-E4; Fri, 30 May 2025 08:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBi-00026R-70
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:18 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBg-0001se-EK
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:17 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad88eb71eb5so238387666b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609415; x=1749214215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sEJvWPI5TCKqfdQya4TcjkApCVr/qAdFJO9zgc2Bkok=;
 b=UNANJGr4QCXzOqimMhpi5wNp+6+0Zd/vRm5Gs7uLbIWpv9tIrWsemIu3lluaC2zEQJ
 y2F5t2PIe43OJUsjeWVs+Pd/7Wq35drYOQagBGk8qQwv8KQERHYsqSE6c2qsY3bcchhi
 K15jMdBH3+xwuwAMCHXXmHMam0rHY5m8d30oDvIL3ZKVjfyvsQA5f+o9exW4gCZRSnzc
 ZY6z1DUC2ikDpEdw/rchP0pTL0ylYa/ddbd7+NdW+XFWBy68JpF2mk8hXdIgWdyoCd64
 njwExzIi8dSbIENuLvNkvyHe0nOM9oOg/ZuaTTZeXsIH92eh2i0bJXKaFDCwBL+jCIYX
 438g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609415; x=1749214215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEJvWPI5TCKqfdQya4TcjkApCVr/qAdFJO9zgc2Bkok=;
 b=eI6AhlhWcVEq7OrELkaJTnsU66tXd81/f5dcwkKmNBh2LiIx+GRppbSRn3i7fO+C21
 zP38UHDywh89Hc02bJds5aMbiurLhejcjaX5iyvNylOV3ndnGHkEkWLQ7EKpssNVZrQc
 B0XSA26CK/1YDwWgpfmmHu0k4tLkXZxGVcGCdHDm+4QrUXIoWdxo6DOCofNmgv7hU4bB
 /7XUwj/j8pR+SokBk4Jq/9P7KNHWf7YAHD4ckJq9bUnOCxW1KuUybq26iCrKQTvLRWAY
 4yGdVYyDZlJUVSxZFSU8Xz7uv75A1YAm1JqZ1WDgaAn8WeYXT7zNx3tokYeYy5dYHgza
 8U/Q==
X-Gm-Message-State: AOJu0YxSSDaTk1rWEujjhrEhmeEIXJo9e/PUceAzsqSIIoJYPCvaSkbv
 z0sYUrHpVQdYmubkt6Cxq6Ze25xXmSnr0joJ/55zk2xCIO3glYsFeEJazcGXuR4ByjSqHjt2rKb
 Sh9Zb
X-Gm-Gg: ASbGncshlMuM4pTa/GMBFx7hz6zVvp5lxoD6St63Tt585e9g2C/jbBz04PXtvQIsYLx
 ZvqZ2rh1JK+ElB6mDT7C3REjmnNBl4qFpJ/lUpesjrRxxMARGwlx3FfvtUl+TCbr91O1A/H7auP
 REASMfU6++IyRsjlOkkiuiSU2aYTXdYDbNvkUhF56NathAuXmWNKN/3LDhfSM8L5t0hh8ttSMUJ
 cxMdBy5XZbZSjB/v5kKB2s7EoGEiK8F3gwrq3llObeYjy4L2yw7ao89MAwSc8MdIFxkyk070rSF
 CTU4MRmEpkfCpYYZoE8Tq3GsPu0nUbqx8bGeV9LH4h9ZwVzZP24SkFFeBsNjb7+1Q7ic
X-Google-Smtp-Source: AGHT+IHoMrjzraplVD9gTJygN5VqwcGqagqWOA/21JlE/h8cMGft2DdEOWYAO8DEleoeEOLgt0l7ZA==
X-Received: by 2002:a05:6000:2085:b0:3a4:f9e7:2796 with SMTP id
 ffacd0b85a97d-3a4f9e72999mr1499140f8f.35.1748609404037; 
 Fri, 30 May 2025 05:50:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] target/arm/tcg-stubs: compile file once (system)
Date: Fri, 30 May 2025 13:49:42 +0100
Message-ID: <20250530124953.383687-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250513173928.77376-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index b404fa54863..e568dfb706a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -48,7 +48,7 @@ subdir('hvf')
 if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
 else
-    arm_ss.add(files('tcg-stubs.c'))
+    arm_common_system_ss.add(files('tcg-stubs.c'))
 endif
 
 target_arch += {'arm': arm_ss}
-- 
2.43.0


