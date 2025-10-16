Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54649CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MwD-0001uu-37; Thu, 16 Oct 2025 08:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvw-0001NJ-4F
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvf-0008Or-1o
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so3534025e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617074; x=1761221874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VFh1HW2f+esTDhZJHkTsaDbNMkr7feXzS6a3B7GjRhc=;
 b=Z8cVeYhVmUW8A7TkQSyOFn94FrHpU8wOJMr92zAoEsjWkzlPPHgCCi9fSfPxLviJnw
 Z2NgABGExDCq3v5FRWwwVyxrnAyba3LEjGQBj+6U3sWt9DAsOjwC2mxg3e0zGX1FDX8k
 Ei3kSZRvlbFxrveS3IqvA70m4HKtykDeXgsudygGrqJnScgqDsUg5mkjHmI0lnsBGRGx
 Zq3Uma9EHNavwf6pTk2vwphn0j3Ckhrq3kEReJCtj5t7Kgmeg376aGqSQljP2i56AKjK
 nkf3vF2R9mqZBmEhJlm3M6xyqJVJ56j33WoFoDYFUOLoqs6lcQIme0EsG/MEaXH9wM2p
 eZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617074; x=1761221874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFh1HW2f+esTDhZJHkTsaDbNMkr7feXzS6a3B7GjRhc=;
 b=O33HqKQ4843jxpS7ClQ4L5HgSbLjtwENhEY7lWoQYYeqpaFxmw8u88RkZGHRUzaykd
 NFFwXipJzc4WICured/FADbpnqdnrc8T9dfDzvdEQYXmw+ySOkAzM0KqZ50x6oB3AgLK
 rLAdRyJBJLMptGaR5W/uW125xMfiUBpbA0OqVJdgzYWuOQVn4H+129FXxgdB3QmZbZY6
 EiEn/WW+jUUMDR8dc+TBgQRptdDPZzAB5sSX07s6NgcHvvfNLsfp0pdj9LpKZxefPr1i
 AO+YUde//VVyOU32ACK3GVdcNdXrdV1IuBq5Adk0vq33rOH1efY89G7WvY4DBGRTlhku
 RTfg==
X-Gm-Message-State: AOJu0YywlIbhrf1YIGeNzdUly54dZdAoiahQSAdIcT7MA35joBtmi8KN
 FSnKYHIl5HDVV4Aa1G1YdS0r1so5Xl94sky39Z2rzPKlGx0x51Sgp6wL05fhgIcKx8/FXYrYQLw
 gJ+yX3fQ=
X-Gm-Gg: ASbGncte9Tsbyx/tT+H18bSnE0lbNbMm1ZjK4JTgDupJjuzI4LErAeAPcLptocUHVjN
 GrMfVPhqvVutK57LuPmTk8RIvr0I6D088iAoiWIFjeHRvtcZKDkt04aN2pmu4sFS3eGwAgD/zrw
 fih2eDzt6fH0Qkhlk3ESvNYpwvSvzdN8anjaHWv4ZUqbq2KtK3tu6zivJ+cTRf6bLgBCNkgur+2
 mfnjLAZrmq+89pr4+ey82rXRKHuJlapqNEX5nuF9xw+iSzbnmejBqL6osBLcVVIXKNeJKGfVhKX
 yF8v7UE+6VRmVMzcK0XvWEvFyUCQEDss6DmZ2LUhrhPkCytZOcKg0ZFcWu2C0nKsii86GCz23m1
 XEK7/s6ElRhB+yDWU7GcAra7L3Gga5rZzGy2izd7PbQqWC7dfjXWDPB7C4ddZYuI8FA6H+yIJN7
 qG/WPUUN99kxmbqUYoKikZYbuXbl24iys6gTT0qNtjtwJXl04PzOZ1sA==
X-Google-Smtp-Source: AGHT+IENKDhvS6jeeRypQlxK3gHoj8Sh/20fZY5JSAD+bcNkXmwiGl8VAuN5Ah+yGJf2w80LgCp91w==
X-Received: by 2002:a05:6000:4210:b0:3f2:1cd:3d00 with SMTP id
 ffacd0b85a97d-4265ef760d5mr18791057f8f.0.1760617074254; 
 Thu, 16 Oct 2025 05:17:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711444d919sm23847755e9.14.2025.10.16.05.17.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/75] target/openrisc: Remove target_ulong use in
 raise_mmu_exception()
Date: Thu, 16 Oct 2025 14:14:46 +0200
Message-ID: <20251016121532.14042-31-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

TCGCPUOps::tlb_fill() handler provides a vaddr type (since commit
7510454e3e7 "cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Do not inline get_phys_nommu(), rely on the linker to optimize at
linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-5-philmd@linaro.org>
---
 target/openrisc/mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index acea50c41eb..ffb732e0d1f 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -28,15 +28,14 @@
 #include "qemu/host-utils.h"
 #include "hw/loader.h"
 
-static inline void get_phys_nommu(hwaddr *phys_addr, int *prot,
-                                  target_ulong address)
+static void get_phys_nommu(hwaddr *phys_addr, int *prot, vaddr address)
 {
     *phys_addr = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
 }
 
 static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
-                        target_ulong addr, int need, bool super)
+                        vaddr addr, int need, bool super)
 {
     int idx = (addr >> TARGET_PAGE_BITS) & TLB_MASK;
     uint32_t imr = cpu->env.tlb.itlb[idx].mr;
@@ -95,7 +94,7 @@ static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
     }
 }
 
-static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
+static void raise_mmu_exception(OpenRISCCPU *cpu, vaddr address,
                                 int exception)
 {
     CPUState *cs = CPU(cpu);
-- 
2.51.0


