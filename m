Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459BEC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCy-0007lH-V4; Tue, 18 Aug 2026 13:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCx-0007kt-S1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:39 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCw-0004tR-Ch
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:39 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84847482584so980000b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072557; x=1787677357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g33juf5c3dA6H2IeYYXITtBF1sk/zaL/b6eznyusN5k=;
 b=G8v6/j8kwKYtLRBWc59/ktqwcepeDc7/Lxvk9n+1OT6UOs8dL2sBZNr/877aAp9O4f
 onq/tPw3RiX7SIyz8lIK94PmKGmIGPyM9iDO4Pmr+Pla5W5N/aEfv1ap8EC1duCJCdEx
 a9K3oto3v604sPbHcFyYJD6pw+u0buHO9LaQUVJKyVUnn7jxR3Yhvh0uPzvvtynAaYh0
 0s48OBCSas0YpeLZMAqmodNDODw4W1KXRBkbS5ESdBAwRhS3km8vHLpvSvKlwxua3/h5
 qgVjBSTzcRMnde7nfUtXZLeemLiPIk7Vui8PEMweuNQBh/lz9cwn9QGqfBNrku/8Q0C6
 nJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072557; x=1787677357;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g33juf5c3dA6H2IeYYXITtBF1sk/zaL/b6eznyusN5k=;
 b=mgTPKYCf229d9Ns8cha8zSj7z2b1qFQOzir93IQNT9yDU0zfvaXURlGUbBhF9sfXg8
 Ib3yowU5r+CwK5hARLe/uW/304h2PZt/DSgHzEKeQTljPpt+e28fORXTGAvVHw5H6922
 QKzpAwLAKoAgN1lpkqekLPfLyDRZneHxEt/8ejOhY27cPAvOIRhxJR6VTrKAJ3l8SZPl
 9Bc3qdJRWlU+Bxj1iFu2wI12EGr4lZndVvvWHXHK187hq3JOjGxTfkOnd7NB71j5xvvh
 fzwPU30UdpkZKGJdOZ6sY/M2J5WD1L1z159pd7LPNy3ypcRqDYI6+mhG7Cgxa0F2oiJF
 5tuQ==
X-Gm-Message-State: AOJu0YwZaqXEY0WIyN7iLfJWA55zuuiO7Fd7JMOK4VH/tGZACM79WyqP
 rwEDElesHW8hHqcuHamsPP8lgo5huRuIORR3VZIGIOPrLr7FvTsu51hDI51lp5r+KlWn/lEmXnC
 vDEHxTK0=
X-Gm-Gg: AR+sD11/WDVSFjnEdPNAdSmdcxW/0z6ARk/t+Oy7ddNItURvrAjtlHCIkVNT6PJYNLV
 1zK2XW1FnRdUfPVAwno1xRX2qQTGMen3tzCuQjP+HPOzQ1UxR+JlsDQyb5l17kBpYXZTXlGVHaY
 p3AYPpqGnWAnkaoSiOFbPn3rGbNTad5c4Yoq+obIhJKmqBXjkEHUO8r3I48e/6HIol2srp3Ibb+
 eJX18YukO9+f+7nWDj44XTS9BrfyOJ7+kdLM+h+XkdCkF4V7cxFe1rt4MyxeC3C7/1XzTM4fk1L
 4PDXSg8FY6kZmn2hHr2Y6s9P5yaxh1KOggpprNSbPQn/CRCMFU1Fu34KCNYBHij9gkisgK0V1Ni
 WueeCr5lEmv4R++TamhvFlJ0CLZylFMPIldotiB2036IXlfbzIc5cfxf5WIwbCCcLrIATXdoIzH
 SfCEXwMtoJk9Dx7RT9hOHZJByfCb6MBv4vYQQaxCoWg22cJmXmgdFeePLYeGss/mEEqUAHBGvM9
 j2b8oNefbIvAq+sCzK4MLCABSsi9sY4GFg=
X-Received: by 2002:a05:6a00:9494:b0:851:c1f6:948 with SMTP id
 d2e1a72fcca58-851c1f60b26mr5261055b3a.16.1787072556832; 
 Tue, 18 Aug 2026 10:02:36 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 34/38] target/tricore: Enable disassembly via capstone
Date: Tue, 18 Aug 2026 10:01:51 -0700
Message-ID: <20260818170155.1907006-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
index 96e2817dee..dcd5c5065b 100644
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


