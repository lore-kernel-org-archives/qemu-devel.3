Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FEAC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXZI-0006jR-9f; Mon, 12 May 2025 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX7-0002c1-H9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX4-0000AH-Na
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so55843265ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073139; x=1747677939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=eJoE7JhnuqLffqEoAK5ClAMF0bsmHcCCB3YOedg7zsmFnwmIGVBaaVE7FKi1XEbpwN
 qAAfAnc1gZce5lHBDjC09F9MPD85iHYFFV24QM348zCKiR1VduRQMY4U6S1ehSJvUr8c
 006tcb8RxuDSvU94g1wrbCPqcVNo05+wqb7jDsvsFI9Mlpvfa/ZtM3pFggTlJNtDzdoX
 dhABGYHZ6M5z8ygULxbTTI6wimLvQOBU7r+V27nAYVNpq6eYdUn+VFyzlZQrrjCmDGc8
 poRy27nZFYy1FPEt9TqjE5ieusAOE9avKGhYJmAXD3pG11R88rCOJH6jSFJdeqivdpTa
 3R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073139; x=1747677939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=puMp9323+RhBfQxGFoxPLdPTVoORglnGf/Jy5JVB9X5WorTrzrh1BUa0Zwgn6vI6Fr
 acCU1yG1MclsDUseCj2rf7lYKiD8FE4QrcGTLNqYCwIyNxK+nl421a87avEtwm2qNJBY
 XB+HhBhOEPWqVwi35Fue1r321t/L/QIfEsBk+LGYo7wvMaxKXAVwROMyCXJdOLWvk1Et
 Y34OVSBLyT7Y96a86pG8oXZ+mlwOtQdDnPw1Z1NT2blB0a8vkuDY3wyD5+zHebLp8mHr
 3Oy7aVDeIkWt00I6g5CPDgY7qDWRY2TjGZC6wJTCEIqxt7hPB4kY3k+WwQJv6DKa8UDb
 kWBQ==
X-Gm-Message-State: AOJu0YynzYyqv9G8humc2z9bXo8P+HK3ugVm8p2fdqw3CGJG5AF6gOZm
 7vsWbwgPSH724dq7OKEvcroEOiKPJa8KmgH2dKMuMvCXDriAWk9bfRbg5a5Cl+mvWGMg/8+LuDq
 w
X-Gm-Gg: ASbGnct09SFFZIqvini9JlD9JtGnUNuRSyqqS3EPrm+QXjURBNwUKXDc4yOPUMrahYb
 ib9BeYgEAzJytYRHBa4LhWYPWIUrRqD1kRt5ZhNoFd9cEPG8OrO0I+5xEENezxBAWh4D+2fusfK
 otQFhiohtD9/T2ulB7Nwd+cKyNbAIAo/JlytTihYoRRHgh1CNQFWDSB9s9NZsnF4+bKagqZLGWA
 u7koDPDs1YBff4DjvyygZgLXxMbEDXUon+qCF6jbuwg2WQj/qtBFu21SeWgUTqGxiW2M2QiM0xE
 VfIO/l8RyHLr0DSo2nmAtX89RnFFAlihhzloYEzn/VOqzaG49Js=
X-Google-Smtp-Source: AGHT+IGDbYE3NZddHMNtkgUSWM+p6EAgBZsVoXhpxs4UoNfVW5VcAewVjNOY1zxjElB4McK2iuAKUw==
X-Received: by 2002:a17:903:98c:b0:22f:9f6a:7cf with SMTP id
 d9443c01a7336-22fc91a8c92mr188938405ad.52.1747073139445; 
 Mon, 12 May 2025 11:05:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 31/48] target/arm/ptw: compile file once (system)
Date: Mon, 12 May 2025 11:04:45 -0700
Message-ID: <20250512180502.2395029-32-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0327b6f5b..151184da71c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -17,7 +17,6 @@ arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
-  'ptw.c',
 ))
 
 arm_user_ss = ss.source_set()
@@ -40,6 +39,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'ptw.c',
   'vfp_fpscr.c',
 ))
 
-- 
2.47.2


