Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78A0C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhu-000185-4J; Tue, 02 Jul 2024 05:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhq-00017Y-Ur
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhk-0006QR-1A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so28144995e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912089; x=1720516889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmproyIzBvgthgzgc+ED5AQDlzk9eDrpZD0ggY0YeFY=;
 b=FY0qDnMcAh/sB3kwJNrEV+Rvx34EV8btGzMGUWyfDjOyGWOfPWju8ZR9OfkKNZp2En
 Fdd8L1ZU+ypsw5hioN7wT2pAEq6b9xRtAvte9yKm55fBgFGozCDU/AERYFaqLhQ0vL4P
 kG5KR4uXgHfkaa0sxveqs9hm4OUw3iau5SRRDTbImxLfdsO7eE37I19e5MK2DAoLSM4y
 85S9t/0xzAm2Ctz5lC8Lo1n83lc0jdQVf39GS8j2d5lMQ1dnnjgiBIdjhUj8t/heQ34h
 fDVYe7HBVWcL5lecr4tV07mu/CteGTtQJ6hmmeXYuZKKvfSZ/pjPhUoWArWxUBIwx2fz
 dnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912089; x=1720516889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmproyIzBvgthgzgc+ED5AQDlzk9eDrpZD0ggY0YeFY=;
 b=f2RCZhp9+uIbWjVcXDHEnf7nkPGVz3wt26hNI9AqU9Y5v4VnvE0S8GwmKTYjGDRnFo
 XOP0O+9I2D4zn9Aweb2EPOVeJVPv8NOYCcypV6kBjQI68ujAoqHfO2b0r5P61e6ixINH
 0iAkl5dnd5B/PESkqbQcNIyVR12ZdSksHItN1JUlu15tu5rNg6iyqF3stjqXucZKve2B
 vEqKBkl4erNBFs8IlAOAAEfYFZWy8cuwpbsjM5o3CEtQ5IkqLj6CslmyXOMCP1cE93cu
 jhWZxpOrf5gsZqSBJNze24WruGUPxSDSQ4+XBC13orHpQnwj2hoSv0X9L5u3z5+A2r+l
 qsjw==
X-Gm-Message-State: AOJu0YwNGGg3+z6bp06Ukx+XqJ3BFxS0vInrA6YCQDqfRUtU0T74NtxJ
 9AMMaHDJCny1c4BwRegN7IUZdp0YwrEyZWbB4vsuJYgcoq24kX7ZHJXKlALC6m+YAlDuRCQAIC6
 E
X-Google-Smtp-Source: AGHT+IHFNxXTD0/30qhzbq21YUuPH9Yct0X7Umm3cpEfcUCir90HhmG7zaAd9h6xfOrKzLzotcp+fw==
X-Received: by 2002:a05:600c:491d:b0:425:6d66:e432 with SMTP id
 5b1f17b1804b1-4257a03a6c8mr54270855e9.22.1719912089186; 
 Tue, 02 Jul 2024 02:21:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm188276115e9.15.2024.07.02.02.21.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/67] hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
Date: Tue,  2 Jul 2024 11:19:49 +0200
Message-ID: <20240702092051.45754-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Per sections 3.6.1 (SD Bus Protocol) and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Fixes: a1bb27b1e9 ("Initial SD card emulation")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240628070216.92609-8-philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b5d002e6d7..1e9530f9ae 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1508,7 +1508,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_sendingdata_state;
-            *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
+            stl_be_p(sd->data, sd_wpbits(sd, req.arg));
             sd->data_start = addr;
             sd->data_offset = 0;
             return sd_r1;
-- 
2.41.0


