Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65E6C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7l-0004CO-2T; Thu, 01 May 2025 23:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7T-00049I-LZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7R-0001FQ-0K
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so1710947b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156679; x=1746761479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyx6RarOeQbfyFAQ0Udrqez9p+XhUS2Q4KG6PVcPYIE=;
 b=Gf2qCGigkrjIQU24mauowtQUpJn6ZvyVukQjAIuDPecBde4NK0iKR2yW5EKywPJrNR
 bdhYVSDFQpw8CB5jHu/pi8eoG6nKS44IMK1NHQJMXToVK1/gFOT+fOdEuXJrSkOERQyS
 7kqYCL8ZLMqirVPnMMQyggXZWGKJP8HlLYaQZnsHMqmwUJtA06A6YECLr74R27Q/eBHT
 p9mhhbCb1tDsqNxRYA6apRrvUGOF4bRiljSZKi0Ps8a25FLcoHvrTGoy9v6To3/vVsPY
 TY84DmJNKKpRXZDuYEJ2k74xV5pwhscujFDOIa4eBBiHAd4wpW9f/SYz0P2vVjElTEmC
 6KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156679; x=1746761479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyx6RarOeQbfyFAQ0Udrqez9p+XhUS2Q4KG6PVcPYIE=;
 b=m6y1gvKiQPZD884GH6kRldObBTGtOLS2FimEcExagoTW6Gix6+nKCwMubC5sQaj1/v
 zr9pP/49q6XjlKsrFJRIQx5JqyIdUehpFrr70QS5YjCeTUfGzqjswD0LZyjNiQgwCDW+
 MWvKzu0X3sNueghZPHVbNcBXrYHMqftkCAQAagmQQ0isu9FyC8IlmvtKnG51/xLwJk9e
 TZ4Rfo8ySukVEU/eAxBlzAT1yaUnHxgKN4mfCTWrl2Tdq4bvhNPwpgRVLamM+TYDcJ0Y
 bhpj6FGJqjx+T2PMe07CPVuGzFYMFbVVEtM5zrOvlUg6dQfiyhgz+96CfbCmxQjET1lj
 gayw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGnaH1y3RpPyLz8ae2DOc8YpkdWpTxra8zv+QPhOD5OzmbvUEL1EVIWvXap8ywjUS8u8Gv6At9t1gJ@nongnu.org
X-Gm-Message-State: AOJu0Yxb/81Q9ST+5FWg1jQyOkaAPU7/uDasXSmGXQmdWo54J6ntdRvT
 UmQwvSuunqWMs5j5JLNh7eRyuWWA0sjT2NNw0dNcOoST4HoqcmKL
X-Gm-Gg: ASbGncs1D6LWUpm+JMf5d/zhrc96hWlDP/zKZcT6R6m8D/9U5EVRNQX3B5XE/8NUIv5
 OOlzSrpCP/vZ9sKPG3eYOnBG8TeKBPWhQp1hf9Zn74gmeVKjgapPYZBRU7Y5NyR4K9WyPUFxp6H
 MnLt8Zidng2zg+lzNm/DIBCQ1dwDVkcvzVZIuAY6vXc/SL4jf+h7f1pkKJqSggk9acUQVcrfkFQ
 zIYZg1go9JEKA9XGBuUhhkHU7UYsdqdlNcaOGe31eewmJuaWEbScQZvJgPNRDokOdmdxWdy8sm7
 6UozkNHosn+D1216w4yqvlJx9vspjEM6WUfJt0yb1WQc
X-Google-Smtp-Source: AGHT+IH4BJN80gWH8MS7zfoXc/RelSfvAIuXQSqmVphRO0k92l9u45dj1o7POMFYQKK7zNkHcrmsUw==
X-Received: by 2002:aa7:8e0e:0:b0:740:595b:c2f4 with SMTP id
 d2e1a72fcca58-740595bc464mr1049281b3a.5.1746156679286; 
 Thu, 01 May 2025 20:31:19 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 04/22] tests/qtest/xhci: Add controller and device setup
 and ring tests
