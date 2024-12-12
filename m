Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC08E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGP-0003T0-If; Thu, 12 Dec 2024 04:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGN-0003SQ-R7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:39 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGM-0008Op-Dd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:39 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7fd10cd5b1aso311669a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994817; x=1734599617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzr7yor2vNyxx++nCVtwqty4yb5+mRXEz0v+KHBkCPQ=;
 b=WfNT+0VpLqu4D3lFcpj1MZRDKzbP6TzX6N3t50nDw5VmqGxAttsdLtx7FSDGgJXXuy
 Ki/d2+f1sO0SlG2Dh5gkADwA1HfUYpOXWWpclrW78I82ipEGIWWUiUOGCtJVmwFc0NY1
 07ggXpV13xrVC7xtO4ukf0aPQyZxmoXp8JZk0nn3vuw7S9H0fWpsVX6mV0PXUxtzwqU0
 Qf+5WVnjhDAxthKQeljlV0rbxiccITM9Qpj0ZE7hCvgqTT6vwuz3AC+90MOV50xlcjOC
 s5g8CVQJ49pzdmvTA46USq+SjfyjKLPbePkKyO1fFc8Ve+lH6ZyBm68P3YFMJCMJLOjA
 z0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994817; x=1734599617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzr7yor2vNyxx++nCVtwqty4yb5+mRXEz0v+KHBkCPQ=;
 b=eQSszw187lrnGFYnfzhgQvnBGXU8DDsaifHE3/5uHPbBmzEdy2JBwDTtPwb0MIW3+C
 MxAAIZ1cyE9kgzkC7m5djhMpDdQ42hZFaOJhUUiRZReiiFDr/F7Qhd9Q7etKSlIk0Wxt
 1Elspy9l1Iqz3NHEr27s4GqXBAerTmOHn3o4fnClr1fG9sZGFE9QfaxzGmTNHYEfynfQ
 OjlqHB7TtDso0HPhAeqxoVj4UQp5ugDRIXXjaRHGOXUiYSuXY2ANF+w5JotZA+hzi2f7
 dzs8Ns8S2oGnCXf+7btHUR/QCtWNIUnHhzHVS/YSs/26Et4z9LCFBN1T5b3qsfZH6CoT
 Pnjg==
X-Gm-Message-State: AOJu0YzF5m4odseLi14ZfjPAPgk0a/kelUvTeQ0GH5uHBFPSq/lDlCi5
 HhCYW8fQmPLGUqG3fr656oGhXT9yYhJ8qyucfs0ICS+9wlN5oNFdEt4o2g==
X-Gm-Gg: ASbGncvhYDnGp8Xy4O9jiuKtCxWS9vCVR02zmsiJFVogFHF6IKSn1uc4ZpOnnxWEA4A
 aLJXMF2vZ0bYBhyEaBupMtlMjCjIVinZ8dTOyUmCOx+qKEPHGri0ZHxgx79WMkZGkrQwaUafFWD
 uk6i7W+ZT1a5y6lIanIUJa45Qiaa2K2TcTIyD2OP38KV2kE4yRdJi1LLgnWu73vxFTMoomEqMF8
 sDtThB7lb8R2d+Q3EKnF4zvJAv/iFhaBuXX4PnAA/NxQzeKO25BsTkWoL0=
X-Google-Smtp-Source: AGHT+IGOE7+zznvv+T+DL0vZwIUGVw7NvRbC/bwX6UN4UOexGyqlD0osUToIk7ADMuHB6E1fWAeCVw==
X-Received: by 2002:a17:90b:1f92:b0:2ee:bbd8:2b9d with SMTP id
 98e67ed59e1d1-2f12804fc56mr8534542a91.34.1733994816767; 
 Thu, 12 Dec 2024 01:13:36 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/11] usb/msd: Add status to usb_msd_packet_complete()
 function
Date: Thu, 12 Dec 2024 19:13:12 +1000
Message-ID: <20241212091323.1442995-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 341e505bd0a..4f1e8b7f6cb 100644
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


