Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22229CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29AF-00014Z-DI; Fri, 26 Sep 2025 10:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299R-0000Gu-7z
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298g-0005nc-P4
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1672914f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895768; x=1759500568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r1Aatavlnp9I8vVGVCmlOFy7hlPRhQsimFryDicIoL4=;
 b=gn6t50aKFgFPvLjxoTJZxLSljvn8raKZMyJdt5Kphdh3QpzOBdnv9esv02anW55iy1
 cDW3nzPOD0VgxNq/UxkieXssso0LbRsxWYqk/CmElJSl4+qeWDveL2PHm8xSXSJPsSi9
 RewYqAnErTxxsL/3sFXmSRZiQd39eHV2MyTr6DPV5kp2+ucq3xeaI/K9z+5NtyqryKL3
 NJmFmjk69xCBHjH5Se44xGL4Kd6GeZqsG4dkg9TPKCOJGo1yjM3A02bPGa+1n5DOJ/dn
 dXGeTnKdPkWbjUaWCq7PoCmNMmQvdqvrdHMgVeotSz0SCHqpk4p99q/SwT8bPIs/O/nh
 t65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895768; x=1759500568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1Aatavlnp9I8vVGVCmlOFy7hlPRhQsimFryDicIoL4=;
 b=oDMJPnPE8ajPS1DugweZ3/xJYhRRnZYoIkksxf/Wxeey2B6tuzlEDal7bm0pVEFW6t
 WDTAwRkqhqP2tQvmrTNav/m1dkQs8qAZqWeCRNhhwNCKaAx4V087S3k6y9o+7Buovuwc
 mjmb/oraXOa6tnGy0Tpfgg+ikbQv62y0CKk4ycZu7Hdf5hNw3N/U4qrQLWahy5IFwzKx
 186mKhY+KFtmQdDyj01KLPtmx764gYEib/6ZKLDkGAXo60JXJvenh8/w4zRg4WuUSm5v
 YVqqgUcUwuTEcjbOByOqGv092QmqmmjXu4jXs+EWMlcH12ydZ07WsViuQptvP8T/jAoN
 Zx8w==
X-Gm-Message-State: AOJu0Yw4R8iXlUeWXT33aGbun0TAXYvW4Fl7Hbcclf6u8oYfdom44w0V
 MRFKqMdH1Eq4eK/J7AQv5N0okjsOYavmc3eidXDhETdt0dtz66WsHhxb9xvArnvNHWx9Iv6HgS9
 6+55j
X-Gm-Gg: ASbGnctwJrR8MflDAHb+SmxfBv9SUsh0gXpLfF2ZaXHYOj7V7m/blEM7bjhXuZSuFVB
 x6g9DQsvFf/Gpf+9N/D1UZlQtYJDZoAVChxYpydiBJMXcYBS4IbU95GcfioxJ9V/+edPdbKtIKC
 VFEStHcK7KbLphcNsUBymAWCn9tmK5bUfHEcrKwjr6LvjZEFklh51dBFiWZ+tKC7x+kmyPv1OI/
 dM3bZLaCAQLvVoMk6xO1meJDICBBRl7EaC2xmm8sP/SImqWMgY/o/LBG6MRKbe5Ig/VjluJ27oh
 L9niyNhg9Or0oN+KpXqduXpV2il1t/6h9xp1+cgTDOl++m39T8TjAH9ZHK0CJyhuGcE+6l5rI4K
 KwG5TcFEkVU1TNNrt7heb+PNqDqxv/mrVOC88MM4=
X-Google-Smtp-Source: AGHT+IGZDmVSiEkMPSgp8WpTNjr5A65bAtE9dn7+dVjd/cW6slNwH4/yhN6IwQuY+K3uiJhRo4H8EA==
X-Received: by 2002:a05:6000:2dc1:b0:3d0:e221:892e with SMTP id
 ffacd0b85a97d-40f6617670dmr6987541f8f.27.1758895767920; 
 Fri, 26 Sep 2025 07:09:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/44] target/arm: Trace emulated firmware reset call
Date: Fri, 26 Sep 2025 15:08:41 +0100
Message-ID: <20250926140844.1493020-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c        | 4 ++++
 target/arm/trace-events | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 91ae56dddb2..f8e6749ff99 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -52,6 +52,8 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
+#include "trace.h"
+
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -574,6 +576,8 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
     bool have_el3 = arm_feature(env, ARM_FEATURE_EL3);
     bool have_el2 = arm_feature(env, ARM_FEATURE_EL2);
 
+    trace_arm_emulate_firmware_reset(arm_cpu_mp_affinity(cpu), target_el);
+
     /*
      * Check we have the EL we're aiming for. If that is the
      * highest implemented EL, then cpu_reset has already done
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 252c05a9ebe..badff2b2e46 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -14,6 +14,9 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 
+# cpu.c
+arm_emulate_firmware_reset(uint64_t mp_aff, unsigned target_el) "cpu %" PRIu64 " @EL%u"
+
 # arm-powerctl.c
 arm_powerctl_set_cpu_on(uint64_t mp_aff, unsigned target_el, const char *mode, uint64_t entry, uint64_t context_id) "cpu %" PRIu64 " (EL %u, %s) @ 0x%" PRIx64 " with R0 = 0x%" PRIx64
 arm_powerctl_set_cpu_on_and_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.43.0


