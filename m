Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BBEE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLegQ-0007N5-RC; Thu, 12 Dec 2024 03:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLeg0-0006lk-Fx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:36:05 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefw-0005H6-VV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:36:04 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2164b662090so2769805ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992556; x=1734597356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzC3cEHKBBLIYQgKT356TNBAPRilgUNCzs7VeSQDUkM=;
 b=VebMr0PI1qF95LUljSuPzXCnosVM+mv7OvSo6bt3lD8Vk3UgUT2GwDgGNkSl0X1B0G
 doN3Y0ouGBYJn7JCsVfRvHJSl2Vyevxfjrv9a9dOBi1qToFDG7V68N3tBi86kGhKI0OU
 cm0I7BX7Gig/2LG5FM7jE9CXu0V5znlNPo46kYMwOre1BOTCI1Dkiurbk40ptw4vEPLv
 sAUNO+92YJaY+/ey4qSUqLyJ6SJ+6vWdtmTchNBUBBMnabDjx2zAtI/hbD/HRNrE7ZMa
 kqLewEoYQNfGMWNQmdjRTfqUYVPanfkwgzwPuZ9GFH07Sh5Ty2k9ijlY1tozrhQP8DPa
 Euvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992556; x=1734597356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzC3cEHKBBLIYQgKT356TNBAPRilgUNCzs7VeSQDUkM=;
 b=bqh/1POhw5K4vMdfJP9mcG0utxK0yHi227vu99NXAeFkFpv7ny/73MhLG/BafG0UKG
 IbZkZBOcuah3faFgVaQT4NWYGxf0LdTyge19X8ceKyBlf49sbURNmv/skzuQqY92hDzN
 xWXieH7qrB1ekywkGoVz809zwdMcHnAFQMBjD5EEp3nSm+5zReA2Doo583L+OQpfN1Yj
 fKu9Wc4+fZNB+mX6qOm0dsE49qQ0D2JPrGis4rj7HY71Ytfx3YM13y/ZWzVk1/SVjMiZ
 rLRvCmT3FPFWpQDi3nPtJVQgIGvA/i4xudw08139Mdm2xzG+OmV0d2ZYsTHhnqZS5F89
 HnOw==
X-Gm-Message-State: AOJu0YyQNQgBjnPyNj+pUjUxW9K3XTSaHxdz50jAmEDIocFu5ychX6i+
 Lx/riiyshqI6Ro/ys9JJKSiNfFILqUh8ozKWrXUf3fyykjYLxqbq3Z8Dkw==
X-Gm-Gg: ASbGncsY/w1WVeadjb0pO5TyuEcmxU1drv7RivfUcvY+ayoUUgV3QpH7BCc6srE0671
 9l7t4nuk1StLj+fSmkJEz0I3jhrIOQXAFuA4jqKM9QTephNurJ637HfYcTVhgcBHSlmJIKZGoOb
 vyl2JObHfvJVqBAZW+lldbpKpSwO6tuoXWJWLqQ8YH184AMeWwLeuFyHdQjHB2spT1TwBmX6XaQ
 qlwFbf2XfVdIPbcFOge3nsGyDzhV0IGSGDAEAUX2Kc50FZpTsMv91ToLMM=
X-Google-Smtp-Source: AGHT+IGfXhonHJS5URNqnLHWthApHAM0hvuwtqqQgOzHrK6lDLKylbOq7CXLfXyPoE1ivdqszqrQ8g==
X-Received: by 2002:a17:90b:49:b0:2ee:d024:e4f7 with SMTP id
 98e67ed59e1d1-2f127e1f772mr9821406a91.0.1733992556259; 
 Thu, 12 Dec 2024 00:35:56 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:35:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 6/8] qtest/xhci: Add controller and device setup and ring tests
Date: Thu, 12 Dec 2024 18:34:59 +1000
Message-ID: <20241212083502.1439033-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212083502.1439033-1-npiggin@gmail.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add tests which init the host controller registers to the point where
command and event rings, irqs are operational. Enumerate ports and set
up an attached device context that enables device transfer ring to be
set up and tested.

