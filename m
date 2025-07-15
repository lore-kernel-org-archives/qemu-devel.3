Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7D8C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ2f-0003se-Vc; Tue, 15 Jul 2025 02:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1f-00030G-Jo
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1c-0007Oi-PM
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:27 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso4863449f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560421; x=1753165221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2Itf1u4dIdOzwp9PA5MQ9GY2YE6K+iup4a5uTVYETw=;
 b=DESMPE1NoPiIAkiRb8uUGf8zEpmob2I/JFldsicPrrfejMknCxzdyjmSMjyRDyANWx
 clwJvWHFJ2wnons+s0lM637WZOQnGgW1hPslok/gyLyqTLcVdvfvmhWqZc9yrhyc/c2T
 Y7Vgy+YkIp9hILlTMnU2siHWioHWrGLnfbXwv8vXb7rd/Y8A+NVddp0CY0bJjcTJW9xi
 q5783nIT4qWtNUbTb8Q8hDEy0YOm3wTwYhqvyArAZmyfZynRjPRqDnoRzGfCnN3uJ1yV
 NBOykDCS8aIn0k/e2s+Zir28mK7gN976gV7mrfRaTT+2ozBdQgc9u1SEwbTtF5naVFgT
 l8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560421; x=1753165221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2Itf1u4dIdOzwp9PA5MQ9GY2YE6K+iup4a5uTVYETw=;
 b=mUstdHRsy2yIIZ9jJeSdItUJF3kcnefE8klCos/R42F7GkUtV0NhRcZd8Oi7WlO2tN
 oaaoTo1HvJj1xExxzd4X0bJIsa+xBevzhPH4kIbtvir+tDzkstbO/wepkVbsKo8iTcD1
 3staQttxcLbg2dy+q36t+XALP4Nz70MC6m2RLeGfRqTnTFXu5IifXwquO1NoQv/KXdJb
 UurQ9nLlsj6kgatOHlbpNH5qgt8NVkQ7lw6z1RtJZfB7BWUwDdPVJy1xZWqEk9DkEkQk
 PqFPYxU3jmuckSkFuPKUJV9cv3/vHYjjyE24k/vXs1qGAnrBBsyu1LShJVjFI++nMieE
 Lj1A==
X-Gm-Message-State: AOJu0Yy7/2nou/a5En/jYLR94A0qiS+vv7hzpaVrvSrIJ2Uf0WTCOXsA
 DdtM9Q1ix9aPZ1Cd5/Wl2+XsTocXhR+pcyAat1aLDNV7+sCMl8NvO5YUAXf03Vv6oqT2vEI+ucM
 bzuV1
X-Gm-Gg: ASbGncvJaI7YmYBjgKyR6rWceK3vmBPLRcPqWtFGJk4bQfwITy7QVUwqmn72OEHE2ww
 Dnx7GjksSysEwOfE0rE5+xFXosZ4NakjKGzY8psCEEkkOvHC5rkpj3Jr0RmTESGCMurDYqIze++
 pCpDno6gPus+i1hZwDSIA0NvxpwgiQaWrIflgLiIKdn8EfhKM7B+MZ8NzwvGegZ147QJpZmo1UA
 7KXh54OthYkJBiBaxZiKDizssMPJCltOSc3SSe9/WbY9TaSL6hszA4ihbicqvY9tFUaQ2AaQDYw
 fStDTlKGaWj/PxFzFztBtsItHwifZRsOXqje4sDJhGpGr3nI9+pv3EyHi7ReQJkVxsncEY+bZKp
 5SXwVeelMYRJnjZL6eR48jbTFWDX6GA0rfFmPwwoNAnhVLORBHaOq7Mu0SwPt4fAUHcnU1YLf
X-Google-Smtp-Source: AGHT+IEPyYJg4TwclqqAby4zKWjUSCJwyEeY5b1+X7wTCZis0VZDG9zua9cmzr/sTb4NO1bavjOnyA==
X-Received: by 2002:adf:f3c5:0:b0:3a5:8abe:a264 with SMTP id
 ffacd0b85a97d-3b60a195cb3mr756390f8f.37.1752560420737; 
 Mon, 14 Jul 2025 23:20:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560eb98a40sm82199075e9.27.2025.07.14.23.20.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 12/17] esp.c: improve comment in esp_transfer_data()
Date: Tue, 15 Jul 2025 08:19:12 +0200
Message-ID: <20250715061918.44971-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Whilst working on the previous patch, the existing comment was not enough to
document when the TI command codepath was being used. Update and improve the
comment accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250711204636.542964-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9181c8810fb..62ba4061492 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1029,8 +1029,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
         case CMD_TI | CMD_DMA:
         case CMD_TI:
             /*
-             * Bus service interrupt raised because of initial change to
-             * DATA phase
+             * If the final COMMAND phase data was transferred using a TI
+             * command, clear ESP_CMD to terminate the TI command and raise
+             * the completion interrupt
              */
             s->rregs[ESP_CMD] = 0;
             s->rregs[ESP_RINTR] |= INTR_BS;
-- 
2.49.0


