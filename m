Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E11CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Pdl-0001Mb-M2; Thu, 16 Oct 2025 11:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Pdh-0001La-Tc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Pde-0002Jd-2b
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-426fc536b5dso475822f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627489; x=1761232289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e72zKPVaF45yxQ33N0zODaVKpunbOjttloU3CNi1eLA=;
 b=W+cAWyDwe4m5XNK6KhXmO4+jisVuNpkYujYQpdrUKmdYih5Lj7MDOuFGF4Uhg18CqM
 40UXOLQ2yD0oJ/o696qRRUa+adHNxvS9dHb892UI2BzMXtDWazGTTGAiu8XDCfX5INXZ
 VMG5rFAXVkvDsgmqhzmUOxMDs225zW9YnRXjiwq8SE6Vzg/f02tNLhO8wyAI7gR5UlxO
 mEme0jJAbefZ1VipL821qSA7thJ3xrrGVKLvp/hXXCA3uo9lkgGx/VnPpFMsFFldA/dd
 3IxN5ytb8jYBRR1hlWVTyz+GgG9EnFnWl609/W9BumPsWVAPeB7GfIRVZKe4yd9VtjMP
 E2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627489; x=1761232289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e72zKPVaF45yxQ33N0zODaVKpunbOjttloU3CNi1eLA=;
 b=PE15g69vaNdC+S1x4ymfx7qKIZv5I1B5ZH9WRgVEO8MU0aw+HwfEAA0iSNgw5yTyvV
 5svOv0dyOMzc5hy5xi0J8lY2WsVuzWT9FHZ17GtS/2dzjnNMdfxch/ywBmnulfLHgLkF
 ECcPbFkZKYNpLIVXqndVPJnxwwsln0eje3F/z/oFH4eG/HSy0ybl6QBL8Xhvy9xTVx/I
 rn2WyJhZq3+qJkFbQc0Kv+we/CO864uPQthBqvMwG3WMtS4vzQt7m8P5kgHnmizqWHsI
 yuvHlkERLXypOzC69ygyGGt4gXBCbnzLI1xhrZJSZu4CZcoBBlHyXJF/8kftpBJG8url
 aBpQ==
X-Gm-Message-State: AOJu0Yz5WnMssiR6IK7HadPIqJPx+m1Ih/kuT/LQlQk0QULwMLEC4Wf/
 2vQIRWuWvVWHJ/PtO1OUSyyZOz15Ze956DIHMAs3Dkx9yjpWz7qshTRI+4w5rsNCnpBJFRKovHB
 zsO4lbmg=
X-Gm-Gg: ASbGncveS1P6ETWqQnd575p47QdaDRIJcacJEwNpdNtIAMzQ34sq0aAaxL5ZsiQfUoA
 eNRwxCjxyo2udUn7eDc88+fUWKAwhNseGsXBXx56EDMj9B4UanSp7CNCDVJJAQP3aDStnRqxSLV
 mW9WlasEX8SF0c/kHi5HmFKvSyFP/xoJU9t7Yp2qipNaH2Nu5cxm/b0QgJxILmEudl7E2uAOwHT
 y74bKX4Zw2JcDlgSu9oOhE+/OLfEE6E80A///9v8xswYA7XWAMfnO758h9bxcEKMaIDmripioMQ
 FTYKo+Lo8TPnu2ypBu4K28Gbh2S1XE1BdPrpjvVkpa846fTMUQs/neWosaqd4QWTEl2XbQbxEPw
 huKT+r5u86moOeqQ58BTSumdw5X4cXZeUaX4tpmFWHjCvqzTo+4Dfp+BRZuKhz7SnRsJwzjOM0q
 BIpEtNI13hnToPY9xX6j3GTVbP03hwUM0UhvKYtx54jThCtSeqeeP01kI1OLwX
X-Google-Smtp-Source: AGHT+IGDpA4duXcqW6Zu7eMd0o/SVXpPXYoTMKe0KfyTlgVANv4Y+cFoTYLjTz0ywr6fehfELx9a9g==
X-Received: by 2002:a05:6000:186f:b0:3f9:6657:d05 with SMTP id
 ffacd0b85a97d-42704d7eb23mr398962f8f.12.1760627488690; 
 Thu, 16 Oct 2025 08:11:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e13b6sm35683038f8f.44.2025.10.16.08.11.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 08:11:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 43/79] target/riscv/monitor: Replace legacy
 cpu_physical_memory_read() call
Date: Thu, 16 Oct 2025 17:11:07 +0200
Message-ID: <20251016151108.18442-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016151108.18442-1-philmd@linaro.org>
References: <20251016151108.18442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Propagate the address space to walk_pte(), then replace the
cpu_physical_memory_read() by address_space_read(). Since the
monitor command are run with a vCPU context, use its default
address space. As with the previous implementation, ignore
whether the memory read succeeded or failed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251002145742.75624-5-philmd@linaro.org>
---
 target/riscv/monitor.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 100005ea4e9..8a77476db93 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -23,6 +23,7 @@
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
+#include "system/memory.h"
 
 #ifdef TARGET_RISCV64
 #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
@@ -77,11 +78,13 @@ static void print_pte(Monitor *mon, int va_bits, target_ulong vaddr,
                    attr & PTE_D ? 'd' : '-');
 }
 
-static void walk_pte(Monitor *mon, hwaddr base, target_ulong start,
+static void walk_pte(Monitor *mon, AddressSpace *as,
+                     hwaddr base, target_ulong start,
                      int level, int ptidxbits, int ptesize, int va_bits,
                      target_ulong *vbase, hwaddr *pbase, hwaddr *last_paddr,
                      target_ulong *last_size, int *last_attr)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     hwaddr pte_addr;
     hwaddr paddr;
     target_ulong last_start = -1;
@@ -100,7 +103,7 @@ static void walk_pte(Monitor *mon, hwaddr base, target_ulong start,
 
     for (idx = 0; idx < (1UL << ptidxbits); idx++) {
         pte_addr = base + idx * ptesize;
-        cpu_physical_memory_read(pte_addr, &pte, ptesize);
+        address_space_read(as, pte_addr, attrs, &pte, ptesize);
 
         paddr = (hwaddr)(pte >> PTE_PPN_SHIFT) << PGSHIFT;
         attr = pte & 0xff;
@@ -132,7 +135,7 @@ static void walk_pte(Monitor *mon, hwaddr base, target_ulong start,
                 *last_size = pgsize;
             } else {
                 /* pointer to the next level of the page table */
-                walk_pte(mon, paddr, start, level - 1, ptidxbits, ptesize,
+                walk_pte(mon, as, paddr, start, level - 1, ptidxbits, ptesize,
                          va_bits, vbase, pbase, last_paddr,
                          last_size, last_attr);
             }
@@ -145,6 +148,7 @@ static void walk_pte(Monitor *mon, hwaddr base, target_ulong start,
 
 static void mem_info_svxx(Monitor *mon, CPUArchState *env)
 {
+    AddressSpace *as = env_cpu(env)->as;
     int levels, ptidxbits, ptesize, vm, va_bits;
     hwaddr base;
     target_ulong vbase;
@@ -199,7 +203,7 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
     last_attr = 0;
 
     /* walk page tables, starting from address 0 */
-    walk_pte(mon, base, 0, levels - 1, ptidxbits, ptesize, va_bits,
+    walk_pte(mon, as, base, 0, levels - 1, ptidxbits, ptesize, va_bits,
              &vbase, &pbase, &last_paddr, &last_size, &last_attr);
 
     /* don't forget the last one */
-- 
2.51.0


