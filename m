Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB4EC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZjH-0006FA-0M; Tue, 02 Jul 2024 05:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjE-00063a-Fa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjC-0006ts-Nw
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-366e70d0330so2485569f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912189; x=1720516989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJKBBwll7Vgxqrd4++eiEl6JZS58Z0q7hVOL9pUOlIU=;
 b=bds0P/DxaoBOQXoYi44gPC/luvruztHy4rjmSkX2QDtLtOFuc/Pxyopzh6Iz4oKk5g
 TUxlYahlfWb2vHCmiwnlpm3ONY3NDhj/1SVHfdevVJ9ah5Yk4fCXl3FtIOBogGgbpbIh
 xVJVIzD8+GG53ZwI5LIkAV+oLKkZ1nE9OPQuFwGT7/1wHbGQf3T1q+oEcpeuEUUKuSyz
 xAg6MAiTaNBMfutadkPXvb/jrzhP1eO0uNREJoe80It89PVFXVsiHljsavAdCdxsx42W
 D+Bp4X4MIMdHzjQk7eBPY9q1ESB55AK0B7rSyJy7qTFLcbrp6saQWnlXcqMxbKcz8ico
 oEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912189; x=1720516989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJKBBwll7Vgxqrd4++eiEl6JZS58Z0q7hVOL9pUOlIU=;
 b=FxFDvwJ04fV4KOpk01+FhmpvkEbZ1teF5IcN5tZwIM487h/AI79PVWFn8zPBALtKjI
 p9K/mEGuBI9T7galS+vdeJJBO8op1SKBa7AiDmaMSePRTz+yTrEUqsJLSfY+MNmoFY26
 IiDKPg3XPWNHnZhFJ+O6Wp1iQcNCY7Oehi4U1b8EDMuQi3SqFxong5sjMP1mwa5ZW40r
 FAxMP/WlbFA9vkB27NgJs2pwG7tHrbviukHPZgnKEyF2oo3I2x2j73wE143rw4an57jo
 zHYnz9z0/du6cr+XnuZWZ/csLypfkP+y1vbkWseAldE6B5vAWiG+KDSKOjxB4l4bKfbh
 Hymg==
X-Gm-Message-State: AOJu0YxevGlqqiIWLFWPxqdZY8ma+cJ8A7SIYvfSHD4kyTt3DsFkuyAQ
 tj+xVpE0hx+iymDKHcorRprVA2LySsZpGTPOPltOrzxf17aaujr1q6AIcz98pAydXYjucKoEyFF
 N
X-Google-Smtp-Source: AGHT+IHwaICijgWASGtbxb7Ux7atkjYKB85vS9D5tOE4KGyMpGHshO9hnpBsnnQeB+w9YcLzYt8pZQ==
X-Received: by 2002:adf:f406:0:b0:365:b695:ef76 with SMTP id
 ffacd0b85a97d-367756c71eemr5364221f8f.36.1719912188782; 
 Tue, 02 Jul 2024 02:23:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb9c1sm12717294f8f.74.2024.07.02.02.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/67] hw/sd/sdcard: Convert SEND_SCR to generic_read_byte
 (ACMD51)
Date: Tue,  2 Jul 2024 11:20:06 +0200
Message-ID: <20240702092051.45754-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-29-philmd@linaro.org>
---
 hw/sd/sd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5d5e55243e..78aabb65ac 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1775,10 +1775,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 51:  /* ACMD51: SEND_SCR */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
 
         default:
             break;
@@ -2129,6 +2126,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
+    case 51: /* ACMD51: SEND_SCR */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2156,13 +2154,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 51:  /* ACMD51: SEND_SCR */
-        ret = sd->scr[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->scr))
-            sd->state = sd_transfer_state;
-        break;
-
     case 56:  /* CMD56:  GEN_CMD */
         if (sd->data_offset == 0)
             APP_READ_BLOCK(sd->data_start, sd->blk_len);
-- 
2.41.0


