Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74401C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXx-0002rX-Rp; Mon, 24 Jun 2024 09:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXw-0002mq-Bc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXu-0005Vf-Jn
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:48 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3620ee2cdf7so2765564f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234943; x=1719839743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJnTXjeu6vchkfoyUhTtN0woxxCm+FO3y7c+ViS30WY=;
 b=iq5bvPnE7yPZW80eNVcyaJ1HBiMh51MaGmzBaLCpCNLEG/momRb4++LBnxHEXpNY83
 qrKfXVzDUzWfxcwBI2cN1SrN1XZK8+kBeFX+Ov8S3T85bYM4LJWUrMJ7gZimX9gQ5AjR
 IWAUZxY77StPAM2qfcGMkNRoOzZUHBMJRowQot8mzPh/5kEWy/wrN2twrhkgp5Hv8LQm
 qHK2z7szBPeKL0/U0RKbmduGOMHe3BYsjJFkgxqd0w7vUUYEWknK5Z7EJNyh8mQ3uK8E
 TY3S6qyZrydBqXXBu4srjDPbqKiUGcpfStUDl+w3E7Nf507cLuWggB7rAEZHTjH6QsaR
 tamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234943; x=1719839743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJnTXjeu6vchkfoyUhTtN0woxxCm+FO3y7c+ViS30WY=;
 b=jAqP0V4DhpC8v7fs5Quzfr1BBsAkwEwiUDoqsLEv2wHPekVGRePIpCg7gVPaWOONY2
 bZy9TaLCRX5aygCiH4vJNlmc8u2EEzc3d5cVNGM3X5sZumt7ES/Nnt4gaLaovZUajq5U
 uYIP0FGzEgoII/j5SFmy/A/T+cPrEUafUU0KIwM8cvruShlFjnD3t6LckA/BTf8KGC6d
 G8+mfaju7ygLogDAFVIVQm0LC48cEnM16dvvVnAYTdWlMiln/5cH5s6KSLQnEPfn8vPF
 tyXX6vtypM9FH5E/AVomWzoiqNlghbLPRRCF9LCP7RKpktBFw1MV58VivXtHZcUyRlLH
 EKJQ==
X-Gm-Message-State: AOJu0YxlA+y/T67liDjss/iCVhpLquaetTyn3irYXXqnVou0nIO0iTiJ
 tRemIis0btRSPqoyf6dz5153Wlgo1p8Yi3BQt6ogPIMDdws9ec64PdHJhzhxTqNme5nuY3UjJb6
 7
X-Google-Smtp-Source: AGHT+IHKiL8/JlR3ZqxBvaXv3FsPYbL/BdthKxrld0PwwrufKdXyBNxKU7ehSKrn/LKc4Sg8JUc7rw==
X-Received: by 2002:a5d:5f48:0:b0:366:e90f:3758 with SMTP id
 ffacd0b85a97d-366e90f38b2mr3986933f8f.10.1719234943421; 
 Mon, 24 Jun 2024 06:15:43 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366ea4c0d9dsm5018823f8f.0.2024.06.24.06.15.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/19] hw/sd/sdcard: Trace update of block count (CMD23)
Date: Mon, 24 Jun 2024 15:14:32 +0200
Message-ID: <20240624131440.81111-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-12-philmd@linaro.org>
---
 hw/sd/sd.c         | 1 +
 hw/sd/trace-events | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4afb6988c7..44225bae9b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1090,6 +1090,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     }
 
     sd->multi_blk_cnt = req.arg;
+    trace_sdcard_set_block_count(sd->multi_blk_cnt);
 
     return sd_r1;
 }
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 94a00557b2..724365efc3 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -43,7 +43,8 @@ sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
 sdcard_reset(void) ""
-sdcard_set_blocklen(uint16_t length) "0x%03x"
+sdcard_set_blocklen(uint16_t length) "block len 0x%03x"
+sdcard_set_block_count(uint32_t cnt) "block cnt 0x%"PRIx32
 sdcard_inserted(bool readonly) "read_only: %u"
 sdcard_ejected(void) ""
 sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
-- 
2.41.0


