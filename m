Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A16E9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurFN-0005b3-4X; Tue, 24 Feb 2026 07:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurFB-0005YP-Pb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:25 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurF6-0005sH-8L
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:24 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8f92f3db6fso883470766b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771935018; x=1772539818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrVJ9tdMlXwGedNfsdtlslEQzbHBYQL/tzdi3zI1jrg=;
 b=s5U6QSg0UJHkC9tz7eQ/GiNckPtIn5gcxipW+T3yxIxQ1+pMfk0w2iVE3iKTBbnoBB
 czID9cWSASprqB+zd7x49Z5q21Ak4gnGR4RdMC/sLsoccKT9oXiA4DlGXtLLQUMKglpk
 bZOtEH+kl01JrIZE0PEYulVFT4feduiEe6Bd/wMNoDyV1T8Z2LCl4q4dD6REsDbUHWR3
 JGD2lkBWo+7bVkOJEOMcfjscYXG3XdCiNRPXIcQjbXWLlSU+9vVIJE/9RuuEkBlyrFPw
 xSGp5dvapjIrOjQOUNi97jKXixrT6x/QQVv4lDOzhQLI8cvevOuPW5dd5/5jS/LIBQ9Q
 lSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771935018; x=1772539818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SrVJ9tdMlXwGedNfsdtlslEQzbHBYQL/tzdi3zI1jrg=;
 b=SQh8iQzjHDfSPo1F4HEEmw79G4RKAanZEdtuKJKiHzBBriJwRiUFTBcQKDWL5diXpx
 ztq1U2z/csrXVI2Wqn3UosGcbYjiVtiC8xQP0D45y7p5DDvf9LhoK3vikzwcFcqmHaht
 VMak6VMz5k+2taolWb9UlIniPLhuNTfLNCwnPJrjrII6nr82hctYbIVk87pWX8dFw/d5
 Se69BQqZJm46i9burqlWr5/2cLgXpU7axpPCV5+ohafL1C3S7EWbiltj2x6OtldnjbrJ
 0L/dEYgCtkWSO2PmgczOE5QZAnTajG2ZHpFJvqea/P76lWsmKCkcyVgJLlFTNnhTiL3K
 oMfQ==
X-Gm-Message-State: AOJu0YziKIkhGM9mb5CAYo6Ydewyjt1f8qJFDftwZfAp7BWNXb7ggfQT
 5dJpt8AbSTIOFEoBisQmXtrxIrQ235X721oxnS7HOcnnU6DBgoKr0IehsxKeHhE9x/g=
X-Gm-Gg: ATEYQzzCJ4IPKM3B465bm5lJiOCVseuVibGx/p0tXCP5RgAGKeD77bVeqZ1KodH9Poh
 deU2jMCXc64T5hwPqXK1Ign+83IS6qqFdEkq7WevNiETF/Qh8hSPsHTmHfgnG9Ho8bycD+fKulb
 UmOt2MS4AbNPqdadMuhBt+r0x7ZS0NtJd0HrNsib9dU+KTSltxGrxYj7tD8l6GXlFU1LyyKVXGj
 syYvJtezqcKNkwJ8b4Fxf2bvQsNAF1oDeu6yO3uw1bn8WKMDADLZiUMqyL2OdXiOaRT6PU+sk+u
 kEBAfrEQZtrcZ7LRzRClbNuS88YW4UjNWq9Tz6nxsbn/7IvAIRQnOIVgcjBjRqdG3o2js7QpLra
 YHb2wE6HEWxw5IR18plUkz2olROpCvgeFrDxh/kP3nsjak+iEWxVCD/zK8fWZcCMXfSlIb0O+UT
 1eDkHDT69gs847Usu7ZCovM3M=
X-Received: by 2002:a17:907:3f9a:b0:b73:1634:6d71 with SMTP id
 a640c23a62f3a-b9081a4cbf1mr805748666b.26.1771935017847; 
 Tue, 24 Feb 2026 04:10:17 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084e8b790sm421996066b.49.2026.02.24.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 04:10:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E7BB05F8D0;
 Tue, 24 Feb 2026 12:10:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/8] PLAN.md: add plan for the current work
Date: Tue, 24 Feb 2026 12:10:10 +0000
Message-ID: <20260224121014.279248-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224121014.279248-1-alex.bennee@linaro.org>
References: <20260224121014.279248-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

This is entirely generated by ECA/Gemini using the
gemini-3-flash-preview model. My initial prompt was:

  I want to generate a PLAN.md for a piece of development work. Recently
  support for WFE was added for M-profile but I want to extend that
  support to A-profile along side proper semantics for WFI, WFE, WFIT
  and WFET instructions. That includes setting the full ISS fields for
  the traps (RN and RV fields of the ISS encoding from WF* intructions).
  See syn_wfx() for where we currently build this up. Keep in mind we
  want each commit to be kept small and review-able while maintaining
  bisect-ability. We also should think about how we can test and defend
  the functionality in QEMU's testing suite.

