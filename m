Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39629C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjIP-0000QX-Lz; Sun, 27 Sep 2026 03:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHt-00008V-NV; Sun, 27 Sep 2026 03:27:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHr-0005Sy-RM; Sun, 27 Sep 2026 03:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494013; bh=tiXXDqgXg7lPbcJbyG2ZRq/+J8WaPZB+kwSlU8kfh4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ctTD0fl3AdnVuBvoj4jWb+ayxwAC6ViDe2O+E8vgM4GzFRMAU4fgCDAefxKOWZTIK
 q8nwFT5s4RIlgYurR/iOsGBKGcOCQtUzRctQVmIJBDs4kZIlSUPSeCl5DvXO/cKKQp
 ld4PRE2afdH+LD1tepvjOAKB+WgI5PnB2n699J2IDuDCBpbb9xUiIDSFTUHye7KAel
 s9lCNHZaZYgbhKwfdgHDadrGZ8GFNusfabCXHI8TaPn8TcQ8PPw/hgyHQNjYXVlUeB
 SqJpis4wIPfXMegPiyp0Uwd/fd86O8eVpx/gY5thdTqoQf8ShObRsx0vc64DbHSQ36
 sTeD8rscAyAkw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8647E1D8ABE;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74E1D432050;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EADEB5E62B; Sun, 27 Sep 2026 10:26:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 60/72] hw/usb/hcd-xhci: Set reentrancy guard in
 timer functions (CVE-2026-17588)
Date: Sun, 27 Sep 2026 10:25:52 +0300
Message-ID: <20260927072622.93656-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The xHCI controller processes USB events from timer callbacks
(xhci_mfwrap_timer and xhci_ep_kick_timer) outside of any MMIO handler
context. The device's mem_reentrancy_guard is therefore not engaged
during this processing.

A malicious guest can exploit this by pointing the event ring base
address (er_start) at the xHCI doorbell MMIO region. When
xhci_write_event() performs a DMA write to deliver a transfer
completion event, the write lands on doorbell register 0. If the
written value is 0, this triggers xhci_process_commands() reentrantly.
A CR_DISABLE_SLOT command prepared on the command ring then frees
endpoint and transfer objects via xhci_disable_ep() / g_free() while
the outer call stack still holds references to them, causing a
heap use-after-free.

Fix this by setting engaged_in_io on the device's mem_reentrancy_guard
around the processing in these non-MMIO entry points. This mirrors
the protection that EHCI, DWC2, and UHCI already have via
qemu_bh_new_guarded(). With the guard active, the memory subsystem's
automatic reentrancy check (system/memory.c) blocks DMA writes that
would dispatch into the device's own MMIO handlers.

CVE: CVE-2026-17588
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3926
Reported-by: XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>,
    Guannan Wang <wgnbuaa@gmail.com>, Zhanpeng Liu <pkugenuine@gmail.com>,
    Jiashuo Liang <761232680@qq.com>, Guancheng Li <lgcpku@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4195
Reported By: Ken Hsu and Royce Lu of Palo Alto Networks
Message-ID: <20260915112213.525283-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit f91b0544fe1f9fbabf582ccaaecc08877b7e19e1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 97b18f8d362..9805dff0114 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -458,9 +458,15 @@ static void xhci_mfwrap_timer(void *opaque)
 {
     XHCIState *xhci = opaque;
     XHCIEvent wrap = { ER_MFINDEX_WRAP, CC_SUCCESS };
+    MemReentrancyGuard *guard = &xhci->parent.mem_reentrancy_guard;
+
+    assert(!guard->engaged_in_io);
+    guard->engaged_in_io = true;
 
     xhci_event(xhci, &wrap, 0);
     xhci_mfwrap_update(xhci);
+
+    guard->engaged_in_io = false;
 }
 
 static void xhci_die(XHCIState *xhci)
@@ -1087,7 +1093,14 @@ static void xhci_set_ep_state(XHCIState *xhci, XHCIEPContext *epctx,
 static void xhci_ep_kick_timer(void *opaque)
 {
     XHCIEPContext *epctx = opaque;
+    MemReentrancyGuard *guard = &epctx->xhci->parent.mem_reentrancy_guard;
+
+    assert(!guard->engaged_in_io);
+    guard->engaged_in_io = true;
+
     xhci_kick_epctx(epctx, 0);
+
+    guard->engaged_in_io = false;
 }
 
 static XHCIEPContext *xhci_alloc_epctx(XHCIState *xhci,
-- 
2.47.3