This test does a bunch of things at once and is not yet well librified,
but it allows testing basic mechanisms and gives a starting point for
further work.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci.h               |   7 +
 hw/usb/hcd-xhci.c               |   7 -
 tests/qtest/usb-hcd-xhci-test.c | 498 +++++++++++++++++++++++++++++++-
 3 files changed, 499 insertions(+), 13 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 5781542f40e..36d8f4c8309 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -310,6 +310,13 @@ typedef struct XHCIRing {
     bool ccs;
 } XHCIRing;
 
+typedef struct XHCIEvRingSeg {
+    uint32_t addr_low;
+    uint32_t addr_high;
+    uint32_t size;
+    uint32_t rsvd;
+} XHCIEvRingSeg;
+
 typedef struct XHCIPort {
     XHCIState *xhci;
     uint32_t portsc;
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index df0421ec326..90273cd317e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -136,13 +136,6 @@ struct XHCIEPContext {
     QEMUTimer *kick_timer;
 };
 
-typedef struct XHCIEvRingSeg {
-    uint32_t addr_low;
-    uint32_t addr_high;
-    uint32_t size;
-    uint32_t rsvd;
-} XHCIEvRingSeg;
-
 static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
                          unsigned int epid, unsigned int streamid);
 static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid);
diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 0cccfd85a64..8733299e52f 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -8,17 +8,174 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "libqtest.h"
+#include "libqos/libqos-pc.h"
 #include "libqtest-single.h"
 #include "libqos/usb.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/pci_regs.h"
