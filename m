Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08649CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2996-0008Ki-42; Fri, 26 Sep 2025 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298u-0007wI-Rb
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298T-0005jR-RS
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ef166e625aso1770652f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895754; x=1759500554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wtX0TyylDSZF8Gayrztuz/qgyELXa0qSpMe0+Lgit+Q=;
 b=jjB2AdPveyzrEfTYxaacAWgaxnhsv+iaIJyO8RGKqUZUcMXovIfFiZTZfl6C1jbmDL
 Ypj3uF6DtSdAHrr4MbBbPWwjzNIUxgk1y6tulHiQ/GjhaR8x30w4qTT9yZM9g6U/grQA
 07l+ponUH+sZDUYJ9QGNfG+XTqrF+sn4MupzpvVNpXGAyFe/VJnNBGwoQwVeh3WN1fs4
 gsPbGGp8Q8LXASh60Duyx22mUuHtjClW2shD5uW+blqY4NW5xs1LimO3BV9k5N1W/7nI
 uD6vDXezNUM+LDeKMx4OMlopCnM9sT0zyxuQSwpbkWPCwhT355Qfu8mNWeIR7Uy1uuvf
 Xcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895754; x=1759500554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtX0TyylDSZF8Gayrztuz/qgyELXa0qSpMe0+Lgit+Q=;
 b=MLv4P3g4kVIRUY6D0LY46J+UScDLzPhZVtyPpkRpV/BU55g52x2s3rZUHZ4hmZEAOS
 HPECasdGPd/bX3s9WvjsTYp/N2UZzeIfLgycXYv9suZdrH2+TLmFz7Pu0AXfeslDW3cc
 7LIh92cxfzn1E0tokCqnC9NKjf5Q6Sc4pEUfnqvxHSdd3xl3m1Y3juLGqAWAjez/1E6t
 N2GawJQTQ0QFCjfm9v3QU5+siRDzkhoR+F8cj4jjeg5kLs5RUFPSytMjcxq+RVB+hvO5
 J3e3IgcH+W2Lp7jxuRTcr7/2tQE2giix+YZOyMo1wrvEHVEMMe3I+OyU34JSQ0DMtxKw
 uiYA==
X-Gm-Message-State: AOJu0YwU+lnWW3hmkkvRkJhiTc96lOGDLXkhzYF+sUP7MUihCOJkSxAC
 eM9V4jY4PL2AUK/U2gQqcoyCEau1OHdfKhGBcT5p8d6pBHJGaXYol/3PxbXsJWxQJQHmRm4gz0l
 imEai
X-Gm-Gg: ASbGncu2SNhhtZAgBSF6zNAiWlifZ8GX2BKgxVVyO8WG8mvInONvvpdDGpeT6qqFQBY
 0tTKtolFGWBNzbRGV8wkCnk6PdDMJ4SSRTf2H8TUIaUwR/haMbORXq8GL83jEU1V5RUNProE/ta
 WcE5vYgJmLRUoMmid0InPIamFG1nLgZ3tAqIfaqWyRl19XxYx/qXWJ8he1sDWZ1HeRdzmG5prr1
 IFfV8+3xCD+FiqHHGWhrspyiMo3wkQSZ28Ot0BZxkQgo3zW0XBz6mfEirvRctM/J4E0hOpChNLw
 +I8O2k6E9W4iRO/EynRGkn8A5xSNZ9iN3Lf7Bvj6g7kpAQmuenFAjQJaADnM8Wzr/kIUiic3jyV
 nuOuFiGjDIyX2tnuLnJa4UO1nP6HGj1yH2ni21xqa8RyLljeMLQ==
X-Google-Smtp-Source: AGHT+IGKdQdtXaClxo7tvoM9uGuGg4N/A6bNlIJ1VZ4PbSilBxzallNsiTSQtKqai4ts21k4u2uwPw==
X-Received: by 2002:a05:6000:1886:b0:3ee:13ba:e140 with SMTP id
 ffacd0b85a97d-40e4a8f9a93mr6266693f8f.21.1758895754318; 
 Fri, 26 Sep 2025 07:09:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/44] target/arm: Split out alloc_cpreg
Date: Fri, 26 Sep 2025 15:08:27 +0100
Message-ID: <20250926140844.1493020-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Include provision for a name suffix.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8a8fa8c40e9..e36598e273b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7362,6 +7362,28 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #endif
 }
 
+/*
+ * Copy a ARMCPRegInfo structure, allocating it along with the name
+ * and an optional suffix to the name.
+ */
+static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in,
+                                 const char *name, const char *suffix)
+{
+    size_t name_len = strlen(name);
+    size_t suff_len = suffix ? strlen(suffix) : 0;
+    ARMCPRegInfo *out = g_malloc(sizeof(*in) + name_len + suff_len + 1);
+    char *p = (char *)(out + 1);
+
+    *out = *in;
+    out->name = p;
+
+    memcpy(p, name, name_len + 1);
+    if (suffix) {
+        memcpy(p + name_len, suffix, suff_len + 1);
+    }
+    return out;
+}
+
 /*
  * Private utility function for define_one_arm_cp_reg():
  * add a single reginfo struct to the hash table.
@@ -7374,7 +7396,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     CPUARMState *env = &cpu->env;
     ARMCPRegInfo *r2;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
-    size_t name_len;
 
     /* Overriding of an existing definition must be explicitly requested. */
     if (!(r->type & ARM_CP_OVERRIDE)) {
@@ -7384,11 +7405,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
         }
     }
 
-    /* Combine cpreg and name into one allocation. */
-    name_len = strlen(name) + 1;
-    r2 = g_malloc(sizeof(*r2) + name_len);
-    *r2 = *r;
-    r2->name = memcpy(r2 + 1, name, name_len);
+    r2 = alloc_cpreg(r, name, NULL);
 
     /*
      * Update fields to match the instantiation, overwiting wildcards
-- 
2.43.0


