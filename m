Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242D9C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8I-0004p9-CX; Thu, 01 May 2025 23:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh87-0004jg-Qz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh86-0001JS-7m
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso2321491b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156721; x=1746761521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdcBmlZ41fztrDxg8OzWqVn83Qj5ovbs7ZwEC3huu1Y=;
 b=dJcwK+He85fa3hWEgTR3ShzIyHdqj9NNrKJJXLJHcCg+4vfZuPIFQBuQzHK8FWZu/q
 RGgt0RaxZcktfR35Azgg2JNSLi+VR4yUYwPum9puBlRM2wLHlwfbn7YddZFV608RyZA2
 qO6LOqTBs66htXOW5WADIcgCmsZCrcVRFH8egDW3/14qCDBGJ458z8FmTWMelAs5gmMK
 mLkRfCJUtujmUoj8mgXnlO6IKQCMW3xglzNdvmJu/l2JYT1ZrS0mRfkpl+I0i5eZx1bj
 4nZ+/BjAw+eqrDVTtq/k/bFIOxsRY3XLYnK5HV1H/KN8lKM1+OC6jkBcMKru0QrF32Yn
 26jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156721; x=1746761521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdcBmlZ41fztrDxg8OzWqVn83Qj5ovbs7ZwEC3huu1Y=;
 b=hkKcEfjy7YyeX7JRcyfTd3hjtjf7bOrwgdgVIK2jU49Gtuh/mat+VR0whFnZYbtKwA
 6vwO6PQkYqcNn4K+IkZ6zhQQCtZGEZxr+C2yV2YKZhsKjHSEd4NdGWllcors+YFBfuLd
 cp6BYjgC5lo5LE3UoB1omKV/HXyIrh+IMjhX6m8pJQv9S9yagZBZq6o6f2BHmhF1fWWc
 fz07A9WJe1g24TPbwg2uNSpBH+EI2j98MJYE8w5JEI4CHmvwRkCnrjPExsFRroa8W9WG
 PJGQbLngcfbl7kFBbCe5YfL74vbm/k62lBOlPuWS1WsuTcnaTf8jr1H3hw5V5gsO5Lbj
 t/Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcESEfG4Z6DQeDEDAXbotALpqW1KSnrblZlF46ebszwzxxnpsxT4ma6DuRM/0hBD6EZrSVt0xpqX7M@nongnu.org
X-Gm-Message-State: AOJu0YyJKUsztT3Aft2B8+lH1J11v8VfLhI/RX9qziN4PpFA7/aXK8BH
 uZA1sFi76YEE6iIgjTHWdDE9yVwDREHkleEtgQMCe7s8jaWVrMhrltLCGg==
X-Gm-Gg: ASbGncsOQiAdNsqSE4bbe47ZXVcn85+OlEuQ8UdaDzHLy/vw5smXVYlklRI1RdZqGkW
 sqXS5Zxf90k/+A/LqgniPIA5RiXEnPrPD2ll7BP+kvHYIQ8KDxfdZX1+2uh6FwRNXzYyq/jANKO
 kjOy40wDKfHmclnfwrZ3ZQp7wenj0LV1K2W70fC0yKekhApa3cGbn8ikmS9N/4tp2atLcPwUzi8
 9gXcZ07JdbJ2jrGK5WtXhs07pF3pqyqd856LK/lep1CRLe2mY7FjwZPB1UAo2j1P1sLp6uSHeBx
 1dUrEH6w2tgN/OI2sT8KYeZHVpa2Qe1+sUmpvMGtEzlI
X-Google-Smtp-Source: AGHT+IHvgD0K5P5ZYydqJtVAL2Z7Zs+Y2t/uEFj/aFLKRgU5joQGot/Zqajj7Ct3gZX2KdOaWcUtBA==
X-Received: by 2002:a05:6a00:8c04:b0:736:457b:9858 with SMTP id
 d2e1a72fcca58-74058a188d7mr1736038b3a.10.1746156720862; 
 Thu, 01 May 2025 20:32:00 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:00 -0700 (PDT)
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
Subject: [PATCH v4 12/22] usb/msd: Ensure packet structure layout is correct
Date: Fri,  2 May 2025 13:30:36 +1000
Message-ID: <20250502033047.102465-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

These structures are hardware interfaces, ensure the layout is
correct. Add defines for the data sizes throughout the code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 394fb8e1ec0..41924b9320e 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -27,7 +27,14 @@
 #define MassStorageReset  0xff
 #define GetMaxLun         0xfe
 
-struct usb_msd_cbw {
+/*
+ * CBW and CSW packets have a minimum size, enough to contain the
+ * respective data structure.
+ */
+#define CBW_SIZE sizeof(struct usb_msd_cbw)
+#define CSW_SIZE sizeof(struct usb_msd_csw)
+
+struct QEMU_PACKED usb_msd_cbw {
     uint32_t sig;
     uint32_t tag;
     uint32_t data_len;
@@ -405,11 +412,11 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 
     switch (s->mode) {
     case USB_MSDM_CBW:
-        if (p->iov.size != 31) {
+        if (p->iov.size != CBW_SIZE) {
             error_report("usb-msd: Bad CBW size");
             goto fail;
         }
-        usb_packet_copy(p, &cbw, 31);
+        usb_packet_copy(p, &cbw, CBW_SIZE);
         if (le32_to_cpu(cbw.sig) != 0x43425355) {
             error_report("usb-msd: Bad signature %08x",
                          le32_to_cpu(cbw.sig));
@@ -489,7 +496,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
     switch (s->mode) {
     case USB_MSDM_DATAOUT:
-        if (s->data_len != 0 || p->iov.size < 13) {
+        if (s->data_len != 0 || p->iov.size < CSW_SIZE) {
             goto fail;
         }
         /* Waiting for SCSI write to complete.  */
@@ -499,7 +506,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSDM_CSW:
-        if (p->iov.size < 13) {
+        if (p->iov.size < CSW_SIZE) {
             goto fail;
         }
 
@@ -636,6 +643,10 @@ static const TypeInfo usb_storage_dev_type_info = {
 
 static void usb_msd_register_types(void)
 {
+    /* Ensure the header structures are the right size */
+    qemu_build_assert(CBW_SIZE == 31);
+    qemu_build_assert(CSW_SIZE == 13);
+
     type_register_static(&usb_storage_dev_type_info);
 }
 
-- 
2.47.1


