Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9EFC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXG-0004ho-Pl; Wed, 07 Feb 2024 13:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXF-0004hA-CF
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:37 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXD-00086J-NG
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A191961A17;
 Wed,  7 Feb 2024 18:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82738C43390;
 Wed,  7 Feb 2024 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330033;
 bh=x2QqFV0OrTV+B0MBMSpUKn1JRbPiQZhKDBTVpogYAiY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tC54nD+38Adey29kFuNhnmdIp4Y/T1zUYpzutCuYTOCIRY2b84wEknq6WZh04w7fi
 zJcwMiVjgX0OCNuz0KJ0aX27sKa7HtdZquux4MZZaKUSLIwwDNETOPP7ebAYT2WiMi
 BEfu+JQX5zeXQlmkPfTqAtkfZbyn3j8aT8VoM7hnLD/tydP7Ve2yoHDD/pNTbJj9fy
 UyyW24u8yoAl2Y2YqaZpGMlfql/89IpB4hMD84vXDnoMKv5imogeIa7z8Ca9tfKHsv
 5zIXzfLzyHG4oE9eJc11on5sA7JgvBbmjX85O4JjSgTnPQ/S8RO2E57BebT30W7LT0
 5cqGqQga0IZ+g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 05/13] hw/pci-host/astro: Implement Hard Fail and Soft Fail
 mode
Date: Wed,  7 Feb 2024 19:20:15 +0100
Message-ID: <20240207182023.36316-6-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

The Astro/Elroy chip can work in either Hard-Fail or Soft-Fail mode.

Hard fail means the system bus will send an HPMC (=crash) to the
processor, soft fail means the system bus will ignore timeouts of
MMIO-reads or MMIO-writes and return -1ULL.

The HF mode is controlled by a bit in the status register and is usually
programmed by the OS. Return the corresponing values based on the current
value of that bit.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c         | 23 +++++++++++++++++------
 include/hw/pci-host/astro.h |  2 ++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 42bd65de53..39549df3f5 100644
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
 
@@ -188,7 +194,7 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
         if (s->iosapic_reg_select < ARRAY_SIZE(s->iosapic_reg)) {
             s->iosapic_reg[s->iosapic_reg_select] = val;
         } else {
-            ret = MEMTX_DECODE_ERROR;
+            goto check_hf;
         }
         break;
     case 0x0840:                /* IOSAPIC_REG_EOI */
@@ -201,7 +207,12 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
         }
         break;
     default:
-        ret = MEMTX_DECODE_ERROR;
+    check_hf:
+        if (s->status_control & HF_ENABLE) {
+            ret = MEMTX_DECODE_ERROR;
+        } else {
+            ret = MEMTX_OK;
+        }
     }
     return ret;
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


