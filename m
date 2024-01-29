Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC9CC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPj-0007dU-Or; Mon, 29 Jan 2024 10:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPf-0007YX-8r
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:07 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPd-0007T4-Fh
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33926ccbc80so1804999f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541543; x=1707146343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qv6tmFjUz5yI+ezdbTnOo4SrqA0F8CpD3AVMoPUpbVM=;
 b=AKdcK66moimxa0Nec18f+dSiuB/7oZ7PcWFBK7fF1/d9gZtmbw4wWVqQopNASGe+Rd
 fqtQn893YFb7bKlIKkqZgK/X42p8BYP9LW27dI4btauKk75xb8EtDja6P1TfQ4X0lMrX
 +sTfx244hMciaqFxSW8ZBFpe6OE5hEUDur/X2Wz3oFLZQpryswYtd6CwSX/eODejsibu
 lcH1alMFEvZp49yzoM6E5A8yjR+OCJvXogo7qD47Zg+9ykrhXNvYtCPfFkbx8SNbOV3x
 QWT8kbIpchhjkiHqeLykE/O+bpxP7T2Ob06qDgopZMKY8Une/G/nz3cFGswnkctnUggT
 wD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541543; x=1707146343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qv6tmFjUz5yI+ezdbTnOo4SrqA0F8CpD3AVMoPUpbVM=;
 b=K3fmuw6dAAvgiHM1mmp1kJkoJgRGo5JXq9NvFY1KZFzVGDuyQTpva7MY+xbuhI495Q
 6VuSQDMBub+1ppIwxcvUuyQ41jwsfxWHrhzDOfISghcyWT5/yPU3tehN/SnEZaSa8MLJ
 PG/FQ7GppUkPKcSLtxYIB8mTpdg6o5QD4N9muqrjL4kzCeZrMy8J2BKHwpBVLmzongIj
 AMvu/C/ByXoFXwnucEYvktIlY4TOiaoaMUFCW8p9+5ViY+DbvEGLsLTuZSgmmct7FKsk
 lMkafx04y052+f6OeOKg++wVjbBOjM3+e0qZjqKNUUEu0pqL9zyg+lWj53ENjXAa8gRy
 I6GQ==
X-Gm-Message-State: AOJu0YywS94Zw7lmMwddB03Jiviw1tWqG/+Wu2LWyVG3FF1ruhEFKGxj
 fprzyHRd0QjPqtvwGvd31sPl/ITIEDE2xT2Qm8uflAzonwCzaPxpJiZlavCEXvdnL91ccUCiuDM
 A
X-Google-Smtp-Source: AGHT+IHiDZpeQNPziYqNwMV9zzVoZ0IsryPvguDHX5fqz6IcziphZDLrVSgpLVWKctRvo+Q7Gb2PFw==
X-Received: by 2002:a5d:64ed:0:b0:33a:e39a:1590 with SMTP id
 g13-20020a5d64ed000000b0033ae39a1590mr5380182wri.53.1706541543479; 
 Mon, 29 Jan 2024 07:19:03 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 bo18-20020a056000069200b0033af3aec393sm1623351wrb.38.2024.01.29.07.19.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:19:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/9] hw/arm/msf2: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Mon, 29 Jan 2024 16:18:24 +0100
Message-ID: <20240129151828.59544-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

The M2Sxxx SoC family can only be used with Cortex-M3.
Propagating the CPU type from the board level is pointless.

Hard-code the CPU type at the SoC level.
Remove the now ignored MachineClass::default_cpu_type field.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/msf2-soc.h | 3 ---
 hw/arm/msf2-soc.c         | 3 +--
 hw/arm/msf2-som.c         | 4 ----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index ce417a6266..9300664e8e 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -47,13 +47,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(MSF2State, MSF2_SOC)
 #define MSF2_NUM_TIMERS       2
 
 struct MSF2State {
-    /*< private >*/
     SysBusDevice parent_obj;
-    /*< public >*/
 
     ARMv7MState armv7m;
 
-    char *cpu_type;
     char *part_name;
     uint64_t envm_size;
     uint64_t esram_size;
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index b5fe9f364d..d6eb9ec9ac 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -134,7 +134,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
-    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     qdev_connect_clock_in(armv7m, "cpuclk", s->m3clk);
     qdev_connect_clock_in(armv7m, "refclk", s->refclk);
@@ -231,7 +231,6 @@ static Property m2sxxx_soc_properties[] = {
      * part name specifies the type of SmartFusion2 device variant(this
      * property is for information purpose only.
      */
-    DEFINE_PROP_STRING("cpu-type", MSF2State, cpu_type),
     DEFINE_PROP_STRING("part-name", MSF2State, part_name),
     DEFINE_PROP_UINT64("eNVM-size", MSF2State, envm_size, MSF2_ENVM_MAX_SIZE),
     DEFINE_PROP_UINT64("eSRAM-size", MSF2State, esram_size,
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index a269cf044b..5c415abe85 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -47,7 +47,6 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     DeviceState *dev;
     DeviceState *spi_flash;
     MSF2State *soc;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
     DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
     qemu_irq cs_line;
     BusState *spi_bus;
@@ -62,8 +61,6 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     dev = qdev_new(TYPE_MSF2_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_prop_set_string(dev, "part-name", "M2S010");
-    qdev_prop_set_string(dev, "cpu-type", mc->default_cpu_type);
-
     qdev_prop_set_uint64(dev, "eNVM-size", M2S010_ENVM_SIZE);
     qdev_prop_set_uint64(dev, "eSRAM-size", M2S010_ESRAM_SIZE);
 
@@ -108,7 +105,6 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
 
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-- 
2.41.0


