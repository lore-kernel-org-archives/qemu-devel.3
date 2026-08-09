Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53429C5AD56
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wssQI-0000PG-4g; Sat, 08 Aug 2026 21:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQG-0000Mv-LZ
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQE-0002Ng-Ux
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso1035003a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786239233; x=1786844033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GU/L2JcroJNHA+KY28DNLnCmO+j8k/C0lmalv2aUq0M=;
 b=DT2l6yERyOrTZ/+fGv+Iy2ylNBIMJaSNtK0ssXIxGQnog2i5klal0JClkItTj5XNz/
 SMYr3ZNIwaIyBauOJ+9bCgbKxOW4aP84lCcCCcngo62r9/JpmqV6LQmKkeXU/sokI6JL
 NB1Amt7/mQhfHWcRw8pm1HEk5twftWy+FX3NjgpY3xRxuH542BHBzVCzflqki6J96KWE
 Cu8X9Z8/5urZOJy4HGGozKPZ733s/NXQdp0Ik1V3R1Ngv+28r3Z4aYYiuJbYwNn3f4TC
 qjO/sAWyyn/Oi6FNTE55/F6eHHa8IZZMpssUvy0LTorJCOkEvYshEYwshDhASnxMvIIa
 bUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786239233; x=1786844033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GU/L2JcroJNHA+KY28DNLnCmO+j8k/C0lmalv2aUq0M=;
 b=plu8q21k3l5hqioTExIcC3llCmezm0Zfx+JhUptfmfoxxEEw7At/GHvZf1nWWLYG6v
 nGnk/Q4ZwiXZCDnmO7KtY41oTrApzI9SAVtdX0kQCsKouw43FK2YNcChN1MTLA0/WLPq
 2bA10LkfDrkeKbD+P75rRrt5zjYow5xnNDKzWVHYfac5PqC8/Mz8Wan0W1v9zXxkY3n/
 7gakIS/Ld1JD4FDJJzNuHGW2V8YD5Zyx1peqkPv34MnP9OTQ/Jt7TYbuvCx8b+vdczwp
 GbSu6T78XfqgU0KQq5VHFf2f88eDTYs7sIY+upv0Rryw0D/wX5jw65uZLUR9hXfQQbm6
 3Zhg==
X-Gm-Message-State: AOJu0Yy9Hh6kKuisHOL1CixHTKRvMlhk/+QxQZWsqqNt8NWGgn66rjO3
 CUqXwRy0oJnBfBN0jYeAt9lWpoRpwfv4zybJgd8pXpOIWZLZHDHpOdDmm2Ls5yXnUZqHeYmi5s6
 +RSnb
X-Gm-Gg: AR+sD13CWujZkA7fTRpFdvRE+WLy8PR/JfP7Jus4MESHheYZAT2A5SayLt07yyZVMdr
 il9duLc3MNVBDuED6Isn8F9G0pGvP5FGhPoDoTOIdpS/ldHCLdwLqk9P//afKtDaVDXHu7Z/7wH
 a9o6+YT2ffSEVcj7Pk/WDYCsyRxKXbvJhCPPpcY1oeDen/oj2DVt7UzvjMtGDfrh4kkjqEORCRK
 krLY5IhS9X41V26JCVx1ZOV6BYpXwzPlntxKYAkqSV1Nn5hW5rOaoInBKblengLUuvRFip1bm7H
 PLSvw/ItZeqCIGv4vPHEMgETHygmlgTNhraIlXOdRZJj9XV/4vMR7+wtILL9P3XG1q7lyYHnBrB
 wFfmzKYGlsOC0S6RimFLSyavicB2Sgn9qy4SWhMOT9FfG4Yw4y4eCGawPPhlxGUxUne1IseJLJs
 Svc8g6Zwbfy/U3yhud6Own8ZEcwI6fLrayc/gFMbiK5Md03oqhfTGrfB9REh9TlyGlSCleg7Axn
 1M2cV00bMnQh7hPZHih
X-Received: by 2002:a17:90b:3b45:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-392621444f0mr13898722a91.15.1786239233399; 
 Sat, 08 Aug 2026 18:33:53 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm10067927a91.6.2026.08.08.18.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:33:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 7/9] target/s390x: Update capstone disassembly to v6
Date: Sat,  8 Aug 2026 18:33:41 -0700
Message-ID: <20260809013343.664966-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809013343.664966-1-richard.henderson@linaro.org>
References: <20260809013343.664966-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In particular, this enables many more vector insns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 11 +++++++++--
 disas/capstone.c         |  2 +-
 target/s390x/cpu.c       |  4 +++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index a922f7627f..87f8f6181f 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -4,7 +4,6 @@
 #ifdef CONFIG_CAPSTONE
 
 #define CAPSTONE_AARCH64_COMPAT_HEADER
-#define CAPSTONE_SYSTEMZ_COMPAT_HEADER
 #include <capstone.h>
 
 #else
@@ -19,7 +18,6 @@
 #define CS_ARCH_X86     -1
 #define CS_ARCH_PPC     -1
 #define CS_ARCH_SPARC   -1
-#define CS_ARCH_SYSZ    -1
 
 #define CS_MODE_LITTLE_ENDIAN    0
 #define CS_MODE_BIG_ENDIAN       0
@@ -84,6 +82,15 @@
 #define CS_MODE_SH4A             0
 #endif
 
+#if CS_API_MAJOR == 0
+#define CS_ARCH_SYSTEMZ         -1
+#elif CS_API_MAJOR < 6
+#define CS_ARCH_SYSTEMZ          CS_ARCH_SYSZ
+#endif
+#if CS_API_MAJOR < 6
+#define CS_MODE_SYSTEMZ_ARCH14   0
+#endif
+
 #if CS_API_MAJOR < 5
 #define CS_ARCH_TRICORE         -1
 #define CS_MODE_TRICORE_110      0
diff --git a/disas/capstone.c b/disas/capstone.c
index 78062339d0..a5bd91890b 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -95,7 +95,7 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
                   (uintptr_t)&cap_skipdata_riscv);
         break;
 
-    case CS_ARCH_SYSZ:
+    case CS_ARCH_SYSTEMZ:
         cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
                   (uintptr_t)&cap_skipdata_s390x);
         break;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c074e12ba2..e81cf16ac3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -225,10 +225,12 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
 static void s390_cpu_disas_set_info(const CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
-    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_arch = CS_ARCH_SYSTEMZ;
     info->endian = BFD_ENDIAN_BIG;
     info->cap_insn_unit = 2;
     info->cap_insn_split = 6;
+    /* Disassemble everything, even if the cpu would trap on the insn. */
+    info->cap_mode = CS_MODE_SYSTEMZ_ARCH14;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.43.0


