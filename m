Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74E3C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fg-0005sV-Cb; Fri, 28 Jun 2024 03:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fV-0004ji-S4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:14 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fU-00015h-5q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:13 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cdf9f934fso247212e87.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558310; x=1720163110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sU/k2Rks1jINZkUZw0aLSNYbtB22cqllnIk+1At/gmc=;
 b=t1pDEPLO9zAY6dxvMFWvedYvkixfny8a2Eo/5gfixIIwpnv/3+mMlFgAhePQi6JdNg
 us2jcym73qsNtzTKj6HEyZy6UYjSdBi1Yj/ws6zi7xeaUSKyV5nhKu4mdOAmPbTZQoNQ
 KGdwHxvB2B9HZKz/W1kGURcoxYBPSFmc4++WdQsR3J+mWFmb6tCZVAFNAG27sQ0+0GtY
 bxjydW12iurciJZ1r9H8m4Eb1orcIKFkvgzBaSk47fv3cg6YsRfk9HMHl4pLXeWOPlqv
 4f6+f6mDf/iYEgAg9mycBgGo1Nd8QShIZ0r3SHcMKyOWV+rhaip8oLEQbTh/EqLcwjPO
 j5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558310; x=1720163110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU/k2Rks1jINZkUZw0aLSNYbtB22cqllnIk+1At/gmc=;
 b=F8tnVkRWBm6jIill88FCccWbLwSTYW7UTA6hnXqySu5FBwpD+UnbbJE3SvoAudSVG9
 usYW251TCM4oUCeKaT9bYEsaFOqIUkE94+sxfpPmnoJ8YorTL6i/BtR+cxfBpDjSsELX
 4TQ507hgvSmsY5cCi4sPEUejtGDpmAEVZBZ2PsAzV7Q8+ar2J3d4Nl8KqluyXVzfPLi1
 njHyIjEW6GNFi0+gHp0NpKqC+v+XV9Qv/uyJcTldOg4U0Pm9n1wzpN51rCVSvqPm6Y6s
 9q4uop5LOdgtw0miqiT8tIfEjFBn+6EA2NFgqkD2Q87ySD0nTPbUlEhfiTHO71B+rC5o
 WThg==
X-Gm-Message-State: AOJu0YyMG03RPKfua68P8A2upFV8j+k9lxyavXIcL20LvuZAenyVhw26
 KuZMa2kE7LYJG/Kciyl9zBWQro9xgyPgG6/gjA7Ysr60NsWFkDAVZbdWsLcjdGqsfKL+9t40Cr3
 woIk=
X-Google-Smtp-Source: AGHT+IFAq0fXJMJmcnKVRTUzCA3JvP1VJB3p41m3E8z8bLm/xSF/9cE8i+rVRPezw9NYAy6F4LP7JA==
X-Received: by 2002:a05:6512:715:b0:52c:b008:3db8 with SMTP id
 2adb3069b0e04-52ce064f483mr7976797e87.38.1719558310111; 
 Fri, 28 Jun 2024 00:05:10 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fbbd4sm1327324f8f.84.2024.06.28.00.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 27/98] hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to
 generic_read_byte (ACMD22)
Date: Fri, 28 Jun 2024 09:01:03 +0200
Message-ID: <20240628070216.92609-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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


