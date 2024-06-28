Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF358C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fa-0005DY-2Y; Fri, 28 Jun 2024 03:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fM-0004eB-5Z
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fK-0000I9-7i
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3636c572257so239853f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558300; x=1720163100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IlTxhpvzZWvkbW0VpI4omM+WCLHLk77/0zlyk24X1aE=;
 b=thWkcIzMoz96tW9QOly6jjBETWrN2poA5vCM+vMOj/481Doirk+yVIMRXXRlHpVf69
 YP0ANHChMiT/qCBfY88yuroVoK7YOiNgenNOrg1s6AF2+IyBR+O9jCbfk/3zwZy4P2v4
 CfY4QSrJpPKg0g/L6Jvig3InkYXVFPp0PnG6wFu8hb/Z4w1rjlHQaGzAQEVvS03RvDHW
 aHtB4qIkPHyPsqbnaDbugjkK/To+kaJFdqh4Heia53f7qaTdkl2hh7A1lpwxe9AP8yNx
 RDptmSVebVbE6amAZb52g4FPKcgTvuTQhLy7l2rqwJo6AbOQPWL+CrgRWw5CHa3Balk/
 20/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558300; x=1720163100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlTxhpvzZWvkbW0VpI4omM+WCLHLk77/0zlyk24X1aE=;
 b=DkBybdT89Z3MxEDgdGinXtrlaPLxyEvBUtQHQqZoy5/ysy7DoW2Bx3J21B2YpmhFmL
 RWvn2+nzO8K5tczjLq6Ffe/XZyNQMwgrAmLtiIDO67xlrZFcnt+qE0/qKCSct9umz/KQ
 Y0r3y8hfPXTBdsPrrR/kRPR/asIKmwSrsojhMy9HOFSoei01qIpsnwU2pl1YNC6H0ulT
 pBT4M/M5jLxp6FBACbmm+01V0/A/ljApTycFX+T4EcXUltnZlYx5703Xvz6tnkiyp0yG
 uJ7FOXHzm/J9DscLej09OG06s0TqsRHYUjewWE2iXuxyKkGAPb0OPvLAheUqfn2ph3S+
 ZjBA==
X-Gm-Message-State: AOJu0YzH88nRpYqGn12n0/AB2TehVJqUPi5P1S0kukqbj8xeaBSJMTKf
 hkJJy8jGNxWt9KEyQVR3s2KZJKCSWIwjB+JYDnwzyyVn7rwLUk2OSdCzl0Fo+WHjR1nGtuDKj5h
 UWfA=
X-Google-Smtp-Source: AGHT+IGxz4BNfNyAWYnNVCW0TJxgokxcLXGaDc83PfIxFnw/GnqNAosXeeS9yp3qwI2LCovgUYel4Q==
X-Received: by 2002:a5d:628b:0:b0:35f:16c9:a5bd with SMTP id
 ffacd0b85a97d-366e949a664mr12647407f8f.23.1719558300072; 
 Fri, 28 Jun 2024 00:05:00 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9ca8sm1333096f8f.43.2024.06.28.00.04.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 25/98] hw/sd/sdcard: Convert GEN_CMD to generic_read_byte
 (CMD56)
Date: Fri, 28 Jun 2024 09:01:01 +0200
Message-ID: <20240628070216.92609-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bf922da2cc..ccf81b9e59 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1648,10 +1648,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
             sd->data_offset = 0;
-            if (req.arg & 1)
-                sd->state = sd_sendingdata_state;
-            else
-                sd->state = sd_receivingdata_state;
+            if (req.arg & 1) {
+                return sd_cmd_to_sendingdata(sd, req, 0,
+                                             sd->vendor_data,
+                                             sizeof(sd->vendor_data));
+            }
+            sd->state = sd_receivingdata_state;
             return sd_r1;
 
         default:
@@ -2137,6 +2139,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 30: /* CMD30:  SEND_WRITE_PROT */
+    case 56: /* CMD56:  GEN_CMD */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2185,14 +2188,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 56:  /* CMD56:  GEN_CMD */
-        ret = sd->vendor_data[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->vendor_data)) {
-            sd->state = sd_transfer_state;
-        }
-        break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
         return 0x00;
-- 
2.41.0


