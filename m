Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A921DC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiljp-0007Xk-OK; Sun, 12 Jul 2026 00:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilie-0006SQ-MQ; Sun, 12 Jul 2026 00:23:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilic-0007OT-V8; Sun, 12 Jul 2026 00:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=IIyXBgs7Q7EyMmBK59bS0SPSGlYTJC1VKc2b5fdm0AI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gxfkh7nZyDMHlZXxREu9k/BRcwQo5ZqaX7Ty6WTQtDNMdF4LGyjQRIRgvKAKDnpTg
 g7sQ3gP2j145oD24B3fztgsW6lxDRnUZxBwSTSjZ9z+h4j0nnwlzKU7CxGjesSDQUW
 lYYrfs7ZKbt+E5GusSZgk7f7S4LJU/qNKVsQXGrCLNnbpqYcx7xgbDOGs4Nic8lkPS
 XAm/Djq74KNOfMfZL9mzxejZKRzwGH6r0YSpVGmVAZC+Y8nVqIraSudD8jcRMcwkUT
 5B+KU8BZPjxu1/ABi8dMHrrrbEbHwL/8DuOJenN7iBR39X67j5kCbL6VqhQaaSubRQ
 L15sEg+BkvBVA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6E7AD1C0C23;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A18783EB983;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C0E8313449; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 72/75] hw/pci/pcie_doe: Check mailbox length for
 overflows
Date: Sun, 12 Jul 2026 07:15:30 +0300
Message-ID: <20260712041539.108341-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

It was possible that a guest could overflow the `doe_cap->write_mbox`
buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
`doe_cap->write_mbox_len` would continue to increment and there were no
bounds checks on the length when offsetting into doe_cap->write_mbox.

This patch adds a check and reports a guest error if we would overflow.

On an overflow we also silenty discard the entire object as instructed
to do in the PCIe spec when the length specified in the header
(up to PCI_DOE_DW_SIZE_MAX dwords) doesn't match the length of the
object.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
Message-ID: <20260707020750.788960-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit c7e61854544be3ebcc001a33d41807947866a739)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
index 2210f869681..1bc2b457816 100644
--- a/hw/pci/pcie_doe.c
+++ b/hw/pci/pcie_doe.c
@@ -78,14 +78,21 @@ static bool pcie_doe_discovery(DOECap *doe_cap)
     return true;
 }
 
+static void pcie_doe_reset_write_mbox(DOECap *st)
+{
+    st->write_mbox_len = 0;
+
+    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+}
+
 static void pcie_doe_reset_mbox(DOECap *st)
 {
     st->read_mbox_idx = 0;
     st->read_mbox_len = 0;
-    st->write_mbox_len = 0;
 
     memset(st->read_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
-    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+
+    pcie_doe_reset_write_mbox(st);
 }
 
 void pcie_doe_init(PCIDevice *dev, DOECap *doe_cap, uint16_t offset,
@@ -356,8 +363,20 @@ void pcie_doe_write_config(DOECap *doe_cap,
         if (size != DWORD_BYTE) {
             return;
         }
-        doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
-        doe_cap->write_mbox_len++;
+        if (doe_cap->write_mbox_len < PCI_DOE_DW_SIZE_MAX) {
+            doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
+            doe_cap->write_mbox_len++;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Mailbox write length (%d) overflow\n",
+                          doe_cap->write_mbox_len);
+            /*
+             * Too much data has been written, it can't
+             * "match the Length indicated in DOE Data Object Header 2"
+             * so we drop the entire object.
+             */
+            pcie_doe_reset_write_mbox(doe_cap);
+        }
         break;
     case PCI_EXP_DOE_CAP:
         /* fallthrough */
-- 
2.47.3


