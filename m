Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D96C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBhh-0004NN-Dr; Wed, 14 May 2025 08:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhG-0003lJ-L9; Wed, 14 May 2025 08:58:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhE-0007rW-Hq; Wed, 14 May 2025 08:58:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 33483121AE3;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D31F620B851;
 Wed, 14 May 2025 15:57:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 05/34] target/mips: Revert TARGET_PAGE_BITS_VARY
Date: Wed, 14 May 2025 15:57:27 +0300
Message-Id: <20250514125758.92030-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Revert ee3863b9d41 and a08d60bc6c2b.  The logic behind changing
the system page size because of what the Loongson kernel "prefers"
is flawed.

In the Loongson-2E manual, section 5.5, it is clear that the cpu
supports a 4k page size (along with many others).  Similarly for
the Loongson-3 series CPUs, the 4k page size is mentioned in the
section 7.7 (PageMask Register).  Therefore we must continue to
support a 4k page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250328175526.368121-2-richard.henderson@linaro.org>
[PMD: Mention Loongson-3 series CPUs]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit fca2817fdcb00e65020c2dcfcb0b23b2a20ea3c4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 7fd8296ccb..7124f1893f 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -333,7 +333,6 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
-    mc->minimum_page_bits = 14;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f3b6326cc5..bb8e1ab2e5 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -670,7 +670,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = LOONGSON_MAX_VCPUS;
     mc->default_ram_id = "loongson3.highram";
     mc->default_ram_size = 1600 * MiB;
-    mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
 }
 
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index f3a37e2dbe..26b7e4ceba 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -23,12 +23,7 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
-#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
-#else
-#define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
-#endif
 
 #define TCG_GUEST_DEFAULT_MO (0)
 
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index 79a5c833ce..fb394bf0ed 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -877,18 +877,13 @@ void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
     if ((mask >> maskbits) != 0) {
         goto invalid;
     }
-    /* We don't support VTLB entry smaller than target page */
-    if ((maskbits + TARGET_PAGE_BITS_MIN) < TARGET_PAGE_BITS) {
-        goto invalid;
-    }
     env->CP0_PageMask = mask << CP0PM_MASK;
 
     return;
 
 invalid:
     /* When invalid, set to default target page size. */
-    mask = (~TARGET_PAGE_MASK >> TARGET_PAGE_BITS_MIN);
-    env->CP0_PageMask = mask << CP0PM_MASK;
+    env->CP0_PageMask = 0;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index e98bb95951..62a3a86d80 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -874,7 +874,7 @@ refill:
             break;
         }
     }
-    pw_pagemask = m >> TARGET_PAGE_BITS_MIN;
+    pw_pagemask = m >> TARGET_PAGE_BITS;
     update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
-- 
2.39.5


