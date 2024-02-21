Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB957C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyu-0006rj-9a; Wed, 21 Feb 2024 16:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyq-0006Vq-M7
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyk-00014z-Lz
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:16 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d4c0b198aso730701f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550288; x=1709155088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwtVJOAzHCvEh5zeHnf1CnqeZsBBSTY3uRRfR/7NLW8=;
 b=k7M65HuWfT9rTjKKBypVlcMJ9HLsgS5D4kI4RIA7ar37Rs83OXjglwFLBFGuckfrKT
 K0/GaQDUZYikOb1xMR4I9JRT6ZazJhmpQof7qF3xXHVkkq2f017wWkbqFsDqUtgwSxmB
 pq8LeEBq8igyzdleE9sWRFUN5/oD2dVtVrK4U6yGW8V/9snw8eWiRIPPm3LfxylJSyw1
 9FYGnZXFtrrcQKMnMTTVtNBlUgXdyCLX1cE8KMKdO2e//d2Z1gPpzKcmDg8qfP8A6hk0
 Fk6ILIXzWPD++VqBRvqRYbpEVMgHKIfInFk7DpaYdsc5lUZiZ1X08/JIuGURkCGtUsfU
 vS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550288; x=1709155088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwtVJOAzHCvEh5zeHnf1CnqeZsBBSTY3uRRfR/7NLW8=;
 b=uqdU77mfkmMv13Pnc55YwQDxk9wxSEMZgmpjWfFsi/oJvEr7Z1lN6j98BnRdAJ5Ilx
 ATYghbpukvZySwj3HUPQVu9vxG93dAqnNqW2znecdGEMd96BjytSA/t1zX0eIFtZCY5V
 RbuPY61l12rtIQgbjK+5k1kEGupxEgfptlVya1Gm19k5+j2JdnEeqnHJaRCI/STikw/I
 0OZZ7vC0a8/Jj41MmMbjbBnxVDAufdsWkr0BxXd0pRoSbFHX95dItQD9D0pHVOXuM1wR
 2D7bHOIFL6JsOx6/v6pu3X2rS/2Ob1NdfKKTw9XG8U6E2Pek8qPLlwh90ri2/QGVGe5n
 vSHA==
X-Gm-Message-State: AOJu0YyHMB+7K5UVScP3fjFVB/pmHOdZWqOU+nmwiapvqRjXNYVJboHJ
 CMmfrArhpO7fc+FGQS9coRV3XpXOeccqpa5P9e7H0ygK6LFOJs5DkLPdQov/pBSeE9OUSC1ygai
 JYzU=
X-Google-Smtp-Source: AGHT+IGmfSHG+/r5mJO/cRoikvzS0NZ1FX2VEcGBcNX1XJT8URhspdH8/7Z9f89HkCzz0nlXmzwChA==
X-Received: by 2002:a05:6000:184a:b0:33d:6b89:fbbb with SMTP id
 c10-20020a056000184a00b0033d6b89fbbbmr4816826wri.47.1708550288697; 
 Wed, 21 Feb 2024 13:18:08 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 bx14-20020a5d5b0e000000b0033d6bd4eab9sm6920318wrb.1.2024.02.21.13.18.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 12/25] hw/i386/pc: Merge pc_guest_info_init() into
 pc_machine_initfn()
Date: Wed, 21 Feb 2024 22:16:12 +0100
Message-ID: <20240221211626.48190-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Resolves redundant code in the piix and q35 machines.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240208220349.4948-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 2 --
 hw/i386/pc.c         | 9 +++------
 hw/i386/pc_piix.c    | 2 --
 hw/i386/pc_q35.c     | 2 --
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index cf2fa60868..39cdb9b933 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -154,8 +154,6 @@ extern int fd_bootchk;
 
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
-void pc_guest_info_init(PCMachineState *pcms);
-
 #define PCI_HOST_PROP_RAM_MEM          "ram-mem"
 #define PCI_HOST_PROP_PCI_MEM          "pci-mem"
 #define PCI_HOST_PROP_SYSTEM_MEM       "system-mem"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d7183780bd..694de8e130 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -698,12 +698,6 @@ void pc_machine_done(Notifier *notifier, void *data)
     pc_cmos_init_late(pcms);
 }
 
-void pc_guest_info_init(PCMachineState *pcms)
-{
-    pcms->machine_done.notify = pc_machine_done;
-    qemu_add_machine_init_done_notifier(&pcms->machine_done);
-}
-
 /* setup pci memory address space mapping into system address space */
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
                             MemoryRegion *pci_address_space)
@@ -1744,6 +1738,9 @@ static void pc_machine_initfn(Object *obj)
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
     cxl_machine_init(obj, &pcms->cxl_devices_state);
+
+    pcms->machine_done.notify = pc_machine_done;
+    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index bea096f569..eeca725504 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -225,8 +225,6 @@ static void pc_init1(MachineState *machine,
                                                &error_abort);
     }
 
-    pc_guest_info_init(pcms);
-
     if (pcmc->smbios_defaults) {
         MachineClass *mc = MACHINE_GET_CLASS(machine);
         /* These values are guest ABI, do not change */
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0e9bd27a6e..8053d8cccb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -188,8 +188,6 @@ static void pc_q35_init(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    pc_guest_info_init(pcms);
-
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc,
-- 
2.41.0


