Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A5C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ2xW-0003FA-1W; Sat, 18 Jan 2025 02:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xP-0003DH-QP
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:24 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xO-0007pI-27
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:23 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2165448243fso66777965ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184159; x=1737788959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4VzgFnlAufaRydiep0qE8J1DEBNHc9FILqOQebNfGs=;
 b=ZWIxXcz7F3qoPpbg60iLJMJ5G8TFU9Tx4D7kSrQYNMH3i6Gmh/Qu37mjgXcUogeF+C
 vOzRPWVfKS6DKdUcrG3gEw9nnkcIqk+6gmXtEdFWGYX5PZEClreDFzXHav46O7Pss71E
 YHInsKUhaxuw5ueQMb6KBeqtlxDR5tpa1zrOxfiO4K+g0Dqpa06orSAQqaVjygCLFT8Z
 Jkl8ibafaYO95rrk1KTn4d2ZSCZZb4AX+nxm+rsEpsJJTWIZPORMRmL8ZShtDNpnHFw9
 3qTIzdVsJOrC3peh18YrWq8gudM/f7KoCTxmK1rFngDv1Tr344rFFpKZQC+pdNUETEDn
 dtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184159; x=1737788959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4VzgFnlAufaRydiep0qE8J1DEBNHc9FILqOQebNfGs=;
 b=Cl5KpbDWTLEq69H6haZiqw2tby0VXY9tecCjUcii6gw5VNCNRg+SpYyOvYxLxckaOA
 H6L9p+OZYpOm/YCEaf/ACJ2zPTFY02qlt3sgYOBrZnItgHq5a3oSDOwQTvcP4M6CleDG
 OJ3hrqF6F2AVZgp+NjN7eukpmhGIZ2jhAq27WHdT72vyTIV/NKCwoY1Q2iaGn2YmMkxK
 gDvl1nJ5HYzb5IgMjlAPF4NOyUoA/jkCgZdMFuFUAXbDQAGEnyhR0l0fS6bHLuYIqp7U
 8PQLuUxy/IrMA0TPN76sni9sXFXsuxz4DOxqs1yhsn34UcFIwPjLyHQbH8rmPwYmu72r
 /PVQ==
X-Gm-Message-State: AOJu0Yy+3QNnDUaN9AGq3PMv8AMa6PJgpaAZrtdlsbfbe3vmmCUmBcFy
 khXtHMiq5OcjUDcUPxJAiyyMVUVKw69WDuUbTpKiQhirCvgCqvRR0Tvjaw==
X-Gm-Gg: ASbGncvmjTSVIT5E7IjU4Z6JdlH7NN6Cbg2Lhln7DdemQuKtg9zunUq8QLZ02Ty3MRk
 8M1970/jQT40vnXq6VQMRWAP/IoQLwWUhj+CPcUALtvgkukf5aFSyHo3+auLzxwBuRUF2bP+mSf
 D5jBo7lZwRqLh1X02XITzzMLdMBSQkWiF0VbjnNJFjA1AeNAjF4zuRkPbXSOvBdjZFi5Z/p7zi1
 dXZRsvR8vK/YoIrTmjaBE3eiBM7vV3K57eqTk2CF0H8vkkfknQJtGYo1b3EhVFl6N62XU0On0dU
 1K2ODRiLlMbtJ2JvBEuh1ZQoyTA8
X-Google-Smtp-Source: AGHT+IEVZGUaGonDWGU/ppEhKH/xlMbup3a7MCMdcv83t90xMoyDnFls1udIPHlS6YLD5grw53SUGA==
X-Received: by 2002:a05:6a20:3942:b0:1e0:c6c0:1e08 with SMTP id
 adf61e73a8af0-1eb214afe1cmr7864173637.25.1737184158882; 
 Fri, 17 Jan 2025 23:09:18 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c95adsm3192880b3a.107.2025.01.17.23.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:09:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 4/8] hw/usb/xhci: Support TR NOOP commands
Date: Sat, 18 Jan 2025 17:08:49 +1000
Message-ID: <20250118070853.653778-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250118070853.653778-1-npiggin@gmail.com>
References: <20250118070853.653778-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

Implement XHCI TR NOOP commands by setting up then immediately
completing the packet.

The IBM AIX XHCI HCD driver uses NOOP commands to check driver and
hardware health, which works after this change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index c68cf268365..256bee6c72f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1662,6 +1662,20 @@ static int xhci_fire_transfer(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext
     return xhci_submit(xhci, xfer, epctx);
 }
 
+static int xhci_noop_transfer(XHCIState *xhci, XHCITransfer *xfer)
+{
+    /*
+     * TR NOOP conceptually probably better not call into USB subsystem
+     * (usb_packet_setup() via xhci_setup_packet()). In practice it
+     * works and avoids code duplication.
+     */
+    if (xhci_setup_packet(xfer) < 0) {
+        return -1;
+    }
+    xhci_try_complete_packet(xfer);
+    return 0;
+}
+
 static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
                          unsigned int epid, unsigned int streamid)
 {
@@ -1784,6 +1798,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
 
     epctx->kick_active++;
     while (1) {
+        bool noop = false;
+
         length = xhci_ring_chain_length(xhci, ring);
         if (length <= 0) {
             if (epctx->type == ET_ISO_OUT || epctx->type == ET_ISO_IN) {
@@ -1812,10 +1828,20 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
                 epctx->kick_active--;
                 return;
             }
+            if (type == TR_NOOP) {
+                noop = true;
+            }
         }
         xfer->streamid = streamid;
 
-        if (epctx->epid == 1) {
+        if (noop) {
+            if (length != 1) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: NOOP TR TRB within TRB chain!\n", __func__);
+                /* Undefined behavior, we no-op the entire chain */
+            }
+            xhci_noop_transfer(xhci, xfer);
+        } else if (epctx->epid == 1) {
             xhci_fire_ctl_transfer(xhci, xfer);
         } else {
             xhci_fire_transfer(xhci, xfer, epctx);
-- 
2.45.2


