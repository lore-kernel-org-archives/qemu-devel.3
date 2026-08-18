Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EFEC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwND0-0007ly-Om; Tue, 18 Aug 2026 13:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCz-0007la-4z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:41 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCx-0004to-EW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:40 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so29186a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072558; x=1787677358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Pj94heN6UWYtvUEx68rDu4510kAyKsMZVzdju/rCoo=;
 b=CjiFA82GGfrbfCuzisbWnl+Ov/s0U/ZT6zMGtSa87/5QG1Vq1FQPF8zEHmDPT5AlZ5
 EzeEDx2mOBSSNtG6xdvAii0UN+vkgGKxsrTcn5PifdQmghfVw1BVsoglJCIzD8TAYIrf
 HE+wpgVCOmA3vHkAvMTa/q2WbXwjUV6wWhc7y03xC80ZMYPh5kjXkXCwMeU8r6IbJiw3
 hz4ewrGh8IEQV8hmcdUrnscf9hjTU2doiGDYqJ9wk4iaKKk5h1IrH8F/LJ27mQrCizBc
 9NXe7pOT8eOvkJ0OcZ+sIBnb2gFj/kPhKdpwRHCvt+IiDZpLD/kc5funqSLOsw4udSs/
 mEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072558; x=1787677358;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Pj94heN6UWYtvUEx68rDu4510kAyKsMZVzdju/rCoo=;
 b=EZSRZkK7Hhvzi5PJScNl5VQ1bfJiQcwrVVjipNfEBl5iIPp7ewrRXvqpFy2VGFwntI
 v6G7m4VYR/iWlUH/2o45HinrTiKAi6hEK1hYnAS6xeVkVIJNhSEi3PpEBETfgGxdyKuJ
 JF5LTPYDSIJ641eTeGyJduRwHICdLoPeiTDXGXEVx7CtQdKP33oLa8J9GyWPdPEJNpRe
 EkPdqrRaBCpVMQiTEnoL2byTh4znEJbfnfZnTZFD42vQsedt/6InpqAlO7Z35y1Ua3yn
 KoYQEWJul5jQfvG0YGjDU44V7WGCAUEMtBMCNtA60j3yMRKBeAMQQymXjBwDgO6P46+x
 RCUw==
X-Gm-Message-State: AOJu0YzWXiLK7ZjkyDDC1FP4iUpecAmzfHtyM+7KWLoSvMCl4rF//+ib
 u75D17X6W2alSE0mILGw0oUFwAXKjcm6TcQ/DzEKrcSgboOtn24uSZkZlOpcpr8OisH4Cp4j1el
 bYFJkR5E=
X-Gm-Gg: AR+sD13NEW9WpPJnMg6ieSVYsuoNyILAHQzu3Jm7AgYFnUVcfqkbmzC4wxdSa0/mjRZ
 0bWqCZhtJYBqfGf2xCTV9efkgry4x8f27auFXHutRUwSM75y36CT/kDwS1sVbVQllEOI4K+wH6E
 /guFaF1ZlblpNkxqJU0ZeC4QjAIFeP6dwr5v0ktAMiUyRDw7RhU1bYU6x6zFLxr9S1Op97Y7GFC
 1eYXZ5PV5oysicIkVDIUycUfsZoI9WqcUkF46DaM5jgJgnMEDb4b/zNsXTHMwHh9CFIFcLHajEC
 ErNAO3i5Q1CRUDElmoi46Vh+4SpXmKY+/GklvhBvIak1155vv+6kXvEpreILH3xJ88MfhK/yWBu
 eqcydYQ9KX5N7wXTj7A+FYAq155e3L5Nc+hIXb3WKwlNgR4Gg2EExwduOUKP3pSF0XlSHYKJl1P
 7cz3zsAcVtCpCaAB8nIfuWDOJKu8opI6sYwzJfulXDEcnyiHGdqfxBsm6MwGGocf9P9XBBKZT5e
 hW0eHQAkQtr5Bhkd3nVbWck3q6U7kJJb6g=
X-Received: by 2002:a05:6a00:8c6:b0:84e:9257:d0c2 with SMTP id
 d2e1a72fcca58-851b877ad03mr13970649b3a.9.1787072557905; 
 Tue, 18 Aug 2026 10:02:37 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 35/38] target/loongarch: Enable disassembly via capstone
Date: Tue, 18 Aug 2026 10:01:52 -0700
Message-ID: <20260818170155.1907006-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Song Gao <17746591750@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 6 ++++++
 target/loongarch/cpu.c   | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index db1abe7f70..a922f7627f 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -40,6 +40,12 @@
 
 #endif /* CONFIG_CAPSTONE */
 
+#if CS_API_MAJOR < 6
+#define CS_ARCH_LOONGARCH       -1
+#define CS_MODE_LOONGARCH32      0
+#define CS_MODE_LOONGARCH64      0
+#endif
+
 #if CS_API_MAJOR < 5
 #define CS_ARCH_RISCV           -1
 #define CS_MODE_RISCV32          0
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index cb07f15110..8cd5bc18a3 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -29,6 +29,7 @@
 #include <linux/kvm.h>
 #endif
 #include "tcg/tcg_loongarch.h"
+#include "disas/capstone.h"
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
@@ -694,8 +695,15 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 static void loongarch_cpu_disas_set_info(const CPUState *cs,
                                          disassemble_info *info)
 {
+    CPULoongArchState *env = cpu_env((CPUState *)cs);
+
     info->endian = BFD_ENDIAN_LITTLE;
     info->print_insn = print_insn_loongarch;
+
+    info->cap_arch = CS_ARCH_LOONGARCH;
+    info->cap_insn_unit = 4;
+    info->cap_insn_split = 4;
+    info->cap_mode = is_la64(env) ? CS_MODE_LOONGARCH64 : CS_MODE_LOONGARCH32;
 }
 
 static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.43.0


