Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95C7C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZl8-0004Uj-2k; Tue, 02 Jul 2024 05:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkj-0004E2-5d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkZ-0000Aw-9g
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-364ff42999eso1746035f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912273; x=1720517073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ph442tiXvXeNCMFB68Xw+ODOVr0L1MOlNemy3MQKQw4=;
 b=FbVONF0AfTAufll9euSrMmC7dwo9kOVFtmdOrqVc3UeCs51oAL3AwgQK9F1P/tj+20
 COKRBTBdZ0vZj6X8KJcNgt4TH//5C9G/b4lexbvFOFDA7z4HJRRF/mQettB0MUBuzITq
 VqSmiCo+z6+w0fThGc6AMC9hgNauPFRflrhCupzA2h5Ofr907CJScIM42m9aJtKK1SoZ
 EKnFZ2rUNY8fEHQJNeBz/EmkjK1Sk3vFYsNX0ukON31U2CYfsyxA8gsmbhO6BSmBcfqr
 hQuhsIo5TGMPgLQ/mwS3EDfX2srKmdH2gP0qKv6sEvqBL3wY2d6N53zw+uJPCbZs+ytN
 BxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912273; x=1720517073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ph442tiXvXeNCMFB68Xw+ODOVr0L1MOlNemy3MQKQw4=;
 b=fWJmGz0VnlLr/AVP+fwQXQYvAeTy6FeIQ1YkhE1vL+uph/mNIHh3KDQCLDWAMHUB3Y
 A5E6SqlYyDTtphQ4aeaASMiNo3G93ctXUMiFQ0ve4//2mHav3r0iH8V9hy3OwWZ5RslV
 Zsk3cPKzvjfWGiPif0k6C7+PySw2Ut78D2KJjwqulH56TT4gzkV0qgg91LYYC0F+N06H
 jA/YjoPX2+fqKqWLd4X8U+PtA8gQjMgn53TnCN8/7EC1I9P9OP7hmysOnV7VLa0IRSzK
 RfBhR/PvlbVxUmUn5LuMuG02NaWo71FGe0GzkfLhGJgK5LMyP3JREwZpNtd+jbvv0Bnr
 QpaQ==
X-Gm-Message-State: AOJu0Yy31ESWTQpJotpn9v5zcOPMcQIz1+/eVnmdZq7GoVLUPghZXX9g
 Fg9tXqy+BX1DDHcZ2vHiegXJtYsQ6bBqlYnM0QlQ2HsPNevZ/UJrDzsFpecFakhUgnx+Lm95fnJ
 b
X-Google-Smtp-Source: AGHT+IFFsVYnvpaOnuaG6ynniSLtIhuX//JyQ536N1m8Fv39CzYA9z3/eK6Z6MaEkuDVSvjbcXaUwQ==
X-Received: by 2002:adf:ce0a:0:b0:364:29ce:b14e with SMTP id
 ffacd0b85a97d-367757307aemr7145020f8f.69.1719912273339; 
 Tue, 02 Jul 2024 02:24:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b068e54sm192840175e9.25.2024.07.02.02.24.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 37/67] hw/sd/sdcard: Register generic optional handlers (CMD11
 and CMD20)
Date: Tue,  2 Jul 2024 11:20:20 +0200
Message-ID: <20240702092051.45754-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-44-philmd@linaro.org>
---
 hw/sd/sd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c25e376b35..b4fd863189 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,12 +240,12 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                              [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
-        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
+        [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
-        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
+                                            [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
@@ -1156,6 +1156,14 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: Optional CMD%i not implemented\n",
+                  sd->proto->name, req.cmd);
+
+    return sd_illegal;
+}
+
 /* Configure fields for following sd_generic_write_byte() calls */
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
@@ -2281,7 +2289,9 @@ static const SDProto sd_proto_sd = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
+        [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
 };
-- 
2.41.0


