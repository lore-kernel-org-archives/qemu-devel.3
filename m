Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45026C48BF0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw1E-0007bb-N5; Fri, 16 Feb 2024 06:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1A-0007RT-Vz
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw18-00014R-MF
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4125295ff94so1409265e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081468; x=1708686268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0y1oWRnInhsHqZm+cg/tsMm+PW5dK4fpoLCbcPyN88=;
 b=JH5nC58YOAe6murAf8Ji9d+hD94A2GIfXNBxOprWtySIRQH8TD+apJkRM61FcK4xiv
 2PPZRvf7jkRlKW6op+KHRV6P0DCURkaM2CxVv67gi1z77zTUxdaz3lRv8y8NpWjwnBEy
 OKRbliYrXFW6jn+cU7/cgP4lEwe5DthLSuWMNUqoZHep72E9s34ysVjmuIsB6DwqiBGp
 EV1hk/b+mzPemEYZrp+OVejzOGF/rA7WBSa3hozafzPkMUlq6mI1ADoo6lAt/Vh5ORJP
 Kg093cEsMn7UsxNkyV8GbQPNWcnUNg+XE92W9Yg5a0boHXoYwJ2bUgCPz8H3BODx1u+t
 lNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081468; x=1708686268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0y1oWRnInhsHqZm+cg/tsMm+PW5dK4fpoLCbcPyN88=;
 b=JTiIjHkVeECqLPR6nZIvsGzfvds+O9VcByZf42ZcWkqWE5iW7LNwQ0WPqXG0WjoQz4
 a0JyTzPRdZMbhYB8J2jEcMB1ZahNOfPuoMrWQas6AzAsiB8DqauQ7WdKTPWmb0BqMmsV
 wjv27j5hCl96bRmhTDJqvtrbA6euT0hQMwULJhhIF0VR4WQ+t+TDa5VGLKlNC0Sv4R9u
 4HRwyMFcceOX/02qUKA0//NGU686q3oc0FdG49Yv2S0qTBOJxCc1VNcbk2qcPQl9ec8O
 b5q6CPWoeB0fLng5J13GZWLiaHB17IG8oDJKCmT5pcfitkrl53AnQuvOZEnmKcqoteEm
 /ZbA==
X-Gm-Message-State: AOJu0YwqS7vlSY+Qisdb1WvCjIF5DTDm0i5JT5+wcU7TMb6fWnIckLbt
 awtJw4SFfrB8qACedkMQ2EjHiWHI1azZZMroWMoPkaEY37Ld9BV5EjkQilYZvy4e6mTkRCVDpOm
 P
X-Google-Smtp-Source: AGHT+IEV7SRh/XSnpo0zVpNk9x/dmBVF+PARN86d6zGPb4KFkBuHxKPmsNTU3xJItSyiBnpe0MiDIg==
X-Received: by 2002:a5d:428c:0:b0:33d:2156:6da1 with SMTP id
 k12-20020a5d428c000000b0033d21566da1mr553594wrq.61.1708081468667; 
 Fri, 16 Feb 2024 03:04:28 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 az9-20020adfe189000000b0033b7a2136a4sm1911276wrb.97.2024.02.16.03.04.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:04:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 11/21] hw/usb: Add QOM parentship relation with hub devices
Date: Fri, 16 Feb 2024 12:03:02 +0100
Message-ID: <20240216110313.17039-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QDev objects created with qdev_*new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index a599e2552b..baad04f466 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -439,6 +439,7 @@ void usb_claim_port(USBDevice *dev, Error **errp)
             /* Create a new hub and chain it on */
             hub = USB_DEVICE(qdev_try_new("usb-hub"));
             if (hub) {
+                object_property_add_child(OBJECT(dev), "hub", OBJECT(hub));
                 usb_realize_and_unref(hub, bus, NULL);
             }
         }
-- 
2.41.0


