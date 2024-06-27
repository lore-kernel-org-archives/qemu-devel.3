Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6C0C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrwT-0004EN-9Z; Thu, 27 Jun 2024 12:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrwO-0003iz-5W
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrwJ-0002d1-KG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-363826fbcdeso5900204f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505535; x=1720110335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSF5Ro3NaUsJXtCUAFWLr+3NgzU6nFSUILhMkj2n5D4=;
 b=VRTLmw2Kl7Psz2fJJmQvLVcfBWkyXFy7RNqZ2CiL1cd/wxLbsNePqyzT3SatEzCGLq
 ZOdhDuNshAIun+hWnUpgFP1XrOxY7+BlE7WBpPu7NqwXAuAZW3ls73bh0plkc1xQu35n
 RnDUSnc452/zeszBtOLdrqe4K8EpfwhRWBRZVFwukNPIwcUYGpwO84lTYkAAIzTLNq6k
 +k9pPHJePki5DmfklbxS9uJpxuGwsZbpnXxtECvNJORbmS0jbxafDPrvNrQlGeko/rhL
 5CPq7Vn8QNAjmR9x9MjI0HzNCSKjlHadeVY4jnrSTgYznvCIuf3dc7EJNVOFL7RnS/lO
 whrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505535; x=1720110335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSF5Ro3NaUsJXtCUAFWLr+3NgzU6nFSUILhMkj2n5D4=;
 b=vAHgYyhiIA1sxjYXsZvLim9iPEJkv7hpkqHBjyYFgQSZ/tkTCfVAJ+s5oOMQvvltxX
 GzZPI1iaxPsmEXlleVlZ4nhlGM8SiE4I/vQ3fpNwey5QwJj7pKUJFpnTE1EhAUMOyMJ1
 qmU2wCIYHQWN5CG7s20cCwjvuXXALyrVAuMK2LqGzHkuoYW6ZxUSYiHn/E41v62qvXt4
 iIfc1xsPdmcG8MXnsrLqP7WPs0wad9k+oNYIeYehKC1+x7OaDglcNScxq6jaxpaEFXdi
 DcaHSMVZght1PD//pzQT3O41/PWcRzhrwxUct5qe2cAiAX+enrplEG+xW1tWrOmAh6uo
 UrAg==
X-Gm-Message-State: AOJu0Yz3wsdEuQFTmBFKWEQg6/N4w+g6nR0VePuLR3LdEnzl7gRT03/0
 HNWQ6LqMg5nTNOfPxQJN8T2ZPk8L1q72ofDxEgJf+RJU70QxbjZNi47UNYLyOPjPoTbIY0oLUIh
 5/Ns=
X-Google-Smtp-Source: AGHT+IESxH3LVe7TrKN7BENR7voaifbARLmTsdyOhFIvFpdn6nBlZfs6cwdj42L17vK8YD2SncAjkQ==
X-Received: by 2002:a05:6000:2c5:b0:366:e89c:342b with SMTP id
 ffacd0b85a97d-366e89c34bcmr13353327f8f.52.1719505535283; 
 Thu, 27 Jun 2024 09:25:35 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369ebaesm2348335f8f.91.2024.06.27.09.25.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:25:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 14/17] hw/sd/sdcard: Extract sd_blk_len() helper
Date: Thu, 27 Jun 2024 18:22:29 +0200
Message-ID: <20240627162232.80428-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Extract sd_blk_len() helper, use definitions instead
of magic values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaa50ab2c5..5997e13107 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -603,6 +603,14 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
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
@@ -2076,7 +2084,7 @@ uint8_t sd_read_byte(SDState *sd)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return 0x00;
 
-    io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
+    io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name,
-- 
2.41.0


