Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F325EC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFh-0001ic-30; Thu, 28 Aug 2025 13:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVS-0007SY-HT
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVP-0008A5-8W
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:13:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7704799d798so707977b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383204; x=1756988004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adyrdy+wc3AR55BfEtJwCQ42orjEroZu6e7hfMaKNNQ=;
 b=NxPIhVqbipkGH1uVVGo61LHCo3O+WxdIUreTx9SeXPndCaAtu60BcoEYejvriZyOsA
 NCCOmOx/eMLpV/2f7R8tJ9iSdamGPaOiZVQSUMge1ftiSJNAkJJzDn9oTstzkMrAtJqr
 xbkL9d3KAjVFtiwuY8tdLlPYs4sqXz0tX090GIMxoar3B8Bebo4EWAPVGFE0xsVOj4TW
 o6EK3MTC2zfQICo7dgc+RAR1AiQG69+G8YN2SzhJ9IakM/G7CG0oZPmq6eE4xnEl8jzA
 dvV5xaCJx3isnxZ7q36ymTw0xUwz9u0awDiKGAeUlIR6QuYyH46TELqd1ZZtBexzTeaZ
 mVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383204; x=1756988004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adyrdy+wc3AR55BfEtJwCQ42orjEroZu6e7hfMaKNNQ=;
 b=kGmG2I2YZjWrz3qWavqVRgocfC5sr9tUIUYkI6I0IaheRSfAWO1GAyj38EKj7+vx3L
 s+mlqCe5t4ZCMM10wPE96urPiXMGgfU4ruvOFr2FIEBZiQvRH6cUv7G3bT9HVSgcx7PT
 qjC0M3gBF+b4sNYT+JkQE8s87fYiRc2KMlBPpDeCOC3YamhE2Uun8+Q+ISMqX7hXHril
 jZXUBpqee2ftKeYgz3IFbBKHp6PWY5vNYs43ELSdACpNyX3KmeZim3z5jmikJiSIS3yS
 lkyRJ4aAgMeDW96bMRl+GrY4iEkLHxWUBiuYiCl42m4FqoXqqjK3SlvQCd4SRea6vzg9
 vm4w==
X-Gm-Message-State: AOJu0Yz3U3B7yYfeCiEQivBsW9tYse8SCNFrqro8+u1Sq1lZEMOTxhQf
 OmJUWh0s5u3GcjuY4QDXZq2/xxB6S1dKyoXgm/MdnLKBBuLCp9Oe8NT/SEDCjAl4UDBhDWFpPv9
 N13x50hE=
X-Gm-Gg: ASbGnctc2JQ1aKTD+pScguRDNB5/HHj3P/WxYUe9ivofVrAzhOPC2cnwgcOy3GWDjgd
 BqxJMn7AcOatMmMMya65/C8mVeQMH4RoZToyIxo6UWLrUMqC22I86DP4P25lbncFsHzYPzTSXTD
 BViPp51nVT9lFYhRBQoRmNrTINgJpx6HN4y25YN9dHvIlyRLKUpjXqcCe3jBG/OIUx6W9r/lQcl
 2T5gNxxdBtBtUFJDEuB3KnTZJJpqZfv/PqxqN0QgbHPUTsofnzXGNFdNiNraHetlpji/MTsiMnE
 dbHuaj/QZHnVMg4QwqQgTbD+elLExEfKB94emx/VUuWPonybNGYI9X6KR6As1PDIeVmM9OzsXgA
 S4xpzfG5xVtfw6oByRCNXZRIq2Q==
X-Google-Smtp-Source: AGHT+IGW5kv0+M1tVyOaEctYjHfWV47syJ5cy7Zd8VQE2FikXBIfvVH9kggSli7fcKzrS4g1o5VkWA==
X-Received: by 2002:a17:903:1988:b0:234:f4da:7eeb with SMTP id
 d9443c01a7336-2462edd7d61mr315425495ad.7.1756383203546; 
 Thu, 28 Aug 2025 05:13:23 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 40/87] linux-user/loongarch64: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:49 +1000
Message-ID: <20250828120836.195358-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Note that the kernel's uses an array, and then it has a bunch of defines
to create symbolic offsets.  Modulo some reserved fields, which we do
not implement here, this is the same layout as struct user_pt_regs.

Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/target_elf.h |  7 +++----
 linux-user/loongarch64/elfload.c    | 14 ++++----------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 90bca4499d..1f40419af2 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -6,16 +6,15 @@
 #ifndef LOONGARCH_TARGET_ELF_H
 #define LOONGARCH_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
-#define ELF_NREG                45
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 832890de10..ce3bd0c607 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -65,20 +65,14 @@ const char *get_elf_platform(CPUState *cs)
 
 #define tswapreg(ptr)   tswapal(ptr)
 
-enum {
-    TARGET_EF_R0 = 0,
-    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
-    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
-};
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
 {
-    r->regs[TARGET_EF_R0] = 0;
+    r->pt.regs[0] = 0;
 
     for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+        r->pt.regs[i] = tswapreg(env->gpr[i]);
     }
 
-    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+    r->pt.csr_era = tswapreg(env->pc);
+    r->pt.csr_badv = tswapreg(env->CSR_BADV);
 }
-- 
2.43.0


