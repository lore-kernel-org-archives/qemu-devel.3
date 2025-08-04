Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E452DC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwek-0004OX-Ak; Mon, 04 Aug 2025 10:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivL2-0000zm-5Y
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivL0-0000A2-BR
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-458baf449cbso19579335e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314489; x=1754919289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+eXSqcToyjbRu8c3pGsVVTbIh0f2MkxTWiqZgdInT8=;
 b=EDTGv0n0F3U85c3ay5fIGJvUO8g067VwJYSV/+kIqz+2JMUzFwqr/LOBKeAAolV5ZX
 0Xo47+/VSlsnhcXEFPU34hfy4I37OPJgKLdXEXH5+0chUCPjGTp/hLf9wk/RsPsFF4D1
 WV18/oB9TPUSbGkwoTIGb4halTmEs3v4Z7BC8VWzaRZ/4SyVklgx3e18x9VVkFv1pras
 vR6c/ug62whyfVgfgR+enTdXF1+Z8qprMSLeWastxlvZw+zixSXhyv6+Pl09fQmkcBY4
 JHobm08fQDFF5r8/Dx3lHXgmPkiF7gUqQ/jTvmMS2DSqHSYZLC8KuhOpPX9MBVS0oAWi
 J2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314489; x=1754919289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+eXSqcToyjbRu8c3pGsVVTbIh0f2MkxTWiqZgdInT8=;
 b=LsthKRxmZoo8B7xAOhlxOzwR5K7QbFKAE4SfgWuJ2Usw3UawN73FKY/cphz3Kn1WBv
 Hz32crUjJOOnaX0Kxgqlobyf+oue1IrmDZJRmJNmnZUv7K9vY6AhbBy5TDYf118Z5rJj
 wqIagRNpKk9xnUpHie8rknLPetPoLcV3yA04bRHLl+S43XYdiXIWMq0KowZz/i47WhA+
 fnvMqjkaD+fqOw+ZfUik5shMAuTOfQdk5qPq/x37S5aTTkIAinRCkpHRwE3L7bkVvjOW
 QKk3HgkiOGzKZrNjn9X1CnnFa/sTVMeBOMpU7XedX+hd6JXqrLXQo4ouGgfDLuBZlbfV
 ryhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy0kD0w+0whgP+N9e4UD8V9+fv3f/x7GDJBeGYZoGZ05hagvHBz1kf7iPozrkTowAkMZtahrGFJU7R@nongnu.org
X-Gm-Message-State: AOJu0Yzus/deVSzsvbh3lvxBYj5QYlL2rJaLIWZebvrtBDS58aOefvmz
 zmay75En9ehpZTP7S0VoDuvdyKm36MTS7Jdsb4ergqXt8aSdA3uUJfo3I6hS9oSrJQ0M8jXK2vO
 FFYop
X-Gm-Gg: ASbGncvelzDBrDrmfa6v+aYFzNfPVljL/pbrOvcz1MJroi8ji4xpRQU7lC9Hils3Rf6
 lF/ny6ZoNtrop4w/zK609rW1XuJpvFt7Lkn2wlvdxplbtl1ZGGaoNYtTPqoZqhjWnsL9UiQnoeB
 t5yduI+v1uUIHYNM9/l7FJwRZmIGlrNGZEPqV7rwQrh2Ybsz/aiQIFtAcHtDYK5ctfVTwDboP2Q
 65oUJA83k3JvXoRKL/SkKhDL+dygIBNKGeqgexYZMKZ8mljmSkSOtZSiySdzuYP6FTVZj6QgvUd
 HHhmg/GvOZpgpUBrSOZ5LkS9PdIjcT8n3NbEHrzY56cYU0BQvXF19S+VEIrZxDvR/EUIJTHfQAw
 X2XCyySA7EqAKe+cUgQfGh2j1eOcIXCxClPGi9XE3tNyVps4QBWh8+anLFdvnBMGHUlVJ7bwoiM
 b7AJvWMHI=
X-Google-Smtp-Source: AGHT+IHWhJVh3YosT/BNnjaLA2PiepJGIr8E+/mGbbS+2KCgnbEAkEQTJFYZs0qZFPN45qeiSqCk6A==
X-Received: by 2002:a05:600c:8b37:b0:456:25e7:bed with SMTP id
 5b1f17b1804b1-458b69dec87mr82266395e9.14.1754314488794; 
 Mon, 04 Aug 2025 06:34:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e054036bsm5772143f8f.31.2025.08.04.06.34.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:34:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-10.1 v2 08/11] hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
Date: Mon,  4 Aug 2025 15:34:02 +0200
Message-ID: <20250804133406.17456-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
References: <20250804133406.17456-1-philmd@linaro.org>
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

spi_cmd_SEND_CSD() and spi_cmd_SEND_CID() are very
similar. Factor the common code as spi_cmd_SEND_CxD().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a9efa158594..ee81dc09991 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1588,14 +1588,19 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
                                  sd->ext_csd, sizeof(sd->ext_csd));
 }
 
-/* CMD9 */
-static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
+static sd_rsp_type_t spi_cmd_SEND_CxD(SDState *sd, SDRequest req,
+                                      const void *data, size_t size)
 {
     if (sd->state != sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
-    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                 sd->csd, 16);
+    return sd_cmd_to_sendingdata(sd, req, 0, data, size);
+}
+
+/* CMD9 */
+static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
+{
+    return spi_cmd_SEND_CxD(sd, req, sd->csd, sizeof(sd->csd));
 }
 
 static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
@@ -1610,11 +1615,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 /* CMD10 */
 static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_standby_state) {
-        return sd_invalid_state_for_cmd(sd, req);
-    }
-    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                 sd->cid, 16);
+    return spi_cmd_SEND_CxD(sd, req, sd->cid, sizeof(sd->cid));
 }
 
 static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
-- 
2.49.0


