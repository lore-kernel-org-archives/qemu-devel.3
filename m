Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0987EEDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY8B-0004m7-LI; Tue, 03 Mar 2026 17:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY89-0004l0-P2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:17 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY86-0002T7-Db
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so58240125e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576533; x=1773181333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oh5fF1cD60o2GgdhvxUuihszrtUOa2nx4hPj7KeeMlk=;
 b=Z4MJj1jItB2b6+MVJ2itEdJ622WN7SoECrzsgwypAqG9kWGo6002Pl+/NY1uYH0Mbj
 maZLVRbDkDC7tnDnPAlKMmIN1WI17QQFaHuTucYx4/8K5aKV3g15+UGadm666MQCVAG9
 vcKbq21mnX3PnawkPVFcbasscjZNPWtON1T+SaY+tWn/vfwz1L9pUzzFVb/1xD+dbsld
 7SkjXAc2R7/naAB3b0wc0h46PZVvPvRxxD+plGqxs9Jk/ntLhipx/XZ5dIV3dHAlFWHg
 gZbFBls/2K5D/iGenfl9uB0Wjd24I34pXii+O9n5Ua1d7kGW32pbpAsAmh897EmIe6r6
 bbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576533; x=1773181333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oh5fF1cD60o2GgdhvxUuihszrtUOa2nx4hPj7KeeMlk=;
 b=vsWZFCiByjS+yN+EpyN4dwD0Vx+ZhodNVXLcOYk/OAtJ6hpyOl3nJMo06tQuBuw9/t
 afDfJ7DDE7PSZRy/nvS9uHvqF8Pe1I/KMrpnDSkzmriZDnRuayEQocdPgNxd96TkLGRU
 4AWJcSGLaUz26R297kC1PxZrBlwrJmeQxdFsUPyPf5Tl+4JTZPfAECZRv2GUN95I9Xhy
 5y9Qf+b8UBThHNSagq0H29KU193wOn98yP7PBuHHBzn/C62M8iRa4QSbj1k/9Hxn6niM
 4ep1N8k8ykaWlNcqBt5Jq5LnEul6AXhf9kWuA9F7EXZwNnIm01X/gr/3v+b/8kUo8rBg
 yZEg==
X-Gm-Message-State: AOJu0YzgOdna5St/20jrSaDvLTdN/ty0hddqjl8TYF+LFrS0N6mMw280
 7QACX66kRkEl4JEqLoTxcImK4QskM+glgBybp3fSKc1BUYtRplLLf5z2R5c54g==
X-Gm-Gg: ATEYQzyFHhNf8b5npcgfJkYziQ/dUBwLLc3IaSUdhmXbzofkWvXhl10YTo0qss7cU7Z
 kID3QS/DOTWFxTOEE2+SuH6K8zPjrKuUGeqAxLpDtnLg51dxHx77u02yvL6W+EzkwcM6c0d0DH3
 i0NnKJNSjw+ZK7AWMkV92ZOoJMbCX0XXjSS8qt+hlXbfO29GLEBBjjBeIGAFJcYj3JQTTgZeO6T
 P9uGsBLStOH/2iWYkoywJXrDG9kMvuSPatp6JnKYPoL+HIEww2dfzzX/BDqaOTHXTnctuSTeUVL
 3yEqW5YF4hM0/ujsHokolPkDfylMlhQWAnxTnAYqFHZrAwssUQNAPrFyV6YQBWnCEeIZH/QB0nI
 2UdNGG3MC1EfNd6/bKVZPDqn250M2/1lQSO9VTL8uxtEc/kbMM0C7m7PWRO9K68kFgINl2T6HIl
 MVImXn3MYwWGjF0dfvd1H89+0w2a9gZ3WOlFM/6ktMmJJJcL6Voa/93BxEm8zioJqZc2TrAaPA8
 jxQJPVe/HploDQaqFutu6OL2RjktrA=
X-Received: by 2002:a05:600c:6992:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-48513c71087mr62255885e9.12.1772576532552; 
 Tue, 03 Mar 2026 14:22:12 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:12 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 09/13] hw/char/serial: Remove redundant reset
Date: Tue,  3 Mar 2026 23:21:39 +0100
Message-ID: <20260303222143.142741-10-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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


