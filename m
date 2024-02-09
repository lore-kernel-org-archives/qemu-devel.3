Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67EAC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPUy-0003Yc-3H; Fri, 09 Feb 2024 06:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPUt-0003Vg-OX
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:47 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPUr-0002PO-7S
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EE13D62063;
 Fri,  9 Feb 2024 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2ABC433F1;
 Fri,  9 Feb 2024 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707479801;
 bh=eKd3LfJAQ+UZw+rrOrT83UdSOdoxCGW0LqJcz2pG0sA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HHRYkUSAHdrIKhs5JC4/f+pbOd6j+d+WG1S6qp7JXZuuQP6tf9ojDGbtudlzWWao3
 58UVQ30VqVIqeKCNknDCs/AkHMtGG+qB/ZTiVwVxHotZeEiSgayR4IOlgUF0l4n0UF
 U0RUJDoTZ+vRdhtp8mq9m9DWL4TZfUEqSzYpwEsNzB40yRF2L2OMRdj0pnMBcsKqjd
 c8Eb80nFwrxLR2H3UeT8UzCIiCJIyIEeUhwxBM7VG1E1LbM2kwDhlmqR4KelRxkDe+
 j2T/5qNomd9ZbIM9b5Xzsu+rYfxKv/0rgQ0TDU+UVGqGSB6JDFc5ZOj2Ni7O3zOtR7
 XETb00ObNoQ4Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 03/12] hw/pci-host/astro: Avoid aborting on access failure
Date: Fri,  9 Feb 2024 12:56:24 +0100
Message-ID: <20240209115633.55823-4-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209115633.55823-1-deller@kernel.org>
References: <20240209115633.55823-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Instead of stopping the emulation, report a MEMTX_DECODE_ERROR if the OS
tries to access non-existent registers.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 37d271118c..96d655f5fb 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -122,10 +122,6 @@ static MemTxResult elroy_chip_read_with_attrs(void *opaque, hwaddr addr,
     case 0x0800:                /* IOSAPIC_REG_SELECT */
         val = s->iosapic_reg_select;
         break;
-    case 0x0808:
-        val = UINT64_MAX;            /* XXX: tbc. */
-        g_assert_not_reached();
-        break;
     case 0x0810:                /* IOSAPIC_REG_WINDOW */
         switch (s->iosapic_reg_select) {
         case 0x01:              /* IOSAPIC_REG_VERSION */
@@ -135,15 +131,15 @@ static MemTxResult elroy_chip_read_with_attrs(void *opaque, hwaddr addr,
             if (s->iosapic_reg_select < ARRAY_SIZE(s->iosapic_reg)) {
                 val = s->iosapic_reg[s->iosapic_reg_select];
             } else {
-                trace_iosapic_reg_read(s->iosapic_reg_select, size, val);
-                g_assert_not_reached();
+                val = 0;
+                ret = MEMTX_DECODE_ERROR;
             }
         }
         trace_iosapic_reg_read(s->iosapic_reg_select, size, val);
         break;
     default:
-        trace_elroy_read(addr, size, val);
-        g_assert_not_reached();
+        val = 0;
+        ret = MEMTX_DECODE_ERROR;
     }
     trace_elroy_read(addr, size, val);
 
@@ -191,7 +187,7 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
         if (s->iosapic_reg_select < ARRAY_SIZE(s->iosapic_reg)) {
             s->iosapic_reg[s->iosapic_reg_select] = val;
         } else {
-            g_assert_not_reached();
+            return MEMTX_DECODE_ERROR;
         }
         break;
     case 0x0840:                /* IOSAPIC_REG_EOI */
@@ -204,7 +200,7 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
         }
         break;
     default:
-        g_assert_not_reached();
+        return MEMTX_DECODE_ERROR;
     }
     return MEMTX_OK;
 }
@@ -594,8 +590,8 @@ static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
 #undef EMPTY_PORT
 
     default:
-        trace_astro_chip_read(addr, size, val);
-        g_assert_not_reached();
+        val = 0;
+        ret = MEMTX_DECODE_ERROR;
     }
 
     /* for 32-bit accesses mask return value */
@@ -610,6 +606,7 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
                                               uint64_t val, unsigned size,
                                               MemTxAttrs attrs)
 {
+    MemTxResult ret = MEMTX_OK;
     AstroState *s = opaque;
 
     trace_astro_chip_write(addr, size, val);
@@ -686,11 +683,9 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
 #undef EMPTY_PORT
 
     default:
-        /* Controlled by astro_chip_mem_valid above.  */
-        trace_astro_chip_write(addr, size, val);
-        g_assert_not_reached();
+        ret = MEMTX_DECODE_ERROR;
     }
-    return MEMTX_OK;
+    return ret;
 }
 
 static const MemoryRegionOps astro_chip_ops = {
-- 
2.43.0


