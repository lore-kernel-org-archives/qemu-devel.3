Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A51093180
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3UYu-0003QK-Gk; Fri, 20 Mar 2026 03:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3UYl-0003Hq-Vs
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:46:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3UYj-0003Lw-SK
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:46:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48628ce9ab5so3635095e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773992775; x=1774597575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIn7Jp1y3jvxH/+6QsHu7bop64Gst3prUJHkIzzryuo=;
 b=KVkWOArBe1m+AaMysEMjh03Wsdq2TJ2BDjXmbQghfQo0KLYWL9aQNuphgaYbepxbnv
 VlRf8V5XKARqyusPxx6hI+e/86zjrNMRGXEdAllrm0y68IE8zQBpKQQ5+SzJ4Rc6VHTt
 gXyRR7NQJZBeKTkicY0SPvwNuWdF9dbF4TOZ7B3+VcIlvOzkq4UvHiYKsvV3158LL9bM
 KG0zoHszrtKcgmbPZx2CiodR1oiOB502CIZ+gNHWVGgCZO4GL7f0OR5TGxn3URvEgdS+
 3nF+KR/phjupJNYs4m0ZTvsMcUWQI9fNZzq0JbLDu3pziWoRXyxsdKU/PRoereqLbgRN
 tgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773992775; x=1774597575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RIn7Jp1y3jvxH/+6QsHu7bop64Gst3prUJHkIzzryuo=;
 b=O4Ysf5T9fYHBHEU0ArmlhQQAbNgG1VRiU0x8+WpTj/DNCWickJIDQCfMg/Bsx8QPYz
 KxsbsJPOk2Gb/Mt5NAsp1xQzBoq0FOjFqTaY6Bi6qdud8Mkun/t8nH+ojX5y1eEME+m2
 kzvT5J36uZr6+WZRCqVYkpW47+/Q4XG5kFz1E3BXXZfxHdH5oVncVYRvxNcwaQiBfXgd
 LO5/rU5M+eBbVamHLrPXCMqiuiJIYAfqwZAl2nOctYVRsJNfF2XRcX1AclilOkR2OyPG
 8S9S1FqtTeWY8t19bZPl/ZeRCa3nzANole6KVUmK4QHeagTPd5nFGIC+kUoIY/tSDtHe
 iOqg==
X-Gm-Message-State: AOJu0Yx3MSPUNch78yYg4/7khty7+t9/tllOMR3AH47Urd5QhC0zjrgx
 ARWoVzd0t1WS+Wq9gH3pWc/TQg29ud/pxF4KgEhP9gg3dAvW1dfIpBLLZTvGcw8Bm3sKgd3Hbg/
 4TIdVKyQ=
X-Gm-Gg: ATEYQzzc+RM7xj7R/EvF2QqiSPdtdC8u8PTpDk6R91woEbhlwxZQ7Krusb+JW7kGkI0
 IPneDQphgDvZSo3catuJlPDrTQTbad/7J9vQdSo6JlFyjgYzz+9TIT1zAna3LIlqbcET9b7Y7Jo
 yNcOe70+CwFYiBLKID2dApaxMxutM9cFexhECqwk06Q3Dz5MA1g3aMMlVrQDOgofNnbtkegK1D0
 oaXXh4+NoiwrQJ7KUZQYvY1OSmGfRTO3Ng9tpYZM/DsiToHnzLrtD3Se9f2N6/5rTvxVLxTCpm3
 GQXaeWSuEdpZF2Jp+THyS3FP0Iclm/rFh2QKvYqf+0f8g0P10A/vYJ5eMhExS45U7AEe9lKwMLh
 UunTtz3fYBwlgFmMTOo4N9X8SNDrvODbhLapEEkmfc1q8+rBjQ43P/RtbjsLBhyzaCsnHtIDwZ5
 4OE7lqcQ4mIyZSKuSM9+Us5kmSdxZHzGrwtPwZEXo4ZaPB2P9SSDtXVISWpBl6ydR9WJ7s6W3U
