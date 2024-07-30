Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43524C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoB7-0007fI-75; Tue, 30 Jul 2024 10:50:18 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1sYmG4-0005oc-Ie
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:47:25 -0400
Received: from [89.207.88.248] (helo=mta-04.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1sYmEv-00089X-6H
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:47:06 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 7FE2BC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1722342981;
 bh=V+l+hMPgpSjeGnJjRXQ9Se+/zBWez49MK5BRCt63NoE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=nh6nwHJgdJp4nDGKt2I2qIzmpw1Tc1nFbwgC4mQzxFU8JP4/o46gBZdmbt26LDBOp
 cw6S2KvZyqo5NJgMSIY5dpQOuu07Ttpdb59RBVw3i2azs/dPUjOguc7qffeFPcz8pX
 Lpxkx3yLmheVqH8bxLs2U5n/eQBEhYqeeW/+yaQUuqx3OuTBPcCJVoQtroxtGoNkvn
 YfT8a6+8sqmA2qlj6ydLn2rUgaOqNLUlGvi2lDoL3+4OLrCznvSgRmrVQSoOhLbNHF
 0zBqk4xfpnOK/BWiC+ajXP5v9oPguPZKYAGr0y4mNDtiTmAXDwnOm3YeCQxiemlN+r
 Ur+qvXSqydtYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1722342981;
 bh=V+l+hMPgpSjeGnJjRXQ9Se+/zBWez49MK5BRCt63NoE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=e71ss90Swa8jC8r2k2hWxQM8duJxzuhS1doTgU7siZG0MUJZocsenz075L0+oub7z
 MFGuT7iATB71lv1d1+l1B7Yt3ogG7eg2VdfcZCxeo4uWh6SFTaDcOL2RntePyRHKeB
 W5zh80bJwUmWxjwSROyW2Iife6loj4WzHIOP7sskWfFKzJ706mepGRENxX9j++J8vL
 MpA8qMKNma7+NpOj2k+Tw67d+tSjQlF3c84gTgZYCQXjyknVoEMUfUH27YibjwLPxm
 eIyQMPU8PVYYJcvKDTN1Qpx5FtDj8Ip9B84YjkxZelah5I3qEAdC6/rHZR2r8WtvQI
 3eGnvRGl9aEUg==
From: Nikita Novikov <n.novikov@syntacore.com>
To: <lureau@redhat.com>
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, Nikita Novikov
 <n.novikov@syntacore.com>
Subject: [PATCH] hw/char/riscv_htif: Fix 64-bit var write order in 32-bit
 system
Date: Tue, 30 Jul 2024 15:35:59 +0300
Message-ID: <20240730123559.35115-1-n.novikov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 89.207.88.248 (deferred)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=n.novikov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


