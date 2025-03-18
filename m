Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C131C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOx4-00025j-2i; Tue, 18 Mar 2025 00:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvb-0001F0-QL
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvY-0008Ub-GS
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22359001f1aso50940675ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273502; x=1742878302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWxuqDn4s8YGDZbkaUM66zf0LxM3gMsyBA+i/Ql3r9I=;
 b=AHwWMggX6uoudT6S9mSuOirqQ990MnsvlxNyZ1ZljMmsEjPAYPB/5aRyYJlCWhZv7B
 koEJTLj9+hqsjuUJtu0+WJwLtZTDG37BxhxIzQZjYN6QKe4rTZ7mB6hNDTC/zY/AZrBF
 t6+4XXKIydJVOUwZT8y0caveWBsLsX1+eZrzO6PgJUOEZTU7nZTKRY4vk1Kcsq2nCLRR
 Pep/6P4NAOWz+rlwn5/elrtto/jzmUwE6FbH0B93G4Zr6xW8RxWQsgAIMXXvxP1TzAYD
 Xzedb09L5AP6vX3TkvzJfc7dU81m7tGNgmu7P4n/d9LF/pIZD/6X9P7qPZENvcgVzXGX
 v+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273502; x=1742878302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWxuqDn4s8YGDZbkaUM66zf0LxM3gMsyBA+i/Ql3r9I=;
 b=Kqdyt2X3Nu3J9GBr19Nx0grWbzZHLbhSGZlFF12kII2YpfUcQM5mQQ4jsmi4079Ls6
 ePBkoWk4Knw+eJWnPVYfwQsirMRQklr4T2PkmjATU8ZLuRi+bxsZPPuV2O/2XHCJKFL1
 +r0Hk23nEAopDBqTWXBdRUu3i4Mcbo8yGa7m4g6rvTo3SMLotVJ0/O1Nqd2Ze7S36bAO
 RHICCL3jjqhpTWZZSrBIHRonodzkOsPZbAcsZI7AwkYsf1TEJnW1rCVfl8nPvguTnU0h
 x8PtzXI5VtT20t6ZCgzjRIXYv7LBWzXsDYu08KwzSgBa4t48trf+I2FYoBw3+SWKUn0Q
 KGsw==
X-Gm-Message-State: AOJu0YyhBMhtR4oO2tlQ4M5DOGrKVTEHn4LNt1eBjborNaVfMr8wnK7p
 a5IA6l4n4HDeKQMA1Z6gta0ApbKDoQwiAOTp+QMZLRrR29NFebOZ0T7ztHpG6gzxZ6boKPscX2w
 /
X-Gm-Gg: ASbGncsfuINsTBSnxf+THEacqb/XUy/F0K7HFc+gO8+b6NVj5kKTQsRGz3RaRlP1Yyu
 Kcv2hXijalyiCCN2MkTr+i/OvQvdXYeeiL8zfvb3F+d8T+LQIE7ZQVEcv3kNelic+n4ETfcC7lj
 g89dOTfCKI3e3QpNCLgvOHHctAdd/6PbWmkxAm4x0FEJmyrZOGPYmK++XoT9UHcqxxc8RzoAgce
 IFtJSEADe0DOKb7Trzly2SRy+xIqIhAIRqabH/gdoWtYV/b3l38irW4rqwXlovA+fp/2TbsFYlq
 qvmMC8FPeKhOHo7Mk9iqWVoX+aRbIuJcd4Hp/wUb1ZCu
X-Google-Smtp-Source: AGHT+IFe64voSZsfhB6tCQvZ6JsS5YIy++Gra9YOoX3NHYIjPdoV//u+oQg4+pI0ZxYcfpZboB2sWw==
X-Received: by 2002:a05:6a20:9c92:b0:1f5:6680:82b6 with SMTP id
 adf61e73a8af0-1fa461552c5mr3160029637.38.1742273502551; 
 Mon, 17 Mar 2025 21:51:42 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/13] target/arm/cpu: define same set of registers for
 aarch32 and aarch64
Date: Mon, 17 Mar 2025 21:51:22 -0700
Message-Id: <20250318045125.759259-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 00f78d64bd8..51b6428cfec 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -175,7 +175,6 @@ typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
-#ifdef TARGET_AARCH64
 /* In AArch32 mode, predicate registers do not exist at all.  */
 typedef struct ARMPredicateReg {
     uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
@@ -185,7 +184,6 @@ typedef struct ARMPredicateReg {
 typedef struct ARMPACKey {
     uint64_t lo, hi;
 } ARMPACKey;
-#endif
 
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
@@ -656,13 +654,11 @@ typedef struct CPUArchState {
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
@@ -707,7 +703,6 @@ typedef struct CPUArchState {
         uint32_t cregs[16];
     } iwmmxt;
 
-#ifdef TARGET_AARCH64
     struct {
         ARMPACKey apia;
         ARMPACKey apib;
@@ -739,7 +734,6 @@ typedef struct CPUArchState {
      * to keep the offsets into the rest of the structure smaller.
      */
     ARMVectorReg zarray[ARM_MAX_VQ * 16];
-#endif
 
     struct CPUBreakpoint *cpu_breakpoint[16];
     struct CPUWatchpoint *cpu_watchpoint[16];
-- 
2.39.5