Date: Fri,  2 May 2025 13:30:28 +1000
Message-ID: <20250502033047.102465-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci.h               |   7 +
 hw/usb/hcd-xhci.c               |   7 -
 tests/qtest/usb-hcd-xhci-test.c | 336 ++++++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+), 7 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 20059fcf66c..02a005ce78d 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -350,6 +350,13 @@ typedef struct XHCIRing {
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
index c12b72cb9d8..ef9f2a7db41 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -128,13 +128,6 @@ struct XHCIEPContext {
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
index abdd52c444c..291d1dfc36e 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "libqtest.h"
 #include "libqtest-single.h"
 #include "libqos/libqos.h"
@@ -15,6 +16,8 @@
 #include "libqos/usb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
+#include "hw/pci/pci_regs.h"
+#include "hw/usb/hcd-xhci.h"
 
 typedef struct TestData {
     const char *device;
@@ -22,6 +25,22 @@ typedef struct TestData {
 } TestData;
 
 /*** Test Setup & Teardown ***/
+
+/* Transfer-Ring state */
+typedef struct XHCIQTRState {
+    uint64_t addr; /* In-memory ring */
+
+    uint32_t trb_entries;
+    uint32_t trb_idx;
+    uint32_t trb_c;
+} XHCIQTRState;
+
+typedef struct XHCIQSlotState {
+    /* In-memory device context array */
+    uint64_t device_context;
+    XHCIQTRState transfer_ring[31]; /* 1 for each EP */
+} XHCIQSlotState;
+
 typedef struct XHCIQState {
     /* QEMU PCI variables */
     QOSState *parent;
@@ -29,6 +48,21 @@ typedef struct XHCIQState {
     QPCIBar bar;
     uint64_t barsize;
     uint32_t fingerprint;
+
+    /* In-memory arrays */
+    uint64_t dc_base_array;
+    uint64_t event_ring_seg;
+    XHCIQTRState command_ring;
+    XHCIQTRState event_ring;
+
+    /* Host controller properties */
+    uint32_t rtoff, dboff;
+    uint32_t maxports, maxslots, maxintrs;
+
+    /* Current properties */
+    uint32_t slotid; /* enabled slot id (only enable one) */
+
+    XHCIQSlotState slots[32];
 } XHCIQState;
 
 #define XHCI_QEMU_ID (PCI_DEVICE_ID_REDHAT_XHCI << 16 | \
@@ -160,6 +194,8 @@ static void test_usb_uas_hotplug(const void *arg)
 
     qtest_qmp_device_del(qts, "scsihd");
     qtest_qmp_device_del(qts, "uas");
+
+    xhci_shutdown(s);
 }
 
 static void test_usb_ccid_hotplug(const void *arg)
@@ -176,6 +212,305 @@ static void test_usb_ccid_hotplug(const void *arg)
     /* check the device can be added again */
     qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
     qtest_qmp_device_del(qts, "ccid");
+
+    xhci_shutdown(s);
+}
+
+static uint64_t xhci_guest_zalloc(XHCIQState *s, uint64_t size)
+{
+    uint64_t ret;
+
+    ret = guest_alloc(&s->parent->alloc, size);
+    g_assert(ret);
+    qtest_memset(s->parent->qts, ret, 0, size);
+
+    return ret;
+}
+
+static uint32_t xhci_cap_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, XHCI_REGS_OFFSET_CAP + addr);
+}
+
+static uint32_t xhci_op_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, XHCI_REGS_OFFSET_OPER + addr);
+}
+
+static void xhci_op_writel(XHCIQState *s, uint64_t addr, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, XHCI_REGS_OFFSET_OPER + addr, value);
+}
+
+static uint32_t xhci_port_readl(XHCIQState *s, uint32_t port, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar,
+                         XHCI_REGS_OFFSET_PORT + port * XHCI_PORT_PR_SZ + addr);
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
+}
+
+static uint32_t xhci_intr_readl(XHCIQState *s, uint32_t intr, uint64_t addr)
+{
+    return xhci_rt_readl(s, XHCI_INTR_REG_IR0 +
+                            intr * XHCI_INTR_IR_SZ + addr);
+}
+
+
+static void xhci_intr_writel(XHCIQState *s, uint32_t intr, uint64_t addr,
+                             uint32_t value)
+{
+    xhci_rt_writel(s, XHCI_INTR_REG_IR0 +
+                      intr * XHCI_INTR_IR_SZ + addr, value);
+}
+
+static void xhci_db_writel(XHCIQState *s, uint32_t db, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, s->dboff + db * XHCI_DBELL_DB_SZ, value);
+}
+
+static bool xhci_test_isr(XHCIQState *s)
+{
+    return xhci_op_readl(s, XHCI_OPER_REG_USBSTS) & XHCI_USBSTS_EINT;
+}
+
+static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
+{
+    XHCITRB t;
+    XHCIQTRState *tr = &s->event_ring;
+    uint64_t er_addr = tr->addr + tr->trb_idx * TRB_SIZE;
+    uint32_t value;
+    guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+
+    /* Wait for event interrupt  */
+    while (!xhci_test_isr(s)) {
+        if (g_get_monotonic_time() >= end_time) {
+            g_error("Timeout expired");
+        }
+        qtest_clock_step(s->parent->qts, 10000);
+    }
+
+    /* With MSI-X enabled, IMAN IP is cleared after raising the interrupt */
+    value = xhci_intr_readl(s, 0, XHCI_INTR_REG_IMAN);
+    g_assert(!(value & XHCI_IMAN_IP));
+
+    xhci_op_writel(s, XHCI_OPER_REG_USBSTS, XHCI_USBSTS_EINT); /* clear EINT */
+
+    qtest_memread(s->parent->qts, er_addr, &t, TRB_SIZE);
+
+    trb->parameter = le64_to_cpu(t.parameter);
+    trb->status = le32_to_cpu(t.status);
+    trb->control = le32_to_cpu(t.control);
+
+    g_assert((trb->status >> 24) == CC_SUCCESS);
+    g_assert((trb->control & TRB_C) == tr->trb_c); /* C bit has been set */
+
+    tr->trb_idx++;
+    if (tr->trb_idx == tr->trb_entries) {
+        tr->trb_idx = 0;
+        tr->trb_c ^= 1;
+    }
+    /* Update ERDP to processed TRB addr and EHB bit, which clears EHB */
+    er_addr = tr->addr + tr->trb_idx * TRB_SIZE;
+    xhci_intr_writel(s, 0, XHCI_INTR_REG_ERDP_LO,
+                     (er_addr & 0xffffffff) | XHCI_ERDP_EHB);
+}
+
+static void set_link_trb(XHCIQState *s, uint64_t ring, uint32_t c,
+                         uint32_t entries)
+{
+    XHCITRB trb;
+
+    g_assert(entries > 1);
+
+    memset(&trb, 0, TRB_SIZE);
+    trb.parameter = ring;
+    trb.control = cpu_to_le32(c | /* C */
+                              (TR_LINK << TRB_TYPE_SHIFT) |
+                              TRB_LK_TC);
+    qtest_memwrite(s->parent->qts, ring + TRB_SIZE * (entries - 1),
+                   &trb, TRB_SIZE);
+}
+
+static uint64_t queue_trb(XHCIQState *s, XHCIQTRState *tr, const XHCITRB *trb)
+{
+    uint64_t tr_addr = tr->addr + tr->trb_idx * TRB_SIZE;
+    XHCITRB t;
+
+    t.parameter = cpu_to_le64(trb->parameter);
+    t.status = cpu_to_le32(trb->status);
+    t.control = cpu_to_le32(trb->control | tr->trb_c);
+
+    qtest_memwrite(s->parent->qts, tr_addr, &t, TRB_SIZE);
+    tr->trb_idx++;
+    /* Last entry contains the link, so wrap back */
+    if (tr->trb_idx == tr->trb_entries - 1) {
+        set_link_trb(s, tr->addr, tr->trb_c, tr->trb_entries);
+        tr->trb_idx = 0;
+        tr->trb_c ^= 1;
+    }
+
+    return tr_addr;
+}
+
+static uint64_t submit_cr_trb(XHCIQState *s, const XHCITRB *trb)
+{
+    XHCIQTRState *tr = &s->command_ring;
+    uint64_t ret;
+
+    ret = queue_trb(s, tr, trb);
+
+    xhci_db_writel(s, 0, 0); /* doorbell host, doorbell 0 (command) */
+
+    return ret;
+}
+
+static void xhci_enable_device(XHCIQState *s)
+{
+    XHCIQTRState *tr;
+    XHCIEvRingSeg ev_seg;
+    uint32_t hcsparams1;
+    uint32_t value;
+    int i;
+
+    qpci_msix_enable(s->dev);
+
+    hcsparams1 = xhci_cap_readl(s, XHCI_HCCAP_REG_HCSPARAMS1);
+    s->maxports = (hcsparams1 >> 24) & 0xff;
+    s->maxintrs = (hcsparams1 >> 8) & 0x3ff;
+    s->maxslots = hcsparams1 & 0xff;
+
+    s->dboff = xhci_cap_readl(s, XHCI_HCCAP_REG_DBOFF);
+    s->rtoff = xhci_cap_readl(s, XHCI_HCCAP_REG_RTSOFF);
+
+    s->dc_base_array = xhci_guest_zalloc(s, 0x800);
+    s->event_ring_seg = xhci_guest_zalloc(s, 0x100);
+
+    /* Arbitrary small sizes so we can make them wrap */
+    tr = &s->command_ring;
+    tr->addr = xhci_guest_zalloc(s, 0x1000);
+    tr->trb_entries = 0x20;
+    tr->trb_c = 1;
+
+    tr = &s->event_ring;
+    tr->addr = xhci_guest_zalloc(s, 0x1000);
+    tr->trb_entries = 0x10;
+    tr->trb_c = 1;
+
+    tr = &s->event_ring;
+    ev_seg.addr_low = cpu_to_le32(tr->addr & 0xffffffff);
+    ev_seg.addr_high = cpu_to_le32(tr->addr >> 32);
+    ev_seg.size = cpu_to_le32(tr->trb_entries);
+    ev_seg.rsvd = 0;
+    qtest_memwrite(s->parent->qts, s->event_ring_seg, &ev_seg, sizeof(ev_seg));
+
+    xhci_op_writel(s, XHCI_OPER_REG_USBCMD, XHCI_USBCMD_HCRST);
+    do {
+        value = xhci_op_readl(s, XHCI_OPER_REG_USBSTS);
+    } while (value & XHCI_USBSTS_CNR);
+
+    xhci_op_writel(s, XHCI_OPER_REG_CONFIG, s->maxslots);
+
+    xhci_op_writel(s, XHCI_OPER_REG_DCBAAP_LO, s->dc_base_array & 0xffffffff);
+    xhci_op_writel(s, XHCI_OPER_REG_DCBAAP_HI, s->dc_base_array >> 32);
+
+    tr = &s->command_ring;
+    xhci_op_writel(s, XHCI_OPER_REG_CRCR_LO,
+                   (tr->addr & 0xffffffff) | tr->trb_c);
+    xhci_op_writel(s, XHCI_OPER_REG_CRCR_HI, tr->addr >> 32);
+
+    xhci_intr_writel(s, 0, XHCI_INTR_REG_ERSTSZ, 1);
+
+    xhci_intr_writel(s, 0, XHCI_INTR_REG_ERSTBA_LO,
+                     s->event_ring_seg & 0xffffffff);
+    xhci_intr_writel(s, 0, XHCI_INTR_REG_ERSTBA_HI,
+                     s->event_ring_seg >> 32);
+
+    /* ERDP */
+    tr = &s->event_ring;
+    xhci_intr_writel(s, 0, XHCI_INTR_REG_ERDP_LO, tr->addr & 0xffffffff);
+    xhci_intr_writel(s, 0, XHCI_INTR_REG_ERDP_HI, tr->addr >> 32);
+
+    xhci_op_writel(s, XHCI_OPER_REG_USBCMD, XHCI_USBCMD_RS | XHCI_USBCMD_INTE);
+
+    /* Enable interrupts on ER IMAN */
+    xhci_intr_writel(s, 0, XHCI_INTR_REG_IMAN, XHCI_IMAN_IE);
+
+    /* Ensure there is no interrupt pending */
+    g_assert(!xhci_test_isr(s));
+
+    /* Query ports */
+    for (i = 0; i < s->maxports; i++) {
+        value = xhci_port_readl(s, i, 0); /* PORTSC */
+
+        /* All ports should be disabled */
+        g_assert(!(value & XHCI_PORTSC_CCS));
+        g_assert(!(value & XHCI_PORTSC_PED));
+        g_assert(((value >> XHCI_PORTSC_PLS_SHIFT) &
+                  XHCI_PORTSC_PLS_MASK) == 5);
+    }
+}
+
+static void xhci_disable_device(XHCIQState *s)
+{
+    int i;
+
+    /* Shut it down */
+    qpci_msix_disable(s->dev);
+
+    guest_free(&s->parent->alloc, s->slots[s->slotid].device_context);
+    for (i = 0; i < 31; i++) {
+        guest_free(&s->parent->alloc,
+                   s->slots[s->slotid].transfer_ring[i].addr);
+    }
+    guest_free(&s->parent->alloc, s->event_ring.addr);
+    guest_free(&s->parent->alloc, s->command_ring.addr);
+    guest_free(&s->parent->alloc, s->event_ring_seg);
+    guest_free(&s->parent->alloc, s->dc_base_array);
+}
+
+/*
+ * This test brings up an endpoint and runs some noops through its command
+ * ring and gets responses back on the event ring, then brings up a device
+ * context and runs some noops through its transfer ring (if available).
+ */
+static void test_xhci_stress_rings(const void *arg)
+{
+    const TestData *td = arg;
+    XHCIQState *s;
+    XHCITRB trb;
+    uint64_t tag;
+    int i;
+
+    s = xhci_boot("-M q35 "
+                  "-device %s,id=xhci,bus=pcie.0,addr=1d.0 ",
+                  td->device);
+    g_assert_cmphex(s->fingerprint, ==, td->fingerprint);
+
+    xhci_enable_device(s);
+
+    /* Wrap the command and event rings with no-ops a few times */
+    for (i = 0; i < 100; i++) {
+        /* Issue a command ring no-op */
+        memset(&trb, 0, TRB_SIZE);
+        trb.control |= CR_NOOP << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        tag = submit_cr_trb(s, &trb);
+        wait_event_trb(s, &trb);
+        g_assert_cmphex(trb.parameter , ==, tag);
+        g_assert_cmpint(TRB_TYPE(trb), ==, ER_COMMAND_COMPLETE);
+    }
+
+    xhci_disable_device(s);
+    xhci_shutdown(s);
 }
 
 static void add_test(const char *name, TestData *td, void (*fn)(const void *))
@@ -194,6 +529,7 @@ static void add_tests(TestData *td)
     if (qtest_has_device("usb-ccid")) {
         add_test("usb-ccid", td, test_usb_ccid_hotplug);
     }
+    add_test("xhci-stress-rings", td, test_xhci_stress_rings);
 }
 
 /* tests */
-- 
2.47.1


