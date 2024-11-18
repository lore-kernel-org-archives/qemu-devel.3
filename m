Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57301D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1AA-0003Pw-O3; Mon, 18 Nov 2024 07:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1A9-0003Mt-EV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1A7-0005PW-VK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so26875775e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934045; x=1732538845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ttdwyIWnlE0XcHxa21WmzaMS4O1MZxffEe5jLcx9RE=;
 b=XIOrZcikEyo//fXKLMdc/8TV6ZB289n+ijbbARZmvjBY8HLl9cWGgfqA8MqpUGge+d
 3E7Dnx44UIEtcYgKLLjDf5LkVq+mcfM/0hrJ6jMjZwD1womkQcTvYi9zCz3/X24ldNE6
 W5mrMgMA+G2TRJpw9zX2pu5JGnZS4vBMXg6zgwulRSHQO6dec2PJPGd8kAJnHH/ygtT/
 VG1bUgbfQk6f/J/CGYBCPdapHGbNr6W3dCF4/t5Oy2LHrHDZD/qhaLZMnW/czhi4uOOn
 YdsQO6wWCdQSrbvRUf1hOznBSVpTPviLL5SP4/BIYxEdlyEDUbQpGeFcV8IMtJQ3mG3g
 n6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934045; x=1732538845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ttdwyIWnlE0XcHxa21WmzaMS4O1MZxffEe5jLcx9RE=;
 b=gXf15XR05s6fXwYmJr+d0m9URI93OIL8tPUz5jxWGU5Kv+ItdzqLujkF8ZztNMs99R
 LES5KL53WCfF40NLjoA1CrUZX6Zu5Hytp5waggdl1DwlH8kK7Ga38V6E7MJLM6ILx/G7
 GoUER7IbYJ5ye4fCAW5pKBA3CZrhmCF2sPGCEJF3L3mVigxuw3QAOUEyduQatBmiRlb8
 6diMy7cAmSAx765y04h9ox3b1KYAScmWQlUibpgNjThN5+wnuPV3MIWWTsQnLhDBhTw3
 Y+e5p/Isdb4JfydyxA27Xv+L+LW909S5LZepss+uN1UZD3P2mGVAS8+vF53bifDCokJS
 noxA==
X-Gm-Message-State: AOJu0Yz8BkFLBUgJiG3d+TELKOKjJ1sPP/dLBn/9IVX+osBGTR8Znqsn
 mMtcLYDW54qzE9bqSKBlJL5KsbrQaq26pu/Nv2V4n8tNh9v3OnK3K1yOShU3RItuJDp0btwIuU0
 n
X-Google-Smtp-Source: AGHT+IFhVzV7qI53Z++fgv2tXiSftzwzfLkHf8Iy3AmOVyNgXGf5NzN9vnaU5OeQMCi1RODmFKSX+g==
X-Received: by 2002:a05:600c:1908:b0:431:52da:9d67 with SMTP id
 5b1f17b1804b1-432df7178f9mr114301385e9.3.1731934045442; 
 Mon, 18 Nov 2024 04:47:25 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab78783sm154194365e9.12.2024.11.18.04.47.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/15] usb-hub: Fix handling port power control messages
Date: Mon, 18 Nov 2024 13:46:34 +0100
Message-ID: <20241118124643.6958-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

The ClearPortFeature control message fails for PORT_POWER because there
is no break; at the end of the case statement, causing it to fall through
to the failure handler. Add the missing break; to solve the problem.

Fixes: 1cc403eb21 ("usb-hub: emulate per port power switching")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241112170152.217664-11-linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/dev-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 06e9537d03..2c3640c705 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -479,6 +479,7 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                     usb_hub_port_clear(port, PORT_STAT_SUSPEND);
                     port->wPortChange = 0;
                 }
+                break;
             default:
                 goto fail;
             }
-- 
2.45.2


