Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A762DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrzS-0003LZ-1q; Thu, 27 Jun 2024 12:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzO-00037o-5z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzK-0003VJ-LO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-424f2b73629so22835875e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505724; x=1720110524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXnvSPEQ0479Kw/NHZLng3szLmllyhp62LGUqGmd/0w=;
 b=OFKGwD0ivlbZnWH7p/QMvodQqcn6r59QTHglZw5G+H8SurDq5B73ZHRwEIihVMtvfG
 odkgMD7Rip0OlN88IJDuQWtGRlhGYaGNQwJhroJHlz9QEQhvDiT3eHxJTXNLdKEyEcwW
 E0arsNdaBXJB6HFxp0u0SsGil4eNx1TvRA9cmeTlUHx5u3Av7/JLKT3gnQtPRQVDevbe
 N9i7Fbrp42xkX4XiWgrxNwxWJaKInwWHi7xPtP3vwKifK2yxZ/ycPV//DTzPM4DywPYh
 UC1h6YzmWtRwSqfqaCfdrrIbexY/VqQMKOQ08mVtZtLjEr4U/oGKz0bMiNCS/i7QhpRR
 qgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505724; x=1720110524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXnvSPEQ0479Kw/NHZLng3szLmllyhp62LGUqGmd/0w=;
 b=mXQwGsRYYPwKi2cARDHoyoquTkPd3QCF+WUCn/7Y2Uyk8HtzI/U/uIwpnE7bIitO8J
 l61Gm38oFMZ8ba9BMzw7zx3RVQMlHwkaEFxzP7yMhkPUu9DTYxS/EfzvfnZmd7qaZuVn
 Y973GUjAIbGynfwyg/MZmA+LPkd/Z985K0R6sMu6BqAulwTQZBNZTWn5k2hCQzlhXlMg
 WOqdpruq/mhJ5vYJWtEbE+VD7zQzsIqTffVbS+eFVQZxFQ5tK7CdlDNRPPsSqBJEnQVr
 8K+cG0YilJZG7qednVVts0lCyy/x2qjrjYDx8Sf9YmQy4SWeyZ1qTdXFn6Yz+w9zuuqQ
 enuA==
X-Gm-Message-State: AOJu0YwzEqZJ/l6bvVI/PEO1VZVM1CClJIsfgL5VXsNSeMfB5e6+K7LU
 +sZ29f9642iuzmsEJdaNxxiAtcGme24WeJtuMLqYk7UK/Tcw2OSvUs6BPcDQcCU//Hr1XMctqDh
 M1Cs=
X-Google-Smtp-Source: AGHT+IHgatHNEdIT25HZ/RzZ9g+vd7DOOS0h5YFs6HuHyLRsEZAHibyf8Ejb+ifokMpP6CXTLVMFBA==
X-Received: by 2002:a05:6000:2ab:b0:366:eb00:9ddf with SMTP id
 ffacd0b85a97d-366eb009e92mr13900341f8f.3.1719505723851; 
 Thu, 27 Jun 2024 09:28:43 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1fcsm2379809f8f.20.2024.06.27.09.28.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:28:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 07/11] hw/sd/sdcard: Convert SEND_WRITE_PROT to
 generic_read_byte (CMD30)
Date: Thu, 27 Jun 2024 18:27:25 +0200
Message-ID: <20240627162729.80909-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/sd/sd.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index eece33194a..bf922da2cc 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1202,6 +1202,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
     uint64_t addr;
+    uint32_t data;
 
     sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1555,12 +1556,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2139,6 +2136,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 10: /* CMD10:  SEND_CID */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
+    case 30: /* CMD30:  SEND_WRITE_PROT */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2180,13 +2178,6 @@ uint8_t sd_read_byte(SDState *sd)
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


