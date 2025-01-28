Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B91C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxk-000274-A0; Tue, 28 Jan 2025 15:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxh-00025X-5T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:29 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxf-0001Zc-DC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so69615695e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095206; x=1738700006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JXg2yjqOPUlgEXJLBc2p0xWaWiTWTQI0b81snBCtMNo=;
 b=uvlCrOtrVGm4TgbeBlonN/KwuFpOI2bThI0Rwe5YHugdcPo68viJZOInGUKzRo+ldb
 Dr+qGbqYUA/W/j8skUiqHNGYyIKVRBh0ry+XBNbvjtKpkT1of8G7GlbaS2PU7Uejj5K2
 IVeglvwaAO/SNhinKzEMH29okgKCu4YTPRBhNZEtLjBjanSzNIZBMcBsejgRtHD85gqI
 Acs7XZjDPsu1UbY02GdoeRrLDFC7sjbXW8VpgWS3tueM3S4nTNkoBn4TZ88v5oBkNJxO
 ul/OMcsk0x0ipah9X22wOAkp3O1YBgr85qeL6A/qyAJywNGMv5247pD2gBuy1l7E4Esh
 8ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095206; x=1738700006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXg2yjqOPUlgEXJLBc2p0xWaWiTWTQI0b81snBCtMNo=;
 b=tTufiM8oGthyVyJXbNuuicGxjULksNMcHv1POXBMbWp+iPg9CQnUS3qy1AFFuQzWY3
 Wbe0nbLDY5jncPL1DqlxF5mrzJs9onS9qWayQchBGcoxins4qLmSIq28sF+7jvV5PgfD
 srFUKjy7r8DirQUBQD/AZLrSdaZXh6NeSlJ8Tr0RfLKxfc6XDzTeg79Bdvk4utkU+mHv
 EhLja3gfML5miR6brzUSRHYgWQgLC9pp3hZp10u4u/AvazkVpJD32I4v+QGNz7tn6j72
 OatyOsRSn3DU1vIHlIdZPJJ+ZbV/3zISVCCM81VPCVmVqZKV8R3RyFwvm4w4O2OMG/o8
 /uow==
X-Gm-Message-State: AOJu0YwNssgxaU/0w8fN7Kb5MY66kLAG8dFfGK1Xh1Tjw9GdufG5G1Dj
 J2bWjNZXrB2JMbX1IIMJ87htQRZw0+1EWZWvQgbjuGqQcD48FVTL4rTvkSQxUgJIeXEeJRwiMPr
 J
X-Gm-Gg: ASbGncvjezhRYieNcntE0+9OyrckAoEQTDmfw2mIDgTHZs12+pyGgUQtStOOANMMdDv
 Vzr/I63CNSpH+B/93fFcrDyObs4yDeTG1HugVP1pGICokYiw52FNQhN2rHdjC+3Wfp5BkrAWJzh
 hm7qeIYjiRjhJicOVNek6+d/akElBXsUizRsLBEFci9+VRMs+VrTyizJtpAc4+ltkWgoHv99Ovf
 vkRsMd0M9pYCHXKLqkWfVy3bZV0HrEcAgE0N2UUmZgjgFvZxM7DRC/Z54AHZ9kwtd/YKinfurrN
 czqhc/CY9LCbwgT0Md7MDg==
X-Google-Smtp-Source: AGHT+IE6i/8GA3YlInqWGoSVQVYsiL+QaB8suit5xQQWsAN2TrJGHGo5GhxYXBbnPlHKKfIwuMczeQ==
X-Received: by 2002:a05:600c:4e87:b0:438:a240:c55 with SMTP id
 5b1f17b1804b1-438dc3af833mr2296815e9.1.1738095205790; 
 Tue, 28 Jan 2025 12:13:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/36] hw/arm/stellaris: Remove incorrect unimplemented i2c-0
 at 0x40002000
Date: Tue, 28 Jan 2025 20:12:47 +0000
Message-Id: <20250128201314.44038-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

There is nothing mapped at 0x40002000.

I2C#0 is already mapped at 0x40021000.

Remove the invalid mapping added in commits aecfbbc97a2 & 394c8bbfb7a.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250110160204.74997-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 42498cc1e53..4df02138ac5 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1001,7 +1001,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
      *
      * 40000000 wdtimer
-     * 40002000 i2c (unimplemented)
      * 40004000 GPIO
      * 40005000 GPIO
      * 40006000 GPIO
@@ -1357,7 +1356,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* Add dummy regions for the devices we don't implement yet,
      * so guest accesses don't cause unlogged crashes.
      */
-    create_unimplemented_device("i2c-0", 0x40002000, 0x1000);
     create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
     create_unimplemented_device("PWM", 0x40028000, 0x1000);
     create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
-- 
2.34.1


