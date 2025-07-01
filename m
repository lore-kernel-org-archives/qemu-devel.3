Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B0FC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCy-0002RD-Ln; Tue, 01 Jul 2025 10:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCY-0001kt-Eg
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCR-00073O-1T
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso3061104f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380982; x=1751985782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZVwfUaPu+BzW1eaAwnv15woF4igMTOdkeJWF9UPUpQ=;
 b=sj5tnHS+yyF4VrRbkEk68E7wW3RymwEo1WhS207Afoi+J86jhwCnvCQUIcV4o6Q06h
 YZb9Cbgm6SuY/QA/7oyMfD7CkBgaHv9Q+07ok2haIV+Pd/JzsLWaJdlzfwy6fzMBQ3OV
 UxPyztzghnChiNemeqdSFfHqhodwrEMHxxz3iBy2w9CyB4ASUOu3shYSXQ6mN485OXdU
 ZhK5JbTCqUcGafe/kEQWkcpkn2gNJrmUWF9OT5qO9l2m2cYYTZomK1xjJm22rSu57BQP
 MHtGkOXx75nwZ3vUVvn+o1UlFK1NpBXDxx+gBINGLeJqDtwJcF20H8+Zb2yjR/pzIJPy
 jBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380982; x=1751985782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZVwfUaPu+BzW1eaAwnv15woF4igMTOdkeJWF9UPUpQ=;
 b=Pu/IGxlf3UNwv+9KwUc9xYIvpgitQ9WSmQUMH1T7XSCpEAFmhY5l79lRfHXwHmbdyK
 JO6Fm4Nt0CnEadl1DWfieYxQ5XAiPxB0DVdUwhlyh7g+syo31lWRj4rz2CHE6KIe8MSc
 YGWhyX6AwxUh914SWEeae36paPMVef+QUzKWyWjdDJJ+HncIA+qumBVbUHSs8vXzyVyT
 cdt87Jmse2uiCemk3WvfrqI8Yszfakdom74h9EqTrCKtUe/WtEfByB3IigLg4xSAUsGr
 iGVDYfat2ef/H7u731p55olfdP6S4kDIRSNabagAOhnugzrqO6qxuJPAoEcrKmmXhHtZ
 MD1A==
X-Gm-Message-State: AOJu0YwhcQSLxH/CvgI/PjRaxT78qx05y/DoF2IrkbNQ3CuJy9mfLp0o
 qY4X+foKWmDQ4hCcKg+GNOErpu4dfDG3IZ/RTI3lfCaZVdnKBc2vCoFazBCMtAUCkfk6R7HWQFF
 PJQCv
X-Gm-Gg: ASbGncuThPesSbdpKsuiEa133c6ao/CJ2Ais/A6z2bWOLIZICE/q6+08PzYLmT5eGRh
 NVWhqtl54WLJDb48/ocA/wkjbn9LnfWPACQHCLpMwjUsW7DK0IWwOtyNCNfDo8zZzmk+Z4YiDy7
 P9Jv138CJ7p3waWifPzoeGGbKSajGMw7dRZzeoUGP7vH4SSqMRctQA9xuF3Cx1vuAhmPkgqVPuy
 PfSLb7qgo5TYGuG8KBiV6x/yBJEFJZzqaCKu/5bu4RJWochaer6R4igACeMcjueFxpG5DiBB1Z7
 iCPLAFCgL5e7fWvbCRxcVXhK7PrUdgeRMLc4ns9XC7LosBIAP2BSscxFgBmkR4TBpaXlJ25QP8w
 ZtvaKG1suK7ZsUn1S+q3zcIXbvWBFmGtmJ2i2
X-Google-Smtp-Source: AGHT+IFgQw0afPbX8ExizgihQzU0li8a6NF/2DsckfF/vBjg0FRNBFO1B5K6Mcgi31L53K79mmcJlg==
X-Received: by 2002:a05:6000:41fa:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3a90b6dfbb5mr16443651f8f.47.1751380981636; 
 Tue, 01 Jul 2025 07:43:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c2esm13637518f8f.53.2025.07.01.07.43.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 30/68] accel/hvf: Move per-cpu method declarations to
 hvf-accel-ops.c
Date: Tue,  1 Jul 2025 16:39:38 +0200
Message-ID: <20250701144017.43487-31-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 29 +++++++++++++++++++++++++++++
 accel/hvf/hvf-all.c       | 29 -----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 8876a026120..8242a78c0c0 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -50,6 +50,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/queue.h"
 #include "system/address-spaces.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
@@ -486,6 +487,34 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
+{
+    struct hvf_sw_breakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
+        if (bp->pc == pc) {
+            return bp;
+        }
+    }
+    return NULL;
+}
+
+int hvf_sw_breakpoints_active(CPUState *cpu)
+{
+    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
+}
+
+static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
+{
+    hvf_arch_update_guest_debug(cpu);
+}
+
+int hvf_update_guest_debug(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
+    return 0;
+}
+
 static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 8c387fda24d..481d7dece57 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -12,7 +12,6 @@
 #include "qemu/error-report.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
-#include "hw/core/cpu.h"
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -41,31 +40,3 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 
     abort();
 }
-
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
-{
-    struct hvf_sw_breakpoint *bp;
-
-    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
-        if (bp->pc == pc) {
-            return bp;
-        }
-    }
-    return NULL;
-}
-
-int hvf_sw_breakpoints_active(CPUState *cpu)
-{
-    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
-}
-
-static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
-{
-    hvf_arch_update_guest_debug(cpu);
-}
-
-int hvf_update_guest_debug(CPUState *cpu)
-{
-    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
-    return 0;
-}
-- 
2.49.0


