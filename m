Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D217C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7o-0004DJ-Lp; Thu, 01 May 2025 23:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7c-0004AQ-P5
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7b-0001GP-22
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so1530695b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156690; x=1746761490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lmS65fZf1hovgzPaFQwZvs4bM/iLU2g3QpGdLfzqQg=;
 b=frU3hhTnhO8zK6M92RKOhGxBtXIDgwb3AtPtob2nChiO/5JKGuYcHQX/nqUtLWuMbX
 NrCZQC64DfWBkHGA4+5GI/xjQOddVh8jWgK1OB4dpMqoleJ7aGwcM501I5jhSwEXJKIb
 EsOMZKHdAqbmxEsoPfSlCkMo76GwLDTZh5EmQQgy0ujasyPeL75TRW7fDcT9Ao32xLj5
 dngVwLRdurFLJH7pNcfF201sS0hIqQP4PjouAqQXIiRTaJjw0XEByzW0sRkvcc4aNrc8
 V3xeXMDJzicR+pagonX9tBK6vb2DIyT0mSlO+InT9LOOA1ZW/yQeVkIDZyKnMsAw2hss
 +CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156690; x=1746761490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lmS65fZf1hovgzPaFQwZvs4bM/iLU2g3QpGdLfzqQg=;
 b=IkMW/aVZl3xlfhuTCG1JVW9G07a/5Nup31Su+f3llti/8bx/U4KFo1mL7j1LAAMdaD
 IWV0KzvPejPy+10iQxRRrhWsI/tjfvoGrhz/M5EMLbW03iLROkJtCpomJMapt2pv9RIi
 Upxc3QUgHarOZ+ukSAxw27CKD/JUT/6rc6D/zUygj1zMvRDn5chfh7EpfH+6oTRmEDRh
 wJNDxskJJD3S5Ic77veh8lMBSLZ/xA0KKTKU61oZk3u1IbkKyWNPihLPV6y4CWjyRKKE
 RxZlh5+OTkJNLEOKy0/ctt+Ph1H1WavyTlL7rqC3ft1Te1yXXMoEPH4oCMUanDgJ+wj0
 1J+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0A5gBS0cl71RBk/0cykEs4aSjR8/NeqCxa82D/UPmWyTMbycfbrOJfo/pyLg6Cb/jIS5qfERdon/9@nongnu.org
X-Gm-Message-State: AOJu0Ywb8BxnsQRBHOvYVNTH2NGM4p7tNaxiondtQT3nTzSvA7kVf2Zx
 4A3i4HEEaMl07lUPKob4y4ZgKeeawygEEpSEPf3/8L/ROCE9eLlG
X-Gm-Gg: ASbGncv97atwXS6KUqkxPz0lwlxTQC8rZlcM60pwQE1xCRGnMzeKOFIx3BuKDNzdRWb
 Nyzy3kYazU31TyoPhCuQBEwHmypV2T/zpmmSwwsrK6YrEsTL3MZVBbyYLSWUUP09VobtCQydSa9
 woEP7FNP//9D0pz7kNcW+dMlv5glqJZt7oOXcSQcYowPLHRlCrz9mToj5EKdAYFw0iJF/nUa5YP
 bQ6myrSe5PT9UYsMwyhzCElqbRJXsTMPNd90Aeoodf84RxtCXJRtrqY/fVJs6tt6FnXvb1Zrttt
 4WP7Y+ZxunswOtzRKk6laZTCYcXHBnPDmZK9Gajh2WPf
X-Google-Smtp-Source: AGHT+IEu6VlXM40BhVUfDkOtcaxFsZzttNGo+ZBqotB3iXtqlqr4Prb78Mc+2b7k8vONhS8F2v99UQ==
X-Received: by 2002:a05:6a21:b8a:b0:1d9:c615:d1e6 with SMTP id
 adf61e73a8af0-20cdc1ec1d6mr1999394637.0.1746156689651; 
 Thu, 01 May 2025 20:31:29 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:29 -0700 (PDT)
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
Subject: [PATCH v4 06/22] hw/usb/xhci: Support TR NOOP commands
Date: Fri,  2 May 2025 13:30:30 +1000
Message-ID: <20250502033047.102465-7-npiggin@gmail.com>
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

Implement XHCI TR NOOP commands by setting up then immediately
completing the packet.

The IBM AIX XHCI HCD driver uses NOOP commands to check driver and
hardware health, which works after this change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ef9f2a7db41..6a490a5febf 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1664,6 +1664,20 @@ static int xhci_fire_transfer(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext
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
@@ -1786,6 +1800,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
 
     epctx->kick_active++;
     while (1) {
+        bool noop = false;
+
         length = xhci_ring_chain_length(xhci, ring);
         if (length <= 0) {
             if (epctx->type == ET_ISO_OUT || epctx->type == ET_ISO_IN) {
@@ -1814,10 +1830,20 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
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


