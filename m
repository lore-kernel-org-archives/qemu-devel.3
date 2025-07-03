Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7084C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNoJ-0005V3-Qu; Thu, 03 Jul 2025 13:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoH-0005Ug-0I
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNo9-0007wP-HN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so31776f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563991; x=1752168791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=oMIVqrK5AArub7iT5TxMlxNycRv6BH4i0lH26jXBFyI8wEgLTeOi7A2P03AXjFG8KK
 vxzwYBKz+axvsdFspz8dy6zrPDV3gN1ML/it7RR8BRuPiQNARaSjbtLpKFR+odQdga3O
 oZ3zaGfggXA54T0tXJCEkDMuBGTQHGv9Wy9haCMj0sNakz+4Sequq4FG9Tq1Z2dnvn2d
 DPtgKCsoVXVkfeRyw3r+ORzD0iWtNpUlOIKTcx8Cbly5OyR9gKEIiSBFpMnS5Xd7H+FV
 3Hwiv5J7tlz/z4sa+hmMV+/YEZnceDzqzW9dH8A42raw4BrKgWCdv0fCR8o78rAFNeFF
 F6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563991; x=1752168791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=QhdXU4iZVJgZ4qT/Uz3NmyVnDFoFLuEhK2X0DYnzuchZV6JBya+I9/q9o5whQ/IEaP
 4c2COu3J3a3PLpZHehaBekMTfnVks95bfBu0Vw7f+xEbaM8KnvSPZ0uh6XtM80MGRHsW
 3EJ5Gl+caq+XeGR7UeQm1ikIIEnwjsLk+GwjgKtvZowCiyVNGma9Sskcir7tFQ2lZr9M
 uXMqkVnRmy4r12flM/BK64bFWvceWhYT/izxHnTTdNy4WeEN0NW1d9gXtsYHUo/8YMEh
 o2TFME1uVZkZjdh0NPifvUY3MRMeNaK67D5hxm+1Li2EAYqyhgU50bTwd2gGWFsTzvIL
 RTUw==
X-Gm-Message-State: AOJu0Ywq94cmMt4+s77x5eETp7RsO4Sodg6Grd8c+s/kwJhSrbkn2TTv
 XXcacWX9lEGrDz3OPh3cUoCPfDnBhwn7HeCZQrkjIgcFPvH/7QUTN/KGV3oFlMhUzQQ7MRSsU2S
 kpg4A+v8=
X-Gm-Gg: ASbGnctq00aOriDoCancmkaYn19G4xTcRTQIW9VlSB2k62EGSBNEHbxx1oD2D1CfeVs
 1IkI2oB9uZTKy7RBBBCBCTlqegihwtrr/VuLEExmW52ekscjJvqk71fOkFNNdcaj67xCdARbWKK
 ESjiFLdFc1rEpY0t4yYGj7rF0aOfzJlUW52HK8WnGLFn2w1kGYF3Cj/zwVeO5hFi2e0oyI0j2Ad
 jflv5nwsHcuYsyraVOijreMHSsrdOYog/KxqSbDSsGVhK8dnG+j5aMt9bWjHQy5krDukcUM4Yof
 B8AV4dISkjCH4crqlXwJdPL3UJI6CrChnGV9Kq+WEOZC37TokR9Ud3rd9LbvVQYQ+NGrnA5xsBO
 GbEEI6GVu2GyHix2+CTqcfVY5E21uGkN4mxqn
X-Google-Smtp-Source: AGHT+IE3eHyttpF5AjRM2NSGQ74TaN/fjiyPc2BAFxWRz/XEWKG28qNhJROCu2bMLK0jAzBhqfMEDg==
X-Received: by 2002:a05:6000:4188:b0:3a6:f2c1:5191 with SMTP id
 ffacd0b85a97d-3b32c56e040mr2371776f8f.4.1751563990811; 
 Thu, 03 Jul 2025 10:33:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1628ebcsm3545525e9.14.2025.07.03.10.33.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 04/39] system/cpus: Assert interrupt handling is done with
 BQL locked
Date: Thu,  3 Jul 2025 19:32:10 +0200
Message-ID: <20250703173248.44995-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
 accel/tcg/tcg-accel-ops.c | 2 --
 system/cpus.c             | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index b24d6a75625..6116644d1c0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-
     cpu->interrupt_request |= mask;
 
     /*
diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..a43e0e4e796 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    g_assert(bql_locked());
+
     if (cpus_accel->handle_interrupt) {
         cpus_accel->handle_interrupt(cpu, mask);
     } else {
-- 
2.49.0


