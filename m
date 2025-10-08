Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EF4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9g-00044B-7y; Wed, 08 Oct 2025 17:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9c-00042J-VF
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c95-0006eO-4n
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27d3540a43fso2936865ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960581; x=1760565381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcOCks6UmABFWVi0tC8ZkV/VoNMSt0hRAlHP6icAWxo=;
 b=B6V1kAq5oTuCeYSIGEQFYnKslDQRTJ09gZOacbDVB8G/w89PDKM8rXHzF2cyjX6Wj0
 B+uXebyP6ITcXkJY5m5MxX/2+rOnGIANLQrweYB57QAu/HOnmV4tCn3G6FjfxVhtYiDf
 Fi8v36+m7kPvfFbW8oC75xzDZK23z6/lpvqRq8liSLggWGkqPxW78LM0d6xOpGESh/RR
 wWXBEUTOu6WIa5EiGzuHpV2KRKIW3SAFl44DmIXNZCsxqF+ANEzHdIVYNq/UXgp0xxVC
 QYH7mPYGWxscdrY3tjvo5pzjpyitvrHtF/jZ3s9AXXhuoXaQ6lBMaEtd0JvPu4aV07CU
 Pu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960581; x=1760565381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcOCks6UmABFWVi0tC8ZkV/VoNMSt0hRAlHP6icAWxo=;
 b=a5FqRG13aP0j/T1n0PtsSvPQBuvx/Vb69yOpWmB3wklQfNQaKP36V/+SQbtOVdNQEN
 XnmSc3J+LCXL9UKKa6IrVJF257ys5jrCqGxiVtInU9wWUaNo6ZDFKspOVN2IIOW4lLNr
 qA5HnHdZ02wcXkmWcDr/rhB0DFCKEYkgqX2Tv5iWjZjWkCMRZjgCf+1HuHvDla6x/EY3
 EGoH1LKjYUipUbb/0Xq3IIVPeiS+apeEEnpe/Aww09g3rGh7paVMx8kurVOa5u/2Ribw
 Rf9UrQlRd5XwpybJMJpuCLRh/hpDziQcZWxQ8CFu5R+ycUmzLABy64VTaXoZlhYq7eKy
 xz4Q==
X-Gm-Message-State: AOJu0Yzl85Fih4/qpUa/8v0IMKL/hFPSkVe3Yqh/ufhA7ts8fMVe0J16
 VVtQj3MM+Al4MivVYG6pGLSDvGe83+x9+g5YeRdZmnxoReCwlrIq1I6057+8DQYm0fq0r8nuN9y
 H4B1KNOM=
X-Gm-Gg: ASbGncsAGJkLjomHlFWO/gIpoutY1QBMAo+LOe1/wc46KEmy1cPfvAroVjq0iOnxjnq
 chwKuMdHsUdyJcIp2kkpuz9G5W4LMfbPDpe6byVL0KSDMXjGhz+13s+iA1S3XmrZ0JF6BTiHuGQ
 ZL2EzfIQJnMkt8OglJ3h3RidWePSRXHjiUaLJwq7RNaAgJIbItN7fnFc5BI4zp+FBYzj+7JLENU
 ZOP+9lLlFQpGO9AxoIurIbBVvZKxzoq4r6Jh7dQgVUS/8CoIq3DLmj1ZpvjoCgmgZ6zCnMz5Spr
 198Rfscq2jxCp+5naQy58TxNQ8Kco0/AXyG5Y2c+mjZcp0sJmbS5mG/d8ouOtWiBGyHfk6QyQMD
 S03cvRUbGvSXiiXxun7SbhV1AajXL0N6E9nQYSWDIdGEO7lIAWNxCmG2F
X-Google-Smtp-Source: AGHT+IFkx1bp/NklMzonOAneiMaz6VUAnT1QJ7ajMjIHXVZ4/nnq/BRP0RlIt33i6YmmVCdFaFlZAA==
X-Received: by 2002:a17:902:ce88:b0:26a:8171:daf7 with SMTP id
 d9443c01a7336-2902723f086mr81679915ad.16.1759960581451; 
 Wed, 08 Oct 2025 14:56:21 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 10/73] target/arm: Expand CPUARMState.exception.syndrome to
 64 bits
Date: Wed,  8 Oct 2025 14:55:10 -0700
Message-ID: <20251008215613.300150-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index c9ea160d03..04b57f1dc5 100644
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
index 37865bf70e..bd5321348a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9196,7 +9196,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
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


