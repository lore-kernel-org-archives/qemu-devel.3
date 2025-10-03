Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50634CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHL-0001lq-Sz; Fri, 03 Oct 2025 13:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHK-0001lW-Rg
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:10 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGU-0006Fa-CF
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:10 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b554bb615dcso1832816a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511291; x=1760116091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqJ39C2YIa9w+PuGzpKdBwZww4qTnjylq+zTMQPOtFI=;
 b=mD+ZOnaRVDo40J6Bf6yxglz1tAWeP6W+DHzD7FOwvuEMfkxjHG3TkbcDbMuyAHtlIO
 j0vx4ZN7kKuGVQWWsC6z/s8MbhtJOYjL0GcpvfWrWe+5P4sW9HrVLaCP7H5Sq1UYInHN
 MZoHK5uIr/7GG2oIycqgDTeDg3nbRqHI5lImr5Lou+7sqp6lkV9Fs5T2IJhBFgvWcFI8
 XoHIY6zX2Ast65u+0itiXmog4Dtl0yUaflCZ36j5T35vvv5Rn+Y14aWxo/10okojaMVr
 DaVoTd+iejCrma5bjzauTaoO0uLx6FwJxq1ZHbb+AfmW4DNU0fBYeO8MeQyZmnqK0OjL
 u8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511291; x=1760116091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VqJ39C2YIa9w+PuGzpKdBwZww4qTnjylq+zTMQPOtFI=;
 b=tcEo0dTRinlPnRe8P6KnwxWNPOIfF9wuqboWq7ThKj/R3b9ae9AnWWdDH3+cGrRhD/
 CeyR9XS1FZIn1EtY8/mnDXTUcM6AplwrrVplcrgwvXWDDiAgL1jNyeEwTPquikYznM7e
 jTTqwyrcWagWE3noKZ9ij1byOnr06raZVX+Ar+NrXUhQ0XJXr2B4sLFzVa5hMx7m4uta
 wrvTxqowYjRqE16yY3V4eZNhsH+vrkFk2DpHLtr+r1qKCXuRPrtrEq4yBc6yUbAGv14Z
 /6tFsfzlQtzDt8QLPzFzkd9IuWnmxNC0tIlRQcMb0xBHHb/Iu1Xko/RWoNPHjo6BYNp+
 i7Kg==
X-Gm-Message-State: AOJu0Yy8cOkMDpPbyYSMEiO6SJy4OeDeNiQTEerqkfpYO6I6Iq21Bypa
 wELmsHnSOQR/BDhyRQIRoMiMTCHSKFpTy5Y0ho9vEqFqhX0p23ezp4Bc7WsrDPpPNS2vL+ZoyuJ
 WJVUdOfU=
X-Gm-Gg: ASbGncuefgkonP+8ijGtpRTyMq2d3C0SGjS4V8eCsX2HeBi/0SoKm9/BZCQ9+N0KDOR
 7Rr0IV6lC7bH+JWIYc2HxAWBIrVFkp0oujIaCJEdtJRjoA30DCXWqovfk682uGCs+XWrs+Jo8+z
 VZ266A5mBykaFN3TTteapxpl/JDpb2o+QzyNEeV3Q4igO+mYHrGPyzGdJ104tWRGeg8mSnDM1TK
 ID7yqo2YGfNUn1Qhgy3KIMACuN8wCu5Jk2syfpONhmErH5cvR3QCst2S1hU1DJNnbWcKh9Mt/6R
 K9Uhyp8hYDM2Me5oGU/uo/a9nSoevL5kV0wfW64VIkh1jvSKI/NqFx0Dlpm3WFpMzFyXvqK33Ah
 NqyGNXgUDxQXFccUgcbIan5p0hHWCqD1ARqsu4lCCt1gLefOKac5Z8lIL5JR67S95bYo=
X-Google-Smtp-Source: AGHT+IFVfUSzMiVBe13/eexFXkgvSkcrFIzucZQXU7XrqEeBTPCHCMxpaxKAc9RYTv8nWzynTl8sGA==
X-Received: by 2002:a17:903:2c7:b0:269:96ee:17d3 with SMTP id
 d9443c01a7336-28e9a6fd7c4mr40583255ad.51.1759511290906; 
 Fri, 03 Oct 2025 10:08:10 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 10/73] target/arm: Expand CPUARMState.exception.syndrome to
 64 bits
Date: Fri,  3 Oct 2025 10:06:57 -0700
Message-ID: <20251003170800.997167-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This will be used for storing the ISS2 portion of the
ESR_ELx registers in aarch64 state.  Re-order the fsr
member to eliminate two structure holes.

Drop the comment about "if we implement EL2" since we
have already done so.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     |  7 ++-----
 target/arm/helper.c  |  2 +-
 target/arm/machine.c | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 55c00f484b..eef4ae62ac 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -633,13 +633,10 @@ typedef struct CPUArchState {
      * entry process.
      */
     struct {
-        uint32_t syndrome; /* AArch64 format syndrome register */
-        uint32_t fsr; /* AArch32 format fault status register info */
+        uint64_t syndrome; /* AArch64 format syndrome register */
         uint64_t vaddress; /* virtual addr associated with exception, if any */
+        uint32_t fsr; /* AArch32 format fault status register info */
         uint32_t target_el; /* EL the exception should be targeted for */
-        /* If we implement EL2 we will also need to store information
-         * about the intermediate physical address for stage 2 faults.
-         */
     } exception;
 
     /* Information associated with an SError */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae8948d410..ed046c4421 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9190,7 +9190,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                   new_el);
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
-        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
+        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx64 "\n",
                       syn_get_ec(env->exception.syndrome),
                       env->exception.syndrome);
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6666a0c50c..ce20b46f50 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -848,6 +848,23 @@ static const VMStateInfo vmstate_powered_off = {
     .put = put_power,
 };
 
+static bool syndrome64_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    return cpu->env.exception.syndrome > UINT32_MAX;
+}
+
+static const VMStateDescription vmstate_syndrome64 = {
+    .name = "cpu/syndrome64",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = syndrome64_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.exception.syndrome, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1065,7 +1082,19 @@ const VMStateDescription vmstate_arm_cpu = {
         VMSTATE_UINT64(env.exclusive_val, ARMCPU),
         VMSTATE_UINT64(env.exclusive_high, ARMCPU),
         VMSTATE_UNUSED(sizeof(uint64_t)),
-        VMSTATE_UINT32(env.exception.syndrome, ARMCPU),
+        /*
+         * If any bits are set in the upper 32 bits of syndrome,
+         * then the cpu/syndrome64 subsection will override this
+         * with the full 64 bit state.
+         */
+        {
+            .name = "env.exception.syndrome",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_info_uint32,
+            .flags = VMS_SINGLE,
+            .offset = offsetoflow32(ARMCPU, env.exception.syndrome),
+        },
         VMSTATE_UINT32(env.exception.fsr, ARMCPU),
         VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
         VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
@@ -1098,6 +1127,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
+        &vmstate_syndrome64,
         NULL
     }
 };
-- 
2.43.0


