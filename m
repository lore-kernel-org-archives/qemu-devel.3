Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C61C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfMr-0007uz-Ii; Fri, 17 Jan 2025 00:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfML-0007KY-3D
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:33 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMJ-00063j-IN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:32 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso31153655ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093450; x=1737698250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvKTZTfwHo09+/+9jpS1HMWs+F6dxpkz87v0o67vzNg=;
 b=hP9lsflQGoTxsogiEfo7eHu5PBdpVTkGhcVKmyHVKt+VFtMUp02oiw8rTtpqQWWyMZ
 ZV8dLVyeGlcCOK/JSSi7Faf0peI9w99WSt3BH4p2ji2Ch4NRg/1Xv7YGZF2iM2+WcXQP
 wOMKVd5uuBpudoVPhbhK1qh3vPpsYhYzWHaEpJJs0RdOrgRf0W3oXwMZWb9DJpBntO/T
 9iyPhzlugF+uz7pBmHDiQhHGwx0SGqNzYmQeePQXPKeuXPQJIEL/BSvhRdf+D1Zzp5X9
 iKM9jFJRusK9upVIZ78qHG5NzZE05zuXMTnTZuSIpF3WKplrKNFCJETqgo6caoe9BB3f
 OFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093450; x=1737698250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SvKTZTfwHo09+/+9jpS1HMWs+F6dxpkz87v0o67vzNg=;
 b=JbABR0AFrmE0Av1nOoJpRFj7KPNjMu0pAFwNJOnpANZ8WTa3FKJSaptF0l64NKsFQI
 jdWYifCJPZTPqG80FRY41BpXhr2aKPFaV3t2vMWmPL+xxOcbJu/1/iLH7jx14ULds1vl
 xJ8e9nBL1AYx7iUffNa0DmmLo0oi94D4xa9buvL94SKHcaBbbBlDaZDOjJJGnNxEWzuU
 /SnKsumK1anN4Isn/HB0WUCH0XriE0c0n1Z4PkTEMqqVB9iNL+u4xLHhtlSydyK/xkuq
 F8TMNuNv0Acp+xjZJg2phv3oEnOjCgW8v3cByUQ3Bft9xsRkdILYYAnkCTVkjvIf0lmJ
 5TWQ==
X-Gm-Message-State: AOJu0Yy3x6LoB9MJ/BjE6IjC+qiykc1sd+ZngQd9ms+3/qYCn5bTcAfW
 YmsSJlqeTHxBljizcxKNuU0xcpOLT4R3/DDL8XuZAgHADDkeRGWYBjqktw==
X-Gm-Gg: ASbGnctkrC5474aITCdb7CmowIWvWBG3eQcfV1KHhJefOB+iS0b2uMMJPiIvef9hBio
 ElufB2qakF2801GBXZTIBCEpzot5wrX+eKjm4D9MRVErHQPsh5pEBXXZN66zDqMmJwzaqGYnJ9u
 m/Xs1cqoI/MbVOW86jjSzyZefe7vIXbGcyzd1Imk7iaypOMUhEjGnSSNcBUgJEdeoeqKqYh9NWY
 /80wjNkHtE/B3YtxW25zswvWAEwCvrXfjbSKdc/L8Q6Z7PoXl5K+nhBiWLFCLmDvz6q+niLCk4W
 qeQPPC+mp/V+uPaqFHmHJZQhF8TRNKchk9+N6iIyPuyI3w2Vpqb9uKEHiFnv
X-Google-Smtp-Source: AGHT+IFQ13IrIEhUrSeLUUrdUogfH3V0amQwH3oJwmoWf+oqimlmsZK3GElmUCR/tkUGWSYHbQTVOg==
X-Received: by 2002:a17:903:2342:b0:215:cbbf:8926 with SMTP id
 d9443c01a7336-21c355b053fmr20983145ad.35.1737093450042; 
 Thu, 16 Jan 2025 21:57:30 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:29 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/50] target/riscv: Have kvm_riscv_get_timebase_frequency()
 take RISCVCPU cpu
Date: Fri, 17 Jan 2025 15:55:28 +1000
Message-ID: <20250117055552.108376-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Keep kvm_riscv_get_timebase_frequency() prototype aligned with
the other ones declared in "kvm_riscv.h", have it take a RISCVCPU
cpu as argument. Include "target/riscv/cpu-qom.h" which declares
the RISCVCPU typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250112231344.34632-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm_riscv.h | 4 +++-
 hw/riscv/virt.c              | 2 +-
 target/riscv/kvm/kvm-cpu.c   | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 5851898868..b2bcd1041f 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -19,6 +19,8 @@
 #ifndef QEMU_KVM_RISCV_H
 #define QEMU_KVM_RISCV_H
 
+#include "target/riscv/cpu-qom.h"
+
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
@@ -28,6 +30,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
-uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
 
 #endif
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2bc5a9dd98..9e8876be29 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -750,7 +750,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
                           kvm_enabled() ?
-                          kvm_riscv_get_timebase_frequency(first_cpu) :
+                          kvm_riscv_get_timebase_frequency(RISCV_CPU(first_cpu)) :
                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 11278ea778..23ce779359 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -758,11 +758,11 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = false;
 }
 
-uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
 {
     uint64_t reg;
 
-    KVM_RISCV_GET_TIMER(cs, frequency, reg);
+    KVM_RISCV_GET_TIMER(CPU(cpu), frequency, reg);
 
     return reg;
 }
-- 
2.47.1


