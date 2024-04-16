Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84049C04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjHA-0005gO-EU; Tue, 16 Apr 2024 09:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjGl-000582-UY
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:45 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjGh-0001xC-W6
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:43 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a523dad53e0so577762566b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275678; x=1713880478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niCnoAX1/IoHq/fW8NTYGu+tVPbyTFDmTrJEBLORM4w=;
 b=BISGUhwZNSyAAjQ6ZaIUAOqjaDkJK/dYKiQbAdGKsjhSnqBm4x9PqdWtfU5Plu1u5i
 HS6qyb3YMfDZoFnhAaNjyzwaSCSMHWrwE9o5jambQFWF1jtlY3mwTFTfjwpdCbKpvbhI
 RkBcpiByO007eEiz/Aw2Mrfrq7jo1e7b0jkHBVCn/ZOd+4MYA8By4cPFKOmdYimTW0ZP
 Eg49U2AZVryyMjPShRqj9f+H8iQ0HCJLbQW56jS8aymdiEwoRKA+ZpZVP+1m2oyJOexK
 u6MKMjunPG7V0faCwV/rqA6OyEY6qSyC2NUi5ovXpAACoAaDKZx3tC4KWOh2DISWDNYX
 V/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275678; x=1713880478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niCnoAX1/IoHq/fW8NTYGu+tVPbyTFDmTrJEBLORM4w=;
 b=eiEqkdQ1s5fJedXwYNh1xWDXqACe+4D43HueZtRLuiAlznqVMkGfz3zYqE9Or6WwmI
 Q9NO4fK6ZOpxorP3zgkP+KICIUeFxIVtgmUuvhx4Hs3m7G91xL+ZLn3qPTXe/9VG1TYK
 eGdeXxPo8wlF9yprNzOHik5Wb0IYtVhaXI9vLieOdV9fkI6VLdYwlKuV9+FnjbnZ8d/a
 vcLndJ6jRc7Kfse5SNx9tS/aYXvH9mbU250ToU7TnV6V5k03B7I/vsyR5HJuUBShjlK6
 z/FWb57uZin0EFe/a0k+itpwI7/mtYDi2Z55OC/6rEoeTPK0msAAvFrILy1WYTxyuS6m
 VviA==
X-Gm-Message-State: AOJu0YzNj/YbveMYRydBjJ+DaYlI0kV0NN7Jvivtl/NWn6ZVN1UqvxSe
 tk2OFcSMtlVyYr/tlp1QADBOOy63Vc8uVEhMuoQodBBWqpBE9VPn/wtTW9I4ev8laykiwqASVEE
 l
X-Google-Smtp-Source: AGHT+IHbRPXAeF1BWH/B4tIZ1JRviM9QnaVYXhLd2cjnwk5yQUeudL8GfmYw5GIrQejQFhB0g4qdlg==
X-Received: by 2002:a17:906:b892:b0:a51:8672:66e4 with SMTP id
 hb18-20020a170906b89200b00a51867266e4mr2515645ejb.22.1713275678090; 
 Tue, 16 Apr 2024 06:54:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 23-20020a170906319700b00a543e6e1c47sm2010767ejy.72.2024.04.16.06.54.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:54:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 16/22] hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
Date: Tue, 16 Apr 2024 15:52:45 +0200
Message-ID: <20240416135252.8384-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

The pc-i440fx-2.2 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240305134221.30924-13-philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst       |  4 ++--
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    | 23 -----------------------
 hw/i386/pc_piix.c               | 21 ---------------------
 5 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 689cf3cead..707455c817 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -219,8 +219,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.2`` and ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.7`` (since 9.1)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.7`` (since 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 01c55103d3..4664974a8b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -816,7 +816,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.1`` (removed in 4.0 up to 9.0)
+``pc-0.10`` up to ``pc-i440fx-2.2`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 231aae92ed..df97df6ca7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -274,9 +274,6 @@ extern const size_t pc_compat_2_4_len;
 extern GlobalProperty pc_compat_2_3[];
 extern const size_t pc_compat_2_3_len;
 
-extern GlobalProperty pc_compat_2_2[];
-extern const size_t pc_compat_2_2_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 633724f177..18bef7c85e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -281,29 +281,6 @@ GlobalProperty pc_compat_2_3[] = {
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
index 2f28b4e329..d32acb5634 100644
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
@@ -828,22 +823,6 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
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


