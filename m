Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6CDC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbRS-0002Mi-9l; Thu, 28 Aug 2025 08:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbR9-00028r-JQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbR7-0007AG-L7
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-248c7f955a2so8102585ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382940; x=1756987740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nKfUoO4CItnglgX3ikzNqhJgzeUM5V1sWMeO8yPNJs=;
 b=fT/20P0RPzCGIYIgNOcI7TmpqhNwGY9NbszSFnlmjVy+RO9HXSwuCuMWh4bLun3QMy
 YZaFlov4X1RZsdp21UvGRM7lwS7hFvb/qGG4dbHOvSRcw/wxnKFeFgyDE/PGObvz7H7g
 cf8d1ODLbuRd2iubIommCpkPofEfDapSy9lWNqmG3rdx4+th6iJdto7hMTXbdIe9C/s0
 0xLQh/WsUPXHy0Mn2CBGcmcs2jLPm6BOuQNV7J8rJ25oYljSZsyUieNthGBRzgNY9kVy
 DwwZuHXTu4N3cRNVTRB0Mr77orC/nspes5etR51sRUzUdCLNmvwzWzvjmcvtgX5q3YZK
 QkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382940; x=1756987740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nKfUoO4CItnglgX3ikzNqhJgzeUM5V1sWMeO8yPNJs=;
 b=MFZve+eDgv9t2EewC5HuTzEhxM/gPm29vtsx4Gj8iCUVYURlwr/DIQhE1/d2s3XLgE
 3D4j02bTvfPV7nlf7NFna21SwCAfBjjx3+kIYLIfmHbjbG6zQZqWbfH0w7QzbRdKWZja
 jS00cqNMb0da+sJx1v0Au2BUIImHsExF4ZjL409doK+8p8F5UJSU0lIh6fupTusJyN8+
 mZ+25MVdtwrAXYtMSBW/NIMB/keaHsWQqxqbEuZHbKBXrahnflY6ZEKPGV7OaIG+bfVr
 Dg0jfOw+eD7pZFI901MsvbvghTWq5mtoBeSIpkBRMqXXbiPIYnODIhbHV04qsvxjpZkp
 LWrw==
X-Gm-Message-State: AOJu0YwGqlVVxay/AbSN7HVdv2nLlGwhyfL0fYEhw98uLqXITS7kjhtn
 QLXzwfsIw0oVMR78/ihV1L/NutGMqH45dpP9Ezj82nGrpWOWzwHuOjfk3AoaFEgXqjX2Jifes7Z
 Jnion8Vw=
X-Gm-Gg: ASbGncuC+Jdjmbr7EBWjMY02JNRdv+u5l/3eO9M/77GIPR14RJ8oESrcO8Zl1t3GFrF
 QMrCy1v/dkFMVr5KYDCJTNxiLjn+1WOpPfP1i7s7wj6i6COc8mzlHN54eVTL526wE8nnB2tQ1RM
 hnC/R8XAcY74T7IEha5FqIwcw5Sz/41EcBHcMFHHiqVpmHAg1LQOFYrOXsF49t3HlEV6Hnt7acg
 vCkqfECXjjeBle2PXH6ffgPxHZ/XLplbmpUBfiUr2R96zc9ohOh2FTuHL+MOpO3R+PQ9EHJ18w0
 MFYvO2+Om/47w8M93DaT4WX0gF+r8KkEP9kO09BBotZQYNxprhZtWrJqSBccrwK2m0LEuA3Mtih
 LjiXsP5oxCNUjJQ5zov/+EFG18xkahbak4KU9
X-Google-Smtp-Source: AGHT+IH4RVfFqVVAPfzVfrXDiaE2lgNUz7SaUCKm40zfG5GVPTQ7lRd36fxjwJ1kpHjf2ZnS+CIqZw==
X-Received: by 2002:a17:903:8c6:b0:240:3eb9:5363 with SMTP id
 d9443c01a7336-2462ee7390emr285781805ad.27.1756382939814; 
 Thu, 28 Aug 2025 05:08:59 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 07/87] linux-user/mips: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:16 +1000
Message-ID: <20250828120836.195358-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


