Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ECDCCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSp8-0000YW-Ic; Wed, 22 Oct 2025 02:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSp5-0000V7-VR
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSp2-0008NL-2L
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqVV/DhfUVmiAsOuDOS5NZyZJD1edNdISD6WpYTmcrA=;
 b=UwEUmo95hJotrrkT6ALlm2QZ1TKdRawELoTD+ylueUnuAVjzBK4gr7+8wpDBWlxR/ekvR5
 I3JtvKAOvXA/0MmQ/vJmnrD0wMcc6QjFCIKRsRTq5vPdrVuaj6ZnFlofDKmRmJqnT08+Sr
 XhHq3WnZIdUyMXUxKDZ75Oe2sWw8ZLI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-QqFVV9VTPQqqHsJrMUo_fQ-1; Wed,
 22 Oct 2025 02:59:42 -0400
X-MC-Unique: QqFVV9VTPQqqHsJrMUo_fQ-1
X-Mimecast-MFC-AGG-ID: QqFVV9VTPQqqHsJrMUo_fQ_1761116381
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 793AC1805C28; Wed, 22 Oct 2025 06:59:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60B3D3000225; Wed, 22 Oct 2025 06:59:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 31/42] hw/audio: replace AUD_log() usage
Date: Wed, 22 Oct 2025 10:56:26 +0400
Message-ID: <20251022065640.1172785-32-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

AUD_log() is just printf(stderr, "prefix: "..), we can use
error_report() or warn_report() appropriately instead.

Ideally it should be converted to traces, but there are many places to
convert, this is left for another day.

Avoid bit-rot by using conditionals.

The patch could be splitted if necessary.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/ac97.c    | 120 ++++++++++++++++++++++-----------------------
 hw/audio/adlib.c   |  20 +++-----
 hw/audio/cs4231a.c |  40 +++++++--------
 hw/audio/es1370.c  |  24 ++++-----
 hw/audio/gus.c     |  21 ++++----
 hw/audio/pcspk.c   |   2 +-
 hw/audio/sb16.c    |  93 +++++++++++++++++------------------
 7 files changed, 151 insertions(+), 169 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 9157588dbc..1b2ce601a6 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "system/dma.h"
 #include "qom/object.h"
+#include "qemu/error-report.h"
 #include "ac97.h"
 
 #define SOFT_VOLUME
@@ -141,11 +142,8 @@ enum {
     BUP_LAST = 2
 };
 
