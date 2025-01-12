Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1ADE7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6HY-0007VN-26; Sun, 12 Jan 2025 17:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HO-0007Tc-OZ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HM-0006PA-7H
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso36061905e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720268; x=1737325068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlEj3ANe4I1Uz5rznp2DVq0ieFeAR6XbYMp+YuA15wg=;
 b=fhNYUhrTxdd78hmUpf674+PkTJmigH+B/sOjcG5Va1VrInfuqzit3RXFe1HEat/H2/
 eiLcwlo1Uj1NJ8aoVc7NpfX/k4NsUpuDkKRDlaicy8gy8V9NKaBbeXqlnQ4TJo/YnQth
 3KFP17USMs/YBT437nohUU6pwn40y1kztyHlR/3opZD7nPFw2Fr/HY0SOSeSZ5uB8ppk
 gk0Q4JpBoCrzfgJ/T+SiULyC2dN375BFPAkfCfc58QJRGRFnZrS9Ny0N0WRUJriNiWn/
 T1mQe/pg6D3cZO0V0iEd/jMvE2fHh63l2LF4/Sd1dTDWmrnRdFRZuD2Rfd7dO0wsTtUG
 N4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720268; x=1737325068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlEj3ANe4I1Uz5rznp2DVq0ieFeAR6XbYMp+YuA15wg=;
 b=f1PIoilkJda8MkqpwV7WjVr+5RVA6Kv4Shpf6+bSuw0t+CH9ele3rn1gRrBwy5KRld
 Kogjn4fcVwIst8K5N5P5oIK0Kqsp4hSlK4+lSOTB7OF6qT6kqX56dqJiZULxluFuQyex
 E8uhJ3eKWbmR+ebX4WiBzknm/Hx5Y6+7ktLj3gtG031SRKHWh1860qlyL6LXr05z3U8p
 SaVIrb3iIrXWuad5ULqVubxYhAlNZEBpro47QVcwZUFtlGw4u8US2dwrTYTjza1EqqM9
 cqTTOii4fiA40RrnqT4cka7otUofJMvOtfN/UhGGBVZtDvIpLvIxKDB4J/2/pMqNtcPp
 5P3g==
X-Gm-Message-State: AOJu0YyxpSfjwyhXeYp76+W6ohmY0Du3vkmfrxnY0tnRau40bJMMr4P0
 FPJSen2FGm4PUdfjDzLNvPbs1pjH0HGMs+OhNI0h7QDZiuhocWS34wNoEeTNhIcOcfneCM9T7UY
 1qgI=
X-Gm-Gg: ASbGncvewIFvc0cpdFEXF2k5f47G2rIHkN+E+zXn7UEntIHJvKUxP6bdZXqtDqgMUOP
 ncRH+ch47VGEpT5ovYWQD/GGuYYH2mhl6HM10E7O9mepwdBQiyYnG1eviI9/44/QChLyfni7KyN
 XGKomJHW7oa5RzvlwAo9ffJfSrMgre6mBxYWMVKRw1CLp7eVX3XpP3tR/kMDBH1cchBm+lCNhVv
 I33OkfoaHe9F7F2qYGlqg36KxN6o/erC0PZeEKzqZPFSkjtpQwxU+NH675UBK5pJjmi5H/Dv/+x
 pmXEdSdA7WzvbFMsnkyyx7ejq/HR3qQ=
X-Google-Smtp-Source: AGHT+IFuCXP2VKCUNxfQe3dsW6Y7TZSE9dOGq8dNi89oNTFsmYTzDgyJAvH6UQCSBDEwYF63bszwXQ==
X-Received: by 2002:a05:600c:4745:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-436e26c4218mr180621855e9.11.1736720267876; 
 Sun, 12 Jan 2025 14:17:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0f69sm156716585e9.13.2025.01.12.14.17.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:17:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Date: Sun, 12 Jan 2025 23:16:40 +0100
Message-ID: <20250112221726.30206-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

QDev objects created with object_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240216110313.17039-22-philmd@linaro.org>
---
 hw/i386/x86-common.c                     | 1 +
 hw/microblaze/petalogix_ml605_mmu.c      | 1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
 hw/mips/cps.c                            | 1 +
 hw/ppc/e500.c                            | 1 +
 hw/ppc/spapr.c                           | 1 +
 6 files changed, 6 insertions(+)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 97b4f7d4a0d..9c9ffb3484a 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -60,6 +60,7 @@ static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
         goto out;
     }
+    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu));
     qdev_realize(DEVICE(cpu), NULL, errp);
 
 out:
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8b44be75a22..b6be40915ac 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -83,6 +83,7 @@ petalogix_ml605_init(MachineState *machine)
 
     /* init CPUs */
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
+    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
     object_property_set_str(OBJECT(cpu), "version", "8.10.a", &error_abort);
     /* Use FPU but don't use floating point conversion and square
      * root instructions
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2c0d8c34cd2..29629310ba2 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -73,6 +73,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
+    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
     object_property_set_bool(OBJECT(cpu), "little-endian",
                              !TARGET_BIG_ENDIAN, &error_abort);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 0d8cbdc8924..293b405b965 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -87,6 +87,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         /* All cores use the same clock tree */
         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
+        object_property_add_child(OBJECT(dev), "cpu[*]", OBJECT(cpu));
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
         }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 4551157c011..17d63ced907 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -955,6 +955,7 @@ void ppce500_init(MachineState *machine)
          */
         object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
                                  &error_abort);
+        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cpu));
         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
 
         if (!firstenv) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 623842f8064..125be6d29fd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2705,6 +2705,7 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
                                     &error_fatal);
             object_property_set_int(core, CPU_CORE_PROP_CORE_ID, core_id,
                                     &error_fatal);
+            object_property_add_child(OBJECT(spapr), "cpu[*]", OBJECT(core));
             qdev_realize(DEVICE(core), NULL, &error_fatal);
 
             object_unref(core);
-- 
2.47.1


