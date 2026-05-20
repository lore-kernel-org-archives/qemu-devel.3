Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378FCCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPke8-00047b-B7; Wed, 20 May 2026 13:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPke6-000406-EV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPke2-0003Wl-Hu
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso38943015e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297825; x=1779902625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLvsWS0q05lqOyXgNSpk34dhHcgF39sVzumKyZgyZ0U=;
 b=iDidjUCVGoh02E5X0pJ0dyWTGY/cVJIGAI0uq0bD5nVXqQ7ce0JjQbutqTDEBgs+1o
 4PD2VeoDTpla8YBrR51ijWlPxUwqeGVNmRf+1ZAmSfZ2QZ4/nvSON4BbVUUNcMsrG6Xy
 1KXcSM5o3nIEfiub5/MQEfqgLNSBa8xT/Xw4AjiWlFTXxCbfwLsUx66RYGr9FN69q/V7
 U4QHeF6z549ZRUyE/tbUNsjpBAiFfddBg3Cq9+PnISWUXUL4e2ZcL3EWiwZazlcFW/ZP
 QF8dK+WgTfZO/gjy5CeffZJ4GatAuu5vT0DEpmUa9efHRj7uQ4oVSrPoh1Sm+WTSXbIt
 E6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297825; x=1779902625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JLvsWS0q05lqOyXgNSpk34dhHcgF39sVzumKyZgyZ0U=;
 b=Bjh/t5fdj1AidyR5M6W0HC1TQOOQEe83vQKQuhg9RJLysMV+7/14FvUhCdGHUIRHis
 emsOA2ECAfQim1qSdAjxD69auL3FXjs7zOTm/Lerqw27jcL2RI0edoBW1vwzts9WU4UZ
 rhT1MHpcxflGuHR2hDm3IAn8ZFjAOx3hX9WBKIfN0Ynk9e0qDOzO1feic3AgxNRuyR2s
 +J8L+HfJwOSddVd9ekmHdzrSKpRPmEcTCBarcrDG2iPAZElKjD8mAXoir94IksdQBlU3
 lQxJleEvhvVr72aBgUwkmddcDY0ffcv9kimGGvE+fG2DgQOc1YQFEHGVDgetOGC3yxRU
 r3Cw==
X-Gm-Message-State: AOJu0YzRAzZTN28C9dq1bMd7FGev+L/UTNn/qe40oHLgM1bjYVmLjV9S
 Wjc7PZ8Zq/kvZpp3Puzyru3QC6IEvUavN8geUNtzJBTGU37VgvB4CsqUIGLPQcdEU5PTpD6ulNN
 UnfRk5G8=
X-Gm-Gg: Acq92OGaPguWjlb4b1A66L2/p4SfAjTag/X6YUWcQss38cMMvgptQwHj0MgzCOQNOST
 GGVEh1Q+7JzALXYBT97fIjzbLkQgwq34XIU/WOxSDEMa2CoWwJc54DVSU2kR7XdG0U91MPPKMEX
 5Ctiujw6raphk7BqarWS1DUHgsGe0B0pJdQ51/oIyP1ToGpfRpFEJ4fXDMWb3UTUdOX0wNW4oJJ
 GpU7QOIyKVH/uePCnm2ub1R6xpPmebk7h1888o9iAePBCiBz+mb9gyoBVrtQYikK9BPJa1tiPlt
 kPMfb4IOxmH7VqXZ0WbwLXP0Sx5uIsd3IJqCaphk1qvAnoKk/Xqgvo9DlOe6m7s32KO8+HHx0sY
 NNUVlbW8ZEGUeLcQ6Q5vVSQbiC6yAQkhpd0mySJyqadwV6GNPkoYLViKNweEMPrYtA7yhu54vsD
 A5QXrqLL7zebBK1PiFyo3KUZZjajJMNwl0TE187xibTYFKKyuo9IDbpZWyMbjekRuQHkFw+0tZ
X-Received: by 2002:a05:600c:6211:b0:48f:e230:72fc with SMTP id
 5b1f17b1804b1-48fe663152cmr388092155e9.33.1779297825046; 
 Wed, 20 May 2026 10:23:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe79ce3sm138670215e9.31.2026.05.20.10.23.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:23:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 04/24] target/mips: expose Octeon68XX floating-point
 support
Date: Wed, 20 May 2026 19:22:52 +0200
Message-ID: <20260520172313.23777-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and use
CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab04738..cc1916232f5 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
-- 
2.53.0


