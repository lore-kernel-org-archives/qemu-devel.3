Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82715C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wssQF-0000Mc-Tm; Sat, 08 Aug 2026 21:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQE-0000Km-76
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:54 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQC-0002L5-8m
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:53 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso1034979a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786239231; x=1786844031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CMjhGAouHGBJW/4hNYHsxuO6VLA75iUJaQ3M13HdXA=;
 b=U3k809V8Njf08omCmoxMBcqnLkWemSDPXVBR7GMj9Q3RahLCRLGVSIN+x7tGg4G8TP
 XQYdjNgP3rpZ5WFzfWdIymNLdb3cnNorrZxnlURvEZOXDATS3zEBv4FZAv4NmlOYQJku
 19U8XlANC5ubgVz5OUSXyYQEp0qvoljgEWnmX5AzbLQv3PJ38F50MBWoVCkZTxYyKLyP
 l8gB5xMZtCx4S4s4Pm7+wme8gp+ttnDQ3glmetYpQYW5oDwx/gprw0W1GtlpYgfMO9wQ
 WNHEAydJWaViQcmVy2t6Yzuswly0spLdBZbv0GXpvPOl/OwakukUG+uLgfpIA0ubUW5P
 aBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786239231; x=1786844031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9CMjhGAouHGBJW/4hNYHsxuO6VLA75iUJaQ3M13HdXA=;
 b=cKTCkpkZm0P3HBzyzSTkFezQeb+0umFmT0nC+7+PSxfcDc3mnJQCWoG/tEU+lC/vEn
 v7GEzujvMzdFMjmvDgkq/ixPuwOnhRzkc+s/iCTitINlW7wk4fYO5w5BpjoZo8aehUt5
 sw6NGdkWv6mRaALSHsGfqVEAAQ6hZYGp/Mdzh9rEcsUW3f9HDYL9PUA1R+6i0ww20NFK
 WSNvdIn5mZAYAFvSLw5kTRzFQY1+eqsSc0Ov/KtWuDfdtwkGD8i01/mQj92MFsMAK94H
 fdC+40GhsrAZO8kms8gpu7RGGtti4md3qv8vMTLJHQy9U8P/RkizjyfFr4XKwfu+tXYT
 3ssg==
X-Gm-Message-State: AOJu0YyUFQ+nKUASNeyas7Zp95FlqLaoKeZ1WLWHtizJKt2Mv1D+TEZx
 ym6ez+XtAHLBdMsYBQQRSdWVa6EH+DbNuJ9M3hIHpxQXnenU0GKdOktgQpCSKq7XJO2NoJiXzbL
 3DqLi
X-Gm-Gg: AR+sD10tGEjzeU5Zkw75XZ5FXAWV3+XcnPAqqnj0PdgoWjlT+mBF2MLnVp8aZEDCryw
 KzegTVxdGza4hALAskGmA4xLoeI0+5BR0I3gmBPo+lQNP197qUz8VMMOGIPU/wEeJMda8TS4GQP
 Lrv+UsarvhlXHzNWk/jR+MfWbc1k9Oz9zeJTMCfIpiviioAtryzFy1lkZGplFrAh/fCCsET0ThR
 9saN2y502dQcci5DfwyOi0tjMNpI8zhd3dwC+Q9R0ONcUJctpqc7cH8jmyjlSAVBC7QezdWVUm5
 DrKQNKf1BWizOjBgo+YCWOim1Lp6d+TmcPZ95uZEv8BzBp6wUzkZlOTZpSlVCTVoU9b/ngJqSru
 ZmEFs7sE85L55lnFEJHUpnsDq59WhCtKyZ0bPptq13IMGUfHGmOkRNJSgZrN6zTwi+RNC7co1M7
 qSRgvSwMSJbO96u/LEwm6P3EP/3ybevxTlbMa0VwuxdGk0rkt/SRRcoqa1h9MDz3U5Q32y/3Rfv
 RnbYN2zyrSQdqbRAVyl
X-Received: by 2002:a17:90a:d445:b0:381:20b:a9ee with SMTP id
 98e67ed59e1d1-3926213f22emr14128526a91.14.1786239230705; 
 Sat, 08 Aug 2026 18:33:50 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm10067927a91.6.2026.08.08.18.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:33:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 5/9] target/tricore: Enable disassembly via capstone
Date: Sat,  8 Aug 2026 18:33:39 -0700
Message-ID: <20260809013343.664966-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809013343.664966-1-richard.henderson@linaro.org>
References: <20260809013343.664966-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 11 +++++++++++
 target/tricore/cpu.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index 788f90771a..db1abe7f70 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -78,4 +78,15 @@
 #define CS_MODE_SH4A             0
 #endif
 
+#if CS_API_MAJOR < 5
+#define CS_ARCH_TRICORE         -1
+#define CS_MODE_TRICORE_110      0
+#define CS_MODE_TRICORE_120      0
+#define CS_MODE_TRICORE_130      0
+#define CS_MODE_TRICORE_131      0
+#define CS_MODE_TRICORE_160      0
+#define CS_MODE_TRICORE_161      0
+#define CS_MODE_TRICORE_162      0
+#endif
+
 #endif /* QEMU_CAPSTONE_H */
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 472c24ae32..c3c9b7ef02 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -24,6 +24,7 @@
 #include "qemu/error-report.h"
 #include "tcg/debug-assert.h"
 #include "accel/tcg/cpu-ops.h"
+#include "disas/capstone.h"
 
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
@@ -35,6 +36,35 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
     return "tricore";
 }
 
+static void tricore_disas_set_info(const CPUState *cpu, disassemble_info *info)
+{
+    CPUTriCoreState *env = cpu_env((CPUState *)cpu);
+
+    info->endian = BFD_ENDIAN_LITTLE;
+    info->cap_arch = CS_ARCH_TRICORE;
+    info->cap_insn_unit = 4;
+    info->cap_insn_split = 4;
+
+    /*
+     * Possible capstone bug: the isa levels are not additive.
+     * Work around by settiing only one.
+     * Note that TriCore 1.3.0 is the earliest we support.
+     */
+    if (tricore_has_feature(env, TRICORE_FEATURE_162)) {
+        info->cap_mode = CS_MODE_TRICORE_162;
+    } else if (tricore_has_feature(env, TRICORE_FEATURE_161)) {
+        info->cap_mode = CS_MODE_TRICORE_161;
+    } else if (tricore_has_feature(env, TRICORE_FEATURE_16)) {
+        info->cap_mode = CS_MODE_TRICORE_160;
+    } else if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
+        info->cap_mode = CS_MODE_TRICORE_131;
+    } else if (tricore_has_feature(env, TRICORE_FEATURE_13)) {
+        info->cap_mode = CS_MODE_TRICORE_130;
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 {
     cpu_env(cs)->PC = value & ~1;
@@ -214,6 +244,7 @@ static void tricore_cpu_class_init(ObjectClass *c, const void *data)
     cc->gdb_write_register = tricore_cpu_gdb_write_register;
     cc->gdb_num_core_regs = 44;
     cc->gdb_arch_name = tricore_gdb_arch_name;
+    cc->disas_set_info = tricore_disas_set_info;
 
     cc->dump_state = tricore_cpu_dump_state;
     cc->set_pc = tricore_cpu_set_pc;
-- 
2.43.0


