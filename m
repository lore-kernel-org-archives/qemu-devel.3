Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D054AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo4M-0004IR-Le; Tue, 16 Apr 2024 15:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo47-0002v0-Mw
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:02:00 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo44-0005sg-5Q
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:59 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-570423c4f80so1413002a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294114; x=1713898914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRDJ/6CeDpX+rBaqWai3BvHbA1Ey+M3PEP71cuI1QCM=;
 b=m2DHMs2zy2GwUfVXQEhJ88Tfb1wPPo3dABZmpNUi+8WiVMDjJsrPhhMtv5bsmW/oja
 ir4X4tr/E3Xr6LaP/MSqs52r1WXWCsUP/AEkRDP/JwPu0v+vRiDEE7o38Owe+XwvJ7nx
 FIZwFzJSTTq42djq8XpvIWnE6asWk8KgTf63pEeeR/RbkQYiZmiLHdj/duldgLXcbnsu
 dXxbQjtBLqxBbXnV2/sjxakA24tYbxjoTC/S3UUTyVG/FSeIhKkWn0fkd9dZ/gi23LW7
 BZI485uLuhQKLU+b8TPA4rcvpoR6fWrVpNuQBQ2zhec0dFt57M2Nc7sJ/I8Zdi0XDI+b
 4ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294114; x=1713898914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRDJ/6CeDpX+rBaqWai3BvHbA1Ey+M3PEP71cuI1QCM=;
 b=bYlMlrwp4CBlxawxmjXeVnHx2fk/pymiLpJxllb9I5k8Aic0/ZOmpLxCslprFOGG27
 jZIs3QgKDLKbh1y+QUEFNvIStsrHskhpVoBalE8vMbF+8fIoVTk/AUvcLWA/s0naWR/Q
 cOmkKkwy/jpNWjWkJz4Espy8x2b/TMTxxH93wdZ52wbFPQa6ifzfAeJwNAl7TlMwONWs
 40Hz5sMz05sOaoD8LKhtXvixvsU4nUWe3ioNy0FvR0UW6D4eKsYSk7mBGt8f7T1VpHBr
 311GqI78Y3mPox5FDe4BA9hLpgv6J3ZuEscvNqiRdiAi+Ifsh79mIVtrgxvYzLzPMpLu
 /uoA==
X-Gm-Message-State: AOJu0YwErp7toFOriiAdNnzKM4QlMsUuujxbC6cpv4bvfrj3Yde9DqkG
 BJ+T41AI9F/WQbJgUkqYo2gU0X2a3jFmNIEvg3pbKnmgA0IQuKsF2m93RJW5WvtATgHaLswdzvR
 W
X-Google-Smtp-Source: AGHT+IGbN4pVpHOuCVs1vpZXoKir+5UlkDJfYGPm0F9gzxHmEpVmKVINj61gLzSY1JPoELa7vVkCfQ==
X-Received: by 2002:a50:8e5c:0:b0:56e:2a0a:c133 with SMTP id
 28-20020a508e5c000000b0056e2a0ac133mr11019517edx.22.1713294113891; 
 Tue, 16 Apr 2024 12:01:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a056402274300b0056e3d80ca71sm6417110edd.35.2024.04.16.12.01.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:01:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 20/22] hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine
Date: Tue, 16 Apr 2024 20:59:36 +0200
Message-ID: <20240416185939.37984-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

The pc-i440fx-2.3 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  4 ++--
 docs/about/removed-features.rst |  2 +-
 hw/i386/pc.c                    | 25 -------------------------
 hw/i386/pc_piix.c               | 19 -------------------
 4 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 75bf0f4886..cb6ca372f2 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -219,8 +219,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.3`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 4664974a8b..0caa6a63e4 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -816,7 +816,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.2`` (removed in 4.0 up to 9.0)
+``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a1b0e94523..2e2146f42b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -256,31 +256,6 @@ GlobalProperty pc_compat_2_4[] = {
 };
 const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
 
-GlobalProperty pc_compat_2_3[] = {
-    PC_CPU_MODEL_IDS("2.3.0")
-    { TYPE_X86_CPU, "arat", "off" },
-    { "qemu64" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "kvm64" "-" TYPE_X86_CPU, "min-level", "5" },
-    { "pentium3" "-" TYPE_X86_CPU, "min-level", "2" },
-    { "n270" "-" TYPE_X86_CPU, "min-level", "5" },
-    { "Conroe" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "Penryn" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "Nehalem" "-" TYPE_X86_CPU, "min-level", "4" },
-    { "n270" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Penryn" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Conroe" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Nehalem" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Westmere" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "SandyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "IvyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Haswell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Haswell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Broadwell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { "Broadwell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
-    { TYPE_X86_CPU, "kvm-no-smi-migration", "on" },
-};
-const size_t pc_compat_2_3_len = G_N_ELEMENTS(pc_compat_2_3);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 30bcd86ee6..370d130a6d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -421,14 +421,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
  * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
  */
 
-static void pc_compat_2_3_fn(MachineState *machine)
-{
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    if (kvm_enabled()) {
-        x86ms->smm = ON_OFF_AUTO_OFF;
-    }
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -812,17 +804,6 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
                       pc_i440fx_2_4_machine_options)
 
-static void pc_i440fx_2_3_machine_options(MachineClass *m)
-{
-    pc_i440fx_2_4_machine_options(m);
-    m->hw_version = "2.3.0";
-    compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
-    compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
-}
-
-DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
-                      pc_i440fx_2_3_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


