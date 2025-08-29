Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A46FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk4-00004y-Ta; Sat, 30 Aug 2025 11:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wy-0002zr-Jk
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wv-0002tX-T5
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2754683b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506308; x=1757111108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBOCs0u9eTFzPs1BXssx7t+lpyppND+lsDMhtkq3G70=;
 b=PsO3AHsyezcOKn+pZw2TXqCB2Wmrr5x1BNqFsBLb1nad4zB9nPnbZRefBmQ/olxcS+
 JAeoFTrnRiwQVMwAKdSPfROhRLidVg9/QhdNg1D2H1k34G/W8+DBcYTXpRDBg5Hum3TS
 VvjUWyzIv6SuVYbv//58+e49n8ZbIqPYox4gbBZ5q3Doko3Ybsvd4ZfQWxMVv+CD3fAk
 /GZEGAgP2h1w9jIpv9IKhxugAY+9baUxkga1LNza18wVPrimRSCxMfq2pvG0bc0GAuEN
 CxdSvsc51qwi+sGL4ajfCoSviiNdzvgDMRv0/uNmzIFBQ5iuXRuhWlAbWZ7l0LZpwaio
 UuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506308; x=1757111108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBOCs0u9eTFzPs1BXssx7t+lpyppND+lsDMhtkq3G70=;
 b=pIENnOCb8ov1bxtwTsk0xiJuTwSr3q++NV6hW96fItV6Is7s5KQgBFApl+3+MHFBKx
 Le9C3QJ4NVNVBPM1/+E/DZ3CFpJrtq78oeVVRK7SaTa37EHx3Ong1wNWP16a9cvJ7EPY
 L+HgR2arg7oM3FqBW86+CMCGxyguuirsJTk9Q/COCzEX0c2CLkRLEHTD20mGj+fcpyG/
 FGs54OaxeMEI+b5Ta8FgXwnNeVhcj7G52aUM0XBkED0BkaErn+h1D01N0NqDmAc+3j30
 LIgPpBFyYC8vm/B4hoENh2pwew9q5x1M1G/w4a1dkKpmS0BktiDIfuAvHni/6Hf8hJe0
 P04Q==
X-Gm-Message-State: AOJu0YyBGQ+X+jk9E0kURJM5l49JiZ6gaA5lZfCAzXxJ8JyXGv81NuDD
 QXggjykf29dDaWlRMrJ7YDrF0YCmL/Ez83gf1+w/e/qsWhOuF55uTsa9uXRDS6sdqM2DU1Rkjoy
 w7I7CAtY=
X-Gm-Gg: ASbGncsYQkIS4Rl+96O3ucFBojKhErcx+7YdhXp8wENr2OwRAaKuKntQ9dU6f9Cn7bC
 o6KxyDeG7Et7PBEyBVuQh7k2j9jiV4pvekmqPb71zly0sHYpdJIfdvLNm3Y+1833m8Wam1fiE30
 gaYdrNcAu8zlEEzMHGWL3FB74UM+MNZlDL51oFOW/GmvKIf9cx6dZsB81529LpU9HA9PPOoIMqh
 s61K5erX+AAXtP30JoVRkNNl/1KsbG1KIwK5CQb6N0YLPH6rtIXWwxPydTA1Z8FHdX8ecMhk936
 w3PwqteMYIGRqIXzEAcGEna8d3/BcbUJ5LIJgvkwBmjpsNXi9M0Yv4Oz2LaFygR66W7kbEewPvy
 cfaw16ZdM6K5DUPlRdFbPMDdyoMPRDpcEFl3trNTjjnxM32zTKI1H5JspK2hk
X-Google-Smtp-Source: AGHT+IGC/WQdATEhJ+is6Kaz7Qx3IvOwAs100mcyBwfsLRMDKU732nRYksWhjaG9AZX+f2yRrVXtfQ==
X-Received: by 2002:a05:6a00:1495:b0:771:ebf1:5e45 with SMTP id
 d2e1a72fcca58-7723e393f29mr288794b3a.22.1756506307614; 
 Fri, 29 Aug 2025 15:25:07 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/91] linux-user/sh4: Convert target_elf_gregset_t to a struct
Date: Sat, 30 Aug 2025 08:23:10 +1000
Message-ID: <20250829222427.289668-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index da034e5a76..cc9140bf32 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -678,7 +678,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r,
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /* See linux kernel: arch/sh/include/asm/ptrace.h.  */
 enum {
@@ -691,22 +693,19 @@ enum {
     TARGET_REG_SYSCALL = 22
 };
 
-static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
-                                      const CPUSH4State *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 {
-    int i;
-
-    for (i = 0; i < 16; i++) {
-        (*regs)[i] = tswapreg(env->gregs[i]);
+    for (int i = 0; i < 16; i++) {
+        r->regs[i] = tswapreg(env->gregs[i]);
     }
 
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PR] = tswapreg(env->pr);
-    (*regs)[TARGET_REG_SR] = tswapreg(env->sr);
-    (*regs)[TARGET_REG_GBR] = tswapreg(env->gbr);
-    (*regs)[TARGET_REG_MACH] = tswapreg(env->mach);
-    (*regs)[TARGET_REG_MACL] = tswapreg(env->macl);
-    (*regs)[TARGET_REG_SYSCALL] = 0; /* FIXME */
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
+    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
+    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
+    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
+    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
+    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


