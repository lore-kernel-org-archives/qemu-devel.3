Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A589C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqB-0001w5-GS; Wed, 19 Aug 2026 22:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspx-0001s1-Qz
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:03 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspu-0000Rv-S1
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:01 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66b35d2c4edso2796962d50.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194137; x=1787798937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vhrrmVXgiHV55vONvF9mCuACTf5Rtr1rMIvzakWRaVA=;
 b=C3HtFOe2AfCWwz8R44G7InlIppW1nV4qD1iBzapNsnihRC+V1bMdCqAlvDJxD/6QA7
 wtQa5UyRU188Wp6vag1DCWMsbsnC6/gokAtmtNyW9WuvZ/vp4rNEWnlEl5yNzNqq6W9D
 YQvBGDF89G9nUYu3+PLuGgK7NXTOl1BfGrue9pz5vpcgHSs2wFKFiPpljhfRmxH54j5Y
 6K89ZPfSSD/ZF3r+NZEUFycakWzpp1QuIwEaQv+aOKO77WaRMoanC5/Gtm4rcLJNawsD
 rq5cTzFhxMM+TLWtd+N6PKIuaAfJDg5fBf06CRXRYJU4WRW6HPpBKHQGv+juFkyEwbe2
 HCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194137; x=1787798937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vhrrmVXgiHV55vONvF9mCuACTf5Rtr1rMIvzakWRaVA=;
 b=SwLEZKc5m7ESK3AlVAoAfD9bs2iXVS6Cof3erPH2DjDZbW6gWqfbOoD690io8S5XV7
 IrDL2yOWI/pLiSQeJzfKjFk935JVCm/UeOKcz7d74ZWJrqo2BR6XfE8UNVNKCLAh7QNr
 225HF+eYQiJlXoGX6gWQGrSd9Gv4rNz+VQcV3TXherglV15Q5B14MhArH4/uArcMx03I
 Wd4ElV99igGzy1YXpIR75Sno88L6/xqebFIVlXw441sZzupZsXKL4V9WD/mqFqIrMHnS
 4pmFg8aLXrQZdGG+y1/5vImvDpiuVVYqKmMcX3/S7zCMRIO0SEfU20CdfbmW+DrX9OHT
 qq3Q==
X-Gm-Message-State: AFuF++mdb2TyQVCIzObGEpaTkJ8NSw1XZU29yjCe9+sh3KP1eMFBEfdf
 po5db+pr/up0ALb9YUv/meCRqvcvTMHTBUFGb8D7VSRmj4gREpwZI+gSLGJAsQ==
X-Gm-Gg: AR+sD1225+3o6NuLrQdWW6v6PKcj2RZusjcRxZTqGdGnvWROqa28il/Ot2NLowLpeRa
 GmiTPPTgJxTJE2HvJtOm4s11ZFmz409Ni7FBzttWpxi3m3LMQQcikrz7OyIrzsSYgV8jaIcGQGw
 u8jnNlDkNRCn45HkRKP8M82nTXsaHQMsYUt7Cb5oGVF2tXjYU8OMmgvIluRYIyiRz3G3XBt9TpO
 of0oPAgG5Y4mMPzcWBDt2zu3OxcLza9aEVrFyl/pvt7RbPTXaFaN/7eHAoAql63nWdR05TF0o6V
 6GZEViR3PqgJgphvydLN1v/cTzZeTzTDgM0mNHOhq5OD7HGSxzT9kVFLTa6+Di3IaMt68V/1yJC
 u/yjurLH26nMs+cF9L90Y9I+hBx65kR3Hf7KlKCYAuNH4LVJDWKACfPDpqEjT/on0LTgoy9qqEB
 qReXoFEEgu3soNALDCnBUP7b1h0Q6D2rtV7gbuUxLuQuZC4jbxJo0sYQa0PrukIZWHkNCUL/StW
 5B5vb5LjJSHdTsp5Lu2SbwnUImFeONRLsteFyJGIvf/4d4Jl1b7fQ==
