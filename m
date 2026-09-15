Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02EAC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RF7-000702-D7; Tue, 15 Sep 2026 07:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x6RF5-0006yw-8J
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x6RF2-0001Wp-W2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NToK3ir8VnPlFCa5l6tn2sGAPeTADGZWya5exlgZPBw=;
 b=HETs8fd2FJIiIFodkkpvWt8dqal5W+BuPb7XdcKaOsgaAj+gQG6b4K7YDr79FwjRHQPU79
 S3Vl3tBsQtsCD3zHyc2Y8TASTmPooLq6q43GV6hfn71EVxFl3M+imjDt+D5JUw6cxm9TEn
 AIalV658jAFxPipdlF8gw0KnTPhBfXs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Wgddktg_NWqFRWsfC-09kQ-1; Tue,
 15 Sep 2026 07:22:19 -0400
X-MC-Unique: Wgddktg_NWqFRWsfC-09kQ-1
X-Mimecast-MFC-AGG-ID: Wgddktg_NWqFRWsfC-09kQ_1789471338
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28E251964CCE; Tue, 15 Sep 2026 11:22:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51B721800581; Tue, 15 Sep 2026 11:22:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, qemu-stable@nongnu.org,
 Guannan Wang <wgnbuaa@gmail.com>, Zhanpeng Liu <pkugenuine@gmail.com>,
 Jiashuo Liang <761232680@qq.com>, Guancheng Li <lgcpku@gmail.com>
Subject: [PATCH] hw/usb/hcd-xhci: Set reentrancy guard in timer functions
 (CVE-2026-17588)
Date: Tue, 15 Sep 2026 13:22:13 +0200
Message-ID: <20260915112213.525283-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d342aa2739e..12f8ffece0f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -456,9 +456,15 @@ static void xhci_mfwrap_timer(void *opaque)
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
@@ -1086,7 +1092,14 @@ static void xhci_set_ep_state(XHCIState *xhci, XHCIEPContext *epctx,
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
2.55.0


