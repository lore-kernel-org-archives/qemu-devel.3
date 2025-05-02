Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24DEC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8v-0006xq-WC; Thu, 01 May 2025 23:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8s-0006do-Qk
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8q-0001O2-OK
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:50 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1848785b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156767; x=1746761567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOGwADERVvXg781RmsL0xZJHu1Zpu23r1/TsBfdql40=;
 b=RUrN3DqHJ0mUNqRdkeGeClpcssCTgGdltB2Sz5lyJxV8hecQRTTl+zfXsSZc2UVpYa
 k0XBGMIcNOTa5zAKzN9i64vU4KboH1VwCC8lZNPzrb9BfO+2Qf/OaW6sMxfLhMT0JK5E
 0AUa15GZnnpRmyqwpq9nbrdQbv5jSp7rJrWsOrS1QFAkROXLrRe6YHJ2UWYBK63aHiud
 +F+ew1DgxpXSmw8F0Dt3Q49jf4JVB8mQAHxSD0KmxmDjnUfcPT1/dWB3U9nH8SzgdjXQ
 Mck2kPA5Bsosq4nhV2qW5M3pZfwttiDDV1RMvMe8KybqBL4b79jSGWd+S22ix3ZwW0dZ
 3xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156767; x=1746761567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOGwADERVvXg781RmsL0xZJHu1Zpu23r1/TsBfdql40=;
 b=gKNvGpvIF9Le505Rdx2WOEOdSt1Usf1lzS0oMxQGk8nbIyc+gzbnG3mysjR7NUpV1m
 3vpV2WUUh6d7pUCbSsSbsjMrfTxX0mQMv2nTQCgh4YGy1X6TL0bcHCfqLEyT98M+rx0P
 IsLHd9PMWwbJ3jD5WWqChvKrmwHE85c/kJR3QFIuu8cqswDBCNNTEl1NbxnKaypGw0hI
 Ts2zF8v6JG13hEC4crfvKccl8J8QTDJ/ruMdzkRQTTDOJ7bLM07DDHPRYshL1VT1u24z
 fWASa0eIt1qXSf2Q2XcLHFLTMdJFtQkyLlR4WwihVWCvKP6KxIYHZ+A+7EUXdKUMsiVE
 013w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ5IdF52z/5+MTnGhnI5NTxh5GZ62sfMPQCTGsUdUrQB9LhjLM/QehTj2kkCWiHSUhlpGwpt9d/kkf@nongnu.org
X-Gm-Message-State: AOJu0Yxg35/nMAiRs9QPTcz5NrO77FgqY91MypdQ5IebKdteMhdfXeZH
 K7bUXcyjgzAPLW33Br0MkqYUbX0yPc33XTXVoqVJpdsTslP+pNYb
X-Gm-Gg: ASbGncuexcZ3ocvKoopStr0yRwa9xCJFTGhLK4SLQinpyGOv9dCIEh3/aU/DpJdX9O3
 Q4LyL+GV5TS6M7bHhMAikZlFerKNpo1I/8h/qfQYQNUh35X+vpwfeqrip4Uj8NEpNDmIw4ABjdR
 Gr50D6u6Ck5jkE77ZczYHkizqHGeceQAa3tgBT/mz7Z+y5JeH3NvfjfEmcsSQssQwTK0h945c+M
 lUgHuvuo8janxYw4iYiUAgI86K8TB4+H9C0vrNTTSRDXoqB4nrX0eAwE2JWvv9d0qo8q7fgfzJM
 487+/HaO3hK9QBKEKdguK3tl+wfpnN0VisWAC3VP+wy3
X-Google-Smtp-Source: AGHT+IFvRJI7Dh6/uFThU+y/se4og3amgMJ02k4Btom5a+oiHKKxDXy7jaR8pGRixJFOzwFdNLPZmw==
X-Received: by 2002:a05:6a20:7d9e:b0:1fd:f4df:9a89 with SMTP id
 adf61e73a8af0-20cded435edmr1793021637.25.1746156767391; 
 Thu, 01 May 2025 20:32:47 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:47 -0700 (PDT)
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
Subject: [PATCH v4 21/22] tests/qtest/xhci: Test USB Mass Storage relaxed CSW
 order
Date: Fri,  2 May 2025 13:30:45 +1000
Message-ID: <20250502033047.102465-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

