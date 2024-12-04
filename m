Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D0EE77172
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvzY-0004Xw-9U; Wed, 04 Dec 2024 15:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvzA-000454-F4
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:36 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvz7-0003aX-GA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:36 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434a8b94fb5so1437235e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344111; x=1733948911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cBEMnN1TXHS4bt02AxYmkT0i+FxThQSvcImr5g6Wp4=;
 b=B2fGai38bUK9ei9o/LTCXZjWHaxGueoxQg66TYG+pnCxwED/Jpjf+C2Z3xKtsd7cOA
 KDjXUgaxx/IIdh+RLpqs9eZ6IH9fYZIXPYxHxcqPiC2gQ4B5/tHmJ/ITrwbMU8GscAtZ
 Z9zcNNRk8Hri/Mj8+CNz+ikCJYdZV+mGtFWY4imOG+n30a9x01isr0p/oFeR5OVGpGHB
 1m5WS0JpY4z5/IjRytt2YoTT3TbMBBK/KBKkKNpG0rpYwOtLFKbAlZPPcYZawNtRtBJ8
 EZgBtR/ID4TpJn83+3U4hg5qic8fNflpQ+gfSDFfHF+luH9w6pyY2/YkE0v9U0oqX9R9
 yEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344111; x=1733948911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cBEMnN1TXHS4bt02AxYmkT0i+FxThQSvcImr5g6Wp4=;
 b=Dbddkf1ufvppFkFSa3neRiYHD1ZigfmJoL0hLo5vCaWbTOnEWjce+BRnLJP+Q4Gqxa
 OrBMiUNWjBZBSObW4+K36LP6p4gS13i85Nr7s7i57T+ARyCAMVNtoxiaT3zJMkHA69sl
 hztrL3hjCTaYfMPiXHzCnoPJrSIv09ShIJt2EssC9QgqoGTpt8SPa2NKkcHRsFvxdBg0
 SvSlJzzTRvLohQ2lv6sRZWcibi9yB7pXx5H08fpN2aFCVhsoOv5qJ3ulGqz8ILkjNZJx
 n7vvu1tQ5u9NnDAkcq0in8ci49iXl3oXEzPNknz6rrgFrcqwkwBrtikUuUYN6ZCCoKoa
 SflA==
X-Gm-Message-State: AOJu0YwR7sApB/8kYkbTQVxXgcYXVyGpKQuM7O4WTTa/0+3qnMheL9A2
 bCdEO+Qi61vNLPamf3kb4gd127R/CYAfKgceuQWBJYKJr7Ge/ymkKaDkQIxNMunkVAwoO/J8CWi
 J
X-Gm-Gg: ASbGnctcOeGNgIl5bhz0Xq7qiMv/cSKntVqAOnUhJowU4tk21+MpvPKDQReMPm9zFwz
 u1o6Ql3o2zVz5I6Y8Xw1t1UYJmKdeYCNIQjXvDf0B8jyG1Jiq6OP07hJ3fQNnMkkwr7/TphB7JJ
 yt2HTpvV8LVRB4FMz/95lsdvx0CPFk094SMUHBLqMhv1Gu9IedAuInfurvmLyYneeCAgIl35M8A
 k8ALX4BeeVIZXYCLNTqCIaUFaxr/VxCoGjvlqwpIGvCdiIXcF6Ch903YawkN66jOGNz5GVd2dtJ
 BEJdjIZkCNrVFv8hL2BIOrW8
X-Google-Smtp-Source: AGHT+IHGWG2XfrE5hUpZ7ULVvlqpIFSiR/ooFWD28XqCbbY4PtNRrd8I3XJJTwLLCVn1frQOSzVPFA==
X-Received: by 2002:a05:600c:511b:b0:433:c463:62d7 with SMTP id
 5b1f17b1804b1-434d927b5bemr5211385e9.4.1733344111609; 
 Wed, 04 Dec 2024 12:28:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527252bsm36373915e9.2.2024.12.04.12.28.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:28:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/20] hw/core/cpu: Remove cpu_virtio_is_big_endian()
Date: Wed,  4 Dec 2024 21:26:02 +0100
Message-ID: <20241204202602.58083-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

There are no more calls to cpu_virtio_is_big_endian().
Remove the method and the SysemuCPUOps::virtio_is_big_endian
helpers altogether.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h            |  9 ---------
 include/hw/core/sysemu-cpu-ops.h |  8 --------
 hw/core/cpu-sysemu.c             | 11 -----------
 target/arm/cpu.c                 |  1 -
 target/ppc/cpu_init.c            |  1 -
 5 files changed, 30 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5c75fe3a842..21b49800f52 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -752,15 +752,6 @@ hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
  */
 int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
 
-/**
- * cpu_virtio_is_big_endian:
- * @cpu: CPU
-
- * Returns %true if a CPU which supports runtime configurable endianness
- * is currently big-endian.
- */
-bool cpu_virtio_is_big_endian(CPUState *cpu);
-
 #endif /* !CONFIG_USER_ONLY */
 
 /**
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 24d003fe041..9806a2b7ecb 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -72,14 +72,6 @@ typedef struct SysemuCPUOps {
      */
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
-    /**
-     * @virtio_is_big_endian: Callback to return %true if a CPU which supports
-     * runtime configurable endianness is currently big-endian.
-     * Non-configurable CPUs can use the default implementation of this method.
-     * This method should not be used by any callers other than the pre-1.0
-     * virtio devices.
-     */
-    bool (*virtio_is_big_endian)(CPUState *cpu);
 
     /**
      * @legacy_vmsd: Legacy state for migration.
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
index 4b85face02b..458dde692ec 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-sysemu.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "exec/tswap.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
 bool cpu_paging_enabled(const CPUState *cpu)
@@ -122,16 +121,6 @@ int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
     return (*cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
-bool cpu_virtio_is_big_endian(CPUState *cpu)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->virtio_is_big_endian) {
-        return cc->sysemu_ops->virtio_is_big_endian(cpu);
-    }
-    return qemu_binary_is_bigendian();
-}
-
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3061b2ac18c..0df6408ee73 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2664,7 +2664,6 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
-    .virtio_is_big_endian = arm_cpu_datapath_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
 #endif
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9650acb4850..be0eea2ff2e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7407,7 +7407,6 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
-    .virtio_is_big_endian = ppc_cpu_datapath_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
 #endif
-- 
2.45.2


