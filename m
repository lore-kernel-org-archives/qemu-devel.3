Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF48C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6J2-0002R5-V2; Mon, 22 Jul 2024 23:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J0-0002IZ-JT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iz-0001x1-0R
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so1452342b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705710; x=1722310510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ06f1POln3X8Sb8fDa8/CDLulrLL54olCBz3brWMPA=;
 b=aao1tx64iHeJ5dRihmsiRGT8WTyUKfMorDTjPha1eX0Hf6XwWW8UVU/2Hj1WPATIrX
 2aRdDTJbLCN2j3bl6ZMYeF/4jaRsN5ocHwuS6aOLoVdQe39BbWjAL/GXKjph56aaU4Cw
 dtx1uODqE5UMZqHDT93z0zA7Y1knt+LLOTq6Lr8Ja1knXkmQOOjAJ6iy72RV4GuryAUi
 Fh8tTDuT0J5OAFaX0MSkx6KWO9zr9VRhLa6ZTlu/+XVjbzF96Yd3BmoCv0BN2al9XooR
 Ld03CKePt1Of1yyLXJ9MduHLZYk9FHj6RCpdETMl1ACYu5GuClzHn2hGWZN1OCyUaReI
 eNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705710; x=1722310510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQ06f1POln3X8Sb8fDa8/CDLulrLL54olCBz3brWMPA=;
 b=XnHj72vn9OVK8uCjW8c4aRslUDQ67PkTHhQ+EkCwZ8Mn9tdeLMIZQxzqF689ZVZ2Fa
 kq8FCHwNvE4xUWNIrT6wQerD1yEVl2Wn/+Vw4bvDIu0xQPK2e1w+azI4WF0mLcoJkx3o
 AmRb8Q77YfMelZZFL+NnNe6TvKELoNW0sHw1EziwjFg8eGbI3VqBAOh+YgpXFqGztiGw
 DMse9nW/vrYMuFNRKpZyd2EiX55CXRBtTmBvAMhaIBZJQKXS4ez71QpauZ4Wgzy9B8Tf
 J+LNHpRoqxtQSYbt6cSPRw2EL4lrjuWJ9k/6SUEKrLliGpSkU08nft/OiVYhAplJqwf4
 nPIw==
X-Gm-Message-State: AOJu0Yx2tP8GcFlzvD77z6oKd9v9/fWuBJs84dYtmQLE7iq4ti2yrmwO
 FWEpINfBXIWznmNJyjaIEbCdRvUCl04NnqQvUPvSoSLwqt+IoZ2dIObz+6c3KZdpqqnRzUzhAdz
 mHZ8G0Q==
X-Google-Smtp-Source: AGHT+IF7Z2lbnp9CXecA00v0CI0UH7DfLhBQiAPO5S0ntBDAA3cLFNI02NviW0TQWSw6s/3lfb/DwQ==
X-Received: by 2002:aa7:8457:0:b0:70c:e1ec:4233 with SMTP id
 d2e1a72fcca58-70e80779778mr1312903b3a.6.1721705710365; 
 Mon, 22 Jul 2024 20:35:10 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 05/12] target/ppc: Hoist dcbz_size out of dcbz_common
Date: Tue, 23 Jul 2024 13:34:44 +1000
Message-ID: <20240723033451.546151-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The 970 logic does not apply to dcbzep, which is an e500 insn.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 361fd72226..5067919ff8 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -271,22 +271,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
 }
 
 static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
+                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
 {
-    target_ulong mask, dcbz_size = env->dcache_line_size;
-    uint32_t i;
+    target_ulong mask = ~(target_ulong)(dcbz_size - 1);
     void *haddr;
 
-#if defined(TARGET_PPC64)
-    /* Check for dcbz vs dcbzl on 970 */
-    if (env->excp_model == POWERPC_EXCP_970 &&
-        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
-        dcbz_size = 32;
-    }
-#endif
-
     /* Align address */
-    mask = ~(dcbz_size - 1);
     addr &= mask;
 
     /* Check reservation */
@@ -300,7 +290,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
         memset(haddr, 0, dcbz_size);
     } else {
         /* Slow path */
-        for (i = 0; i < dcbz_size; i += 8) {
+        for (int i = 0; i < dcbz_size; i += 8) {
             cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
     }
@@ -308,12 +298,22 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
 
 void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC());
+    int dcbz_size = env->dcache_line_size;
+
+#if defined(TARGET_PPC64)
+    /* Check for dcbz vs dcbzl on 970 */
+    if (env->excp_model == POWERPC_EXCP_970 &&
+        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
+        dcbz_size = 32;
+    }
+#endif
+
+    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
 }
 
 void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
+    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
 }
 
 void helper_icbi(CPUPPCState *env, target_ulong addr)
-- 
2.43.0


