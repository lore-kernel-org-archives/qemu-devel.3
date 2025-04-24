Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F39C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kms-0005KW-QF; Wed, 23 Apr 2025 20:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmp-0005GQ-Dq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:55 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmn-0004LZ-4z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-739be717eddso275527b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455792; x=1746060592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVaQ8uivr0ZSIFp6lnsLbuP1aUnA44gVuobbLqVlt/s=;
 b=qET8YayhTklAKL/mz51uKlbI69zXsQ2MkqevqRxus1LgYdEwGTsB2Nmz1t/H1YyRIL
 aJOUBroFT+vUszWw1snnKxXq6riNfmyIC8O8q1w363KeCnjRJBTugJmtpugy3zuKtqyw
 zqajk5UrwYkvE6d1sigZ/pyow5gTq/8b/8KchTEuuqASLZTv4eQg0GU7XTao+q6FrzVQ
 n0Jpaf3dOBfZaSwZNSwYcq2AUxI474eSCKQvwFlX7V49pPmXs85SvZBlf5/b+H7VeQIY
 qQTUK0wSRgGY5qX6Nldt8UiH5UQbEgBlV44toE3jMbUiWDZjy7SeXMSC5RlwvoLpszci
 gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455792; x=1746060592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVaQ8uivr0ZSIFp6lnsLbuP1aUnA44gVuobbLqVlt/s=;
 b=SdGGTYgoS6sP7kJu0rDUl1UsaJoEvIdghkSGSIG0rWhIgvtHEvoOQRfOQxp0QTKmr9
 WXlCXT8c7P5ddxH3DpviW9q/+yZwLVuE9sFf3lQRlH1euiZJZ4jWStrACBNUCim920EM
 F9xJ13D5jeCyqY3bM6Kx3zpDZ7Ye3jU/XbYx4nWoUAQN/VFQupR3E92uJttXbX1KblVD
 7PxShdaFzRuFot4yyWiXLZagWw00TJum4/7273d+Ruw/Am/ZA0/oY8Ot4DJIZrY+lQYJ
 80pFOYp9lHieU20Vc8wmBWSOkoqEBKTZjckIdE9H3He/xsiCFXoc2XcmSJt3DD2nowKC
 totQ==
X-Gm-Message-State: AOJu0YyRdt1S77qi0e3pB0IYAC09XPNMOPfNsJyrU0A+Q1Ga+6k//2oc
 i+qCWXMhjvImPk6YzvFAN8f2uthB+6Q9mk1Izg2FfQOdukpAFGhxMZgvqMPGM+74XN3KK5PB0Dn
 c
X-Gm-Gg: ASbGncuItWAl6TVgU3/mG4y+iwl0Pz2mQ2xI3D1n4TFu1ZTUz7m1QSlV9cjdtsuXw6G
 k1n6H4Umoe9Y0cNOny6IFw+D5s7p5ARilNPgSF4qpioOcjjbj09TbGUSpP9qrwYvgqa6YWCl6XM
 6/tXecE/VlfAUpQxcW6x7zvEqifRhkP/OoO2K2vH8kI+b1vmx3UM9+6UGI+LsrH4K+cy8RY2OGF
 glO9YX4e1aPpgd+ed77CSZpko1U2xyXa8fqVFnxqDmb+OUScDKLwbe69hIq/ZMTa5+8ppSSZXGC
 h55bVoOlsa9QQ/76yMYgkrXP1APSvU3iR1kKAygz+TswrQNjA2XhkEj2lc6TDosY88MupIsAiJo
 =
X-Google-Smtp-Source: AGHT+IFQDyXjW7X7hBKiCT0I6CWFhNIMN/D3joqmDKTAa+9jB5e4v1WmPCj9nfx8cAf5e75mOuwFrQ==
X-Received: by 2002:a05:6a00:1150:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-73e2460ecd0mr1170956b3a.8.1745455791741; 
 Wed, 23 Apr 2025 17:49:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 021/148] accel/tcg: Fix cpu_ld*_code_mmu for user mode
Date: Wed, 23 Apr 2025 17:47:26 -0700
Message-ID: <20250424004934.598783-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