+#include "hw/usb/hcd-xhci.h"
+
+/*** Test Setup & Teardown ***/
+typedef struct XHCIQSlotState {
+    /* In-memory arrays */
+    uint64_t device_context;
+    uint64_t transfer_ring;
+
+    uint32_t tr_trb_entries;
+    uint32_t tr_trb_idx;
+    uint32_t tr_trb_c;
+} XHCIQSlotState;
+
+typedef struct XHCIQState {
+    /* QEMU PCI variables */
+    QOSState *parent;
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint64_t barsize;
+    uint32_t fingerprint;
+
+    /* In-memory arrays */
+    uint64_t dc_base_array;
+    uint64_t command_ring;
+    uint64_t event_ring_seg;
+    uint64_t event_ring;
+
+    uint32_t cr_trb_entries;
+    uint32_t cr_trb_idx;
+    uint32_t cr_trb_c;
+    uint32_t er_trb_entries;
+    uint32_t er_trb_idx;
+    uint32_t er_trb_c;
+
+    /* Host controller properties */
+    uint32_t rtoff, dboff;
+    uint32_t maxports, maxslots, maxintrs;
+
+    XHCIQSlotState slots[32];
+} XHCIQState;
+
+#define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
+                     PCI_VENDOR_ID_NEC)
+
+/**
+ * Locate, verify, and return a handle to the XHCI device.
+ */
+static QPCIDevice *get_xhci_device(QTestState *qts, uint32_t *fingerprint)
+{
+    QPCIDevice *xhci;
+    uint32_t xhci_fingerprint;
+    QPCIBus *pcibus;
+
+    pcibus = qpci_new_pc(qts, NULL);
+
+    /* Find the XHCI PCI device and verify it's the right one. */
+    xhci = qpci_device_find(pcibus, QPCI_DEVFN(0x1D, 0x0));
+    g_assert(xhci != NULL);
+
+    xhci_fingerprint = qpci_config_readl(xhci, PCI_VENDOR_ID);
+    switch (xhci_fingerprint) {
+    case XHCI_NEC_ID:
+        break;
+    default:
+        /* Unknown device. */
+        g_assert_not_reached();
+    }
+
+    if (fingerprint) {
+        *fingerprint = xhci_fingerprint;
+    }
+    return xhci;
+}
+
+static void free_xhci_device(QPCIDevice *dev)
+{
+    QPCIBus *pcibus = dev ? dev->bus : NULL;
+
+    /* libqos doesn't have a function for this, so free it manually */
+    g_free(dev);
+    qpci_free_pc(pcibus);
+}
+
+/**
+ * Start a Q35 machine and bookmark a handle to the XHCI device.
+ */
+G_GNUC_PRINTF(1, 0)
+static XHCIQState *xhci_vboot(const char *cli, va_list ap)
+{
+    XHCIQState *s;
+
+    s = g_new0(XHCIQState, 1);
+    s->parent = qtest_pc_vboot(cli, ap);
+    alloc_set_flags(&s->parent->alloc, ALLOC_LEAK_ASSERT);
+
+    /* Verify that we have an XHCI device present. */
+    s->dev = get_xhci_device(s->parent->qts, &s->fingerprint);
+    s->bar = qpci_iomap(s->dev, 0, &s->barsize);
+    /* turns on pci.cmd.iose, pci.cmd.mse and pci.cmd.bme */
+    qpci_device_enable(s->dev);
+
+    return s;
+}
+
+/**
+ * Start a Q35 machine and bookmark a handle to the XHCI device.
+ */
+G_GNUC_PRINTF(1, 2)
+static XHCIQState *xhci_boot(const char *cli, ...)
+{
+    XHCIQState *s;
+    va_list ap;
+
+    if (cli) {
+        va_start(ap, cli);
+        s = xhci_vboot(cli, ap);
+        va_end(ap);
+    } else {
+        s = xhci_boot("-M q35 "
+                      "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
+                      "-drive id=drive0,if=none,file=null-co://,"
+                          "file.read-zeroes=on,format=raw");
+    }
+
+    return s;
+}
+
+/**
+ * Clean up the PCI device, then terminate the QEMU instance.
+ */
+static void xhci_shutdown(XHCIQState *xhci)
+{
+    QOSState *qs = xhci->parent;
+
+    free_xhci_device(xhci->dev);
+    g_free(xhci);
+    qtest_shutdown(qs);
+}
+
+/*** tests ***/
 
 static void test_xhci_hotplug(void)
 {
-    usb_test_hotplug(global_qtest, "xhci", "1", NULL);
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot(NULL);
+    qts = s->parent->qts;
+
+    usb_test_hotplug(qts, "xhci", "1", NULL);
+
+    xhci_shutdown(s);
 }
 
 static void test_usb_uas_hotplug(void)
 {
-    QTestState *qts = global_qtest;
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot(NULL);
+    qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-uas", "uas", "{}");
     qtest_qmp_device_add(qts, "scsi-hd", "scsihd", "{'drive': 'drive0'}");
@@ -30,25 +187,353 @@ static void test_usb_uas_hotplug(void)
 
     qtest_qmp_device_del(qts, "scsihd");
     qtest_qmp_device_del(qts, "uas");
+
+    xhci_shutdown(s);
 }
 
 static void test_usb_ccid_hotplug(void)
 {
-    QTestState *qts = global_qtest;
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot(NULL);
+    qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
     qtest_qmp_device_del(qts, "ccid");
     /* check the device can be added again */
     qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
     qtest_qmp_device_del(qts, "ccid");
+
+    xhci_shutdown(s);
+}
+
+static uint64_t xhci_guest_zalloc(XHCIQState *s, uint64_t size)
+{
+    char mem[0x1000];
+    uint64_t ret;
+
+    g_assert(size <= 0x1000);
+
+    memset(mem, 0, size);
+
+    ret = guest_alloc(&s->parent->alloc, size);
+    qtest_memwrite(s->parent->qts, ret, mem, size);
+
+    return ret;
+}
+
+static uint32_t xhci_cap_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, addr);
+}
+
+static uint32_t xhci_op_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, 0x40 + addr);
+}
+
+static void xhci_op_writel(XHCIQState *s, uint64_t addr, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, 0x40 + addr, value);
+}
+
+static uint32_t xhci_port_readl(XHCIQState *s, uint32_t port, uint64_t addr)
+{
+    return xhci_op_readl(s, 0x400 + port * 0x10 + addr);
+}
+
+static uint32_t xhci_rt_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, s->rtoff + addr);
+}
+
+static void xhci_rt_writel(XHCIQState *s, uint64_t addr, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, s->rtoff + addr, value);
 }
 
