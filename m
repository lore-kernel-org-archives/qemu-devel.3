Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55613CD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgo-0006jr-8O; Tue, 16 Jun 2026 06:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgn-0006b4-3N
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:37 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgl-0003Cp-BL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:36 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c855599a77aso2142283a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604394; x=1782209194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bS5R3RsGVTQdordSW0UVUW5jFQW+AZvEdBGjeszpt5o=;
 b=XxPMaE+PE6ww/GI7yaeY85DscjbDCsrPTAE+icOYOGRqrDAfMNtTecmakHRGg7Nj8E
 ERiTse2sVFJuFxczhhSsZEZixCLX7BIm/n74hLAkSOwN+LaNVk4GutchFGvACKHObxse
 pGHLmvukCcAjZG5PnG8aVsk7egYNYi6N6euv39TjmZ8+Gch8hkq4/1Kr3YQ4KQ1WIfkE
 7mSn+o0odUN1DHmuTF8ISq+KPJpV2omGj6Y/LMpeMn05EkI5JUGgveSB6glqo9je6mdK
 HaGAg+xMwh0WqHyrtgDvOGCi394YUjCdOR3y3gRsMat5m7uDC7Z6E2ZWQEHfKed9FLPn
 rOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604394; x=1782209194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bS5R3RsGVTQdordSW0UVUW5jFQW+AZvEdBGjeszpt5o=;
 b=hbYQiyw2nXM631FYg0/mChdzSFPE34qI4yTQufsN3xQU7bdrOfd4ZyqE2UdhDhwdNf
 QHkulwk4Lb6g1EiLfq9I3XgM79k9geuxqZZkJC2CvdUjqWY4u+OwlT9Bt/f8jux+SyMw
 4XINGrztgnZqb7a8FKV3wvMA/mWwu6VXevSwQrpQjc9hlj5hyPrHSIqhM04OGl1Qppyv
 HDI40t1o5ZmIEH28P3mGhKQS9vXQkE9ySmfSC30I2qPebVt9tVKmSGMVR7zTQTvTcv39
 q+piE/TvMovHiB972/wZfxhl2lyGDUUSq+yoFuWzk9O3zyfVcJJ8G3xrPjLdISnEgcNK
 94Rw==
X-Gm-Message-State: AOJu0YyoefgjGqRbRe1zIr9Ml9CX3k/yHPIb2T/yNxtjwvje1PCOs15T
 xFM+eg6pjAxr+1I1+UELVQfDMbhl7RyvpGMiyR694AYpntw6Uxx4jCrHfZPkLlhb
X-Gm-Gg: Acq92OF9ZM9DdGRikmtwiFHIAEFOeihNB1yALXB9BaFscNhnNB0Vji3sqyLyEYrqivZ
 67PAYGQmrZ93VZ/xJOn1oGWHW7S05iCbZJbjWCZw6z2AyUr/K9jghvBAEPai1J4Ibd6s73nH2YC
 1P8EEfI1FQNfO52lwVwezoceh5ax1YPDAGf20F1JqQzvQZzGCDnSGQT/abM3XdlHxPOV8zBRl+1
 B9hGFVUWExl7WZfzIKj84dw+ptO1LOU81UkWotmTeAxzfB/AToHyZhOAcIGq1ClnEWtG75SOApb
 PIHCsMgH6nLKHxm/13nmJXJ2EnzJA0snYaqwAKvc32R7YeIBuHpxZbvdBO2JhgmztBaK7ccPwOH
 Wbj1EjR8PqfuIP5s0TAVWfDAu03DLqPefESkaIFe0xLSARDmnP4CEkwF/tITe8n3jzfaLBw8eDK
 cypOwWT/4IM7/UgvUbvTOdF2+3bEw7vDRzpZYSsopj
X-Received: by 2002:a05:6a21:b94:b0:3b3:216b:274c with SMTP id
 adf61e73a8af0-3b7e4cffefemr3336350637.22.1781604394056; 
 Tue, 16 Jun 2026 03:06:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/83] target/riscv: Fix size of guest_phys_fault_addr
Date: Tue, 16 Jun 2026 20:04:20 +1000
Message-ID: <20260616100527.1939565-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Anton Johansson <anjo@rev.ng>

Widen to 64 bits, and use hwaddr as argument to get_physical_address().

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-7-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/cpu_helper.c | 3 +--
 target/riscv/machine.c    | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2cc1b68f34..50f9ce1f86 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -238,7 +238,7 @@ struct CPUArchState {
     uint64_t badaddr;
     uint64_t bins;
 
-    target_ulong guest_phys_fault_addr;
+    uint64_t guest_phys_fault_addr;
 
     target_ulong priv_ver;
     target_ulong vext_ver;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f81354c90d..a25727b0da 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1236,7 +1236,7 @@ static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *ret_prot, vaddr addr,
-                                target_ulong *fault_pte_addr,
+                                hwaddr *fault_pte_addr,
                                 int access_type, int mmu_idx,
                                 bool first_stage, bool two_stage,
                                 bool is_debug, bool is_probe)
@@ -1876,7 +1876,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         ret = get_physical_address(env, &pa, &prot, address,
                                    &env->guest_phys_fault_addr, access_type,
                                    mmu_idx, true, true, false, probe);
-
         /*
          * A G-stage exception may be triggered during two state lookup.
          * And the env->guest_phys_fault_addr has already been set in
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index b7790c14d0..a4d337c27a 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -458,7 +458,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.load_val, RISCVCPU),
         VMSTATE_UINT8(env.frm, RISCVCPU),
         VMSTATE_UINT64(env.badaddr, RISCVCPU),
-        VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
+        VMSTATE_UINT64(env.guest_phys_fault_addr, RISCVCPU),
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
-- 
2.54.0


