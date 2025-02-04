Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E519C02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6ig-0008Us-Bv; Mon, 03 Feb 2025 19:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6ic-0008SN-Pu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:11 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6ib-00072x-DQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436341f575fso58603925e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628586; x=1739233386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfi4/wO8QElC8iN/q4YQlATETcRX3ZkKT7f3+KqkqnA=;
 b=JWM6lXGOXl81vdJ8aDXvvO0pDlXKhB+lYKFOueVtl0gAhmarut90mKxz0+qCFbRwWy
 LbZ1pheEDK92E3Ut0RKm6nbAgQS3WJclkEuf+BlFiAE+S2yVndQfLFa2nS4NiLJgoPbl
 q6EGTKWi6DerIVvpcN5VWZwnqVoE1h6BnNnHOprIlp6sGeuGGuGX0br+ZyiXPctG5nEV
 i5pAMMcwbHj6d0U7iG1xmWUI49ZohcFg70h+KDqmNL+Iozx8Vrk/NWaw5z/73g+p5sgr
 GYUfQ1evr4+9ix6hTJB/z7eG5+QJXNn4L8g7RADNCu5Ey8W9uf5XO/FigJF2dd8IL2c0
 Wyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628586; x=1739233386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfi4/wO8QElC8iN/q4YQlATETcRX3ZkKT7f3+KqkqnA=;
 b=Ueitm0ndDOn6oNeUtJ9HARuKmsxVnViGyJY3GTSZhmiRPjCPj/zAXvJTn9q9fAhzXw
 rSxHUCskEtcPilxW/YxX8+XcyiK4eqtfj8eqJcRRiGVtdgDdwE/kLUl//MzJvUfRt1SG
 MuAUcqw/uCnhYIL9ykaMCi2IpZKSpU41s6V/uXxjyL2isuXeNYRsGYLsG9SVYjuUrCtN
 eVxJoqZuO0ZEXoOsHJNkc44g53NpqrcgIr3LMvkteW8aPhqWPDAQRI+xqmYN5/AsSlOq
 SMJfRfkP1UQNYLtE2vNzQwz+NvrjWpzAaXTqYXqkXw8AqnKlfLeg5tYDmHoo1WBbIN8I
 BFQA==
X-Gm-Message-State: AOJu0YycTiaEeVptKjmtYOmCIuMOndfFPFhIa/oaRiuy0jt6g0/1Ohs6
 s1aOKF8ioLy2rT3jYRovUTkquDodz6N62kCo2qnbOHf/2ITJTJitzERmw6iXb445hz9zjRudPeI
 IVDA=
X-Gm-Gg: ASbGncs8KFfywsgdYNfpEWUJn7eFgJK6p6Rj0DD6jT/tk0Pww1G346a1g8zC0yvEQ2u
 MkwiHc94D5MtgsLiXx75gjcVl1FF+70pCegukYiG1pkryt3tg3SdNJq7piS9gJGugEgZValZ7pG
 5t/EmLO1HXupVY+8xfMF+BthggicsV9I0UylL8aQtaAOPcsBDv/u+5vYKAgpJvD3L1yKLxUEjed
 UPE/BiAKCeU9KTJ4yiubarxUg6DJXs8jUGPNTr+2h/kA61/AyFQICFZRulaipUWuzY4v8EnAp7a
 KZZ+ucbbsl5a9sj7nCa8xPyhaVrPC0Yqq48ntwPV0J+vZUZIfM1JrC9LayWaZ/I2Rg==
X-Google-Smtp-Source: AGHT+IGwtOzAO4uoqkoycfQcATaNBoRbxxp90e6mhPZc1FH4wFDyWxxo51d3PVPylF8GUURb7ah17Q==
X-Received: by 2002:a05:600c:5027:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-438dc40d36emr216466915e9.24.1738628586606; 
 Mon, 03 Feb 2025 16:23:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26d6fsm204375225e9.14.2025.02.03.16.23.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 04/12] hw/arm/raspi: Pass board_rev as argument to
 raspi_base_machine_init()
Date: Tue,  4 Feb 2025 01:22:32 +0100
Message-ID: <20250204002240.97830-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since callers already have reference to the RaspiBaseMachineClass,
directly pass 'board_rev' as argument to raspi_base_machine_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/raspi_platform.h | 2 +-
 hw/arm/raspi.c                  | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 7bc4807fa51..defb786153b 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -58,7 +58,7 @@ void raspi_machine_init(MachineState *machine);
 
 typedef struct BCM283XBaseState BCM283XBaseState;
 void raspi_base_machine_init(MachineState *machine,
-                             BCM283XBaseState *soc);
+                             BCM283XBaseState *soc, const uint32_t board_rev);
 
 void raspi_machine_class_common_init(MachineClass *mc,
                                      uint32_t board_rev);
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index ef94d57dab5..571b50bef7e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -254,10 +254,8 @@ static void setup_boot(MachineState *machine, ARMCPU *cpu,
 }
 
 void raspi_base_machine_init(MachineState *machine,
-                             BCM283XBaseState *soc)
+                             BCM283XBaseState *soc, const uint32_t board_rev)
 {
-    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
-    uint32_t board_rev = mc->board_rev;
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_base, vcram_size;
     size_t boot_ram_size;
@@ -384,7 +382,7 @@ static void raspi4b_machine_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", soc,
                             board_soc_type(mc->board_rev));
-    raspi_base_machine_init(machine, BCM283X_BASE(soc));
+    raspi_base_machine_init(machine, BCM283X_BASE(soc), mc->board_rev);
 }
 #endif /* TARGET_AARCH64 */
 
@@ -399,7 +397,7 @@ void raspi_machine_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", soc,
                             board_soc_type(mc->board_rev));
-    raspi_base_machine_init(machine, BCM283X_BASE(soc));
+    raspi_base_machine_init(machine, BCM283X_BASE(soc), mc->board_rev);
 }
 
 void raspi_machine_class_common_init(MachineClass *mc,
-- 
2.47.1


