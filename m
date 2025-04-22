Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5D2C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIe-0002aw-PU; Tue, 22 Apr 2025 15:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIT-0002Vg-6n
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:45 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0006Cd-5D
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:44 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-308702998fbso5010904a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350114; x=1745954914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVaQ8uivr0ZSIFp6lnsLbuP1aUnA44gVuobbLqVlt/s=;
 b=SPZlSHPiFamSHNBsL2ksaFIsvWyj1SnRypY2hG02lpArYy0VfGwOXV8MmAPxyMky40
 naol++jgbj7wJAfADNC53vfywseLURvnG5KMXxilb8QJm9EOHiiLzBRI2NMsA35MsP1Y
 hTLDukRajS4jMXgsCycOmrothu5C0vWXNdBYIzTnL6SJlNpRrrD8oIS4nknGCTfi8CDI
 dJVpZezCzNjZw6HTnbsz8Spf/YY5Q4FpGlhqlTrKvdVukSHoCsQYGYRZquvc7XdUSeHm
 uBM+aF+rf/1H76TAq/vj+kLvU7/BM7915/ZQ70lNjt8M/cAvDBACHECiCLDY9WRqDNOB
 mJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350114; x=1745954914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVaQ8uivr0ZSIFp6lnsLbuP1aUnA44gVuobbLqVlt/s=;
 b=jMNS6gwfflGUf60Vlzr1VG8tAxF4yPj4CZl0LvJ+7YvbuXis8LSBheXPKJeLKhzCv5
 kvI6tw1ASlc2R+Zto6Y5ebREAgowL4fKBht6gEwkfWtithnv2IbIiBzTsu95ARY6lWHO
 8GQgoyfnxmcE5uMiTQDCL7f2TBr7cDPRJ/JpNblnBCT1yjNQ9COMOaBgSiI064OYopw3
 xFjCaM/RtgGPxQO3sysmCiBWOPLH/2gjc8GAK7lVBWFKBdhX5nY3uPtwfLYSt61P2R88
 lAHrpJKsAszp8eipFrVBEwGxdGdgnOQ0itVP7N7aSMEPI5LhyNduweEYSTnoj2hzuxM1
 ZZJQ==
X-Gm-Message-State: AOJu0YxiSIL6LFvoMSrvqD34gGuTMPw6MkWuH+GFqt4viktir7j273YA
 bOcahr9D6NZiPzLuCFYRRsAjT7MCwNt6WQ/1zmThfjEsapM2LhwG1w6YlqCSrUS3eE/ahkwNjna
 U
X-Gm-Gg: ASbGnctfG70GsM4hkrNEzgRlhrpcr0RrFANyOx1NI1atL/SRc1SpK4qmO9HS8mh7MBA
 /TTUP+EjjxlS0gkSHySg/DwOlJxIfGzRhs/oYYdHrHWK+CowB25Yag2kN3K+Qu3H8fKYRTYbkYS
 eFmQ2zgxtkrhsOVZuqIVTJ739wcaoOqTR/WKPUN7drVMDXk4p9hE0hVIxR+IKFy2rDqLGNEn6cR
 SuSTU6GwhZvPRzU2Chc50hVNX3Nmqs+ZwJJ5oNjWwc/E6rkTFTSRqt5rf/8obkWy1TfMQdmascr
 c1GssL2FQCEtypX9DjOHqGJKyTS10l0N+JPjy/THIvbt8pwwlveAGaRQYYYQVf9Ul/WB6VaAvps
 =
X-Google-Smtp-Source: AGHT+IHeIN9/7OF7X0azbbbfAD73V7MTV5FfetqOkT+DBbiHv1+pdnmDjoQtREkvSnfDTwUmkUGGZA==
X-Received: by 2002:a17:90b:4ecf:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-3087bccc3a5mr23409251a91.35.1745350114420; 
 Tue, 22 Apr 2025 12:28:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 021/147] accel/tcg: Fix cpu_ld*_code_mmu for user mode
Date: Tue, 22 Apr 2025 12:26:10 -0700
Message-ID: <20250422192819.302784-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


