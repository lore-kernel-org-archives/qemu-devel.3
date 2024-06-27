Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703B4C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrzz-0006vI-00; Thu, 27 Jun 2024 12:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzx-0006q2-IO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:29:25 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzq-0003aI-4W
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:29:25 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ce01403f6so5520727e87.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505756; x=1720110556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sU/k2Rks1jINZkUZw0aLSNYbtB22cqllnIk+1At/gmc=;
 b=TqP9ojXbJFcm1yNC/pr4FP1p946PY4m1Y+0dm6be54VvGs9u8DRH3Rtb646ouGkBZC
 0nq2k9Ih4/zo2Di3frvKD3Wh07Ej7FGWQziQr3tZ7E2br43uQMhqg3DkucFYWDaQGbiS
 2NDPdrZ6MDItKWc4Fx/he1vWKb/w7ycvkkzW33J4zh2QHyihwoAw2VoLLIIMsYs6sOvK
 DDyWECjZS0CtkR5tzsGJeaQX014PNh2Ke/hLx4E5q6iBnsIfRw01W8iVg1PMNCzEusBj
 zPyGedHcy5ZgkUb73TAWx0W6wXcJna7xFk/dQh74y7hWe5CkzFB2ZS0iEmJex8TJjgrt
 21Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505756; x=1720110556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU/k2Rks1jINZkUZw0aLSNYbtB22cqllnIk+1At/gmc=;
 b=xJkzD9g35yl77afFrrYVQndkyIG85TsFGzWQ+6mGbSa/69lLnJkYNOcuEx7TLmoj4t
 lfONqZ5FWBmIqxOikGFlSagp3M2eTk47HISxwL3C3U/+8ENd0OU95m6Q/tPCv40PL743
 F5a/6Z4za3j7sCa4tvNyBpoA+t7w41usR8ep0btnsRODwYIiudbkndGnC75DdUB/xUIz
 pd3xjZFlCmh71Mf9kwgCgZGqBvjMvhMVZd+Z/O8Ai/fy+uClgTjM/C+yV5yhLRZzXFbg
 nFLuNjo+ZKu8QOcu+o8TNx5b002dr/BFPvmv07aoj5g9YfT7QY/b9YHhGfj59s+2zCwt
 m6PQ==
X-Gm-Message-State: AOJu0YzziWd6rMMXJEwWFUwAbiaoNmsNGOeQ5S65pvCEBLEnruhQQHLY
 UkFGWJIZ96zfOoe1y4ETOe6D7pnG6ewDMq1rxQ1RczPYYe2kO1bsi6O3MpH6hhH1jqs3w3oxrnk
 qMkU=
X-Google-Smtp-Source: AGHT+IHVx04c6zs3uE+wkMDQmBW/+FLRPc3iuxJ3WbDGxnyqNrR5Vx9zRuGSaTsFTsXAzpnK9r3xOQ==
X-Received: by 2002:a05:6512:2509:b0:52d:b0a5:cf3c with SMTP id
 2adb3069b0e04-52db0a5e327mr5459783e87.40.1719505755838; 
 Thu, 27 Jun 2024 09:29:15 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c089sm2415473f8f.7.2024.06.27.09.29.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:29:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 10/11] hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to
 generic_read_byte (ACMD22)
Date: Thu, 27 Jun 2024 18:27:28 +0200
Message-ID: <20240627162729.80909-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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
---
 hw/sd/sd.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1c4811f410..8d02cd9a26 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1715,11 +1715,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         switch (sd->state) {
         case sd_transfer_state:
-            stl_be_p(sd->data, sd->blk_written);
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0,
+                                         &sd->blk_written,
+                                         sizeof(sd->blk_written));
 
         default:
             break;
@@ -2138,6 +2136,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
+    case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 56: /* CMD56:  GEN_CMD */
         sd_generic_read_byte(sd, &ret);
@@ -2167,13 +2166,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
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


