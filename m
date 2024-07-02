Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F513C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZid-0002Q4-Fl; Tue, 02 Jul 2024 05:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZia-0002Aa-EI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:32 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiY-0006XL-Ej
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:31 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ce674da85so4260900e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912148; x=1720516948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pum4FAVUTjoo+qizzaMYQ9jJ7vnP2diemnQewFpOPU0=;
 b=wKiZhuflJZNOvfwwMtQRds6slGjwZWQXrAoDs0d2Kt8pl/b8CGg5nvZVgwVg4RdUhl
 CzVUNkVF0xTA1jo/hxSWchlFUJDbpCWe2srNlneVL4RZagkKfuH9sSQa+n6DXOOu2UbF
 wmwQDUBAXky9uvLqs3kv9sXciar+g2GN/q0zTAOdHnayfo9BlLNH5X5yIjWz8fY+hbg0
 oSKZ8jcLm+OIQE3zm4eNgdo+yuqeoGOcznk2tQLDrzA8QmchszxkLOVxCJg22AXtNqQL
 6GUgDT9S61ucQ+1xWtFn4thRxl9J8B/cp3ojzpWTDRoHmZ+hjHBF0kh7uYM61sn9aWAp
 chiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912148; x=1720516948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pum4FAVUTjoo+qizzaMYQ9jJ7vnP2diemnQewFpOPU0=;
 b=RoTYbiYkJXW00jPfsALoOr4Kzg9Y59uh70qlXAIjTLp6gYbTQwJyG0rKiWYo7AphKV
 mAAO+tMy7HQ0FFtSevChISUBJW0uVgfS3cLyZ+SkxboP81I2Stm/970EwLD+XDsse6Sl
 4lfHfPJhuU3Sshf0gxBcYspREJdroYIaTgbjyPekQ0pA02Ti0Ajw8ARqX7YbKzVRmmKZ
 hkDtTYggZ1hmGs22rYaRbekEdc65+v/dVvpIhZyCvPkyHnjT01UGsBe1Y0xmZ5bzyJEb
 FcOwj+8m26+gaESAEFraVk5p44HS0nVbL7S/jvZFbSdj05K0TM4fqfyM6z7qecnK840q
 baJQ==
X-Gm-Message-State: AOJu0YzqsicqpRG41DV6Bww0vU92pqgeQp8DNjpDwUMQlCUXMud7U0Lm
 GzhD2ZuL1Qec4JZAwl7m8VujgQwEZROkiHD6BwB3TA7bDWe35EvAtz6JqOQ8wKMtA05sa5XtJVV
 e
X-Google-Smtp-Source: AGHT+IFJgcAe3DIvQsOfxG94XrNmSIkmejKtyruqKeTUYigY5t7KLUTDd61pKZc/HMUK+4sfT2KgIg==
X-Received: by 2002:a05:6512:398f:b0:52c:e4bf:d55d with SMTP id
 2adb3069b0e04-52e8264d9fdmr6743732e87.8.1719912147962; 
 Tue, 02 Jul 2024 02:22:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd623sm12678718f8f.16.2024.07.02.02.22.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/67] hw/sd/sdcard: Convert SEND_CSD/SEND_CID to
 generic_read_byte (CMD9 & 10)
Date: Tue,  2 Jul 2024 11:19:59 +0200
Message-ID: <20240702092051.45754-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-21-philmd@linaro.org>
---
 hw/sd/sd.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b073700180..6b02e0a178 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1304,11 +1304,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -1328,11 +1325,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2123,15 +2117,9 @@ uint8_t sd_read_byte(SDState *sd)
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


