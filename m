Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE95DC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMryp-0001Dp-Vs; Thu, 27 Jun 2024 12:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrym-000183-U8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:12 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryl-0003QO-5j
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:12 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so91455771fa.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505688; x=1720110488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L78DEkAbiZk4g5l5bieI9G3pq1quTielmVGwRkKOrNQ=;
 b=TPYZ0s4pa17D9zpVItFqHQSK1/KG3cvEIvhXDIYGa+7CVF0iCq0V+SrACcwIMkolGq
 aUJLz/ZQy1z5JDaa/HOes8WNFGWDr9YBAj3IzkmFhjkdEoBZpB92epRiuaaMwEj+Ilub
 iE+sb9BISjJ2p4SQ6dSCU7Nh9kQLAnfkB6WJd47TB+v3slERjb8vO+JltZy6Zv1kZevX
 IXveoUE1TJaUJX5lWQOTJ0O5TYqHkUwx3FjK+4zxeFzcv4ATkFrFlRCqO8JEhQvAgab7
 m5L/4CQLd+o0q9jE0CB6d/a6kkwf2At5HEDhUaF0+1spBCJwAlXwfYD2F04n2reyq905
 Zl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505688; x=1720110488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L78DEkAbiZk4g5l5bieI9G3pq1quTielmVGwRkKOrNQ=;
 b=BrSXnWJLfxivwY9B3QeJFVnDh8rZFS5F7r0TiQHy0GUR1tEI0G0rChr4xTzrTka2g0
 pH9MJeQv93KNCgPOiH0oSRiXxoBIYUVC07qltUhMG36267RBCGsJF7R9guOyYkACiPG7
 tDVnfc7qeGFQrsrVAHcwu21fI90LMHZa0WdgnlT2IgXvowb1p3mCDGdjBH6ViMDR40fw
 jtwXrPivCjVhy1WyRkuJdzwSg/YLGmoP9aSO4eU9I8oaBkPKQdub7uLM6p1pM509HNf5
 4cVZ7WAwXfkV3JhnXBOktlmlK+fhNxOaN7vU+32mYCHCHguczdcRSPloN/40VSMk2xyH
 sQfw==
X-Gm-Message-State: AOJu0YwcFhRR/E7yIJRVyrso/IQ7tA/DCNlmZHw8oPRm11iueZszIuaH
 1NRxwmAqHTqEGsHHleTRA9ZIWQvY4eTmBApWiIxS12ayofbN1Ujp/QFxibvYk4UuiL3O5cijxUa
 Y94I=
X-Google-Smtp-Source: AGHT+IGjgpggEaOBrJTqK6x7e8bO8FhKBflrOfQmF8hBfvQtpMOqC//z62WvkKdyxsGvcffbqu0pyA==
X-Received: by 2002:a2e:9895:0:b0:2eb:e177:14f8 with SMTP id
 38308e7fff4ca-2ec5b38ac24mr80911641fa.27.1719505688107; 
 Thu, 27 Jun 2024 09:28:08 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8424554sm73694685e9.37.2024.06.27.09.28.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:28:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 03/11] hw/sd/sdcard: Convert SEND_CSD/SEND_CID to
 generic_read_byte (CMD9 & 10)
Date: Thu, 27 Jun 2024 18:27:21 +0200
Message-ID: <20240627162729.80909-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


