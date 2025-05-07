Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4032C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ9-0000fh-HZ; Wed, 07 May 2025 19:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPq-0008Tg-Aw
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPn-0002X2-5L
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-227b828de00so4514395ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661382; x=1747266182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAz2QB2SUYrr3XWzF2d2hg/x4+UA3WdNJnT5uCp92aY=;
 b=AqvidG+ugCrS9jn+X4NQrRRNp/w/qe/MCUWwDGdMXft/aTvm2UiZ47Z1nDjy2WD28o
 iJ43ci7Gek/JTSgPyI/GgDY5Zl1+X4xoCQWxlxXGjw+nsBWpPlPzpwCkJR/+bGXXeeG1
 ZD+/JFWndOP0iTzxxl3BNeobqpAF/aQ8msipz1dmoSvOiGMrzEx4haJtr+4dcvXm8xnE
 bWzrDqxBTie0CSR/FFiYDTYF87cSG+J9ghiF2JMPaebdGSRNrMawi2x8owSvwJUN7l+a
 APGdyqYNvO34iysohk5iapfUpdTuAEpG4isDLKEuh80SKOxLEVl/1Nu+FJvPfxCb+PV7
 1aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661382; x=1747266182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAz2QB2SUYrr3XWzF2d2hg/x4+UA3WdNJnT5uCp92aY=;
 b=Hyp6361W7Le5RLzi+BL1tF8HqQiJN/wy5pG95/h1ZXG4EkUuWkaSnB7r+RACO3i0Zd
 nwQ3Lk5PjxRUwPlObiJh0YyY00fuoJ9jTZ528F1R14tEJVqzJzzvtE3idtykGujBdGdE
 bLmAlhujWp1ytWNh6jOZIEu6yxtxvosyTPqUqw6NSA8JzNnhwE0wgnaFBwE5kgWxcZd+
 sexhFhXKPfACfMQBcyzadaRiNpHvxG660uGfxYqZqn8FG88ew10HJQdL9lDvrRnbfjry
 C1rd1DxE/O+FhmgKx6Ph7mY1ZGQEQFlaqNX9eeXWyfzU++BZPV91I871YLDH1QIgiJG5
 P/UA==
X-Gm-Message-State: AOJu0YwL1FtjaJaG0KwRlRr6tmUxEpjHOtAlpZ5wl6TyMGf+n1RMmg+F
 G0pdd8wOAxpXWKhrYVCsCXmsNlvusVxWiAvZy4bYJvq/mTMspIqOuA65/UwYpcL6Lle3nIjfXaq
 K5mAP+A==
X-Gm-Gg: ASbGncvn3PW7Tp96Ag3vR0qtbpHe79/szOQ/TbKglu2vB9SmZiZZslR2QHtyF970ZhG
 SZQABAWARWcId0IMUznN6puDKt3vVAfZg0mcn70rXICb4+xdkhfURm4smO9qrahyECfYBaA3zLQ
 Q2u6asodeV+gkR7Ectaec3ND3Os/95eIVyK0SJxvyTeNrFnqFUg5jqvji9QYI7y4y9RNOlITL+n
 WBsHEbY4q2KRBjDZ6UzvthjlG17SDONjkgHgUhq55xdDreV/O1BEsZjKgEtnVDFN3gVm+G6bwZt
 soWOGuxTwDdLZ9E2Rd6FYKg8/m4hxyjM8z2nlQS7
X-Google-Smtp-Source: AGHT+IE38pdekqu2nTYznWLfBCmnQUl4ZsEQS33bpVJKG/HiFUEGF9CqGv5eA2fH3TQAGtumOTQcDQ==
X-Received: by 2002:a17:903:24b:b0:223:325c:89f6 with SMTP id
 d9443c01a7336-22e5ea1d4cbmr90104005ad.10.1746661381800; 
 Wed, 07 May 2025 16:43:01 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 21/49] target/arm/helper: replace target_ulong by vaddr
Date: Wed,  7 May 2025 16:42:12 -0700
Message-ID: <20250507234241.957746-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 941fc35d24d..2e57fa80b08 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10621,7 +10621,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
-    target_ulong addr = env->cp15.vbar_el[new_el];
+    vaddr addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
-- 
2.47.2


