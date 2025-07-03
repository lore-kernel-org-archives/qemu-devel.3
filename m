Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E2C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiU-0003qB-Dg; Thu, 03 Jul 2025 07:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfc-0006iz-AN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHf5-0003T7-T0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso5602820f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540365; x=1752145165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZapE+BsIWKP1uR9SD9UqThOOP5DO0oP7K7FrxAXgmYg=;
 b=W8Lsx3Fec7wzAalHKV/6oEIsLIMAl5hLA9mhlKqdB1ayg5OvfQ5JDu1Y46q9TJjtGZ
 SC1gxBpMmXZ/FQNduXMluLyIpnARzGKbGWGRmoCSbvbUsMLfYNvQ3alv6RMSacrU5FKD
 nQm9vGyDdUtMMZAXTQ/lLEqyh+uiIsBcLFXYilwG9XpH7zBCOehr8BoMzGoy+eURXT7V
 cGbzhE1gGc7axdeno4gLoOlWYdv7VsoHvoIOxQ2Esr6w9Le70LryfVeGS+S5OI2apPLO
 kZKy4TZpRIixkcdAmvoSYYomOpoPGOsOUJYQ7c7wyPyzetYeggXVIVou+zwDX4Kn5h01
 L3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540365; x=1752145165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZapE+BsIWKP1uR9SD9UqThOOP5DO0oP7K7FrxAXgmYg=;
 b=CfwaCWq3z0GBCwCqbgBd2dEkpK3ambR+OQ3QZKXpu9kuZ7Mu7m8h362MdH1feo+gql
 SoRmjJ8GPL9quds+Xb3a6kx24oaiizm4IEsAwflipHhtd4UlOV29QPMqFN5+uUwgAlG9
 8k9vE6YrRz789DJImDeNWMcL+z3F1vSeRwMhsA1FmVS94Zhm20lsk+W5JHgwiOuw2cfu
 ruTgM13V025UOWTrKiABvKbQ+0BRVQ9FqvIjZuIkVF/xxSr2urqMTxTniZurowpo+xaE
 UGmCNIAYueWrmzRN9qnwp/TOB/YHMTT3o55Ndzl16kYotniuL4EsvhXRZWBrv3tPTo4t
 EDrg==
X-Gm-Message-State: AOJu0YxhbfuUbTtUO8ASS7HQrxS5YuDJGvF368DR7vC2nswRy2XS8gUX
 IQ13f8zYvLKWW4NE1JcZkbUgVbgwXMV3KgUai0MlrWT7LMujUxCZyoMIMZIfjtD9ZlwOKx2uhYL
 dPasMOHg=
X-Gm-Gg: ASbGncspRmMk1f5+fC6YUyqYEBS/IHwVqQP7j12XCVZeJOxPP7965vK1boxAu+Hhud1
 gD8p3bPHTVPrXYbGuPcw/AL41fIrbTckOOKknd3yYCZdN1RVe81hDatgvqIgGXgN8nYBsMXBQrv
 s5KlJimJZO9fQhmXk//5YBRhbkEqUWfs5QD1/4zYEOf54dmR2357MPJ2ADjiivqQSrnJ5PBc4Dz
 6a7tJSNkM5jCVNioUl6OhOye3lVrAKpuXHQt9k+jnQL7TN4sd3l+7VW+zifEpzLL//2Gvg4pvXa
 ++EvEKhYu4XO/JTo9X8IL7QftLHQPuDbDTA4LzkGNQJDwUareMAdxcf9O7Q0B9DNmobpXYc5bPa
 6SGMFeOgxfmjy3zlKbVreuA==
X-Google-Smtp-Source: AGHT+IFY9M7MGc9Du92Rg09ABFGQ8dmP+5MoX5ZHraX2JMAk+dchRReAPMN4ssVoMNvxYSI4Pwb8+Q==
X-Received: by 2002:a05:6000:480b:b0:3a3:648d:aa84 with SMTP id
 ffacd0b85a97d-3b1fdc20ce5mr5225925f8f.5.1751540364905; 
 Thu, 03 Jul 2025 03:59:24 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c8esm18531283f8f.55.2025.07.03.03.59.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 42/69] accel/system: Document cpu_synchronize_state()
Date: Thu,  3 Jul 2025 12:55:08 +0200
Message-ID: <20250703105540.67664-43-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h |  8 ++++++++
 include/system/hw_accel.h  | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 2a89641aa81..ac0283cffba 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -45,6 +45,14 @@ struct AccelOpsClass {
 
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
+    /**
+     * synchronize_state:
+     * synchronize_pre_loadvm:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers from the hardware accelerator
+     * (the hardware accelerator is the reference).
+     */
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 380e9e640b6..574c9738408 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -17,9 +17,18 @@
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
+/**
+ * cpu_synchronize_state:
+ * cpu_synchronize_pre_loadvm:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers from the hardware accelerator
+ * (the hardware accelerator is the reference).
+ */
 void cpu_synchronize_state(CPUState *cpu);
-void cpu_synchronize_post_reset(CPUState *cpu);
-void cpu_synchronize_post_init(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+void cpu_synchronize_post_reset(CPUState *cpu);
+void cpu_synchronize_post_init(CPUState *cpu);
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


