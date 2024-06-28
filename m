Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF9AC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lN-0002fi-2f; Fri, 28 Jun 2024 03:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lK-0002d2-On
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lJ-0004sM-03
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4256f102e89so1287155e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558671; x=1720163471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ojivM3IaWwWzglQz4g05HwWNW+Y8YVh/DQQ1yO/B8Js=;
 b=gRpHobt0fg9khKD4RVG24jp6wuVZwOKC6cqlx7qDGRr7NlHfsMugQAzjzK4xAdltID
 Z9pVrAAp9CmOwKAC3s3rlcrJfQZ56mC9tr7XQEVx6+9RUBA7LhnIa9VIn2+GA34T9KUA
 lJCPHQGwnn8BMrWeYHCSxA5WcQTqhlmnzXvjjJ+yIfinN68gac29fDb6XQLOd3RFypFP
 PF2PMfykUG6Wxw46reVioF+6CUH6eZe02WHVlKpL2jBWgazkJz1nLMh4mtQiXfqctS0V
 e4XmK67an7OklKCcM7IUKNKUaFOPsdc5wzyoXDXTUivejc7IucLK3zBuFNKhomrxjdeC
 qXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558671; x=1720163471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojivM3IaWwWzglQz4g05HwWNW+Y8YVh/DQQ1yO/B8Js=;
 b=l3FxAAdlICLLU17Xr/9iLwopo+VF7HqsHFjngIt2NMlIlCpteWhamIWIU6f+/QFqNg
 gi31bYMQ4NyhUhTKi8Jrm0areQxnKFzvSOeeBwPuS06GhzjHGGyNayirw1GZhzP/UOad
 5Yq8CzUoLArYLCFAssWxLPQNFVUjLpDRikzi8mulrf/16vNJkXheogT3ocsJOnOqVYPy
 eFI6BiibTCWVI+c7lG/8/7gv5lTIgNvG4eWartQWOqNaaJAU+QGoIJlbfWvhcOIcGnDn
 2z8jrCWnfEQNtRY5cD8IBdLurRNNdn2sEbT9zodOFgCZ+Yv3ijmDgpTLE3GKX/u8j4jX
 BhUw==
X-Gm-Message-State: AOJu0YwhPPeboc3DH+spektx0RRyCB8dkQWfeJ1cicqN5mS9HGZfv7Q8
 GW0PffqiX1UOPORID2UOV1T8zNeRf0yfEsG1Lf/fIfJqBnk7h0xdf4vnQPDUPEZclObcZhBufwm
 OC1o=
X-Google-Smtp-Source: AGHT+IFX+qfOMZGKPWNS0Kz2JFKQBhOJ2wL/tK1dIW446bn8/0sp55dzVE8cjS/c5ONifm/UTF53zA==
X-Received: by 2002:a05:600c:929:b0:425:65c5:79b4 with SMTP id
 5b1f17b1804b1-42565c57b9amr28625005e9.26.1719558670999; 
 Fri, 28 Jun 2024 00:11:10 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a2abcfd0sm62373955e9.1.2024.06.28.00.11.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 92/98] hw/sd/sdcard: Adapt sd_cmd_APP_CMD handler for
 eMMC (CMD55)
Date: Fri, 28 Jun 2024 09:02:08 +0200
Message-ID: <20240628070216.92609-93-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
[PMD: Use aspeed_emmc_kludge]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f875fcd741..82e0b5838f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1693,6 +1693,9 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     case sd_sleep_state:
         return sd_invalid_state_for_cmd(sd, req);
     case sd_idle_state:
+        if (sd_is_emmc(sd)) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
         if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
@@ -1707,7 +1710,7 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     sd->expecting_acmd = true;
     sd->card_status |= APP_CMD;
 
-    return sd_r1;
+    return sd->aspeed_emmc_kludge ? sd_r0 : sd_r1;
 }
 
 /* CMD56 */
-- 
2.41.0


