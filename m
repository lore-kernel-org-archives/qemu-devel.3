Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5642AC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWb-0000Hr-Ok; Tue, 05 Aug 2025 13:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWT-00005T-0O
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWO-0004xd-Hp
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so4953629f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415136; x=1755019936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBtTATN0gdZYlpHQ3cfsSbHn908qNQ4B08Juh08r/AU=;
 b=cjakfvO8prgArx+/yjaA9uBctNCwmj0Ge62Sq0jDCFLzdLrKtBOx88stmZTL6h7IY1
 zb6vlk0ONBDAY9XbnE9MV+tUaKcD6KHhZ2Z43HI8ow4Er3Hi/DXlAOV8bp/PXam7Knj2
 +k7WH0XXkf6awqSRb58/spFBIgJxFwN4UOxcDy1ImApS9VTsq3ekOcJnifDAJy6LPIfz
 CfUIxg6/oWu3T9Ed4PjnHaymsTsnAzK0HmoQD6iHzGpZ1/F9jqFd/pcpZ8gl/nQXirYa
 6826jEEQFniNXxvT+TSuilJqiGWM0AdcS6FClPB1SFwE/kUlR0bwqUQOnKqj0oYNOkkx
 VCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415136; x=1755019936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBtTATN0gdZYlpHQ3cfsSbHn908qNQ4B08Juh08r/AU=;
 b=HY49fgX6ECTdtffcWrdEQCIHC76c3DJyE8g51K0SDJPa8sfTCaD9loUz58XLxOhin5
 W9OmUJqsDasaglPBHV13rqi5XDHD6L28ZxKkPfzOmK66n8wUnZfteHRosLAoWP+NoeOs
 pC3bo4X5imxqOVaGFFcO6h964WBM4/lnSX6mU+OxN10e1plrTUWOO3qI8n53qpzft4Bk
 LbwAVS+jdhpirntzx5uOiWH7Q3Gz2oMuP4LXr7+2riJfHQpP/ybeJ308O89KfjYOZ1At
 arvoExXC5yEv/qBB00AJ3mHHQCBoCl+oY/bFnNPzdagEO6ZV+ryDthjEb0P6FHsKpDRF
 nOeA==
X-Gm-Message-State: AOJu0Yy0GEHgZuIdf5IFA9a/ALQJAOgCjbLkaBGIQMT0r97KrXkbOXE5
 ByEpe97FDy2kkkHPuIEQSmmt1a9pO83sVOgcR5x48XZnx+Cti2UlENlBa09vr42yN3K/6L6x6Hz
 /wxvd
X-Gm-Gg: ASbGnctbSh0OQvtc0Zj4XMP5XULBxauCb1/FtPR0kLqacwh3pevH8Ptjr7ZeXfXhfz6
 yooCg9eTW/Ci9DJvH/wqvqGHNRBKLPoCfmm3cpYy7t/0koUp1UgEoqyeONxbSyQGPJoNhKIJ9ai
 TRhOp9i8OVHV+LPH336XGJTSnszJTsgJrKhUH2gRW9QuwA00a+bJSt+gLj4/XS3dsuWBRQUbOAN
 DuoRE2DBsA72lvfgLnO2EYXi0JLSWvnixPyycCI2ykn6e7+amzrmeE2J9ESWmazKnyaA2q7Visc
 V4jsCdMuhC24cPUDin3z4rkDxGsVkllcdCy3VFBRgVPF23fLnFjUFfODzs/uCN1JdMD4Ic7z8pN
 KqJ0ig/AG4lRyfwRtzLCNDtNTlm/6K9PJHvBw2rwJVgFLwSI9GjwhrCRdFR3P+gVWZqU+eQdu
X-Google-Smtp-Source: AGHT+IH7rAnukj/YRBPQ0ZLRvOw8yV8thZZZd5DeYKJJ2/Xhi4yEAv7oturfjnY4CAnYd70z0uJlJg==
X-Received: by 2002:a05:6000:1ac8:b0:3a5:8934:4940 with SMTP id
 ffacd0b85a97d-3b8d94c58f0mr9573337f8f.50.1754415136504; 
 Tue, 05 Aug 2025 10:32:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b95f4sm19849075f8f.23.2025.08.05.10.32.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 08/13] hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
Date: Tue,  5 Aug 2025 19:31:29 +0200
Message-ID: <20250805173135.38045-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

spi_cmd_SEND_CSD() and spi_cmd_SEND_CID() are very
similar. Factor the common code as spi_cmd_SEND_CxD().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-9-philmd@linaro.org>
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


