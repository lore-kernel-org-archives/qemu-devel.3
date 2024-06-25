Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0EEC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOg-00018U-9B; Tue, 25 Jun 2024 02:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOT-0000zZ-Uq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:06 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOS-0005f3-8w
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:05 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ec5779b423so29115491fa.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295862; x=1719900662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtW0nRzwV3BVpB0w4GeNN0Pmc1dXKuFE2etuFwf0o1Q=;
 b=CSWhSlSMPiOUzQhaBuD0LpM57tybOCsODpjtihXJMBH31yH8u7cO7wVpH1bm4QKupQ
 PPciyayqcI5moLlA4iCBgLWBxjK1uja3AtAwqYN/GtWO5R9WIb0gu+HpMWyzao3lIauc
 zPdRlf+ZdiKQBDbdh50vOkbro6nNHmOo77Cm9hx8BqJTlWDLY8v/xJXwYNcY1qYpX5A5
 XzphS2YovXbIXw+4liXfxhyT1YYu9LeuVTzYA2RvYBSM38VhBaLnPvYzedyKtlo45riu
 Xg2rfGUvFI0AVWV2RyYKC5OvzifPbyk9oj955Q+e7ktdhoI2Rr1zu9olLqLCVv6udG/g
 g7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295862; x=1719900662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtW0nRzwV3BVpB0w4GeNN0Pmc1dXKuFE2etuFwf0o1Q=;
 b=uHafSCHZgcAJw3jRTs4fZg6sak1C1bImmi9lXncZOv3DR2mO4CCdcwQvEvMlQEbBjO
 0VfOQ1IfsurNezKlYf5g4+4bPD7i2amSIgUQT2NknxQXfndnc0ROJCAHA5zHfnKZTgC2
 LdgACNMm0+KwdskHF9e/Ekt0l5fVepKaOr6qOr4FS/VPSw2M0jLGKG0FVJ8QCqSDmMTP
 GL1z+vbSkpzZ0XCzqQTGe2tx7T/xNxqkJ24GXj3n2rjomtaruNo31tP/rjy146Ic51M/
 3InMqm6M+o7QwAPjmFPJcaoQ2yc9wapXC5BHwYUW9ZJS17hsgTaX+ypupekjLOOI9Hgw
 EBXA==
X-Gm-Message-State: AOJu0YxigvUmiACeVGjehPyejUl/cM9tbXzL7uPr6xojg3vrjTX/F3/h
 Rn6EyErmcDTV2jrU5PNGTYV8REwNMwZ8u3/tkURl58hChCDlAW5slzT2aVs0zjUMU2rsiqOZ9Ic
 f
X-Google-Smtp-Source: AGHT+IE13dt16RgJSOjSHZUtCUWr67mxVmyBUQzwnkBbE177Gymonefsm5eS+2PbXkgojDHnTuR9IQ==
X-Received: by 2002:a2e:91c7:0:b0:2ec:27e6:39ba with SMTP id
 38308e7fff4ca-2ec5938a759mr51691381fa.53.1719295862238; 
 Mon, 24 Jun 2024 23:11:02 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910f91sm157628785e9.38.2024.06.24.23.11.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:11:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/11] hw/sd/sdcard: Convert SEND_WRITE_PROT to
 generic_read_byte (CMD30)
Date: Tue, 25 Jun 2024 08:10:11 +0200
Message-ID: <20240625061015.24095-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3d341495e9..6e6b37bd2d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1180,6 +1180,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
     uint64_t addr;
+    uint32_t data;
 
     sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1533,12 +1534,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                                   req.arg, sd->blk_len)) {
                 return sd_r1;
             }
-
-            sd->state = sd_sendingdata_state;
-            stl_be_p(sd->data, sd_wpbits(sd, req.arg));
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            data = sd_wpbits(sd, req.arg);
+            return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
 
         default:
             break;
@@ -2117,6 +2114,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 10: /* CMD10:  SEND_CID */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
+    case 30: /* CMD30:  SEND_WRITE_PROT */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2158,13 +2156,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 30:  /* CMD30:  SEND_WRITE_PROT */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 4)
-            sd->state = sd_transfer_state;
-        break;
-
     case 51:  /* ACMD51: SEND_SCR */
         ret = sd->scr[sd->data_offset ++];
 
-- 
2.41.0


