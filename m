Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0086ECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpE-0006DO-Ay; Fri, 10 Oct 2025 09:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cor-00067S-1B
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cod-0003oD-H4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso1425394f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101542; x=1760706342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TCA0a51x/0hU4qwXin7PiPqwLCuzNIeSk89CpOUqDlU=;
 b=NWZmcx4hqIjgfxS/Jt/wQzl7/OOBGDowTsh/sSirzuFvgbrh7QCBgl0wzb+D+ASdfd
 VTehLjzZDjkZx+C/vJmFPK+CBsUHcqfldLahtO2/1CRFkL8s7ttE5xIOP59fIjVlNb+U
 vvJY8XkccLX4W39mf/1fz4WQTNigftp5u//gGqqCj4vM0nlqc0Qgze5VigqO9kyG+ikZ
 Nb6De9mswDXVR0jeAbzD1cgzo0LgBkNb9VDoR/6t5FKoPBgD4OoO197kni7U3PDVX5jd
 ideUPKo0n8zy2lwtnXDsoXIr5EOb+UANsKLOESBK/X+bJOeQmrlTJBtq4LjjJ6jQm1UL
 ifGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101542; x=1760706342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCA0a51x/0hU4qwXin7PiPqwLCuzNIeSk89CpOUqDlU=;
 b=rjeeIlZevevdUo95BSRjZ+xWFeyehr6g68zbKG5wHPlVXZCxkqVX8WaZWPn30p8YlS
 9nhyxq2vRyo+EvTyL3Cp7LfQ8lRbdM70/asYDXUPzIYOcmE+Gh9lqca8bpuVLyR+bFMf
 IH0FXuUzDi/mVjm2nmNJKnKpSh3Ly6fx+jgSQfyUs4vHKxgxgxcpHuy4Pz6kdibqwkti
 27k7M18lI8TDYGp5+6mtnLn/odwZdYf7mvGLCrDIdJvNIARQ+9neIGK9r4lGeSViAxUh
 ny20AmyjGa0sDvaWc7+8Qn4j7hKT0TjTcDEbztELTCj7WPOwVJwhUAynd/vtQtEorjCQ
 f5SA==
X-Gm-Message-State: AOJu0Yw4A/kBfEpiWtX77+su/tDTy1UCacHxmxj5kVHmeH6FhVmuSgi+
 wACnoTLnj7RV87mF8ApmaHIh+aZ9O7I+T62+/gbzkoF1Ocy95dpR0eHNStjq8LZOR8PM0hgpAp2
 JV3Jk
X-Gm-Gg: ASbGncsxr+ONiiXAdc3Vy19qgB/KAdlhRJ2LAamXx5p8SNYgYorlQUswx3FhmJXRwV8
 54quQdj9Yoe02hEemShacRsWbmbfb44lWDgev1JFcng6yXYmx2dYDAVNW6PpAGEnsASi5J+ecYz
 etpEiCnv5Te+I7d90J8WQXSDHozvMKZXgdH+TtAQ+KR8jOwaP+Kc/gCUlOl7u2XbSo7+4kZQvhx
 /GGDkVXXMz9bHHtwzAmasDwylYiyE5oTkVlOJt7J4IFYD5NWH8Pv/y1Loolp0V+sOft1aG3iRYb
 QLSoUFntZEX3vVpbDhEm4pqi135DJJgtbDpCgUvjELUXd2BrLIkQVV+eieO3zgA6rsI6Llr5jB2
 ALeblZQeCbPH7BobL0cJRGzEevTrj3bpBEv2+oKu4e6WVkRhvW4E=
X-Google-Smtp-Source: AGHT+IFC5slyhWb+h9iqyRhpE5DnCk9+lqxGlem8Kx5OKri6oH3y7MN0E64C6QIVsiYzSNoJYPwa9g==
X-Received: by 2002:a05:6000:604:b0:424:2275:63b4 with SMTP id
 ffacd0b85a97d-4266e8e4cd7mr7612106f8f.61.1760101541582; 
 Fri, 10 Oct 2025 06:05:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/76] target/arm: Expand CPUARMState.exception.syndrome to 64
 bits
Date: Fri, 10 Oct 2025 14:04:21 +0100
Message-ID: <20251010130527.3921602-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This will be used for storing the ISS2 portion of the
ESR_ELx registers in aarch64 state.  Re-order the fsr
member to eliminate two structure holes.

Drop the comment about "if we implement EL2" since we
have already done so.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  7 ++-----
 target/arm/helper.c  |  2 +-
 target/arm/machine.c | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c9ea160d035..04b57f1dc5a 100644
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
index 37865bf70eb..bd5321348ac 100644
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
index 6666a0c50c4..ce20b46f50f 100644
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


