Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7423C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kw6-0003GL-Qh; Wed, 23 Apr 2025 20:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktk-00067L-44
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktf-00058x-CR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2295d78b45cso6762885ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456217; x=1746061017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLKTjM2ffAVeFrE6Gc5tW8Q4Xi7NyJ25WnTbWz90B6E=;
 b=uxb7xpwtsktl82kGM7qy65HoEudoBkV6dfbxwXeg5nWVQKn3DY3zDBi3I30W+RZxD0
 RvdIHPFOLCmgyFWPjG51jR9CIBUw4gKUKpPnmqFlOf0ykgh3JzexWtfpHdgrUVDLv+Bq
 OEHyxKx2R7lRYGoEULi8QbS5l0fgxmYNtv/JV422gmxLe4xeRDpASiUs5vuqjUV5cyb5
 UqPeV2KT/YP7Ex/MLxRwGSkmopDtk/No/SooY2B4TmGG1MD6F27p64vRqiBR7tJyrZVV
 LRPCD0ArQuFbQ4cl3HwwaUX/xK2uPKPDN7RMwGa+WucFyb/CWZEC3ADnQASLNgF/CgUw
 VI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456217; x=1746061017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLKTjM2ffAVeFrE6Gc5tW8Q4Xi7NyJ25WnTbWz90B6E=;
 b=UnzhPmwL/R/ARoEMOCcebieRgQhRU2HSZjXN+cQvvur9Rt941u8z8m9MOK+tf2OITB
 KPq6JZbcrWQ+nAcqcE+rfsUykVYBz28DwP7iXKSGNqZzJZbApSts5I5SqdAfPqkoawvA
 Ud2KRYk7SvWyYIvCzaNuBJtw4KuuYVWDKVmRzADW35q50RrCjrbelUE2Qy4YBWj0p1hz
 S/f3STgZwU2Y0d8FEttqi6hzdA7ez3rwh6KLVnDpOaeHCdSO4u+V2+ukPcdNPl6l92jg
 3y0wJzckat8bbqTCZGS0yCv+I5uGg2IDPpNTUWvQJGOqtm7Bbc1LN5AKXt/eMUBs7xvL
 8qig==
X-Gm-Message-State: AOJu0YxZ1p7suOPlyQpvqnddD6fKAHLt2j0F7H8NdTVbDdE2hP7MF4cY
 GZRJJzEd321SZ/Qao0DShAGGSUFoRohHXJOp/yteGN6kIjwy1NfbEyjC1aKInzpxFJmOD8Kx0Du
 /
X-Gm-Gg: ASbGncu0uZgbI0pb/6Z1458m64uYqKIkj/cmarvQSVHMmXBe4o5A7PAvHP3/YGgWwn0
 aLvZGo+CzZyCp/RsKyRyyOLIMwNJPTtdEfxrzmDVgik6e9otLAoxSCQZ+2UL+AkKqQgKKBBtcnH
 JxhLDvpYmdkEKRs33m2Rkc7ysjz+ynI+dapC2qmlElqT8MjxBcpiwBKhOz6qE+ysckL7SKtZ62C
 /RLQuoXRPH7WQrAqwSQ6e3whJSnoWZQjinwws9dkIxknqdpTxZUNLeoEuh+PAvIybPig2ysWDpT
 YohA51EzlHT5P0ps0x3qNLNKr+OZGNEQt8tFpQmwBt6fH8mKUz4qY74YbCnPlcJ1hPGmCx2R7D4
 =
X-Google-Smtp-Source: AGHT+IFM79kmeviTPwe3AZ02yyJ7HaSwzsgjTHvLMkLRuZveUj4b1Pe5VeS98m+vjosBE0PD6L/MgA==
X-Received: by 2002:a17:903:190d:b0:223:37ec:63d5 with SMTP id
 d9443c01a7336-22db3c0d32fmr9575935ad.28.1745456216895; 
 Wed, 23 Apr 2025 17:56:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 113/148] accel/kvm: move KVM_HAVE_MCE_INJECTION define to
 kvm-all.c
Date: Wed, 23 Apr 2025 17:48:58 -0700
Message-ID: <20250424004934.598783-114-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This define is used only in accel/kvm/kvm-all.c, so we push directly the
definition there. Add more visibility to kvm_arch_on_sigbus_vcpu() to
allow removing this define from any header.

The architectures defining KVM_HAVE_MCE_INJECTION are i386, x86_64 and
aarch64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-18-pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 2 --
 target/arm/cpu.h     | 4 ----
 target/i386/cpu.h    | 2 --
 accel/kvm/kvm-all.c  | 5 +++++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 21da3b8b05..18811cad6f 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -390,9 +390,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef KVM_HAVE_MCE_INJECTION
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
-#endif
 
 void kvm_arch_init_irq_routing(KVMState *s);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ea9956395c..a8a1a8faf6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -33,10 +33,6 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 
-#ifdef TARGET_AARCH64
-#define KVM_HAVE_MCE_INJECTION 1
-#endif
-
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bd63036334..17ad0b644b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -35,8 +35,6 @@
 
 #define XEN_NR_VIRQS 24
 
-#define KVM_HAVE_MCE_INJECTION 1
-
 /* support for self modifying code even if the modified instruction is
    close to the modifying instruction */
 #define TARGET_HAS_PRECISE_SMC
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a30b19f455..cba9c78d2f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -57,6 +57,11 @@
 #include <sys/eventfd.h>
 #endif
 
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+# define KVM_HAVE_MCE_INJECTION 1
+#endif
+
+
 /* KVM uses PAGE_SIZE in its definition of KVM_COALESCED_MMIO_MAX. We
  * need to use the real host PAGE_SIZE, as that's what KVM will use.
  */
-- 
2.43.0


