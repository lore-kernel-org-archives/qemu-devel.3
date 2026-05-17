Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B82CD4F49
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPe-0007yO-9k; Sat, 16 May 2026 20:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOZ-00078k-OD
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:17 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOV-0004nC-Gb
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:14 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so357569a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977808; x=1779582608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=Tt2RXVO99wu0fNHFcpolbvQHyf3L2RuBAQ25SmROeQvB0Iomoo6dI3Exwyx23NXsAg
 pc768vW1aieUynXBSGlSOPhLTDJpV4uc5hH3IO/Hh1T+NBS4X6033GprRaBxlX9AxUoQ
 mxwdk0AGiAjr2JUvxj3SGKJfHxqgDCA0o6DNPS6UXkWICqmk2iRvQNPjtEFUZXAeAaOM
 Fud8czGWEZwUKlz1IS99nsDfHVF3z+bpKQeCytVCxqkmHoaxZevfC54ZjjMq//DBmQtj
 RLJmNOOkeyEL6ncCzyherPD1ci6m5W/W/6FznqEKsuMdM0xTkNc44Te+agHCoLfwkp2L
 7xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977808; x=1779582608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0L8sm2nuOmiw4XE7Qu74ytG281Y5T5t916Djua5D5pM=;
 b=KFKDk+9nDT+Y6YZAWJi0qQsH6PbOoBrfOum5jCg3PGsgaMRkMnbTyMZCVXBI8v8U7U
 Vez6w8nMmERNV9Z90V9bibyeHGZ8ju4kZk8yzXxgf+/5YktLlcyC1bK9tvtqbwm02QtR
 VaVL2L7vhjfu3+SSrpuTBDvh1YGwaaWkAIWpSByyo7v9kzZ4JxFYhwSOa9Lk6pXZLYXw
 e8ZlGirs6bRArfhQJ5VFKIvto4j0EkejuImhA260VP9SM0D5hlciW9qTrOBvIQEowjAT
 3wRSevffOgMF12BaRAcBpy3Y1bh0uNaLo6ZejC41Zdb/VAHgSJ0n/pw2IyZWMbKSzlR3
 od1w==
X-Gm-Message-State: AOJu0YzhXyN3qOYvAq8fIbRDWMYebYn3D+XT7D1KRzfarY+TvfX73ceG
 bSxg5tQv5CVExicp00+WpIWUD7WFbdAT+n0f/EmoW9A1gS0HY7VkjDy6MMAiR+9fgrZAdcIlcin
 mtQlz
X-Gm-Gg: Acq92OE89Wfojiv14ZsOdwfgaQCofjNZg+ouNzGUEAnpdGVB4eA8zNeqXcyjzSrc1x2
 fHFFuyOXx1rsDgfGJbiM2mm86i7hvZf/Z8jh3rVgaEzTxG7OC/FcHJ1ZFiaOhaVNvRXhhZuRgA1
 jDFodMkESkV5vjPqUhvlDE8jaWmqM6lGlRllJ9Zledqsa+LAt3YO3WwARczHpsxsqLWGvErczQE
 Uil+UGuFrTAvUSgOjFmdetVfRMqI1si+1zsEw9zSKsmguOW1pz47qp1sLOZLWj/PUKjQkqa7wG9
 yPdUDEKdYqeo9/qGnTgBeXqW2fwKruN0/6Q7MFiU9lg3SSMCW0Lbnn4m1YGRCRRw2JrlRk98/5u
 S2g0i2+Fh000EKwxCCFqRKCKb6uJAMt+JuLD/5mSGqsZ/iVJLSjvolm7n92EeC+UUu3VX00w4Xo
 Ym6/tTDzSrHaJXcYpli2DXXB3NSWgD
X-Received: by 2002:a05:6a00:ab0d:b0:838:1c71:bc7d with SMTP id
 d2e1a72fcca58-83f33bae2d5mr9723505b3a.3.1778977808093; 
 Sat, 16 May 2026 17:30:08 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 06/63] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Sat, 16 May 2026 17:29:05 -0700
Message-ID: <20260517003002.321430-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..ff0c2b1c47 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1266,6 +1266,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8cd7fe7b00..da5f7efce2 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -68,6 +68,7 @@ the following architecture extensions:
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
+- FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
-- 
2.43.0


