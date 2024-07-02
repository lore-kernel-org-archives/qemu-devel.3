Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CA5C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZj0-0004Lh-A7; Tue, 02 Jul 2024 05:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZix-00045t-6S
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiv-0006et-69
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-363826fbcdeso2295332f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912171; x=1720516971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44A7uKnrLEqCTNEeUcpB4p2VqBTe04M5aS1mgYhUgXI=;
 b=TOWH08fHC0LdJrKRZvZkA47y2Ja1IxkA726rpX/BlKmADnFnHHOW6AZO31jtAt1OGJ
 +Pp1xqJE5T4hIFkcr9pssKeb/DiGcyTveHzlsJFaOlAszFbJQeLksPyI183vFqJVSA/I
 UjEF8Sl+RZYOpeO5iOvzDaJ8QTUXRf5ykVllsAAwIs8e5KcBcKgoFWLd/jtuLrWAaMRz
 /ZYgT9r7sQyluOk4fk0e5JVACR7qjCKHkG40dSh0dKISPtd2ZlgxAC0k3JOQP8tgvXLE
 WWy114AGiiOsSNF3Oacx+f22UhpfquF2KtVooI6o+V9caR5l0AkzAPB4jV2YNd14qBHQ
 vIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912171; x=1720516971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44A7uKnrLEqCTNEeUcpB4p2VqBTe04M5aS1mgYhUgXI=;
 b=HKGrQomGMtsRgcsiGEuZs1R0l8zAWDBYlCmaCXip3o9Bno3EcbkSHFlW+XTRpJMRs1
 N6EzAbgOHXxDgN9Jti+x9R1kvSMzJQb0zD6tcRUzHWNdp5b9pIFMRqU9X0P49eFT2UVj
 pjhHFDSTTw8Lx3onPL3ACAA3EW1ml+klOx4UcgWU8fpCKnKQAMnR7Onj9ye33/Y4HXmb
 fCkMBfeb/QxhuHK7U23b8ZSTC+onGXpCz1Lh2TXgC1E0jqJy6dt11HG3ShflliOLHx9c
 haJvxTQrR5a/Tl0/1N9bB44q772h5b73HjUK0hDE/eIboFPPSXW/MCQQVdsiCrHLI33V
 1Xxw==
X-Gm-Message-State: AOJu0YxCBsGp4Pp2QqTZkTMDGv0b0oNsuQaJjKGoAdiQ0T1LhexHUzEQ
 hvlirHVFtMGzyyoGcSu8xjgCUHrUDG7DOI6ABsvcBqrelpaQDQxVDeA3bBpSO1PobuEZeee5XFS
 b
X-Google-Smtp-Source: AGHT+IFMYq1WCSvUlSlGedVZ+5rIH93F8Y5LBqjSIspPIbEkUmIDcpvE9qFeVLb3evWBAAQrFzKh3A==
X-Received: by 2002:a5d:5f91:0:b0:367:83e9:b4a5 with SMTP id
 ffacd0b85a97d-36783e9b614mr993638f8f.49.1719912171329; 
 Tue, 02 Jul 2024 02:22:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a112e19sm12631308f8f.116.2024.07.02.02.22.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/67] hw/sd/sdcard: Convert SEND_WRITE_PROT to
 generic_read_byte (CMD30)
Date: Tue,  2 Jul 2024 11:20:03 +0200
Message-ID: <20240702092051.45754-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-25-philmd@linaro.org>
---
 hw/sd/sd.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 940cbb0d3c..1d6bacf885 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1194,6 +1194,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
     uint64_t addr;
+    uint32_t data;
 
     sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1547,12 +1548,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                                   req.arg, sd->blk_len)) {
                 return sd_r1;
             }
-
-            sd->state = sd_sendingdata_state;
-            stl_be_p(sd->data, sd_wpbits(sd, req.arg));
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            data = sd_wpbits(sd, req.arg);
+            return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
 
         default:
             break;
@@ -2132,6 +2129,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 10: /* CMD10:  SEND_CID */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
+    case 30: /* CMD30:  SEND_WRITE_PROT */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2173,13 +2171,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 30:  /* CMD30:  SEND_WRITE_PROT */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 4)
-            sd->state = sd_transfer_state;
-        break;
-
     case 51:  /* ACMD51: SEND_SCR */
         ret = sd->scr[sd->data_offset ++];
 
-- 
2.41.0


