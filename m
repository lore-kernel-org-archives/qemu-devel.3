Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A441EC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrzZ-0004Ft-1C; Thu, 27 Jun 2024 12:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzX-00042I-7W
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzT-0003W4-0f
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so12999345e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505733; x=1720110533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0OGAnFsplarXOIRkfzB/tBQTFE1QX5yc3lFvHsUa30=;
 b=NkximAbfHZwrsZZoe9aAeCHIaepMoqrCaL2jukDcY5odVc5+ojfRdJzRY36C+BJJ2m
 iN332BWvqs3VM+Ii6/lwYsI8Q94jnu1aL1kA4aoPqDSEyuXqfI04MrNo+SwqKqh+km1M
 7pYuoo8fSON8WYWoCxsq1s+pggqRgXWnuWIyrBENLXKQxsk9PfSjEG28HrqGPwKAdwmN
 KsJDAJHlfWW3h94bkD3aa/FyLEckTQQ80V2Zti5Z6FNGLu7tuBcsha+gEzhUoWxjkAEP
 /onhrHWa0le9XOUGWeDCk1tFEG34OMGJ/Fffo+khIPW6dlpbZjoxVGl3PLESZbaFrILY
 Ljzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505733; x=1720110533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0OGAnFsplarXOIRkfzB/tBQTFE1QX5yc3lFvHsUa30=;
 b=tpFi2lPqiKp2S4jBeICmq08F09/yqfTnPhSreg7GF2+wIcUAKUMNHjkW28mn7uoJMT
 SVV7ZMcCU99e7IoVJzy60CeG/8i8/XysQICEWMLWKxbw41lIFVIH1ZUjSCrBdeFLDcF7
 PFUkfTQktH7T5FMSkWYlWo5EMHHA8YwEWGNG00HEnPMSXkEEWOwzaRa/wsvaQ1cbprTR
 FTrc86PWGXTJwD28Ss68WDEZoOiHG3aOWDwV0esUHmRFGGOkT1qTlXa4spWieotoyRfR
 TI8fpaXXFOg6UQaJVBEXSpv68m442EP+IDhsq+K3ZWCXKGOCoBIkjW8mSeBPwor+aPlZ
 nElA==
X-Gm-Message-State: AOJu0YyvjlEOZcE86GIDTj5oCLMPc55j4JqHpBKyok5FLQWrEF9ftHCM
 /I+q90xF9x9kwgg51sjUdM9rUiCWx9a2TxIkog1+8LpPTxU5VT9+P4w5RQv7GHFmqb+KKGivY1E
 AatQ=
X-Google-Smtp-Source: AGHT+IFgBCoSuF6W5LssKnAsW241RIRXJsXCJ1FBJZp91YGpujY4cOx+ivs697wMPeGswdTDWmMIZQ==
X-Received: by 2002:a05:600c:5104:b0:424:8836:310c with SMTP id
 5b1f17b1804b1-42564316399mr24158445e9.5.1719505733307; 
 Thu, 27 Jun 2024 09:28:53 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc59f5sm35576815e9.42.2024.06.27.09.28.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:28:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 08/11] hw/sd/sdcard: Convert GEN_CMD to generic_read_byte
 (CMD56)
Date: Thu, 27 Jun 2024 18:27:26 +0200
Message-ID: <20240627162729.80909-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


