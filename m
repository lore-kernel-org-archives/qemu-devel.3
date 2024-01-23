Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EAEC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPDH-0005qK-0c; Tue, 23 Jan 2024 17:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPDF-0005hr-2U
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:45 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPDC-0000zJ-RW
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:44 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so501945666b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048741; x=1706653541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RjX1tFrRGVlM1BwnlKhE6JoLvLjIml7FEvFQ9cMoCw=;
 b=TUc19tHZjyl4FfUjXYKcFb56jSJO7LiGv+PpiXnYJ3C3ywjCMi5rBdmJ0lOv0TBpEE
 0KOfNhBgAfzuDI9yH/iPHhSm3jONaFEEoBH2RTH1SJFT809eGdYJhbnefSyFDEBjdXZV
 9EJxyWEZs5D5O/fyfspUAU6ZkRvh94mXFw6Z+gb4hm7im67XIbk9fUnQeT8J02Doq7it
 vtH/DMx4d2FCHcfrRMru30iBpR1E7Fu3bfL1XusCEiWyxuAwwzevvpp9OzDwton2+ox3
 LrIFrJ9y5KNCk0yPirt0XH5+51bWGglt7aRd9hRgp/eSVLnAa5Xa3GZ9x48Qi3MZi5QV
 xNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048741; x=1706653541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2RjX1tFrRGVlM1BwnlKhE6JoLvLjIml7FEvFQ9cMoCw=;
 b=TLvQs2UnsV4X7iv8V/Xx65CW9KZHAv2vhzo17lrIkYDmrvPFKkWyTYCFVh8ayxw11/
 DVApECUNG6laSSixlbbDAdv3f9AlwoWq23GLth3gMMMEd2y0BERmwEbOKUYGTDgpcXq8
 mrlPSXxKpWLIqAd9e/YRtQQgFws0VDs82rmbXnnGJrx7N8T4IPVJkegIfkOkrTvPJ0lG
 rM2VzDlUKAy6yqM6fS0ibHRsagk83xNMnuSy+akDB9JBPeqZqVO2kntO671x9mpoxmut
 nNpL3Ua4vzYbB4nrpzyje+ws4hM0OwqdEBj0CIIWs8Fug4eRXhKlq9x2oDa+pXeSWuTG
 qeow==
X-Gm-Message-State: AOJu0YzB58oMMwx9p2QGF3CCWQnk9BSaaoOcWO2Tr2iyUPOO4HYfhF07
 PaXCrrBYU6cmWMySWYFwEcLLxt3bv0cjLo9MlNMCp/lUcsJx9dlxIr3fyJEIRFmqeyFLB63wkVH
 Z
X-Google-Smtp-Source: AGHT+IEn7r3h75w6vm5m2TAgM5ELIUQ8bWkNZJV5XfU7Zfak1rjJUR8WqEwWgcm3AKP0Mqb7/K/hCQ==
X-Received: by 2002:a17:907:8749:b0:a31:408:e4e5 with SMTP id
 qo9-20020a170907874900b00a310408e4e5mr146355ejc.178.1706048741114; 
 Tue, 23 Jan 2024 14:25:41 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a1709064bc100b00a2c70caccbasm14539348ejv.107.2024.01.23.14.25.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:25:40 -0800 (PST)
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
Subject: [PATCH v2 5/6] hw/arm/vexpress: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 23:25:07 +0100
Message-ID: <20240123222508.13826-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123222508.13826-1-philmd@linaro.org>
References: <20240123222508.13826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/vexpress.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f1b45245d5..a3561a1b56 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -783,22 +783,32 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
 
 static void vexpress_a9_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile Express for Cortex-A9";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
 
     vmc->daughterboard = &a9_daughterboard;
 }
 
 static void vexpress_a15_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a15"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile Express for Cortex-A15";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+    mc->valid_cpu_types = valid_cpu_types;
 
     vmc->daughterboard = &a15_daughterboard;
 
-- 
2.41.0