X-Received: by 2002:a05:690e:43ce:b0:66b:3c3c:c8a6 with SMTP id
 956f58d0204a3-66ccb6aa08amr2636613d50.52.1787194137370; 
 Wed, 19 Aug 2026 19:48:57 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:56 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH 07/16] hw/misc: add i.MX Messaging Unit (MU v2)
Date: Wed, 19 Aug 2026 21:48:25 -0500
Message-Id: <20260820024834.3286721-8-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The i.MX Messaging Unit (V2 register layout): the mailbox that carries
SCMI between the A55 cluster and the M33 System Manager. Models
CR/SR/GCR/GSR/GIER, the TR/RR data registers and the GCR.GIRn/GSR.GIPn
doorbell. Two endpoints pair through a peer QOM link: a TR write is
delivered into the peer's RR and the TX handshake completes when the
peer reads RR, so the real, unmodified SM firmware answers Linux's SCMI
traffic over the emulated mailbox.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/misc/Kconfig          |   3 +
 hw/misc/imx_mu.c         | 454 +++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build      |   1 +
 hw/misc/trace-events     |   4 +
 include/hw/misc/imx_mu.h | 144 +++++++++++++
 5 files changed, 606 insertions(+)
 create mode 100644 hw/misc/imx_mu.c
 create mode 100644 include/hw/misc/imx_mu.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b8860dd3e77..8645ca11f3f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -261,3 +261,6 @@ config AXIADO_CLK
     bool
 
 source macio/Kconfig
