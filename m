Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312F9D12D79
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 06:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAO6q-0006nB-U5; Mon, 11 Nov 2024 01:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6b-0006kF-FT
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:59 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6Z-0000fG-Km
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:57 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e79f73aaeso3350461b3a.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 22:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731307253; x=1731912053;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zpfc6hr6Bhw+kRs25skm7ehABQwj5ycjd/6KochPE+0=;
 b=070586pRTmnMiZtzh20a+2K+j2jjj12EOOEykEdZCWGf9wI+6KTMweBRGou7MyS/gS
 B3Rqmj454a0e5ikKfo8UyEup0JoVRedf7hXjn0SrSmcaCQQUcv8APD8XhJFYXBivplw9
 mHImWJMf6oBQVGkFy6r4HqpcVVFcwyzBrVh4NxAn1nsct4nWPc1CeO86+5LzX88+6BS1
 C+HYJ/cPDfdUBAtD0ck/0ko5n40lJeLDx2oR5sDb0OLea950/HUnlLngFwfh6eVho25U
 4IF5h4k0FWZ3tC6okdzHODH5Y0dxS6n1dYKerhejC2Mg8XfH4D3rjrRSfiA3ybVeOniy
 VY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731307253; x=1731912053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpfc6hr6Bhw+kRs25skm7ehABQwj5ycjd/6KochPE+0=;
 b=b1C+Kn9rgFXgbVC6MWSepdu0r+NdKTe+DWhNHLpFDkDbdUoV2P9JegopV6xxLKTBWc
 jOSEVr6D06itfyOY0wy+Zd5CVpCeQKxXtcgfOkoaSSUjSHIrXi3aoXfMNmNWgbsqjoiX
 NfOx1MOcBKR/MYcmOivdAE3TNoeZZhMPcSIHV280pVHvhN0mdwARj4pDq+EhxHSpyc9t
 W/vrq3MFBbuAoOHRGeF/Usd2AdjZ3sACW7fN4zsTLEwMsezIqSCUgZtH1ZjkXF4nnOp0
 ROKSzrIyTd3/8qSpcfyHgglSrjfWnj+UMWTIlLW+ZytIefuPHVYNVJcPSb2TBlelU53H
 vOZg==
X-Gm-Message-State: AOJu0YxayEfUbo5Es8Yn741GCqY6cFvbmC9ExP5MY1aXBg4itgQ06Fl6
 wIgSAIxHEmPeZakDd8xOWf5d2BQ8Y/wop3gudB7UAwWTAXbLOzr15QgXbYne7gc=
X-Google-Smtp-Source: AGHT+IGl4h4z2bcEIbZBzIwMkIIpeSCu1+s+Pb0flQINgKnXyjyGw65+pSZ+y68rivQbNAPzGi4j/Q==
X-Received: by 2002:a05:6a21:c20c:b0:1dc:3a8:7fc0 with SMTP id
 adf61e73a8af0-1dc22b85620mr9280307637.46.1731307253394; 
 Sun, 10 Nov 2024 22:40:53 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-724078a7f2esm8312075b3a.49.2024.11.10.22.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 22:40:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Nov 2024 15:40:20 +0900
Subject: [PATCH v2 3/6] virtio-net: Do not check for the queue before RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-queue-v2-3-2f7883a1004f@daynix.com>
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
In-Reply-To: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

virtio_net_can_receive() checks if the queue is ready, but RSS will
change the queue to use so, strictly speaking, we may still be able to
receive the packet even if the queue initially provided is not ready.
Perform RSS before virtio_net_can_receive() to cover such a case.

Fixes: 4474e37a5b3a ("virtio-net: implement RX RSS processing")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 62e396e8d2fd..abbb22e40f9f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1906,10 +1906,6 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!virtio_net_can_receive(nc)) {
-        return -1;
-    }
-
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
@@ -1919,6 +1915,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         }
     }
 
+    if (!virtio_net_can_receive(nc)) {
+        return -1;
+    }
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;

-- 
2.47.0


