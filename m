Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90CBC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 09:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzXb3-0005BH-1R; Tue, 01 Apr 2025 05:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzXZW-0004bq-98
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 05:06:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzXZT-0005Xp-7Q
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 05:06:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so59105545e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743498369; x=1744103169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ModoBwl9WODpWJ7/22XSJxgnbrp5F28A+dseEzQypeA=;
 b=f+Fvc3EXrLImyHFBsAR3/Hy8HIoIqaDZfjGyyFGTBGkuoc2LLnjJw/ugNpRWyCJ5uM
 xRhSdZDFN2emqzbRJonoIJ/VnUV+Kkx10oyTfCiqqp2nzxyo9VMbOGWZgWoXy9qSxcVY
 1XrXGZIgA7La17hpaRfqsiajYTavuYdUXwB5T/dyzGQagWSP/DdHBr7abBS/Iue8YJEv
 nBsJHcNG7pMj2zhnmZh5NSwJ/xkkDDj5u6/X4ZXCpnWC4E37zC2wlh72vXFWC8gKE0ta
 svE8M0tvDAXKpYPaqGG3wrWFkn0zlAymfBjhb6QHeSFJtiRBvWt1Al7Ye57MOkBqzjP9
 mSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743498369; x=1744103169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ModoBwl9WODpWJ7/22XSJxgnbrp5F28A+dseEzQypeA=;
 b=lOQOEgirWWCe/avqPqIAPPwGSFF5U3Ll/2YoOQPn9JqqZTcNtrHB9CruQtLH1/EwGp
 yRnPda9t9xKBNehSvNTLnOYQZ7bXWZk0wtGTRiifGJWgtvb1VWx8rubmN7Zccbv3SOkV
 +JslRcllSCnV6E9tCeranoMRtO16dbLwIx9ZNJQGDUHZ0OYSdrWCcoCBDzlEZqp4ANMg
 SJqIx7klWAl1YVgApaoqZDXjqCMMjwoEPDgr/+HjfMBPc52XQL24zaANmp8asrVn4sOC
 eWe1sW/UOzITKyDTYRCvc0ZcF+2tzbAr2POeZ7taHRSZiO3Z2jBkgN7ua+WXHoPmi1V4
 E9Ww==
X-Gm-Message-State: AOJu0YyqiDgok36Y0dZigRfahbfxVMTNafLnRXtRkXDppnLMOkIxKvVA
 adYUW0Q+u/IK+nygwgiPttCFYzeSgHkqQqiz9k6LiUR0R43h4dqCVnohGGnTMVll2AnGbMgEl71
 q
X-Gm-Gg: ASbGnctZmuXvopzZ3h8j7+mme8HuKdbFgHPzflE7LrBEQuikHm66sw0ng5KxM+oUBnz
 T2n5Jl9zPhAQjrQzVQRoSb4SG+WjFDADFvD/a/QRcY9bP0A04kjhdNz44PpQQziFglhugnJqXjO
 tD5XFbXuU+Or2y3wnPo6LIlHRQMLhw7zwo9fxrHqcKxxNAh+avpqLkWZuB4gIyfm6nUnChATbBn
 g2SWqgC0tMfIoF0ZYns3FqnlpMt70z1hSefHVQJxEbNvY0wppcCKaYQnwu/U6JO9v6+TrhL8pVZ
 6kqqyAgkI7yyxvCVdd3DWvAy65w4MIjPfA62RQ/HlOPHfAxBysSUItHyTIU+ukzjAr7r1Cyeuok
 AeZkqWR9yMRshmJwAUcI=
X-Google-Smtp-Source: AGHT+IF/ZqUEWEJcY9uABjrIwHvEfJTa4nnJCcDSw1OY6DlmufwPYcxadGO4sbqhRkuGNHeHSpRtnQ==
X-Received: by 2002:a5d:6d84:0:b0:39b:fa24:9519 with SMTP id
 ffacd0b85a97d-39c12117ddemr8727460f8f.35.1743498369011; 
 Tue, 01 Apr 2025 02:06:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d830f5b41sm198104025e9.27.2025.04.01.02.06.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 02:06:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.0] hw/vmapple: Allow running QTest framework on
 macOS
Date: Tue,  1 Apr 2025 11:06:07 +0200
Message-ID: <20250401090607.36375-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

First, the VMapple machine only works with the ARM 'host' CPU
type, which isn't accepted for QTest:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

Second, the QTest framework expects machines to be createable
without specifying optional arguments, however the VMapple
machine requires few of them:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: No firmware specified

  $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
  qemu-system-aarch64: No AUX device. Please specify one as pflash drive.

Restrict some code path to QTest so we can at least run check-qtest,
otherwise we get:

  $ make check-qtest-aarch64
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
  Broken pipe
  ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
  ...
   7/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp     ERROR      24.71s   killed by signal 6 SIGABRT
   2/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test     ERROR      71.23s   killed by signal 6 SIGABRT

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vmapple/vmapple.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index fa117bf1511..e16c0c72fe5 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -48,6 +48,7 @@
 #include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "system/hvf.h"
+#include "system/qtest.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -494,7 +495,9 @@ static void mach_vmapple_init(MachineState *machine)
                                 machine->ram);
 
     create_gic(vms, sysmem);
-    create_bdif(vms, sysmem);
+    if (!qtest_enabled()) {
+        create_bdif(vms, sysmem);
+    }
     create_pvpanic(vms, sysmem);
     create_aes(vms, sysmem);
     create_gfx(vms, sysmem);
@@ -504,7 +507,9 @@ static void mach_vmapple_init(MachineState *machine)
 
     create_gpio_devices(vms, VMAPPLE_GPIO, sysmem);
 
-    vmapple_firmware_init(vms, sysmem);
+    if (!qtest_enabled()) {
+        vmapple_firmware_init(vms, sysmem);
+    }
     create_cfg(vms, sysmem, &error_fatal);
 
     /* connect powerdown request */
@@ -541,17 +546,19 @@ static const CPUArchIdList *vmapple_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
     unsigned int max_cpus = ms->smp.max_cpus;
+    const char *cpu_type;
 
     if (ms->possible_cpus) {
         assert(ms->possible_cpus->len == max_cpus);
         return ms->possible_cpus;
     }
 
+    cpu_type = qtest_enabled() ? ARM_CPU_TYPE_NAME("max") : ms->cpu_type;
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
-        ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].type = cpu_type;
         ms->possible_cpus->cpus[n].arch_id =
             arm_build_mp_affinity(n, GICV3_TARGETLIST_BITS);
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
-- 
2.47.1


