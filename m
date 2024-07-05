Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2448C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3B-0001si-Pa; Fri, 05 Jul 2024 18:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr39-0001qH-Mu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr37-0007Bm-CF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-367963ea053so1574076f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217098; x=1720821898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7r9/bwMA7Y9aC77VYKrC6dcppuacEWAp1H+HkEgQaQ=;
 b=nE6thAv/gtU5DRGDUnUYdqpI9zF8utS6clazL6K6RAMMdYJG+zW4r/Yre5hZ3DrRB/
 i/fR5mQxrmpNKc4YfOtirXxHlnM2sUC2XaZJilvMuxlRUGUvULrNteoEfB5d1okoTul+
 EoUsv5pBJe3hFwVwpfMN3TUKdOZcFJXSXv2n0XlwZJoBh7JqDGMOOi8nTzTjNcnRN9CQ
 ZPW4EuEdyGpwD0q2xh2q06peLJTr4JjHG1KOXJCwus+J2d7QBnMBXy7Hi6wuf2YG/ICs
 s4W53EJl/E+i/gNyuo+usjsKqmmm5DWZM3vgbqquvJIcYF2ySAi8Xpyb1MXtLEDGkkMK
 toOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217098; x=1720821898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7r9/bwMA7Y9aC77VYKrC6dcppuacEWAp1H+HkEgQaQ=;
 b=DYiBruBF8BSZ1g1bQDoVVa+O387B16gNdyolpLlpiqmLpKErdZg2FXjJRuqy9gux2G
 XsmjEsagX/q15uMbqiE4Md8BqMSKiwUCzmIynlvk4DB7hscNywqEoN044F4olVh7wKh0
 d1BEHE/baiSyDZeYtf5UueUDboRea9PIqnpZXrZ8rbl1lUI0y6F+70snzEMK6HvBlGMz
 w6IXkrrxmj69peYFjIlwcQBVK7Nd3/ZZAj/gNm5Ct0aA4/Lxh6WytPjwEWDWVZR5djwB
 EQ5qjZ+uBRlKdM1ZN15zPfJWr3L1bDbdCuSWNjJEMD4NF/DoTaduZS0zSyVD6m2VKakO
 15og==
X-Gm-Message-State: AOJu0Yx4ZBSOPT71josD8lRwrG+jqebclYLe8+foEF8y3IvSvkQpqToi
 cWYBf1GShpE+xtYtcK0wMQXmBIV8jh+GVseqVyAb4rKkULW0eqK2czF09nRrEQf1wP1UkDBNszM
 5
X-Google-Smtp-Source: AGHT+IGmddp/Mt8Q/t8E8svxiBEF62A6ZsMiYILbTVZgSvZCKsgXjJ6iZjl9TTxughSmc18S2KqLIw==
X-Received: by 2002:a5d:4745:0:b0:367:8de4:84ef with SMTP id
 ffacd0b85a97d-3679dd31158mr4923237f8f.30.1720217098129; 
 Fri, 05 Jul 2024 15:04:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a8d74e0bsm2700480f8f.52.2024.07.05.15.04.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:04:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 04/16] hw/sd/sdcard: Generate random RCA value
Date: Sat,  6 Jul 2024 00:04:22 +0200
Message-ID: <20240705220435.15415-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Rather than using the obscure 0x4567 magic value,
use a real random one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Message-Id: <20240702140842.54242-5-philmd@linaro.org>
---
 hw/sd/sd.c         | 11 ++++++++---
 hw/sd/trace-events |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 552957b2e5..b158402704 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -46,6 +46,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
@@ -515,9 +516,10 @@ static void sd_set_csd(SDState *sd, uint64_t size)
 
 /* Relative Card Address register */
 
-static void sd_set_rca(SDState *sd)
+static void sd_set_rca(SDState *sd, uint16_t value)
 {
-    sd->rca += 0x4567;
+    trace_sdcard_set_rca(value);
+    sd->rca = value;
 }
 
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
@@ -1212,11 +1214,14 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 /* CMD3 */
 static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
 {
+    uint16_t random_rca;
+
     switch (sd->state) {
     case sd_identification_state:
     case sd_standby_state:
         sd->state = sd_standby_state;
-        sd_set_rca(sd);
+        qemu_guest_getrandom_nofail(&random_rca, sizeof(random_rca));
+        sd_set_rca(sd, random_rca);
         return sd_r6;
 
     default:
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 43eaeba149..6a51b0e906 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -43,6 +43,7 @@ sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
 sdcard_reset(void) ""
+sdcard_set_rca(uint16_t value) "new RCA: 0x%04x"
 sdcard_set_blocklen(uint16_t length) "block len 0x%03x"
 sdcard_set_block_count(uint32_t cnt) "block cnt 0x%"PRIx32
 sdcard_inserted(bool readonly) "read_only: %u"
-- 
2.41.0


