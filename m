Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBF2C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCy-0007l3-DP; Tue, 18 Aug 2026 13:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCw-0007kM-Mv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCv-0004t2-7C
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:38 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-851cbd64814so79016b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072556; x=1787677356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cm60cTHKSfIokrOsMkIE12y9wwPsvnpPsXy0HmIZSdM=;
 b=EtzZtT3qpFGNNRT2fwmhcKMYrtDTJ5uYym6tKZap0oRivpBvIWC4eODH70njlafH3a
 fqlCABGGJKI9N1Z+4L5+Xn4aH0sTQAcl/en1qB3GFTe1G9NBuBd9Xj1/YMqyDPe0y+jw
 gyOCEIykV5b6sZn4aW05eZ8R/tQB9ozWqpGgyESJ4IrYAGiE8rDHEfURVs8E8Q4bpZif
 viSY4GdaWh+u7a4lqHSkvlu6HO5o30vllZFzncLvvLKp4RQXeZEGutub+anatjK9xDAI
 XSwjrla0i2SBswpf9egVQJYa578zNFOdA2FGaNigMGBOyfQJmQFXFmR5sifRAHRGbD1z
 U1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072556; x=1787677356;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cm60cTHKSfIokrOsMkIE12y9wwPsvnpPsXy0HmIZSdM=;
 b=JPtqUpFpESpnhANdbnOx/DHPxvy0cgFFPYOdV4RkBOPj0F0di7uVThfUvCk3nZ/ZEX
 0wx95Z/mcA60KSDhlgGBUnDEg+XNeMbrIGH/LFmi8z0b6napkwRyqYau8XNCGVj5Igeo
 EinfubQoiuBU9icYgmELDXlak3YBxxGTH07Wro0rvOpd2pjjTh6/11upwjDpj9HuVW3C
 auLCDV/lRP/2UAYq6twdD6DdxBlF/9pbsizcmt46oj3EXZfTOK+iLgtQgyiGOkcGd4Bu
 cGxJA3jfvjylK/cpH9JJd2s7oe9jMulMvPps8DS9QVkKL3FikfYROQT6rF+9EVJiGqim
 qSYw==
X-Gm-Message-State: AOJu0Yw+zLEBoCT3VdgfhikQb3KrJLey76C6IARui2TAVAghZvvep0Yb
 tvi4dlNCBq1KieQ9md7CRO9JRzoEsON9T5Bwo06KL5Pjt1ZGOHza01p238wKICsYhv0U66Euo1U
 A9JtKdq8=
X-Gm-Gg: AR+sD12fDEqcb+jSdWTU9I5A5+UBVeN/mZd3X89CSDDVxEKbeUZDb1qIStE+o6J1s2I
 u2uAMwjQnkFX6hF9olpOXe7MU18cRFwH4hMEFkj0r+4qQK/BKyq+lxe39fQ+zzZSLqRC3sqqZSP
 cLgWq1arWL3e6xEqgQ4fpSRaYvo3ZyfScuKW6iRvNRwpqHG2cgPlErjZhHpDkHmPqaZhfARHfOu
 qfThptln3iTZHgZLEaWQgPi8mNVfKfGDyuLn/jZyUSZH19c2/KtLHhDt71ciSQlqYDbaNFvq0Lj
 Zbov0+arBGH8J4h2DS23WsKgPjfPGjTb0xEn64CyaVl8G50NWRAchCgY2ZVglnYiQgWP+tan/3P
 nQptPM5hRpl4FZFB35WmpO1VxQpWn+fKdfnpw3VGbppQcHg6q5dSLmRhlOX36F4fPDmbWxVYEpG
 IpFgEkA3lyfh8lAeUOK2xGV3W9WOTnDLl+GLAu2LuTr3Bd0RcwE3cg76HHtG3KXJpTZxj1y/vbr
 VtjEKNcr4Hb4kczMssLL5yV/YJGKIgid8+Nkb0lau9ZBBM=
X-Received: by 2002:a05:6a00:1ca6:b0:846:de21:3da4 with SMTP id
 d2e1a72fcca58-84fde367c8emr40648396b3a.3.1787072555832; 
 Tue, 18 Aug 2026 10:02:35 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 33/38] target/sh4: Enable disassembly via capstone
Date: Tue, 18 Aug 2026 10:01:50 -0700
Message-ID: <20260818170155.1907006-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h |  7 +++++++
 target/sh4/cpu.c         | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index 5c78824da2..788f90771a 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -71,4 +71,11 @@
 #define CS_MODE_RISCV_VENTANA    0
 #endif
 
+#if CS_API_MAJOR < 5
+#define CS_ARCH_SH              -1
+#define CS_MODE_SHFPU            0
+#define CS_MODE_SH4              0
+#define CS_MODE_SH4A             0
+#endif
+
 #endif /* QEMU_CAPSTONE_H */
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ad2ec28c1b..3bbdee301d 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -28,6 +28,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
+#include "disas/capstone.h"
 
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -167,10 +168,23 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
 static void superh_cpu_disas_set_info(const CPUState *cpu,
                                       disassemble_info *info)
 {
+    const CPUSH4State *env = cpu_env((CPUState *)cpu);
+
     info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
                                      : BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_sh4;
     info->print_insn = print_insn_sh;
+
+    info->cap_arch = CS_ARCH_SH;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 2;
+    /*
+     * Possible capstone bug: the isa levels are not additive:
+     * least significant bit wins, so SH4 overrides SH4A.
+     * Work around by setting one or the other but not both.
+     */
+    info->cap_mode = CS_MODE_SHFPU
+        | (env->features & SH_FEATURE_SH4A ? CS_MODE_SH4A : CS_MODE_SH4);
 }
 
 static ObjectClass *superh_cpu_class_by_name(const char *cpu_model)
-- 
2.43.0


