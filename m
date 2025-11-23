Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86084CFA46B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 18:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNFIS-0001Nj-CS; Sun, 23 Nov 2025 13:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNFIH-0001AU-Br
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 13:58:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNFIE-0003W5-3U
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 13:58:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so36785205e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 10:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763924315; x=1764529115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZs7gYynycdv4EGKIYDGcUMCMGhmj2RagHDsP9q/nKQ=;
 b=sLxpUxJXMxMtgWTSrrmuBOKqjFoqdKy4wCsol2RbsA+um7ftW0P7vKvstP37RpAz1S
 PlWOB/p9kfhy3FeI9b2QAdwgtJu3m2EgAlftjE4P/B6BG9boZVsYy/SwRiQ0n9c6fLTD
 gFzUqriu6JYRLbtsJmeJg7lFdeFyrqjESyVbUNT08rt9TzVaGcm8S2L71Sw0jYEcRUTM
 KLkUy8i3MeaodGfxSTuSgVh7yEOhcaq0UiywSFPQLZczvtQsGWLxpjdnGQw/VlBXm0u/
 6L4doDsHX2V+D9abUIOXq5xiO6Fg4C6OEC0HpFxUtzbJQjNCw52Sa2XcpjcY2oC3+cH8
 nznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763924315; x=1764529115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZs7gYynycdv4EGKIYDGcUMCMGhmj2RagHDsP9q/nKQ=;
 b=CSEwDoCMCq7UgjD3hOBAAD0cbU0HLDwRqsRBfZnWhlmfdoTaboUZG75CSjtewCb90h
 80eY2R2ZaPkJInWFR+xNvaJ0FLpPiUXEQeh6SS3stKrAkLtWU8kTBh0bmxVTQWzIkGPq
 e7XS/hsXH6V0s13qOpj7Q1GjZ6yCkvJVF+FmpBfWymEPrPM8q1geCfVJY91T+71m98II
 Vdz2mujpaHW6yTCH9z7erRSB5x4XAxUCbmEa7xHC7lE82mAx/FJDgGwYM9zcVIRC9Ytv
 PzYdr3qvF6MdjBYZUMs1PF4EtNZYKAB+1AXdgQN1UAH71sWD0uSSPQCDhjsLR8w/dNae
 vR9w==
X-Gm-Message-State: AOJu0YzbN+opUzt8RhulxC7Gcd7FVBqNbHqNyFujRpAPLCmgGCroBCrj
 ivLDhyUJs90lmZrhh6htNzvFALgElf7SibrRq+Fud2vigZovneS9xcBZ0U4G18Ml8kUfc7/SMdw
 PzCi4Oy2FTg==
X-Gm-Gg: ASbGnctORTh7fsMHULc5cMSFUZCdc3x34Ox1y+KoNvZ8GTEBXL6zd9/h/+M06Gu6SFF
 XbRM0Llzn8UYhXn2BZIYiw2sYskyVJiuqh1WF1BtZv/B7ZlEOhSNFh7sAZqufsXORxbD5IMuDhA
 PGCKVS0mnl8KVPgnvudzEl9n4vPQD50MHolsUgtkyp78+Q/ecfCYOfz9z6cIx/ZK56xfGAY4qCi
 SuPZyj3418mIhkEd4Nr64WLPHd13vToFvy7HIAcK1l3MsKv3KgexTWd0H+FS7cEZ1dMkYO1NUP2
 cSyDryVsltRfjoiMrOeSH7ZwVHcLhASCrZI7CCbH6ycg991tUauA9tunJQRlxZCS5fG2u0oq6ct
 uG85PLGEeQMmhst6SA8wRnzDlIR6A+NM34EaCWqd1TevULGfdUcoX0BiIbadLns0qWTpSCEqB7i
 Fkhobh2SYDDLDZMlkwgmpKGIeiw2qPExH0Br4JPfXqjqUE8UwOixgZVbZibg9oZl3LmEmRzV8=
X-Google-Smtp-Source: AGHT+IHzO3TzKM0byiy0d9QAboT5h5wHvIrU67sA5M2DR4+xrurNsc+4Y6ORWQbdadWWIQty08DYhA==
X-Received: by 2002:a05:600c:b93:b0:477:557b:6917 with SMTP id
 5b1f17b1804b1-477c01be404mr91728135e9.18.1763924314742; 
 Sun, 23 Nov 2025 10:58:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4eb2sm154328725e9.12.2025.11.23.10.58.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Nov 2025 10:58:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, Eduardo Habkost <eduardo@habkost.net>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/i386/isapc: Remove dead Xen code
Date: Sun, 23 Nov 2025 19:58:32 +0100
Message-ID: <20251123185832.53802-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

We don't use Xen on the isapc machine: let's remove
pointless code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/isapc.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 1ba9ae22cc3..1e13a30c505 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -17,8 +17,6 @@
 #include "hw/ide/ide-bus.h"
 #include "system/kvm.h"
 #include "hw/i386/kvm/clock.h"
-#include "hw/xen/xen-x86.h"
-#include "system/xen.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "target/i386/cpu.h"
 
@@ -37,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
     ISABus *isa_bus;
     uint32_t irq;
     GSIState *gsi_state;
-    MemoryRegion *ram_memory;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
@@ -77,15 +74,9 @@ static void pc_init_isa(MachineState *machine)
     /*
      * There is no RAM split for the isapc machine
      */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 3.5 * GiB;
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
+    pcms->max_ram_below_4g = 3.5 * GiB;
+    x86ms->above_4g_mem_size = 0;
+    x86ms->below_4g_mem_size = machine->ram_size;
 
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
@@ -94,17 +85,7 @@ static void pc_init_isa(MachineState *machine)
     }
 
     /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, system_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
+    pc_memory_init(pcms, system_memory, system_memory, 0);
 
     gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
-- 
2.51.0


