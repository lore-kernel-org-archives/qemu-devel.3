Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8502DC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb5-0000Nf-SS; Fri, 02 Feb 2024 10:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb1-0000KC-Mf
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaz-0004Td-2s
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40ef6bbb61fso18648525e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888206; x=1707493006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ROIbqMmLLVZq9UdAkCxZXU8hJKBW1wxg/fAMDNbM68c=;
 b=IGet7IlDwj4Ui/UZE57ZGCl1SS5abanvzzFkqCo1tOH4Ba7WBZczRUtCoLmJS5IVMv
 oK+OkfirXXGaxbgD4tFb2uz8zz+GhMBmJku4qk6Abaak6/8bWdVTM5PukkeXaATgaSzg
 2QpeLcdovTXHGSIeXzLDSaoYjt2QwVng0XD7sODfMvpf6ApLB1z/Ipo5nms1wQr02m2u
 6M1xgtQFGINMj1kgTDcZ5OUC64GtqFEd7z98FawEZpZ72Qyd4kuSdJJOwjqwIjbarR4f
 d3IwRtmTezzTqdm/RE2NfURB16JLCjCRWuc/+vm3NCuoXtMwKXUH7y85aLjHtqNe1cAs
 2vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888206; x=1707493006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROIbqMmLLVZq9UdAkCxZXU8hJKBW1wxg/fAMDNbM68c=;
 b=SlfBfGLsTtw4Qx4g4kVjao0kNNGkiK2SOCfG+DyRBvYgmD0BeKVb1Ld+9G0q7VIiNL
 fM+Oaceu8LnmprlACdM7n36bUjXXO2xwkDdO/2+nbQdmUbdCgmhyC7GDa8Jex5ovoWph
 ZswPQneqzFKjsP7IJRaC5Zf0HNIReCNEf57I32qjdXo5yLGLHh6ylUPNXlznfEsWtLdx
 s1ZYRn2eI86a30knJ9Q3Ss58OMVI9DWFNwJ+6Mkjm/OQaQ2M1JW08H9Rc9aa+fii67OB
 u7D6h65rmqu9YpEHTwQXxk/8+Uj+Gl3xLAr+OXXva3ut+4iakWMH7n+ieFdqryL5rP65
 5wjw==
X-Gm-Message-State: AOJu0YxCZgePFgvjQV4PGu2VE7Po5iAbPM9f0okyZAfe8F0sbyeDof+L
 nQtgiGNq4/STnLA8B2FI92yO0mqLlZ0iuQXki/iyt1zBTJ6SvDoWGFdanpFJCU/mKKVHxhvm7dX
 E
X-Google-Smtp-Source: AGHT+IHKi0TpxKIIYngtLZ+5DBdnVqlEwkrX/qtVnN4sRNZhhdK4EjgGPtHqweEBU6Rqo6BZVki3BA==
X-Received: by 2002:a05:600c:a3a5:b0:40f:c655:aaf0 with SMTP id
 hn37-20020a05600ca3a500b0040fc655aaf0mr1390701wmb.23.1706888206713; 
 Fri, 02 Feb 2024 07:36:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/36] hw/arm/msf2: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Fri,  2 Feb 2024 15:36:18 +0000
Message-Id: <20240202153637.3710444-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The M2Sxxx SoC family can only be used with Cortex-M3.
Propagating the CPU type from the board level is pointless.

Hard-code the CPU type at the SoC level.
Remove the now ignored MachineClass::default_cpu_type field.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240129151828.59544-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/msf2-soc.h | 3 ---
 hw/arm/msf2-soc.c         | 3 +--
 hw/arm/msf2-som.c         | 4 ----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index ce417a6266a..9300664e8ea 100644
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
index b5fe9f364d5..d6eb9ec9ac1 100644
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
index a269cf044b9..5c415abe852 100644
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
2.34.1


