Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627AECA0EC1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 14:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwed-0003R8-14; Mon, 04 Aug 2025 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKv-0000jY-0K
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKq-00007U-LV
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso13562625e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314479; x=1754919279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Uzbc/9L5Pzkd4K6o0zmm99krPdgkAOBzf5hBdRfajU=;
 b=UbqGDXIcpJluEzFdOg505sxM49p0GdbFz6afW+XE25/GFxW1dAZY+Bni+f8POrZ0dK
 lppaCeJcQRL+Zph2/iNPw+z9k8QvpiLsRw3ZSSuE8oIHaxd80VBh4Pm+/SRnb7yc+RUy
 G7GebPGjiSJYYPvlia8RShDgALPdAv68ffQwNGJHLy7R9WZ/s3hvzWow3gT3Bzm//I40
 5ZxCWruZxOtAViiCMoZV/SkJ/ckR6p8x8CLWyZAl/39g1uSl9VSWXgO4ZWNPR+4Df9gd
 gdM/RA6l+VvYfzdShvoMJ3k48wPAaIFyzDp+AtE1AC2T6YQFQ+woZbNHwwaKaHG7MSZq
 vgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314479; x=1754919279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Uzbc/9L5Pzkd4K6o0zmm99krPdgkAOBzf5hBdRfajU=;
 b=sRsb98VLe3KehfLvjIWwG8oGLBPnafLEsfesDIF++I4kp7bJ4DKa7NBtU7zzPftHT0
 Hm5oCSe4iAuZk50yhV+0pehz4rzku+N51msd0+aSNKMnbHXPtkN6eWo+QJ0uQVCPGW3X
 uT+aLBDxMNP1ehRBwVyOFFNJDLiFPNZFT9UBMWjlds31g1Y1wkSdVW/haQb/xgn1MVQY
 /frRh6zvlTp06L9GyPbHCBajnS/FV0MOZPwPcvh0lSz9kxPkrRbM2Xl28KVoHlDoguj5
 vQMJcloP4bqQYkv8IrsIJerIwqHTGwKJkeUnYIwpRfPRcpzFDSY6WE7bBBuz9aNo/NgA
 4J3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNb2bryjJFniydypzKt6vZLofEC9RtEmhVoagmI4OiMNB59GAveK9mA5wl6kxB9pCXa57VvF8UsRFz@nongnu.org
X-Gm-Message-State: AOJu0YyV44iWH9ceRQMJfI9FtdI26LU3YZiVuQwSk/veE486RlgLepHE
 UKN7AYwX6p8PwYo2OeJCcxQ2JIMGpJBqGGiTC/y+2EGNznihhAbSEyjDZ92KyzaMumc=
X-Gm-Gg: ASbGncsaR5lvLUcGjZaDVe/o0VdsyMgKkB2C9x3FcEyumTx1mfOJyRlSgZR1X5VlnfX
 qLo+zALDB1VR+GyVrqmrwGrjvZ6KBCjrERcd8B83Hc3frQEwLLOElbB0tRSP8Ny8V2ulOSGdEEg
 BH5uP9og+by7C6mTuEi8MWX1mU6k6k1pTlAoGV1M5CqnFo1cXumeJNZV/wGd1xffdoVdxqhC88Z
 tD1ENUDw3OMk9VC8h1s3brhtAHpyzwVXMunxbP/Ej1Dw0TIQsdU/GHQNv0ewzWgg0E2VnGzZVPQ
 oCpUTPELTo5t2izi6WM3K3ju2KcmPIMz9uHqVYKgEQ7ew18Uj6Yc8u7IKjam3KhLTC8E8NVWHh+
 Xro3NQh3MPYW5gtXY4W4vP4PTnbn51QlWmpU60rm/BYXBTO4XqAYiQtoD56t23QzLEvY/ZTsvqF
 +EuZFlD1M=
X-Google-Smtp-Source: AGHT+IHdQV3ZZ7y0hcsW5s0sE6REmong0zZ6FpRzcsHdqr0+Z8yx2mEad8dQ6KedYSuApn3+hceRpw==
X-Received: by 2002:a05:600c:1554:b0:456:1514:5b04 with SMTP id
 5b1f17b1804b1-458b6b316a2mr72524415e9.21.1754314478960; 
 Mon, 04 Aug 2025 06:34:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458f713eb44sm69385015e9.14.2025.08.04.06.34.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:34:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-10.1 v2 06/11] hw/sd/sdcard: Use complete SEND_OP_COND
 implementation in SPI mode
Date: Mon,  4 Aug 2025 15:34:00 +0200
Message-ID: <20250804133406.17456-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
References: <20250804133406.17456-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

While spi_cmd_SEND_OP_COND() is incomplete, sd_cmd_SEND_OP_COND()
is, except it doesn't return the correct value in SPI mode.
Correct and use, removing the need for spi_cmd_SEND_OP_COND().

Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 01ec6d951c8..df2a272c6a2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1414,14 +1414,6 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
 
-/* CMD1 */
-static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
-{
-    sd->state = sd_transfer_state;
-
-    return sd_r1;
-}
-
 /* CMD2 */
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
@@ -2046,6 +2038,9 @@ static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
         sd->state = sd_ready_state;
     }
 
+    if (sd_is_spi(sd)) {
+        return sd_r1;
+    }
     return sd_r3;
 }
 
@@ -2590,7 +2585,7 @@ static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [1]  = {0,  sd_spi, "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
@@ -2626,7 +2621,7 @@ static const SDProto sd_proto_spi = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
-        [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [41] = {8,  sd_spi, "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
         [51] = {8,  sd_spi, "SEND_SCR", sd_acmd_SEND_SCR},
     },
-- 
2.49.0


