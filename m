Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65CEC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39IO-0002KC-OZ; Fri, 11 Apr 2025 03:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39II-0002Jq-PY
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39IF-0003sO-QK
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso1931731b3a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358358; x=1744963158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TtNN7VYXgzvwVBu/O4Bb4s2j9QKOdcKj2T3Ii/pMqs=;
 b=Xf9NJ1H7c/E4cb1d7gx8MV/qzTrAMkY/k6CjYqWSpRf2qds01KTBcBv2FrKN4WYXL+
 pzNBgIa0X8ZvXkSJ0pqT2H5uQ9P/Vr62yxqW3ZejJnaOitza9Rin2ep5iG4DaYAnvj2W
 fhyD9MCgGsHWQeEc4mXkPFlGaEJvdgDG5xDJhtyTIzYtcAOVrmFgyAwfkUujreOw/qAf
 Pf5R0r3DjrZYegPCyZooOArfx9Kpg9Dfa6sWDO3f9ZYoH2u6Yo5jGSFpfqGqxqdU18Bz
 NymaGxqQRdltm/Gk26S9AeIilfMnqvuszuUOk42Jz1ld5ifDPWOLKb02eQi1AuFu0ZcB
 zwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358358; x=1744963158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TtNN7VYXgzvwVBu/O4Bb4s2j9QKOdcKj2T3Ii/pMqs=;
 b=ev5Ex5jKVBbo4rOZ5nUEwr1SUfgn2FJm706GWC8544HBa7JpqEcSBLdFkoIu+EmChX
 St4OoVNeR6hhSnNhjnViEOe3/1ugsVHb8p/5NrhEbDqz+vTMJGg9oalqyYtVrvQQNU0T
 EAMzFS7Wn3OMJM2Epnmqot2DHK8wS9lsy6NYb7s5B/oS32LaPOyD9/TjfXzrcsm4LoBL
 9uyqCNhHag3yIm5I8/PTN24xHKwrn8OIGRhE8taxbgCma8bOcx0U2Gc2ES5eTEyWyCHr
 YBsRIt5Var2qYLx6pd23I/NewVbo2c5OYptl5LQSRsfV0oNeTs75TV70SM9m3AbUTeuM
 Lc+w==
X-Gm-Message-State: AOJu0YyYsPv8MZMRO5XXa9HP+40otUGPDZ8QnXbkGRXgCGdhVJYAGNdU
 I93fdeWjWm3m+eiEvL/qJUT3XIDqq3cPidhi6C3XUkA6uHqt/PJ6NHwS4w==
X-Gm-Gg: ASbGnct/i3zYVHWmcBci1Df3HoJn9l148PGKGmDmD4Ua6uO2eRr8Levs2S5mtoCWaFy
 P15YemvQQagAhRQBGXRYgBjbsl9RQlhnoLfjSLK+L4UwqxFDNE3lWLteb9O/NdVRecFMPlWzgjC
 T8Ibjdv3SaDLMV1xtX3SYQd95AWr5CH5bEM670u9ptQI1H7VaAycDGfOq4AjFirkbTOBjWAG9Nn
 b0pjmN1b+eLwC3HxXOfy5HdlfmoNSCxhRKPVU6aRuxb0La2+wNE1mb2dP5z9n1fBsMieYNi3WNh
 VFEXDReRTJnPP61WBm596xBiaqPfm+nYJiYBHxXKM2QL
X-Google-Smtp-Source: AGHT+IE0DMpSWXRu9LNSwjUU/l6gz3TgLWTDyMr0d32sCGo0eafl385tCnskLmhQ5KrHMZuRcd7jVg==
X-Received: by 2002:a05:6a00:2443:b0:736:a8db:93b4 with SMTP id
 d2e1a72fcca58-73bd11b500bmr2581387b3a.2.1744358357849; 
 Fri, 11 Apr 2025 00:59:17 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233554asm851687b3a.180.2025.04.11.00.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 00:59:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 4/8] hw/usb/xhci: Support TR NOOP commands
Date: Fri, 11 Apr 2025 17:58:46 +1000
Message-ID: <20250411075851.206995-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411075851.206995-1-npiggin@gmail.com>
References: <20250411075851.206995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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
index 88973c485d1..b6f65628db7 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1663,6 +1663,20 @@ static int xhci_fire_transfer(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext
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
@@ -1785,6 +1799,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
 
     epctx->kick_active++;
     while (1) {
+        bool noop = false;
+
         length = xhci_ring_chain_length(xhci, ring);
         if (length <= 0) {
             if (epctx->type == ET_ISO_OUT || epctx->type == ET_ISO_IN) {
@@ -1813,10 +1829,20 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
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
2.47.1


