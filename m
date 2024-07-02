Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446AC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZjs-00013j-C2; Tue, 02 Jul 2024 05:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjq-0000vL-G3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:50 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjo-0007xT-Hq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:50 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52e743307a2so4454871e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912225; x=1720517025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upGfqqV5De+YauigIoBYXsU7px/Lanfz6QB2Qs40bCc=;
 b=FD8wuC3PgyqwYOpMrO7zBmWMq7Qj5E5N7+CPiKGpTve5v81oy5Uuk7JdudYW7q8AkA
 wxrtEBCVIUu246+Ab4tkvG7Si+UnN+1apL8BUkdMGUx2wTA+hLqTEkuqyIb8OiYuQQa/
 apq0dWwJ4v6UsILtmRQ4l65/eRA+yIF2nXTw5XkXFAEsxOWbEHE7X8rAvWmb4vdkiteU
 KnYOFQhH8MrFGMT/pxHRGFRRI4hbfoPhdvG+N2w39VHv3PPt/Ww7zZUXpyUShTqCaeQL
 3rg21QkwnyPh39LER7ZsrUOtgxvDpLD4TQxIhbT+AUf7icnD+a1+sfwrOiN5eBaDF2jb
 evdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912225; x=1720517025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upGfqqV5De+YauigIoBYXsU7px/Lanfz6QB2Qs40bCc=;
 b=xAqos0YVF5sxmLX8h/l8Ng+A0bAn5iTlviptE0bDXZkcg59eadsgVluQheLQHHONtj
 sKYB5YulfK3VgDDCDezgTXjZBnCQtXP+sdoeN/5nfzr6a3yX7m1/4m99a8P6MkaXGO1b
 K7VtPBi3CW10mRZzVNe2quf1a0Kbjkcgg/qePgD8QFvaafHtRilKDkN3+xa7BkrS7kJA
 gwKeBjfUl/JqiPKjPGAQYRuJ0XqmeKDITwRydzlbDBeip0PSUOa75v0QWGuxkTsu11WG
 lW8+weKYtLscjhsN9yR33eNAu8arBfaawT/OC+6moAX6XAFwEdzEelf50K4HYTAZ//2C
 VKfg==
X-Gm-Message-State: AOJu0YwxeRQ3KUMyg22WQyRy1rrwfH9N4bu0O451YPb8iTCRDOcvLCEx
 +YjsGsomaJ4Gbo6RVPKVXF18WYahbOpm7RIJ2L4r5hA4P0YiS3GLlLg6lHX+hr+uMbc2Z71F026
 q
X-Google-Smtp-Source: AGHT+IGJTCqErRVdtePtktRkF/z1HNfAwDNpU7zFEBKsByjsrE11xpFOPOJZUC1lGjRuqJ2QtJgYpQ==
X-Received: by 2002:a05:6512:3d86:b0:52c:e086:7953 with SMTP id
 2adb3069b0e04-52e8264df6amr6388329e87.4.1719912225359; 
 Tue, 02 Jul 2024 02:23:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257fc934b2sm93124925e9.44.2024.07.02.02.23.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/67] hw/sd/sdcard: Convert LOCK_UNLOCK to generic_write_byte
 (CMD42)
Date: Tue,  2 Jul 2024 11:20:12 +0200
Message-ID: <20240702092051.45754-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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
Message-Id: <20240628070216.92609-35-philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 95ba4d0755..822debb28b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1620,17 +1620,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Lock card commands (Class 7) */
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, 0);
 
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
@@ -2099,8 +2089,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
-- 
2.41.0


