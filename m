Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E3BC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPDD-0005ai-GB; Tue, 23 Jan 2024 17:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPD8-0005Vn-TW
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPD7-0000yh-2J
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:38 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-339261a6ec2so3203974f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048735; x=1706653535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gOIjV+kRVk5jxD4Ph/NrJc9jwr9UWxBXsmdwi6+Inw=;
 b=QwRVraXSKZwNlbLIquOBauJq3ZPh1rIUnQQuShWgXGHHKxDrRPGR1Ta3/7lp08vvZp
 nlNsuvYdqY0b8aPX93Yfu/D+pfq6lrvwag+HXsGiJRwwnBEpKkBjFeh+MwAbKZIfirKl
 b+riA25q08ZU3ygheMQw36eu1wvqX1AAE8wjjGKuz9vQ03cOXhfbP2Bkg0jw3Zp17OTQ
 jRtI/DNJ/QNqieBrbMN3y0TIPiTcD4RLFBc8HYYbmGvyR9CyH7XLMMFLmliRMODIJdUb
 OH0/n8f4mWmfY5TaGcZM3eJ19ydj3dPH6EWlhqUkGGQDwLeNAwaF0HwD5CcJUccCcVTb
 6DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048735; x=1706653535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gOIjV+kRVk5jxD4Ph/NrJc9jwr9UWxBXsmdwi6+Inw=;
 b=AROy0bsCwOl4e8CGFISa3Oss7xqVoK3tMtJuYSU7vmNbOVB9ZgJ4TCrI3Q7QjzdQEA
 /yq0bLjdNNbt/ihNWJ81QV/kqPKXISEx0XhhHYmtX+Ebx7VT2SlCh1ZFt4LztztkISKq
 zSw/GZ7upaJYvwk1h9mzVHKiRA/34IeKn+7ahNaAW/rJth/4W21JoPR0tqtD3xs2yQ9a
 sLxPsI6nJixjbHYKRQHmrkGJYQepJDfW++Ap6gWkJpWs92b58eCTMIi2UAO4jcIwcHmY
 dX05xcfdfmq+N5NwIr/jvG2QuoHlb8lqo17iuC7r3xZepOYJsXC40KAWzYupVrXBqY+G
 4Jgw==
X-Gm-Message-State: AOJu0YwV1/JEoaRMgulcdkw2Hb7cTfj9niUqlprz/qsfwknLy2vEO0ft
 yMYXrvcfFpWpaiyHIohmalljGZVnt/bBgkn9U3ODA/TtBLHBv5aGhKUEq3QP2CVYhpkz7Uy/+yk
 E
X-Google-Smtp-Source: AGHT+IHB7LjpuiDUHwrdWXtjdwhCtXJSWwse29yuqOpw6ZRSS8MBCmSjq61ZQUEDilM7Ki/1yhXWSQ==
X-Received: by 2002:a5d:4087:0:b0:337:d85f:2265 with SMTP id
 o7-20020a5d4087000000b00337d85f2265mr4118633wrp.136.1706048735107; 
 Tue, 23 Jan 2024 14:25:35 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 hw10-20020a170907a0ca00b00a3040040011sm2656613ejc.45.2024.01.23.14.25.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:25:34 -0800 (PST)
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
Subject: [PATCH v2 4/6] hw/arm/highbank: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 23:25:06 +0100
Message-ID: <20240123222508.13826-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123222508.13826-1-philmd@linaro.org>
References: <20240123222508.13826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Instead of ignoring invalid CPU type requested by the user:

  $ qemu-system-arm -M midway -cpu cortex-a7 -S -monitor stdio
  QEMU 8.2.50 monitor - type 'help' for more information
  (qemu) info qom-tree
  /machine (midway-machine)
    /cpu[0] (cortex-a15-arm-cpu)
    ...

we now display an error:

  $ qemu-system-arm -M midway -cpu cortex-a7
  qemu-system-arm: Invalid CPU model: cortex-a7
  The only valid type is: cortex-a15

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/highbank.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index b8d702c82c..0367050697 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -345,10 +345,15 @@ static void midway_init(MachineState *machine)
 
 static void highbank_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Highbank (ECX-1000)";
     mc->init = highbank_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
@@ -364,10 +369,15 @@ static const TypeInfo highbank_type = {
 
 static void midway_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a15"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Midway (ECX-2000)";
     mc->init = midway_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
-- 
2.41.0