X-Received: by 2002:a05:600c:3b23:b0:486:fdc6:1c0d with SMTP id
 5b1f17b1804b1-486ff02da9emr29225575e9.22.1773992774861; 
 Fri, 20 Mar 2026 00:46:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64711f58sm4739864f8f.29.2026.03.20.00.46.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 00:46:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] accel/tcg: Remove non-explicit endian cpu_ld*_code()
 wrappers
Date: Fri, 20 Mar 2026 08:45:55 +0100
Message-ID: <20260320074555.33974-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320074555.33974-1-philmd@linaro.org>
References: <20260320074555.33974-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

All uses were converted to the cpu_ld*_code_mmu() helpers:
remove them. Update the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst  | 21 +++++++++------------
 include/accel/tcg/cpu-ldst.h | 33 ++-------------------------------
 2 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 57892e814cd..c719241a7f5 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -235,16 +235,13 @@ Regexes for git grep:
  - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data\>``
  - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data\+\>``
 
-``cpu_ld*_code``
-~~~~~~~~~~~~~~~~
+``cpu_ld*_code_mmu``
+~~~~~~~~~~~~~~~~~~~~
 
-These functions perform a read for instruction execution.  The ``mmuidx``
-parameter is taken from the current mode of the guest CPU, as determined
-by ``cpu_mmu_index(env, true)``.  The ``retaddr`` parameter is 0, and
-thus does not unwind guest CPU state, because CPU state is always
-synchronized while translating instructions.  Any guest CPU exception
-that is raised will indicate an instruction execution fault rather than
-a data read fault.
+These functions work like the ``cpu_{ld,st}*_mmu`` functions
+except that they perform a read for instruction execution.
+Any guest CPU exception that is raised will indicate an instruction
+execution fault rather than a data read fault.
 
 In general these functions should not be used directly during translation.
 There are wrapper functions that are to be used which also take care of
@@ -252,7 +249,7 @@ plugins for tracing.
 
 Function names follow the pattern:
 
-load: ``cpu_ld{sign}{size}_code(env, ptr)``
+load: ``cpu_ld{sign}{size}_code_mmu(env, addr, oi, retaddr)``
 
 ``sign``
  - (empty) : for 32 or 64 bit sizes
@@ -266,12 +263,12 @@ load: ``cpu_ld{sign}{size}_code(env, ptr)``
  - ``q`` : 64 bits
 
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]_code\>``
+ - ``\<cpu_ld[us]\?[bwlq]_code_mmu\>``
 
 ``translator_ld*``
 ~~~~~~~~~~~~~~~~~~
 
-These functions are a wrapper for ``cpu_ld*_code`` which also perform
+These functions are a wrapper for ``cpu_ld*_code_mmu`` which also perform
 any actions required by any tracing plugins.  They are only to be
 called during the translator callback ``translate_insn``.
 
diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index a5711bc15a6..084d906a56b 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -51,10 +51,9 @@
  *     _be: for forced big endian
  *     _le: for forced little endian
  *
- * mmusuffix is one of the generic suffixes "data" or "code", or "mmuidx".
+ * mmusuffix is one of the generic suffixes "data" or "mmuidx".
  * The "mmuidx" suffix carries an extra mmu_idx argument that specifies
- * the index to use; the "data" and "code" suffixes take the index from
- * cpu_mmu_index().
+ * the index to use; the "data" suffix take the index from cpu_mmu_index().
  *
  * The "mmu" suffix carries the full MemOpIdx, with both mmu_idx and the
  * MemOp including alignment requirements.  The alignment will be enforced.
@@ -474,34 +473,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
 # define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
-
-static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
-    return cpu_ldb_code_mmu(env, addr, oi, 0);
-}
-
-static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
-    return cpu_ldw_code_mmu(env, addr, oi, 0);
-}
-
-static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
-    return cpu_ldl_code_mmu(env, addr, oi, 0);
-}
-
-static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
-    return cpu_ldq_code_mmu(env, addr, oi, 0);
-}
 #endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.53.0


