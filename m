Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8CECA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 17:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk5WX-0004y7-4r; Fri, 30 Aug 2024 13:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WV-0004uO-9g
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WT-0003OI-Nn
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42bb9d719d4so11477475e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725039296; x=1725644096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYtUTT0TIbHg3HS+ud7uRweJ2SSTTNwBbnoH0NdYWvc=;
 b=jeDWUsLOADrSOTOFssZr0iytFfOWu0LwEpagJDuM1BTS7ZgtVGDbPoU6nyqwUfbR+a
 +cKM6RbBRavoy5yFmqvdKA7PnwrSwokRea0N345m2/0EO9Y2d6dmOalGMYMz1/xOUNq4
 eGvbhbq5Ypc2olo7AOD9VLv1HDm16KDPYpTuoiaG+qU3QBj381bA5wB327mpiOpkkkC1
 XaYMeLYAhmpJM71Ibm9OaFsQO/NfwazcE/YdcUvgV6r23eB7NV+4L0k52LsUds/MMOyY
 QvawA6DgihfLTfNBg2q9kAiJwewdILp3ewP9uirpMjlJ/HFOtR+JmemrX7juckRPp1CC
 4WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725039296; x=1725644096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYtUTT0TIbHg3HS+ud7uRweJ2SSTTNwBbnoH0NdYWvc=;
 b=uqhwH4ztExyUYi/ZmfxXIXIn5LlAbFfHWNU0upC/GNXEbIw9jlHRjZPB2b6quJa4xA
 O2Y/mLhWK694A72S2AM655W2YI8aGpw9Tcrz8GeajmxSYGK9omgjW330RPXiCDplArRU
 aS5OuPSTtL9cd20+c53VhcIFR9M47/EMn0GIo2+FhO00whnYZGEz7GazxVRV4zVYCfL3
 JLkEEgT75v9UoMAXS7IkXlF0Vf8AO96RQlhW6lUKuZXhVI3oqkAmKzm/C8llEjDYyuMP
 /ssJZwPHfEe3A5bnjHTsD09qbjSCulOD0HAxL5BYHI7vUmnaEFTUfQS5lEcWjzDEhKqY
 O7+g==
X-Gm-Message-State: AOJu0YxE35HAZfOV32pqBPgAYNqX9fUbCSMx3/LYOmHFDr1nQFnkPDCC
 D10PzLsaXJqI9vo3YKcfTg1V7VtKsUY0seKsDG8y6e2Kb1xWCO0+1/6qA71mDTlSCAqnh3AZFQ9
 X
X-Google-Smtp-Source: AGHT+IEmExZPBL/8VPxrKfpAgmuDzp9PdBcQJttyaZhOrK6wQl70Rzk9vQkvtSquN4xBJ4x5wKXUdA==
X-Received: by 2002:a5d:66cb:0:b0:373:b44:675 with SMTP id
 ffacd0b85a97d-3749b544813mr4812902f8f.20.1725039295945; 
 Fri, 30 Aug 2024 10:34:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb37f7849sm58471775e9.7.2024.08.30.10.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 10:34:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 3/3] hw/nubus/nubus-device: Range check 'slot' property
Date: Fri, 30 Aug 2024 18:34:52 +0100
Message-Id: <20240830173452.2086140-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830173452.2086140-1-peter.maydell@linaro.org>
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The TYPE_NUBUS_DEVICE class lets the user specify the nubus slot
using an int32 "slot" QOM property.  Its realize method doesn't do
any range checking on this value, which Coverity notices by way of
the possibility that 'nd->slot * NUBUS_SUPER_SLOT_SIZE' might
overflow the 32-bit arithmetic it is using.

Constrain the slot value to be less than NUBUS_SLOT_NB (16).

Resolves: Coverity CID 1464070
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nubus/nubus-device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index be4cb246966..26fbcf29a2b 100644
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
2.34.1


