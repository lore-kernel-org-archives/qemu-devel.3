Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FFBEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKq-0002Z2-HH; Mon, 23 Feb 2026 12:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKo-0002X3-1j
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKm-0000Jz-D0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso34587655e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866179; x=1772470979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dBwNvGbCOD54Qlf9QuiSd9BdBjRvsnVDp48/gZ6uiLM=;
 b=pwXlsR79QEYIBIQUZ0lY5VeZoVYy6/UlHIaTQxyyowiyiwiafTd/Mx3GCDGPMIoKvv
 xTsuYNL61HSRLhIj9e2Cn+bkwynNTTghgGxDAZyIg1kzxGa2BCGq52EsAPm50NkCX4R/
 zErqfIINkLdVs3xRKoHRWZH0I1BJ7TlPNhDNV0NhjDqBTZQ/Tvixb3bVXTe1N50i8nSx
 /udrb+LijrGlCTb4fSTg0FbgJxGpXAzTdC1xcQEJkrVfyQTan3co5tKK0Bj73+CEOTt3
 Fet4QwTM69AhJmKgVqRX25qTvlahu8zQ1IvfOT/XDO3LOBJ3EvMzfm/OVTtv8Giv1/6W
 VxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866179; x=1772470979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dBwNvGbCOD54Qlf9QuiSd9BdBjRvsnVDp48/gZ6uiLM=;
 b=FpVKGAQVkgK94LQbwNA4LhL4trwhh3BF+emJc6mitkW0vLQYVB9+u7SSu2bMTCiGav
 FFt6hpMdGnhrMj9moZl45bAPPkQO2NFFu1IfXjDCVi/OE76TY8e/7jiPnJSwksa5+DHn
 fEExInIKOnHOV+R40nVXweqs8MdE9Br9h3gq0qXmitxRFZu11eqaJMXEaY4kUj4TlwFk
 +vq7bs/L8YFxTBRfySrnjflNSMYjnEogFBYTbdrP4cU7Is2YFw3BBkAVqkjsUb50zxon
 Eju0VM5IUKASYBcNw3CWDm2fYGdBKSdgwQJ0UnsRyu+QfPxZu5ojhT8A1tChYhMc5iKt
 STaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUArSKbNkkWpC2ewBh8THTS7QS0RkXp6acfyH1b/0fJhZYYL+2zx7hRDusf3RrFTbrgMVDbiJubnmb6@nongnu.org
X-Gm-Message-State: AOJu0YyxnyQoW1A5xXIIoyRWPKzzJ5wD+bOWGuSwK1O7gbGNlqfnP2LB
 7YP+ZcW7Sh/MGOOHuYmQpN8kppwT1otwUH9B6DapQDjdTX6yyG6lkSJaapaZVbLzLhU=
X-Gm-Gg: AZuq6aKMUnYWqZUqBeAQqIj0Wag1A//2DAZiWBcA8AfcY0hIyCudNqdamdXyU6kx7ub
 KAtgWbfzqKRgDbvORhCx26OrO5lyRZg+0QAN/B+BKZqvZ5OnDxrvHrZIgeiTtsfWkY21ecwvGpQ
 Q6iCdhh6ZxT779ABHqg7pE/RRB27Vj9C7MTYLdzjQ1Jd0NPr7AoDxj9rFNm9QLKYFT2WsQU/j9s
 85HcAm8mO+MHSp6LEOQpln02pXFnrxlFa01S38Saw83eeXtBsx9xmDR3vczL80GzAyIQTvoitST
 KEjZI/Mim4eKcMmhlNXrXYaNLYeLFR+Rft5+aGpAbsq5WvpYRMyoGlV88h2ql2sHqW79gLe21Z5
 H0bCSbprIhqnfqizkT6FKcmi3GVF7WAcHc0mQDFaqDhhYay27+ckiafLZaJU1VGOleRs2zMVar1
 tN+PJI7a5ubhqsJRQrqHNLx32sCdygsVY3IXRT2CEhOELsSzEe8hLxVcRORdloeu+jwA/bXhT3u
 eF/eX/KehvNndKj+QvXvnBKIOYPZR4=
X-Received: by 2002:a05:600c:a00d:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483a95bf2f3mr162437875e9.14.1771866178908; 
 Mon, 23 Feb 2026 09:02:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 39/65] target/arm: GICv5 cpuif: Implement PPI priority
 registers
Date: Mon, 23 Feb 2026 17:01:46 +0000
Message-ID: <20260223170212.441276-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Implement the GICv5 registers which hold the priority of the PPIs.
Each 64-bit register has the priority fields for 8 PPIs, so there are
16 registers in total.  This would be a lot of duplication if we
wrote it out statically in the array, so instead create each register
via a loop in define_gicv5_cpuif_regs().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  2 ++
 target/arm/tcg/gicv5-cpuif.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 915a225f8e..b97f659352 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -608,6 +608,8 @@ typedef struct CPUArchState {
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
         uint64_t ppi_pend[GICV5_NUM_PPIS / 64];
         uint64_t ppi_enable[GICV5_NUM_PPIS / 64];
+        /* The PRIO regs have 1 byte per PPI, so 8 PPIs to a register */
+        uint64_t ppi_priority[GICV5_NUM_PPIS / 8];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index c54e784dc4..60b495dd8f 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -225,6 +225,12 @@ static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -382,5 +388,22 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
 {
     if (cpu_isar_feature(aa64_gcie, cpu)) {
         define_arm_cp_regs(cpu, gicv5_cpuif_reginfo);
+
+        /*
+         * There are 16 ICC_PPI_PRIORITYR<n>_EL1 regs, so define them
+         * programmatically rather than listing them all statically.
+         */
+        for (int i = 0; i < 16; i++) {
+            g_autofree char *name = g_strdup_printf("ICC_PPI_PRIORITYR%d_EL1", i);
+            ARMCPRegInfo ppi_prio = {
+                .name = name, .state = ARM_CP_STATE_AA64,
+                .opc0 = 3, .opc1 = 0, .crn = 12,
+                .crm = 14 + (i >> 3), .opc2 = i & 7,
+                .access = PL1_RW, .type = ARM_CP_IO,
+                .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_priority[i]),
+                .writefn = gic_ppi_priority_write, .raw_writefn = raw_write,
+            };
+            define_one_arm_cp_reg(cpu, &ppi_prio);
+        }
     }
 }
-- 
2.43.0


