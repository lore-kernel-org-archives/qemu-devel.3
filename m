Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190DFC41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3l-0004Gu-DP; Fri, 05 Jul 2024 18:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3j-00043P-SH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3h-0007i0-7H
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-424aa70fbc4so14096655e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217135; x=1720821935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNqSp0iQz07nPZVO9KsMulPxDcXpDCHlv5P9X5kScC8=;
 b=LMGRJu07vEfw/T+m9ERuNxP+r8pt+K2goOSkIRveK/xQDXghdk8SlggA9CwN8DTsWo
 OiY90nmin3vLlJxKzG85yoOZiHMRM4OhnSb//2msMK+7mB3gJXMl9upbaRMIhQVK9+Xo
 de6XK9s1peGj12nERPo1Swj3prd75zPketbFk03IAVuIEKcdlkPKV5v2b5CIobR3N/XI
 79XsbTL2PsPS/69ypQm+vYIYTsj8dzBkeXnCxi72PWcdADhRjNzIovOBotv/NRwo61QS
 QJjhQk0hkh0uygsF1jFHHUJUMXrSXXGkAcSccavA2r4Xht5nNPLg4GinZjkZKlmELT7+
 oKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217135; x=1720821935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNqSp0iQz07nPZVO9KsMulPxDcXpDCHlv5P9X5kScC8=;
 b=IvNT9y82ZWmaxERZ/CJ8lYZXPCofwG9ZdmYXsbcx2H+6XsNOxKF7AcAyk3u5ihbJM2
 NTnbi4qoMi1BKI9kg+5OFjZECgBnlYQ9Sbk2Mi+BB6XjIwOm0QUGLBgMsoKwKJ+5Z2P6
 YfzhEJjXIbfywwhdLX43FLPuoErpZPHEEK9ONSAX/EwQoU7EZuOfwtLEj7nHAdLl1JZS
 JaFV4QWIMd1p0LN0t4/h6YzKO20YZkT/7m7teSEXTUH22uREi1V6MBWjEMwb2mR72/s6
 arauOd1qZEI/rHZb5LqP/WqlrHH5Y+qTqUXs5Mt/9idXFKJoH8ZAHb8D4u5vhM2beijA
 dhOA==
X-Gm-Message-State: AOJu0Yw92fLPBqER3bOUpHyaal3d9IrPxqJiQgXyyeIqvEPbSvBDvztV
 dzJ5JVdsp0IbqLcp2r1KeS5pPIZQvOGy/6aN+JwJMTmFDG52AkjBkrOOBIkmjY69Ro6x1zNXc91
 8
X-Google-Smtp-Source: AGHT+IEZoXmgZKnlRhyVlvZnjDcP8JDG04HWIUeJ+1OFfW7Q3T4GbC5Te6lhKkeko8apvwO2qWevCg==
X-Received: by 2002:a05:600c:470e:b0:425:7c5f:1bac with SMTP id
 5b1f17b1804b1-4264a3e7a16mr44928575e9.21.1720217135298; 
 Fri, 05 Jul 2024 15:05:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc882sm76511795e9.41.2024.07.05.15.05.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 11/16] hw/sd/sdcard: Remove noise from sd_cmd_name()
Date: Sat,  6 Jul 2024 00:04:29 +0200
Message-ID: <20240705220435.15415-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

These CMD names weren't really useful, "UNKNOWN_CMD" is simpler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-78-philmd@linaro.org>
---
 hw/sd/sd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 274a917ba6..bc1a574b62 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -239,12 +239,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
         [18]    = "READ_MULTIPLE_BLOCK",
-                                            [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
-        [26]    = "MANUF_RSVD",
-        [40]    = "DPS_spec",
-        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
-        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
     const SDProto *sdp = sd->proto;
 
-- 
2.41.0


