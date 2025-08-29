Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6828FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNl3-0003zQ-Gm; Sat, 30 Aug 2025 11:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7ay-0004HU-N6
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7aw-0003Xz-Lw
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1240832b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506557; x=1757111357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AP3J9qKby1OMNQJiAFiOcVBRXyp/SS6GtQpkHS/dPHw=;
 b=idEMasJF1UxIZoUo5ZMfNFn2ts05OLUqT+u1sFdssQJPFLrOErWKDPf6Cbft/TNHuV
 qtegpkGlq9a8i2tMADsXERsm6JceMaIo5o8A4AKz1oIfJLSaubxsaNy3EXPorCnpvN11
 F/9q005U+Yy62EpAeDBXk3cS1pl5VlVKhgh1gkjYoeOYsCiXSAolqnF2BhmLGvZMBpnt
 YC5599NxKnZSpuVfu/JfaHWKX5SyCX54B1id/pW4bXbqYe2Fona5AGPpB5gdGnzVRU/R
 EAdaq5SHV7WV5ItJazY7NjBn4aIu5cQ+eTSL3pKNmTqjW7+9vswjItUYz3XHbbbioihw
 nyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506557; x=1757111357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AP3J9qKby1OMNQJiAFiOcVBRXyp/SS6GtQpkHS/dPHw=;
 b=BnUKFUJEHOkJt6Ma0GGq2m55RbJh5eVWwOOQDPJUdOdEK3B17Ftp7wsNF+UWs8z/ry
 sHANd+uTq0sDYRe0u++oStQGIzfRbynZTqxh/djJBs9TmeqYKHoxEW2RXaZPyDJqKQgj
 uQbDMYNKkQbdVcvJ/CIqHYMBzVCbVLAEdNg8+jPQ7MUDM6B5wGmPfxBWrpwAXNBlfxwz
 pVFltlOgC9XDI5Z/tuhH55ZwErOj8WblheVKnJEGDp4ByktXsxxpkRvefiqNt1Iu0Ga4
 UejaTnjsJFHfDNdXYOdxPO+ntHtq64GRL3lnT5T7veYIj9NtJalvD/ioICp0J0DI4DkU
 UUnQ==
X-Gm-Message-State: AOJu0Yw0vBsOOcYWgE5zL3N0BZJBc1D8I0ZylAd/Um4YLRRuyA4+gT5F
 OM2umj87YZecFhwbf17ROkNQnm6WgSrqpIQrSsjpZ2KO7Xt4h01JSSOqcF+XtNKhwVtyZFfPuvp
 D+bdNUSY=
X-Gm-Gg: ASbGncsS7NxpyLPTeCOVmIVlqn5gPvtw1ETeEzzizBDMED+1zEOOJOddWEc1PoWMq+q
 N/EgJinbsgLGUoC3abqibP7aTSI0gcJC+CjX7YvpQIOJwrf0pufrdtda+XkrEhXF6nIwK5YvPf1
 62PJeLgYBuzHrSIL0DcQQeFjAhkPnoA2IDR+EiKJ0DlRFjDk397ukjwPU2iQ5OesCMHQYCzhsq5
 z5Gtxo8bczWXf1LdWg3ZGO+CvGpVEpkxK8YVKxFhkK2YHyuOQnokJtMM5hnj6kvTv5vc5cGNc9R
 AE1AaXVK9eMHIcq85QppKnu7fYDtoFCBQasU3pDQHit/d1HEg8U7VpRYE5Q8Vuij1/uHPwQUxdo
 wspoVuDRMPmgbgUvPmYbS2kEUwPqT5QfaAfCeziw1FK/qb4AK7QKjoKa2+AYXNTCN9YVpqOqhEg
 ==
X-Google-Smtp-Source: AGHT+IEa6eetv8ynUcsmbNH8zrqpnfWr8q0f7fSa1pkpk2Z3R0PRtnHqZyrSq22QUPAcuoXympBM9A==
X-Received: by 2002:a05:6a00:4fcd:b0:76b:f0ac:e7b2 with SMTP id
 d2e1a72fcca58-7723e276f61mr292009b3a.13.1756506557215; 
 Fri, 29 Aug 2025 15:29:17 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 42/91] linux-user/arm: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:38 +1000
Message-ID: <20250829222427.289668-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h | 11 +++++++----
 linux-user/arm/elfload.c    |  8 +++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 94db3738e8..fa8f8af2f3 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -8,16 +8,19 @@
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-#define ELF_NREG                18
+/*
+ * See linux kernel: arch/arm/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct pt_regs via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 47fe16a1a6..f811c2f07a 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -201,13 +201,11 @@ const char *get_elf_platform(CPUState *cs)
 #undef END
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
     for (int i = 0; i < 16; ++i) {
-        r->regs[i] = tswapreg(env->regs[i]);
+        r->pt.regs[i] = tswapal(env->regs[i]);
     }
-    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
+    r->pt.cpsr = tswapal(cpsr_read((CPUARMState *)env));
+    r->pt.orig_r0 = tswapal(env->regs[0]); /* FIXME */
 }
-- 
2.43.0


