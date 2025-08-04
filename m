Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4D9C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 14:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiweb-0003Iz-Ma; Mon, 04 Aug 2025 10:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKp-0000ai-9B
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKl-000060-R3
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so5973665e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314474; x=1754919274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FuF7hehb7w0/1XQAyoYKQHd5iUS7qur1XCWnAxr71Q=;
 b=cykoYVwlvGTANHkWz9TDQbUNBTUlmefFUkDIcV1HaLw/nzWeIzNaVrEM4n1Dp9OIHf
 CEVCV8QnJZJTlFSmaBvJ0sW6TK1LKvlBGWi0bhAimMLaZb8MeubVY2p9fKUMvw31iZ15
 m26BUPF6snt0huX8plVLnHyBe0pz9NS/nAqPvWWSDt0QYllI6Rnq3RrIeKsWaWbvjcrR
 Wlq10hlCdbH1615wFztSQEc3NhZX3CoAav6NoAgS/gOUarhzdjY3+DdyhIh28mtdBXX2
 95BWZomc16yMWkcaJ8p3KPINfkUbpdlvdj+TXKsivD3ssM0m8HtlqP0gdvjZjEWp/LcK
 UVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314474; x=1754919274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FuF7hehb7w0/1XQAyoYKQHd5iUS7qur1XCWnAxr71Q=;
 b=OHoXPSjDLHDyqL4oZSthu+s4pDAwOEZ4t+i3ZlOeW2RHXVczzY5piOfLlLevtZgg6y
 GeueqzF5axpB8AN7A6wee//DJSOOXRFcR3JEWIiAcniZdmFrsDhAkt9W1M62g2MKfSA3
 UBfMtmvWoUHvQLBkW9jdEYG0Huh7frVNpCj7HAUFX0gUCI47wbNNtLaMXRITlIIZQzpl
 tnbA+rZ9eho+TJrOdP3HQfDvHAT1/4HDlBxkBhOYeppD1aVES/2nHjfDv8dGuPUgzH88
 s4t0o1l8wc2fS3Ho5nIMYzt4v/cTt8VC7K9E22sXPPcbtCs2S7PfJCfREahHy8+1GF0h
 v7og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcrayXY4/cT2oGO9YaOpFCOoR9Q2Me3uuoOznW0hUPqjrKXLk5+6EJaKIyfNTPSm31U6bYKEqwJqQg@nongnu.org
X-Gm-Message-State: AOJu0Ywe+tEoWXMHdfqCztsLYvsus1EnO5k8pyAgyh8hbyZraAryEW6c
 hqByRHBb1LS4xRcnCbYhMAzha4AFqf8zTL2WxFUHPKktGiMXj27XrPMnbcCVdUPKFBogoynHO7/
 cpJ4n
X-Gm-Gg: ASbGncsVZ11KfuDhs3x7MHKXnmkHtafAnjj5Up/DJxLOIwoQ6GY7ZD7/ingWDpunyws
 Ra4/+ow8rfC/ju5BqyRxY2zU7ssT73HoZ94MdbBCq0I1bkHCN3X7aaG3dmiTDRkB9TsYFgDffP9
 9TgS6zw5uK9a4zsSTt3CRWwfNgzng3q115Un3CftW5HZjVt6JlhvkA/hnaBDExAOkN8qbQVSRGW
 pUq3WyJbACFm070gkjxB3D3XuMbUSEAWjUN3cUU8wNukpYG5d/qRK5ocyQBWn43uCVb40+p0Py7
 eDuhX6gfXI3N2VjePmUT7g0l1tOPnwhsoC+wA1+xKQY4t8e3e1jkRUjppKpSnJ5OYtK4f73RJNV
 1nQnZsjBY1JUTv4RiO9VF42J0ro1o58zNtNUzTJ4r0HoDP7lyEl6oN0Ua647qTjuWzF1zX1jq
X-Google-Smtp-Source: AGHT+IFYOu7nkG9F0StsOdErlwB5/2xT9FL21rdulKc4Wh711KsDc2fRPP3zVgs9vlBrMxgKqMoHYg==
X-Received: by 2002:a05:600c:1e8c:b0:456:11cc:360d with SMTP id
 5b1f17b1804b1-458b69de114mr73189625e9.9.1754314474211; 
 Mon, 04 Aug 2025 06:34:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c338c7dsm15702306f8f.0.2025.08.04.06.34.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:34:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-10.1 v2 05/11] hw/sd/sdcard: Implement SPI R2 return value
