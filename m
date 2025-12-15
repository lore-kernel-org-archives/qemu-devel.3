Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308B3D5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEoo-0001Ow-4O; Mon, 15 Dec 2025 15:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEoh-0001EE-Js
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:05:14 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEog-0008G0-0O
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:05:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so6341935e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765829108; x=1766433908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5ZKN7vFg5y/BC/H+WKhPf8GxYdib3s0WoFhrYhHqZI=;
 b=IFU5foRAD4IWhY75aNw5K94NT6C+J/v3KOxpfcIK94hhmRjPdYicwrpfi/fuMyrbRh
 UDRlWohq1tqjUoJ0kY8wb5OXVQ8yXfk4Q9eV7reGCoT+Neg/GzuK4nUCzYvaZxo+gX9O
 iuZCW/d0zaJ1AAtMlR6rPc7KMPtKsBFMuPwAgI/S57CPkn2Up3apM2S6ktn/lPTt4cfc
 UaGfS0DyLaE4yF2T9f6l8RP3ZbkfRThvr8ViB+ExVVmCnGNSL2Ni+1TzLAQS/QUsM7cg
 WOGKt/nM0CxtRAtOV2EVTV7eEiowHwDMY8mYUbaNGKJmoIwZmj7qOk4gyrmfOuyGZldj
 DK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765829108; x=1766433908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K5ZKN7vFg5y/BC/H+WKhPf8GxYdib3s0WoFhrYhHqZI=;
 b=OBNH5DWbXsFAqaJzzkXblKDNxx3u9+qLJRQecGH4Vgn5MBB5/1ZYUPnCfC9YFe+3Qh
 AfBnHC73pXsrqqC4V89435NEE9jYjV3nBSRHC0YJW1ciZL33NdCw40LHCtIxrF5A0ew3
 TThyOCwA5E79be06+fsDkaf8Lu/XF6D175o0w/+3hEcY6E+p/gFvieG2r2oWEzWenHiz
 dRz4ZnuyhoayEMdiER0UIjCkQBm7JV3Q7kh3yV5yDEclErl0L/WHu5t9F+LVJdohS2iJ
 8/OiKSam56nsDVrFIbqt6eTfqEv8dYSqOlsxjm1pBEOkBoQzOg9YVK7NZM1cig4mN5tR
 N0Ww==
X-Gm-Message-State: AOJu0YzkMFeBpRZRt7HFguNLFYh/ynAjtaUFkrAsN5pAjsoC2Z9Cb4Fv
 XK5fg+DRZsYt20E0SE4TWihPHMrS09SGnnxIxkJi/ENC1nrdyYwV6DQ4qpj6UQ==
X-Gm-Gg: AY/fxX7vWuP7f4pRMKlrm1D0yO0zYn32kY+GpPuvaMIa5/UzpzsXsypCFi0/KaA/wyj
 CB/EVWYJTL9hw6eGTlBHqbtcUpQtl8Io7MuELpIK+MCgys7dCATmi/NJ6jI/tU/RXA+GS4Yrj12
 KljOCxzOLRD32iZ8UZ1pelK3YDF5gYni/2dRzsvnLw0HfKbz3U+DxPayvzbZbyNVvTplkL60+rv
 2xO/DDjVUsm+Ho01MqGdpMfyQdrMWsU+wzE2NHEVk+SJgWxYuVmD9UrFVfUsgvU9Kt3brnqCqR2
 Llk7Yeh+SjRPRtu8z5yjjuck9QV5lTwgqA5WtlYNu1BX8WzRjTCC99ISr2nY71w1Cgr/UmxpJ5l
 /q82AfRYKm8WXhZbQLf2Mz0KX+Apvp5kC9UhYx7EAJknDQ14gtCTMJlBq3ekWflhi8TUv+QTyPm
 Rk+V06sCLEa/95CISw+ofvyhw/GnFIpKos+AzFtjjDgw==
X-Google-Smtp-Source: AGHT+IE1xman+xYOqHVxsfF6wbFIt0uxgzugu4sshjmRTg4sBtVV8+naAprU4PMqNDL4z6vn7nRDHA==
X-Received: by 2002:a05:600c:6912:b0:479:3a88:de5d with SMTP id
 5b1f17b1804b1-47a8f91dac4mr133480445e9.36.1765829108449; 
 Mon, 15 Dec 2025 12:05:08 -0800 (PST)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f703efesm72603235e9.16.2025.12.15.12.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:05:07 -0800 (PST)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v1 6/6] docs/arm/sabrelite: Mention FlexCAN support
Date: Mon, 15 Dec 2025 21:03:15 +0100
Message-ID: <b13be1ee5d264b051eacf260ea767f6b6424e55b.1765826753.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Also added example command line usage of the Sabrelite board
with FlexCAN controllers.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
---
 docs/system/arm/sabrelite.rst |  1 +
 docs/system/devices/can.rst   | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 09121836fd..5f21c01550 100644
--- a/docs/system/devices/can.rst
+++ b/docs/system/devices/can.rst
@@ -173,6 +173,26 @@ The test can also be run the other way around, generating messages in the
 guest system and capturing them in the host system. Other combinations are
 also possible.
 
+Examples on how to use CAN emulation for FlexCAN on SabreLite board
+-------------------------------------------------------------------
+FlexCANs are connected to QEMU CAN buses by passing the bus IDs as machine properties:
+* property ``canbus0`` for connecting ``flexcan1``
+* property ``canbus1`` for connecting ``flexcan2``
+Note that upstream Linux SabreLite DTs have only a single FlexCAN (``flexcan1``) enabled.
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
2.52.0


