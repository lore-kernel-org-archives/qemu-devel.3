Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2306C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvL-0002Rx-To; Sun, 04 May 2025 01:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvB-0002GH-Ui
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvA-0004Qe-4v
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e15aea506so21472225ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336586; x=1746941386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=mYiHn8FuADTFGSnuB+i4vD4BqdpLpjVrQ78I9L8+sG76wR/vJAEin5Wlcr2doBolA/
 dyYVOfqSUcgNpIvB5lYu/Z085O2w2mbJ/giinSWo7OksvrLJGWrN5fZ2uFHgeZGl+yn/
 M7bxy+J/S3r8M7aHqPjuKFwKUgwKxZZ4G4TVLvAaH0/oVQ1NKRZ8bV5v6PHCr4Htrd3J
 Ogy2PmO3sY737LC7GMBirXi8ozGyxWvTU5dOFsXWRrmp0efjUjyOZfaFUSgrOMS7C2Zd
 Rc1hbVymUXbqYrPGNm/Z79qOpREuJH9xPrk+MGFLb4AgV2QvijB1v8r1UVj3HE2RW94+
 Hanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336586; x=1746941386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=WBlG1g/c7G99E27MvPIJ81loem8C6X907hVIeC59QTclICEtQJjsTbP8GyriaIeofi
 nC86SU+ocCZWmHxm5oiqjuhgzSvVY6bx7hWjJoUbPzWP1AB0zVYncW4QNXTdqEqFYe+r
 hzkLgfiIrsfFjibGfzgWaV1CSAS19Xn4/P7whCOijfeZtUKgQxujRJMhOjbpEkGBGnx0
 TlgEaaLkm0rgf/IP7OhKTue6riTtpDYtNy19oqTFKJ6guoGlJl9QP7Zy0bBOKLzlu41X
 LoE0tIb+x9GJPXrMMADoNssuUSc/4kvRglzi0EZg3BTuPrT5p+747m6Y2KeCbwOLCFOC
 6tFw==
X-Gm-Message-State: AOJu0YwxRhs8o0dcHhj/WjsYGyaKoR+GVEwDBoZi79+KyMo5M+Ojrb4F
 94xhlGmAWkQ+c2/PfLpZcdc+d16FOe1LES5/myJVvxXeg0IB8x20wKVN6Pf1QgF8B9nZiW2dWtJ
 0ngg=
X-Gm-Gg: ASbGncvH6zB+lrNGpkzyAfk060Pp2XZ0b/rkmUrUNw5cETP4sT+aOpjIhbX42uG4pYQ
 EVoh1QNtTKo7zZxip1RhAP5ibVqhjYGXeNKXVj7ZxvRjMdosVVwC7Jt1EjDS1gZi4Pve89J3lKd
 3faI+OjN306eJRc5vZGIqX+UH+Xlt0PXkEVvgQ3nuJK/Vuah5HLdBVrwElmk0lleAUf6fqcvkj3
 P14tF5PaPfQMsEyeXZT1ySkB/9G1KCB5EmaWu2InHGMMaIOCRkzSFOoclduU58+Ox8uJjxTP6NY
 lDXF4rQDmV8owdy42ECR2xgJ0xU9mrARzYmaH0ZH
X-Google-Smtp-Source: AGHT+IH8pStqcZBvvYFFxKQxcdicD1/a/lfc9xhDUZ+J9NMLqS3FmKOe7ccMNbifujt3rX7vnt1Q1Q==
X-Received: by 2002:a17:902:d2d1:b0:224:194c:6942 with SMTP id
 d9443c01a7336-22e1eaabf6amr44782545ad.34.1746336586599; 
 Sat, 03 May 2025 22:29:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 30/40] target/arm/cortex-regs: compile file once (system)
Date: Sat,  3 May 2025 22:29:04 -0700
Message-ID: <20250504052914.3525365-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 7db573f4a97..6e0327b6f5b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'cortex-regs.c',
   'machine.c',
   'ptw.c',
 ))
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
+  'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