Date: Mon,  4 Aug 2025 15:33:59 +0200
Message-ID: <20250804133406.17456-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
References: <20250804133406.17456-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In SPI mode, R2 is a 2-byte value.
Implement in spi_response_r2_make() and
return SPI R2 in the SEND_STATUS commands.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c     | 38 +++++++++++++++++++++++++++++++++++---
 hw/sd/ssi-sd.c |  3 ---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cbcc180f6a4..01ec6d951c8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -61,6 +61,7 @@
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
+    spi_r2,       /* STATUS */
     sd_r2_i,      /* CID register */
     sd_r2_s,      /* CSD register */
     sd_r3,        /* OCR register */
@@ -247,6 +248,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     static const char *response_name[] = {
         [sd_r0]     = "RESP#0 (no response)",
         [sd_r1]     = "RESP#1 (normal cmd)",
+        [spi_r2]    = "RESP#2 (STATUS reg)",
         [sd_r2_i]   = "RESP#2 (CID reg)",
         [sd_r2_s]   = "RESP#2 (CSD reg)",
         [sd_r3]     = "RESP#3 (OCR reg)",
@@ -736,6 +738,10 @@ static size_t sd_response_size(SDState *sd, sd_rsp_type_t rtype)
     case sd_r1b:
         return sd_is_spi(sd) ? 1 : 4;
 
+    case spi_r2:
+        assert(sd_is_spi(sd));
+        return 2;
+
     case sd_r2_i:
     case sd_r2_s:
         assert(!sd_is_spi(sd));
@@ -778,6 +784,22 @@ static void sd_response_r1_make(SDState *sd, uint8_t *response)
     sd->card_status &= ~CARD_STATUS_C;
 }
 
+static void spi_response_r2_make(SDState *sd, uint8_t *resp)
+{
+    /* Prepend R1 */
+    sd_response_r1_make(sd, resp);
+
+    resp[1]  = FIELD_EX32(sd->card_status, CSR, CARD_IS_LOCKED) << 0;
+    resp[1] |= (FIELD_EX32(sd->card_status, CSR, LOCK_UNLOCK_FAILED)
+                || FIELD_EX32(sd->card_status, CSR, WP_ERASE_SKIP)) << 1;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, ERROR) << 2;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, CC_ERROR) << 3;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, CARD_ECC_FAILED) << 4;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, WP_VIOLATION) << 5;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, ERASE_PARAM) << 6;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, OUT_OF_RANGE) << 7;
+}
+
 static void sd_response_r3_make(SDState *sd, uint8_t *response)
 {
     if (sd_is_spi(sd)) {
@@ -1643,7 +1665,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
     }
 
     if (sd_is_spi(sd)) {
-        return sd_r2_s;
+        return spi_r2;
     }
 
     return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
@@ -1957,8 +1979,14 @@ static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
 /* ACMD13 */
 static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
 {
-    return sd_cmd_to_sendingdata(sd, req, 0,
-                                 sd->sd_status, sizeof(sd->sd_status));
+    sd_rsp_type_t rsp;
+
+    rsp = sd_cmd_to_sendingdata(sd, req, 0,
+                                sd->sd_status, sizeof(sd->sd_status));
+    if (sd_is_spi(sd) && rsp != sd_illegal) {
+        return spi_r2;
+    }
+    return rsp;
 }
 
 /* ACMD22 */
@@ -2264,6 +2292,10 @@ send_response:
         sd_response_r1_make(sd, response);
         break;
 
+    case spi_r2:
+        spi_response_r2_make(sd, response);
+        break;
+
     case sd_r2_i:
         memcpy(response, sd->cid, sizeof(sd->cid));
         break;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 2d5c0ad5016..594dead19ee 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -158,9 +158,6 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
                                          longresp, sizeof(longresp));
             DPRINTF("CMD%d arg 0x%08x = %d\n", s->cmd, request.arg, s->arglen);
             assert(s->arglen > 0);
-                /* CMD13 returns a 2-byte statuse work. Other commands
-                   only return the first byte.  */
-                s->arglen = (s->cmd == 13) ? 2 : 1;
             memcpy(s->response, longresp, s->arglen);
 
             /* handle R1b (busy signal) */
-- 
2.49.0


