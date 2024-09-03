Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C43CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4d-0004vT-2m; Tue, 03 Sep 2024 12:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4a-0004nE-W2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4U-0002f5-0f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42c7a49152aso36158465e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379676; x=1725984476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fmDEQAHR61WT1tBB8RVs6stzaZ4Kwf55ODK6be7k5N4=;
 b=VYlUeRNs/VA+lob0HIcuxhHMKTXfPidW5eqLlk4EoVXWDtxyX1jX2HP5847KY9u9KO
 6nLlsJ6fQq4cbjJ/DCwFu6s1D37cg+TUHh6sXVD+ZhIK4LkbT5BBIGZOOyR9go+w/qSR
 tctX6tIvBjZlQOupCMqPDhDeX42aIu2xeDcSjVXWDvyMoNqUNiSdyIOqeM9ZotwXdTTx
 YBdOhmK/tGFUI/FhuA4CFxkAi0FyZFGkywgbygOmYzAA2SLkOeBarc/mqECWpmHVNpsp
 Ne+Vp1//mNsYgnsLmcs/GDzoQ1+0bhMC4FEeZdzosD+xn5Hl+AdPeNwnIS55HSMJhKB9
 IPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379676; x=1725984476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmDEQAHR61WT1tBB8RVs6stzaZ4Kwf55ODK6be7k5N4=;
 b=M8EHkR5VfmS8f3vgFgMs3sfisQDCTzrS1l9DKG2dfpu4G6KUBsIeJ+NnmwFYAC0+Ye
 mi+dl/LFOBFgIXI6WMhHJe6UhQgiPR8MBNVXLJRcy65AGZgwV3U/NIHa41bD4rsqAhZj
 /LiIl4J3Lqh0pc2ZxXjJkx0gK6wBZkI0WVEr5UDasHmR1N/QP7X/Yw1KgPAB06YynXc0
 1nmtch4/p1PJf/IazB5ALvvFlDUL3YLuxsgUNlKFbP1fsT5uByUvU9dXddewpb4jGnGL
 OFqrQh9c8Deth5JnBUmans2e4N17xE0hwZKtFUkqNiqv6n1jR67mwIH5aFmnKTGI0jWn
 GDWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs87/ZQu9+eooUEOK48vFSmER5LwB9OJdk3frRSYNIvkYeZGKMqjy03XLTbS7o/6SAiygJ/rAJ/zcM@nongnu.org
X-Gm-Message-State: AOJu0YwB1uKUl+7w9G3DlygCyIg2u0Pt3f62teQ95+SxIzyLEllWvMBp
 pQ2UWlTD/QGRBK+0koOyjyflLRzUWiRoucVXnkc2yZ8DllJQ5uR1MNTinEU1Oi8=
X-Google-Smtp-Source: AGHT+IFQ5xQJHKA18SxOorVN/1A+6sCylkkSqvmMy8zToWoTL/7rBvm6cle8rNJ7HhqfTBrn76wYZg==
X-Received: by 2002:a05:600c:a01:b0:426:6857:3156 with SMTP id
 5b1f17b1804b1-42bb01edd50mr169493835e9.27.1725379676341; 
 Tue, 03 Sep 2024 09:07:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:07:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 05/53] hw/ide: Remove DSCM-1XXXX microdrive device
 model
Date: Tue,  3 Sep 2024 17:07:03 +0100
Message-Id: <20240903160751.4100218-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The DSCM-1XXXX microdrive device model was used only by the
XScale-based Zaurus machine types.  Now they have been removed, we
can delete this device too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/pcmcia.h |   3 -
 hw/ide/microdrive.c | 644 --------------------------------------------
 hw/ide/Kconfig      |   6 -
 hw/ide/meson.build  |   1 -
 4 files changed, 654 deletions(-)
 delete mode 100644 hw/ide/microdrive.c