+static void xhci_db_writel(XHCIQState *s, uint32_t db, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, s->dboff + db * 4, value);
+}
+
+static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
+{
+    XHCITRB t;
+    uint64_t er_addr = s->event_ring + s->er_trb_idx * sizeof(*trb);
+    uint32_t value;
+    guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+
+    /* Wait for event interrupt  */
+
+    do {
+        if (g_get_monotonic_time() >= end_time) {
+            g_error("Timeout expired");
+        }
+        qtest_clock_step(s->parent->qts, 10000);
+
+        value = xhci_op_readl(s, 0x4); /* USBSTS */
+    } while (!(value & USBSTS_EINT));
+
+    value = xhci_rt_readl(s, 0x20 + 0x0); /* IMAN */
+
+    /* With MSI-X enabled, IMAN IP is cleared after raising the interrupt */
+    g_assert(!(value & IMAN_IP));
+
+    /* Ensure MSI-X interrupt is pending */
+    assert(qpci_msix_test_clear_pending(s->dev, 0));
+    /* Then cleared */
+    assert(!qpci_msix_pending(s->dev, 0));
+
+    xhci_op_writel(s, 0x4, USBSTS_EINT); /* USBSTS clear EINT */
+
+    qtest_memread(s->parent->qts, er_addr, &t, sizeof(t));
+
+    trb->parameter = le64_to_cpu(t.parameter);
+    trb->status = le32_to_cpu(t.status);
+    trb->control = le32_to_cpu(t.control);
+
+    g_assert((trb->status >> 24) == CC_SUCCESS);
+    g_assert((trb->control & TRB_C) == s->er_trb_c); /* C bit has been set */
+
+    s->er_trb_idx++;
+    if (s->er_trb_idx == s->er_trb_entries) {
+        s->er_trb_idx = 0;
+        s->er_trb_c ^= 1;
+    }
+    /* Update ERDP to processed TRB addr and EHB bit, which clears EHB */
+    er_addr = s->event_ring + s->er_trb_idx * sizeof(*trb);
+    xhci_rt_writel(s, 0x38, (er_addr & 0xffffffff) | ERDP_EHB);
+}
+
+static void set_link_trb(XHCIQState *s, uint64_t ring, uint32_t c,
+                         uint32_t entries)
+{
+    XHCITRB trb;
+
+    g_assert(entries > 1);
+
+    memset(&trb, 0, sizeof(trb));
+    trb.parameter = cpu_to_le64(ring);
+    trb.control = cpu_to_le32(c | /* C */
+                              (TR_LINK << TRB_TYPE_SHIFT) |
+                              TRB_LK_TC);
+    qtest_memwrite(s->parent->qts, ring + sizeof(trb) * (entries - 1),
+                   &trb, sizeof(trb));
+}
+
+static void submit_cr_trb(XHCIQState *s, XHCITRB *trb)
+{
+    XHCITRB t;
+    uint64_t cr_addr = s->command_ring + s->cr_trb_idx * sizeof(*trb);
+
+    trb->control |= s->cr_trb_c; /* C */
+
+    t.parameter = cpu_to_le64(trb->parameter);
+    t.status = cpu_to_le32(trb->status);
+    t.control = cpu_to_le32(trb->control);
+
+    qtest_memwrite(s->parent->qts, cr_addr, &t, sizeof(t));
+    s->cr_trb_idx++;
+    /* Last entry contains the link, so wrap back */
+    if (s->cr_trb_idx == s->cr_trb_entries - 1) {
+        set_link_trb(s, s->command_ring, s->cr_trb_c, s->cr_trb_entries);
+        s->cr_trb_idx = 0;
+        s->cr_trb_c ^= 1;
+    }
+    xhci_db_writel(s, 0, 0); /* doorbell 0 */
+}
+
+/*
+ * This test brings up an endpoint and runs some noops through its command
+ * ring and gets responses back on the event ring.
+ *
+ * This could be librified in future (like AHCI0 to have a way to bring up
+ * an endpoint to test device protocols.
+ */
+static void pci_xhci_stress_rings(void)
+{
+    XHCIQState *s;
+    uint32_t value;
+    uint64_t input_context;
+    XHCIEvRingSeg ev_seg;
+    XHCITRB trb;
+    uint32_t hcsparams1;
+    uint32_t slotid;
+    g_autofree void *mem = g_malloc0(0x1000); /* buffer for writing to guest */
+    int i;
+
+    s = xhci_boot("-M q35 "
+            "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
+            "-device usb-storage,bus=xhci.0,drive=drive0 "
+            "-drive id=drive0,if=none,file=null-co://,"
+                "file.read-zeroes=on,format=raw "
+            );
+
+    hcsparams1 = xhci_cap_readl(s, 0x4); /* HCSPARAMS1 */
+    s->maxports = (hcsparams1 >> 24) & 0xff;
+    s->maxintrs = (hcsparams1 >> 8) & 0x3ff;
+    s->maxslots = hcsparams1 & 0xff;
+
+    s->dboff = xhci_cap_readl(s, 0x14); /* DBOFF */
+    s->rtoff = xhci_cap_readl(s, 0x18); /* RTOFF */
+
+    s->dc_base_array = xhci_guest_zalloc(s, 0x800);
+    s->command_ring = xhci_guest_zalloc(s, 0x1000);
+    s->event_ring = xhci_guest_zalloc(s, 0x1000);
+    s->event_ring_seg = xhci_guest_zalloc(s, 0x100);
+
+    /* Arbitrary small sizes so we can make them wrap */
+    s->cr_trb_entries = 0x20;
+    s->cr_trb_c = 1;
+    s->er_trb_entries = 0x10;
+    s->er_trb_c = 1;
+
+    ev_seg.addr_low = cpu_to_le32(s->event_ring & 0xffffffff);
+    ev_seg.addr_high = cpu_to_le32(s->event_ring >> 32);
+    ev_seg.size = cpu_to_le32(0x10);
+    ev_seg.rsvd = 0;
+    qtest_memwrite(s->parent->qts, s->event_ring_seg, &ev_seg, sizeof(ev_seg));
+
+    xhci_op_writel(s, 0x0, USBCMD_HCRST); /* USBCMD */
+    do {
+        value = xhci_op_readl(s, 0x4); /* USBSTS */
+    } while (value & (1 << 11)); /* CNR */
+
+    xhci_op_writel(s, 0x38, s->maxslots); /* CONFIG */
+
+    /* DCBAAP */
+    xhci_op_writel(s, 0x30, s->dc_base_array & 0xffffffff);
+    xhci_op_writel(s, 0x34, s->dc_base_array >> 32);
+
+    /* CRCR */
+    xhci_op_writel(s, 0x18, (s->command_ring & 0xffffffff) | s->cr_trb_c);
+    xhci_op_writel(s, 0x1c, s->command_ring >> 32);
+
+    xhci_rt_writel(s, 0x28, 1); /* ERSTSZ */
+
+    /* ERSTBA */
+    xhci_rt_writel(s, 0x30, s->event_ring_seg & 0xffffffff);
+    xhci_rt_writel(s, 0x34, s->event_ring_seg >> 32);
+
+    /* ERDP */
+    xhci_rt_writel(s, 0x38, s->event_ring & 0xffffffff);
+    xhci_rt_writel(s, 0x3c, s->event_ring >> 32);
+
+    qpci_msix_enable(s->dev);
+    xhci_op_writel(s, 0x0, USBCMD_RS | USBCMD_INTE); /* RUN + INTE */
+
+    /* Enable interrupts on ER IMAN */
+    xhci_rt_writel(s, 0x20, IMAN_IE);
+
+    assert(!qpci_msix_pending(s->dev, 0));
+
+    /* Wrap the command and event rings with no-ops a few times */
+    for (i = 0; i < 100; i++) {
+        /* Issue a command ring no-op */
+        memset(&trb, 0, sizeof(trb));
+        trb.control |= CR_NOOP << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        submit_cr_trb(s, &trb);
+        wait_event_trb(s, &trb);
+    }
+
+    /* Query ports */
+    for (i = 0; i < s->maxports; i++) {
+        value = xhci_port_readl(s, i, 0); /* PORTSC */
+
+        /* Only first port should be attached and enabled */
+        if (i == 0) {
+            g_assert(value & PORTSC_CCS);
+            g_assert(value & PORTSC_PED);
+            /* Port Speed must be identified (non-zero) */
+            g_assert(((value >> PORTSC_SPEED_SHIFT) & PORTSC_SPEED_MASK) != 0);
+        } else {
+            g_assert(!(value & PORTSC_CCS));
+            g_assert(!(value & PORTSC_PED));
+            g_assert(((value >> PORTSC_PLS_SHIFT) & PORTSC_PLS_MASK) == 5);
+        }
+    }
+
+    /* Issue a command ring enable slot */
+    memset(&trb, 0, sizeof(trb));
+    trb.control |= CR_ENABLE_SLOT << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    submit_cr_trb(s, &trb);
+    wait_event_trb(s, &trb);
+    slotid = (trb.control >> TRB_CR_SLOTID_SHIFT) & 0xff;
+
+    s->slots[slotid].transfer_ring = xhci_guest_zalloc(s, 0x1000);
+    s->slots[slotid].tr_trb_entries = 0x10;
+    s->slots[slotid].tr_trb_c = 1;
+
+    /* 32-byte input context size, should check HCCPARAMS1 for 64-byte size */
+    input_context = xhci_guest_zalloc(s, 0x420);
+
+    /* Set input control context */
+    ((uint32_t *)mem)[1] = cpu_to_le32(0x3); /* Add device contexts 0 and 1 */
+    ((uint32_t *)mem)[8] = cpu_to_le32(1 << 27); /* 1 context entry */
+    ((uint32_t *)mem)[9] = cpu_to_le32(1 << 16); /* 1 port number */
+
+    /* Set endpoint 0 context */
+    ((uint32_t *)mem)[16] = 0;
+    ((uint32_t *)mem)[17] = cpu_to_le32((ET_CONTROL << EP_TYPE_SHIFT) |
+                                        (0x200 << 16)); /* max packet sz XXX? */
+    ((uint32_t *)mem)[18] = cpu_to_le32((s->slots[slotid].transfer_ring &
+                                         0xffffffff) | 1); /* DCS=1 */
+    ((uint32_t *)mem)[19] = cpu_to_le32(s->slots[slotid].transfer_ring >> 32);
+    ((uint32_t *)mem)[20] = cpu_to_le32(0x200); /* Average TRB length */
+    qtest_memwrite(s->parent->qts, input_context, mem, 0x420);
+
+    s->slots[slotid].device_context = xhci_guest_zalloc(s, 0x400);
+
+    ((uint64_t *)mem)[0] = cpu_to_le64(s->slots[slotid].device_context);
+    qtest_memwrite(s->parent->qts, s->dc_base_array + 8 * slotid, mem, 8);
+
+    /* Issue a command ring address device */
+    memset(&trb, 0, sizeof(trb));
+    trb.parameter = input_context;
+    trb.control |= CR_ADDRESS_DEVICE << TRB_TYPE_SHIFT;
+    trb.control |= slotid << TRB_CR_SLOTID_SHIFT;
+    submit_cr_trb(s, &trb);
+    wait_event_trb(s, &trb);
+
+    /* XXX: Could check EP state is running */
+
+    /* Shut it down */
+    qpci_msix_disable(s->dev);
+
+    guest_free(&s->parent->alloc, s->slots[slotid].device_context);
+    guest_free(&s->parent->alloc, s->slots[slotid].transfer_ring);
+    guest_free(&s->parent->alloc, input_context);
+    guest_free(&s->parent->alloc, s->event_ring);
+    guest_free(&s->parent->alloc, s->event_ring_seg);
+    guest_free(&s->parent->alloc, s->command_ring);
+    guest_free(&s->parent->alloc, s->dc_base_array);
+
+    xhci_shutdown(s);
+}
+
+/* tests */
 int main(int argc, char **argv)
 {
     int ret;
+    const char *arch;
 
     g_test_init(&argc, &argv, NULL);
 
+    /* Check architecture */
+    arch = qtest_get_arch();
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        g_test_message("Skipping test for non-x86");
+        return 0;
+    }
+
+    if (!qtest_has_device("nec-usb-xhci")) {
+        return 0;
+    }
+
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     if (qtest_has_device("usb-uas")) {
         qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
@@ -56,11 +541,12 @@ int main(int argc, char **argv)
     if (qtest_has_device("usb-ccid")) {
         qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
     }
+    if (qtest_has_device("usb-storage")) {
+        qtest_add_func("/xhci/pci/xhci-stress-rings", pci_xhci_stress_rings);
+    }
 
-    qtest_start("-device nec-usb-xhci,id=xhci"
-                " -drive id=drive0,if=none,file=null-co://,"
-                "file.read-zeroes=on,format=raw");
     ret = g_test_run();
+
     qtest_end();
 
     return ret;
-- 
2.45.2


