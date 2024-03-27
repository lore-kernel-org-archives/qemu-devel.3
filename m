Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8803C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpWYQ-00026o-Lj; Wed, 27 Mar 2024 12:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpWYK-00026P-Fv
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:55:04 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpWYI-0000Cn-Ki
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:55:04 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so39954a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711558500; x=1712163300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QXc4QbqxBeBLJGQXzu0iuY9oUOaX/t73y5Bs7l/02iA=;
 b=biTi/LkWcjVLmAVt+JGF3MXScqWgdLN9+Z56ISptEAEwW+sTFFHvhN1m5cqhDQdIt1
 GO2Ijbm3rEcCMh53iMpdPW2tcLlWO28REySOSXAcWRs67yG6j9T01j0Hnmv1Q9OPMtuj
 pNI41DxhCFjbPMY6DkIv+OSSN7+V8gA/5xYLpeFKi5PO6Z3OmbRuOIbF31DO2Tqe0yOa
 SJqZHtrtF+54TsaTh7zt+yDIFjAzUO3iT7eoJM7NeGplFQorvQ0yohA2jqqglurTxdp+
 pvuMYaxe4CmIWIwZr7WcwKIIVcnRZ12aIRREUXzv94ukWNQztSMv4asaePxrBPNR1Wa3
 PMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711558500; x=1712163300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QXc4QbqxBeBLJGQXzu0iuY9oUOaX/t73y5Bs7l/02iA=;
 b=YpgzJEelhaYpT/XjjIsqN4SpmL5gLChGSGPiEQ2SuioYuEytfSF0SRDoUPTvkFgzkw
 RLUWzlRMrY0lATdixFgWjy9MnZ/WAi0e2oKMk4lK4berw5lfGDO1rhyckW3VyedD7s9D
 x9RzBpvtYr+b6LEBT9RspWneYJzGdagVzx2sg7VPCXT62gxQMTTz7ad7qByHffeY9ihq
 5RnxRVmmsPmGUQWK5c6oyXliHO797UYQxY5skg3G4ZXJoymBx7cTPg1pT6ZCCzkIFxvz
 W4JE2x7KI1AoQ1Hkg+42PYkus8yPgemzn0r9/mm3EkdR3uvoOzwHo4Wc3/5rvGSxBImi
 IChQ==
X-Gm-Message-State: AOJu0YxufTddF52Wp7xUFK4fHcm2IpkhLzdHgUOcMI+OUDQg16FKbGsf
 MRMq8VXCf8rBraD0+cxbrGkzALQ192wOnSS9NJ496Mh+2H69JTdC/VLV+2Sp30orDUJLmg2El1M
 D
X-Google-Smtp-Source: AGHT+IEPEdvkamj5YN+XVBeItkX18IEqBVKqxrnoc0OXTKMgyY3Ko6o2o51fvkmZG0bb7XAJFYVxiw==
X-Received: by 2002:a50:f610:0:b0:56c:3644:9945 with SMTP id
 c16-20020a50f610000000b0056c36449945mr312096edn.7.1711558499945; 
 Wed, 27 Mar 2024 09:54:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 fe10-20020a056402390a00b0056bf9b4ec32sm5221984edb.78.2024.03.27.09.54.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 09:54:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-9.0 v2] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only PC
 machine
Date: Wed, 27 Mar 2024 17:54:56 +0100
Message-ID: <20240327165456.34716-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Per Daniel suggestion [*]:

 > isapc could arguably be restricted to just 32-bit CPU models,
 > because we should not need it to support any feature that didn't
 > exist prior to circa 1995. eg refuse to start with isapc, if 'lm'
 > is present in the CPU model for example.

Display a warning when such CPU is used:

  $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu Westmere
  qemu-system-x86_64: warning: Use of 64-bit CPU 'Westmere' is deprecated on the ISA-only PC machine
  QEMU 8.2.91 monitor - type 'help' for more information
  (qemu) q

  $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu athlon
  QEMU 8.2.91 monitor - type 'help' for more information
  (qemu) q

[*] https://lore.kernel.org/qemu-devel/ZgQkS4RPmSt5Xa08@redhat.com/

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst |  7 +++++++
 include/hw/i386/pc.h      |  1 +
 hw/i386/pc_piix.c         | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..345c35507f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -208,6 +208,13 @@ is no longer packaged in any distro making it harder to run the
 ``check-tcg`` tests. Unless we can improve the testing situation there
 is a chance the code will bitrot without anyone noticing.
 
+64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``isapc`` machine aims to emulate old PC machine without PCI was
+generalized, so hardware available around 1995, before 64-bit intel
+CPUs were produced.
+
 System emulator machines
 ------------------------
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27a68071d7..2d202b9549 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -96,6 +96,7 @@ struct PCMachineClass {
     const char *default_south_bridge;
 
     /* Compat options: */
+    bool deprecate_64bit_cpu; /* Specific to the 'isapc' machine */
 
     /* Default CPU model version.  See x86_cpu_set_default_version(). */
     int default_cpu_version;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 18ba076609..2e5b2efc33 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -182,7 +182,20 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 
     pc_machine_init_sgx_epc(pcms);
+
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
+    if (pcmc->deprecate_64bit_cpu) {
+        X86CPU *cpu = X86_CPU(first_cpu);
+
+        if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+            const char *cpu_type = object_get_typename(OBJECT(first_cpu));
+            int cpu_len = strlen(cpu_type) - strlen(X86_CPU_TYPE_SUFFIX);
+
+            warn_report("Use of 64-bit CPU '%.*s' is deprecated"
+                        " on the ISA-only PC machine",
+                        cpu_len, cpu_type);
+        }
+    }
 
     if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
@@ -918,6 +931,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->gigabyte_align = false;
     pcmc->smbios_legacy_mode = true;
     pcmc->has_reserved_memory = false;
+    pcmc->deprecate_64bit_cpu = true;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-- 
2.41.0


