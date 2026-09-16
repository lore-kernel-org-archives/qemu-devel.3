Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CC4C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6k8L-0002Tw-Mr; Wed, 16 Sep 2026 03:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1x6k8K-0002Tn-JT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:32:44 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1x6k8J-0003QN-2o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:32:44 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 46e09a7af769-80a6fbf797dso141818a34.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1789543951; x=1790148751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VsHLsYo9PjIwrfm9IhZPcrhpy7+xxZmiTGTP+zvPlqo=;
 b=QSXlR73SFoaxNve4IRPpfKxoDjTB8lqbVjS27CTMEPCcXOpy6GSw4MogpK9qXD2LU6
 wlVih/bdvNjxNkVPnBIqqJkuUWC0yib7MbL8av5zkrFcMht6YCtnIXXDO+wp/fe2iQPe
 06qhu7+BUB7pgeUKGxnDWx/I63m57F3c0pyDL7JExTcRz//SMGHJYpH0/FHBxR2prDG7
 RO18P/vtnmFSegU/hBnpO3nM0b0dWUDDvcpmWI4tFfyRoCCCw9+9vswINTFnWz0Y0Xc2
 T6TN5Vj5KfkNKv+r9YMndxWlwKHBD1JzAGBGJafpOp1Aqrr4ppJnGrJf14F9+eAGglfz
 0xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789543951; x=1790148751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VsHLsYo9PjIwrfm9IhZPcrhpy7+xxZmiTGTP+zvPlqo=;
 b=yp2DOyliRrckPzrenTxnSM1LlXn69wqbrrbryD+S2hQniRcvWpr8pUUX7s4KjYhuVD
 YS5o67IuPKSIJ+z0Jide7hRbGCeQAfMZbINy8JRklIFr0eP/SadWFpsRZgOmfdLzuVSS
 eI2h415O/40PsrXTS0gn7YrZ3pXIdmMX/pNABCs4XdMz1MM9dhMVYghFUoIQX+H9BPIM
 I6A889236RcW2BdGkVx6XiC+Vc9Ctz/qq4Rt/OwgW9DENeMD4oZa8+yRKgwRgEABMK+R
 DrvWzbXms1upea2oo/bFkd9co3N5eejpxfbbEiEQlqsc7w0Si27ZGrs5ZPY3a8oQbnDG
 QojQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwve+ysP4Ih1sU3kYtdaqg6vb27blTEdTGZYVWZfmfPZ5AECklYkt3ekMqqvj9Bs37PzjgN8dCIYn3+@nongnu.org
X-Gm-Message-State: AFuF++nIyxcEibvLcNX3g1Vk3M07arf1HWAiuLySPFAclLkQg32Z3MZS
 a7U6V3Ty4vpuqI2AsiQK/vJIuIlyhc8evS+f0e565F25NbFboQ+/4UqqMo4Tu0yF/TE=
X-Gm-Gg: AYBFou15m/n73Xm7R5biYRJO05xlPfFkN4m40oGicv/JzNqnfb9/rE+7oHmHa09nvcb
 bTFl2f1cwKSS+7GAHmh3WLYzWb7Gigw6FJQgASj0nmd3V7uNXpZMvr8wPZG7l/RNOYFiYVn+qUB
 G6ZGpyP+ltDY6csVt10R15gUa8jLOn0Zn5yChAV/cBDp17MOrvM48+4SvQC2TYK8D7ymxgoSLMb
 4ETdbaR9DEHU+uNcJvYIRk64XDuYkro4zFvUdKGuJ8Ixg80TaAw4gjQckoPfIpJuWenyEUy0OtT
 XuWGJaigzHYXoxJxDT2qN6C2N0C23Fv862Bfh2O5lcnY5UEJWhfdns2ibKB5Yd9oUf/R/WXPe7O
 dvpzoCQUWM2Se3CVzwqVh8EfC11mEjE1wsfFqAjRzodQ9GQfCrnlnChILA0X27t3WL0NqLlczS5
 +lrz99ZxmALi3IcPTJUT64CI3ZUKQFtDglconxaF4ka2yFUFMZITLh/Bdx9AXyOSgo0FmGRzSir
 2VCAmKePvFG1xd3o7MNR+Yj/scG581n
X-Received: by 2002:a05:6830:6385:b0:805:b4a8:724e with SMTP id
 46e09a7af769-80b363a986cmr1332250a34.6.1789543951115; 
 Wed, 16 Sep 2026 00:32:31 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80b06cb8c77sm1906282a34.11.2026.09.16.00.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 00:32:29 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH] accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
Date: Wed, 16 Sep 2026 07:32:09 +0000
Message-Id: <20260916073209.1791732-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=antonb@tenstorrent.com; helo=mail-oo2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Update tlb_plugin_lookup() to check TLB_MMIO in slow_flags when
TLB_FORCE_SLOW is set.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 accel/tcg/cputlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f7c208ba1..7150d6d126 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1593,7 +1593,8 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
-    if (tlb_addr & TLB_MMIO) {
+    if ((tlb_addr & TLB_FORCE_SLOW) &&
+        (full->slow_flags[access_type] & TLB_MMIO)) {
         MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
-- 
2.34.1


