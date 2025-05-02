Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6534C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8l-0006CK-WA; Thu, 01 May 2025 23:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8i-0005sf-Ee
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8g-0001Mm-PG
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7376e311086so2404622b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156757; x=1746761557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxKI7f7n6Tn3V37ypD9JbP6M9PyWm2G5CMuSlKC7xw4=;
 b=G4ab7GIrAWdN0pGZPOUmhbrUk7wZh2/LhozVniGMUoXXHCqSdHlnXKCiQO2vCkTAk4
 39+qjdzbYjbV6/ug4LG90X+GXKfTcybityX2PWMRyrQ3ebSeaW2EW6GwSGaumEAcI63M
 6eT/be02L4K2WROiBGX+TMRawuEh6z5HndM6whZVdVf6l/3uMIIj0PDHIkdj1W/DTkae
 DjWhGmHF+PUIJA3HLeE3WpnJq0JHYLmQjQd/wiwpP7OnDzzmz3xvJmkhvzy04Xvqg5pY
 8+/jzRHnjE5Ajiw1joddXy7jqLKmu8Y5wfzPzCSLTv/451lvj/rrOj8l7P1mxdeoORd7
 7I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156757; x=1746761557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxKI7f7n6Tn3V37ypD9JbP6M9PyWm2G5CMuSlKC7xw4=;
 b=WuLs5SaXxp+JeEFyCoKR1zN8OoNlJIeVSTmCocUAItJfcOkojV9xeL1GqgC6LRavj8
 1XnrmapFXiQmH+lmtD5rfzqiFvUqZaPvMVFo+9ELnKtc4s3lBSeSiA5z65kS/fgSdOY/
 lfRLlO6rBMBqBve5aDoXvUQ6vKK178w0DZ6U5hajfiwkoMdcmNGRUNbSRVhrgdZmaHJ9
 O87f9y009Ci+eDDu7RWKia12wzJLoXwYEah52yEHNcAQWwOpyInHNd3OL3VEMUdaYNBX
 jRIJXe2daEgx42QHH9ynLmPia7u/s8qZpSTd1DWst62IP/LqcUA0eiRv/pC99XojbkYP
 rcDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD0RwrCeyN+UP9AxAMrpwZZBD2El20aSq3lJTMIE5JwU4MXB16W3lupMn+ki3wEU2qslP1M9WSD1Hb@nongnu.org
X-Gm-Message-State: AOJu0YwFbUGfCiL6tufHDOJelaabT2wKo0TW/hIJOloqX51bdKQ3G2xn
 q9DGdCaoTXERrgwOyDDJ4YTFKWQ6aEiAyF+bPQGFRdYsuPiy9SjIckQ02Q==
X-Gm-Gg: ASbGncuiNhN0T3c4mKptDG9cNz+ltxHPTvnKutKMJWHNVkApPSLoXOrDQp9VbR4Vim5
 hSR56BPSDzcOWEyzhVTfRU5zTyvcyFOiv8C8pcL+WrVHtp+oUGj2CONEEohTk6JiSh+CzXXXq+s
 Br4VOIHuH4HOpcw6lWV1dtFgnkgv+QJocS8vo5dIvoYJStPOFmn/CqtACJDbCue2VGXMu47eKwA
 xbrjKIwGvZRTwNnMKYAZdEqGwCg/xml0fiu5LLQzWxAc+vxibP9/pqBgGQLEbmzP0B25eLC42sA
 LL7jOTRBP3HoK+xG0/yZ7v776Ncw8Rk2/VcLh+WWtjtq
X-Google-Smtp-Source: AGHT+IH0qGvgnU1xlbGGqs/qU5TPUsMyLEDvYa33Zz7PmTp5Q8F+izP2Y/elpmXpwRTy1s/yWkxW9w==
X-Received: by 2002:a05:6a00:6ca1:b0:737:678d:fb66 with SMTP id
 d2e1a72fcca58-740589049edmr2032846b3a.5.1746156757127; 
 Thu, 01 May 2025 20:32:37 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:36 -0700 (PDT)
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
Subject: [PATCH v4 19/22] usb/msd: Add NODATA CBW state
Date: Fri,  2 May 2025 13:30:43 +1000
Message-ID: <20250502033047.102465-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

This is not really required for the state machine but it improves
the symmetry of zero-data packets with data packets, and helps with
assertions and reasoning about traces.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/usb/msd.h |  1 +
 hw/usb/dev-storage.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index af12a16c35f..6d741e44160 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -14,6 +14,7 @@ typedef enum USBMSDCBWState {
     USB_MSD_CBW_NONE,    /* Ready, waiting for CBW packet. */
     USB_MSD_CBW_DATAOUT, /* Expecting DATA-OUT (to device) packet */
     USB_MSD_CBW_DATAIN,  /* Expecting DATA-IN (from device) packet */
+    USB_MSD_CBW_NODATA,  /* No data, CSW but also a SCSI completion */
     USB_MSD_CBW_CSW      /* No more data, expecting CSW packet.  */
 } USBMSDCBWState;
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 5b773a22e60..a2544d2659f 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -318,9 +318,12 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
     scsi_req_unref(req);
     s->req = NULL;
 
+    g_assert(s->cbw_state == USB_MSD_CBW_DATAIN ||
+             s->cbw_state == USB_MSD_CBW_DATAOUT ||
+             s->cbw_state == USB_MSD_CBW_NODATA);
+
     if (p) {
-        g_assert(s->cbw_state == USB_MSD_CBW_DATAIN ||
-                 s->cbw_state == USB_MSD_CBW_DATAOUT);
+        g_assert(s->cbw_state != USB_MSD_CBW_NODATA);
         if (s->data_len) {
             int len = (p->iov.size - p->actual_length);
             usb_packet_skip(p, len);
@@ -500,7 +503,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         tag = le32_to_cpu(cbw.tag);
         s->data_len = le32_to_cpu(cbw.data_len);
         if (s->data_len == 0) {
-            s->cbw_state = USB_MSD_CBW_CSW;
+            s->cbw_state = USB_MSD_CBW_NODATA;
         } else if (cbw.flags & 0x80) {
             s->cbw_state = USB_MSD_CBW_DATAIN;
         } else {
@@ -565,6 +568,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
     int len;
 
     switch (s->cbw_state) {
+    case USB_MSD_CBW_NODATA:
     case USB_MSD_CBW_DATAOUT:
         if (!check_valid_csw(p)) {
             goto fail;
-- 
2.47.1