+
+config IMX_MU
+    bool
diff --git a/hw/misc/imx_mu.c b/hw/misc/imx_mu.c
new file mode 100644
index 00000000000..c9f372a8726
--- /dev/null
+++ b/hw/misc/imx_mu.c
@@ -0,0 +1,454 @@
+/*
+ * NXP i.MX Messaging Unit (MU) device model - V2 register layout
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Implements the subset of the V2 MU register set exercised by U-Boot
+ * SPL's imx_mu_init_generic() probe path and by SCMI mailbox traffic:
+ * CR/SR/GCR/GSR/GIER/TCR/TSR/RCR/RSR + 4 TR/RR data registers, plus
+ * a doorbell mechanism via GCR.GIRn / GSR.GIPn.
+ *
+ * Models enough for the SPL probe to succeed and for the SM to
+ * handshake on doorbells. No
+ * cross-domain interrupt routing, no flag-bit semantics beyond
+ * read/write-back, no per-channel TX/RX FIFO depth modelling.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/imx_mu.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static void imx_mu_update_irq(IMXMUState *s);
+
+static int imx_mu_post_load(void *opaque, int version_id)
+{
+    /* Recompute the IRQ line level from the restored register state. */
+    imx_mu_update_irq(opaque);
+    return 0;
+}
+
+static const VMStateDescription vmstate_imx_mu = {
+    .name = TYPE_IMX_MU,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = imx_mu_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cr, IMXMUState),
+        VMSTATE_UINT32(sr, IMXMUState),
+        VMSTATE_UINT32(fcr, IMXMUState),
+        VMSTATE_UINT32(fsr, IMXMUState),
+        VMSTATE_UINT32(gier, IMXMUState),
+        VMSTATE_UINT32(gcr, IMXMUState),
+        VMSTATE_UINT32(gsr, IMXMUState),
+        VMSTATE_UINT32(tcr, IMXMUState),
+        VMSTATE_UINT32(tsr, IMXMUState),
+        VMSTATE_UINT32(rcr, IMXMUState),
+        VMSTATE_UINT32(rsr, IMXMUState),
+        VMSTATE_UINT32_ARRAY(tr, IMXMUState, IMX_MU_NUM_CHANNELS),
+        VMSTATE_UINT32_ARRAY(rr, IMXMUState, IMX_MU_NUM_CHANNELS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+/*
+ * Recompute the IRQ line. V2 layout: each xSR pending bit ANDed with
+ * the matching xCR enable bit; any one of those produces an interrupt.
+ * GP-IRQ comes from (GSR.GIPn & GIER.GIEn) across the channels in use.
+ */
+static void imx_mu_update_irq(IMXMUState *s)
+{
+    uint32_t mask = (1u << IMX_MU_NUM_CHANNELS) - 1u;
+    bool level =
+        ((s->gsr & s->gier & mask) != 0) ||
+        ((s->tsr & s->tcr  & mask) != 0) ||
+        ((s->rsr & s->rcr  & mask) != 0);
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void imx_mu_reset_state(IMXMUState *s)
+{
+    s->cr   = 0;
+    s->sr   = 0;
+    s->fcr  = 0;
+    s->fsr  = 0;
+    s->gier = 0;
+    s->gcr  = 0;
+    s->gsr  = 0;
+    s->tcr  = 0;
+    /* All TX slots come up empty - TEn bits set. */
+    s->tsr  = (1u << IMX_MU_NUM_CHANNELS) - 1u;
+    s->rcr  = 0;
+    s->rsr  = 0;
+    memset(s->tr, 0, sizeof(s->tr));
+    memset(s->rr, 0, sizeof(s->rr));
+}
+
+static void imx_mu_reset_at_boot_hold(Object *obj, ResetType type)
+{
+    IMXMUState *s = IMX_MU(obj);
+
+    imx_mu_reset_state(s);
+    imx_mu_update_irq(s);
+}
+
+void imx_mu_assert_gip(IMXMUState *s, unsigned int idx)
+{
+    if (idx >= IMX_MU_NUM_CHANNELS) {
+        return;
+    }
+    trace_imx_mu_gip(idx);
+    s->gsr |= IMX_MU_V2_BIT(idx);
+    imx_mu_update_irq(s);
+}
+
+void imx_mu_set_doorbell_handler(IMXMUState *s,
+                                 IMXMUDoorbellHandler handler,
+                                 void *opaque)
+{
+    s->doorbell_handler = handler;
+    s->doorbell_opaque  = opaque;
+}
+
+void imx_mu_set_tr_write_handler(IMXMUState *s,
+                                 IMXMUTRWriteHandler handler,
+                                 void *opaque)
+{
+    s->tr_write_handler = handler;
+    s->tr_write_opaque  = opaque;
+}
+
+void imx_mu_deliver_rr(IMXMUState *s, unsigned int idx, uint32_t value)
+{
+    if (idx >= IMX_MU_NUM_CHANNELS) {
+        return;
+    }
+    trace_imx_mu_rr_deliver(idx, value);
+    s->rr[idx]  = value;
+    s->rsr     |= IMX_MU_V2_BIT(idx);
+    imx_mu_update_irq(s);
+}
+
+static uint64_t imx_mu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMXMUState *s = opaque;
+    uint64_t value = 0;
+
+    if (offset >= IMX_MU_TR_BASE &&
+        offset < IMX_MU_TR_BASE + IMX_MU_NUM_CHANNELS * 4) {
+        value = s->tr[(offset - IMX_MU_TR_BASE) / 4];
+        return value;
+    }
+    if (offset >= IMX_MU_RR_BASE &&
+        offset < IMX_MU_RR_BASE + IMX_MU_NUM_CHANNELS * 4) {
+        unsigned idx = (offset - IMX_MU_RR_BASE) / 4;
+        value = s->rr[idx];
+        /*
+         * Reading RR[n] clears RSR.RFn (the receive-full status bit)
+         * so the next sender can re-queue. The SCMI transport doesn't
+         * rely on this, but it matches the documented HW
+         * behaviour and lets the U-Boot probe drain pending data.
+         *
+         * For a peer-linked MU this completes the TX handshake: the word
+         * was delivered into RR[n] by the peer's TR[n] write (which left
+         * the peer's TSR.TEn clear), so draining it re-asserts the peer's
+         * TX-empty and lets a blocked mbox send finish.
+         */
+        s->rsr &= ~IMX_MU_V2_BIT(idx);
+        if (s->peer) {
+            s->peer->tsr |= IMX_MU_V2_BIT(idx);
+            imx_mu_update_irq(s->peer);
+        }
+        imx_mu_update_irq(s);
+        return value;
+    }
+
+    switch (offset) {
+    case IMX_MU_VER:
+        /* Plausible V2 version. Linux/U-Boot do not branch on this. */
+        value = 0x00020000;
+        break;
+    case IMX_MU_PAR:
+        /* TR count in [7:0], RR count in [15:8] (V2 encoding). */
+        value = ((uint32_t)IMX_MU_NUM_CHANNELS) |
+                ((uint32_t)IMX_MU_NUM_CHANNELS << 8);
+        break;
+    case IMX_MU_CR:
+        value = s->cr;
+        break;
+    case IMX_MU_SR:
+        value = s->sr;
+        break;
+    case IMX_MU_FCR:
+        value = s->fcr;
+        break;
+    case IMX_MU_FSR:
+        value = s->fsr;
+        break;
+    case IMX_MU_GIER:
+        value = s->gier;
+        break;
+    case IMX_MU_GCR:
+        value = s->gcr;
+        break;
+    case IMX_MU_GSR:
+        value = s->gsr;
+        break;
+    case IMX_MU_TCR:
+        value = s->tcr;
+        break;
+    case IMX_MU_TSR:
+        value = s->tsr;
+        break;
+    case IMX_MU_RCR:
+        value = s->rcr;
+        break;
+    case IMX_MU_RSR:
+        value = s->rsr;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+    return value;
+}
+
+static void imx_mu_write(void *opaque, hwaddr offset,
+                         uint64_t value, unsigned size)
+{
+    IMXMUState *s = opaque;
+
+    if (offset >= IMX_MU_TR_BASE &&
+        offset < IMX_MU_TR_BASE + IMX_MU_NUM_CHANNELS * 4) {
+        unsigned idx = (offset - IMX_MU_TR_BASE) / 4;
+        s->tr[idx] = value;
+        trace_imx_mu_tr_write(idx, value);
+        /*
+         * Writing TR[n] clears TSR.TEn (TX empty). Three delivery modes:
+         *  - TR-write handler (a responder, e.g. the ELE server): consumes
+         *    synchronously and we re-set TEn so the next write succeeds
+         *    without polling.
+         *  - peer linked (the other side of a real MU, e.g. the A55<->M7
+         *    rpmsg channel on MU7): deliver the word into the peer's RR[n]
+         *    and raise its RX interrupt. TEn stays clear until the peer
+         *    reads RR[n] (see the RR read path), which is the real MU TX
+         *    full/empty handshake the imx-mailbox driver waits on.
+         *  - neither (unattached MU): the slot stays "full" forever, which
+         *    is correct for a mailbox with nothing on the far side.
+         */
+        s->tsr &= ~IMX_MU_V2_BIT(idx);
+        if (s->tr_write_handler) {
+            s->tr_write_handler(s->tr_write_opaque, idx, value);
+            s->tsr |= IMX_MU_V2_BIT(idx);
+        } else if (s->peer) {
+            imx_mu_deliver_rr(s->peer, idx, (uint32_t)value);
+        }
+        imx_mu_update_irq(s);
+        return;
+    }
+    if (offset >= IMX_MU_RR_BASE &&
+        offset < IMX_MU_RR_BASE + IMX_MU_NUM_CHANNELS * 4) {
+        /* RR is RO from the guest's perspective. */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only RR at 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    switch (offset) {
+    case IMX_MU_VER:
+    case IMX_MU_PAR:
+        /* Read-only. Silent ignore matches HW. */
+        break;
+
+    case IMX_MU_CR:
+        if (value & IMX_MU_CR_RST) {
+            imx_mu_reset_state(s);
+            imx_mu_update_irq(s);
+            return;
+        }
+        s->cr = value;
+        break;
+
+    case IMX_MU_SR:
+        /*
+         * Per the kernel/U-Boot drivers, SR bits in V2 are read-only
+         * status that the model manages. Writing has no effect.
+         */
+        break;
+
+    case IMX_MU_FCR:
+        /*
+         * Flag-update register. On hardware a written flag bit is reflected
+         * to the peer's FSR; the SCMI transport does not use these flags, so
+         * we just store the value (no peer reflection or interrupt modelled).
+         */
+        s->fcr = value;
+        break;
+
+    case IMX_MU_FSR:
+        /* Write-1-to-clear of latched flag-status bits. */
+        s->fsr &= ~value;
+        imx_mu_update_irq(s);
+        break;
+
+    case IMX_MU_GIER:
+        s->gier = value;
+        imx_mu_update_irq(s);
+        break;
+
+    case IMX_MU_GCR: {
+        /*
+         * GCR.GIRn writes are doorbell triggers. Detect 0->1 transitions
+         * and, for each newly-asserted channel, deliver the doorbell. The
+         * bit is auto-cleared afterwards (write-1-to-trigger pulse),
+         * mirroring real HW where the request clears once the peer ACKs.
+         *
+         * Two delivery modes:
+         *  - peer linked (the other side of a real MU): latch the matching
+         *    GSR.GIPn on the peer and recompute the peer's IRQ. GIPn latches
+         *    regardless of the peer's GIER, so a doorbell that arrives before
+         *    the peer enables GIER.GIEn fires the moment it does (the peer's
+         *    GIER write recomputes the IRQ) - real pending-vs-enable HW.
+         *  - doorbell handler (a responder, e.g. the ELE server): invoke it
+         *    synchronously to consume the request.
+         */
+        uint32_t mask  = (1u << IMX_MU_NUM_CHANNELS) - 1u;
+        uint32_t newly = (value & ~s->gcr) & mask;
+        s->gcr = value;
+        for (unsigned i = 0; i < IMX_MU_NUM_CHANNELS; i++) {
+            if (!(newly & IMX_MU_V2_BIT(i))) {
+                continue;
+            }
+            trace_imx_mu_doorbell(i);
+            if (s->peer) {
+                s->peer->gsr |= IMX_MU_V2_BIT(i);
+                imx_mu_update_irq(s->peer);
+                s->gcr &= ~IMX_MU_V2_BIT(i);
+            } else if (s->doorbell_handler) {
+                s->doorbell_handler(s->doorbell_opaque, i);
+                s->gcr &= ~IMX_MU_V2_BIT(i);
+            }
+        }
+        imx_mu_update_irq(s);
+        break;
+    }
+
+    case IMX_MU_GSR:
+        /* Write-1-to-clear of GIP bits. */
+        s->gsr &= ~value;
+        imx_mu_update_irq(s);
+        break;
+
+    case IMX_MU_TCR:
+        s->tcr = value;
+        imx_mu_update_irq(s);
+        break;
+
+    case IMX_MU_TSR:
+        /* W1C of TX status. */
+        s->tsr &= ~value;
+        imx_mu_update_irq(s);
+        break;
+
+    case IMX_MU_RCR:
+        s->rcr = value;
+        imx_mu_update_irq(s);
+        break;
+
+    case IMX_MU_RSR:
+        /* W1C of RX status. */
+        s->rsr &= ~value;
+        imx_mu_update_irq(s);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx
+                      " value 0x%" PRIx64 "\n",
+                      __func__, offset, value);
+        break;
+    }
+}
+
+static const MemoryRegionOps imx_mu_ops = {
+    .read = imx_mu_read,
+    .write = imx_mu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * "peer" accepts any TYPE_IMX_MU and is settable at any time: the SM/M7 MUB
+ * endpoint is only created (and hence linkable) once its M-core is realized,
+ * so the SoC establishes the link after realize. A non-NULL check is what
+ * makes the link writable; the type is already enforced by the link itself.
+ */
+static void imx_mu_peer_check(const Object *obj, const char *name,
+                              Object *val, Error **errp)
+{
+}
+
+static void imx_mu_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IMXMUState *s = IMX_MU(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx_mu_ops, s,
+                          TYPE_IMX_MU, IMX_MU_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+
+    /*
+     * "peer" links the two endpoints (MUA/MUB) of one physical MU. It is a
+     * weak link - both endpoints are owned by the SoC container, so neither
+     * refs the other - and is settable after realize, because the SM/M7 MUB
+     * side is only created once the M-core it faces exists. That is why this
+     * uses object_property_add_link() rather than a static DEFINE_PROP_LINK
+     * (which forbids setting a link once the device is realized).
+     */
+    object_property_add_link(obj, "peer", TYPE_IMX_MU,
+                             (Object **)&s->peer, imx_mu_peer_check, 0);
+}
+
+static void imx_mu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_imx_mu;
+    rc->phases.hold = imx_mu_reset_at_boot_hold;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NXP i.MX Messaging Unit (V2)";
+}
+
+static const TypeInfo imx_mu_info = {
+    .name           = TYPE_IMX_MU,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMXMUState),
+    .instance_init  = imx_mu_init,
+    .class_init     = imx_mu_class_init,
+};
+
+static void imx_mu_register_types(void)
+{
+    type_register_static(&imx_mu_info);
+}
+
+type_init(imx_mu_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e86d9ad6b39..9d0e3ed220d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -171,3 +171,4 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
+system_ss.add(when: 'CONFIG_IMX_MU', if_true: files('imx_mu.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c9a868b3efb..01b0b275f7f 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
 iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
+imx_mu_tr_write(unsigned idx, uint32_t val) "TR[%u] <- 0x%08x"
+imx_mu_rr_deliver(unsigned idx, uint32_t val) "RR[%u] <- 0x%08x"
+imx_mu_doorbell(unsigned idx) "doorbell GIR channel %u"
+imx_mu_gip(unsigned idx) "GIP assert channel %u"
diff --git a/include/hw/misc/imx_mu.h b/include/hw/misc/imx_mu.h
new file mode 100644
index 00000000000..e308ebf70ea
--- /dev/null
+++ b/include/hw/misc/imx_mu.h
@@ -0,0 +1,144 @@
+/*
+ * NXP i.MX Messaging Unit (MU) device model - V2 register layout
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Models the V2 MU register layout used by i.MX 95 (compatible
+ * "fsl,imx95-mu") and other recent NXP SoCs. The MU is the
+ * messaging channel between the Cortex-A55 cluster and the Cortex-M33
+ * System Manager (and ELE, V2X, camera-mix, etc., depending on which
+ * instance); it carries SCMI traffic for clock / pinctrl / power-
+ * domain operations.
+ */
+
+#ifndef IMX_MU_H
+#define IMX_MU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_IMX_MU "imx.mu"
+OBJECT_DECLARE_SIMPLE_TYPE(IMXMUState, IMX_MU)
+
+#define IMX_MU_REG_SIZE         0x1000
+#define IMX_MU_NUM_CHANNELS     4       /* TR[0..3] / RR[0..3] */
+
+/*
+ * V2 register offsets. Source: NXP U-Boot imx_mu_cfg_imx95 in
+ * U-Boot drivers/mailbox/imx-mailbox.c.
+ */
+#define IMX_MU_VER              0x000   /* version (RO) */
+#define IMX_MU_PAR              0x004   /* parameter (RO; TR/RR counts) */
+#define IMX_MU_CR               0x008   /* control */
+#define IMX_MU_SR               0x00C   /* status */
+#define IMX_MU_FCR              0x100   /* flag control */
+#define IMX_MU_FSR              0x104   /* flag status */
+#define IMX_MU_GIER             0x110   /* general-purpose IRQ enable */
+#define IMX_MU_GCR              0x114   /* general-purpose control */
+#define IMX_MU_GSR              0x118   /* general-purpose status (GIP bits) */
+#define IMX_MU_TCR              0x120   /* TX IRQ enable */
+#define IMX_MU_TSR              0x124   /* TX status (TEn = TX empty) */
+#define IMX_MU_RCR              0x128   /* RX IRQ enable */
+#define IMX_MU_RSR              0x12C   /* RX status (RFn = RX full) */
+#define IMX_MU_TR_BASE          0x200   /* TR[0..15] (TX data) */
+#define IMX_MU_RR_BASE          0x280   /* RR[0..15] (RX data) */
+
+/* Helpers for V2 bit numbering (one bit per channel index, starting at 0). */
+#define IMX_MU_V2_BIT(idx)      (1u << (idx))
+
+/* CR.RST clears all state when written (V2 bit 0). */
+#define IMX_MU_CR_RST           BIT(0)
+
+/*
+ * Optional callback invoked when the guest writes a 0->1 transition
+ * on any GCR.GIRn bit (a doorbell trigger from the agent side). A
+ * responder (e.g. the ELE server) registers itself here to process
+ * inbound messages. Unset by default; the model functions as a plain
+ * register file when no handler is registered.
+ */
+typedef void (*IMXMUDoorbellHandler)(void *opaque, unsigned int idx);
+
+/*
+ * Optional callback invoked when the guest writes to a TR[idx] register.
+ * The ELE responder stub uses this to accumulate incoming ELE-protocol
+ * message words and react when a full message has arrived. Unset by
+ * default; the model is a plain register file with no consumer.
+ */
+typedef void (*IMXMUTRWriteHandler)(void *opaque, unsigned int idx,
+                                    uint32_t value);
+
+struct IMXMUState {
+    SysBusDevice    parent_obj;
+
+    MemoryRegion    iomem;
+    qemu_irq        irq;
+
+    /*
+     * Writable register state. Read-only registers (VER, PAR) are
+     * computed at read time from the configured channel count.
+     */
+    uint32_t        cr;
+    uint32_t        sr;
+    uint32_t        fcr;
+    uint32_t        fsr;
+    uint32_t        gier;
+    uint32_t        gcr;
+    uint32_t        gsr;
+    uint32_t        tcr;
+    uint32_t        tsr;
+    uint32_t        rcr;
+    uint32_t        rsr;
+    uint32_t        tr[IMX_MU_NUM_CHANNELS];
+    uint32_t        rr[IMX_MU_NUM_CHANNELS];
+
+    /* Doorbell forwarding (see typedef above). */
+    IMXMUDoorbellHandler doorbell_handler;
+    void                *doorbell_opaque;
+
+    /* TR-write forwarding (see typedef above). */
+    IMXMUTRWriteHandler  tr_write_handler;
+    void                *tr_write_opaque;
+
+    /*
+     * Optional peer MU endpoint (the other side of a real hardware MU).
+     * When set, a GCR.GIRn doorbell trigger on this side latches the
+     * matching GSR.GIPn on the peer (raising the peer's IRQ once the peer
+     * enables GIER.GIEn), instead of invoking doorbell_handler. This models
+     * the A55-side (MUA) <-> M33-side (MUB) cross-connect used to let the
+     * real SM firmware service the A55's SCMI traffic. Set via the "peer"
+     * QOM link property (registered in imx_mu_init()).
+     */
+    IMXMUState          *peer;
+};
+
+/*
+ * Register a doorbell handler. Replaces any previously registered
+ * handler. Call with handler = NULL to deregister.
+ */
+void imx_mu_set_doorbell_handler(IMXMUState *s,
+                                 IMXMUDoorbellHandler handler,
+                                 void *opaque);
+
+/* Register a TR-write handler. NULL to deregister. */
+void imx_mu_set_tr_write_handler(IMXMUState *s,
+                                 IMXMUTRWriteHandler handler,
+                                 void *opaque);
+
+/*
+ * Deliver a response word into RR[idx] and assert RSR.RFn so the
+ * agent's mu_hal_receivemsg() poll loop exits. Used by responder
+ * stubs (e.g. ELE) to push a message back to the agent.
+ */
+void imx_mu_deliver_rr(IMXMUState *s, unsigned int idx, uint32_t value);
+
+/*
+ * External hook: peripheral code (e.g. a responder) can call
+ * this to assert a GP-interrupt-pending bit on a particular channel,
+ * which surfaces as GSR.GIPn and (if GIER.GIEn is set) raises the IRQ.
+ * Used by the response side of a doorbell handshake.
+ */
+void imx_mu_assert_gip(IMXMUState *s, unsigned int idx);
+
+#endif /* IMX_MU_H */
-- 
2.34.1


