Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79588C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLw-00016b-Jn; Thu, 01 May 2025 17:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLm-00010f-QR
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:46 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLk-0001a2-Uj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:46 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso1549852a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134503; x=1746739303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSNENHYud6d4CatFFmLB8e+vJFaHLohbjF+bNPxyKN0=;
 b=qsQlbzu15cPm/B9PbtnhCat2e34FpVPYvOTxlTApFPjSnmXViMEABeJ1GTthR+9c+P
 B1qUxP9M6PsvmKNU7wKquwzBRCS7zd6QmDrv1u1VF+4jAfM0W0kzjBXJ/EffxiibBM53
 wEeLzJx3e3NFnx5GzRaXSe6hSo0OGkcryUQIHE/Ke/0EnnknAzJXviXc6OkxQaM1GFiw
 r13UIR+ma79VsTLuaySqAmflukqTaW+I326ptIbALFQPetbO8a+2Qu6P2Hkpjz1FojG9
 kuRwOcZREPxLdg7MAj125P79KQUjS9uUs6Z/A6+BwVC11UbkhuVnsGxnJOFGOk4HlsPF
 Hkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134503; x=1746739303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSNENHYud6d4CatFFmLB8e+vJFaHLohbjF+bNPxyKN0=;
 b=vSK6nX0gJcymHnF8LcpWgQGBPbK/DecQeIVnYsCre5FaXk3oIaHex5gQgYGMw1lHZ+
 K1fe1LxEAmWkERrpsVwuM+0GNieWm0wkVRuQp5lZa9/iNjQrNsYM8t9HG+MdUI7/KUYr
 3tur+0D3pKzLZiZ9bKCf0O3GFlQ7FupiJB1Tut+nxfmFsIwUjgwzKoE9lH1h9CL8hAh3
 ll0QG/db0K9eqb2iufYYjNri8TmsmhMTR5Stu6aAPSzxKdMYr/viD6Qq6xr1m7EBXNIQ
 E07riiobeEckD7gQPRiiLlpmzZvAXH8tcNacTIKiJXw7k1NGbe9QBT+l4t6+6nYueOiM
 s5NA==
X-Gm-Message-State: AOJu0YxGByEvNn3D9IprJ8F3Suq2lINQhTsjR3KCWiTtisQMxyFY63lV
 UtQkLu63XFa1CN9o3oDACbPE07h2FxYOz32d/lPl0rVoyp0DyGPPe6NgWPuahPlw86osztYPHPo
 s
X-Gm-Gg: ASbGnctBSEf9besw1OU+U7Nk0NpUNM1jzMoUIApdKbNj1eupYcF725Q/x/nc0bWe6AH
 2Kkr2VwoSvf1e723LQpemWYhcdYRFCY+gL85YAXhdrlO5XtvLhTfq04XcHP4B8jSH1W82sN/c+A
 Yc2zZlIZ36CfWhTgDpGdouqDgRhmbd8jWZ+Jwu8zUaGqX72dBBkkGHE+iIJEG2O++ktxIn6AXJC
 QhpjMyUN+TiKyMadzbLR6b7oNMKYjkyXy1rrzDfFT4l/0K01T/kv4yerhjC1qb0TCgL+N4IQ5oi
 vGgPJ8SZXyHMxlAhOc99MmAZZ8/O7I0IAB9+8Vmt1k6lALnufsjFp0qXC24ZtavqIAlgMm5kL0A
 =
X-Google-Smtp-Source: AGHT+IFqeurWgzAdWXiCr2xo/aNnUUVo7i37e/pkV/HcufWGGogozmrYxEVK1u7RDDAVb0OD2cmCZg==
X-Received: by 2002:a17:90a:e705:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-30a4e6befe1mr877791a91.31.1746134503540; 
 Thu, 01 May 2025 14:21:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 35/59] accel/tcg: Pass TCGTBCPUState to tb_htable_lookup
Date: Thu,  1 May 2025 14:20:49 -0700
Message-ID: <20250501212113.2961531-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 808983e461..8e6899950e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -195,26 +195,24 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     return false;
 }
 
-static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
-                                          uint64_t cs_base, uint32_t flags,
-                                          uint32_t cflags)
+static TranslationBlock *tb_htable_lookup(CPUState *cpu, TCGTBCPUState s)
 {
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
     uint32_t h;
 
     desc.env = cpu_env(cpu);
-    desc.cs_base = cs_base;
-    desc.flags = flags;
-    desc.cflags = cflags;
-    desc.pc = pc;
-    phys_pc = get_page_addr_code(desc.env, pc);
+    desc.cs_base = s.cs_base;
+    desc.flags = s.flags;
+    desc.cflags = s.cflags;
+    desc.pc = s.pc;
+    phys_pc = get_page_addr_code(desc.env, s.pc);
     if (phys_pc == -1) {
         return NULL;
     }
     desc.page_addr0 = phys_pc;
-    h = tb_hash_func(phys_pc, (cflags & CF_PCREL ? 0 : pc),
-                     flags, cs_base, cflags);
+    h = tb_hash_func(phys_pc, (s.cflags & CF_PCREL ? 0 : s.pc),
+                     s.flags, s.cs_base, s.cflags);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
@@ -253,7 +251,7 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, TCGTBCPUState s)
         goto hit;
     }
 
-    tb = tb_htable_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
+    tb = tb_htable_lookup(cpu, s);
     if (tb == NULL) {
         return NULL;
     }
-- 
2.43.0


