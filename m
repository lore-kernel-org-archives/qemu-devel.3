Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C9DC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueXy-0001GK-Rl; Tue, 18 Mar 2025 17:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXo-0001E9-AJ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXm-0000is-6O
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-225df540edcso1782185ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333532; x=1742938332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lD9jDoC4IS62bMndhOtFSfLQLyZKi8PN0X3J0KsjhhM=;
 b=onEdvnv9hT40qAF9DPzfXMLFzwX4ZOmbH/y3Txx4i/UMlenpCSWZhYWwtCvX6V1ONc
 Fcn4CUEBRNvYt1LA0tjgeJJx9oQ9JK8W+G2T81a11XFNokjpeWIHW4ISDvaD0d4znQLg
 imubEInEu0zQLmDESkOMUZpP9GKv9X+EmqxmUhnVcGMHDqKltt8O/t9r5Zc3R3kRQkmI
 t0PY5smxUWR2geSI6Mf378xFuL1+9V/Qd0970Dv9pzr7KKm+WCh8dtGnzLhRKEs6sxr2
 rV3pWGHmtwSxoRtcQUdkucIXftRV8j9d0qfIuTzzPJMXYA44w3NSIoERS5C8k2NMc/fn
 p0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333532; x=1742938332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lD9jDoC4IS62bMndhOtFSfLQLyZKi8PN0X3J0KsjhhM=;
 b=IDZCW57uZjYRXn3nj9geI6gtNjfuz9vLFLqZCY8wHKH6IfFKgoY2cM9yoIy87hbylj
 uSPIhaJE9ZvV+lSdpJiEPr+nUVWre2scYxP3Q1rSYNwlC8DN5NE0+nLkexLgRmTF9LAE
 JKDS0RFE4tSnJGoXvM9jk/HVr8rsDH2UU5VHbiSW/P2Py+ydThodTcRRvBpLwzUM6Yxk
 lLnhqosuLfjm3O6fihZWVyn1TlKvZ/CXS14Pwg5aaMso41gJGaqs7EZ6OmdmqyHIbrMW
 g6lOetQ5IEhX7R8+cjzn8wRG7oDG806S/0zNbVWjLTOHkcY33Et2yyVEHaH9CCMnJs4c
 0gGg==
X-Gm-Message-State: AOJu0Yw05erIPsd2CsGeyaUafjF7WamDIWhL8HiK5yAm9XXR3xyhVHmC
 tc09JtlWy7yQrXp4IyPwcT1ZsfupNmWhi+pxFEzMCCWrej7HZ7sQU67lPbtbgFQI4aX8C4vf38e
 o
X-Gm-Gg: ASbGncuVXZ9IxThOw/NbdsvGFsY2nOy89CG9kts+YxehD1A5JHaC8KIDJFIP/czOBiY
 fRNXok6rhyaq3QwCLBS/0ZI9BVYF0IaX1meTLojCavg1ILtWP9YVXVNG7dOCdsCPDdOLK4d7VTp
 AU3+Mqw84QwcylGN2nsaZZjrY8Ds0q9CP20qVSaqjHTaYV3K1s2t7OmXguMSRLuqet8bkqbHgD/
 WRpleeO7lFC254wMePjkncWvhDAh4/jc0QWuCv5Ek9VoIuXTIZ7enXYcjHUU602bE0Ng9xFXUiF
 WU144qpOd6/kXCMl/iwkCluGYA/I1t85q/zz2tiLjfqVhBDv/gyY1yiXj0U7wH3j4gFvKE9XGoj
 k
X-Google-Smtp-Source: AGHT+IGQRHuPYmoY5Jv509IwnnVlAckP0AanChA9FVetwU2FJm8p9UQKEPfhPoSdpndC2wY/dRiBDA==
X-Received: by 2002:a05:6a00:908d:b0:736:aea8:c9b7 with SMTP id
 d2e1a72fcca58-73757764898mr9108417b3a.2.1742333532522; 
 Tue, 18 Mar 2025 14:32:12 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 03/42] accel/tcg: Fix cpu_ld*_code_mmu for user mode
Date: Tue, 18 Mar 2025 14:31:28 -0700
Message-ID: <20250318213209.2579218-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

These routines are buggy in multiple ways:
  - Use of target-endian loads, then a bswap that
    depends on the host endiannness.
  - A non-unwinding code load must set_helper_retaddr 1,
    which is magic within adjust_signal_pc.
  - cpu_ldq_code_mmu used MMU_DATA_LOAD

The bugs are hidden because all current uses of cpu_ld*_code_mmu
are from system mode.

Fixes: 2899062614a ("accel/tcg: Add cpu_ld*_code_mmu")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 41 ++++-------------------------------------
 1 file changed, 4 insertions(+), 37 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2322181b15..629a1c9ce6 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1257,58 +1257,25 @@ uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
                          MemOpIdx oi, uintptr_t ra)
 {
-    void *haddr;
-    uint8_t ret;
-
-    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
-    ret = ldub_p(haddr);
-    clear_helper_retaddr();
-    return ret;
+    return do_ld1_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
 }
 
 uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
-    void *haddr;
-    uint16_t ret;
-
-    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
-    ret = lduw_p(haddr);
-    clear_helper_retaddr();
-    if (get_memop(oi) & MO_BSWAP) {
-        ret = bswap16(ret);
-    }
-    return ret;
+    return do_ld2_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
 }
 
 uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
-    void *haddr;
-    uint32_t ret;
-
-    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
-    ret = ldl_p(haddr);
-    clear_helper_retaddr();
-    if (get_memop(oi) & MO_BSWAP) {
-        ret = bswap32(ret);
-    }
-    return ret;
+    return do_ld4_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
 }
 
 uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
                           MemOpIdx oi, uintptr_t ra)
 {
-    void *haddr;
-    uint64_t ret;
-
-    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    ret = ldq_p(haddr);
-    clear_helper_retaddr();
-    if (get_memop(oi) & MO_BSWAP) {
-        ret = bswap64(ret);
-    }
-    return ret;
+    return do_ld8_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
 }
 
 #include "ldst_common.c.inc"
-- 
2.43.0


