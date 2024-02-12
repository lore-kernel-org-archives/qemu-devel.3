Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E10BC4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 23:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZg1a-0003Ck-Ju; Mon, 12 Feb 2024 18:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1X-0003By-Dg
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:43 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1R-00007n-4I
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 41673CE17BB;
 Mon, 12 Feb 2024 23:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FF0C433F1;
 Mon, 12 Feb 2024 23:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707781653;
 bh=ubbnHP6CQJX6H46ApufgbUTl/GyRa/bvBIBXu8fglok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tg+uNbCFBdhUB4HPlfR2U4IIkLWfOS6kU9vfMc5yvBshYN2i3lo41ldE1o3TX0AfA
 bHcZz+d0Ly52l7QB+6pBhorvO68M92enzTcdJ3tfRDEMrEsfOguDOvGOdXKqMFU+/C
 plXYr7qlqawfEqdKj2jQ3M3om5Rhl+5osyMyz16WUwj1sQvAZksZ/KquOQvQyZi6sL
 +WeIfDeNzW3mY7/8eUQUMPGubplDzeTAqwsc3J/SSn1/5Os6aMVJEVHvN08MEoWOmS
 f2D133jYXfCX0KCiDTiTEz8vZALLFmvSgUZQHgQJwXQs/ypfJJ+ACFhOkFYJ5XSanR
 YX9HusgIu+f9Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 04/12] hw/pci-host/astro: Implement Hard Fail and Soft Fail mode
Date: Tue, 13 Feb 2024 00:47:15 +0100
Message-ID: <20240212234723.222847-5-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212234723.222847-1-deller@kernel.org>
References: <20240212234723.222847-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


