Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77654C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtil-0007r7-4B; Wed, 19 Aug 2026 23:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtii-0007Vk-BD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:36 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtif-0003vJ-4E
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cf452def93so3671885ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197532; x=1787802332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+FdWVqHvbukBDTAtIE0GsAxOTICi4E0tdgbLrJwjft8=;
 b=JHI9rSjqDYbZSpdVKQlYkLPxw6wwKp43/lGXIvtZGlghSB09YVUlJHkWhLsy7RFmp1
 m1zl6DfF9JmjvqomSfrXg56kk1gOcAAxeSavhjJWTOG9ABKopQVbv7pLSBKKiwsMMTSU
 QDNJftJJNf0nYgr8BaNtiI/RKBXYnE9QyUASd22w5XhLNs/9uIiSwd7Wl70/mR4aBC6W
 ojW4IrkaKPq87G8vh36tuk0IJzezSwfRXQKFWfYKvNEe08/odIkI9cXY97FpNPDF/xKN
 kJTliEwvwiD1Sy7xYaTceYPA2kJ+CVd1upMtjsqxZzlk24qlga5ZaBGo94MJE3YkcM4R
 JISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197532; x=1787802332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+FdWVqHvbukBDTAtIE0GsAxOTICi4E0tdgbLrJwjft8=;
 b=aN6motpghmMksHfG7rvzziFLklrYQpFX80njcFI2XTNcE2F6A6QKUojDC8qv247iLZ
 upEIqoxeThb6gKt4G/6lM2Yxc6HvsHxNUaSeJj1NFOtkAG0BBleYFrCWTIFwif+6GUU/
 Lp4FVdAmaJ9CDRpIUYyZLSnunyk03AHFgH8sQoD2qhiqd8EwpkDCR/R4d5TIP/3jmDch
 8Eiu92AHPgLLEFPm+rR9WmaUoLKvYLCPKqEhaHz3TEyKIiIJfFX1AS9ZPHAkVq8+o1Um
 PrE5+zKypc2XhtxsgJQ2xxI/WDp85wO//Qu1/RNKebJ1JzR/UK9OyonLXg9vjxjvHJ0z
 NKew==
X-Gm-Message-State: AFuF++k6M9ZzvCFzClVz1UNoIKg/q/16qUkMSY2pWGDrWKBgGqrmfAiU
 3aT1YhBlgw3WsmqIGmG7xw7hmSea8AGtHxgMsDQAXou71p//FJIu08CHQIjhoA==
X-Gm-Gg: AR+sD13qlmb+O603YNhQYq3ePA4to2MlI4X5+BEmRmTDbgmMx15FEkKP8BSWJwXh18C
 4i2YVtlvswVYyC299IFHcPTu5UNThsywayHecj/UVzzHCA9qw6/M8/poy/UV9XwSCR/6XLHH9wI
 Wj5Qs/6jPS1DkP1Ojxcfaum50AbfcwyNA3io8tbYycvT2PFZX4iIy2UoKHIIvp/kG5ZPeQY9dm9
 efMQIxbr6AQdFW9jiph4ifCusL+nkUUz4WkMFPUstuzGEV8N78m74/YqajcMpAWg/xT0tVwy0SI
 6j0e+94hmieIxZ1Ssj+r5l1wZEB4lRs+Im5ekUXGRnwYHPsaowr3FVpsJhwPs1mh249BEHysbMN
 doqkyD9mB2jQ6yhTRjA2HgMDeBwxnzpr4KcTOfR81Me+72vPsckHRsYTdvk90VmVAFidNll3rDQ
 KWlivZf2JlrwLnV+1tiNsD9Lv4abJPA0qp5DDw3Mdvkn6e/5SWUyJdyT85dGVkQCcYBhKyXYzq2
 9YPYA==
X-Received: by 2002:a17:90a:e70c:b0:38d:eaed:4adb with SMTP id
 98e67ed59e1d1-395a074d955mr5010276a91.20.1787197531640; 
 Wed, 19 Aug 2026 20:45:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 16/93] target/riscv: Add Zicclsm CPU option and enable it for
 the eligible CPUs
Date: Thu, 20 Aug 2026 13:43:13 +1000
Message-ID: <20260820034430.1186695-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Add Zicclsm CPU option and enable it for the following eligible CPUs:

- Base 32 CPU (to be backward compatible)
- Base 64 CPU (to be backward compatible)
- XuanTie (T-Head) C908
- Tenstorrent Ascalon
- Ventana Veyron V1
- XiangShan Kunminghu
- MIPS P8700 (ISA doesn't include Zicclsm, but their datasheet claims that
  it has unaligned load/store support in hardware)

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 2 ++
 target/riscv/cpu.c                | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a7..f8c27a574f 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
 /* Always enabled for TCG if has_priv_1_11 */
 BOOL_FIELD(ext_ziccrse)
 
+BOOL_FIELD(ext_zicclsm)
+
 /* Vendor-specific custom extensions */
 BOOL_FIELD(ext_xtheadba)
 BOOL_FIELD(ext_xtheadbb)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e73ff53159..b2693f4c20 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3347,6 +3347,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3419,6 +3420,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3505,6 +3507,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbs = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zbkc = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zihintpause = true,
@@ -3548,6 +3551,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicond = true,
         .cfg.ext_zicsr = true,
@@ -3597,6 +3601,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         /* ISA extensions */
         .cfg.mmu = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.pmp = true,
@@ -3656,6 +3661,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
      * The RISC-V Instruction Set Manual: Volume I
      * Unprivileged Architecture
      */
+    .cfg.ext_zicclsm = true,
     .cfg.ext_zicntr = true,
     .cfg.ext_zihpm = true,
     .cfg.ext_zihintntl = true,
@@ -3712,6 +3718,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
         .cfg.max_satp_mode = VM_1_10_SV48,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.mmu = true,
-- 
2.54.0


