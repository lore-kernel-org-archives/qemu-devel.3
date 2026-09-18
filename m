Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6879C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7bd4-0003QM-Hc; Fri, 18 Sep 2026 12:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bbz-0003G1-Ob; Fri, 18 Sep 2026 12:39:05 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bbr-0002hK-0l; Fri, 18 Sep 2026 12:38:50 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCAFF43D6B;
 Fri, 18 Sep 2026 16:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFE61F000FF;
 Fri, 18 Sep 2026 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789749523;
 bh=Ynlks6OjXe/uRxYnEgUbla/LudkyT55AVz8txJwfPoA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fZGVPD/6wcoLui2w1CANkELSoqGv/OSLoqZEyIsfOk/xbjM1kag0Ha1z8tRSOZqFW
 3ZeT/Qp0PoMLnGpkSMGhVm1fBgp6zcJo2MLTOVk4EXdn1VQA97oM3nME6Y8BO2QkrA
 WhQoXMh64/53ZmOTZ/Nn63UfJYabrVWaF6XrQNRXGtdYskVprfOJG+k43D7PU1Xer3
 Q1HbjX9CDCDx8aAj+KqtjSSuApJLYUWGr0Y1/sieRai5JF3bw/EVYC6+ztk0ng0YSr
 +Eq8WECbcRtOeGqPYEWgbU1zkGxZZ6mGu/GqvAOotVQmgOntL2qBAAX/6kfJAjGyAJ
 fIMXX8r9ano0w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Helge Deller <deller@gmx.de>, "Denis V. Lunev" <den@openvz.org>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Subject: [PULL 4/7] hw/usb/hcd-ohci: Add big endian and consistency check
 support
Date: Fri, 18 Sep 2026 18:38:25 +0200
Message-ID: <20260918163829.2917-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918163829.2917-1-deller@kernel.org>
References: <20260918163829.2917-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>

The OHCI controller allows running in big endian mode. If this mode is enabled, swap the
buffer contents before accessing them since we by default run OHCI in little endian mode.

Additionally add the architected consistency check which halts OHCI on errors.

Signed-off-by: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/usb/hcd-ohci.c | 35 +++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.h |  5 +++++
 2 files changed, 40 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 23990115ab..5e5fe41f47 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -74,6 +74,7 @@ struct ohci_hcca {
 /* Flags in the head field of an Endpoint Descriptor. */
 #define OHCI_ED_H         1
 #define OHCI_ED_C         2
+#define OHCI_ED_HEAD_RSVD   (1 << 2 | 1 << 3)
 
 /* Bitfields for the first word of a Transfer Descriptor. */
 #define OHCI_TD_R         (1 << 18)
@@ -371,6 +372,8 @@ void ohci_hard_reset(OHCIState *ohci)
     ohci_soft_reset(ohci);
     ohci->ctl = 0;
     ohci_roothub_reset(ohci);
+    ohci->big_endian = false;
+    ohci->consistency_check = false;
 }
 
 /* Get an array of dwords from main memory */
@@ -867,6 +870,18 @@ static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
     }
 }
 
+static void ohci_bswap_buf(uint8_t *buf, size_t len)
+{
+    uint32_t w;
+    while (len >= sizeof(w)) {
+        memcpy(&w, buf, sizeof(w));
+        w = bswap32(w);
+        memcpy(buf, &w, sizeof(w));
+        buf += sizeof(w);
+        len -= sizeof(w);
+    }
+}
+
 /*
  * Service a transport descriptor.
  * Returns nonzero to terminate processing of this endpoint.
@@ -975,6 +990,9 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
                                  DMA_DIRECTION_TO_DEVICE)) {
                     ohci_die(ohci);
                 }
+                if (ohci->big_endian) {
+                    ohci_bswap_buf(ohci->usb_buf, pktlen);
+                }
             }
         }
     }
@@ -1024,6 +1042,9 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
 
     if (ret >= 0) {
         if (dir == OHCI_TD_DIR_IN) {
+            if (ohci->big_endian) {
+                ohci_bswap_buf(ohci->usb_buf, ret);
+            }
             if (ohci_copy_td(ohci, &td, ohci->usb_buf, ret,
                              DMA_DIRECTION_FROM_DEVICE)) {
                 ohci_die(ohci);
@@ -1108,6 +1129,13 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         ohci->done_count = i;
     }
 exit_no_retire:
+    if (ohci->media_error) {
+        int cc = OHCI_BM(td.flags, TD_CC);
+        /* only these 2 errors will ever actually be possible in qemu */
+        if (cc == OHCI_CC_DEVICENOTRESPONDING || cc == OHCI_CC_UNDEXPETEDPID) {
+            ohci->media_error(ohci);
+        }
+    }
     if (ohci_put_td(ohci, addr, &td)) {
         ohci_die(ohci);
         return 1;
@@ -1136,6 +1164,13 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
             ohci_die(ohci);
             return 0;
         }
+        if (ohci->consistency_check && (ed.head & OHCI_ED_HEAD_RSVD)) {
+            if (ohci->descriptor_error) {
+                ohci->descriptor_error(ohci);
+            }
+            ohci_die(ohci);
+            return 0;
+        }
 
         next_ed = ed.next & OHCI_DPTR_MASK;
 
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 243cd1f46a..d079f8d24e 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -93,6 +93,11 @@ struct OHCIState {
     bool async_complete;
 
     void (*ohci_die)(OHCIState *ohci);
+    void (*media_error)(OHCIState *ohci);
+    void (*descriptor_error)(OHCIState *ohci);
+
+    bool big_endian;
+    bool consistency_check;
 };
 
 #define TYPE_SYSBUS_OHCI "sysbus-ohci"
-- 
2.54.0


