Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F09C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfkt-0003mZ-MX; Tue, 02 Jul 2024 11:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOfkq-0003hd-Lj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:49:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOfkp-0006uF-0G
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:49:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f9b364faddso26792665ad.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719935353; x=1720540153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EYRoGF2stDqYWIzGESxh6OgaaDeyMSanepz7ZjBZqBw=;
 b=cfZtSi6o7ivI9vZDiluwWcWWAaZXNag2+1xbKD+Dt+hWnLDnj4M5LP76nmA3A1ShH0
 1ds1cqXHxbMcNgo7qkyI5ef2m+xtwKWplMFLtL5EyO268DeQicc6CiKqkc7OBbICUPWS
 9qhBfKxsdEi/RlsJSvKxGiXNtCzKbVqiqpd1tsDYllZpTvWefE/mNFgYnIxhexsblKko
 aSM2lOGB63Mj3IKHScGFTPJ+H89zwEYLQs7J5MEwHDRGdWOSYKJY6exa8oAozqLHUtcH
 yWcnTEgW6sYqm6qKCSr4wwALPiG8uimYJNXk071GdClH04mxSz1o5aMGIYtx485RKNyY
 OzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935353; x=1720540153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYRoGF2stDqYWIzGESxh6OgaaDeyMSanepz7ZjBZqBw=;
 b=JLyPNnAV+aviavocBr/Zmo/V5+vWN9FPjvMv7COBhnSttHUY8J+d0qGw6B+N0FFOj8
 Qw5AsjtpupaU+kuWUp72t4UX2spVJK9hcE9e3wpauKBSSzRHT7jJd6qHxCOGgFn/13eO
 PN9v+p/tSqzz2RT+V0MAeTbJ5/UkaVT5rdzHIQSg2yFn10owMOztcIiLTrPe7joPsCTl
 FVCEMST4vO4mBIVtEzkW3QylLBvF1anDOspo1e9EgBGJLpRIfAotgw8t75JBZrXT5si8
 Lke2/qPyhqeXhyY8pY4jXEGm2LhoDoUobLe8KGGdP5lpwm31zy1CVLHa7nrtndVe6WOA
 nhTw==
X-Gm-Message-State: AOJu0YwXT3d96uBUZmm3pBUQfej3NFcV/EdrLc7BQPvZYVJCe4dsO+PL
 KuW/0Jz1PQ4cygmDnHUnEkgbNtBDrcd4f9dplDtfGatSAovleDmd94jEka7melaeP7CtESZV6yZ
 0
X-Google-Smtp-Source: AGHT+IEDV4g8N6Mb9ZM26RWlMtPhlOHZkF+TbUfLPRoBI/20oWF6Vk4i69536PFgyC++PyKeKi1z3w==
X-Received: by 2002:a17:902:ceca:b0:1f9:cbe1:af0 with SMTP id
 d9443c01a7336-1fadbc5b80amr50721595ad.5.1719935353277; 
 Tue, 02 Jul 2024 08:49:13 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1569d28sm86197275ad.230.2024.07.02.08.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 08:49:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH] target/arm: Use cpu_env in cpu_untagged_addr
Date: Tue,  2 Jul 2024 08:49:11 -0700
Message-Id: <20240702154911.1667418-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

In a completely artifical memset benchmark object_dynamic_cast_assert
dominates the profile, even above guest address resolution and
the underlying host memset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d8eb986a04..ccfb9349a3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3309,8 +3309,8 @@ extern const uint64_t pred_esz_masks[5];
  */
 static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    if (cpu->env.tagged_addr_enable) {
+    CPUARMState *env = cpu_env(cs);
+    if (env->tagged_addr_enable) {
         /*
          * TBI is enabled for userspace but not kernelspace addresses.
          * Only clear the tag if bit 55 is clear.
-- 
2.34.1


