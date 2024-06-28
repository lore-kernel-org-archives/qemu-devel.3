Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B1C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fa-0005LT-U1; Fri, 28 Jun 2024 03:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fK-0004dI-0K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:05 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fE-0008W9-GH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:00 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367339bd00aso229112f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558295; x=1720163095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cXnvSPEQ0479Kw/NHZLng3szLmllyhp62LGUqGmd/0w=;
 b=KESPM39ma/WMVuuwvO4sUfIZuFRc1bDRa65DFOPJVlSF9oeeNPx4mB8FfhuKS3Fu0L
 BoJR+RUPT0GIHC1rbZ1mh2UbYVy5CDRrwLfw0ndiidEQX8yeU6KNhAb6F1/E18GdHrxg
 v8ofHYbB/tr4Kc1VNYFY4wQN/+Mdvo9ZonRHv50SIRY5qGtvj195GzGvjJ1ggVnFqhp1
 hR2/BJHigQdee5UJWSpleFoG8fm3JoNOX6sn6s4szK0ObWTSn2M5QnDZKvQnHBZxxHvZ
 AHUb52btzVjMjgISNX+0Lf3PnzoQxsCn2AQbb3degHMZnkjTZpWlti5Oc+Jf6wqTrPCV
 4RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558295; x=1720163095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXnvSPEQ0479Kw/NHZLng3szLmllyhp62LGUqGmd/0w=;
 b=hJzMRkJUyEinSSFWv5UuydeuUugpFaUhHM+wPmSVpend3gsWOmg4KpAg/ehkZrPKBp
 h2Oeu79nzmPbSqn9n3px6gNTks6ifYEuBWcd1sxreNi02R3sXcQqmrDQl3BgQEU0XKrL
 pRAg88hoh7lTwwFGjUBNQI76g7hQda+HULQAzzJ4ltnzAJphggqvw1RprxPDsBmWDj8r
 ANohuWoh72/NS83z2/PE7r4cI7cnSr+tub9h9orkDfcfA4Xx5JbsAcggAtNkXw+nm+O6
 0Vt5sjlL2r25cKgF9XS4EeYADMokV6RFhURqdG/5KiuqptcEI+7fs8qUcuYcLJN/PWGR
 9rVw==
X-Gm-Message-State: AOJu0Yy9kxHe6q0cjWV6KYoXoZHJOFH6qZ5A/YwCVsVSNg7+4sI22dxl
 +LuD1eTc8uumo1f1cLzogjt1I7NwhVlFPNqzbhse6SIqAhRwAGSONsEtBE9PrD+8S4n5l75r0fw
 S7ek=
X-Google-Smtp-Source: AGHT+IHyRACznf6XoQtfq9q8/+I0JwbND68Z6ZHnJnv6MbZUoAaRhM1XXOxuq/V0jvETh0dZQgl5tw==
X-Received: by 2002:a05:6000:156a:b0:367:434f:ca9a with SMTP id
 ffacd0b85a97d-367434fcca3mr3584916f8f.0.1719558294741; 
 Fri, 28 Jun 2024 00:04:54 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1069cfsm1316272f8f.91.2024.06.28.00.04.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 24/98] hw/sd/sdcard: Convert SEND_WRITE_PROT to
 generic_read_byte (CMD30)
Date: Fri, 28 Jun 2024 09:01:00 +0200
Message-ID: <20240628070216.92609-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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


