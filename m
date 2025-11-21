Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82350CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcyk-0003tY-FZ; Fri, 21 Nov 2025 21:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMc82-0005Ri-L3
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:09:30 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMc61-0003hS-2P
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:09:27 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b736d883ac4so480458066b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763773622; x=1764378422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6GufoGaaceDifeP+Y5j1u2tXZkEGmQIoKK0KjlWQxI=;
 b=QcmHwVUSfUI66wGfvzfAFMbLbPs3CGFNwJjgh+MPerIur9TWHwkw5HD/iZxQrdL3vl
 daOciwc7diYwPFZFib0uJr8dtzv2O85o3aUS6EL+dx3X0TX20bXNXc0pn2TxLdoG2TW2
 2447twYFJG5aH+aVc/CaITODW390koumctbgFEaljN7Orx4Pz2bsUkTSGPfVgqJgjAQv
 MLP17s6INdPoahbrh2oMtTHY61i9MFUXAIqdJahgx221VlVvkLKB9uV52yDPjDuGC7T9
 DVusniGfhoqB+mhR25dYMGfspXXNRWngwzXQXT/mw5wsw2OxWiZiAOB3ga4mkT4Yo3dI
 qk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763773622; x=1764378422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g6GufoGaaceDifeP+Y5j1u2tXZkEGmQIoKK0KjlWQxI=;
 b=ZXmQTnHgJG2wWedW45/Zu0ZissFcWBej+aAUZV50688ochUmSiEbz5fBm1fi2l7LMh
 AQeut6svz518EwnmVW4K4PonWGU5h/PdT7CU8WO4SglTVYGoIJnp9JrAFQX2rFqF3zq5
 CFJuCtin5E4vQi/XK1n74PBYhqiaDAYeh1L+aaAEV1BX99fqcElx+pRECYUPHZB/MVoU
 ipRzVs/3qr7qZCwuJxLwCWKNnhwyGk+Gv+EGlE9DE8BpTUKs8XdpQBKLumc4u1bKTNV7
 xqzeqh6EOGXMmuPyQDV7M789XSXwbjht/NO7Ys/1YGfRdxLZCE+dmf8kb1mF0mbH8z3/
 uk/g==
X-Gm-Message-State: AOJu0YyWSLnlBBhscNoCtyQivOLLRu8ZQ2XyiUKAIqgoASLaQ6NgYnHQ
 Z4vSdSeB3B2Ic4zqRwSb5DSkBqCnup4f4zkkKRnTB/4U3SvtPeHng5iLf2CBBYTVFKygaAjOwA/
 UDXDsgE7IhA==
X-Gm-Gg: ASbGncu5B+H2VR0SL1JmP3WRqxHn8B2MkvgUTDBYARo1Ox0zzvPydUQmiHenCrQnJt3
 2ptcGzbGUZmZaQ7onfymTTXNCdhskMU7rhQIaPdvQxRPofbj/YW1NcX9JyWuuW9KAxSs6H8RCF0
 MnWt83DJ1zp78s0FIshgaM3PsGF3VgTfNRrKu7qTbFVRMAQVFDuDwju8+/GUjhJ46lu9Tp/Gq4P
 VT+RpJBjThsOg9qhKiCxZZN+v+905W1g2FypWPEvDKCwS8E4Yr/tgp0SSRct1bhCZqmzFSsq/Ap
 o8YcksfI44wwSkfkst7pnYI8j9Oj7e7VWD6u3FxyBFRerwy8GB6JMHg+1HGbZV3aoyhOf0LAWCs
 k0u+/ALV1juZ+H7mSY5HRwyYDulogCq34X3p/e1vYZsmDOuD2b7uz6mUpEmB9J9amRbPnTAo6RK
 NKX2HQPblyvtAaOXOZwzlBehG9dEh7sJEJjZl7fPKnK8i8WmfMqEJQEwQ72rD/
X-Google-Smtp-Source: AGHT+IFEr1L37DDCfdrNIDzi/3UTfYU9WR/5linL3zRdS9ErRGrUqnsYjkIglEr/vK2vRoT+SqG2zQ==
X-Received: by 2002:a05:600c:3590:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-477c0184a94mr35783445e9.15.1763732778819; 
 Fri, 21 Nov 2025 05:46:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf355af6sm44415315e9.3.2025.11.21.05.46.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 11/21] target/tricore: Use little-endian
 variant of cpu_ld/st_data*()
