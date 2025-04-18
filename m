Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9658FC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 05:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5edx-00045D-QZ; Fri, 18 Apr 2025 01:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u5edu-00044h-LR
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 01:52:02 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u5edr-0007KN-Ta
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 01:52:02 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3035858c687so1215277a91.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744955518; x=1745560318;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4miTGJAApaUQ5VNX2Ybbx/ubzoinaG8E7+8o+H+7ung=;
 b=wJo4eDUFD3ci+/QBGu2xKeSPgsW1I6fz6TBHJJQGb+Bwm1EWAYJpHfjSCakzcONA1B
 BEFghlzr4tuumoXJA8/v2AHsDab3l7UKx2CR5gMSwefIJztyHTWtoO16HNFe3Y59IWsn
 /P4tGCCMI9rlaugEknDcYpbHDOcuXJt3uhBbJCBZpGBw08ZOCHVEZveMJLACPm2FDoaW
 x7kTLYfUsc5tx7ovsuyYk8T0RMYDBd9MrA8BIfMZUA780D4lwa//2+El8I21bA2OWYOA
 J1XpQq75rWt6rgl1lWLzccQVOrNrBLqdDbSlLaUTIeFP6L4g5Zeq+BzAGhkS3rqK7edG
 KMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744955518; x=1745560318;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4miTGJAApaUQ5VNX2Ybbx/ubzoinaG8E7+8o+H+7ung=;
 b=Nu6UGLvr6tKrR84tg38MAwwgw4Z5gF9pO10giVy4UppLjNySlODZcXdWRAjOBmFqHs
 VEgCT49QfNSJJ9W75vIVanBF3QQb9Ihhh2H2Fkp+SpPIqC753CfbQNhha70NavDgJOTI
 Bgjp6UKNFY15dsGvcFHB7Hhwng4FkdEp6BJidlHsXlKhPI5cuYiiiAud7KWZhRbVunMr
 GzF94lqh+mNcds50UOYD0tEX31rnKergHn+O3l2glQCuNZCo1a5qW3lLZ0JLwii5Xga1
 VU0Cih8QeXVXG56vDLdM9PGmtj4ps3/ZmkhI9y5q9sN7eCl0L1pE71bD8hDOcTohdy4z
 re7w==
X-Gm-Message-State: AOJu0YxzjOFL2WamjerGI5lNAsop5On00xEFVzqRkYzHB8VF/YVJfBA2
 HEHPH+r4SuRNaIFYDa29pSqVKET8BOPT4590x/S/axHTAz+z87Vz0RDjfL1CyP0WvgQz0h0LhGK
 mlDw=
X-Gm-Gg: ASbGncv5wOvKtyX9q+8NFoIkhT9IFsawrh+0HtPlerGwtYbOCd/alzb5o07GHrJAxZ/
 u4S8VaEICCudj0tkupYGLGf02DiEnpIYGcjDQZAMknYMSjnFpyoHl55ZKhIO0b4Oq5pgmP58HsN
 DDQgta1BI4cWd0CetUulzyJbEAPbUxvkD0HjdmViJhyKS+TX20gbM3crtVCRPzbYvmNgV6vo48E
 bY8nbFQTQdJGXobI2VrvSJuw3unxoh4kVUjZ94Mc+ayA6AyYkao9ZwB98FadSE8tNq64OyE8f3f
 UFiT7g3saNs+4iD/V8YJAr0+5LSB2s3aqWCsqNTHtjoAjef1OXNQ2IQ=
X-Google-Smtp-Source: AGHT+IHF3ivm+OGCgjMTKokMFj1bnUGLukoFeiNAdHwUv9Cmeh12+8lmaOd3ZdZG5gEm92TVeb3wXw==
X-Received: by 2002:a17:90b:270d:b0:305:5f32:d9f5 with SMTP id
 98e67ed59e1d1-3087bb2d9fcmr2717117a91.7.1744955517736; 
 Thu, 17 Apr 2025 22:51:57 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3087df07c1csm458819a91.20.2025.04.17.22.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 22:51:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 18 Apr 2025 14:51:48 +0900
Subject: [PATCH] hw/usb/hcd-xhci: Unmap canceled packet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-xhc-v1-1-bb32dab6a67e@daynix.com>
X-B4-Tracking: v=1; b=H4sIAHToAWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0ML3YqMZF1jC4M080RzQ1ODFCMloMqCotS0zAqwKdGxtbUA8T9NMlU
 AAAA=
X-Change-ID: 20250418-xhc-380f7a7150d2
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When the Stop Endpoint Command is received, packets running
asynchronously are canceled and then all packets are cleaned up. Packets
running asynchronously hold the DMA mapping so cleaning the packets leak
the mapping. Remove the mapping after canceling packets to fix the leak.

Fixes: 62c6ae04cf43 ("xhci: Initial xHCI implementation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/usb/hcd-xhci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 64c3a23b9b79..0f1ccd4aeeea 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1187,6 +1187,12 @@ static void xhci_ep_free_xfer(XHCITransfer *xfer)
     g_free(xfer);
 }
 
+static void xhci_xfer_unmap(XHCITransfer *xfer)
+{
+    usb_packet_unmap(&xfer->packet, &xfer->sgl);
+    qemu_sglist_destroy(&xfer->sgl);
+}
+
 static int xhci_ep_nuke_one_xfer(XHCITransfer *t, TRBCCode report)
 {
     int killed = 0;
@@ -1198,6 +1204,7 @@ static int xhci_ep_nuke_one_xfer(XHCITransfer *t, TRBCCode report)
 
     if (t->running_async) {
         usb_cancel_packet(&t->packet);
+        xhci_xfer_unmap(t);
         t->running_async = 0;
         killed = 1;
     }
@@ -1480,12 +1487,6 @@ err:
     return -1;
 }
 
-static void xhci_xfer_unmap(XHCITransfer *xfer)
-{
-    usb_packet_unmap(&xfer->packet, &xfer->sgl);
-    qemu_sglist_destroy(&xfer->sgl);
-}
-
 static void xhci_xfer_report(XHCITransfer *xfer)
 {
     uint32_t edtla = 0;

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250418-xhc-380f7a7150d2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


