Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5581BE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9W-0004mG-QL; Fri, 13 Dec 2024 18:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8l-0003fI-TE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8g-000358-Tv
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:09 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so1763665f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132725; x=1734737525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVMMyVcYu4LVL1Yzkvds/PCKbLlLdQN2hgXKn39Ce2s=;
 b=sZ8mJPsjoVPohgFMzPx0eX/ZeI68Idlja/rqpaadGMRZrAFh1wrwp2lsIsVGd24CRc
 PCZCUi+BNuJs0AcaE7tkiPNI7e9DIAsSJjk7zrV1EzSQ+fcZLVc/+jDej0d+99dZ7ipi
 yPyjm+JHJvxh2nKw4hzvrAkb+l3LmFglOql6sleiw7/ajX6e1AjxlYfXupg/mkroxp9z
 9f3SnltaZLCjJpABK7NbTRKp/cadpPa4c/MM04Jg+lfSfg9AOOjjoaaGCgH7NK6VIk1L
 K7NU/Q4/4G5kLSd6Ja00+jf/gHhUIiW5Tc94lwS4Ze+MSvC01WqU/47N8d4krpXRakxE
 FC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132725; x=1734737525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVMMyVcYu4LVL1Yzkvds/PCKbLlLdQN2hgXKn39Ce2s=;
 b=gEroSdipNcEXloCWabEuatBZo3vnfmx31qLL+ml0kxnNODcQMBD+aQgr+iu2aIs7Sb
 Jt41YXNutvS6TxsDQZ8dDsLyy3P1rIDxmaBkHjFjLxiQSO3y5E4Pwr9DVS3ge+g36jKS
 OKIsPxr96FdTr87X4xUEn559OoQlhydIDmP4/E/TvyeHpFIpiz7LINLKtYY7VgSagosg
 axMEWauSjtTML/p/swWj4KP5DE6x5GE3D6882EB8pbFyYRB0tRShSdmePTz9D67s/7UF
 RxzYorYakfmwG6TuVkeN+6eNfUSwjTxNyiit1Zqmz5bfyW+13su2HkWK3PJf1/uxFmeT
 +LcQ==
X-Gm-Message-State: AOJu0Yz7IZduGb2XBS9C9H7a+f40D4BXLXjc3fRIJctTZ8v8sUs7crvh
 0I2TAZqIQQ3RV0mDfiUDkBoN3KYhF+UG8BP/ZVZ+7Jcu2mqlDNK5uvfn6zONpdopjpIH5yJEAZn
 oyHg=
X-Gm-Gg: ASbGncuZKB/r37ijCY+PoqgYdQlPJ5I9/iEehsl47jJUyNPUngj5DeuS4LGVAopJgdM
 7n8dveLBXPuAx/tSnK8quPNm6HOhkpJFP9pDAAl7raimcKC6jRPPKirE2BB8JHsVLE0KoHQs5yQ
 jxcOvT0EtPFQGwSORUypFusMKY1MAGJrcVEc0LGBf8vvIjiyfykjBs/KC6XjaHcwq4HFf3XUz3g
 S5CvtTIKcjoyRbtC8Yc5kzcd/rFPK2F0LEJWB6dU/goOaSJ9/ti/5IZv0RLl3afJeRFOG0EUFCc
 cOAxwg==
X-Google-Smtp-Source: AGHT+IHqwFss8Ao8YZJ62/8iDw0BsLag2BNuJcyyb0U7qIAVtmz1jrEApjEPAtHaqnL+Rn095sR48Q==
X-Received: by 2002:a5d:64eb:0:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-38880ac3066mr3254822f8f.7.1734132725046; 
 Fri, 13 Dec 2024 15:32:05 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c806ce56sm786880f8f.111.2024.12.13.15.32.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/20] hw/usb/msd: Add status to usb_msd_packet_complete()
 function
Date: Sat, 14 Dec 2024 00:30:48 +0100
Message-ID: <20241213233055.39574-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Nicholas Piggin <npiggin@gmail.com>

This is a convenience change that accepts a status when completing a
packet.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241110034000.379463-2-npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


