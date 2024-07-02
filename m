Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75293C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZiM-0001aV-47; Tue, 02 Jul 2024 05:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiE-0001DD-Me
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiB-0006TZ-2o
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36701e6c6e8so2081742f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912124; x=1720516924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnOllaloZd2LpX3vFv80SvvLh9z9PQTQVpVybu389fk=;
 b=a4nUkmHvgRvGHnwTeZpyIPn5DxWLPUvquPd9JG0OIBdM0Ogcx8IBcfB07jRpJeL47o
 aOYiz2OWyVttxh9qmV8nWZr44BWpNenywbfH9Ux4HTJwYViNLcMchda2dHMdfi1HQfzQ
 XWY+5bxudzsu6VQZmV8AMJLV1ObaEneeAHtGl2Uti2Jo2NJ0gu5IOMzGNy+g68FqnlMm
 RJF/f9kN/IvO5dgy2atb2C+7oK5zo6bmmqaExQaKC8dlN0q7z4x6KGCjkzqYQpTn9s12
 7vpSEIbey4ZkIT2xhdEKLRaby5aVU/G9w2OpHjNA+djUOZt66Ei/F49HfmegH/CHM5j4
 6BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912124; x=1720516924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnOllaloZd2LpX3vFv80SvvLh9z9PQTQVpVybu389fk=;
 b=DdwCfvBeEim6Qm0KW6wqfOcTpGMixrn+Bj9ojEMh0VkA841FZ90Kbd3ik32VjBtuWs
 gS9AoH9/urnZ38w/zhR62M7qXYid1EPHrKvBwkSK7cfskZnEjttSOICqjkVODtgX3QkM
 yFNub/rOK8dty3bW8g6Sw1QXWwuwneQ84rDQuy9MnVLMCcowymoEWyRibz5F0GbvwGyz
 ksGxgibyMTwj1oV7PDCz6pSJOQrp+zHXaCaH+Jm0SKUblGoXYsT41p2mz+J9jUSizQ0G
 zvMrjCylud8qcFnRMNd3+hPGwmSsb+Db6lyxxglG+HTzGo1fcXIAe0Yf1twc+xHeDkBK
 VpoA==
X-Gm-Message-State: AOJu0Yy/kGA8BzABWZ/SFMqGbA1ZAGREg/PC4rjvA+I9G38/4v33Mgi/
 5CDXNjBazrh4YdtjDJBCz1APKs+aAUziajwAY1HqZXGFIb7Iu3DZ/+NNxanPO+FOcsUbNaseKii
 x
X-Google-Smtp-Source: AGHT+IHju5XOnoUEOYhXnMrBJVLUIy4u17BDJpufv7ADzH4D1RqV0gz4w2Cs6Ws53fE83wn1OjM7CA==
X-Received: by 2002:a5d:6d8c:0:b0:367:1a39:e323 with SMTP id
 ffacd0b85a97d-367756bb528mr6296189f8f.31.1719912124237; 
 Tue, 02 Jul 2024 02:22:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e13d4sm12852900f8f.56.2024.07.02.02.22.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/67] hw/sd/sdcard: Extract sd_blk_len() helper
Date: Tue,  2 Jul 2024 11:19:55 +0200
Message-ID: <20240702092051.45754-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Extract sd_blk_len() helper, use definitions instead
of magic values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-15-philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d06e670024..18bb2f9fd8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -601,6 +601,14 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
     stl_be_p(response, sd->vhs);
 }
 
+static uint32_t sd_blk_len(SDState *sd)
+{
+    if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+        return 1 << HWBLOCK_SHIFT;
+    }
+    return sd->blk_len;
+}
+
 static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -2074,7 +2082,7 @@ uint8_t sd_read_byte(SDState *sd)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return 0x00;
 
-    io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
+    io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name,
-- 
2.41.0


