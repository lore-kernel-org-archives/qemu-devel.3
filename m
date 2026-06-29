Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661E3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgK-0007Nr-33; Mon, 29 Jun 2026 08:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAft-00071N-5C
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfq-0007YK-Es
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so2707393f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734473; x=1783339273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dZ68e+lllc2ko4koDZi1fAQ+t+8zwCavECbfgDMJFSI=;
 b=QhJuSyxxW6EQlk7Tx+usKyIDgULToL919+hambr23TjmCUdyyUBpBxsZEwFHjCToAx
 JSOLWE6JW1KtUKpcKgmd0Yp3w/yK4NssdR4RGVNcsfoz5vfkpCo5o5ytqG/esU0tUZ5m
 BICPAWIgIZNPRDM1n3UkUc1fHBL9ISwcQRSP9GuweYVR4sFzoweq0TqGeS6ip/4eTd3H
 K0M62vUmwCb1u5tyG5ns0l5kiEtZAMs47aMXOtoL0gaddl7Mp3ZN+T2GgYEUBurUVeL/
 G+C3JkS3m6ps+qz7mbwL2zaezdJG2E8yvZQT/sgZKG4j95oKQffq+WReLw/ZfukzXomT
 bo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734473; x=1783339273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dZ68e+lllc2ko4koDZi1fAQ+t+8zwCavECbfgDMJFSI=;
 b=KgTP4pBeo9xUioSxY04BHznHlwue5VyCGNq7NWr1YMZLojTtGsWuh7HwV4KbHvSZCw
 CAjmoUGHgzWFiMZ/kIbjZeeIJZmlYQT1lY7ABURdgNsF2nv2EdcAnQkpLGJbe2G+KjnS
 w4jdCxWunD8Es02qB/S43qxahr5c4WXB+8uWG1Wd7LDIstIz8CqwOVaR4490K+fQQqUw
 hasTBXiMoNmFU4nd/ci3uxQeunMsBXWay6C8jyrO/icaHK94gwBq7+ZTHXqj3Tl81zW9
 p0PU2tHJqZ9dtZuqn3XTHfFrYS1NJSxWcA3EjZFD+9o1Q6c5ZY24yJDKYS2yHQlFcP9T
 qiZA==
X-Gm-Message-State: AOJu0YxpMpnJLJg4IZhyiQxsdiLrIt64BGSp8getIrmetq60M4NrI9d4
 95v4q2zjtUrxnVrJWHOcRnp2HoGBZtMRjDvTO+f12jZbKfbVdqfkl+4Mjjf6rO/VniCVAi4+z+U
 fmqU4
X-Gm-Gg: AfdE7cm4WhIdNkVOz/sGIrT4GNdPVja0q14W2qGWCbkqfqw1aN8PAdr7UHuc804z+J/
 oRZ1GT538EJfKHdKUa+zP0jOAOi4+ZzIdW5JDHd/HhI8RjHapHgvYK4OWCfOFDLOfBjDYG4E0Or
 AG0CHFo0KDQe8yi1ycBxMpmTl36ZQUpioiiyccyJ60r49kjhUNBYgXhe44pNrk9cGtFqhDWMe99
 TtFWeMJuM2PRc6lSJqrVYaDwSG2NoZuNFKVWZqZXafasv/VEAekkJt4WUh9HBd72AcIFSdcouyl
 p6LSUKLL/5rI0OyueJ+Bh0J3dWNkhtBYhApbkl5E2iiSoF9UDxjy0mkElGkf99tcpfdhutPp1E4
 JNEq9dgo41xRK4v4c70P73yN6xoB0Y/usCu+0mHdoPOOvZl69I94yI44pXC5pqHPLKtq6YN6RZ2
 y1nBGVAwo6Bb0sFbbEHsHPjhEZMwJj+06lHZ/EkyBVgFEQOEoIVeSGVtssTUtylZByKo0a6X31z
 B4LlOERQmXnhkaf+Hzu6g==
X-Received: by 2002:a05:6000:420c:b0:474:18d9:8371 with SMTP id
 ffacd0b85a97d-4750079f973mr222502f8f.28.1782734472167; 
 Mon, 29 Jun 2026 05:01:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/54] docs/arm/sabrelite: Mention FlexCAN support
Date: Mon, 29 Jun 2026 13:00:15 +0100
Message-ID: <20260629120032.1645265-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Matyáš Bobek <matyas.bobek@gmail.com>

Also added example command line usage of the Sabrelite board
with FlexCAN controllers.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-id: 19407fc30bdf6b264d1c093a82903609e9cfee48.1782140438.git.matyas.bobek@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/sabrelite.rst |  1 +
 docs/system/devices/can.rst   | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/docs/system/arm/sabrelite.rst b/docs/system/arm/sabrelite.rst
index 4ccb0560af..d3a3c01dd6 100644
--- a/docs/system/arm/sabrelite.rst
+++ b/docs/system/arm/sabrelite.rst
@@ -24,6 +24,7 @@ The SABRE Lite machine supports the following devices:
  * 4 SDHC storage controllers
  * 4 USB 2.0 host controllers
  * 5 ECSPI controllers
+ * 2 FlexCAN CAN controllers
  * 1 SST 25VF016B flash
 
 Please note above list is a complete superset the QEMU SABRE Lite machine can
diff --git a/docs/system/devices/can.rst b/docs/system/devices/can.rst
index 09121836fd..622f898952 100644
--- a/docs/system/devices/can.rst
+++ b/docs/system/devices/can.rst
@@ -173,6 +173,30 @@ The test can also be run the other way around, generating messages in the
 guest system and capturing them in the host system. Other combinations are
 also possible.
 
+Examples on how to use CAN emulation for FlexCAN on SabreLite board
+-------------------------------------------------------------------
+FlexCANs are connected to QEMU CAN buses by passing the bus IDs as machine
+properties:
+
+* property ``canbus0`` for connecting ``flexcan1``
+* property ``canbus1`` for connecting ``flexcan2``
+
+Note that upstream Linux SabreLite DTs have only a single FlexCAN (``flexcan1``)
+enabled.
+
+An example command to run QEMU emulating a Sabrelite development board
+with both FlexCANs connected to a single QEMU CAN bus (called ``qcan0``),
+bridged to host system ``can0`` interface::
+
+  qemu-system-arm -M sabrelite -smp 4 -m 1G \
+    -object can-bus,id=qcan0 \
+    -machine canbus0=qcan0 -machine canbus1=qcan0 \
+    -object can-host-socketcan,if=can0,canbus=qcan0,id=qcan0-socketcan \
+    -kernel ... -dtb ... -initrd ...
+
+Note that in the Linux guest, bitrate for the FlexCAN device is ignored,
+but needs to be set via the ``ip`` command.
+
 Links to other resources
 ------------------------
 
-- 
2.43.0


