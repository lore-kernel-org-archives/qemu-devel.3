Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE57CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9e1-00060u-MR; Sat, 17 Oct 2026 15:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9d4-0005LB-8L; Sat, 17 Oct 2026 14:59:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9d2-0003zr-Ia; Sat, 17 Oct 2026 14:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263411; bh=i/cnUT9s/y34O8nVZIBrK2DSVdUZg+RaPsRGjem2qgs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m/EJwWvIsCqLCnrCEmXZz8Sv7XpkQnRdDGkZdZZWQFlvHD8rK1hkf/gpXzMHPdsUa
 bX3WUoZyX9h4LaAtrBigveRJCuPm36fBQ2dOLRyWBN3FXi1cdT6RSEx36Gsf2zvqNW
 qH5f6x5CpFKXS3Kvbx3Jknf2WkxsPmhtTsL0wDH41DeWFsyRsjA0sFaMsfAMql0/fA
 3WSlHq3pReBCuZF96BZgivAeP6t3HnsysaS8SjLn09h6/eiZm+62EMFi9bapLF1xA0
 PzVXLBjwRslFQggDdYbn0gKkUc2xlheeey2cKWzhZTlwtuktvRLRNatDeAZslybzmT
 TWilLnqH90CkQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6CEA61DE6CE;
 Sat, 17 Oct 2026 21:56:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 89FF0443396;
 Sat, 17 Oct 2026 21:56:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 43/63] accel/kvm: Replace legacy
 cpu_physical_memory_write() call
Date: Sat, 17 Oct 2026 21:54:59 +0300
Message-ID: <20261017185528.722197-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

cpu_physical_memory_write() is legacy (see commit b7ecba0f6f6),
replace it by address_space_write(). Both if() ladders only
differ in the address space argument: rework to have a single
address_space_write() call. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020839.19104-3-philmd@oss.qualcomm.com>
(cherry picked from commit c08b84cd6e55b7dde247a396450d49a069775235)
(Mjt: pick this one up so the next commit, which modifies this
 place again, applies cleanly)
(Mjt: drop `const' from `const AddressSpace *as' across v11.0.0-2179-g77293ecc95db
 "system/memory: Constify various MemoryRegionCache arguments")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 66783fcf11..13d44abb31 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2851,16 +2851,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
         struct kvm_coalesced_mmio_ring *ring = s->coalesced_mmio_ring;
         while (ring->first != ring->last) {
             struct kvm_coalesced_mmio *ent;
+            AddressSpace *as;
 
             ent = &ring->coalesced_mmio[ring->first];
-
-            if (ent->pio == 1) {
-                address_space_write(&address_space_io, ent->phys_addr,
-                                    MEMTXATTRS_UNSPECIFIED, ent->data,
-                                    ent->len);
-            } else {
-                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
-            }
+            as = ent->pio == 1 ? &address_space_io : &address_space_memory;
+            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
+                                ent->data, ent->len);
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
-- 
2.47.3


