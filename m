Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865A2C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6J9-0002qz-0W; Mon, 22 Jul 2024 23:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J5-0002b1-8t
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:19 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J3-0001yL-DF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d24ee678cso1266765b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705716; x=1722310516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvZQYGxfhFbqPHPcUgtNXtbdH2OSgyvIGjZjBPS5VAI=;
 b=ZA8HimR2ev5/mALl9DogQZ8cfGNteOWSGqthzfTo++9LOVEK48AsoNhqnEo+Q4zW56
 UMuHynzVyOojQYtM5hHv5+9L6VMoxGqMrW+d4ce0HQUPcre5hDpiSEv1sLRnv28I/WYy
 bXUQJltfJZpvnYUJRlYaR2mvbk8V9w92fp/Ukwf3QE70zCPlKmK5CLRij+R4TIF6XWfL
 FAk8ywGLEfLpUs2auhzl3L39gdZJgCvjnLrG/LSC7+QH+p3NAf+/Ers5l8DNv461bNPj
 W9OCLsy8TmCAXv8cLzOUbSCjxV1EZTMSGjPM3NpZiWEp3QwmxSRl2laZ5aTMFadnvBhG
 aSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705716; x=1722310516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvZQYGxfhFbqPHPcUgtNXtbdH2OSgyvIGjZjBPS5VAI=;
 b=FJY8LZDnN6uG0TN08mhDHb7E+hCj50s/FgfxmVJWhMmb06w3Pd32fYhZyhc92rJ3Wq
 NwuT2xavJ1I7zoJdinYfEcEhFfKKSl172RF/wYSxviG6ZlDpuHEXRgtr2T4MRR/O75rt
 m4UVR4hIFpe40abIbd4EGvS+an1LzEmFPp7pPlpaNOa+C7SgElbRhtfoF9jHbg2p+bDd
 kTHbZqtSH2Gejo+ZKKytl8zkOBJsSExyw9xK5M13Gv2l0AttLBYGyCK1t/nMdFz8IID3
 4wkWOR4jKlcO0xvqavNruDBUnD+SzCl+p0nFzrCoBHihh4Xk3xMBVyAiyOgajN4f2dXz
 sR2g==
X-Gm-Message-State: AOJu0Yxu678z8J9KIa80yxBP+z+Ic81XgTb76PwYdWC/9C2vXViDk7Nj
 1Xt/hzC7U6MUohUGEp9yGmledoVa5aB/O0/IYh41cjo4/vmP4yml0FWodSSH5eopzrbLyVAHryW
 G7Sxh1g==
X-Google-Smtp-Source: AGHT+IHqxQg7bcdbbJXYOsARf99xSp0swsxEGbO+JuNANLa0Gc32UM6509PM6wsFywuIyT2+ewjwGw==
X-Received: by 2002:a05:6a00:2e86:b0:70d:2497:383 with SMTP id
 d2e1a72fcca58-70d24970528mr4861457b3a.18.1721705715463; 
 Mon, 22 Jul 2024 20:35:15 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 07/12] target/ppc: Merge helper_{dcbz,dcbzep}
Date: Tue, 23 Jul 2024 13:34:46 +1000
Message-ID: <20240723033451.546151-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Merge the two and pass the mmu_idx directly from translation.
Swap the argument order in dcbz_common to avoid extra swaps.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  3 +--
 target/ppc/mem_helper.c | 14 ++++----------
 target/ppc/translate.c  |  4 ++--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index afc56855ff..4fa089cbf9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -46,8 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(lsw, void, env, tl, i32, i32)
 DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
-DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
 #ifdef TARGET_PPC64
 DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
 #endif
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index d4957efd6e..24bae3b80c 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -271,7 +271,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
 }
 
 static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
+                        int mmu_idx, int dcbz_size, uintptr_t retaddr)
 {
     target_ulong mask = ~(target_ulong)(dcbz_size - 1);
     void *haddr;
@@ -296,15 +296,9 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr)
+void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
 {
-    dcbz_common(env, addr, env->dcache_line_size,
-                ppc_env_mmu_index(env, false), GETPC());
-}
-
-void helper_dcbzep(CPUPPCState *env, target_ulong addr)
-{
-    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
+    dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
 }
 
 #ifdef TARGET_PPC64
@@ -320,7 +314,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
         dcbz_size = 32;
     }
 
-    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+    dcbz_common(env, addr, ppc_env_mmu_index(env, false), dcbz_size, GETPC());
 }
 #endif
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9e472ab7ef..cba943a49d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4458,7 +4458,7 @@ static void gen_dcbz(DisasContext *ctx)
     }
 #endif
 
-    gen_helper_dcbz(tcg_env, tcgv_addr);
+    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(ctx->mem_idx));
 }
 
 /* dcbzep */
@@ -4468,7 +4468,7 @@ static void gen_dcbzep(DisasContext *ctx)
 
     gen_set_access_type(ctx, ACCESS_CACHE);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbzep(tcg_env, tcgv_addr);
+    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(PPC_TLB_EPID_STORE));
 }
 
 /* dst / dstt */
-- 
2.43.0


