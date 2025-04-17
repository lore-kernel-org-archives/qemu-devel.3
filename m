Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4323FC369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z80-0006xZ-6Q; Thu, 17 Apr 2025 19:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7y-0006uy-Qr
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7w-0003sc-8y
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1332141f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934318; x=1745539118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOUZObtkL1pnrtX/HUZz7JN00TbmXk0vW2RpCKqJB7c=;
 b=PAFAo2Pp0wgCkq+BChyAr860QFHxBpZWeB7EPQAsx5igLUkJjy6m6FrFRhmUQlon6Q
 9tmYyjKCjhUXsWyqwGOuRS3mCLa3aoqwXWPjzP+vqbo22VG/Aj7fJKm/LwEzUyI8BMhS
 VcerR7gzOxY9S9YXANUFDAi7svQQBXGJ9l/UN1fAOM7yvjyAP2cZVDfvWxtu/qJ1HvaL
 OIyHGq9ATeCpnQExpK+nMdJgNdguB7Y4ZOrLbKGXDb0P9Vlg86t+/ZDDo0ycpRZOr1yk
 rSvaZHlnvWqTnN1+0EZsMdlsJrRD3vTZgFAo5xHM6Z5eXBxx3+Jlp4WsKqieL6Petoae
 RNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934318; x=1745539118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOUZObtkL1pnrtX/HUZz7JN00TbmXk0vW2RpCKqJB7c=;
 b=VtdkyjM8KrJv0lw2yhJrcddnmhcIaZhSoeE/wSqoMyoS0YlBkNSEMdIGeuAWoNvpjP
 ArdjvUJyw7XRGbrk/3cZqWW0ZdtjWWsQet8zeQE0DZK4z/XRldBC7H/bpLKm83VPfm6a
 d2OkMBxFQ/JCxegGkCT/B6AwpZXs7pdb1hduezEJcC7ldggkSHNX/aNsh8d++snPj0Pn
 45TJriiklEHw0J/ZhBxtOEPB8xjy/rxfz3QEXZkwmz51juBWJV6D291CtgPZJZtpwnQb
 kXzpNpdeFGrpK1VWrcaEvuaSH9uX1CelWPBOGg0JGSJi5mR3Ls1v2CVDVhL9GstN5dqp
 EMlA==
X-Gm-Message-State: AOJu0Yzu8ZIqnGQcgEN7IWKlLQ0HJYOpU/x5vQxcY40+iJGg/1Ivewua
 AZJfn1Rvmdz5a999ExzHy1bC5R7FUHpsSknAiRp67osaMFWplTdHoXp03df5Mb5ffeFkAnAbPAp
 Y
X-Gm-Gg: ASbGncs8SDzTtPwMMlSjgQRL90kkBngNyxJBZ3LlyysfxJz1tebZMEUGD69DqcHvySY
 6B5EqAGgMu1/5KRiXDZ+H7gb18LcA64ZlYkw5g4X8iHfpK5zwMLgQe73uC088AzaRJAp1SE8Wud
 HRKrZ8YOjgpW6yOyrzB1mqBbqRBEwq9z5Df8w8rUaOHp3X2yRhYHbdmPPjoUtBBtf4Tw0KEfYZo
 GN8A2O/xLSSqupCaW/3QGS7ouV2uk+ACsXCR6tpR2MMluBHuCdU5D7TfiJ28+i1YH6RuBtaOUlp
 hS9NEbAco7z8FsYdbWXRQnP+XHySeJKC5lfCMt0eWBniDK1dqRjdIsHfDFccp2WHZnwfBXfoIwP
 RdmnMgBRaBPPVthWQUN0C
X-Google-Smtp-Source: AGHT+IGhqBs8Cl/BCZPZ7KaNygtBEknvGH5/U+hhfQ7awY412rO0X5VO0Q5avYnk4lVyhj2JOI9Arg==
X-Received: by 2002:a05:6000:4006:b0:390:f4f9:8396 with SMTP id
 ffacd0b85a97d-39efba5c77emr501897f8f.28.1744934318310; 
 Thu, 17 Apr 2025 16:58:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa49312fsm1045268f8f.70.2025.04.17.16.58.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 04/11] hw/arm/digic: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:07 +0200
Message-ID: <20250417235814.98677-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/digic_boards.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 466b8b84c0e..3c0cc6e4370 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -136,8 +136,10 @@ static void canon_a1100_init(MachineState *machine)
     digic4_board_init(machine, &digic4_board_canon_a1100);
 }
 
-static void canon_a1100_machine_init(MachineClass *mc)
+static void digic_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Canon PowerShot A1100 IS (ARM946)";
     mc->init = &canon_a1100_init;
     mc->ignore_memory_transaction_failures = true;
@@ -145,4 +147,12 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
+static const TypeInfo digic_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("canon-a1100"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = digic_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(digic_machine_types)
-- 
2.47.1


