Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046BAC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoBB-0007sM-31; Tue, 30 Jul 2024 10:50:21 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1sYnDE-0005tt-Qw
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:48:27 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1sYnBj-0007YP-RN
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:48:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 43893C0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1722343760;
 bh=V+l+hMPgpSjeGnJjRXQ9Se+/zBWez49MK5BRCt63NoE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LS13GoxLrPWArJegBniHgW/BG7ArGWT7Vpe/kconv8SE9FV5zzkbbEu+/HhVa/1O/
 eGb3wkDDrOWwEi492w6u+kEWSglpyjJkgSvPhPccBnVZ7xTfEz5p1esF8ZXVeV7x6F
 dKU1PELRrdgrsD7nHQw+OgpTWzY0e4naP9bldnV1qK09JmpcZXdWZ3d6Loiv+E6vTB
 RlKM7C6To+FWH9jyMOJcEeuFDbYxMXdF4+8DGB5knLJ1wNUd0ZsfBDaJQEFJZA2Lzl
 nUTVGKzbvY/hhCroIh3x4ts5gJzxo2PLTaL1yU4+s8aTkl8POca4yR7ee59vrAQbqc
 qRwIen7jwcRgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1722343760;
 bh=V+l+hMPgpSjeGnJjRXQ9Se+/zBWez49MK5BRCt63NoE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=hSQ4uo70pPPFuSLTgU4vNdafXHCX7Eye+juAFkHs43JlGSiHr8w+Qyee5Z/9Erk+B
 NDjg+aWNh0AZ/zV1/mg1XY7Ryv+AMxRRh8OyHFfA+ODNpzcWlt/RaCJrHKSPWD72Ld
 micq4dt8g9FPG8d+7pft+yU5hMSOwcdAXxVUzkAnk/6UH3YjfDZUnOFOjO6kZ0Z4F4
 7C2jMUPp1AfF2RoX7+yZC9ZVfECZQRPws8fOs0u38jV58optmO90w0+XK11SAQYNne
 2/8XmjKusxXNDgODfC2R5UARUyRbl4b07d7nC0G2vpe1sYIl/ydfvwqz1i+6UTY83d
 YCYefvjF6Dmbw==
From: Nikita Novikov <n.novikov@syntacore.com>
To: <marcandre.lureau@redhat.com>
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, Nikita Novikov
 <n.novikov@syntacore.com>
Subject: [PATCH] hw/char/riscv_htif: Fix 64-bit var write order in 32-bit
 system
Date: Tue, 30 Jul 2024 15:49:07 +0300
Message-ID: <20240730124907.36119-1-n.novikov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=n.novikov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jul 2024 10:50:09 -0400
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

When we are trying to write 64-bit value in 32-bit system, the value in HTIF device divides
on 2 separate 32-bit parts. So device expects write to xHOST_OFFSET1 first, then to xHOST_OFFSET2.
But some compilers (ex. CLANG) can change the writing queue (xHOST_OFFSET2 first, xHOST_OFFSET1 second)
because of machine instructions order swapping. That causes wrong behaviour of HTIF device.
This patch is removing dependency of writing order, so the device will work correctly regardless of compilers.

Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
---
 hw/char/riscv_htif.c         | 43 +++++++++++++++++++-----------------
 include/hw/char/riscv_htif.h | 11 +++++++--
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 9bef60def1..d914f158ea 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -233,7 +233,8 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
         if (cmd == HTIF_CONSOLE_CMD_GETC) {
             /* this should be a queue, but not yet implemented as such */
             s->pending_read = val_written;
-            s->tohost = 0; /* clear to indicate we read */
+            s->tohost = 0;
+            s->tohost_status = 0x0;     /* clear to indicate we read */
             return;
         } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
             uint8_t ch = (uint8_t)payload;
@@ -258,7 +259,8 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
      *  }
      */
     s->fromhost = (val_written >> 48 << 48) | (resp << 16 >> 16);
-    s->tohost = 0; /* clear to indicate we read */
+    s->tohost = 0;
+    s->tohost_status = 0x0; /* clear to indicate we read */
 }
 
 #define TOHOST_OFFSET1      (s->tohost_offset)
@@ -291,32 +293,33 @@ static void htif_mm_write(void *opaque, hwaddr addr,
 {
     HTIFState *s = opaque;
     if (addr == TOHOST_OFFSET1) {
-        if (s->tohost == 0x0) {
-            s->allow_tohost = 1;
-            s->tohost = value & 0xFFFFFFFF;
-        } else {
-            s->allow_tohost = 0;
-        }
+        s->tohost = deposit64(s->tohost, 0, 32, value);
+        s->tohost_status |= 0x1;
     } else if (addr == TOHOST_OFFSET2) {
-        if (s->allow_tohost) {
-            s->tohost |= value << 32;
-            htif_handle_tohost_write(s, s->tohost);
-        }
+        s->tohost = deposit64(s->tohost, 32, 32, value);
+        s->tohost_status |= 0x2;
     } else if (addr == FROMHOST_OFFSET1) {
-        s->fromhost_inprogress = 1;
-        s->fromhost = value & 0xFFFFFFFF;
+        s->fromhost = deposit64(s->fromhost, 0, 32, value);
+        s->fromhost_status |= 0x1;
     } else if (addr == FROMHOST_OFFSET2) {
-        s->fromhost |= value << 32;
-        s->fromhost_inprogress = 0;
+        s->fromhost = deposit64(s->fromhost, 32, 32, value);
+        s->fromhost_status |= 0x2;
     } else {
-        qemu_log("Invalid htif write: address %016" PRIx64 "\n",
-            (uint64_t)addr);
+        qemu_log("Invalid htif write: address %016" HWADDR_PRIu "\n", addr);
+    }
+    if (s->tohost_status == 0x3) {
+        htif_handle_tohost_write(s, s->tohost);
+        s->tohost_status = 0x0;
     }
 }
 
 static const MemoryRegionOps htif_mm_ops = {
     .read = htif_mm_read,
     .write = htif_mm_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4
 };
 
 HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
@@ -343,8 +346,8 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
     s->tohost_offset = tohost_offset;
     s->fromhost_offset = fromhost_offset;
     s->pending_read = 0;
-    s->allow_tohost = 0;
-    s->fromhost_inprogress = 0;
+    s->tohost_status = 0;
+    s->fromhost_status = 0;
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
         htif_be_change, s, NULL, true);
diff --git a/include/hw/char/riscv_htif.h b/include/hw/char/riscv_htif.h
index df493fdf6b..2b6d50dc60 100644
--- a/include/hw/char/riscv_htif.h
+++ b/include/hw/char/riscv_htif.h
@@ -27,8 +27,15 @@
 #define TYPE_HTIF_UART "riscv.htif.uart"
 
 typedef struct HTIFState {
-    int allow_tohost;
-    int fromhost_inprogress;
+    /*
+     * Vars below can be in 4 states:
+     * 0x0 - nothing written
+     * 0x1 - xHOST_OFFEST1 written
+     * 0x2 - xHOST_OFFSET2 written
+     * 0x3 - Both written
+     */
+    int tohost_status;
+    int fromhost_status;
 
     uint64_t tohost;
     uint64_t fromhost;
-- 
2.34.1


