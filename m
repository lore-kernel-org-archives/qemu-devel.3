Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DBDC3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXK-0001da-Kl; Mon, 24 Jun 2024 09:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXJ-0001cR-8K
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:09 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXH-0005CD-GL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-362b32fbb3bso2930121f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234905; x=1719839705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AZo3Cd3b6HBjlscPz+JzsDxsvHUlQzRA2cgC5como0=;
 b=L1OZqC937Pj0hY6ez4EYhB7/WxrMeLvrkxZXm9rXtzWMmnpKWFVXmE5Z8FmWS0Hsal
 7QB+E/Cax4imOGqhTVOzT3+e5gkwFpRDQ3gCbsJBPehkD9Tp+kHSa0J6Zzcg5SYX1TMT
 2MMFfMwZ1YCr1U83fGfASOIjc01xWFhkt/c/JyhDZrbCc5vId2TXVMpyxQ7QXmpYTk4K
 cLm0s4fE8j0kRI7WOTtnzyYuItOp+WzqAxuZyPVQfHZbVZNWH1pH70lEBts25H51nkHa
 WpnpoPLKGQptaGHM/EHQXaeuvh6kyaoHpOsiKKvjZUYP2VDfSbOi3gzET4AvZHijnTvY
 aUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234905; x=1719839705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AZo3Cd3b6HBjlscPz+JzsDxsvHUlQzRA2cgC5como0=;
 b=KxAja1OvsjaWuXI8EU6v+tNEn2hPuTZ8YwEgCBHc1bCx7L0s+I1J/v9BErRKRK+paV
 H3+xWbrI98HFR6Ikcn71mp+iHG2itJJTpiSbj+0JtAwIYP1nqgRsIz9ZGpmGpB0vPLQl
 9PG/MvL3g3kJcUO5HxK0kPIeMQ0SaPBV4cK/2E2GqnP6gEbX1N/hj7ZMK6YrLjL4nlM4
 jbevSkCQeOUFLOpL+dSs2AHkom9Z47f3L+QhpU96IlP9KAHISG8tm0VW7yEGffd+gzVn
 kMIxFbWVDjLbkvhrC8vKcK3dhHQP1yJbQcRn7LYESdJbg1mXDeJPI/dh+q5vIIK+iWr5
 a4sw==
X-Gm-Message-State: AOJu0YxBDoAy9fQPQDBB8qQcrtCKWdV3GOAw+G/K9ZwSHPa5lGr4oX2B
 SV/he2Mz0FEPnmBQ4pYCZExAR53pBuovSBv5ixSZjvW1R8Zb3U3UiI0tXrZxM3r+6PWp0hHJc+W
 p
X-Google-Smtp-Source: AGHT+IG4znU+F6hcRsyW5NcF8rYNmjn2yjEHEUiElb3j6oXOd6VQsqV2LVAWQ1sODjUSG+37rMaQrw==
X-Received: by 2002:a05:6000:154d:b0:366:e7b5:3b49 with SMTP id
 ffacd0b85a97d-366e7b540a8mr4645416f8f.54.1719234905753; 
 Mon, 24 Jun 2024 06:15:05 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366387cf44asm9978938f8f.26.2024.06.24.06.15.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/19] hw/sd/sdcard: Rewrite sd_cmd_ALL_SEND_CID using switch
 case (CMD2)
Date: Mon, 24 Jun 2024 15:14:25 +0200
Message-ID: <20240624131440.81111-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Keep this handler style in sync with other handlers by
using a switch() case, which might become handy to
handle other states.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-3-philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba7f165cb5..46388a140a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1044,13 +1044,13 @@ static sd_rsp_type_t sd_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_ready_state) {
+    switch (sd->state) {
+    case sd_ready_state:
+        sd->state = sd_identification_state;
+        return sd_r2_i;
+    default:
         return sd_invalid_state_for_cmd(sd, req);
     }
-
-    sd->state = sd_identification_state;
-
-    return sd_r2_i;
 }
 
 static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
-- 
2.41.0


