Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43089C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW7-0004f5-Bn; Wed, 12 Mar 2025 23:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW0-0004d4-Sq
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:48 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVu-0007lT-0w
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:48 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223594b3c6dso9040325ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837532; x=1742442332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHXu13DFdrh271auqhCP0lApklGf8VDvaV4uG/D/Dqg=;
 b=VTokaCVAIFFL35OXkr/TufbJQ7W5L35y8wKPaNBdD7VAkcOZ8Z8qSacuuZDA5xCCvC
 EYEF+Zsx+3LUUm/vc+lTkqV19QVRgsV+o0QdVbyvUQ+q9Sj0i5SQdbXpaOT03rJfO/ST
 vDJ/oPSNbYOXNXVlynqNI3OZ7bFNwzrGHrF/hxOuxBSyi6jQUeal+0lWtr9pKy7BfDCf
 NHVeXi1LK1MEcqm8TU/adiyFPfT4XN/0woQ2czHEtywiicWOPLju3N/A0fyZqfD2XxKQ
 0l9sYZlAQBLPFRmziMAiXerwE7LcFsVp12NcriwY3b8CTJwi3uPT384aLEmX/sek9ca2
 /mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837532; x=1742442332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHXu13DFdrh271auqhCP0lApklGf8VDvaV4uG/D/Dqg=;
 b=bhTVZ1DonTMHD0pKETPJoAxkWkGeY2lj0WKXeoGutoILgNwvlts5VNXc98f2UlKMKV
 SRvrrrwoG4H8/tUj1OUv+f27v/V6nBKCz/bUMZxcA6oYVZuF6SiHTE8WSGwGvApc1Cef
 /q1HF51/FzJaIiSI1VgfKXFys3go5JYZPbml2K6IIqCTjZEKl/OIBdM2vrcPS4Ze/CK0
 b/E3x29nBUsc7WklsX4nleEcw1BP0xNaW4DN13b2A+12gHvI0GDJSgMKbkQlVmv4bJO0
 MsCL0J8/ldptMQBk/qi13uVBv0ksEt9MgKeRl24XwcmyIi5VWlF1fojEl2NG6QbNsPvb
 HOfw==
X-Gm-Message-State: AOJu0YzauWShLCb3Dt5nsiawxfzF87O6yv8bSVqOpe+fyeKOupr4cibw
 KfEAjI3CBQuFLJhYqW16LRTkkECJxtpupvgUV4owlfw4rLV8iTLXd43xs9RO9BSe2LKj26T9NPw
 O
X-Gm-Gg: ASbGncuLPVSmOcc8qJ9nkggwMnHUWOPtdnwIzRI33j77njnM5HlXp5AXq78b2hfkTqG
 3E4jLj18TOKzvvRn0eKEyym74eniCZwjSL2tgESWrakHOIXLNVEHNDph5MfJ7ssezRkkcUnc6p/
 HudgjfxtdjZIAsBJirkziEUX1rZErtFL4CXmHa6Qt+pxoO3ko5YuUN+b4ECc67699LjD1Gy1W4b
 kzgueyaQQ6AaTSreBwTUNrqf+PSReO1837OBZEQP0AuaEI2akBJeZrlmPeaaKwr6uYA0WVlPl7W
 fLHj/pmIwzKCFdkOBKo6uoX6CLvh51qRbOoSKlA7t0U/5+ATgrOEl4Y9LZA/TjNcQyjH+1Lmvcv
 s
X-Google-Smtp-Source: AGHT+IGEioouCc81/LA0yZXuzlWvAgDQ8iibvhZb59pWBFnDBhAmwa+kPd5qnvENOJ6I56HDwaf0fw==
X-Received: by 2002:a05:6a00:3d55:b0:736:5753:12fd with SMTP id
 d2e1a72fcca58-736aa9c1de8mr33694809b3a.4.1741837532630; 
 Wed, 12 Mar 2025 20:45:32 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 08/37] include/exec: Inline *_code memory operations
Date: Wed, 12 Mar 2025 20:44:48 -0700
Message-ID: <20250313034524.3069690-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

These expand inline to the *_mmu api with a lookup of
the target's cpu_mmu_index() and ra == 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 31 +++++++++++++++++++++++++++----
 accel/tcg/cputlb.c      | 28 ----------------------------
 accel/tcg/user-exec.c   | 40 ----------------------------------------
 3 files changed, 27 insertions(+), 72 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 70e98ebc52..92b4cf20fd 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -472,10 +472,33 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
 
-uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
-uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
-uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
-uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
+static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
+    return cpu_ldb_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
+    return cpu_ldw_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
+    return cpu_ldq_code_mmu(env, addr, oi, 0);
+}
 
 /**
  * tlb_vaddr_to_host:
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b03998f926..2817c9dbdd 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2897,34 +2897,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
 
 /* Code access functions.  */
 
-uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
-    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
-uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
-    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
-uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
-    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
-uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
-    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
-}
-
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t retaddr)
 {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3f63b194bb..5bdbb6f968 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1214,46 +1214,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     clear_helper_retaddr();
 }
 
-uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint32_t ret;
-
-    set_helper_retaddr(1);
-    ret = ldub_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
-uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint32_t ret;
-
-    set_helper_retaddr(1);
-    ret = lduw_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
-uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint32_t ret;
-
-    set_helper_retaddr(1);
-    ret = ldl_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
-uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
-{
-    uint64_t ret;
-
-    set_helper_retaddr(1);
-    ret = ldq_p(g2h_untagged(ptr));
-    clear_helper_retaddr();
-    return ret;
-}
-
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra)
 {
-- 
2.43.0


