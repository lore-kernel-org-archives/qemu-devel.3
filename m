Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CECAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjG5-0002M3-3P; Tue, 16 Apr 2024 09:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFw-0002B5-9c
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:53 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFt-0001nt-8M
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:52 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a51b008b3aeso545270266b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275627; x=1713880427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTaYd4OjLBjXf3DKJz8AWCQisMqrqe70/bylUuOkixg=;
 b=aP55iBADZrGHjVsb6WV8saOT+Jm6Ed1rFJRJ/tuuEcoYYPufI2VaSZLel8OJTrV9Od
 AQtoF7DHglnX3Lgp7GyQ7+1SINkvLElxEKxpB0/MN68qiKcdyOF14OGibFf5p+maXuRX
 CSqoJaRaCCaenGTEZIWD6ck3fEZOrYrZw+kk88oGMh7WCEdnerTMIGhaSZqZCqinfD6K
 keiMFtTmB8HzChQxvZ8Jz5yhVPyNlcjZPnwLxtFZChEiw1uuriHHd776vpLpe0iLflAt
 wDFFu4wwBFgEqspkzY/Gib4skPGJyuRdFFQUUv2h5sk5n1UdOzEIpkWerE5vtul3XymA
 8B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275627; x=1713880427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTaYd4OjLBjXf3DKJz8AWCQisMqrqe70/bylUuOkixg=;
 b=Dj6ZyKAdW6e4Vs/nuyIJl2namuhPOwppGu3sMwhO/yhhs4Ss9coUAcEx84AFVl2D04
 I198+KZSA1qkNGRNtV1w+4ZQIi5cEdbXYmmUG2qM9CdwPhWxS6VrfR9Frzz327+uKDZg
 4LI3M5D+8cmRhz91uasd73jhhnBPCs2NYUEEftVVyrjjkLr6fIC5vuny/AT5ULL66ZtD
 9FHtY4jMw1VlTCH1S/QA7KvgamszCPCYnB1v2lj/btzaNa0j33XnYiAwvF6drwgIIjoO
 q9P5XzdUD04joAYJxwG1YzFCnAr47AMi/kcxcoGOMPL2x47OaAElpBaOloQPBu/9bcaz
 297A==
X-Gm-Message-State: AOJu0Yz0xrNNx6WiVW5yEIsEzcAIqsNw5dIkN67dTqOSSUOTionRQihA
 jX1lzEcCce0ENbeKb/nTIAazN5HHSmUtTU6Y69Ocdn4t1xqvkZYr5u742fN5IbycRSiad1WIZ09
 U
X-Google-Smtp-Source: AGHT+IHEnM7ty3ncWSTNqddQopLUVkczdAizQVTGKAWfYxTLBBSjVo7g+NQWg4J1KRnV4qvxnQ3a9Q==
X-Received: by 2002:a17:906:48ce:b0:a55:339d:bd20 with SMTP id
 d14-20020a17090648ce00b00a55339dbd20mr3213436ejt.51.1713275627114; 
 Tue, 16 Apr 2024 06:53:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 qf30-20020a1709077f1e00b00a46a27794f6sm6807745ejc.123.2024.04.16.06.53.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:53:46 -0700 (PDT)
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
Subject: [PATCH v3 08/22] hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
Date: Tue, 16 Apr 2024 15:52:37 +0200
Message-ID: <20240416135252.8384-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

The pc-i440fx-2.1 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240305134221.30924-7-philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst       |  4 ++--
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    |  7 -------
 hw/i386/pc_piix.c               | 23 -----------------------
 5 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ef4ad16d41..689cf3cead 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -219,8 +219,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.7`` (since 9.1)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-i440fx-2.2`` and ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.7`` (since 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 51119e623f..01c55103d3 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -816,7 +816,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
+``pc-0.10`` up to ``pc-i440fx-2.1`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4ad724601a..b528f17904 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -281,9 +281,6 @@ extern const size_t pc_compat_2_3_len;
 extern GlobalProperty pc_compat_2_2[];
 extern const size_t pc_compat_2_2_len;
 
-extern GlobalProperty pc_compat_2_1[];
-extern const size_t pc_compat_2_1_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 172814f604..cd6335d6b4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -304,13 +304,6 @@ GlobalProperty pc_compat_2_2[] = {
 };
 const size_t pc_compat_2_2_len = G_N_ELEMENTS(pc_compat_2_2);
 
-GlobalProperty pc_compat_2_1[] = {
-    PC_CPU_MODEL_IDS("2.1.0")
-    { "coreduo" "-" TYPE_X86_CPU, "vmx", "on" },
-    { "core2duo" "-" TYPE_X86_CPU, "vmx", "on" },
-};
-const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 80488a4756..2f28b4e329 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -66,7 +66,6 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
-#include "kvm/kvm-cpu.h"
 #include "target/i386/cpu.h"
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
@@ -435,12 +434,6 @@ static void pc_compat_2_2_fn(MachineState *machine)
     pc_compat_2_3_fn(machine);
 }
 
-static void pc_compat_2_1_fn(MachineState *machine)
-{
-    pc_compat_2_2_fn(machine);
-    x86_cpu_change_kvm_default("svm", NULL);
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -851,22 +844,6 @@ static void pc_i440fx_2_2_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
                       pc_i440fx_2_2_machine_options);
 
-static void pc_i440fx_2_1_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_2_2_machine_options(m);
-    m->hw_version = "2.1.0";
-    m->default_display = NULL;
-    compat_props_add(m->compat_props, hw_compat_2_1, hw_compat_2_1_len);
-    compat_props_add(m->compat_props, pc_compat_2_1, pc_compat_2_1_len);
-    pcmc->smbios_uuid_encoded = false;
-    pcmc->enforce_aligned_dimm = false;
-}
-
-DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
-                      pc_i440fx_2_1_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


