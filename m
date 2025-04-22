Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E3CC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRE-0001Yy-Rk; Tue, 22 Apr 2025 15:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JPB-0005iP-FK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP8-000787-Lh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22401f4d35aso62185215ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350537; x=1745955337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msXtfBhGOXcEDb7wOAfBlBKK4V40wttZa0c5PZCnz/Y=;
 b=vpoSbFEPG55rxWwIYe8EdNQgj/nvc8QY+PEJS+4X5HMc6X58+hYAz3/SV96Jf3FcKl
 56KBoh6PcTJ+fpPf6qKTX47AZXOxPnCKo5rwCTS9zNoUlLzJYk+imxfXtEzMc3HFcJcl
 VKpx3HsIW2PcctS8hXMdcC7/XSEYuImHTKWrs7Yw+yNK8QcUAwztVC3lM7szi10H0pbg
 sQXg2G7nSvKyjo5ZFeKXj9KnMVVa2JhjSQI5Vlr8qavkYlauswKLQei3mQf6nF+duOg/
 AheqJfVygmYM4nq3S/RE/Z0+WsgFl8rN5kfdB6QFw+E6nOVvmRGmEYuqxGVFW0yNog04
 CLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350537; x=1745955337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msXtfBhGOXcEDb7wOAfBlBKK4V40wttZa0c5PZCnz/Y=;
 b=FJzEetTDGi03n8Q4anEZo9faFr7t7G1gNmp5lh5oEt0XuG4GZnJE3ZiEAfBM5gz+mj
 b0wIHNQ1uNL5DL+V4yaJyiArKJ5JkMU6VJ+MGFXYOq3OoSc3adVmMsxNyW8/YQpks/aa
 8Rgw39d66oDKcpYJU/cT7kEFlpRzk4TlJFHt5N9L2wO071GUSPQ5eWQaJtljtK1KnUb+
 rRLfxkmFa1Q8C9QHssOXp/HUpWNnVkVbk9L15nsXDb3wS3HyukCcIwGCI4oQjUed4ECa
 9DmcXHzPBqtPbg+PnlCcl2TA2YJsELavNDdf+8ySPJcx3PGwe+25zBbrNFUeZz5GrGJ9
 FxFg==
X-Gm-Message-State: AOJu0Yx9GS83Xy0zVJ4vuSm3gz9tFlCI+BgI+K6Ey+e12B3RIrXFX/Ui
 qIcRzruyHhW9Zr8pEnqJnHvUhw6VuCxs7pR0EncuGJC5bp6/qcAAfL+As2TlfzFjeGNxnrWB82R
 j
X-Gm-Gg: ASbGnctPi7a+p7a3RTSR+NR5zJqpqIm9QRQxPFkWoNlM0t36ruJJ49jgsc1OlqyKPu9
 y0UEYf12ijFmppfrBOH+J+D+a9r07W3zFx9dOLLaE4XNo9jofp3e4a0Z2CRGzhdgUFU2npref9O
 aWuTAjVemApiFimcQ4Z2N+i0ZxDLXEkVPvRtkj31UYCRd+iK/pdJ66226aKX9b5ZHjfmPozpvBt
 Ua4J+LaXgbC/USgiDayTG8LH+gWtUzL5DWMagzY0zCfpf2SNCPiNWMOLjy4k0ro/1hSdme0B/KK
 C87LbEfG0N3pEuJvYFOAhMmzr3VKJuUo1mukWZuZY3pB8TMdBYs1Wt0Elpp9g99sWKZXXFKZ6fN
 zl2o52doW1A==
X-Google-Smtp-Source: AGHT+IHXE9Pe1KyHz7cYQ/Ez4M/DZxZF4rJkNUgdz2Hv872uK4WTvoI2G9BcwhZnRF70DKP/Q27seQ==
X-Received: by 2002:a17:902:ecc7:b0:224:1c1:4aba with SMTP id
 d9443c01a7336-22c53620d32mr232597175ad.50.1745350537291; 
 Tue, 22 Apr 2025 12:35:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 117/147] target/arm/cpu: define same set of registers for
 aarch32 and aarch64
Date: Tue, 22 Apr 2025 12:27:46 -0700
Message-ID: <20250422192819.302784-118-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

To eliminate TARGET_AARCH64, we need to make various definitions common
between 32 and 64 bit Arm targets.
Added registers are used only by aarch64 code, and the only impact is on
the size of CPUARMState, and added zarray
(ARMVectorReg zarray[ARM_MAX_VQ * 16]) member (+64KB)

It could be eventually possible to allocate this array only for aarch64
emulation, but I'm not sure it's worth the hassle to save a few KB per
vcpu. Running qemu-system takes already several hundreds of MB of
(resident) memory, and qemu-user takes dozens of MB of (resident) memory
anyway.

As part of this, we define ARM_MAX_VQ once for aarch32 and aarch64,
which will affect zregs field for aarch32.
This field is used for MVE and SVE implementations. MVE implementation
is clipping index value to 0 or 1 for zregs[*].d[],
so we should not touch the rest of data in this case anyway.

This change is safe regarding migration, because aarch64 registers still
have the same size, and for aarch32, only zregs is modified.
Migration code explicitly specify a size of 2 for env.vfp.zregs[0].d,
VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2). So extending
the storage size has no impact.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-22-pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cc975175c6..b1c3e46326 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -169,17 +169,12 @@ typedef struct ARMGenericTimer {
  * Align the data for use with TCG host vector operations.
  */
 
-#ifdef TARGET_AARCH64
-# define ARM_MAX_VQ    16
-#else
-# define ARM_MAX_VQ    1
-#endif
+#define ARM_MAX_VQ    16
 
 typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
-#ifdef TARGET_AARCH64
 /* In AArch32 mode, predicate registers do not exist at all.  */
 typedef struct ARMPredicateReg {
     uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
@@ -189,7 +184,6 @@ typedef struct ARMPredicateReg {
 typedef struct ARMPACKey {
     uint64_t lo, hi;
 } ARMPACKey;
-#endif
 
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
@@ -660,13 +654,11 @@ typedef struct CPUArchState {
     struct {
         ARMVectorReg zregs[32];
 
-#ifdef TARGET_AARCH64
         /* Store FFR as pregs[16] to make it easier to treat as any other.  */
 #define FFR_PRED_NUM 16
         ARMPredicateReg pregs[17];
         /* Scratch space for aa64 sve predicate temporary.  */
         ARMPredicateReg preg_tmp;
-#endif
 
         /* We store these fpcsr fields separately for convenience.  */
         uint32_t qc[4] QEMU_ALIGNED(16);
@@ -711,7 +703,6 @@ typedef struct CPUArchState {
         uint32_t cregs[16];
     } iwmmxt;
 
-#ifdef TARGET_AARCH64
     struct {
         ARMPACKey apia;
         ARMPACKey apib;
@@ -743,7 +734,6 @@ typedef struct CPUArchState {
      * to keep the offsets into the rest of the structure smaller.
      */
     ARMVectorReg zarray[ARM_MAX_VQ * 16];
-#endif
 
     struct CPUBreakpoint *cpu_breakpoint[16];
     struct CPUWatchpoint *cpu_watchpoint[16];
-- 
2.43.0


