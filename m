Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92739C2BA16
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Xw-0007bm-5t; Mon, 17 Jun 2024 03:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Xu-0007aY-SC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:54 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Xt-0002Oz-1b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6f0c3d0792so462303666b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608371; x=1719213171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s42k9c8X84RNRoOSZQya2U2apvLC50rUpdxoNaury04=;
 b=Ac7UyNZTrrLkE6ddHEFTUthdxr2/7FMnLnCjWXC8xu2ymXGBWsWEuYGvlK61tZQjyo
 oh+/rACK6id7BrRDlVLw/Sc7s1sLlKxDP5m2BdfYwVptACiMHcW8I6beKoSpbutyew2Q
 syXfs8O/eJGPxhSauzHNCV8Mgm4AnTvXFklsjRlp2x6sbEELGzugVG0YecNA4MT8fHkz
 sUDPD2oIUYKDPU4Cj/QjTUtSjD//9MHsDWVZ962d7QIsPNaab5XMOl90niORg2zF4OgL
 Ky9pfCQ1UZj4Q10b0XXggpCxNa481+b8VK8SOHW0oi5b1hs9HOxN7P6ipCQBzVYhbBBC
 Pj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608371; x=1719213171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s42k9c8X84RNRoOSZQya2U2apvLC50rUpdxoNaury04=;
 b=gI2eSeI/nO+FqpNDVOwzNEO9/yhQLXau30q+3uxvTVJtqq3w9PEwVDCu/kq7oZb7UB
 Zxk/0Kp2W4dxqZCkVwopi5sUyJixKaEL/ezHHPk0Di8IT4WlkBxgdPQHJGAc2HHYNHBh
 LdOjJ2OXNV6QElg+NHSpyVjdNxsWjG/H4Vcp5b+Lu2EW1uqwOWI58LW8LPgq7KLU8n6f
 f+6ANtsC59bXtymkmP1zGVaxCrAiWxqURbHlyqtt8j/TNbpCa9/xQL2cpVyKL9JDT+Nr
 wD3qyQIQa2Ot/7MCZivSQiK++yFLRH70bPIH1/WlkgU1LPm1fNABFgz+Wl1cI/B+6gzI
 rC8w==
X-Gm-Message-State: AOJu0YwJzwTDZDS+g+BgYDbpUTRfRPBmQroZcozUgk4mwezMJP3kUyO0
 YSRqOjT3KBoguT3l9PF9RWrBpDZXPNRSXOffYFiP+1sk/aZwHvNKEoCX6Ma2N1XSVcQ3pMwYgrB
 9WTc=
X-Google-Smtp-Source: AGHT+IGTpXL/58NwUNHqD8MWDcC04mYW2GfI8ZsXBWzXauHoy0Il6H/p7ftWPus1ROt/P/8wTxRZdQ==
X-Received: by 2002:a17:906:2c0d:b0:a64:a091:91f2 with SMTP id
 a640c23a62f3a-a6f60d40c99mr630624766b.37.1718608371054; 
 Mon, 17 Jun 2024 00:12:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da4038sm481626266b.31.2024.06.17.00.12.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 16/23] hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
Date: Mon, 17 Jun 2024 09:11:11 +0200
Message-ID: <20240617071118.60464-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

The pc-i440fx-2.2 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    | 23 -----------------------
 hw/i386/pc_piix.c               | 21 ---------------------
 5 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e332eb46e9..d7775fbb84 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -212,7 +212,7 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.2`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
+``pc-i440fx-2.3`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 347e04e50e..58821a8695 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -948,7 +948,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.1`` (removed in 4.0 up to 9.0)
+``pc-0.10`` up to ``pc-i440fx-2.2`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca72f8cab8..155a02b1b5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -307,9 +307,6 @@ extern const size_t pc_compat_2_4_len;
 extern GlobalProperty pc_compat_2_3[];
 extern const size_t pc_compat_2_3_len;
 
-extern GlobalProperty pc_compat_2_2[];
-extern const size_t pc_compat_2_2_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8a9c025754..21a9b7a5ae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -290,29 +290,6 @@ GlobalProperty pc_compat_2_3[] = {
 };
 const size_t pc_compat_2_3_len = G_N_ELEMENTS(pc_compat_2_3);
 
-GlobalProperty pc_compat_2_2[] = {
-    PC_CPU_MODEL_IDS("2.2.0")
-    { "kvm64" "-" TYPE_X86_CPU, "vme", "off" },
-    { "kvm32" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Conroe" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Penryn" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Nehalem" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Westmere" "-" TYPE_X86_CPU, "vme", "off" },
-    { "SandyBridge" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Haswell" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Broadwell" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Opteron_G1" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Opteron_G2" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "vme", "off" },
-    { "Haswell" "-" TYPE_X86_CPU, "f16c", "off" },
-    { "Haswell" "-" TYPE_X86_CPU, "rdrand", "off" },
-    { "Broadwell" "-" TYPE_X86_CPU, "f16c", "off" },
-    { "Broadwell" "-" TYPE_X86_CPU, "rdrand", "off" },
-};
-const size_t pc_compat_2_2_len = G_N_ELEMENTS(pc_compat_2_2);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e0b421dd51..1343fd93e7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -429,11 +429,6 @@ static void pc_compat_2_3_fn(MachineState *machine)
     }
 }
 
-static void pc_compat_2_2_fn(MachineState *machine)
-{
-    pc_compat_2_3_fn(machine);
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -843,22 +838,6 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
                       pc_i440fx_2_3_machine_options);
 
-static void pc_i440fx_2_2_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_2_3_machine_options(m);
-    m->hw_version = "2.2.0";
-    m->default_machine_opts = "firmware=bios-256k.bin,suppress-vmdesc=on";
-    compat_props_add(m->compat_props, hw_compat_2_2, hw_compat_2_2_len);
-    compat_props_add(m->compat_props, pc_compat_2_2, pc_compat_2_2_len);
-    pcmc->rsdp_in_ram = false;
-    pcmc->resizable_acpi_blob = false;
-}
-
-DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
-                      pc_i440fx_2_2_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


