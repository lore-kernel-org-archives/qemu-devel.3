Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNks-0003Fu-E7; Sat, 30 Aug 2025 11:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xt-0003MX-Ob
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xq-00035O-W5
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso2332811b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506362; x=1757111162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONuJMYbWeJBxnsdiR21d/u0rs2Fxlc0F9a0zKzHjW5k=;
 b=X2ODpboL5v4WbWHjjpxuM0WWXVz7ffqEuRyaKA3TomFqUgmSHLTeE51SonN39QfFZ8
 TvJp/i4uqxxKB0vVgJS5plAT2Js4GbC0umM5y2yg0Nrp1iivwXfatBshKYIRedI0koC9
 5wPIq0diH8VTcGwxyNjCeqMO95nUNthdewojtwVPM2Ath5sM1yVbw5CGKqMgH/viuN5h
 JXUcHPiiO09Q8zJJERTFo8DzoLHZpPT1RccUOlzg2oycHas1otT+5uw+jUDYPKjoJvC4
 ZdjeRZIuPdD5iPKEbeiv0iV57Fob0EyWpEtR6ffUk62YjQeUBjZcJjHanqUra6p4LcI9
 U8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506362; x=1757111162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONuJMYbWeJBxnsdiR21d/u0rs2Fxlc0F9a0zKzHjW5k=;
 b=H3cKwhOcP879BkYItBnuBxiDMMgHil0cbCSna0wxOce3Q+6Wc7vRIBXciFAxMYiY68
 I70+/AkQrxSyQ5oUdT15pMexUqsafd8zGrSlaVEgdmir4qi2wocNvojYqxX8aMeq5kIg
 /rpV5Mh1BruOn3NDDedySdGYY9Q5U5hD0hbWUrvhEWgkuYu/J/2+JNFK27N18ml50URH
 fOXWYDH6L4hdjY8x4Z6ejYkHWMTzCOTEqoA7h1nbP70db36pEpnFfVo3/zk1DNcN9XlQ
 1+OvklEN/TiRq+KNtIM54u8wEYt5p//dALHRF+ZUDB8vFiyRN9pZh0MUYidTW9XioYO5
 rDsw==
X-Gm-Message-State: AOJu0Yw26Aga27w7bjzTnw57efPYaj2KrRl/7b7kDJWNIgHkSvuZ8SqZ
 uYng/qp0vZNM7sP9z7PrUUyWM7lcpGBLVg+3rPu/w6r2z3h557KqUQio9jnoK1rLIb1Le835KzO
 B63Trszo=
X-Gm-Gg: ASbGncsioTEznlfSDlkxXYGnkmQSalCUU3bMW8M6C2zuqwdOl61bzPbPeHLqG4ajpNE
 vt/OLeqASKxhKQu1pmnnZQOVHc60heaYsZwJhjuI0MyMdkFho9qoeo4bvtaL36yB3aYsa1sqJA0
 kkHRQm4Fru/uz4clg9DWZkxcwCtPJu06v+j9Lo1bBL6/WznmNjfzDeYyATlOmvjdLG6dkvkj/8s
 e7xLX70HKTS1vFlSvwbH1ikc3/dozmxRzrhKn7HarJzsZDIgidooyILKR1lzN6KNFavt1fr0BJ0
 ZHsIxfEMoIsFtH33R79/WqHYDTx2IK9EyZF98YsTT3peeXA8Lci72VfiAJEIRomF6AdlReU84Wh
 qDbih57zCy6TS1a2KcaMMefbiwg1/72wmg2epsPLW5KFlA3m/dpeQdiMBq6O1QrKnJZt/WX0=
X-Google-Smtp-Source: AGHT+IFXmQDhPk38WNvt28oOKknLPkRYuZ1s5ejkcls1p9jH4PbcFE4Lqg3NtL/tULsl1G7vf2CiJg==
X-Received: by 2002:a05:6a00:3e18:b0:76b:cf2b:18bf with SMTP id
 d2e1a72fcca58-7723e21eccfmr288527b3a.2.1756506362092; 
 Fri, 29 Aug 2025 15:26:02 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:26:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 37/91] linux-user/x86_64: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:33 +1000
