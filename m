Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C00C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6j-0005hV-Qg; Thu, 18 Jul 2024 21:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5y-0003Hx-Ui
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5u-0000ml-MG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc4fcbb131so13396695ad.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351253; x=1721956053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ06f1POln3X8Sb8fDa8/CDLulrLL54olCBz3brWMPA=;
 b=HIgrXQvijkfwIOy0gZzA5J5UwBcIKZUzRC+Jyo3xzqNlBZG4WjXb3zP5Mb0Ews37sp
 0iBkAH7iQ45kgAHY8gZbIHvCdAZghfZVxpP8I8wBtDhyqYuS9EttXICk4j1Vv2E9aaoe
 Waw8jD2rR3gFQIqI64edXjGldGJlrSyUsc9cOeRbRsvQ4dg8I4a/Kh8/4kNHDT3rUulJ
 F8LWIZmTizxMwc6odIaVZEy2Wnwau1haoVXONYkO2ZWErSgZRezY3aNERNszuUsaSRrY
 ab+neIXBox/Z0eqeKqKcynXOKjEU+5b4CWOhpKQ+9LZvTQhZZ8Rbvi7+dZMsygRSIV6R
 WDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351253; x=1721956053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQ06f1POln3X8Sb8fDa8/CDLulrLL54olCBz3brWMPA=;
 b=bAWoLBqwJJ3e3os0n3obj0mmRY8kLHcyWKjYAGO1kZABKskVFwpPH9SnypB7nxwkyW
 DRJp8mSV7bmQ+bt7WAPFp/Ks1QupeKrMxbCz0J7ZelbYyn2J7w4yhysooajve39OM402
 UmTaY1PatgnxS7sxHrtwnBPsuR2KPFPXDGzaaRNCsHfaSoEkxEmA9wSv2kG9KNirg2nd
 r9509fb1V7qdRzyXI95mzH0VmDh+A8dYdR1sONd81uFJqTi6MVh67REMId6HEj0tM3Qq
 p3uSstaYAKUdzHYXGAO6xLH/RMd9dgAIJvUH5VSMWeBTmff3pigTbuivk/U3ifmsg4/7
 CSAg==
X-Gm-Message-State: AOJu0Yz6t4Mx0pQHz0PbprGXmaLhlCd0CbWtsrGs752hPxtBxRa+GUls
 o2c7te0WWOiN/uWOqt5GWU5dQU7yKzP00XdJXEFSBxR6DgO9YKqD0PqhKk1eYJBykmCMBp58/aW
 xWCHzvQ==
X-Google-Smtp-Source: AGHT+IF3mRrWGCj3N1CNJB9+cHrjqJbSl0d9QpMI2YvmWRQp+oVn40+gO9c7c0oioTT97sybP5Wl6Q==
X-Received: by 2002:a17:903:41c7:b0:1fa:8f64:8b0d with SMTP id
 d9443c01a7336-1fc4e154b4fmr67172795ad.4.1721351252633; 
 Thu, 18 Jul 2024 18:07:32 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 05/12] target/ppc: Hoist dcbz_size out of dcbz_common
Date: Fri, 19 Jul 2024 11:07:00 +1000
Message-ID: <20240719010707.1319675-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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


