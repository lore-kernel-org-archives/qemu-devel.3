Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD5CCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiQ-0003xP-Tl; Sat, 30 Aug 2025 11:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X4-00033i-R8
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X2-0002vj-EW
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7722c88fc5fso1114396b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506315; x=1757111115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vntlxf7RKCOfwSDGO8mO6KzabCP78W1rl91PrXQ2mIc=;
 b=p300bDnoql9VzgbCvBsf38moIiul0id4ixc98sYl4Vs/RfEd1uwXj3jXtUEzInuSPx
 ay3e+iMlFUtsqQtJJqWyr+BUeDpi4/6uW39znARmSps1gPkJnwG9srH3qYwOxKe8ef3A
 tz/HalTRvQrDSMyepH81IJvLTrqMbYbHbEqG6JqKppTFcANhGaSJYeyyq/lYD+fm2HPT
 BIjKNx/aUZcK87SETsX2lA9ecFdey3ghKXXKus/r39i2NkcG2lC510HmfHeAdnzEftYA
 tld3BC04Ji4+9IBOghJO6oOvic8cv2tq5CAh5i6LI/KrANqwPLz+rXcQkKLD/BqGOG5H
 Fdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506315; x=1757111115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vntlxf7RKCOfwSDGO8mO6KzabCP78W1rl91PrXQ2mIc=;
 b=SdZVaWpVviGZ5jIIFBILP0mMW7DzhgcKBUy/kaKYVze9CJivz0bzuF8BD+TnRv9GI4
 ShWFZjtIsMP08FP9PRdJrbiTjeOgEbyipSNMViZTuFEJfdvZLkyrFQegxCRYfYyiT/jL
 7BCFrH4dq4ZieOaUOPbgmDjxVcjYTlbMiGvtT7PpoBcpxzUdcL3kGSciT2mJPMFZtodh
 PDQ7u/vwXMIlgq2PJ+KwszAM/6QTss4Bg70Atnq5m2NxGsJ0Nf1NqSbmjluCgzCr4Tfm
 wg92gSfeaTjaFGnJ/IMO5zi40bFeDAzMc64rfkoMJzdIYmU7SjXv6B1KixmIjGmyd+Dz
 eYgA==
X-Gm-Message-State: AOJu0YyX17F0N/m4VCfz1WbPF2xT2pFzAxPTpssTTM4qs1nnRTjz0jt4
 isDTCW5Qm2bS5amfhL3vyVrqo36AwNTRrAbTvmxiZYwHhQ3N06ZlzQSr3zKRoQZHWnBgNm54rE9
 Fq4UPVYs=
X-Gm-Gg: ASbGncsQfT4MROQEPh5R1aoSGVW0XJdIixXU+aQTpSIQzFGrtoQ3roxyOb6ceHvTy5g
 2lhOjDUpkVgJ3i+/xADZPRGqo2XNUSnBLj6pwIrbPfbdoCMaAC5yeqHJkp7UJFsvx0qzT6g8fFI
 fRDPAjYtTLd5A2AP4NVLwOYm2H0EAwA2dQo1h1sZ6xD56PNypZBkSzQQIMQ5dtv5RG4b5VH14se
 rRm5XVr7FZ5UOoK5xizmpDfRAFtX9219E4M9ILKPh213EN1nbOoQueq4traKR1z2cbgYLjREszc
 3GMmABjTzWk1+oyNbbiUU7z4/ZOsJ2GoOJfQWGA15sfdSCWZ+Gw3BxPWvprkNuDWjPl5jJ4wZ0E
 rCVSLII3yFke2/gxa0X1wj6COLQiWTGvVMcNYPbqM7IgEn9vUwNXqHA+cx9mGYOgm29hebeH7nD
 bmlHQDrA==
X-Google-Smtp-Source: AGHT+IHwx6EQklugCPEKyuV0YGCstCxb98GkD/wxy3zK7DhlRDxpDcsVNumJJj3gfv9eWK1MkUregw==
X-Received: by 2002:a05:6a00:1404:b0:770:556d:32e8 with SMTP id
 d2e1a72fcca58-7723e3502d7mr312566b3a.24.1756506314742; 
 Fri, 29 Aug 2025 15:25:14 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/91] linux-user/xtensa: Convert target_elf_gregset_t to a
 struct
Date: Sat, 30 Aug 2025 08:23:13 +1000
Message-ID: <20250829222427.289668-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 linux-user/elfload.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 98c17d32e6..930701f08f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -873,7 +873,9 @@ static bool init_guest_commpage(void)
 
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 enum {
     TARGET_REG_PC,
@@ -888,23 +890,23 @@ enum {
     TARGET_REG_AR0 = 64,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPUXtensaState *env)
 {
     unsigned i;
 
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    (*regs)[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    (*regs)[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    (*regs)[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    (*regs)[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    (*regs)[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    (*regs)[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    (*regs)[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
+    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
+    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
+    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
+    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
+    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
+    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
+    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
     xtensa_sync_phys_from_window((CPUXtensaState *)env);
     for (i = 0; i < env->config->nareg; ++i) {
-        (*regs)[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
     }
 }
 
-- 
2.43.0


