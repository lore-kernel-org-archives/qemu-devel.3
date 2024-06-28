Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EC4C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fD-0004NM-Hd; Fri, 28 Jun 2024 03:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ew-0003p2-Jy
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5eu-0007Ac-9V
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:37 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ccc40e72eso230025e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558274; x=1720163074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IMgFwh1ILCldQYzDAsSnCsrKfQsCDMsdI1Fnj4dwB/k=;
 b=EPBdaDQr766xiiVG2RZhY1wvuoupD0fx4WQ4NLiv72wlKmKwisnXn/z2Fz71MFN5UT
 NFSOqdLyqUhxBsc2JMk7YB4El9D8B3pQJ0yIMJJgkZkkXAz6hjy3j+827Ac9cD3NULSk
 GdnwZgEi7g5SJHyGYVmuiDKRMpevJPd8JPIJ75Yn5lVIQXWnl2AGMTBYgJl6T4gdaXjR
 Ay/4j1bafxc01CobRTamX/MFq4NrZFb5ZRXM7Gy3tV2lF0J/ZdL8GgVRM8ZPdXnGHq/s
 g1oDLaVh9soQt82nPEzOt9oaJG/9a2hT+p/TTqKOgugu4J83cPPAlrTpd3FM7DvQZWdk
 zW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558274; x=1720163074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMgFwh1ILCldQYzDAsSnCsrKfQsCDMsdI1Fnj4dwB/k=;
 b=TUpB9k4dtIzd72oRAUxH+GTTvcYxfdIH8AfGQV2z8s256XKL4SlfPPZeIYASr1QBmU
 I/C6Zj9EeuI2/roo52zH+FvxUnoX0L9+7+FbBrbEanrYEAVanW5rjP1Q5aRawX8/8l/4
 xhloNwABSK6TbuqvmpdLiiSrCJZWfYV9iftEMe4HsxffU+WCrZ6P6Ai+Jv8PvxOHK3nA
 AWYmFNZ3wVJ2utIr2Z+JWBwIGwzYKzskqW0I/OFw8jGFEQUeinDiOV76DgTDczCdbcio
 9uEGVPC3xv/sUD5EfTQnTWwIp6HyU7pYhzyOAokZ3oFQnxrMTXOOqevXhWAZkaPfmOto
 rknQ==
X-Gm-Message-State: AOJu0YzlYHpfvzC3rQ+Rsvonnw0ag+eK8mQL+G4HJleeSInH+6gi51h/
 7z0bu2Ahm534gCrMQbQWrtxBwXVqtacRe2hStcpSBX8yBfBOyhMsFx0dfGTFzAOeVjRecYwhO8N
 VQEo=
X-Google-Smtp-Source: AGHT+IEP+7kuNfW8akz/hP7mCDozVzwPctfTj0XJcHEjQ4aO1ROaXXC1yLBXUOULQtTJA7eiJU8I8Q==
X-Received: by 2002:a05:6512:1154:b0:52c:9942:b008 with SMTP id
 2adb3069b0e04-52ce18325femr14285825e87.2.1719558274074; 
 Fri, 28 Jun 2024 00:04:34 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5a3b0sm21459575e9.13.2024.06.28.00.04.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 20/98] hw/sd/sdcard: Convert SEND_CSD/SEND_CID to
 generic_read_byte (CMD9 & 10)
Date: Fri, 28 Jun 2024 09:00:56 +0200
Message-ID: <20240628070216.92609-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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
 hw/sd/sd.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f7735c39a8..8201f3245c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1312,11 +1312,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!sd_is_spi(sd)) {
                 break;
             }
-            sd->state = sd_sendingdata_state;
-            memcpy(sd->data, sd->csd, 16);
-            sd->data_start = sd_req_get_address(sd, req);
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                         sd->csd, 16);
 
         default:
             break;
@@ -1336,11 +1333,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!sd_is_spi(sd)) {
                 break;
             }
-            sd->state = sd_sendingdata_state;
-            memcpy(sd->data, sd->cid, 16);
-            sd->data_start = sd_req_get_address(sd, req);
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                         sd->cid, 16);
 
         default:
             break;
@@ -2130,15 +2124,9 @@ uint8_t sd_read_byte(SDState *sd)
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
-        sd_generic_read_byte(sd, &ret);
-        break;
-
     case 9:  /* CMD9:   SEND_CSD */
-    case 10:  /* CMD10:  SEND_CID */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 16)
-            sd->state = sd_transfer_state;
+    case 10: /* CMD10:  SEND_CID */
+        sd_generic_read_byte(sd, &ret);
         break;
 
     case 13:  /* ACMD13: SD_STATUS */
-- 
2.41.0


