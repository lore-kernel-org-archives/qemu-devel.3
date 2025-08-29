Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E32FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiE-0002rM-Ka; Sat, 30 Aug 2025 11:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wr-0002lR-Jy
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wp-0002h3-Gp
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1100039b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506301; x=1757111101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mjdr1DYVtpql3ViukljsVmvlw0wae7rs6+tm74FMG8=;
 b=ZGh7qOrWH/cQu0ml0tgop50vEffCGXJMiHVDk0EkEfbYFHbxfMcnuwr8CN1Yun6XZf
 fKkXTsJEiMox5sgjt2N/SYdMtdrvr+W6k6nckgbhqC9dQvgaKYyaWsk0et27ljpZ7tzc
 kJXdr3t+95c9coHsa/g/yO3p/aL8fmAGs9NXwJ7nZ1qHvLt4LVfHinAv6G+MICYK749x
 Tf/0aBpKEUVXELmSD3UQo8SXIBRsmNf5iDdXc9N5FYqpQ3yFSsAhbHJBVzEcdehqlnPC
 ApAC85LRgvcPnjzF/+10fir1iMQas6yCNrYwc2I6rEDtebBrpsqIOnYOxGdSOPPql3+b
 4fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506301; x=1757111101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Mjdr1DYVtpql3ViukljsVmvlw0wae7rs6+tm74FMG8=;
 b=J0DMPcD7t3Knbv1FUoearDFsz9sX1J8MvQLSNtzOTpqtBN+VUujqxnqZERBs2tVkUh
 svdv1uExCMtrBPxmbv9Ob/qnU5+eP/OQy/y94nH7QVI63nCA6GVHH/j0svpKeEGZ/1Xm
 ZA9yOwXYPi/xl+FKktuZ1IeoFya9knCeRJDBSMB2o8e+kU+WIwoS2xvB5o97mbA2EjmO
 dXFfnLbYFy8FqfyggRFwD2SLyJ5grk9BDAnjPy7V6g6C6v4w0vZB+xKvBkK+yiDSl6sq
 6KZP9tqYwgbHzchsxnbmrWMlN7HAFVoTga2WHOkTF3umfm/T0NtVYMGdcwsaU0cOZkCf
 5Fgg==
X-Gm-Message-State: AOJu0YzmRK56WkwJQizBbtxzvmOXxJlpy/viXANxebnhpDjHFCuNpV5V
 cxKQew6hFzAz7uDJoChqJUjhf+N+ja6VwaAuZmV7HUmTJ8pq3K9kC7zfhFuWE0KKsl9rgREiW74
 6UbIUwFE=
X-Gm-Gg: ASbGncsmgXKNBj8pSiwRoOu93s2et/Tubwv+cm8wPad5vuLiJ7LDaGZJYe1KtSbOQ1C
 TvFWJqZFWnlFQ5BtbmnJp/tTjkID7foOkMEnSqoPoQSw/FZMx8U3h/MUBksd4aHfEr9GXPvKplV
 DCRG8B4KK2qHO1RmgQBVE1Mi/7d8splj9GKNR6wuGVxzkPz/7R/K1nHhM+Ir5Xs8r7Pe+9E0Tii
 3c9PqadGP6IgaV5J0FMpgF2Eu8b0mA+XWiinfUYHTjllzWHEAoJlXiudj1O+wPsyZqRznN18Xt9
 UHVdBW+C1AQIM9j1Fmz0Mj3851MyqzJBVYK7BpuDzV3xrjsJG4btThGGBwHXDPloI1vtDEU11YQ
 7+Z5s0nwwwqa4QBkp059rWDM7pPheSYmhOFKTjXSaKOPl66fAy+bFEpeFpSA8N/1AndsiNk0=
X-Google-Smtp-Source: AGHT+IH+vArUnW80SYwaGEYA2tqUFP11IfhOsEB4n44E5qBUDbKzGgD9ItMTbyaDV/cfjpBTW1HOsQ==
X-Received: by 2002:a05:6a00:1495:b0:771:f071:28fd with SMTP id
 d2e1a72fcca58-7723e3880bfmr264061b3a.14.1756506300699; 
 Fri, 29 Aug 2025 15:25:00 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/91] linux-user/mips: Convert target_elf_gregset_t to a struct
Date: Sat, 30 Aug 2025 08:23:07 +1000
Message-ID: <20250829222427.289668-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

While we're at it, merge the store of TARGET_EF_R0 into the
loop over all R0 registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1e59399afa..8fcdb0569b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -564,7 +564,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r,
 
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /* See linux kernel: arch/mips/include/asm/reg.h.  */
 enum {
@@ -584,27 +586,25 @@ enum {
 };
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
     int i;
 
-    for (i = 0; i < TARGET_EF_R0; i++) {
-        (*regs)[i] = 0;
+    for (i = 0; i <= TARGET_EF_R0; i++) {
+        r->regs[i] = 0;
     }
-    (*regs)[TARGET_EF_R0] = 0;
-
     for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
+        r->regs[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
     }
 
-    (*regs)[TARGET_EF_R26] = 0;
-    (*regs)[TARGET_EF_R27] = 0;
-    (*regs)[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
-    (*regs)[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
-    (*regs)[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
-    (*regs)[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
-    (*regs)[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
-    (*regs)[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
+    r->regs[TARGET_EF_R26] = 0;
+    r->regs[TARGET_EF_R27] = 0;
+    r->regs[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
+    r->regs[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
+    r->regs[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
+    r->regs[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
+    r->regs[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
+    r->regs[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