diff --git a/include/hw/pcmcia.h b/include/hw/pcmcia.h
index ab268027511..6c08ad616a5 100644
--- a/include/hw/pcmcia.h
+++ b/include/hw/pcmcia.h
@@ -60,7 +60,4 @@ struct PCMCIACardClass {
 #define CISTPL_END            0xff  /* Tuple End */
 #define CISTPL_ENDMARK        0xff
 
-/* dscm1xxxx.c */
-PCMCIACardState *dscm1xxxx_init(DriveInfo *bdrv);
-
 #endif
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
deleted file mode 100644
index 3bb152b5d33..00000000000
--- a/hw/ide/microdrive.c
+++ /dev/null
@@ -1,644 +0,0 @@
-/*
- * QEMU IDE Emulation: microdrive (CF / PCMCIA)
- *
- * Copyright (c) 2003 Fabrice Bellard
- * Copyright (c) 2006 Openedhand Ltd.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "hw/pcmcia.h"
-#include "migration/vmstate.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "sysemu/dma.h"
-#include "hw/irq.h"
-
-#include "qom/object.h"
-#include "ide-internal.h"
-
-#define TYPE_MICRODRIVE "microdrive"
-OBJECT_DECLARE_SIMPLE_TYPE(MicroDriveState, MICRODRIVE)
-
-/***********************************************************/
-/* CF-ATA Microdrive */
-
-#define METADATA_SIZE   0x20
-
-/* DSCM-1XXXX Microdrive hard disk with CF+ II / PCMCIA interface.  */
-
-struct MicroDriveState {
-    /*< private >*/
-    PCMCIACardState parent_obj;
-    /*< public >*/
-
-    IDEBus bus;
-    uint32_t attr_base;
-    uint32_t io_base;
-
-    /* Card state */
-    uint8_t opt;
-    uint8_t stat;
-    uint8_t pins;
-
-    uint8_t ctrl;
-    uint16_t io;
-    uint8_t cycle;
-};
-
-/* Register bitfields */
-enum md_opt {
-    OPT_MODE_MMAP    = 0,
-    OPT_MODE_IOMAP16 = 1,
-    OPT_MODE_IOMAP1  = 2,
-    OPT_MODE_IOMAP2  = 3,
-    OPT_MODE         = 0x3f,
-    OPT_LEVIREQ      = 0x40,
-    OPT_SRESET       = 0x80,
-};
-enum md_cstat {
-    STAT_INT        = 0x02,
-    STAT_PWRDWN     = 0x04,
-    STAT_XE         = 0x10,
-    STAT_IOIS8      = 0x20,
-    STAT_SIGCHG     = 0x40,
-    STAT_CHANGED    = 0x80,
-};
-enum md_pins {
-    PINS_MRDY       = 0x02,
-    PINS_CRDY       = 0x20,
-};
-enum md_ctrl {
-    CTRL_IEN        = 0x02,
-    CTRL_SRST       = 0x04,
-};
-
-static inline void md_interrupt_update(MicroDriveState *s)
-{
-    PCMCIACardState *card = PCMCIA_CARD(s);
-
-    if (card->slot == NULL) {
-        return;
-    }
-
-    qemu_set_irq(card->slot->irq,
-                    !(s->stat & STAT_INT) &&    /* Inverted */
-                    !(s->ctrl & (CTRL_IEN | CTRL_SRST)) &&
-                    !(s->opt & OPT_SRESET));
-}
-
-static void md_set_irq(void *opaque, int irq, int level)
-{
-    MicroDriveState *s = opaque;
-
-    if (level) {
-        s->stat |= STAT_INT;
-    } else {
-        s->stat &= ~STAT_INT;
-    }
-
-    md_interrupt_update(s);
-}
-
-static void md_reset(DeviceState *dev)
-{
-    MicroDriveState *s = MICRODRIVE(dev);
-
-    s->opt = OPT_MODE_MMAP;
-    s->stat = 0;
-    s->pins = 0;
-    s->cycle = 0;
-    s->ctrl = 0;
-    ide_bus_reset(&s->bus);
-}
-
-static uint8_t md_attr_read(PCMCIACardState *card, uint32_t at)
-{
-    MicroDriveState *s = MICRODRIVE(card);
-    PCMCIACardClass *pcc = PCMCIA_CARD_GET_CLASS(card);
-
-    if (at < s->attr_base) {
-        if (at < pcc->cis_len) {
-            return pcc->cis[at];
-        } else {
-            return 0x00;
-        }
-    }
-
-    at -= s->attr_base;
-
-    switch (at) {
-    case 0x00:  /* Configuration Option Register */
-        return s->opt;
-    case 0x02:  /* Card Configuration Status Register */
-        if (s->ctrl & CTRL_IEN) {
-            return s->stat & ~STAT_INT;
-        } else {
-            return s->stat;
-        }
-    case 0x04:  /* Pin Replacement Register */
-        return (s->pins & PINS_CRDY) | 0x0c;
-    case 0x06:  /* Socket and Copy Register */
-        return 0x00;
-#ifdef VERBOSE
-    default:
-        printf("%s: Bad attribute space register %02x\n", __func__, at);
-#endif
-    }
-
-    return 0;
-}
-
-static void md_attr_write(PCMCIACardState *card, uint32_t at, uint8_t value)
-{
-    MicroDriveState *s = MICRODRIVE(card);
-
-    at -= s->attr_base;
-
-    switch (at) {
-    case 0x00:  /* Configuration Option Register */
-        s->opt = value & 0xcf;
-        if (value & OPT_SRESET) {
-            device_cold_reset(DEVICE(s));
-        }
-        md_interrupt_update(s);
-        break;
-    case 0x02:  /* Card Configuration Status Register */
-        if ((s->stat ^ value) & STAT_PWRDWN) {
-            s->pins |= PINS_CRDY;
-        }
-        s->stat &= 0x82;
-        s->stat |= value & 0x74;
-        md_interrupt_update(s);
-        /* Word 170 in Identify Device must be equal to STAT_XE */
-        break;
-    case 0x04:  /* Pin Replacement Register */
-        s->pins &= PINS_CRDY;
-        s->pins |= value & PINS_MRDY;
-        break;
-    case 0x06:  /* Socket and Copy Register */
-        break;
-    default:
-        printf("%s: Bad attribute space register %02x\n", __func__, at);
-    }
-}
-
-static uint16_t md_common_read(PCMCIACardState *card, uint32_t at)
-{
-    MicroDriveState *s = MICRODRIVE(card);
-    IDEState *ifs;
-    uint16_t ret;
-    at -= s->io_base;
-
-    switch (s->opt & OPT_MODE) {
-    case OPT_MODE_MMAP:
-        if ((at & ~0x3ff) == 0x400) {
-            at = 0;
-        }
-        break;
-    case OPT_MODE_IOMAP16:
-        at &= 0xf;
-        break;
-    case OPT_MODE_IOMAP1:
-        if ((at & ~0xf) == 0x3f0) {
-            at -= 0x3e8;
-        } else if ((at & ~0xf) == 0x1f0) {
-            at -= 0x1f0;
-        }
-        break;
-    case OPT_MODE_IOMAP2:
-        if ((at & ~0xf) == 0x370) {
-            at -= 0x368;
-        } else if ((at & ~0xf) == 0x170) {
-            at -= 0x170;
-        }
-    }
-
-    switch (at) {
-    case 0x0:  /* Even RD Data */
-    case 0x8:
-        return ide_data_readw(&s->bus, 0);
-
-        /* TODO: 8-bit accesses */
-        if (s->cycle) {
-            ret = s->io >> 8;
-        } else {
-            s->io = ide_data_readw(&s->bus, 0);
-            ret = s->io & 0xff;
-        }
-        s->cycle = !s->cycle;
-        return ret;
-    case 0x9:  /* Odd RD Data */
-        return s->io >> 8;
-    case 0xd:  /* Error */
-        return ide_ioport_read(&s->bus, 0x1);
-    case 0xe:  /* Alternate Status */
-        ifs = ide_bus_active_if(&s->bus);
-        if (ifs->blk) {
-            return ifs->status;
-        } else {
-            return 0;
-        }
-    case 0xf:  /* Device Address */
-        ifs = ide_bus_active_if(&s->bus);
-        return 0xc2 | ((~ifs->select << 2) & 0x3c);
-    default:
-        return ide_ioport_read(&s->bus, at);
-    }
-
-    return 0;
-}
-
-static void md_common_write(PCMCIACardState *card, uint32_t at, uint16_t value)
-{
-    MicroDriveState *s = MICRODRIVE(card);
-    at -= s->io_base;
-
-    switch (s->opt & OPT_MODE) {
-    case OPT_MODE_MMAP:
-        if ((at & ~0x3ff) == 0x400) {
-            at = 0;
-        }
-        break;
-    case OPT_MODE_IOMAP16:
-        at &= 0xf;
-        break;
-    case OPT_MODE_IOMAP1:
-        if ((at & ~0xf) == 0x3f0) {
-            at -= 0x3e8;
-        } else if ((at & ~0xf) == 0x1f0) {
-            at -= 0x1f0;
-        }
-        break;
-    case OPT_MODE_IOMAP2:
-        if ((at & ~0xf) == 0x370) {
-            at -= 0x368;
-        } else if ((at & ~0xf) == 0x170) {
-            at -= 0x170;
-        }
-    }
-
-    switch (at) {
-    case 0x0:  /* Even WR Data */
-    case 0x8:
-        ide_data_writew(&s->bus, 0, value);
-        break;
-
-        /* TODO: 8-bit accesses */
-        if (s->cycle) {
-            ide_data_writew(&s->bus, 0, s->io | (value << 8));
-        } else {
-            s->io = value & 0xff;
-        }
-        s->cycle = !s->cycle;
-        break;
-    case 0x9:
-        s->io = value & 0xff;
-        s->cycle = !s->cycle;
-        break;
-    case 0xd:  /* Features */
-        ide_ioport_write(&s->bus, 0x1, value);
-        break;
-    case 0xe:  /* Device Control */
-        s->ctrl = value;
-        if (value & CTRL_SRST) {
-            device_cold_reset(DEVICE(s));
-        }
-        md_interrupt_update(s);
-        break;
-    default:
-        if (s->stat & STAT_PWRDWN) {
-            s->pins |= PINS_CRDY;
-            s->stat &= ~STAT_PWRDWN;
-        }
-        ide_ioport_write(&s->bus, at, value);
-    }
-}
-
-static const VMStateDescription vmstate_microdrive = {
-    .name = "microdrive",
-    .version_id = 3,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(opt, MicroDriveState),
-        VMSTATE_UINT8(stat, MicroDriveState),
-        VMSTATE_UINT8(pins, MicroDriveState),
-        VMSTATE_UINT8(ctrl, MicroDriveState),
-        VMSTATE_UINT16(io, MicroDriveState),
-        VMSTATE_UINT8(cycle, MicroDriveState),
-        VMSTATE_IDE_BUS(bus, MicroDriveState),
-        VMSTATE_IDE_DRIVES(bus.ifs, MicroDriveState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const uint8_t dscm1xxxx_cis[0x14a] = {
-    [0x000] = CISTPL_DEVICE,    /* 5V Device Information */
-    [0x002] = 0x03,             /* Tuple length = 4 bytes */
-    [0x004] = 0xdb,             /* ID: DTYPE_FUNCSPEC, non WP, DSPEED_150NS */
-    [0x006] = 0x01,             /* Size = 2K bytes */
-    [0x008] = CISTPL_ENDMARK,
-
-    [0x00a] = CISTPL_DEVICE_OC, /* Additional Device Information */
-    [0x00c] = 0x04,             /* Tuple length = 4 byest */
-    [0x00e] = 0x03,             /* Conditions: Ext = 0, Vcc 3.3V, MWAIT = 1 */
-    [0x010] = 0xdb,             /* ID: DTYPE_FUNCSPEC, non WP, DSPEED_150NS */
-    [0x012] = 0x01,             /* Size = 2K bytes */
-    [0x014] = CISTPL_ENDMARK,
-
-    [0x016] = CISTPL_JEDEC_C,   /* JEDEC ID */
-    [0x018] = 0x02,             /* Tuple length = 2 bytes */
-    [0x01a] = 0xdf,             /* PC Card ATA with no Vpp required */
-    [0x01c] = 0x01,
-
-    [0x01e] = CISTPL_MANFID,    /* Manufacture ID */
-    [0x020] = 0x04,             /* Tuple length = 4 bytes */
-    [0x022] = 0xa4,             /* TPLMID_MANF = 00a4 (IBM) */
-    [0x024] = 0x00,
-    [0x026] = 0x00,             /* PLMID_CARD = 0000 */
-    [0x028] = 0x00,
-
-    [0x02a] = CISTPL_VERS_1,    /* Level 1 Version */
-    [0x02c] = 0x12,             /* Tuple length = 23 bytes */
-    [0x02e] = 0x04,             /* Major Version = JEIDA 4.2 / PCMCIA 2.1 */
-    [0x030] = 0x01,             /* Minor Version = 1 */
-    [0x032] = 'I',
-    [0x034] = 'B',
-    [0x036] = 'M',
-    [0x038] = 0x00,
-    [0x03a] = 'm',
-    [0x03c] = 'i',
-    [0x03e] = 'c',
-    [0x040] = 'r',
-    [0x042] = 'o',
-    [0x044] = 'd',
-    [0x046] = 'r',
-    [0x048] = 'i',
-    [0x04a] = 'v',
-    [0x04c] = 'e',
-    [0x04e] = 0x00,
-    [0x050] = CISTPL_ENDMARK,
-
-    [0x052] = CISTPL_FUNCID,    /* Function ID */
-    [0x054] = 0x02,             /* Tuple length = 2 bytes */
-    [0x056] = 0x04,             /* TPLFID_FUNCTION = Fixed Disk */
-    [0x058] = 0x01,             /* TPLFID_SYSINIT: POST = 1, ROM = 0 */
-
-    [0x05a] = CISTPL_FUNCE,     /* Function Extension */
-    [0x05c] = 0x02,             /* Tuple length = 2 bytes */
-    [0x05e] = 0x01,             /* TPLFE_TYPE = Disk Device Interface */
-    [0x060] = 0x01,             /* TPLFE_DATA = PC Card ATA Interface */
-
-    [0x062] = CISTPL_FUNCE,     /* Function Extension */
-    [0x064] = 0x03,             /* Tuple length = 3 bytes */
-    [0x066] = 0x02,             /* TPLFE_TYPE = Basic PC Card ATA Interface */
-    [0x068] = 0x08,             /* TPLFE_DATA: Rotating, Unique, Single */
-    [0x06a] = 0x0f,             /* TPLFE_DATA: Sleep, Standby, Idle, Auto */
-
-    [0x06c] = CISTPL_CONFIG,    /* Configuration */
-    [0x06e] = 0x05,             /* Tuple length = 5 bytes */
-    [0x070] = 0x01,             /* TPCC_RASZ = 2 bytes, TPCC_RMSZ = 1 byte */
-    [0x072] = 0x07,             /* TPCC_LAST = 7 */
-    [0x074] = 0x00,             /* TPCC_RADR = 0200 */
-    [0x076] = 0x02,
-    [0x078] = 0x0f,             /* TPCC_RMSK = 200, 202, 204, 206 */
-
-    [0x07a] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x07c] = 0x0b,             /* Tuple length = 11 bytes */
-    [0x07e] = 0xc0,             /* TPCE_INDX = Memory Mode, Default, Iface */
-    [0x080] = 0xc0,             /* TPCE_IF = Memory, no BVDs, no WP, READY */
-    [0x082] = 0xa1,             /* TPCE_FS = Vcc only, no I/O, Memory, Misc */
-    [0x084] = 0x27,             /* NomV = 1, MinV = 1, MaxV = 1, Peakl = 1 */
-    [0x086] = 0x55,             /* NomV: 5.0 V */
-    [0x088] = 0x4d,             /* MinV: 4.5 V */
-    [0x08a] = 0x5d,             /* MaxV: 5.5 V */
-    [0x08c] = 0x4e,             /* Peakl: 450 mA */
-    [0x08e] = 0x08,             /* TPCE_MS = 1 window, 1 byte, Host address */
-    [0x090] = 0x00,             /* Window descriptor: Window length = 0 */
-    [0x092] = 0x20,             /* TPCE_MI: support power down mode, RW */
-
-    [0x094] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x096] = 0x06,             /* Tuple length = 6 bytes */
-    [0x098] = 0x00,             /* TPCE_INDX = Memory Mode, no Default */
-    [0x09a] = 0x01,             /* TPCE_FS = Vcc only, no I/O, no Memory */
-    [0x09c] = 0x21,             /* NomV = 1, MinV = 0, MaxV = 0, Peakl = 1 */
-    [0x09e] = 0xb5,             /* NomV: 3.3 V */
-    [0x0a0] = 0x1e,
-    [0x0a2] = 0x3e,             /* Peakl: 350 mA */
-
-    [0x0a4] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x0a6] = 0x0d,             /* Tuple length = 13 bytes */
-    [0x0a8] = 0xc1,             /* TPCE_INDX = I/O and Memory Mode, Default */
-    [0x0aa] = 0x41,             /* TPCE_IF = I/O and Memory, no BVD, no WP */
-    [0x0ac] = 0x99,             /* TPCE_FS = Vcc only, I/O, Interrupt, Misc */
-    [0x0ae] = 0x27,             /* NomV = 1, MinV = 1, MaxV = 1, Peakl = 1 */
-    [0x0b0] = 0x55,             /* NomV: 5.0 V */
-    [0x0b2] = 0x4d,             /* MinV: 4.5 V */
-    [0x0b4] = 0x5d,             /* MaxV: 5.5 V */
-    [0x0b6] = 0x4e,             /* Peakl: 450 mA */
-    [0x0b8] = 0x64,             /* TPCE_IO = 16-byte boundary, 16/8 accesses */
-    [0x0ba] = 0xf0,             /* TPCE_IR =  MASK, Level, Pulse, Share */
-    [0x0bc] = 0xff,             /* IRQ0..IRQ7 supported */
-    [0x0be] = 0xff,             /* IRQ8..IRQ15 supported */
-    [0x0c0] = 0x20,             /* TPCE_MI = support power down mode */
-
-    [0x0c2] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x0c4] = 0x06,             /* Tuple length = 6 bytes */
-    [0x0c6] = 0x01,             /* TPCE_INDX = I/O and Memory Mode */
-    [0x0c8] = 0x01,             /* TPCE_FS = Vcc only, no I/O, no Memory */
-    [0x0ca] = 0x21,             /* NomV = 1, MinV = 0, MaxV = 0, Peakl = 1 */
-    [0x0cc] = 0xb5,             /* NomV: 3.3 V */
-    [0x0ce] = 0x1e,
-    [0x0d0] = 0x3e,             /* Peakl: 350 mA */
-
-    [0x0d2] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x0d4] = 0x12,             /* Tuple length = 18 bytes */
-    [0x0d6] = 0xc2,             /* TPCE_INDX = I/O Primary Mode */
-    [0x0d8] = 0x41,             /* TPCE_IF = I/O and Memory, no BVD, no WP */
-    [0x0da] = 0x99,             /* TPCE_FS = Vcc only, I/O, Interrupt, Misc */
-    [0x0dc] = 0x27,             /* NomV = 1, MinV = 1, MaxV = 1, Peakl = 1 */
-    [0x0de] = 0x55,             /* NomV: 5.0 V */
-    [0x0e0] = 0x4d,             /* MinV: 4.5 V */
-    [0x0e2] = 0x5d,             /* MaxV: 5.5 V */
-    [0x0e4] = 0x4e,             /* Peakl: 450 mA */
-    [0x0e6] = 0xea,             /* TPCE_IO = 1K boundary, 16/8 access, Range */
-    [0x0e8] = 0x61,             /* Range: 2 fields, 2 bytes addr, 1 byte len */
-    [0x0ea] = 0xf0,             /* Field 1 address = 0x01f0 */
-    [0x0ec] = 0x01,
-    [0x0ee] = 0x07,             /* Address block length = 8 */
-    [0x0f0] = 0xf6,             /* Field 2 address = 0x03f6 */
-    [0x0f2] = 0x03,
-    [0x0f4] = 0x01,             /* Address block length = 2 */
-    [0x0f6] = 0xee,             /* TPCE_IR = IRQ E, Level, Pulse, Share */
-    [0x0f8] = 0x20,             /* TPCE_MI = support power down mode */
-
-    [0x0fa] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x0fc] = 0x06,             /* Tuple length = 6 bytes */
-    [0x0fe] = 0x02,             /* TPCE_INDX = I/O Primary Mode, no Default */
-    [0x100] = 0x01,             /* TPCE_FS = Vcc only, no I/O, no Memory */
-    [0x102] = 0x21,             /* NomV = 1, MinV = 0, MaxV = 0, Peakl = 1 */
-    [0x104] = 0xb5,             /* NomV: 3.3 V */
-    [0x106] = 0x1e,
-    [0x108] = 0x3e,             /* Peakl: 350 mA */
-
-    [0x10a] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x10c] = 0x12,             /* Tuple length = 18 bytes */
-    [0x10e] = 0xc3,             /* TPCE_INDX = I/O Secondary Mode, Default */
-    [0x110] = 0x41,             /* TPCE_IF = I/O and Memory, no BVD, no WP */
-    [0x112] = 0x99,             /* TPCE_FS = Vcc only, I/O, Interrupt, Misc */
-    [0x114] = 0x27,             /* NomV = 1, MinV = 1, MaxV = 1, Peakl = 1 */
-    [0x116] = 0x55,             /* NomV: 5.0 V */
-    [0x118] = 0x4d,             /* MinV: 4.5 V */
-    [0x11a] = 0x5d,             /* MaxV: 5.5 V */
-    [0x11c] = 0x4e,             /* Peakl: 450 mA */
-    [0x11e] = 0xea,             /* TPCE_IO = 1K boundary, 16/8 access, Range */
-    [0x120] = 0x61,             /* Range: 2 fields, 2 byte addr, 1 byte len */
-    [0x122] = 0x70,             /* Field 1 address = 0x0170 */
-    [0x124] = 0x01,
-    [0x126] = 0x07,             /* Address block length = 8 */
-    [0x128] = 0x76,             /* Field 2 address = 0x0376 */
-    [0x12a] = 0x03,
-    [0x12c] = 0x01,             /* Address block length = 2 */
-    [0x12e] = 0xee,             /* TPCE_IR = IRQ E, Level, Pulse, Share */
-    [0x130] = 0x20,             /* TPCE_MI = support power down mode */
-
-    [0x132] = CISTPL_CFTABLE_ENTRY, /* 16-bit PC Card Configuration */
-    [0x134] = 0x06,             /* Tuple length = 6 bytes */
-    [0x136] = 0x03,             /* TPCE_INDX = I/O Secondary Mode */
-    [0x138] = 0x01,             /* TPCE_FS = Vcc only, no I/O, no Memory */
-    [0x13a] = 0x21,             /* NomV = 1, MinV = 0, MaxV = 0, Peakl = 1 */
-    [0x13c] = 0xb5,             /* NomV: 3.3 V */
-    [0x13e] = 0x1e,
-    [0x140] = 0x3e,             /* Peakl: 350 mA */
-
-    [0x142] = CISTPL_NO_LINK,   /* No Link */
-    [0x144] = 0x00,             /* Tuple length = 0 bytes */
-
-    [0x146] = CISTPL_END,       /* Tuple End */
-};
-
-#define TYPE_DSCM1XXXX "dscm1xxxx"
-
-static int dscm1xxxx_attach(PCMCIACardState *card)
-{
-    MicroDriveState *md = MICRODRIVE(card);
-    PCMCIACardClass *pcc = PCMCIA_CARD_GET_CLASS(card);
-
-    md->attr_base = pcc->cis[0x74] | (pcc->cis[0x76] << 8);
-    md->io_base = 0x0;
-
-    device_cold_reset(DEVICE(md));
-    md_interrupt_update(md);
-
-    return 0;
-}
-
-static int dscm1xxxx_detach(PCMCIACardState *card)
-{
-    MicroDriveState *md = MICRODRIVE(card);
-
-    device_cold_reset(DEVICE(md));
-    return 0;
-}
-
-PCMCIACardState *dscm1xxxx_init(DriveInfo *dinfo)
-{
-    MicroDriveState *md;
-
-    md = MICRODRIVE(object_new(TYPE_DSCM1XXXX));
-    qdev_realize(DEVICE(md), NULL, &error_fatal);
-
-    if (dinfo != NULL) {
-        ide_bus_create_drive(&md->bus, 0, dinfo);
-    }
-    md->bus.ifs[0].drive_kind = IDE_CFATA;
-    md->bus.ifs[0].mdata_size = METADATA_SIZE;
-    md->bus.ifs[0].mdata_storage = g_malloc0(METADATA_SIZE);
-
-    return PCMCIA_CARD(md);
-}
-
-static void dscm1xxxx_class_init(ObjectClass *oc, void *data)
-{
-    PCMCIACardClass *pcc = PCMCIA_CARD_CLASS(oc);
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    pcc->cis = dscm1xxxx_cis;
-    pcc->cis_len = sizeof(dscm1xxxx_cis);
-
-    pcc->attach = dscm1xxxx_attach;
-    pcc->detach = dscm1xxxx_detach;
-    /* Reason: Needs to be wired-up in code, see dscm1xxxx_init() */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo dscm1xxxx_type_info = {
-    .name = TYPE_DSCM1XXXX,
-    .parent = TYPE_MICRODRIVE,
-    .class_init = dscm1xxxx_class_init,
-};
-
-static void microdrive_realize(DeviceState *dev, Error **errp)
-{
-    MicroDriveState *md = MICRODRIVE(dev);
-
-    ide_bus_init_output_irq(&md->bus, qemu_allocate_irq(md_set_irq, md, 0));
-}
-
-static void microdrive_init(Object *obj)
-{
-    MicroDriveState *md = MICRODRIVE(obj);
-
-    ide_bus_init(&md->bus, sizeof(md->bus), DEVICE(obj), 0, 1);
-}
-
-static void microdrive_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PCMCIACardClass *pcc = PCMCIA_CARD_CLASS(oc);
-
-    pcc->attr_read = md_attr_read;
-    pcc->attr_write = md_attr_write;
-    pcc->common_read = md_common_read;
-    pcc->common_write = md_common_write;
-    pcc->io_read = md_common_read;
-    pcc->io_write = md_common_write;
-
-    dc->realize = microdrive_realize;
-    dc->reset = md_reset;
-    dc->vmsd = &vmstate_microdrive;
-}
-
-static const TypeInfo microdrive_type_info = {
-    .name = TYPE_MICRODRIVE,
-    .parent = TYPE_PCMCIA_CARD,
-    .instance_size = sizeof(MicroDriveState),
-    .instance_init = microdrive_init,
-    .abstract = true,
-    .class_init = microdrive_class_init,
-};
-
-static void microdrive_register_types(void)
-{
-    type_register_static(&microdrive_type_info);
-    type_register_static(&dscm1xxxx_type_info);
-}
-
-type_init(microdrive_register_types)
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 6dfc5a21292..2e22b677da3 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -43,12 +43,6 @@ config IDE_VIA
     bool
     select IDE_PCI
 
-config MICRODRIVE
-    bool
-    select IDE_BUS
-    select IDE_DEV
-    depends on PCMCIA
-
 config AHCI
     bool
     select IDE_BUS
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
index d09705cac03..90ea8614233 100644
--- a/hw/ide/meson.build
+++ b/hw/ide/meson.build
@@ -13,4 +13,3 @@ system_ss.add(when: 'CONFIG_IDE_PCI', if_true: files('pci.c'))
 system_ss.add(when: 'CONFIG_IDE_PIIX', if_true: files('piix.c', 'ioport.c'))
 system_ss.add(when: 'CONFIG_IDE_SII3112', if_true: files('sii3112.c'))
 system_ss.add(when: 'CONFIG_IDE_VIA', if_true: files('via.c'))
-system_ss.add(when: 'CONFIG_MICRODRIVE', if_true: files('microdrive.c'))
-- 
2.34.1


