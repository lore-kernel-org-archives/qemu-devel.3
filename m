Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91074E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLegP-0007B1-8t; Thu, 12 Dec 2024 03:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLeg2-0006oj-6R
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:36:06 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLeg0-0005Ue-KS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:36:05 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso2665545ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992563; x=1734597363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCY8QL0veLcvYLUXlMQP3OezQThH3JzWNYRzOQI/qEo=;
 b=blKIVvuXpkh85aY+R6R9hlfA4F0Q3+xo2vdso115SeMSznQV2/Ulv9TnAmQRgwxJE/
 D2icVdoMVMFPxbDd/OtxxX+Et2jy/lYrhpXyArEiUXMbRGOZWZzZ+JbMagsJ6kF3x4SB
 XmY4ncqu99wjyvTEU8MEfBmJOh5mJqrfrLQNwrqPidGG7NJSfnmMHiL1BNqI58UdLkvd
 9tfmDZ1sjaMVKzFcwQIpGADrLHz+ovqX/jGD+kHWNwFyjm9nDR+AW0kRzo5aBtAc4xrx
 V2pd7ojxT7OOGfl8qGm16WJAymbDUZzPMHtZRi6JNMsYj28eVE56ZalzlBFG/SwHiCuA
 g+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992563; x=1734597363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCY8QL0veLcvYLUXlMQP3OezQThH3JzWNYRzOQI/qEo=;
 b=mVKwcqkpFM+5xfTB6CvFedBpkKFdKjmbMRPQJ8YqF21/iG6q53XdXVAzRsyMXKN8T/
 Ib9wz44b6jhEIFYqrZgE+cNJp782CNis75izbcVQSbVeB4KMU8MXcLqKvE4p27qEqQGo
 TIYppD/iFARy8z7zHbv8OPgr8Bpiwz7rVG9d2QNACnbMQLWfSTN2x2Q083RpSLL0L2pr
 3A7ZmxzPG0uHk1Lq15NKw/GzgC1wIJoG0JUFsGOJqjkd3u5EWePUwWbi2do8rg8gm7S4
 5IA35tDhmZdHi2f0HCPWVt+pLiWQgYiCFWakRANK3Bi90uzTFnSfaWyUFgccsTM9iv5C
 MixQ==
X-Gm-Message-State: AOJu0Ywhtbi1RAcaZyAoCOjmv9UjCZycsgdaJJIY6lGa6Wi28GN/cAMO
 SUjuBF3k7zfXY0xQ/hQypYogYo/FxH84dhfD+LCub9bg00FwcCxdNZIEGQ==
X-Gm-Gg: ASbGncsKM/Ms78vkyNRKSzbiQiLMS1wytrA7L/D5chVfYckLUUSviZDeqODD0ME2/uh
 ZeDPbyxbKfZwgRAtIHizTOVgkMDRoEhURqHUtrVayymtqWkBPwdAXjC246bIcxuGtdDc72IR47Y
 IvNyio1LGKCF6VSJ0e+zmBUzX4IMF+f0DmN/Mf5ql5eK93xFFBpigLvUSmg64KAlzJ9Ls+h4PRx
 YjJ+Vk6HwuD+7CSiD5U8P8Zja8L98uJAnrw/a8Qs2KtKB0ou/I135impNA=
X-Google-Smtp-Source: AGHT+IG6HH6syHca/BoLf1y+YbDY3O/U+Ipp2m8X6xoXsEhz+Vx43TOWsfC62PWTuJqJFQTgAIbayQ==
X-Received: by 2002:a17:90b:4ac4:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2f13930ba5cmr4149689a91.28.1733992561955; 
 Thu, 12 Dec 2024 00:36:01 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:36:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 7/8] hw/usb/xhci: Support TR NOOP commands
Date: Thu, 12 Dec 2024 18:35:00 +1000
Message-ID: <20241212083502.1439033-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212083502.1439033-1-npiggin@gmail.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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
index 90273cd317e..844521e10f5 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1666,6 +1666,20 @@ static int xhci_fire_transfer(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext
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
@@ -1788,6 +1802,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
 
     epctx->kick_active++;
     while (1) {
+        bool noop = false;
+
         length = xhci_ring_chain_length(xhci, ring);
         if (length <= 0) {
             if (epctx->type == ET_ISO_OUT || epctx->type == ET_ISO_IN) {
@@ -1816,10 +1832,20 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
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


