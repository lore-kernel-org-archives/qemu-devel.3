Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0B6D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Xy-000894-Fp; Mon, 02 Dec 2024 08:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gq-0002iA-DJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:30 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003a5-3y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so2866865f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145297; x=1733750097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SF+s3/3GUKM6ErlG9DZAUNNlPEUN5YnIqVqgW7tQx0c=;
 b=Z+tZk3nSo22vKc0EMsaq6/13fVH2u0DY/zCRA6nkILH/acnqBEF+z1Y5GRsuSo7VWB
 MKtdu4dw5zdQrAM+M39rAtnSSHyudsugPmlcGyLgfHJrEImrBSiUaso0hWLheooJYFLB
 PX+eqzySgZscyZI0I7+WQWOfr+3WP0SsBaVcYHOXjaxp2Zjme4qP0nOZ0cM6xYoxBLY+
 U4Kxp/kmI/OC1Bj+XKw7M18vc1O65GbXhW0qlAReeESkbh4wAGMhsigXAuGQSUGQELX/
 ytAMF8495u6wACCOx40A34B28ud0DxYSZlbJ2E4bwQKFo93Ap8abYQPhouGxIgmTwxHG
 rq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145297; x=1733750097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SF+s3/3GUKM6ErlG9DZAUNNlPEUN5YnIqVqgW7tQx0c=;
 b=oAQdvifOGu8CbfHZqG0Qq7y2LoIuXMfo/5k4RwERkHB8N8eHVHA3NNRBYyiylXC++v
 axK2nn1A/JbuA3LHEo3Wj2WyJGeNZdxVG/C3JdUR9E4A1xmg9m5lUUwYqFV1tRCFkMpI
 fbLMD087VFJA9aaPeBpBg+XZ89V6IFrir2DZwe9O4R1GGbOGnSmc+YpxmxLNHpuH45xG
 wip5Cxy6r2VH0FZomnBBnzWa+umdeyDsPvvN2AK5dNTfynmMogTH0jQO7hdMyIO2eogc
 H4VT2E7HpCKhZCpkM/3msUJLpjrcU+exwigiAmC41PWIhly8cMb1SuAVk/1g07117tzR
 Gwlw==
X-Gm-Message-State: AOJu0Yx3av3iiYqWM2Auz53Yv2ZJmqAh2TCxYLKOXhlAg4bQzUackfV7
 GkBZj/Uvra9K3jasQlETZq2S0/5SVCopNZz8kO6cHKn73HAERuz4gX6gE05t+rRmDQuLMxSP2sp
 Y
X-Gm-Gg: ASbGncsBA59krX1l6bt5y4h+alqfeo91/3vfeYcc82/KFURBvhTysuo4IeSiWeyqcjO
 lp2d1Ce97n7fZ+ez+nJtxiNI5TmqKOtNiuA2N1KPTNmF2mesE6bT+J6e6nqQEmeTPdXlh8C1NL+
 OqiXekzIgMz8K8cNf0cxPfpI8w69dEt4nbtDY3/VoJpT9f1+SRyYL0t2AuhQsPx4hNC06zahiR3
 9JbUKOp3WiPS8Gs2uFpb5wyWcBcMqmFvsSuEPWJn8C/XwgHXXrkf30=
X-Google-Smtp-Source: AGHT+IHZbR8myEJqrFSbtsWW3Ke9b1O77ziqMLQJzRs9zmdRAxpEkQbXVz1J5DH5fUiXKa5Y7BrB/Q==
X-Received: by 2002:a05:6000:381:b0:382:5177:3a4f with SMTP id
 ffacd0b85a97d-385c6edc3ccmr16561180f8f.49.1733145297319; 
 Mon, 02 Dec 2024 05:14:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 51/54] target/hexagon: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:44 +0000
Message-Id: <20241202131347.498124-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Set the default NaN pattern explicitly for hexagon.
Remove the ifdef from parts64_default_nan(); the only
remaining unconverted targets all use the default case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hexagon/cpu.c           | 2 ++
 fpu/softfloat-specialize.c.inc | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 020038fc490..c9aa9408ec8 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -286,6 +286,8 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 
     set_default_nan_mode(1, &env->fp_status);
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
+    /* Default NaN value: sign bit set, all frac bits set */
+    set_float_default_nan_pattern(0b11111111, &env->fp_status);
 }
 
 static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 06185237d0f..5954a6213b9 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -136,10 +136,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint8_t dnan_pattern = status->default_nan_pattern;
 
     if (dnan_pattern == 0) {
-#if defined(TARGET_HEXAGON)
-        /* Sign bit set, all frac bits set. */
-        dnan_pattern = 0b11111111;
-#else
         /*
          * This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
          * S390, SH4, TriCore, and Xtensa.  Our other supported targets
@@ -152,7 +148,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
             /* sign bit clear, set frac msb */
             dnan_pattern = 0b01000000;
         }
-#endif
     }
     assert(dnan_pattern != 0);
 
-- 
2.34.1


