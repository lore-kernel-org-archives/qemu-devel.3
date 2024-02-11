Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3462C4829A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xj-00069d-LQ; Sun, 11 Feb 2024 07:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xg-000686-Aj
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xe-0006FH-2i
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AE24D60C3C;
 Sun, 11 Feb 2024 12:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06295C433F1;
 Sun, 11 Feb 2024 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654560;
 bh=ubbnHP6CQJX6H46ApufgbUTl/GyRa/bvBIBXu8fglok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IcXMrNV7nRA2xKAYJIIxaHMXV1znn+08SRA+2wtrCFnuFLXD7SB0LAIkDuJ7sWBf4
 cDU3yIJ6OUyMkOn9vVh4PchIxOk53o+xBxfp7JkZnhg/uU/TFRkDUv3th5P3D2R2Mj
 uZuJ7emkD/rKuuMzWIyUK8xKpBYhpQ4+1y2zIBT6r2oHtonsfQM8L9racg+ui6haa1
 n6WaomdHWzmeI4LbnyKvMWYWiL4GMhdebP7AS1h3SwTSD82w8ZQFc4MoSwcr+Uj/rS
 7dZoJcxjLM8TcsM/nv3h3IUXZOwF9pXQSIVQuoaQSZWVuCKuGMHpUj++nByi4xMNcU
 GJXzTuyLTEbXw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 04/12] hw/pci-host/astro: Implement Hard Fail and Soft Fail mode
Date: Sun, 11 Feb 2024 13:29:01 +0100
Message-ID: <20240211122909.5807-5-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The Astro/Elroy chip can work in either Hard-Fail or Soft-Fail mode.

Hard fail means the system bus will send an HPMC (=crash) to the
processor, soft fail means the system bus will ignore timeouts of
MMIO-reads or MMIO-writes and return -1ULL.

The HF mode is controlled by a bit in the status register and is usually
programmed by the OS. Return the corresponing values based on the current
value of that bit.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci-host/astro.c         | 21 +++++++++++++++------
 include/hw/pci-host/astro.h |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 96d655f5fb..e3e589ceac 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -131,15 +131,21 @@ static MemTxResult elroy_chip_read_with_attrs(void *opaque, hwaddr addr,
             if (s->iosapic_reg_select < ARRAY_SIZE(s->iosapic_reg)) {
                 val = s->iosapic_reg[s->iosapic_reg_select];
             } else {
-                val = 0;
-                ret = MEMTX_DECODE_ERROR;
+                goto check_hf;
             }
         }
         trace_iosapic_reg_read(s->iosapic_reg_select, size, val);
         break;
     default:
-        val = 0;
-        ret = MEMTX_DECODE_ERROR;
+    check_hf:
+        if (s->status_control & HF_ENABLE) {
+            val = 0;
+            ret = MEMTX_DECODE_ERROR;
+        } else {
+            /* return -1ULL if HardFail is disabled */
+            val = ~0;
+            ret = MEMTX_OK;
+        }
     }
     trace_elroy_read(addr, size, val);
 
@@ -187,7 +193,7 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
         if (s->iosapic_reg_select < ARRAY_SIZE(s->iosapic_reg)) {
             s->iosapic_reg[s->iosapic_reg_select] = val;
         } else {
-            return MEMTX_DECODE_ERROR;
+            goto check_hf;
         }
         break;
     case 0x0840:                /* IOSAPIC_REG_EOI */
@@ -200,7 +206,10 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
         }
         break;
     default:
-        return MEMTX_DECODE_ERROR;
+    check_hf:
+        if (s->status_control & HF_ENABLE) {
+            return MEMTX_DECODE_ERROR;
+        }
     }
     return MEMTX_OK;
 }
diff --git a/include/hw/pci-host/astro.h b/include/hw/pci-host/astro.h
index f63fd220f3..e2966917cd 100644
--- a/include/hw/pci-host/astro.h
+++ b/include/hw/pci-host/astro.h
@@ -27,6 +27,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ElroyState, ELROY_PCI_HOST_BRIDGE)
 #define IOS_DIST_BASE_ADDR      0xfffee00000ULL
 #define IOS_DIST_BASE_SIZE           0x10000ULL
 
+#define HF_ENABLE       0x40    /* enable HF mode (default is -1 mode) */
+
 struct AstroState;
 
 struct ElroyState {
-- 
2.43.0


