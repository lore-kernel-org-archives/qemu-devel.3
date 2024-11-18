Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FACED49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1BU-0005dA-38; Mon, 18 Nov 2024 07:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1B2-0004XV-Se
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1Aw-0005SC-Gw
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43169902057so34282065e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934091; x=1732538891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vThzEj5/0y6fC/Z7sKZAT6Xu5p270O8pYo+gkBmXMu4=;
 b=CMgsvkmcUHQOQpyONJGDbpx7VB6ieLu1c1mlxekPa6hhqDtUXHczDW3QxRyIF5Qi9f
 jbQ4CA0G6BbYMLLI4J65+o8w5zjx6LWfRgS0fxdOqVoVYZ4zBTCJtpus5vCdmcrf4kel
 Y2vbDtDPFDRMK6QpPSl67WtEtuT8YFootBSePWreDTaUqCOO7/G+tVrnXfZozh8VsXZE
 tGo+kyQasU+OOeLKQPqty/F3J1KceF5NJizGrEy28IauWBsyH+NdQUh52P3/Ve+lD12N
 DQ4XOGgIWTzf13v0mWBU5mO5ih4xxA4YiB40H/rpj7+J4ShGU62VmemyGn1zEn9WwCRo
 4hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934091; x=1732538891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vThzEj5/0y6fC/Z7sKZAT6Xu5p270O8pYo+gkBmXMu4=;
 b=f+QkbXda942P6/mD+3J97BmTt/8sh2rY3uYfXdeHJCrWOK4kA+tpFeZJ66tE5NWA24
 QaPBYEKElsf0K2VbAO1cZO/+hBP8ryBPKtXSxpfhFAGc8p+AmEgWGy3btQSGG1wk2iyp
 3DPQ0ZvL4sg05571GSicB/tmrTWaRV9CJqvP0Lk9zm6poHmYs+IoacqQN9u4lR9cYmRu
 I0r6IVtFFXsZjIQGjSa55oP2FSZPFeqL0WQxgpIoS4jufues2r22SBdMf1G6CnW/VXEZ
 1U9ERBvR/ioyaDmZ7na/RJF3JDWapmhc0B9jPwzdWjGnzwns6dR6E99BSEmKD6gtFMVN
 59JA==
X-Gm-Message-State: AOJu0Yw0w/KU+68ZznIUyBLCUU2tsMH1HjChh0AZensCIX5yVpfeRCI1
 Ke1YRqVlsaPrWbMsi5ct4DbMYmGPdPL1ASBo5+EQLSPaV9QfA0jff9nBum5aoqfm1AV3LjaRlLk
 y
X-Google-Smtp-Source: AGHT+IH/Qpx9anm36693kePwO9l3q51HFtofTN2RTonKp8PeJDRuNCQXSnvTuS8pimYG6bn+95KU6Q==
X-Received: by 2002:a05:6000:2c6:b0:382:1c58:5787 with SMTP id
 ffacd0b85a97d-38225a89fe4mr11523224f8f.46.1731934090708; 
 Mon, 18 Nov 2024 04:48:10 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382371a5646sm7362071f8f.0.2024.11.18.04.48.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:48:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roque Arcudia Hernandez <roqueh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/15] hw/watchdog/cmsdk_apb_watchdog: Fix broken link
Date: Mon, 18 Nov 2024 13:46:42 +0100
Message-ID: <20241118124643.6958-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Roque Arcudia Hernandez <roqueh@google.com>

The patch changes the comments to point to the latest Design Kit
Technical Reference Manual.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241115160328.1650269-2-roqueh@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/watchdog/cmsdk-apb-watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 7ad46f9410..e4d25a25f7 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -12,8 +12,8 @@
 /*
  * This is a model of the "APB watchdog" which is part of the Cortex-M
  * System Design Kit (CMSDK) and documented in the Cortex-M System
- * Design Kit Technical Reference Manual (ARM DDI0479C):
- * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
+ * Design Kit Technical Reference Manual (ARM DDI0479):
+ * https://developer.arm.com/documentation/ddi0479/
  *
  * We also support the variant of this device found in the TI
  * Stellaris/Luminary boards and documented in:
-- 
2.45.2


