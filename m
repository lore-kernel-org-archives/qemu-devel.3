Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ABFCCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4KlZ-0007PD-6C; Thu, 02 Oct 2025 10:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4KlN-0007N2-RE
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Kl1-0000Ky-8F
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so7497295e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759417083; x=1760021883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPOBGEk/JkbJROHbpkshAw2ZS83wGDX/n50+XyqtzvY=;
 b=unHShYyEG9tSzyBQW3zUmrf1ugjYqo6NSRefz8yqzaHNmewAv0QoW/mgHV5mC23opo
 0qIz3gZ3gg1wE3m41wuWaFH/9QDBS7HtJ5fwMV7q3gyTYlGsxWcUyaMRaeJAxFY7/d38
 jKasS0pgqP8btG8DewEQr+VdWTxOIg2IB4b10+3tHReYmPtD9lnwO70qHH0/GqLidlFR
 XDEGoIjOytSnDxLDzk0XTWb2B7CM/xxlcDLayRLKW3TW0lhg0Y+xPruQKiX+R2aJ19ef
 1VbdOJfj6DAbXwahPZntdVgnxuy4HulOLXG0ALiXc0StO2LBcsyb6bWR3zNHm17Wu9O5
 XRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417083; x=1760021883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPOBGEk/JkbJROHbpkshAw2ZS83wGDX/n50+XyqtzvY=;
 b=Sc7cKvcPu8QYICHnPkDN+bj1LESQVtLdkGX0CMxFJld4fHLpKaxcP8RRBQh/LR8jVW
 4v0MYFghP81W/WneDzdtbOeKKHV3uZNMg2CqTOTx0SA5PlUBNxzYmZmoMzkptVSwJ2xo
 Bc/MBVVvawAzLSoLv38ayuwEKTY2Cb33+CJOBsM6arWFp0VuGDdinAcZT9XmLsNTwnkS
 sPS/FOEO6W7wrlIzo78/sOl5oT0k+TMBU68aWO42ZbXbj+u67tpXmuehxxAiqrV7uARS
 SHnqhYOUxgd25ul1shoPqy1WaoKA0kQmbngwISbOL/5qCzKu6pWNyELI8XWhylYAD3dm
 ikeA==
X-Gm-Message-State: AOJu0YzQaUSpSCSKw5n8B7DhJ9j/dI+FJqZ3FRbATb2q95z1tzRtNp0P
 w5QRihk03raQnvx9BHOiaL21b2yv+biRK8NW+LPmzOVhMxzUhiYycb5lGUr0dSYxU2+iBWXdV26
 xfrnNvczevA==
X-Gm-Gg: ASbGnctQ2bDx5HcOoaYq+vtz+A7MC8c5VFvbtfjMqVwM3qWERIJm1APhWwtD3Ei689A
 GP7TkKdy98PT31Nv377oI1KPYRcauKVG70PUav9PFy4A+1p16O1szBUrLE2YESEd6s4u2jhUJvX
 aaP9P9jGT+955oZID0Z3amX3yknE16PylLSgH2hbuvS5cPqSpfSLNbHY47i0dyA46gPO7WYhE6d
 CNxg2TcZMSvd7lu7Tfsqn+/Uvh/5oXb/db/OMxLd+3KNXpiszQVoP8SzUW1Bzt15c/I9drdBQKo
 qUMCyRGqusntNFWWLIe3w8BA2Ud+6PVgaqmOyT8yarMSALa+koMuTzaJmjiQSu3kyyqe3X56N3p
 fPBmjo2N5NZFmcimtNhtyDVejnFLD1pcsxAIMhZJGfAt3YAHEKlfI0OarRTHAHSpKatcuy0J4e3
 FPnL2Ni3nrH0jOF/bIcb74CWaP14dJyrk+F4k=
X-Google-Smtp-Source: AGHT+IEjzmN0XjhLdOPvaEBBVbNlhTlDJng2gvvPZFinAsHbstMKy8G/5GeCIAoHz3HU8ry0BH/Img==
X-Received: by 2002:a05:600c:8b65:b0:46e:42fa:ffce with SMTP id
 5b1f17b1804b1-46e6125d025mr53455535e9.2.1759417083378; 
 Thu, 02 Oct 2025 07:58:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a25dbcsm91902285e9.19.2025.10.02.07.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 07:58:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] target/riscv/monitor: Replace legacy
 cpu_physical_memory_read() call
Date: Thu,  2 Oct 2025 16:57:39 +0200
Message-ID: <20251002145742.75624-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002145742.75624-1-philmd@linaro.org>
References: <20251002145742.75624-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


