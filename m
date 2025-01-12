Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA52E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 23:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX79a-0003zQ-7H; Sun, 12 Jan 2025 18:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX79W-0003yX-Ux
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 18:13:55 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX79V-0003UE-D7
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 18:13:54 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so39501085e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 15:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736723631; x=1737328431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7qJZ9wrukuVT3YT0FFUXFsy9pw6z+PqHimxMGu1A3M=;
 b=FDkfzOtXC3izq1pM9VsHfRCnSgAlEmVahwAMooYCP5H+aTEsSuOcfZ7KNDJ06aaz01
 4jzEtdYPvDZeGHkmEa2SJ4WtppZmmsC6d11Giw4fS55c+TUjitFkLYbj8ojtbLCI7Qkt
 1TRYmLr63EDv0b9nJPbHwedzvtUnXHvx3q8hdUmU8+8J6xpcWihFg0BsuGO6X4kX6VBY
 IHP+B5m+rpKg9DmNd7VVKrfyad7n8FFPf/HUBYf3eV/0fqrvzojWsk/FUxrKu+8ATM6q
 6nLKx9JR0mRKu3KDq2KLBh0yt0IBEb8nyjqAKVN7bBF9TsZ9gfzo5mbQP3+JjPAYL4Zm
 yKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736723631; x=1737328431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7qJZ9wrukuVT3YT0FFUXFsy9pw6z+PqHimxMGu1A3M=;
 b=uGr/oeQvG37kj++iCPvGCpIxFpR+nXv5w8j71svDb5R6oyJhshIPsKAji8Jm4kahDR
 oe3PgGd59w0UIPSBG/V605YXCNGLjj2fCsg49Gb4+0/soIHdys+OkFXOl8jh62YeNY/a
 aayGAkKGz9lvjlRPOg4LC4trtLiPr92id1IFMPs5KbkLMIB0O8mhBG6iduUpHx7zUVf/
 jKjiYdDkNdhMqiUe3SQJoclO7kNPEEospjM1mqIk8RVSIRYXVd0jE0xWZm3MedyiRp3S
 o3g8i9aY3uPwVD14hbfNbaTmTUB2f/n3giskz6aodyh0BxKmwuKwBLsHUsJAlk0Rg8t8
 pE5A==
X-Gm-Message-State: AOJu0YxXWtlzziAw3HgJjkbjmJqk7L5DDpcghD9hnz/scoOnNa/jJ1oR
 BUDTwGNoBjp+pv6IjF1qlKvQ6StMzosOifTtggKUQAhxNpgXLvHS4fK5YL4+byktqz0NbcPyzvC
 eqUs=
X-Gm-Gg: ASbGnctXDXGINxyOuWBpW3fzmet+n6+qRECMicj5dtAG1epVcTTwrz6ofDjfnj/AHA6
 u5TOi3Woa7eQmZiO2k/na8F2QQJ6mCNMhd/QdkTgftrKn/DKFfp17t3j7RUqfE45xpW6JZ9z1gI
 zLQq+V9/VeoMyHQgdCkcrbCGBS4/5CLJzxYBWpLmTlFsO1M/JWH7mPuqTg8J6gjhys5gJhKpKqK
 0fxeeUdkUZQJUZbGrHVLcgi16GVmkM3rlrX5JE8KXEuNnW+7bwdgH6jOHhbHPsApOHZ+756ABNI
 cVFOiOuCqszqfhs2Fg4Vf8DoGqIx59M=
X-Google-Smtp-Source: AGHT+IHKlGsO/XkKqKg+GvhxZqMshcmpUS5Z4ysK9a/BlHswDBlLdFadJZQ09mRDYGdSEFFocktC8Q==
X-Received: by 2002:a5d:584f:0:b0:38a:68f4:66a2 with SMTP id
 ffacd0b85a97d-38a87312bdfmr16904898f8f.31.1736723631298; 
 Sun, 12 Jan 2025 15:13:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm10920595f8f.10.2025.01.12.15.13.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 15:13:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/riscv: Have kvm_riscv_get_timebase_frequency()
 take RISCVCPU cpu
Date: Mon, 13 Jan 2025 00:13:43 +0100
Message-ID: <20250112231344.34632-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112231344.34632-1-philmd@linaro.org>
References: <20250112231344.34632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Keep kvm_riscv_get_timebase_frequency() prototype aligned with
the other ones declared in "kvm_riscv.h", have it take a RISCVCPU
cpu as argument. Include "target/riscv/cpu-qom.h" which declares
the RISCVCPU typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/kvm/kvm_riscv.h | 4 +++-
 hw/riscv/virt.c              | 2 +-
 target/riscv/kvm/kvm-cpu.c   | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 58518988681..b2bcd1041f6 100644
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
index 2bc5a9dd981..9e8876be29b 100644
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
index 11278ea778d..23ce7793594 100644
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