Date: Fri, 21 Nov 2025 14:44:53 +0100
Message-ID: <20251121134503.30914-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

We only build the TriCore target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=tricore; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/op_helper.c | 152 ++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 2c8281a67e0..88b50bc1a9b 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2451,84 +2451,84 @@ static bool cdc_zero(uint32_t *psw)
 
 static void save_context_upper(CPUTriCoreState *env, uint32_t ea)
 {
-    cpu_stl_data(env, ea, env->PCXI);
-    cpu_stl_data(env, ea+4, psw_read(env));
-    cpu_stl_data(env, ea+8, env->gpr_a[10]);
-    cpu_stl_data(env, ea+12, env->gpr_a[11]);
-    cpu_stl_data(env, ea+16, env->gpr_d[8]);
-    cpu_stl_data(env, ea+20, env->gpr_d[9]);
-    cpu_stl_data(env, ea+24, env->gpr_d[10]);
-    cpu_stl_data(env, ea+28, env->gpr_d[11]);
-    cpu_stl_data(env, ea+32, env->gpr_a[12]);
-    cpu_stl_data(env, ea+36, env->gpr_a[13]);
-    cpu_stl_data(env, ea+40, env->gpr_a[14]);
-    cpu_stl_data(env, ea+44, env->gpr_a[15]);
-    cpu_stl_data(env, ea+48, env->gpr_d[12]);
-    cpu_stl_data(env, ea+52, env->gpr_d[13]);
-    cpu_stl_data(env, ea+56, env->gpr_d[14]);
-    cpu_stl_data(env, ea+60, env->gpr_d[15]);
+    cpu_stl_le_data(env, ea, env->PCXI);
+    cpu_stl_le_data(env, ea+4, psw_read(env));
+    cpu_stl_le_data(env, ea+8, env->gpr_a[10]);
+    cpu_stl_le_data(env, ea+12, env->gpr_a[11]);
+    cpu_stl_le_data(env, ea+16, env->gpr_d[8]);
+    cpu_stl_le_data(env, ea+20, env->gpr_d[9]);
+    cpu_stl_le_data(env, ea+24, env->gpr_d[10]);
+    cpu_stl_le_data(env, ea+28, env->gpr_d[11]);
+    cpu_stl_le_data(env, ea+32, env->gpr_a[12]);
+    cpu_stl_le_data(env, ea+36, env->gpr_a[13]);
+    cpu_stl_le_data(env, ea+40, env->gpr_a[14]);
+    cpu_stl_le_data(env, ea+44, env->gpr_a[15]);
+    cpu_stl_le_data(env, ea+48, env->gpr_d[12]);
+    cpu_stl_le_data(env, ea+52, env->gpr_d[13]);
+    cpu_stl_le_data(env, ea+56, env->gpr_d[14]);
+    cpu_stl_le_data(env, ea+60, env->gpr_d[15]);
 }
 
 static void save_context_lower(CPUTriCoreState *env, uint32_t ea)
 {
-    cpu_stl_data(env, ea, env->PCXI);
-    cpu_stl_data(env, ea+4, env->gpr_a[11]);
-    cpu_stl_data(env, ea+8, env->gpr_a[2]);
-    cpu_stl_data(env, ea+12, env->gpr_a[3]);
-    cpu_stl_data(env, ea+16, env->gpr_d[0]);
-    cpu_stl_data(env, ea+20, env->gpr_d[1]);
-    cpu_stl_data(env, ea+24, env->gpr_d[2]);
-    cpu_stl_data(env, ea+28, env->gpr_d[3]);
-    cpu_stl_data(env, ea+32, env->gpr_a[4]);
-    cpu_stl_data(env, ea+36, env->gpr_a[5]);
-    cpu_stl_data(env, ea+40, env->gpr_a[6]);
-    cpu_stl_data(env, ea+44, env->gpr_a[7]);
-    cpu_stl_data(env, ea+48, env->gpr_d[4]);
-    cpu_stl_data(env, ea+52, env->gpr_d[5]);
-    cpu_stl_data(env, ea+56, env->gpr_d[6]);
-    cpu_stl_data(env, ea+60, env->gpr_d[7]);
+    cpu_stl_le_data(env, ea, env->PCXI);
+    cpu_stl_le_data(env, ea+4, env->gpr_a[11]);
+    cpu_stl_le_data(env, ea+8, env->gpr_a[2]);
+    cpu_stl_le_data(env, ea+12, env->gpr_a[3]);
+    cpu_stl_le_data(env, ea+16, env->gpr_d[0]);
+    cpu_stl_le_data(env, ea+20, env->gpr_d[1]);
+    cpu_stl_le_data(env, ea+24, env->gpr_d[2]);
+    cpu_stl_le_data(env, ea+28, env->gpr_d[3]);
+    cpu_stl_le_data(env, ea+32, env->gpr_a[4]);
+    cpu_stl_le_data(env, ea+36, env->gpr_a[5]);
+    cpu_stl_le_data(env, ea+40, env->gpr_a[6]);
+    cpu_stl_le_data(env, ea+44, env->gpr_a[7]);
+    cpu_stl_le_data(env, ea+48, env->gpr_d[4]);
+    cpu_stl_le_data(env, ea+52, env->gpr_d[5]);
+    cpu_stl_le_data(env, ea+56, env->gpr_d[6]);
+    cpu_stl_le_data(env, ea+60, env->gpr_d[7]);
 }
 
 static void restore_context_upper(CPUTriCoreState *env, uint32_t ea,
                                   uint32_t *new_PCXI, uint32_t *new_PSW)
 {
-    *new_PCXI = cpu_ldl_data(env, ea);
-    *new_PSW = cpu_ldl_data(env, ea+4);
-    env->gpr_a[10] = cpu_ldl_data(env, ea+8);
-    env->gpr_a[11] = cpu_ldl_data(env, ea+12);
-    env->gpr_d[8]  = cpu_ldl_data(env, ea+16);
-    env->gpr_d[9]  = cpu_ldl_data(env, ea+20);
-    env->gpr_d[10] = cpu_ldl_data(env, ea+24);
-    env->gpr_d[11] = cpu_ldl_data(env, ea+28);
-    env->gpr_a[12] = cpu_ldl_data(env, ea+32);
-    env->gpr_a[13] = cpu_ldl_data(env, ea+36);
-    env->gpr_a[14] = cpu_ldl_data(env, ea+40);
-    env->gpr_a[15] = cpu_ldl_data(env, ea+44);
-    env->gpr_d[12] = cpu_ldl_data(env, ea+48);
-    env->gpr_d[13] = cpu_ldl_data(env, ea+52);
-    env->gpr_d[14] = cpu_ldl_data(env, ea+56);
-    env->gpr_d[15] = cpu_ldl_data(env, ea+60);
+    *new_PCXI = cpu_ldl_le_data(env, ea);
+    *new_PSW = cpu_ldl_le_data(env, ea+4);
+    env->gpr_a[10] = cpu_ldl_le_data(env, ea+8);
+    env->gpr_a[11] = cpu_ldl_le_data(env, ea+12);
+    env->gpr_d[8]  = cpu_ldl_le_data(env, ea+16);
+    env->gpr_d[9]  = cpu_ldl_le_data(env, ea+20);
+    env->gpr_d[10] = cpu_ldl_le_data(env, ea+24);
+    env->gpr_d[11] = cpu_ldl_le_data(env, ea+28);
+    env->gpr_a[12] = cpu_ldl_le_data(env, ea+32);
+    env->gpr_a[13] = cpu_ldl_le_data(env, ea+36);
+    env->gpr_a[14] = cpu_ldl_le_data(env, ea+40);
+    env->gpr_a[15] = cpu_ldl_le_data(env, ea+44);
+    env->gpr_d[12] = cpu_ldl_le_data(env, ea+48);
+    env->gpr_d[13] = cpu_ldl_le_data(env, ea+52);
+    env->gpr_d[14] = cpu_ldl_le_data(env, ea+56);
+    env->gpr_d[15] = cpu_ldl_le_data(env, ea+60);
 }
 
 static void restore_context_lower(CPUTriCoreState *env, uint32_t ea,
                                   uint32_t *ra, uint32_t *pcxi)
 {
-    *pcxi = cpu_ldl_data(env, ea);
-    *ra = cpu_ldl_data(env, ea+4);
-    env->gpr_a[2] = cpu_ldl_data(env, ea+8);
-    env->gpr_a[3] = cpu_ldl_data(env, ea+12);
-    env->gpr_d[0] = cpu_ldl_data(env, ea+16);
-    env->gpr_d[1] = cpu_ldl_data(env, ea+20);
-    env->gpr_d[2] = cpu_ldl_data(env, ea+24);
-    env->gpr_d[3] = cpu_ldl_data(env, ea+28);
-    env->gpr_a[4] = cpu_ldl_data(env, ea+32);
-    env->gpr_a[5] = cpu_ldl_data(env, ea+36);
-    env->gpr_a[6] = cpu_ldl_data(env, ea+40);
-    env->gpr_a[7] = cpu_ldl_data(env, ea+44);
-    env->gpr_d[4] = cpu_ldl_data(env, ea+48);
-    env->gpr_d[5] = cpu_ldl_data(env, ea+52);
-    env->gpr_d[6] = cpu_ldl_data(env, ea+56);
-    env->gpr_d[7] = cpu_ldl_data(env, ea+60);
+    *pcxi = cpu_ldl_le_data(env, ea);
+    *ra = cpu_ldl_le_data(env, ea+4);
+    env->gpr_a[2] = cpu_ldl_le_data(env, ea+8);
+    env->gpr_a[3] = cpu_ldl_le_data(env, ea+12);
+    env->gpr_d[0] = cpu_ldl_le_data(env, ea+16);
+    env->gpr_d[1] = cpu_ldl_le_data(env, ea+20);
+    env->gpr_d[2] = cpu_ldl_le_data(env, ea+24);
+    env->gpr_d[3] = cpu_ldl_le_data(env, ea+28);
+    env->gpr_a[4] = cpu_ldl_le_data(env, ea+32);
+    env->gpr_a[5] = cpu_ldl_le_data(env, ea+36);
+    env->gpr_a[6] = cpu_ldl_le_data(env, ea+40);
+    env->gpr_a[7] = cpu_ldl_le_data(env, ea+44);
+    env->gpr_d[4] = cpu_ldl_le_data(env, ea+48);
+    env->gpr_d[5] = cpu_ldl_le_data(env, ea+52);
+    env->gpr_d[6] = cpu_ldl_le_data(env, ea+56);
+    env->gpr_d[7] = cpu_ldl_le_data(env, ea+60);
 }
 
 void helper_call(CPUTriCoreState *env, uint32_t next_pc)
