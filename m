Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B502E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRWS-0002M0-8s; Wed, 24 Dec 2025 11:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWE-0002I1-Nb
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:25 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWD-0001Wc-78
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:22 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so2947072f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592919; x=1767197719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zs57cHXJrxQHG8Jmpg5M3XmeKAvz3SsUINYRy+npOQE=;
 b=uCf3CyZ+rHGsB7WfFHAElMGWoWE/8GXosyo2t9+bJEsypFpna2dYIbDTIVra+J/lsf
 UHwlgPi0Lj0ckgpr/7BYLiW3EUwPCt6DH+eWNaed8ua2ua2LlrgapedUMLS5e9OkyZP9
 I2E/GyIYfJFBg4hUhcgQxarPYHNXRHq7rJFGnImtzy2WeR5ZjhfgmZmzJ8Qwik7atN8H
 EE31Ez1ZEZXUXMVSPWf0iBRvVVKj2ApTXJ//dIaA9AAM4/x7vnXQOKoB+JSzM5dN76L+
 xsRZQUyUxTHLqBOr6rm5AssV0uM4RHaVOG5YenLom8ijWG5t/iysHcOhrv1RBj2czDeA
 KRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592919; x=1767197719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zs57cHXJrxQHG8Jmpg5M3XmeKAvz3SsUINYRy+npOQE=;
 b=XbEj4QW3d5S6Bi/Zx3YmjjdewO7fW63B1TUzfwtQDaFD4ahBUpVccsWJzcugSkbXri
 vhRepKQS0UbMv/kcwXasCfDG8NAYl2eGwAtEaOMJl4BNPO9Iy9T9kFHHAhJTVP50MNX6
 L7d00pX43FbrqjVOz7ZXlLVD3zqGdy5Q4H7fmaZdYoRQfUBgttAZJ8dy4PxrzhJdg+Zi
 qacz9jgAR0K/5vZvJ5JZhf8eUCcvApQ/F49aeJh2a0RhnwFPukTN0yHmB4cSKSgIH4wz
 VISfp3bjOllJ7R/7nusTS5O1aRDxpU09flTKUwypYBrZLLzITfgnkO48qXK4ruhr+qdb
 UTcQ==
X-Gm-Message-State: AOJu0YxxHaipiVh6p9NfvWEdwiPDU9nj+KODTlLj70OB7tfGzyltajCB
 RyCtJ2CHo+8vD7ufZkizBQy8+ha7DtMWDg9HBBQjL3QGjxV+cAE/gu9rbUqfEDX6gUAddq7hT+u
 KbbI+12o=
X-Gm-Gg: AY/fxX7Awtr+UELd1xF9vOBX4MrkN/THhxVtFYH6e4lZhkUQzJDcqc8ePZUk4bICYHF
 mvogH/jU0VdVLhFOH0Cnde4xEhfVc29hGKjZhYIlcwmUDqvRZ0W3NdJW6jR/oFN7tedlr4cg8eL
 juEBeaTfZGOSLe1AEXGElJpVuN9q2SZfhgiWEAr2OiiSg1qKWKq84oaZbFfdUVwQ+QJMSdar/zr
 a1MzYYoWujl5N87d7Zm3febFgRu6lqpBS4hO+FAv9CSu5cPKkl7YxVgh9QKU9NbH/v4qecPuZZ5
 YK9WGaTHX5Flsf0O+Jhmz9lBVVu6cUYGStAVLJEyXTXgM44WSM8jWSLqFg4+qE4nhAyB0omsiql
 rwWl3RffBSuzc+Ra9nxW0r+IKAD2CPMOq6Pj0jM6aTT7oZSDaZ7FkKXYvtqJkSwJu2GivVS2+xz
 1BhyaFDPJxYb46mObTzmns3xuqqo2wS9LuLgxibqHyIZB3Ye4rmb7sUiBGDtF+vCEhOw==
X-Google-Smtp-Source: AGHT+IEPNgx7Pq1qn6T4lZOLSzeKsJqZ5VClMLZ7m2BlroIU3yN+F4dW8yepATfaHHkUe5NTUckynA==
X-Received: by 2002:a05:6000:1843:b0:431:342:ad44 with SMTP id
 ffacd0b85a97d-4324e50dc75mr20797478f8f.45.1766592919356; 
 Wed, 24 Dec 2025 08:15:19 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2ebfsm34605433f8f.40.2025.12.24.08.15.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:15:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] target/loongarch: Replace target_ulong -> uint64_t for
 DMW and TLBRBADV
Date: Wed, 24 Dec 2025 17:14:50 +0100
Message-ID: <20251224161456.89707-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The Direct Mapping Configuration Window and Bad Virtual
Address CSR registers are declared as uint64_t since their
introduction in commit 398cecb9c3e ("target/loongarch: Add
CSRs definition"):

 296 typedef struct CPUArchState {
 ...
 345     uint64_t CSR_TLBRBADV;
 ...
 359     uint64_t CSR_DMW[4];
 ...
 385 } CPULoongArchState;

Use the proper uint64_t type instead of target_ulong
(which would otherwise be truncated on 32-bit builds).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu_helper.c     | 2 +-
 target/loongarch/tcg/tlb_helper.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index a6eba4f4160..4864f4d6d87 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -289,7 +289,7 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
     return TLBRET_NOMATCH;
 }
 
-static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, target_ulong dmw)
+static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
 {
     if (is_la64(env)) {
         return va & TARGET_VIRT_MASK;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 01e0a27f0bd..873a0a1b0c4 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -690,7 +690,8 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong badvaddr, index, phys;
+    uint64_t badvaddr;
+    target_ulong index, phys;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -725,7 +726,8 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
                   uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, badv;
+    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1;
+    uint64_t badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
     uint64_t dir_base, dir_width;
-- 
2.52.0


