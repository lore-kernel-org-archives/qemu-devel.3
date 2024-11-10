Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F55D5E39C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 03:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9yoB-0007dP-F2; Sat, 09 Nov 2024 22:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9yo9-0007cm-AZ
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 22:40:13 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9yo7-0000PF-S0
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 22:40:13 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso2771852b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 19:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731210010; x=1731814810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ds0KMRTr+esWMK197iNx2SANaPoYOexQH1YChjEEvhI=;
 b=DBjHl1ThWEY7zkR7oqqJvxXu47uQnnPcuWi+mAuVtPV0jHe0EfvAZrd6+eWZZvkg03
 fOcBWaRmVNtXagKeb30z7KKTxd/eJOoJ5MTAIWth8B68FGl67AWIxIamcGURVMGs4Zhd
 Y3bSMFFeEeL0yLaVImttXIxcfTQSO0DwODIzhbYbfRp/wFmvMPCJq1PSOCzOA6byCJBO
 A6jzhtPlO5rgYKCbot7ZWbwa1G650shc1R2IoGdW1OlaW8kWvVCm5xyr+Sjr2hJZwzZs
 pNTQoykZqr0Xvq0ymdPzXDGL112SkTnXc2sveHiDECv3RjakgmUwXsTMTqMNrTmDd+tw
 DnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731210010; x=1731814810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ds0KMRTr+esWMK197iNx2SANaPoYOexQH1YChjEEvhI=;
 b=ppkC2kcNVEgzKtyPWaa8fPUbneXs4yHRmN80p08Zw3jOczThTe6/aDPmO4/w7ANnZ1
 A4d1y2yBFTtTPyoGyBvkoUYejGRGAPDxsSJSTHvIfyrhLmdhYnZK/HXr8v/5cYjCBYBA
 G2EDZkjexLdRONMwYv2HqcCgCFuHDHJckK77KwYQc6s39mxOb0imhY4KN3j3uqZBlbmK
 K0G70dNW4ZFfAcxaq56P3WfRvQypOW6wK98jUqijzIe0zEcLZcpoUyqx6xTyjwVVVlwC
 BlvvbL3QCPSYr1sqtjcNKME0ss77OABhxWKp3h0VV21PDeltQiCUkTaXAGFvQ3LYsvmC
 GxEg==
X-Gm-Message-State: AOJu0Yw0bupBGI959Ai0G4bGHONcamFEhQj55fuN7B/FT7kfN7MOsZ7X
 VdhjDqSyNVurDcGqBJumsP4ckVT2yOSejttI0R71pAbKOYviZSI9YTZ5ng==
X-Google-Smtp-Source: AGHT+IFHhzZBhUeX/irPuEpMRhaRrMo57Rt/Ubu4juLUC/68w6dRL9Lp9OBRstJaTavf7tSI4bUbRA==
X-Received: by 2002:a05:6a00:14d2:b0:71e:cb:e7bf with SMTP id
 d2e1a72fcca58-724133625a2mr10390155b3a.18.1731210009987; 
 Sat, 09 Nov 2024 19:40:09 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240799bb78sm6345273b3a.95.2024.11.09.19.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 19:40:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 1/2] usb/msd: Add status to usb_msd_packet_complete()
 function
Date: Sun, 10 Nov 2024 13:39:59 +1000
Message-ID: <20241110034000.379463-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110034000.379463-1-npiggin@gmail.com>
References: <20241110034000.379463-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

This is a convenience change that accepts a status when completing a
packet.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 341e505bd0..4f1e8b7f6c 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -177,7 +177,7 @@ static const USBDesc desc = {
     .str   = desc_strings,
 };
 
-static void usb_msd_packet_complete(MSDState *s)
+static void usb_msd_packet_complete(MSDState *s, int status)
 {
     USBPacket *p = s->packet;
 
@@ -187,6 +187,7 @@ static void usb_msd_packet_complete(MSDState *s)
      * usb_packet_complete returns.
      */
     trace_usb_msd_packet_complete();
+    p->status = status;
     s->packet = NULL;
     usb_packet_complete(&s->dev, p);
 }
@@ -196,8 +197,7 @@ static void usb_msd_fatal_error(MSDState *s)
     trace_usb_msd_fatal_error();
 
     if (s->packet) {
-        s->packet->status = USB_RET_STALL;
-        usb_msd_packet_complete(s);
+        usb_msd_packet_complete(s, USB_RET_STALL);
     }
 
     /*
@@ -255,8 +255,8 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
         usb_msd_copy_data(s, p);
         p = s->packet;
         if (p && p->actual_length == p->iov.size) {
-            p->status = USB_RET_SUCCESS; /* Clear previous ASYNC status */
-            usb_msd_packet_complete(s);
+            /* USB_RET_SUCCESS status clears previous ASYNC status */
+            usb_msd_packet_complete(s, USB_RET_SUCCESS);
         }
     }
 }
@@ -295,8 +295,8 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
                 s->mode = USB_MSDM_CSW;
             }
         }
-        p->status = USB_RET_SUCCESS; /* Clear previous ASYNC status */
-        usb_msd_packet_complete(s);
+        /* USB_RET_SUCCESS status clears previous ASYNC status */
+        usb_msd_packet_complete(s, USB_RET_SUCCESS);
     } else if (s->data_len == 0) {
         s->mode = USB_MSDM_CSW;
     }
@@ -332,8 +332,7 @@ void usb_msd_handle_reset(USBDevice *dev)
     assert(s->req == NULL);
 
     if (s->packet) {
-        s->packet->status = USB_RET_STALL;
-        usb_msd_packet_complete(s);
+        usb_msd_packet_complete(s, USB_RET_STALL);
     }
 
     memset(&s->csw, 0, sizeof(s->csw));
-- 
2.45.2