@@ -2566,7 +2566,7 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2632,7 +2632,7 @@ void helper_ret(CPUTriCoreState *env)
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
@@ -2662,7 +2662,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
     ea = ((env->FCX & 0xf0000) << 12) + ((env->FCX & 0xffff) << 6);
 
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, A[11], A[2], A[3], D[0], D[1], D[2], D[3], A[4]
                            , A[5], A[6], A[7], D[4], D[5], D[6], D[7]}; */
     save_context_lower(env, ea);
@@ -2726,7 +2726,7 @@ void helper_rfe(CPUTriCoreState *env)
       A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
     /* M(EA, word) = FCX;*/
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
@@ -2744,10 +2744,10 @@ void helper_rfm(CPUTriCoreState *env)
     icr_set_ccpn(env, pcxi_get_pcpn(env));
 
     /* {PCXI, PSW, A[10], A[11]} = M(DCX, 4 * word); */
-    env->PCXI = cpu_ldl_data(env, env->DCX);
-    psw_write(env, cpu_ldl_data(env, env->DCX+4));
-    env->gpr_a[10] = cpu_ldl_data(env, env->DCX+8);
-    env->gpr_a[11] = cpu_ldl_data(env, env->DCX+12);
+    env->PCXI = cpu_ldl_le_data(env, env->DCX);
+    psw_write(env, cpu_ldl_le_data(env, env->DCX+4));
+    env->gpr_a[10] = cpu_ldl_le_data(env, env->DCX+8);
+    env->gpr_a[11] = cpu_ldl_le_data(env, env->DCX+12);
 
     if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         env->DBGTCR = 0;
@@ -2794,7 +2794,7 @@ void helper_svlcx(CPUTriCoreState *env)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2837,7 +2837,7 @@ void helper_svucx(CPUTriCoreState *env)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2887,9 +2887,9 @@ void helper_rslcx(CPUTriCoreState *env)
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_lower(env, ea, &env->gpr_a[11], &new_PCXI);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
-- 
2.51.0


