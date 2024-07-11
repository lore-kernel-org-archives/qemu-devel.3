Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E8AC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthJ-0001pY-Hf; Thu, 11 Jul 2024 09:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthA-0001Lj-BZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00063m-3X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4279ca8af51so1041125e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703911; x=1721308711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VVa76nH1IWBVck2wf/ZIatCGXOnyq0MCOhW9do/s3zQ=;
 b=HlIUHNXWjaQ7cXw7CNZtkCTkRhg9OdpXvP/nPhPiQopooIJ7OhlRaHgCgtaZvemBkI
 ztdRPOFbtARy/rXkeFA5Mnt19DndJni3ZZzfUuKFnvYfIbcgLut47NourG6XsmRdri+E
 O5UqNUWRIGQakCRaiGbSNp1yIKpQ8C/0Z3nyOuRuzEt27ZQDyeKElYrq7gMfofdpfV4B
 Xz4RMpuqAQpX/tzT5KR1fzkVmgBlP06PZnuoTNgBUQ5WEr15xvvCQMb+RAHB4zAqDuT0
 40T06V9ZsWWLFqkarXOhH6vXZQsqI6Yjpaonk3g7r+qLWC6s3md1oIGHRlR6C3oQAPmk
 ttvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703911; x=1721308711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVa76nH1IWBVck2wf/ZIatCGXOnyq0MCOhW9do/s3zQ=;
 b=AJwA1lFKHXtMcYJcLnC3sq7HY5Vt46L1FxiTQ//0XFvAqL1PnLasW8t4wQT9UWKFBy
 Qt+YTnvPjIIAvvcu2ageBRnB1eiNucQQnbC/gj7PAVtrEh+q1Bv7cHvZ1ikmeHtEGPli
 umBC9fvOhKPJlQLdyF/sTK1GTxkSWIDP/4aE3YpGtno6xnLbLwkDnhVnXL/aXGqCJh/g
 tlQDu8RIrBi4vbIpA9pbqsv4IRvmxyoNPPgcHROyiPVcTjYp3aCp+jjNOHWuxsHtCYUn
 zT2GGgETMzRfcdsKp+YGxSsYw0P2MLxLkuqn9dYkRCmldy2rEz9YRddF6OWu9L4UeNuQ
 aCtw==
X-Gm-Message-State: AOJu0YybTG+RuRmXscvCgHnU4oDXIoeyOOmprkhCCfpTPk7lNWIUsjmf
 6hKn0l6QKw1ZJIG2+o6a5ue69Leq/WXsd6NxpqB8i9QRuUEIakqCGzB/6DrhH4Zo9JY6VU9zhQa
 oV1g=
X-Google-Smtp-Source: AGHT+IFCEPKXeUaSxasnSqdSyP47gISMj1UXbyhySDKRmXA4igv4YVycuxKze6wERg0QZrAxJadG6w==
X-Received: by 2002:a05:600c:1c9f:b0:426:591d:adb6 with SMTP id
 5b1f17b1804b1-426708fa8efmr54662335e9.35.1720703911274; 
 Thu, 11 Jul 2024 06:18:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/24] target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to
 arm_cpu_exec_halt()
Date: Thu, 11 Jul 2024 14:18:11 +0100
Message-Id: <20240711131822.3909903-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In commit a96edb687e76 we set the cpu_exec_halt field of the
TCGCPUOps arm_tcg_ops to arm_cpu_exec_halt(), but we left the
arm_v7m_tcg_ops struct unchanged.  That isn't wrong, because for
M-profile FEAT_WFxT doesn't exist and the default handling for "no
cpu_exec_halt method" is correct, but it's perhaps a little
confusing.  We would also like to make setting the cpu_exec_halt
method mandatory.

Initialize arm_v7m_tcg_ops cpu_exec_halt to the same function we use
for A-profile.  (On M-profile we never set up the wfxt timer so there
is no change in behaviour here.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   | 3 +++
 target/arm/cpu.c         | 2 +-
 target/arm/tcg/cpu-v7m.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index e1aa1a63b90..da22d041217 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -368,6 +368,9 @@ void arm_restore_state_to_opc(CPUState *cs,
 
 #ifdef CONFIG_TCG
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
+
+/* Our implementation of TCGCPUOps::cpu_exec_halt */
+bool arm_cpu_exec_halt(CPUState *cs);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 14d4eca1274..19191c23918 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1133,7 +1133,7 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
-static bool arm_cpu_exec_halt(CPUState *cs)
+bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c059c681e94..5496f14dc16 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -244,6 +244,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
 #else
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
+    .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
-- 
2.34.1


