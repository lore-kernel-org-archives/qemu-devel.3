Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427A8C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z89-00076b-Iq; Thu, 17 Apr 2025 19:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z88-00076S-SA
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z87-0003vP-4g
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso954836f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934329; x=1745539129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IV76PRrNanbqrM8g0qKEhby3o8+8x24HZf+5mnfPp+c=;
 b=K4WzrWpe4zvJ3y8lGd1kHUw24Kczgpd7Ceq2ybWVporvbZsAE1AnSOaOLx5bhHPxgH
 k7Nh+Gyru9PSwA4lOQUurAdfgT+Uo6gVkLvWiyDJ2ydHlnp8Xck5bHFQRsjHrj7y1gYI
 t+VmgHZpbUToiY7FZBaewNh0YUwza/EBa6/qGF9p8DeDjvincOt4B5DH4jO8yd6ERS0L
 WTQesLAHJq63xf3XfIIgUoac4kfIbMlAkM3ze3Q0wf+JUtS/I2tz0nqTuGl2VrKbaj2D
 16QKVocK3AnmJqznCPTxbcsQ3pmv1TjolPPBdhho4aVv6g90AqIgq8f3IydtxsZZzZR+
 0mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934329; x=1745539129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IV76PRrNanbqrM8g0qKEhby3o8+8x24HZf+5mnfPp+c=;
 b=pLVdg8sKueqd3XZ+61W2MuYs4ORST3bvrHFo+iYDuW4BIR97CM5Jl8qx2yC+MOEXgf
 GSo+QC8BA1V9C/L/M+ZZxycAIsd9ZsdBHWshLE39HmMuBFAqgyxCEfh689bKtNHoExmR
 gymXmTHgfRVp+v4zZ4mJYUgYAQzn7hHvzbDeo15unM4lqGV+DQ8sp2UI2D6ulA/qBt3p
 9MtSam6OYl7+WQ6UTKg6/xYLo322nnzW0Q6/XkSO9WJH+MNTreIOZaIOm72abmXGMr5i
 nR3AfDAdBSZqJQ/P/ENm+Fnggw/8ak5e9vjZbjurwjoLRq39ySbr/TMsNvdpYeKhyL+n
 nExA==
X-Gm-Message-State: AOJu0Ywwp7Rug5Ffm09+OfdGJb+QIPRbbRXbiECyMAxEV3Pz5t1pfOVh
 6cSL5WwNVXGhtMIrCO9GA/IXZug/65FH0kkfzmb8CMR68bZKtOgtuLsDDsjH9Mxq6TKgTAkYE9p
 P
X-Gm-Gg: ASbGncuyt6uWg+A+zOez78eh7bzU6Sb7TbkPs+yun/jeKKc2/ReRqMGL48PgSXHodRA
 0jPmnaotvsWptK5CYDphqit4tbI2UbBIb7Yfw/psE64SVAMC6lvUG1ZjdVN+wnwIKQt6tNAWTsC
 GnRsa+br4ClGrYct3bM3zdxMBJ+4RqB5nxdXYq5LRFr/wJI5HSV7MfNYcD6utRFm3Zs2RRGtqYS
 fgsSTxRhg/nXDh0gcOZtrvUuz5JGOhj8Zu74BithqKhzVssPb1rMvO+7Dkz9aE3z4CIyyTTtZGL
 9Yhdkijw9RcA9Mo0gAV1roaOABBdShONGS3AtGKPDK33c8nYi5zp1H+e53F/TVmInzv1Bw98tF6
 jqd6I+g3CbJtfj45U8U9O
X-Google-Smtp-Source: AGHT+IHrJybmYerEVKR1kc4iJ3avFxeLEMMiqYjiV9t21N6Lh3iP0i4E41lSeZkx7PH2562rzzrt3A==
X-Received: by 2002:a05:6000:1888:b0:391:4743:6dc2 with SMTP id
 ffacd0b85a97d-39efba5a416mr531019f8f.25.1744934329322; 
 Thu, 17 Apr 2025 16:58:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db230sm836565e9.31.2025.04.17.16.58.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:48 -0700 (PDT)
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
Subject: [PATCH 06/11] hw/arm/integratorcp: Define machine as generic QOM type
Date: Fri, 18 Apr 2025 01:58:09 +0200
Message-ID: <20250417235814.98677-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
 hw/arm/integratorcp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index ac0c6c60961..f95916b517d 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -681,8 +681,10 @@ static void integratorcp_init(MachineState *machine)
     arm_load_kernel(cpu, machine, &integrator_binfo);
 }
 
-static void integratorcp_machine_init(MachineClass *mc)
+static void integratorcp_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM Integrator/CP (ARM926EJ-S)";
     mc->init = integratorcp_init;
     mc->ignore_memory_transaction_failures = true;
@@ -693,8 +695,6 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
-
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
 };
@@ -754,3 +754,13 @@ static void integratorcp_register_types(void)
 }
 
 type_init(integratorcp_register_types)
+
+static const TypeInfo integratorcp_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("integratorcp"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = integratorcp_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(integratorcp_machine_types)
-- 
2.47.1


