Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0D1E6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 13:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snHhu-0002x2-2a; Sun, 08 Sep 2024 09:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHhp-0002qq-W3
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:54 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHho-0000fj-B2
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:53 -0400
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209db94so3604846a12.3
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 06:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725801111; x=1726405911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptL0ygfbb0Laz2aJR63ekKAa+9PX2hwP/FjTByTmNXI=;
 b=SGtVCfbCc0IelJvShjTpu/by4xCjUHsJ13ItZPEMvw2C5W7tived9+qro4f4l0FBji
 tQhzZIFIBuYlvUfB3pS5je30UXtR4QyxyLPFoMSGyrHF6Hjw3VIyAtyyhuzjcNnZIlsi
 +CB1/IAMNoUOS92L+h5Y6YczNA2s0Q/2X9nMpB6ktHaJ1VBg5ZRdGUZtimgOywzPzaJZ
 iUPFIYOuOQzIBVsOgqwZIc+4wn20hn8bLoso6Qz7qs8iLDIPKId10Dk99Pp5xEhMrMeM
 7Kw9AD3Yff+nMwQhnYNmRB9NEU3dg2IBKo07U2q8qvkEHY1o/D6HN8BXbY5dbIO6UJm7
 tpoA==
X-Gm-Message-State: AOJu0Yyaiu+P9Jlih+TR9nbL+wwtxeqUGQtQIUjegfQ9lK3U+fJe2+HL
 yZSVZGEvuKVcgRr4CDmV/TJZv+ATi0otqEU0HH75LndlK6j2qS+58YOohO8q
X-Google-Smtp-Source: AGHT+IE29iaW9jVzRL4gxAAlRo3vTYxwb2tHL9YGl/VYnjKOHDTz1P7dSsFKQRKJ6a66ubBxPhmh2g==
X-Received: by 2002:a17:906:c14c:b0:a86:894e:cd09 with SMTP id
 a640c23a62f3a-a8d1bf75f35mr677789066b.9.1725801110787; 
 Sun, 08 Sep 2024 06:11:50 -0700 (PDT)
Received: from fedora.. (ip-109-43-115-52.web.vodafone.de. [109.43.115.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5212asm1842418a12.57.2024.09.08.06.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 06:11:50 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] hw/nubus/nubus-device: Range check 'slot' property
Date: Sun,  8 Sep 2024 15:11:28 +0200
Message-ID: <20240908131128.19384-4-huth@tuxfamily.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908131128.19384-1-huth@tuxfamily.org>
References: <20240908131128.19384-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.50; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f50.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The TYPE_NUBUS_DEVICE class lets the user specify the nubus slot
using an int32 "slot" QOM property.  Its realize method doesn't do
any range checking on this value, which Coverity notices by way of
the possibility that 'nd->slot * NUBUS_SUPER_SLOT_SIZE' might
overflow the 32-bit arithmetic it is using.

Constrain the slot value to be less than NUBUS_SLOT_NB (16).

Resolves: Coverity CID 1464070
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240830173452.2086140-4-peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/nubus/nubus-device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index be4cb24696..26fbcf29a2 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -35,6 +35,13 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
     uint8_t *rom_ptr;
     int ret;
 
+    if (nd->slot < 0 || nd->slot >= NUBUS_SLOT_NB) {
+        error_setg(errp,
+                   "'slot' value %d out of range (must be between 0 and %d)",
+                   nd->slot, NUBUS_SLOT_NB - 1);
+        return;
+    }
+
     /* Super */
     slot_offset = nd->slot * NUBUS_SUPER_SLOT_SIZE;
 
-- 
2.46.0


