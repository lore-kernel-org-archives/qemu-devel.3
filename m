Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119CEC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBg8-0000af-KV; Wed, 29 May 2024 01:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBg5-0000Yt-V9
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBg3-0005Sb-Qv
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-421208c97a2so11309265e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959801; x=1717564601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O73MgAqxCyDJRattXRNH8siGEuP7PaWdaiYd5+dzTsk=;
 b=bUPVWNjlue+4h6Z6iyUK1MwEvJ13XyB6sOTWIkPA0mbaSkBzafzr1AHwnNVHkRpr0X
 eykAOjGWmFt6iqYqGd9GHSaksJV/QNAzUp2DmSexoZN8P/NCsKHWSkbEgDn8zqvmqiKl
 jDfztB2BpnFJPI8sU2wxYoa/kHcdlX7n84PO0/6VQtVVzrPfR+sTzzOHBV1yVfKjaF6m
 5Z1lhuaYvj+w40AgGA+0mlqvn2SVIziKIKnVmjd8YKdzV8cZ7iHnf3DQVBGr39eG/ymQ
 Rfo7ipFVBxe6mMJwkTuYhgDxj+lBxAJjJ1Z9nQxhWlUAzI/fmhJxUqF/XfY/VTydGg/e
 XVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959801; x=1717564601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O73MgAqxCyDJRattXRNH8siGEuP7PaWdaiYd5+dzTsk=;
 b=YeqD/cO+y1WrCM5jtBFouP92sf6fYfGjS97WYSKmrQZf2+X983cdqr9sOJWL+x5E+A
 psVyasLqKQE8fuWHXMWNBsVxIeLpyVQJcAfwnVV0wpgCVWiZZcGjVpQgGNY/I0xqahzg
 A2mjY/VMhAvFnfn30LS7gL09JFatvrnk/g9oIGP+Gn/1Q7mhJzmZJ10ff9k1xRGScOfE
 ReKHZZ+MHpGoeiZyI4VHRpxT2RPhWFfYg6s0DSurFKNUYjQZq/4re4Lig4iAq7x+a4qY
 g6C0FpP9/4ZsnRrcWzK7okoMVEqvXyJAkWfLLq76pV3QtyxoT77+AkX1IXrk3baPUg//
 OeJg==
X-Gm-Message-State: AOJu0YxR2fbFHclRpGhgzoPkYYdoyNWjNzKgCqGu98kGTBf/3mXGuNz1
 ux5QnU7pBm3OZhcyaPnrpy/wLwtG97MYrPdfXQSlJ0gu6Q5Yz/Adw5lOQx/K5Uqm/dGK+EaP+8V
 j
X-Google-Smtp-Source: AGHT+IEG3BPRttuvOlB6p5jccpB/47MFc9OqA0THQM7cwIFalYc7LG2HS11gw6/yq8++kieeTKLeVA==
X-Received: by 2002:a05:600c:19d2:b0:418:2ccf:cbc7 with SMTP id
 5b1f17b1804b1-421089ebd3dmr101096595e9.2.1716959801223; 
 Tue, 28 May 2024 22:16:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7dbadsm13741060f8f.1.2024.05.28.22.16.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:16:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 11/23] hw/smbios: Remove 'uuid_encoded' argument from
 smbios_set_defaults()
Date: Wed, 29 May 2024 07:15:27 +0200
Message-ID: <20240529051539.71210-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

'uuid_encoded' is always true, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/firmware/smbios.h | 3 +--
 hw/arm/virt.c                | 3 +--
 hw/i386/fw_cfg.c             | 2 +-
 hw/loongarch/virt.c          | 2 +-
 hw/riscv/virt.c              | 2 +-
 hw/smbios/smbios.c           | 6 ++----
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 8d3fb2fb3b..f066ab7262 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -331,8 +331,7 @@ void smbios_add_usr_blob_size(size_t size);
 void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version,
-                         bool uuid_encoded);
+                         const char *version);
 void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
 void smbios_get_tables(MachineState *ms,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..268b25e332 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1677,8 +1677,7 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 
     smbios_set_defaults("QEMU", product,
-                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
-                        true);
+                        vmc->smbios_old_sys_ver ? "1.0" : mc->name);
 
     /* build the array of physical mem area from base_memmap */
     mem_array.address = vms->memmap[VIRT_MEM].base;
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index f9e8af3bf5..7c43c325ef 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,7 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
 
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc, mc->name, true);
+        smbios_set_defaults("QEMU", mc->desc, mc->name);
     }
 
     /* tell smbios about cpuid version and features */
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 3e6e93edf3..6a12659583 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -529,7 +529,7 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
         return;
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, true);
+    smbios_set_defaults("QEMU", product, mc->name);
 
     smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
                       NULL, 0,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fdb660525..5676d66d12 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1277,7 +1277,7 @@ static void virt_build_smbios(RISCVVirtState *s)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, true);
+    smbios_set_defaults("QEMU", product, mc->name);
 
     if (riscv_is_32bit(&s->soc[0])) {
         smbios_set_default_processor_family(0x200);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index eed5787b15..8261eb716f 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
 
-static bool smbios_uuid_encoded = true;
+static const bool smbios_uuid_encoded = true;
 /*
  * SMBIOS tables provided by user with '-smbios file=<foo>' option
  */
@@ -1017,11 +1017,9 @@ void smbios_set_default_processor_family(uint16_t processor_family)
 }
 
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version,
-                         bool uuid_encoded)
+                         const char *version)
 {
     smbios_have_defaults = true;
-    smbios_uuid_encoded = uuid_encoded;
 
     SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
     SMBIOS_SET_DEFAULT(smbios_type1.product, product);
-- 
2.41.0


