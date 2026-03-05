Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73208F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGtF-0001PX-SP; Thu, 05 Mar 2026 17:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsy-00016g-RJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsx-0002I8-Fp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso71411555e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748573; x=1773353373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oh5fF1cD60o2GgdhvxUuihszrtUOa2nx4hPj7KeeMlk=;
 b=fKNPIodWeubcYPx8lqIzfuG8axzq0qS+3ItOqrjbsBrWtzMSFmLOg9pR73HAoaMA/Y
 iw2FtwcPMjLqpXyZCGrqJSFrQNL3t+Gdu6uCY9ZWD1d93vZnzZllfEUkUP/ZSrfAvQQs
 iYJhhjZROuA+xTK0TZDX8HA2SBCpD3O/yXIc8wwzN7YqCHLgF3IVO9oGGrKgWmXjDgtP
 BRH3nk8zeJjzaMOdl+kS2RTV9awxuwHSa67XtCDmLwdxmirZbBjWdjwd8o0GA6v+/Ztw
 UJAOlrdT4CCLPIUac1ATOtfF6dV39lYnYYu3m3TBT1B3PR+83ksUZyRZ6pWo55yYRpsD
 2ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748573; x=1773353373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oh5fF1cD60o2GgdhvxUuihszrtUOa2nx4hPj7KeeMlk=;
 b=XiTnOeD7yC7YUXaET4sMiEr2Qs+ppHoPkpKxxWFKt/UdIRo38AjZMhrLjLIHWwPaf5
 OCEohhjOjF44P27CdC0qTJCi2py5l0/U3QMOulk58nR0Xi6HUCHIsKGMymxw//L30g3g
 gmGkTVI1BSUDL9QP6Q/rQvE8p35z+3fdtey2JxbtJ+fqFar7C/QrBzmzl8RTBhbLpK1f
 BP3fC/P12UCAfreEDiLu5qOGZ6Tyvbpwbokxubuvyh7Z5bc+xg0VkWvR35vJbUPGT406
 Rmlo79kg7EOUExB35teWwEVTyG53cbwLCK5GkAigp2ZwFhSerlQiRJ/Pt6YANgOJ/YjL
 CJnA==
X-Gm-Message-State: AOJu0YzwYHtVqMaqiTo0sXEcF3tDsNntBO+XH20X8vGgjR4Xg7eV0B36
 d+vfcrSmKSZ6k/fO8ojRAZkasEa3T6BLYWV0k/ToPKX97V7Jn8BJ2Lop9IjeEw==
X-Gm-Gg: ATEYQzwL0nMf/pVOqHp0JJ+S9RBs9/VK1blIbdrAzVQ4uMtpunSyyg7vSoqvA4Za9wK
 arWa+w9CIxxW8TGAiLp9iuKHWcQLQ+hU+zML9cZDwOkC5YtLlKsFf5abMINqE/a7UIifCXUICgn
 AW9i1sGBl7xmkv4Q7En3NpgTuW5Su9+78cCj+2B/XVdLhyhkSa2Dx43Alg7YBLExJtq8S3gvfxE
 Fs974ERwlmQOuoFz0xtGtMCO0dS7/t6HIwt6iAz99/Wx/3oXiVaDJ7kOIekh6i0lc7+fvhN5KJH
 sly1xSRI+zWkHhiR/tBWoiLI8H1lIoNAaw8scZMQMXQ7a6jmg+mXLfh2x5SeUkfxwNEveFyGXVW
 gsvzlkeiu1FoUawpBFF3f0cYdABHBgayhENEj2hL/UQmc+2E9Jin1oBRU7lhkPKJLMVsjcDwFMW
 UufxrAcBLsWhkQp+VHJocAsHOVxrEPhcvF7UJJR5gyRhRdPuv5P1CVDXTt22ilXk12q77UpeO2a
 O9HP+j1GJa+ss/OW9R1/n0B07/GqarBaikx5PyRbmG3e3I=
X-Received: by 2002:a05:600c:5394:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-485235a7b78mr16462275e9.9.1772748573093; 
 Thu, 05 Mar 2026 14:09:33 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:32 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 10/14] hw/char/serial: Remove redundant reset
Date: Thu,  5 Mar 2026 23:09:07 +0100
Message-ID: <20260305220911.131508-11-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There is no need to invoke the reset method in realize since the reset
framework will do so anyway before the machine starts.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 485b98f03f..0f3469a1e8 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -934,7 +934,6 @@ static void serial_realize(DeviceState *dev, Error **errp)
                              serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
-    serial_reset(s);
 }
 
 static void serial_unrealize(DeviceState *dev)
-- 
2.53.0


