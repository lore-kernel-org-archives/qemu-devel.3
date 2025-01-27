Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A4EC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNiN-0007YC-Hi; Mon, 27 Jan 2025 06:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhv-0006xG-Hc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhs-0007Al-ET
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f796586so46942335e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978906; x=1738583706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JX3MnHembh04tcm3f0aOQ5qd9/M1w32l0pc1xIgIK0Y=;
 b=CRRuP110n/bB1EYG+advtZI+agZNuvNdW4Lp7K3IM3FHsVcPvhwF0DSV2YypkZj3db
 ddbGpDUZky1gOIF8IBQ3PhKFhspIjm9hnDyOLakJnO/PeC2UrnXmsPwsz67+KtgJ79mi
 hy3yOZTkRlSXyWm5US5ASxlX5D+idxObKplBa2LJRHd4xiVrIpiAeAzSqb0Pc6Q4o5Yy
 oR2c/+Dz/2HjddgAJ55ClmYkB4Y+4CnhLsdDI03R2t4tsj9+wJL+Ke0BbM1wzOPRpF8z
 ZjrarzDZ4wfY2OESQiJ01OzK/epaZDgJ8AfwOBO739T+xdwZnRJ6fWRW84n2hNEYfHPT
 SrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978906; x=1738583706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JX3MnHembh04tcm3f0aOQ5qd9/M1w32l0pc1xIgIK0Y=;
 b=eGjM6Hk65t1lkr2Wp9xzSdEdkLZ8WHKupDz03ogJ25vdEsBRoW1MTCBzvnOA1E/SLG
 YoXTOFgVNawS+9nmNzDzYH41ljJjWqKZNygoQ9dU+c3q2qzjtTpva8Xy5oDMHcxEDdTl
 QyOHXdS/WW6+j5o/SMxoJ/8xBVaKYTcGWPjaofu4tKyEpS3XPX6S4wy9mVHedf7ai+3g
 zqpWWpKL10DpAy/0uuTEuYHLFXQyw8W85V7AhxT2j8i5P1cnhidlfmt1NMFaNXHjyeyy
 B1N1SooIR+shCrZXqT2HaPPftmr6GzNouEmqV+WdZQ273pVVviJl68Yx95O7FXUhPd1P
 OkEQ==
X-Gm-Message-State: AOJu0YzsSbWcEzVqaPjb/T9lKeM59e9NuSOurrFO9Zw4r2zffNTQTq8V
 y5Q2Ye9hm4lVDIiraBTHaFLRSTbHLD8MsI6+i5Epo0NQbwhWErQMmMEEp5jL8X1hpsV6Ot3SM01
 yqL8=
X-Gm-Gg: ASbGncsbjXi65EyxJDLp0OobQdyOKb5oJpzkayrLPyOrMye1/+GckPeFWL0fp0aj+Yu
 oYxm2bfK+Uwl1/bDnrWANCe41Uwecf9O2KpOjCv/A6np156ZVT2hWjh+Ft/mu0PRE4RMU4BkVi0
 BSHX2WeRkkMbTNSA6MVvpynSKC9knQX1ksT+0pCg0FM+S0DRQbf5pW9pbBUQuQVABJ3+QuNePej
 mBlHv8BnYRJIj0c4/OjESqVAgHolge+8iX6IlQ/Je5N+DphPJIW2Sz/qQsERJH1wsJ0HlaKfryF
 E5dNwmBvBz5PXnQPptJSpJXqEpq/SZ5cW/vIbQIiAlzUyO56RlC7h6E=
X-Google-Smtp-Source: AGHT+IHEKWMLADOTUxdUcPINuFaigL9xx0ARgt306pyjiDqEXE54xu4HJsnViYxjZfNPyNHQJpfPQQ==
X-Received: by 2002:a05:600c:6c95:b0:438:a1f5:3e41 with SMTP id
 5b1f17b1804b1-438a1f53fa6mr346012555e9.12.1737978906511; 
 Mon, 27 Jan 2025 03:55:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54bfa5sm128347995e9.25.2025.01.27.03.55.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:55:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/10] target/sh4: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 27 Jan 2025 12:54:24 +0100
Message-ID: <20250127115426.51355-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e3c2aea1a64..9d3e6cb2fd7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -134,6 +134,11 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
 
 static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+#if TARGET_BIG_ENDIAN
+    info->endian = BFD_ENDIAN_BIG;
+#else
+    info->endian = BFD_ENDIAN_LITTLE;
+#endif
     info->mach = bfd_mach_sh4;
     info->print_insn = print_insn_sh;
 }
-- 
2.47.1