Message-ID: <20250829222427.289668-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The comment re ELF_NREG is incorrect or out-of-date.
Make use of the fact that target_elf_gregset_t is a
proper structure by using target_user_regs_struct.

Drop target_elf_greg_t and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/x86_64/target_elf.h | 14 +++------
 linux-user/x86_64/elfload.c    | 56 ++++++++++++++++------------------
 2 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 74a77d94cd..32a9eec431 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -8,22 +8,18 @@
 #ifndef X86_64_TARGET_ELF_H
 #define X86_64_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
- * Note that ELF_NREG should be 29 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
+ * See linux kernel: arch/x86/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_regs_struct via sizeof.
  */
-#define ELF_NREG                27
-
-typedef abi_ulong target_elf_greg_t;
-
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_regs_struct pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 76cf5c1509..18d632ec34 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -21,35 +21,33 @@ const char *get_elf_platform(CPUState *cs)
     return "x86_64";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
-    r->regs[0] = tswapreg(env->regs[15]);
-    r->regs[1] = tswapreg(env->regs[14]);
-    r->regs[2] = tswapreg(env->regs[13]);
-    r->regs[3] = tswapreg(env->regs[12]);
-    r->regs[4] = tswapreg(env->regs[R_EBP]);
-    r->regs[5] = tswapreg(env->regs[R_EBX]);
-    r->regs[6] = tswapreg(env->regs[11]);
-    r->regs[7] = tswapreg(env->regs[10]);
-    r->regs[8] = tswapreg(env->regs[9]);
-    r->regs[9] = tswapreg(env->regs[8]);
-    r->regs[10] = tswapreg(env->regs[R_EAX]);
-    r->regs[11] = tswapreg(env->regs[R_ECX]);
-    r->regs[12] = tswapreg(env->regs[R_EDX]);
-    r->regs[13] = tswapreg(env->regs[R_ESI]);
-    r->regs[14] = tswapreg(env->regs[R_EDI]);
-    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    r->regs[16] = tswapreg(env->eip);
-    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    r->regs[18] = tswapreg(env->eflags);
-    r->regs[19] = tswapreg(env->regs[R_ESP]);
-    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
-    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->pt.r15 = tswapal(env->regs[15]);
+    r->pt.r14 = tswapal(env->regs[14]);
+    r->pt.r13 = tswapal(env->regs[13]);
+    r->pt.r12 = tswapal(env->regs[12]);
+    r->pt.bp = tswapal(env->regs[R_EBP]);
+    r->pt.bx = tswapal(env->regs[R_EBX]);
+    r->pt.r11 = tswapal(env->regs[11]);
+    r->pt.r10 = tswapal(env->regs[10]);
+    r->pt.r9 = tswapal(env->regs[9]);
+    r->pt.r8 = tswapal(env->regs[8]);
+    r->pt.ax = tswapal(env->regs[R_EAX]);
+    r->pt.cx = tswapal(env->regs[R_ECX]);
+    r->pt.dx = tswapal(env->regs[R_EDX]);
+    r->pt.si = tswapal(env->regs[R_ESI]);
+    r->pt.di = tswapal(env->regs[R_EDI]);
+    r->pt.orig_ax = tswapal(get_task_state(env_cpu_const(env))->orig_ax);
+    r->pt.ip = tswapal(env->eip);
+    r->pt.cs = tswapal(env->segs[R_CS].selector & 0xffff);
+    r->pt.flags = tswapal(env->eflags);
+    r->pt.sp = tswapal(env->regs[R_ESP]);
+    r->pt.ss = tswapal(env->segs[R_SS].selector & 0xffff);
+    r->pt.fs_base = tswapal(env->segs[R_FS].selector & 0xffff);
+    r->pt.gs_base = tswapal(env->segs[R_GS].selector & 0xffff);
+    r->pt.ds = tswapal(env->segs[R_DS].selector & 0xffff);
+    r->pt.es = tswapal(env->segs[R_ES].selector & 0xffff);
+    r->pt.fs = tswapal(env->segs[R_FS].selector & 0xffff);
+    r->pt.gs = tswapal(env->segs[R_GS].selector & 0xffff);
 }
-- 
2.43.0