This adds a qtest for the improvement to the MSD protocol that
allows an IN packet before the CBW packet. Send a CSW packet
before a zero-length CBW command packet is sent. This test would
fail with the MSD change reverted.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 180 ++++++++++++++++++++++++++++----
 1 file changed, 158 insertions(+), 22 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 428200d9e41..740e9cd3815 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -287,11 +287,48 @@ static bool xhci_test_isr(XHCIQState *s)
                                     s->guest_msix_addr, s->msix_data);
 }
 
-static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
+static bool check_event_trb(XHCIQState *s, XHCITRB *trb)
 {
+    XHCIQTRState *tr = &s->event_ring;
+    uint64_t er_addr = tr->addr + tr->trb_idx * TRB_SIZE;
     XHCITRB t;
+
+    qtest_memread(s->parent->qts, er_addr, &t, TRB_SIZE);
+    trb->parameter = le64_to_cpu(t.parameter);
+    trb->status = le32_to_cpu(t.status);
+    trb->control = le32_to_cpu(t.control);
+
+    return ((trb->control & TRB_C) == tr->trb_c);
+}
+
+static void consume_event(XHCIQState *s)
+{
     XHCIQTRState *tr = &s->event_ring;
     uint64_t er_addr = tr->addr + tr->trb_idx * TRB_SIZE;
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
+static bool try_get_event_trb(XHCIQState *s, XHCITRB *trb)
+{
+    if (check_event_trb(s, trb)) {
+        consume_event(s);
+        return true;
+    }
+    return false;
+}
+
+static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
+{
+    XHCIQTRState *tr = &s->event_ring;
     uint32_t value;
     guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
 
@@ -306,30 +343,24 @@ static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
     value = xhci_op_readl(s, XHCI_OPER_REG_USBSTS);
     g_assert(value & XHCI_USBSTS_EINT);
 
-    /* With MSI-X enabled, IMAN IP is cleared after raising the interrupt */
-    value = xhci_intr_readl(s, 0, XHCI_INTR_REG_IMAN);
-    g_assert(!(value & XHCI_IMAN_IP));
-
-    xhci_op_writel(s, XHCI_OPER_REG_USBSTS, XHCI_USBSTS_EINT); /* clear EINT */
-
-    qtest_memread(s->parent->qts, er_addr, &t, TRB_SIZE);
-
-    trb->parameter = le64_to_cpu(t.parameter);
-    trb->status = le32_to_cpu(t.status);
-    trb->control = le32_to_cpu(t.control);
+    if (0) {
+        /*
+         * With MSI-X enabled, IMAN IP is cleared after raising the interrupt,
+         * but if concurrent events may be occurring, it could be set again.
+         */
+        value = xhci_intr_readl(s, 0, XHCI_INTR_REG_IMAN);
+        g_assert(!(value & XHCI_IMAN_IP));
+    }
 
-    g_assert((trb->status >> 24) == CC_SUCCESS);
+    if (!check_event_trb(s, trb)) {
+        g_assert_not_reached();
+    }
+    g_assert_cmpint((trb->status >> 24), ==, CC_SUCCESS);
     g_assert((trb->control & TRB_C) == tr->trb_c); /* C bit has been set */
 
-    tr->trb_idx++;
-    if (tr->trb_idx == tr->trb_entries) {
-        tr->trb_idx = 0;
-        tr->trb_c ^= 1;
-    }
-    /* Update ERDP to processed TRB addr and EHB bit, which clears EHB */
-    er_addr = tr->addr + tr->trb_idx * TRB_SIZE;
-    xhci_intr_writel(s, 0, XHCI_INTR_REG_ERDP_LO,
-                     (er_addr & 0xffffffff) | XHCI_ERDP_EHB);
+    xhci_op_writel(s, XHCI_OPER_REG_USBSTS, XHCI_USBSTS_EINT); /* clear EINT */
+
+    consume_event(s);
 }
 
 static void set_link_trb(XHCIQState *s, uint64_t ring, uint32_t c,
@@ -763,6 +794,106 @@ static ssize_t xhci_submit_scsi_cmd(XHCIQState *s,
     return data_len - le32_to_cpu(csw.residue); /* bytes copied */
 }
 
+/*
+ * Submit command with CSW sent ahead of CBW.
+ * Can only be no-data or data-out commands (because a data-in command
+ * would interpret the CSW as a data-in).
+ */
+static ssize_t xhci_submit_out_of_order_scsi_cmd(XHCIQState *s,
+                                    const uint8_t *cmd, uint8_t cmd_len,
+                                    void *data, uint32_t data_len)
+{
+    struct usb_msd_cbw cbw;
+    struct usb_msd_csw csw;
+    uint64_t trb_data, csw_data;
+    XHCITRB trb, csw_trb;
+    uint64_t tag, csw_tag;
+    bool got_csw = false;
+
+    /* TRB data payload */
+    trb_data = xhci_guest_zalloc(s, data_len > sizeof(cbw) ? data_len : sizeof(cbw));
+    csw_data = xhci_guest_zalloc(s, sizeof(csw));
+
+    /* Issue a transfer ring ep 2 data (in) */
+    memset(&csw_trb, 0, TRB_SIZE);
+    csw_trb.parameter = csw_data;
+    csw_trb.status = sizeof(csw);
+    csw_trb.control |= TR_NORMAL << TRB_TYPE_SHIFT;
+    csw_trb.control |= TRB_TR_IOC;
+    csw_tag = submit_tr_trb(s, s->slotid, 2, &csw_trb);
+
+    memset(&cbw, 0, sizeof(cbw));
+    cbw.sig = cpu_to_le32(0x43425355);
+    cbw.tag = cpu_to_le32(0);
+    cbw.data_len = cpu_to_le32(data_len);
+    cbw.flags = 0x00;
+    cbw.lun = 0;
+    cbw.cmd_len = cmd_len; /* cmd len */
+    memcpy(cbw.cmd, cmd, cmd_len);
+    qtest_memwrite(s->parent->qts, trb_data, &cbw, sizeof(cbw));
+
+    /* Issue a transfer ring ep 3 data (out) */
+    memset(&trb, 0, TRB_SIZE);
+    trb.parameter = trb_data;
+    trb.status = sizeof(cbw);
+    trb.control |= TR_NORMAL << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    tag = submit_tr_trb(s, s->slotid, 3, &trb);
+
+    wait_event_trb(s, &trb);
+    if (trb.parameter == csw_tag) {
+        g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+        got_csw = true;
+        if (!try_get_event_trb(s, &trb)) {
+            wait_event_trb(s, &trb);
+        }
+    }
+    g_assert_cmphex(trb.parameter, ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+
+    if (data_len) {
+        qtest_memwrite(s->parent->qts, trb_data, data, data_len);
+
+        /* Issue a transfer ring ep 3 data (out) */
+        memset(&trb, 0, TRB_SIZE);
+        trb.parameter = trb_data;
+        trb.status = data_len; /* data_len bytes, no more packets */
+        trb.control |= TR_NORMAL << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        tag = submit_tr_trb(s, s->slotid, 3, &trb);
+        wait_event_trb(s, &trb);
+        if (trb.parameter == csw_tag) {
+            g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+            got_csw = true;
+            if (!try_get_event_trb(s, &trb)) {
+                wait_event_trb(s, &trb);
+            }
+        }
+        g_assert_cmphex(trb.parameter, ==, tag);
+        g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+    } else {
+        /* No data */
+    }
+
+    if (!got_csw) {
+        wait_event_trb(s, &csw_trb);
+        g_assert_cmphex(csw_trb.parameter, ==, csw_tag);
+        g_assert_cmpint(TRB_TYPE(csw_trb), ==, ER_TRANSFER);
+    }
+
+    qtest_memread(s->parent->qts, csw_data, &csw, sizeof(csw));
+
+    guest_free(&s->parent->alloc, trb_data);
+    guest_free(&s->parent->alloc, csw_data);
+
+    g_assert(csw.sig == cpu_to_le32(0x53425355));
+    g_assert(csw.tag == cpu_to_le32(0));
+    if (csw.status) {
+        return -1;
+    }
+    return data_len - le32_to_cpu(csw.residue); /* bytes copied */
+}
+
 #include "scsi/constants.h"
 
 static void xhci_test_msd(XHCIQState *s)
@@ -797,6 +928,11 @@ static void xhci_test_msd(XHCIQState *s)
         g_assert_not_reached();
     }
 
+    /* Try an "out of order" command */
+    if (xhci_submit_out_of_order_scsi_cmd(s, scsi_cmd, 6, mem, 0) < 0) {
+        g_assert_not_reached();
+    }
+
     /* Report LUNs */
     memset(scsi_cmd, 0, sizeof(scsi_cmd));
     scsi_cmd[0] = REPORT_LUNS;
-- 
2.47.1