This will form the "guide" for the agents next steps.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 PLAN.md | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 PLAN.md

diff --git a/PLAN.md b/PLAN.md
new file mode 100644
index 00000000000..49f330b802d
--- /dev/null
+++ b/PLAN.md
@@ -0,0 +1,77 @@
+# Plan: Extend WFX Support for A-profile
+
+This document outlines the plan to extend WFE support to A-profile ARM and ensure proper semantics for WFI, WFE, WFIT, and WFET instructions, including full ISS field support for traps.
+
+## 1. Syndrome Enhancements
+
+### 1.1 Update `syn_wfx` in `target/arm/syndrome.h`
+- Modify `syn_wfx` to include `rd` (RN) and `rv` (Register Valid) fields.
+- Ensure the bitfields match the ARM ARM for EC 0x01.
+- Bit layout:
+  - ISS[24]: CV
+  - ISS[23:20]: COND
+  - ISS[19:15]: RN (rd)
+  - ISS[14]: RV
+  - ISS[1:0]: TI
+
+### 1.2 Update WFX Syndrome Construction in Helpers
+- In `target/arm/tcg/op_helper.c`, update `HELPER(wfi)`, `HELPER(wfit)`, and implement `HELPER(wfet)` to:
+  - Check `is_a64(env)`.
+  - For AArch64: Set `cv = 0` and `cond = 0xf`.
+  - For AArch32: Maintain `cv = 1` and `cond = 0xe` (or pass the actual condition).
+  - Pass the correct `rd` and `rv` based on the instruction.
+
+## 2. Instruction Helpers and Translation
+
+### 2.1 Update `HELPER(wfit)` and `trans_WFIT`
+- Change `HELPER(wfit)` to accept the register number `rd`.
+- Update `trans_WFIT` in `target/arm/tcg/translate-a64.c` to pass `a->rd`.
+
+### 2.2 Implement `HELPER(wfet)` and update `trans_WFET`
+- Create `HELPER(wfet)` in `op_helper.c`. It should:
+  - Check for traps using `check_wfx_trap(env, true, &excp)`.
+  - If trapped, raise exception with `ti=1` and `rv=true, rd=rd`.
+  - If not trapped, check `event_register` and timeout.
+- Update `trans_WFET` to call the new helper instead of just setting `DISAS_WFE`.
+
+### 2.3 Refactor `HELPER(wfe)` for A-profile
+- Update `HELPER(wfe)` to handle A-profile:
+  - Check for traps using `check_wfx_trap(env, true, &excp)`.
+  - If trapped, raise exception.
+  - If not trapped:
+    - If `env->event_register` is set, clear it and return.
+    - Otherwise, halt the CPU (`cs->halted = 1`, `cs->exception_index = EXCP_HLT`, `cpu_loop_exit`).
+
+## 3. Wake-up Logic and Event Register
+
+### 3.1 Update `HELPER(sev)`
+- Ensure `event_register` is set for all CPUs, not just M-profile.
+- Kick all other CPUs to wake them from `EXCP_HLT`.
+
+### 3.2 Update `arm_cpu_has_work`
+- Modify `target/arm/cpu.c` to check `event_register` for A-profile CPUs as well.
+- This ensures that a CPU halted by WFE wakes up when the event register is set.
+
+## 4. Testing and Verification
+
+### 4.1 TCG Tests
+- Add a new test case in `tests/tcg/aarch64` that:
+  - Executes WFI, WFE, WFIT, WFET.
+  - Verifies that WFE/WFI halt the CPU and can be woken up.
+  - (Optional) Exercises traps by running at EL0 with SCTLR_EL1.nTWE/nTWI = 0 and verifying the syndrome in a signal handler or a small EL1 kernel.
+
+### 4.2 Regression Testing
+- Ensure no regressions for M-profile WFE.
+- Run `make check-qtest` and `make check-tcg`.
+
+## Commit Breakdown (Proposed)
+
+1. `target/arm: Update syn_wfx to include RN and RV`
+2. `target/arm: Update HELPER(wfi) to use correct CV/COND for AArch64`
+3. `target/arm: Update HELPER(wfit) to accept rd and use correct syndrome`
+4. `target/arm: Implement HELPER(wfet) and update trans_WFET`
+5. `target/arm: Update HELPER(wfe) to implement proper A-profile semantics`
+6. `target/arm: Update HELPER(sev) and arm_cpu_has_work for A-profile event register`
+7. `tests/tcg/aarch64: Add tests for WFX instructions`
+
+🤖 Generated with [eca](https://eca.dev)
-- 
2.47.3