-#ifdef DEBUG_AC97
-#define dolog(...) AUD_log("ac97", __VA_ARGS__)
-#else
-#define dolog(...)
-#endif
+#define DEBUG_AC97 0
+#define dolog(fmt, ...) do { if (DEBUG_AC97) error_report("ac97: " fmt, ##__VA_ARGS__); } while (0)
 
 #define MKREGS(prefix, start)                   \
 enum {                                          \
@@ -190,7 +188,7 @@ static void fetch_bd(AC97LinkState *s, AC97BusMasterRegs *r)
     r->bd.addr = le32_to_cpu(*(uint32_t *) &b[0]) & ~3;
     r->bd.ctl_len = le32_to_cpu(*(uint32_t *) &b[4]);
     r->picb = r->bd.ctl_len & 0xffff;
-    dolog("bd %2d addr=0x%x ctl=0x%06x len=0x%x(%d bytes)\n",
+    dolog("bd %2d addr=0x%x ctl=0x%06x len=0x%x(%d bytes)",
           r->civ, r->bd.addr, r->bd.ctl_len >> 16,
           r->bd.ctl_len & 0xffff, (r->bd.ctl_len & 0xffff) << 1);
 }
@@ -222,7 +220,7 @@ static void update_sr(AC97LinkState *s, AC97BusMasterRegs *r, uint32_t new_sr)
 
     r->sr = new_sr;
 
-    dolog("IOC%d LVB%d sr=0x%x event=%d level=%d\n",
+    dolog("IOC%d LVB%d sr=0x%x event=%d level=%d",
           r->sr & SR_BCIS, r->sr & SR_LVBCI, r->sr, event, level);
 
     if (!event) {
@@ -231,11 +229,11 @@ static void update_sr(AC97LinkState *s, AC97BusMasterRegs *r, uint32_t new_sr)
 
     if (level) {
         s->glob_sta |= masks[r - s->bm_regs];
-        dolog("set irq level=1\n");
+        dolog("set irq level=1");
         pci_irq_assert(&s->dev);
     } else {
         s->glob_sta &= ~masks[r - s->bm_regs];
-        dolog("set irq level=0\n");
+        dolog("set irq level=0");
         pci_irq_deassert(&s->dev);
     }
 }
@@ -256,14 +254,14 @@ static void voice_set_active(AC97LinkState *s, int bm_index, int on)
         break;
 
     default:
-        AUD_log("ac97", "invalid bm_index(%d) in voice_set_active", bm_index);
+        error_report("ac97: invalid bm_index(%d) in voice_set_active", bm_index);
         break;
     }
 }
 
 static void reset_bm_regs(AC97LinkState *s, AC97BusMasterRegs *r)
 {
-    dolog("reset_bm_regs\n");
+    dolog("reset_bm_regs");
     r->bdbar = 0;
     r->civ = 0;
     r->lvi = 0;
@@ -281,7 +279,7 @@ static void reset_bm_regs(AC97LinkState *s, AC97BusMasterRegs *r)
 static void mixer_store(AC97LinkState *s, uint32_t i, uint16_t v)
 {
     if (i + 2 > sizeof(s->mixer_data)) {
-        dolog("mixer_store: index %d out of bounds %zd\n",
+        dolog("mixer_store: index %d out of bounds %zd",
               i, sizeof(s->mixer_data));
         return;
     }
@@ -295,7 +293,7 @@ static uint16_t mixer_load(AC97LinkState *s, uint32_t i)
     uint16_t val = 0xffff;
 
     if (i + 2 > sizeof(s->mixer_data)) {
-        dolog("mixer_load: index %d out of bounds %zd\n",
+        dolog("mixer_load: index %d out of bounds %zd",
               i, sizeof(s->mixer_data));
     } else {
         val = s->mixer_data[i + 0] | (s->mixer_data[i + 1] << 8);
@@ -460,7 +458,7 @@ static void mixer_reset(AC97LinkState *s)
 {
     uint8_t active[LAST_INDEX];
 
-    dolog("mixer_reset\n");
+    dolog("mixer_reset");
     memset(s->mixer_data, 0, sizeof(s->mixer_data));
     memset(active, 0, sizeof(active));
     mixer_store(s, AC97_Reset, 0x0000); /* 6940 */
@@ -508,7 +506,7 @@ static void mixer_reset(AC97LinkState *s)
 static uint32_t nam_readb(void *opaque, uint32_t addr)
 {
     AC97LinkState *s = opaque;
-    dolog("U nam readb 0x%x\n", addr);
+    dolog("U nam readb 0x%x", addr);
     s->cas = 0;
     return ~0U;
 }
@@ -523,7 +521,7 @@ static uint32_t nam_readw(void *opaque, uint32_t addr)
 static uint32_t nam_readl(void *opaque, uint32_t addr)
 {
     AC97LinkState *s = opaque;
-    dolog("U nam readl 0x%x\n", addr);
+    dolog("U nam readl 0x%x", addr);
     s->cas = 0;
     return ~0U;
 }
@@ -535,7 +533,7 @@ static uint32_t nam_readl(void *opaque, uint32_t addr)
 static void nam_writeb(void *opaque, uint32_t addr, uint32_t val)
 {
     AC97LinkState *s = opaque;
-    dolog("U nam writeb 0x%x <- 0x%x\n", addr, val);
+    dolog("U nam writeb 0x%x <- 0x%x", addr, val);
     s->cas = 0;
 }
 
@@ -563,10 +561,10 @@ static void nam_writew(void *opaque, uint32_t addr, uint32_t val)
         break;
     case AC97_Vendor_ID1:
     case AC97_Vendor_ID2:
-        dolog("Attempt to write vendor ID to 0x%x\n", val);
+        dolog("Attempt to write vendor ID to 0x%x", val);
         break;
     case AC97_Extended_Audio_ID:
-        dolog("Attempt to write extended audio ID to 0x%x\n", val);
+        dolog("Attempt to write extended audio ID to 0x%x", val);
         break;
     case AC97_Extended_Audio_Ctrl_Stat:
         if (!(val & EACS_VRA)) {
@@ -579,36 +577,36 @@ static void nam_writew(void *opaque, uint32_t addr, uint32_t val)
             mixer_store(s, AC97_MIC_ADC_Rate, 0xbb80);
             open_voice(s, MC_INDEX, 48000);
         }
-        dolog("Setting extended audio control to 0x%x\n", val);
+        dolog("Setting extended audio control to 0x%x", val);
         mixer_store(s, AC97_Extended_Audio_Ctrl_Stat, val);
         break;
     case AC97_PCM_Front_DAC_Rate:
         if (mixer_load(s, AC97_Extended_Audio_Ctrl_Stat) & EACS_VRA) {
             mixer_store(s, addr, val);
-            dolog("Set front DAC rate to %d\n", val);
+            dolog("Set front DAC rate to %d", val);
             open_voice(s, PO_INDEX, val);
         } else {
-            dolog("Attempt to set front DAC rate to %d, but VRA is not set\n",
+            dolog("Attempt to set front DAC rate to %d, but VRA is not set",
                   val);
         }
         break;
     case AC97_MIC_ADC_Rate:
         if (mixer_load(s, AC97_Extended_Audio_Ctrl_Stat) & EACS_VRM) {
             mixer_store(s, addr, val);
-            dolog("Set MIC ADC rate to %d\n", val);
+            dolog("Set MIC ADC rate to %d", val);
             open_voice(s, MC_INDEX, val);
         } else {
-            dolog("Attempt to set MIC ADC rate to %d, but VRM is not set\n",
+            dolog("Attempt to set MIC ADC rate to %d, but VRM is not set",
                   val);
         }
         break;
     case AC97_PCM_LR_ADC_Rate:
         if (mixer_load(s, AC97_Extended_Audio_Ctrl_Stat) & EACS_VRA) {
             mixer_store(s, addr, val);
-            dolog("Set front LR ADC rate to %d\n", val);
+            dolog("Set front LR ADC rate to %d", val);
             open_voice(s, PI_INDEX, val);
         } else {
-            dolog("Attempt to set LR ADC rate to %d, but VRA is not set\n",
+            dolog("Attempt to set LR ADC rate to %d, but VRA is not set",
                   val);
         }
         break;
@@ -630,7 +628,7 @@ static void nam_writew(void *opaque, uint32_t addr, uint32_t val)
         /* None of the features in these regs are emulated, so they are RO */
         break;
     default:
-        dolog("U nam writew 0x%x <- 0x%x\n", addr, val);
+        dolog("U nam writew 0x%x <- 0x%x", addr, val);
         mixer_store(s, addr, val);
         break;
     }
@@ -639,7 +637,7 @@ static void nam_writew(void *opaque, uint32_t addr, uint32_t val)
 static void nam_writel(void *opaque, uint32_t addr, uint32_t val)
 {
     AC97LinkState *s = opaque;
-    dolog("U nam writel 0x%x <- 0x%x\n", addr, val);
+    dolog("U nam writel 0x%x <- 0x%x", addr, val);
     s->cas = 0;
 }
 
@@ -655,7 +653,7 @@ static uint32_t nabm_readb(void *opaque, uint32_t addr)
 
     switch (addr) {
     case CAS:
-        dolog("CAS %d\n", s->cas);
+        dolog("CAS %d", s->cas);
         val = s->cas;
         s->cas = 1;
         break;
@@ -664,38 +662,38 @@ static uint32_t nabm_readb(void *opaque, uint32_t addr)
     case MC_CIV:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->civ;
-        dolog("CIV[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("CIV[%d] -> 0x%x", GET_BM(addr), val);
         break;
     case PI_LVI:
     case PO_LVI:
     case MC_LVI:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->lvi;
-        dolog("LVI[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("LVI[%d] -> 0x%x", GET_BM(addr), val);
         break;
     case PI_PIV:
     case PO_PIV:
     case MC_PIV:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->piv;
-        dolog("PIV[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("PIV[%d] -> 0x%x", GET_BM(addr), val);
         break;
     case PI_CR:
     case PO_CR:
     case MC_CR:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->cr;
-        dolog("CR[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("CR[%d] -> 0x%x", GET_BM(addr), val);
         break;
     case PI_SR:
     case PO_SR:
     case MC_SR:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->sr & 0xff;
-        dolog("SRb[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("SRb[%d] -> 0x%x", GET_BM(addr), val);
         break;
     default:
-        dolog("U nabm readb 0x%x -> 0x%x\n", addr, val);
+        dolog("U nabm readb 0x%x -> 0x%x", addr, val);
         break;
     }
     return val;
@@ -713,17 +711,17 @@ static uint32_t nabm_readw(void *opaque, uint32_t addr)
     case MC_SR:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->sr;
-        dolog("SR[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("SR[%d] -> 0x%x", GET_BM(addr), val);
         break;
     case PI_PICB:
     case PO_PICB:
     case MC_PICB:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->picb;
-        dolog("PICB[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("PICB[%d] -> 0x%x", GET_BM(addr), val);
         break;
     default:
-        dolog("U nabm readw 0x%x -> 0x%x\n", addr, val);
+        dolog("U nabm readw 0x%x -> 0x%x", addr, val);
         break;
     }
     return val;
@@ -741,14 +739,14 @@ static uint32_t nabm_readl(void *opaque, uint32_t addr)
     case MC_BDBAR:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->bdbar;
-        dolog("BMADDR[%d] -> 0x%x\n", GET_BM(addr), val);
+        dolog("BMADDR[%d] -> 0x%x", GET_BM(addr), val);
         break;
     case PI_CIV:
     case PO_CIV:
     case MC_CIV:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->civ | (r->lvi << 8) | (r->sr << 16);
-        dolog("CIV LVI SR[%d] -> 0x%x, 0x%x, 0x%x\n", GET_BM(addr),
+        dolog("CIV LVI SR[%d] -> 0x%x, 0x%x, 0x%x", GET_BM(addr),
                r->civ, r->lvi, r->sr);
         break;
     case PI_PICB:
@@ -756,19 +754,19 @@ static uint32_t nabm_readl(void *opaque, uint32_t addr)
     case MC_PICB:
         r = &s->bm_regs[GET_BM(addr)];
         val = r->picb | (r->piv << 16) | (r->cr << 24);
-        dolog("PICB PIV CR[%d] -> 0x%x 0x%x 0x%x 0x%x\n", GET_BM(addr),
+        dolog("PICB PIV CR[%d] -> 0x%x 0x%x 0x%x 0x%x", GET_BM(addr),
                val, r->picb, r->piv, r->cr);
         break;
     case GLOB_CNT:
         val = s->glob_cnt;
-        dolog("glob_cnt -> 0x%x\n", val);
+        dolog("glob_cnt -> 0x%x", val);
         break;
     case GLOB_STA:
         val = s->glob_sta | GS_S0CR;
-        dolog("glob_sta -> 0x%x\n", val);
+        dolog("glob_sta -> 0x%x", val);
         break;
     default:
-        dolog("U nabm readl 0x%x -> 0x%x\n", addr, val);
+        dolog("U nabm readl 0x%x -> 0x%x", addr, val);
         break;
     }
     return val;
@@ -795,7 +793,7 @@ static void nabm_writeb(void *opaque, uint32_t addr, uint32_t val)
             fetch_bd(s, r);
         }
         r->lvi = val % 32;
-        dolog("LVI[%d] <- 0x%x\n", GET_BM(addr), val);
+        dolog("LVI[%d] <- 0x%x", GET_BM(addr), val);
         break;
     case PI_CR:
     case PO_CR:
@@ -816,7 +814,7 @@ static void nabm_writeb(void *opaque, uint32_t addr, uint32_t val)
                 voice_set_active(s, r - s->bm_regs, 1);
             }
         }
-        dolog("CR[%d] <- 0x%x (cr 0x%x)\n", GET_BM(addr), val, r->cr);
+        dolog("CR[%d] <- 0x%x (cr 0x%x)", GET_BM(addr), val, r->cr);
         break;
     case PI_SR:
     case PO_SR:
@@ -824,10 +822,10 @@ static void nabm_writeb(void *opaque, uint32_t addr, uint32_t val)
         r = &s->bm_regs[GET_BM(addr)];
         r->sr |= val & ~(SR_RO_MASK | SR_WCLEAR_MASK);
         update_sr(s, r, r->sr & ~(val & SR_WCLEAR_MASK));
-        dolog("SR[%d] <- 0x%x (sr 0x%x)\n", GET_BM(addr), val, r->sr);
+        dolog("SR[%d] <- 0x%x (sr 0x%x)", GET_BM(addr), val, r->sr);
         break;
     default:
-        dolog("U nabm writeb 0x%x <- 0x%x\n", addr, val);
+        dolog("U nabm writeb 0x%x <- 0x%x", addr, val);
         break;
     }
 }
@@ -844,10 +842,10 @@ static void nabm_writew(void *opaque, uint32_t addr, uint32_t val)
         r = &s->bm_regs[GET_BM(addr)];
         r->sr |= val & ~(SR_RO_MASK | SR_WCLEAR_MASK);
         update_sr(s, r, r->sr & ~(val & SR_WCLEAR_MASK));
-        dolog("SR[%d] <- 0x%x (sr 0x%x)\n", GET_BM(addr), val, r->sr);
+        dolog("SR[%d] <- 0x%x (sr 0x%x)", GET_BM(addr), val, r->sr);
         break;
     default:
-        dolog("U nabm writew 0x%x <- 0x%x\n", addr, val);
+        dolog("U nabm writew 0x%x <- 0x%x", addr, val);
         break;
     }
 }
@@ -863,22 +861,22 @@ static void nabm_writel(void *opaque, uint32_t addr, uint32_t val)
     case MC_BDBAR:
         r = &s->bm_regs[GET_BM(addr)];
         r->bdbar = val & ~3;
-        dolog("BDBAR[%d] <- 0x%x (bdbar 0x%x)\n", GET_BM(addr), val, r->bdbar);
+        dolog("BDBAR[%d] <- 0x%x (bdbar 0x%x)", GET_BM(addr), val, r->bdbar);
         break;
     case GLOB_CNT:
         /* TODO: Handle WR or CR being set (warm/cold reset requests) */
         if (!(val & (GC_WR | GC_CR))) {
             s->glob_cnt = val & GC_VALID_MASK;
         }
-        dolog("glob_cnt <- 0x%x (glob_cnt 0x%x)\n", val, s->glob_cnt);
+        dolog("glob_cnt <- 0x%x (glob_cnt 0x%x)", val, s->glob_cnt);
         break;
     case GLOB_STA:
         s->glob_sta &= ~(val & GS_WCLEAR_MASK);
         s->glob_sta |= (val & ~(GS_WCLEAR_MASK | GS_RO_MASK)) & GS_VALID_MASK;
-        dolog("glob_sta <- 0x%x (glob_sta 0x%x)\n", val, s->glob_sta);
+        dolog("glob_sta <- 0x%x (glob_sta 0x%x)", val, s->glob_sta);
         break;
     default:
-        dolog("U nabm writel 0x%x <- 0x%x\n", addr, val);
+        dolog("U nabm writel 0x%x <- 0x%x", addr, val);
         break;
     }
 }
@@ -903,7 +901,7 @@ static int write_audio(AC97LinkState *s, AC97BusMasterRegs *r,
         to_copy = MIN(temp, sizeof(tmpbuf));
         pci_dma_read(&s->dev, addr, tmpbuf, to_copy);
         copied = AUD_write(s->voice_po, tmpbuf, to_copy);
-        dolog("write_audio max=%x to_copy=%x copied=%x\n",
+        dolog("write_audio max=%x to_copy=%x copied=%x",
               max, to_copy, copied);
         if (!copied) {
             *stop = 1;
@@ -916,7 +914,7 @@ static int write_audio(AC97LinkState *s, AC97BusMasterRegs *r,
 
     if (!temp) {
         if (to_copy < 4) {
-            dolog("whoops\n");
+            dolog("whoops");
             s->last_samp = 0;
         } else {
             s->last_samp = *(uint32_t *)&tmpbuf[to_copy - 4];
@@ -929,7 +927,7 @@ static int write_audio(AC97LinkState *s, AC97BusMasterRegs *r,
 
 static void write_bup(AC97LinkState *s, int elapsed)
 {
-    dolog("write_bup\n");
+    dolog("write_bup");
     if (!(s->bup_flag & BUP_SET)) {
         if (s->bup_flag & BUP_LAST) {
             int i;
@@ -997,7 +995,7 @@ static void transfer_audio(AC97LinkState *s, int index, int elapsed)
     int stop = 0;
 
     if (s->invalid_freq[index]) {
-        AUD_log("ac97", "attempt to use voice %d with invalid frequency %d\n",
+        error_report("ac97: attempt to use voice %d with invalid frequency %d",
                 index, s->invalid_freq[index]);
         return;
     }
@@ -1017,12 +1015,12 @@ static void transfer_audio(AC97LinkState *s, int index, int elapsed)
         int temp;
 
         if (!r->bd_valid) {
-            dolog("invalid bd\n");
+            dolog("invalid bd");
             fetch_bd(s, r);
         }
 
         if (!r->picb) {
-            dolog("fresh bd %d is empty 0x%x 0x%x\n",
+            dolog("fresh bd %d is empty 0x%x 0x%x",
                   r->civ, r->bd.addr, r->bd.ctl_len);
             if (r->civ == r->lvi) {
                 r->sr |= SR_DCH; /* CELV? */
@@ -1059,7 +1057,7 @@ static void transfer_audio(AC97LinkState *s, int index, int elapsed)
             }
 
             if (r->civ == r->lvi) {
-                dolog("Underrun civ (%d) == lvi (%d)\n", r->civ, r->lvi);
+                dolog("Underrun civ (%d) == lvi (%d)", r->civ, r->lvi);
 
                 new_sr |= SR_LVBCI | SR_DCH | SR_CELV;
                 stop = 1;
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 50bbb97a56..231055b8b5 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -29,24 +29,20 @@
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "qemu/error-report.h"
 #include "qom/object.h"
 
-//#define DEBUG
+#define DEBUG 0
 
 #define ADLIB_KILL_TIMERS 1
 
 #define ADLIB_DESC "Yamaha YM3812 (OPL2)"
 
-#ifdef DEBUG
+#if DEBUG
 #include "qemu/timer.h"
 #endif
 
-#define dolog(...) AUD_log ("adlib", __VA_ARGS__)
-#ifdef DEBUG
-#define ldebug(...) dolog (__VA_ARGS__)
-#else
-#define ldebug(...)
-#endif
+#define ldebug(fmt, ...) do { if (DEBUG) error_report("adlib: " fmt, ##__VA_ARGS__); } while(0)
 
 #include "fmopl.h"
 #define SHIFT 1
@@ -64,7 +60,7 @@ struct AdlibState {
     int enabled;
     int active;
     int bufpos;
-#ifdef DEBUG
+#if DEBUG
     int64_t exp[2];
 #endif
     int16_t *mixbuf;
@@ -92,7 +88,7 @@ static void adlib_kill_timers (AdlibState *s)
 
             delta = AUD_get_elapsed_usec_out (s->voice, &s->ats);
             ldebug (
-                "delta = %f dexp = %f expired => %d\n",
+                "delta = %f dexp = %f expired => %d",
                 delta / 1000000.0,
                 s->dexp[i] / 1000000.0,
                 delta >= s->dexp[i]
@@ -131,7 +127,7 @@ static void timer_handler (void *opaque, int c, double interval_Sec)
 {
     AdlibState *s = opaque;
     unsigned n = c & 1;
-#ifdef DEBUG
+#if DEBUG
     double interval;
     int64_t exp;
 #endif
@@ -142,7 +138,7 @@ static void timer_handler (void *opaque, int c, double interval_Sec)
     }
 
     s->ticking[n] = 1;
-#ifdef DEBUG
+#if DEBUG
     interval = NANOSECONDS_PER_SECOND * interval_Sec;
     exp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + interval;
     s->exp[n] = exp;
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index c8837fe269..062af7628b 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -30,7 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "qemu/timer.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 
@@ -43,21 +43,17 @@
   More...
 */
 
-/* #define DEBUG */
+#define DEBUG 0
 /* #define DEBUG_XLAW */
 
 static struct {
     int aci_counter;
 } conf = {1};
 
-#ifdef DEBUG
-#define dolog(...) AUD_log ("cs4231a", __VA_ARGS__)
-#else
-#define dolog(...)
-#endif
+#define dolog(fmt, ...) do { if (DEBUG) error_report("cs4231a: " fmt, ##__VA_ARGS__); } while(0)
 
-#define lwarn(...) AUD_log ("cs4231a", "warning: " __VA_ARGS__)
-#define lerr(...) AUD_log ("cs4231a", "error: " __VA_ARGS__)
+#define lwarn(fmt, ...) warn_report("cs4231a: " fmt, ##__VA_ARGS__)
+#define lerr(fmt, ...) error_report("cs4231a: " fmt, ##__VA_ARGS__)
 
 #define CS_REGS 16
 #define CS_DREGS 32
@@ -284,7 +280,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     as.freq = freqs[xtal][(val >> 1) & 7];
 
     if (as.freq == -1) {
-        lerr ("unsupported frequency (val=%#x)\n", val);
+        lerr ("unsupported frequency (val=%#x)", val);
         goto error;
     }
 
@@ -319,11 +315,11 @@ static void cs_reset_voices (CSState *s, uint32_t val)
 
     case 7:
     case 4:
-        lerr ("attempt to use reserved format value (%#x)\n", val);
+        lerr ("attempt to use reserved format value (%#x)", val);
         goto error;
 
     case 5:
-        lerr ("ADPCM 4 bit IMA compatible format is not supported\n");
+        lerr ("ADPCM 4 bit IMA compatible format is not supported");
         goto error;
     }
 
@@ -393,7 +389,7 @@ static uint64_t cs_read (void *opaque, hwaddr addr, unsigned size)
         ret = s->regs[saddr];
         break;
     }
-    dolog ("read %d:%d -> %d\n", saddr, iaddr, ret);
+    dolog ("read %d:%d -> %d", saddr, iaddr, ret);
     return ret;
 }
 
@@ -425,7 +421,7 @@ static void cs_write (void *opaque, hwaddr addr,
         case RESERVED:
         case RESERVED_2:
         case RESERVED_3:
-            lwarn ("attempt to write %#x to reserved indirect register %d\n",
+            lwarn ("attempt to write %#x to reserved indirect register %d",
                    val, iaddr);
             break;
 
@@ -439,7 +435,7 @@ static void cs_write (void *opaque, hwaddr addr,
                     cs_reset_voices (s, val);
                 }
                 else {
-                    lwarn ("[P]MCE(%#x, %#x) is not set, val=%#x\n",
+                    lwarn ("[P]MCE(%#x, %#x) is not set, val=%#x",
                            s->regs[Index_Address],
                            s->dregs[Alternate_Feature_Status],
                            val);
@@ -453,7 +449,7 @@ static void cs_write (void *opaque, hwaddr addr,
             val &= ~(1 << 5);   /* D5 is reserved */
             s->dregs[iaddr] = val;
             if (val & PPIO) {
-                lwarn ("PIO is not supported (%#x)\n", val);
+                lwarn ("PIO is not supported (%#x)", val);
                 break;
             }
             if (val & PEN) {
@@ -472,11 +468,11 @@ static void cs_write (void *opaque, hwaddr addr,
             break;
 
         case Error_Status_And_Initialization:
-            lwarn ("attempt to write to read only register %d\n", iaddr);
+            lwarn ("attempt to write to read only register %d", iaddr);
             break;
 
         case MODE_And_ID:
-            dolog ("val=%#x\n", val);
+            dolog ("val=%#x", val);
             if (val & MODE2)
                 s->dregs[iaddr] |= MODE2;
             else
@@ -485,7 +481,7 @@ static void cs_write (void *opaque, hwaddr addr,
 
         case Alternate_Feature_Enable_I:
             if (val & TE)
-                lerr ("timer is not yet supported\n");
+                lerr ("timer is not yet supported");
             s->dregs[iaddr] = val;
             break;
 
@@ -499,7 +495,7 @@ static void cs_write (void *opaque, hwaddr addr,
             break;
 
         case Version_Chip_ID:
-            lwarn ("write to Version_Chip_ID register %#x\n", val);
+            lwarn ("write to Version_Chip_ID register %#x", val);
             s->dregs[iaddr] = val;
             break;
 
@@ -507,7 +503,7 @@ static void cs_write (void *opaque, hwaddr addr,
             s->dregs[iaddr] = val;
             break;
         }
-        dolog ("written value %#x to indirect register %d\n", val, iaddr);
+        dolog ("written value %#x to indirect register %d", val, iaddr);
         break;
 
     case Status:
@@ -519,7 +515,7 @@ static void cs_write (void *opaque, hwaddr addr,
         break;
 
     case PIO_Data:
-        lwarn ("attempt to write value %#x to PIO register\n", val);
+        lwarn ("attempt to write value %#x to PIO register", val);
         break;
     }
 }
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 8cb47589c3..ac5a6aba85 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -32,7 +32,7 @@
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
-#include "system/dma.h"
+#include "qemu/error-report.h"
 #include "qom/object.h"
 #include "trace.h"
 
@@ -190,7 +190,7 @@ static void print_ctl(uint32_t val)
         a(CDC_EN);
         a(SERR_DIS);
 #undef a
-        AUD_log("es1370", "ctl - PCLKDIV %d(DAC2 freq %d), freq %d,%s\n",
+        error_report("es1370: ctl - PCLKDIV %d(DAC2 freq %d), freq %d,%s\n",
                 (val & CTRL_PCLKDIV) >> CTRL_SH_PCLKDIV,
                 DAC2_DIVTOSR((val & CTRL_PCLKDIV) >> CTRL_SH_PCLKDIV),
                 dac1_samplerate[(val & CTRL_WTSRSEL) >> CTRL_SH_WTSRSEL],
@@ -226,7 +226,7 @@ static void print_sctl(uint32_t val)
         }
 #undef b
 #undef a
-        AUD_log("es1370",
+        error_report("es1370: "
                 "%s p2_end_inc %d, p2_st_inc %d,"
                 " r1_fmt %s, p2_fmt %s, p1_fmt %s\n",
                 buf,
@@ -238,10 +238,10 @@ static void print_sctl(uint32_t val)
     }
 }
 
-#define lwarn(...) \
+#define lwarn(fmt, ...) \
 do { \
     if (VERBOSE_ES1370) { \
-        AUD_log("es1370: warning", __VA_ARGS__); \
+        error_report("es1370: " fmt, ##__VA_ARGS__); \
     } \
 } while (0)
 
@@ -502,10 +502,10 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
 
     case ES1370_REG_PHANTOM_FRAMECNT:
-        lwarn("writing to phantom frame count 0x%" PRIx64 "\n", val);
+        lwarn("writing to phantom frame count 0x%" PRIx64, val);
         break;
     case ES1370_REG_PHANTOM_FRAMEADR:
-        lwarn("writing to phantom frame address 0x%" PRIx64 "\n", val);
+        lwarn("writing to phantom frame address 0x%" PRIx64, val);
         break;
 
     case ES1370_REG_ADC_FRAMECNT:
@@ -522,7 +522,7 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
 
     default:
-        lwarn("writel 0x%" PRIx64 " <- 0x%" PRIx64 "\n", addr, val);
+        lwarn("writel 0x%" PRIx64 " <- 0x%" PRIx64, addr, val);
         break;
     }
 }
@@ -586,16 +586,16 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
 
     case ES1370_REG_PHANTOM_FRAMECNT:
         val = ~0U;
-        lwarn("reading from phantom frame count\n");
+        lwarn("reading from phantom frame count");
         break;
     case ES1370_REG_PHANTOM_FRAMEADR:
         val = ~0U;
-        lwarn("reading from phantom frame address\n");
+        lwarn("reading from phantom frame address");
         break;
 
     default:
         val = ~0U;
-        lwarn("readl 0x%" PRIx64 " -> 0x%x\n", addr, val);
+        lwarn("readl 0x%" PRIx64 " -> 0x%x", addr, val);
         break;
     }
     return val;
@@ -677,7 +677,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
          * when the sample count reaches zero) or 1 for stop mode (set
          * interrupt and stop recording).
          */
-        AUD_log ("es1370: warning", "non looping mode\n");
+        warn_report("es1370: non looping mode");
     } else {
         d->frame_cnt = size;
 
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 2c84740adf..40073f2d4f 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -32,15 +32,12 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "gusemu.h"
-#include "gustate.h"
+#include "qemu/error-report.h"
 #include "qom/object.h"
 
-#define dolog(...) AUD_log ("audio", __VA_ARGS__)
-#ifdef DEBUG
-#define ldebug(...) dolog (__VA_ARGS__)
-#else
-#define ldebug(...)
-#endif
+#define DEBUG 0
+
+#define ldebug(fmt, ...) do { if (DEBUG) error_report("gus: " fmt, ##__VA_ARGS__); } while (0)
 
 #define TYPE_GUS "gus"
 OBJECT_DECLARE_SIMPLE_TYPE(GUSState, GUS)
@@ -154,14 +151,14 @@ int GUS_irqrequest (GUSEmuState *emu, int hwirq, int n)
     /* qemu_irq_lower (s->pic); */
     qemu_irq_raise (s->pic);
     s->irqs += n;
-    ldebug ("irqrequest %d %d %d\n", hwirq, n, s->irqs);
+    ldebug("irqrequest %d %d %d", hwirq, n, s->irqs);
     return n;
 }
 
 void GUS_irqclear (GUSEmuState *emu, int hwirq)
 {
     GUSState *s = emu->opaque;
-    ldebug ("irqclear %d %d\n", hwirq, s->irqs);
+    ldebug("irqclear %d %d", hwirq, s->irqs);
     qemu_irq_lower (s->pic);
     s->irqs -= 1;
 #ifdef IRQ_STORM
@@ -175,7 +172,7 @@ void GUS_dmarequest (GUSEmuState *emu)
 {
     GUSState *s = emu->opaque;
     IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
-    ldebug ("dma request %d\n", der->gusdma);
+    ldebug("dma request %d", s->emu.gusdma);
     k->hold_DREQ(s->isa_dma, s->emu.gusdma);
 }
 
@@ -186,13 +183,13 @@ static int GUS_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     QEMU_UNINITIALIZED char tmpbuf[4096];
     int pos = dma_pos, mode, left = dma_len - dma_pos;
 
-    ldebug ("read DMA %#x %d\n", dma_pos, dma_len);
+    ldebug("read DMA %#x %d", dma_pos, dma_len);
     mode = k->has_autoinitialization(s->isa_dma, s->emu.gusdma);
     while (left) {
         int to_copy = MIN ((size_t) left, sizeof (tmpbuf));
         int copied;
 
-        ldebug ("left=%d to_copy=%d pos=%d\n", left, to_copy, pos);
+        ldebug("left=%d to_copy=%d pos=%d", left, to_copy, pos);
         copied = k->read_memory(s->isa_dma, nchan, tmpbuf, pos, to_copy);
         gus_dma_transferdata (&s->emu, tmpbuf, copied, left == copied);
         left -= copied;
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 12a214c566..c8c63b7915 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -124,7 +124,7 @@ static int pcspk_audio_init(PCSpkState *s)
 
     s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
     if (!s->voice) {
-        AUD_log(s_spk, "Could not open voice\n");
+        error_report("pcspk: Could not open voice");
         return -1;
     }
 
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index cd7e813d05..069cf6e120 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -30,22 +30,17 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
+#include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 
-#define dolog(...) AUD_log ("sb16", __VA_ARGS__)
-
-/* #define DEBUG */
+#define DEBUG 0
 /* #define DEBUG_SB16_MOST */
 
-#ifdef DEBUG
-#define ldebug(...) dolog (__VA_ARGS__)
-#else
-#define ldebug(...)
-#endif
+#define ldebug(fmt, ...) do { if (DEBUG) error_report("sb16: " fmt, ##__VA_ARGS__); } while (0)
 
 static const char e3[] = "COPYRIGHT (C) CREATIVE TECHNOLOGY LTD, 1992.";
 
@@ -157,7 +152,7 @@ static int irq_of_magic (int magic)
 #if 0
 static void log_dsp (SB16State *dsp)
 {
-    ldebug ("%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:speaker=%d\n",
+    ldebug ("%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:speaker=%d",
             dsp->fmt_stereo ? "Stereo" : "Mono",
             dsp->fmt_signed ? "Signed" : "Unsigned",
             dsp->fmt_bits,
@@ -182,7 +177,7 @@ static void control (SB16State *s, int hold)
     IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
     s->dma_running = hold;
 
-    ldebug ("hold %d high %d dma %d\n", hold, s->use_hdma, dma);
+    ldebug ("hold %d high %d dma %d", hold, s->use_hdma, dma);
 
     if (hold) {
         k->hold_DREQ(isa_dma, dma);
@@ -290,7 +285,7 @@ static void dma_cmd8 (SB16State *s, int mask, int dma_len)
     }
 
     ldebug ("freq %d, stereo %d, sign %d, bits %d, "
-            "dma %d, auto %d, fifo %d, high %d\n",
+            "dma %d, auto %d, fifo %d, high %d",
             s->freq, s->fmt_stereo, s->fmt_signed, s->fmt_bits,
             s->block_size, s->dma_auto, s->fifo, s->highspeed);
 
@@ -338,7 +333,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
     }
 
     ldebug ("freq %d, stereo %d, sign %d, bits %d, "
-            "dma %d, auto %d, fifo %d, high %d\n",
+            "dma %d, auto %d, fifo %d, high %d",
             s->freq, s->fmt_stereo, s->fmt_signed, s->fmt_bits,
             s->block_size, s->dma_auto, s->fifo, s->highspeed);
 
@@ -395,7 +390,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
 
 static inline void dsp_out_data (SB16State *s, uint8_t val)
 {
-    ldebug ("outdata %#x\n", val);
+    ldebug ("outdata %#x", val);
     if ((size_t) s->out_data_len < sizeof (s->out_data)) {
         s->out_data[s->out_data_len++] = val;
     }
@@ -407,14 +402,14 @@ static inline uint8_t dsp_get_data (SB16State *s)
         return s->in2_data[--s->in_index];
     }
     else {
-        dolog ("buffer underflow\n");
+        warn_report("sb16: buffer underflow");
         return 0;
     }
 }
 
 static void command (SB16State *s, uint8_t cmd)
 {
-    ldebug ("command %#x\n", cmd);
+    ldebug ("command %#x", cmd);
 
     if (cmd > 0xaf && cmd < 0xd0) {
         if (cmd & 8) {
@@ -651,7 +646,7 @@ static void command (SB16State *s, uint8_t cmd)
     }
 
     if (!s->needed_bytes) {
-        ldebug ("\n");
+        ldebug ("!needed_bytes");
     }
 
  exit:
@@ -687,7 +682,7 @@ static uint16_t dsp_get_hilo (SB16State *s)
 static void complete (SB16State *s)
 {
     int d0, d1, d2;
-    ldebug ("complete command %#x, in_index %d, needed_bytes %d\n",
+    ldebug ("complete command %#x, in_index %d, needed_bytes %d",
             s->cmd, s->in_index, s->needed_bytes);
 
     if (s->cmd > 0xaf && s->cmd < 0xd0) {
@@ -696,11 +691,11 @@ static void complete (SB16State *s)
         d0 = dsp_get_data (s);
 
         if (s->cmd & 8) {
-            dolog ("ADC params cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
+            warn_report("sb16: ADC params cmd = %#x d0 = %d, d1 = %d, d2 = %d",
                    s->cmd, d0, d1, d2);
         }
         else {
-            ldebug ("cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
+            ldebug ("cmd = %#x d0 = %d, d1 = %d, d2 = %d",
                     s->cmd, d0, d1, d2);
             dma_cmd (s, s->cmd, d0, d1 + (d2 << 8));
         }
@@ -711,13 +706,13 @@ static void complete (SB16State *s)
             s->csp_mode = dsp_get_data (s);
             s->csp_reg83r = 0;
             s->csp_reg83w = 0;
-            ldebug ("CSP command 0x04: mode=%#x\n", s->csp_mode);
+            ldebug ("CSP command 0x04: mode=%#x", s->csp_mode);
             break;
 
         case 0x05:
             s->csp_param = dsp_get_data (s);
             s->csp_value = dsp_get_data (s);
-            ldebug ("CSP command 0x05: param=%#x value=%#x\n",
+            ldebug ("CSP command 0x05: param=%#x value=%#x",
                     s->csp_param,
                     s->csp_value);
             break;
@@ -725,9 +720,9 @@ static void complete (SB16State *s)
         case 0x0e:
             d0 = dsp_get_data (s);
             d1 = dsp_get_data (s);
-            ldebug ("write CSP register %d <- %#x\n", d1, d0);
+            ldebug ("write CSP register %d <- %#x", d1, d0);
             if (d1 == 0x83) {
-                ldebug ("0x83[%d] <- %#x\n", s->csp_reg83r, d0);
+                ldebug ("0x83[%d] <- %#x", s->csp_reg83r, d0);
                 s->csp_reg83[s->csp_reg83r % 4] = d0;
                 s->csp_reg83r += 1;
             }
@@ -738,10 +733,10 @@ static void complete (SB16State *s)
 
         case 0x0f:
             d0 = dsp_get_data (s);
-            ldebug ("read CSP register %#x -> %#x, mode=%#x\n",
+            ldebug ("read CSP register %#x -> %#x, mode=%#x",
                     d0, s->csp_regs[d0], s->csp_mode);
             if (d0 == 0x83) {
-                ldebug ("0x83[%d] -> %#x\n",
+                ldebug ("0x83[%d] -> %#x",
                         s->csp_reg83w,
                         s->csp_reg83[s->csp_reg83w % 4]);
                 dsp_out_data (s, s->csp_reg83[s->csp_reg83w % 4]);
@@ -754,7 +749,7 @@ static void complete (SB16State *s)
 
         case 0x10:
             d0 = dsp_get_data (s);
-            dolog ("cmd 0x10 d0=%#x\n", d0);
+            warn_report("sb16: cmd 0x10 d0=%#x\n", d0);
             break;
 
         case 0x14:
@@ -763,7 +758,7 @@ static void complete (SB16State *s)
 
         case 0x40:
             s->time_const = dsp_get_data (s);
-            ldebug ("set time const %d\n", s->time_const);
+            ldebug ("set time const %d", s->time_const);
             break;
 
         case 0x41:
@@ -776,12 +771,12 @@ static void complete (SB16State *s)
              * http://homepages.cae.wisc.edu/~brodskye/sb16doc/sb16doc.html#SamplingRate
              */
             s->freq = restrict_sampling_rate(dsp_get_hilo(s));
-            ldebug ("set freq %d\n", s->freq);
+            ldebug ("set freq %d", s->freq);
             break;
 
         case 0x48:
             s->block_size = dsp_get_lohi (s) + 1;
-            ldebug ("set dma block len %d\n", s->block_size);
+            ldebug ("set dma block len %d", s->block_size);
             break;
 
         case 0x74:
@@ -811,21 +806,21 @@ static void complete (SB16State *s)
                             );
                     }
                 }
-                ldebug ("mix silence %d %d %" PRId64 "\n", samples, bytes, ticks);
+                ldebug ("mix silence %d %d %" PRId64, samples, bytes, ticks);
             }
             break;
 
         case 0xe0:
             d0 = dsp_get_data (s);
             s->out_data_len = 0;
-            ldebug ("E0 data = %#x\n", d0);
+            ldebug ("E0 data = %#x", d0);
             dsp_out_data (s, ~d0);
             break;
 
         case 0xe2:
-#ifdef DEBUG
+#if DEBUG
             d0 = dsp_get_data (s);
-            dolog ("E2 = %#x\n", d0);
+            warn_report("sb16: E2 = %#x", d0);
 #endif
             break;
 
@@ -835,7 +830,7 @@ static void complete (SB16State *s)
 
         case 0xf9:
             d0 = dsp_get_data (s);
-            ldebug ("command 0xf9 with %#x\n", d0);
+            ldebug ("command 0xf9 with %#x", d0);
             switch (d0) {
             case 0x0e:
                 dsp_out_data (s, 0xff);
@@ -862,7 +857,7 @@ static void complete (SB16State *s)
         }
     }
 
-    ldebug ("\n");
+    ldebug ("");
     s->cmd = -1;
 }
 
@@ -926,7 +921,7 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
 
     iport = nport - s->port;
 
-    ldebug ("write %#x <- %#x\n", nport, val);
+    ldebug ("write %#x <- %#x", nport, val);
     switch (iport) {
     case 0x06:
         switch (val) {
@@ -976,7 +971,7 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
         }
         else {
             if (s->in_index == sizeof (s->in2_data)) {
-                dolog ("in data overrun\n");
+                warn_report("sb16: in data overrun");
             }
             else {
                 s->in2_data[s->in_index++] = val;
@@ -992,7 +987,7 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
         break;
 
     default:
-        ldebug ("(nport=%#x, val=%#x)\n", nport, val);
+        ldebug ("(nport=%#x, val=%#x)", nport, val);
         break;
     }
 }
@@ -1016,7 +1011,7 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
         }
         else {
             if (s->cmd != -1) {
-                dolog ("empty output buffer for command %#x\n",
+                warn_report("sb16: empty output buffer for command %#x",
                        s->cmd);
             }
             retval = s->last_read_byte;
@@ -1029,7 +1024,7 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
         break;
 
     case 0x0d:                  /* timer interrupt clear */
-        /* dolog ("timer interrupt clear\n"); */
+        /* warn_report("sb16: timer interrupt clear"); */
         retval = 0;
         break;
 
@@ -1056,13 +1051,13 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
     }
 
     if (!ack) {
-        ldebug ("read %#x -> %#x\n", nport, retval);
+        ldebug ("read %#x -> %#x", nport, retval);
     }
 
     return retval;
 
  error:
-    dolog ("warning: dsp_read %#x error\n", nport);
+    warn_report("sb16: dsp_read %#x error", nport);
     return 0xff;
 }
 
@@ -1108,7 +1103,7 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
     SB16State *s = opaque;
 
     (void) nport;
-    ldebug ("mixer_write [%#x] <- %#x\n", s->mixer_nreg, val);
+    ldebug ("mixer_write [%#x] <- %#x", s->mixer_nreg, val);
 
     switch (s->mixer_nreg) {
     case 0x00:
@@ -1118,7 +1113,7 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
     case 0x80:
         {
             int irq = irq_of_magic (val);
-            ldebug ("setting irq to %d (val=%#x)\n", irq, val);
+            ldebug ("setting irq to %d (val=%#x)", irq, val);
             if (irq > 0) {
                 s->irq = irq;
             }
@@ -1150,7 +1145,7 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
 
     default:
         if (s->mixer_nreg >= 0x80) {
-            ldebug ("attempt to write mixer[%#x] <- %#x\n", s->mixer_nreg, val);
+            ldebug ("attempt to write mixer[%#x] <- %#x", s->mixer_nreg, val);
         }
         break;
     }
@@ -1165,11 +1160,11 @@ static uint32_t mixer_read(void *opaque, uint32_t nport)
     (void) nport;
 #ifndef DEBUG_SB16_MOST
     if (s->mixer_nreg != 0x82) {
-        ldebug ("mixer_read[%#x] -> %#x\n",
+        ldebug ("mixer_read[%#x] -> %#x",
                 s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
     }
 #else
-    ldebug ("mixer_read[%#x] -> %#x\n",
+    ldebug ("mixer_read[%#x] -> %#x",
             s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
 #endif
     return s->mixer_regs[s->mixer_nreg];
@@ -1241,7 +1236,7 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     till = s->left_till_irq;
 
 #ifdef DEBUG_SB16_MOST
-    dolog ("pos:%06d %d till:%d len:%d\n",
+    warn_report("sb16: pos:%06d %d till:%d len:%d",
            dma_pos, free, till, dma_len);
 #endif
 
@@ -1265,7 +1260,7 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     }
 
 #ifdef DEBUG_SB16_MOST
-    ldebug ("pos %5d free %5d size %5d till % 5d copy %5d written %5d size %5d\n",
+    ldebug ("pos %5d free %5d size %5d till % 5d copy %5d written %5d size %5d",
             dma_pos, free, dma_len, s->left_till_irq, copy, written,
             s->block_size);
 #endif
-- 
2.51.0


