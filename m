Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCB2C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnDM-00024O-IH; Tue, 02 Jul 2024 19:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDI-00023c-KH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDF-0007VM-Os
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:08 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fa0f143b85so34254225ad.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719964023; x=1720568823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBbLHGYBkBp9/gobRLQEvALvdonH56rxBBHwTgA3fhU=;
 b=La7hAA/Za7VfNFrD0It8cK4uq9sq0ZCbXEEVkN0yrIkMXpuuTRpNCKH1aV14akLz/l
 em1ajFMAmy4VTLUtknfq6zpcNI5XsqK55MNgppq1AzMQQrN4gqLswRhebEiG5D/zfeSQ
 RB3Z39p9oQ+9Vs3ZNMwstQub1LMKuEwpNCWjywwWBsi/OEBtewq0PnkrcjJNZO1HCAah
 P6MqYh+5q391+81URqqRHZoQghgJPjUhRB61yvW2BXp/mnY/z9hyYpSXz8WlDXoxsvGq
 8q1mLZIV7BMUad6H8lA/+gG0jCQXAYoC0lJAsAxsfwE3J3HawBEJyTVFbgKJl+shvcsU
 qsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964023; x=1720568823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBbLHGYBkBp9/gobRLQEvALvdonH56rxBBHwTgA3fhU=;
 b=pEwwDzJrB048oD3o1tq/1/JjEmP/H2+pihjD3h+7ikAHNN4RGg2XKE8Nc05nVrfqTu
 M3knysflvM1ia8Xe+NrARX5DkDPJFaL180rSnt/ymUv3/ki4CHbtwOxGbiX+fRp0biBB
 SkE41BA8SwhxA9DB6da7Jaotnm7NiBD+/KOYWPSPk4LvUqrBND8K3u80BkESAaIDkJJe
 1wYaQBF4ujnfQ4fFfOdf9RuvBcmTiYVBneRZrHgdNgcbR+zkkIE5s1a/JmxORCQG2E5s
 0RNdH/tvljfhlG77hnfMuNiSsmaZEqSC78rQgCdzIJbvV1aRu8VNOtKd4HGsvJHkjA5O
 +aTA==
X-Gm-Message-State: AOJu0YzGLGT5pF+zI01c6eFH5t+ciZUnzC4uRx8pvZhKE5mva4DAHs0i
 kL7IoR5QUFaRzEeND59B+S7mp8fOXrXgo8jNc+GgcSkeSRr3rKLkK8TbKWW0uw8ndhHOIy+U4Cb
 d
X-Google-Smtp-Source: AGHT+IHwbB6PpiO8xfkRQ4W0Fg2xAxTicQ4OQvxDus88e926Dgy9+FxRtLuzc83+tHXPzlBWapZeqQ==
X-Received: by 2002:a17:903:41c8:b0:1fa:acf0:72a6 with SMTP id
 d9443c01a7336-1fadbca1b56mr69196555ad.28.1719964022899; 
 Tue, 02 Jul 2024 16:47:02 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535e62sm90147045ad.154.2024.07.02.16.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:47:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	balaton@eik.bme.hu
Subject: [PATCH 2/4] target/ppc: Hoist dcbz_size out of dcbz_common
Date: Tue,  2 Jul 2024 16:46:57 -0700
Message-Id: <20240702234659.2106870-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702234659.2106870-1-richard.henderson@linaro.org>
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
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

The 970 logic does not apply to dcbzep, which is an e500 insn.

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
2.34.1


