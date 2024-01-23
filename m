Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1623C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPD4-0005Oh-9a; Tue, 23 Jan 2024 17:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPD2-0005Mm-K1
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:32 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPD1-0000xw-3G
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:32 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a30e445602cso120764566b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048729; x=1706653529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cw3bjLOiGxm/gmaq73KAUTSMcDh1pUeA2J6w4VTjYkA=;
 b=DmqCJt2Ujlz0/008flJ1wr4ShztXRQhmCqLSLaqngWB3dbcJY0Elg9BKvWePZ7Zrkp
 3Fub6gDD3Pq2EvKciTwwuGjdBQsNVf6JrWe5awIDlrL/q6ljTp9qIT4vAM2iMNyvBfxa
 cP7tmp1RuFalCDWwvfIfjRaT68GPlGFWIuZP+78+Bu8dxKO2cafxBGOttQP09f1nS+M4
 AK1InynfNo7SJh/6MGIBBRz7et/VtUeIrvOmux4QQQgsUhe8nHJmoOwst1oE34/DnnhC
 Ot5EN1f05IdOMrNW+4Mhw6NGX6WDtPEbb0E0bhq0aIClPew5KRAEP3deu+eN8gWp4wV+
 JRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048729; x=1706653529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cw3bjLOiGxm/gmaq73KAUTSMcDh1pUeA2J6w4VTjYkA=;
 b=BJYQme6j5TYgykKlRSkz/k2LZDv0uEJkM/LCEYbfSfqbtbalkIf0Aj+CRngk3l6Spx
 syGOaFh+IK0unrG+xJpOZ2ZkKC6VzWulzbbbwn+MTsQoAYUgliHmdE8R5ntHKOJFxME8
 r4jQk28C7ns3AXu7IhQEg7OAvig7GTNWbrDRFcAHqzKsirhmVOZNMzjC2k02Dd1c/0jM
 1mN1umOdQ1AsFJQaAqghIjXP94BYcRitSXEKGKeigqbQuYPjkiCs97QF31Fy+p5nOCyv
 /htiFMbREBVrLfNfsREvmF12RI7getNscNZASEkQHBoLTuYP2Pfvsjjt9tojqAEn+aIT
 ru6A==
X-Gm-Message-State: AOJu0YxEeddguOie+jWf8m5Wz8VWOfiNGcNTsa++cBjzaXb7e7D8YlXD
 Fxdhmuvz4xilfaRFD2AO9UHDAVmdjgSPhliX1Zuov5/NZ1MIlVPSfP8C/VmG3VqvWV97mRHJfBm
 S
X-Google-Smtp-Source: AGHT+IGsRnKP5UoMpMQbvANE/EMjJT5o97/XL7m+8TVENxx3MOAeoBstcQnFjSccCElLNWBlPEDM5g==
X-Received: by 2002:a17:906:3ca9:b0:a2f:ebb:f200 with SMTP id
 b9-20020a1709063ca900b00a2f0ebbf200mr196156ejh.9.1706048729352; 
 Tue, 23 Jan 2024 14:25:29 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 gu25-20020a170906f29900b00a30dc39aac3sm667245ejb.157.2024.01.23.14.25.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:25:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/6] hw/arm/highbank: Add missing QOM parent for CPU cores
Date: Tue, 23 Jan 2024 23:25:05 +0100
Message-ID: <20240123222508.13826-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123222508.13826-1-philmd@linaro.org>
References: <20240123222508.13826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index e6e27d69af..b8d702c82c 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -209,6 +209,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         cpuobj = object_new(machine->cpu_type);
         cpu = ARM_CPU(cpuobj);
 
+        object_property_add_child(OBJECT(machine), "cpu[*]", cpuobj);
         object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
                                 &error_abort);
 
-- 
2.41.0


