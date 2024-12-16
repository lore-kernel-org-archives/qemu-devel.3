Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F34E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDb2-0003eg-TG; Mon, 16 Dec 2024 11:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNDaz-0003c6-Np
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:05:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNDax-00064f-TO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:05:21 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso3608115f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734365117; x=1734969917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+cEtuPLfzX3+HA+p4O6VB2iDGKV4RmaMNbJGKVtmUNo=;
 b=Omj0Uq2H56UwvZykc2uicU2FI2FNvowJaQR29Ovydcz2gTWrAS5gR5X5ktzZ+Lj652
 yWLFgH+wSu8MUzrd42aTOQ1nyDN0fYNppe0S7hTFkJyOx6y2XlQMYKoshErsRCgJqxmJ
 QYLlraKsO+A/0U49lkCPb7ee/+3yjzOkZoneCOFQoJHPqs3cDfkeW719TEz+S7nbCzET
 hqYrD43/fFWPKcwXfEz08+k9YUQxn83a4Dc+DZHSawEaSB3dd6jmM8mQQ26vUDBtlkZ4
 SU9nEma0fDqZQulTQ56qE6hd+ms1BHbvEjdNenYIdsFrTfAMHpEWr/MziJnX7CjXv/xj
 10YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734365117; x=1734969917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+cEtuPLfzX3+HA+p4O6VB2iDGKV4RmaMNbJGKVtmUNo=;
 b=Vsv+tTlx3KMGWhraLfylAx7dkyKzOQCeRV5YBFr4Jfe5R1kmOnUSq2YLwya4oiUitz
 3h6vpu9XlmC9oAAswQ7ZYbre09mAR8B2bde27tdV4I9/3XA2RwXmnF19gqquwvRh5i2P
 /6ijnule6jwUjyzUNza4jpJWelDPt4bn/MeqEFY1LrEqDwUCai5deIjYoeatFYM3etEZ
 fYiWSjYP+ysG+vYas3phg6V+Ae6V2BA2bL29bgvnydTPNNdxIsW+MXsEIdJh9fx98m4J
 m5qKKsBpJgo3TPICb6Y4lPmZM8bpRmlR9qnmzb83PUFIqbx2EHqxwLdh51G0TeFIp8n8
 YueQ==
X-Gm-Message-State: AOJu0Yzl5oOQes5wyJCXjB3Bm3V4WGzZLrfRTyzjxlIZ3f6zRcZA6+vp
 jjm2KaklCJMk7CRt0gfu8ZQ2Z7UpxamZLViGnR7lXX2JKo3TKbmHnV15TcKpU2RpPhF7w8L95u1
 m
X-Gm-Gg: ASbGncuWTvVbHSr5/0X9S2TDGwYljP0QxNus003ShHEZZlKhql1OYZNpvg836XY2hT9
 Up7qgcy5ggXAParJQP+nv/7hyNzq6ihL3IKNKDGhFYbKW0U6c83o4suGrMfMGjtkKanvKGGinBw
 doFadDxFSqGEf/4dSMotuljK2G1vt9MRt0eNTu0mSsVgQPugvZfQ2eP2W8BspFHBiaLXm+4vZvk
 wRdOOlZUnL/2xcZmMzxheI3SM4ec+vyRiGAah5E6ZUFTA01KtYIu+TIiaVG7BWm2BELIFbjpBaE
 CQbV
X-Google-Smtp-Source: AGHT+IHKpHGtjr7EXe5iUl22xi99EKVfiSzIkBRlbVabhF3rInBG9uRHZVNEn0FN8FRmbyyusXPIrQ==
X-Received: by 2002:a5d:588e:0:b0:385:df63:4c49 with SMTP id
 ffacd0b85a97d-3888e0ae5c3mr10543297f8f.25.1734365117359; 
 Mon, 16 Dec 2024 08:05:17 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a628sm8686657f8f.47.2024.12.16.08.05.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Dec 2024 08:05:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Really restrict cpu_io_recompile() to system
 emulation
Date: Mon, 16 Dec 2024 17:05:14 +0100
Message-ID: <20241216160514.56630-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Commit 38fc4b11e03 ("accel/tcg: Restrict cpu_io_recompile() to
system emulation") inadvertently restricted cpu_io_recompile()
to SoftMMU. Correct to restrict to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20241212185341.2857-11-philmd@linaro.org>
---
 accel/tcg/internal-target.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 1cfa318dc6c..3ed81e740d3 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -36,9 +36,9 @@ static inline void page_table_config_init(void) { }
 void page_table_config_init(void);
 #endif
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
-#endif /* CONFIG_SOFTMMU */
+#endif /* CONFIG_USER_ONLY */
 
 /**
  * tcg_req_mo:
-- 
2.45.2


