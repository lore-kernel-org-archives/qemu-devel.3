Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE7DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYA-0001MN-Sv; Tue, 18 Mar 2025 17:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXt-0001F0-1d
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXp-0000jw-Uy
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22438c356c8so107497765ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333536; x=1742938336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeri+twoEW7Zt/DU9oQuJ6uk1NkyW5mEGlj/nPXa6pY=;
 b=yR9yQ2+amvHN4t/azJqK4tdgz+bOL+y8PRsCX3yqNT05+FQRXhg4GpuuMy6abj9eFo
 vAwidFc697Jhn8KG8M3EnhK3mztKjUZ28tmPqxDUsO77VB8gNQXfblbSm3rSC9Oj41r5
 WQ+US8Xa/Nv+qc01NPt59fNsdLzST8mUzNYHW5zXVoitoJxyGJaRHPeh3Quk+4C5C3eE
 Frss5lrv0LHkAwGgs0RDP+MRZknlLbE2Ui6CmENqd89rqhWhv0f6Xw+CgQUkJOUKl74z
 lO2Zd8hlEYbJ0lJdRCvEY6WKTJ6XR3idfBIrr9P404Iob/KBNO/lIAFFw7REDQDMDIpx
 ntcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333536; x=1742938336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zeri+twoEW7Zt/DU9oQuJ6uk1NkyW5mEGlj/nPXa6pY=;
 b=FWLv2n+jXfcq9WpWWpEFw05itBJUWSN6pe66W48BMxjCTJC1xQ97N8PtMbV4Oat/XF
 n41VYCIYRN4aBqYTylwAcIgK/s1JaXHbpvx34aFtkyF8fjVRm1j3pb4P8pjGVY2TQozG
 VZBkTGVnHmiB02E2uXUJCoM0qjP8gDNWTTL8tDSJ+l8hrMs+lz8Q54UjQzwTbg6VA2lY
 nO4mgbbqnnYnwgyq3CJUuKXVIXGFsSP9yuTxOW5+P483029hNZP+TSZ89DDWLOqoi5zW
 kwQpfLN4HSIFTAGYriKET3b9+wjCO+KenZ2xfunNEES4rCHqF94QtPdylCg+WlTaVlcF
 0mgQ==
X-Gm-Message-State: AOJu0YxjLq0JiccbOpAC8YUWal5lXZjNsjsWXiwtwmiEUKSWZ1f6iX21
 eQ5kuRGn+fXF+2zWQwawID2wfRv56u7g1wyMyUoKJRgZxVdzSLG7FAlRxv8dX6Li/pKFqWJpLKV
 X
X-Gm-Gg: ASbGncsze507JB0pB96mQ392ogdyI2UGk8yoGyFkqDd3uxX2wlVwmkQyXkkQIRBAGJz
 +QRsYHfARA1t0IPm/E7NH5/WWXACGTDgsCIT4ebex8S40R1GQ/wxrSLEbE0+rWnrh76H/uNsvEG
 VSb8B40o/ty8MYLE9Gr2xflvTXLMT5NUtKeevpuUDw2KehajmHFi1xlLV8m54fiQvRr2OLImL3k
 iO9NAJakF7z08J8AQqt4vrV6dw3GzYno/rPV94Zqqt621wxcOmG20KxZZpeNb5bdibGl5dckpBH
 RvGq8eP+zuDF2a7a0YMw/HXU6MQoIr4jixHIDM65aNV6+KBtQihMUpkPCJp+byaKQFwqv4zPPp/
 Mj2fINzgSE/s=
X-Google-Smtp-Source: AGHT+IFK/rup+kGR5eGCv03w0Hi+eluDYKQokxrPz82Mvhice5R4DFoHqFP6cUKK0fZkasI+HJcQIw==
X-Received: by 2002:a05:6a20:2583:b0:1f5:5b77:3818 with SMTP id
 adf61e73a8af0-1fbece406bbmr296479637.27.1742333536305; 
 Tue, 18 Mar 2025 14:32:16 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 08/42] include/exec: Inline *_data_ra memory operations
Date: Tue, 18 Mar 2025 14:31:33 -0700
Message-ID: <20250318213209.2579218-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

These need to be per-target for 'abi_ptr'.  Expand inline to
the *_mmuidx_ra api with a lookup of the target's cpu_mmu_index().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h     | 144 +++++++++++++++++++++++++++++-------
 accel/tcg/ldst_common.c.inc | 108 ---------------------------
 2 files changed, 118 insertions(+), 134 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 4149f04368..a2a90c7554 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -85,17 +85,6 @@ int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
 uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
 uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
 
-uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
-
 void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
@@ -104,21 +93,6 @@ void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
 void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
 
-void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
-                     uint32_t val, uintptr_t ra);
-void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint64_t val, uintptr_t ra);
-void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint32_t val, uintptr_t ra);
-void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
-                        uint64_t val, uintptr_t ra);
-
 static inline uint32_t
 cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
 {
@@ -250,6 +224,124 @@ cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
     cpu_stq_mmu(env, addr, val, oi, ra);
 }
 
+/*--------------------------*/
+
+static inline uint32_t
+cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline int
+cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
+}
+
+static inline uint32_t
+cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline int
+cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
+}
+
+static inline uint32_t
+cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline uint64_t
+cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline uint32_t
+cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline int
+cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
+}
+
+static inline uint32_t
+cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline uint64_t
+cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
+}
+
+static inline void
+cpu_stb_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
+static inline void
+cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
+{
+    int mmu_index = cpu_mmu_index(env_cpu(env), false);
+    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
+}
+
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 99a56df3fb..2f203290db 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -248,114 +248,6 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
  * Wrappers of the above
  */
 
-uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
-}
-
-uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
-}
-
-uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
-}
-
-uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
-}
-
-void cpu_stb_data_ra(CPUArchState *env, abi_ptr addr,
-                     uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint64_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint32_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr,
-                        uint64_t val, uintptr_t ra)
-{
-    int mmu_index = cpu_mmu_index(env_cpu(env), false);
-    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
-}
-
-/*--------------------------*/
-
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr addr)
 {
     return cpu_ldub_data_ra(env, addr, 0);
-- 
2.43.0


