Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79BDC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbHU-0004OV-35; Tue, 18 Jun 2024 12:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHM-00048l-RR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:53 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHI-0006uI-Q0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:51 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so724265866b.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726507; x=1719331307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7l4PL09eKxeC8JrLL1GKj11eH/AENxSskGBoK9GFtHM=;
 b=F5Rv+76hO1dDz6pdtsbSDhqZ5q//djbZcXEBqWMZl7VQOG9T5dJGBv0EV5/lND5z5H
 YmogFposPIwQXjrcXkhPjIbgfA8erLI9ySEUTPmXTka0aEcjJwmZMQ/bL9ohuyhtn7cQ
 NDMqeSXFHJaDhcg3bt9gHuHUTyUFvjgp1i9TVPT1ICWvQuXC1H0YGfJD3pu1iN7qlyyM
 7g6b+3hwXeQ/oQcfly6w5usgi3A1oZ7Qfk6S25bYp7xeWbnrIxG4a9CUleMTHgjFwOr7
 NGC2M6R3scqSbp3k6YX/PT/nRO67aKoEZf3OmZ0QFzPJ7X4K/l5RBXyzKz5LmsJmcfCu
 BEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726507; x=1719331307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7l4PL09eKxeC8JrLL1GKj11eH/AENxSskGBoK9GFtHM=;
 b=X5YuP9R7qm5q6uK0yeNs9geN67UnNHbmLKUHmabeTa7KLmEZdllRbynt+SjmOIoA1k
 7WSN02NRAe2sFchKJmFlgxEug4zUXOVJ0zewDx6GSNum2BXvdBgCtvoSF8bhNvGWjG5r
 td1n533FSMxBCM8OeJtEJjz+j/fmFBmWDb9OsJUHs6mAAU9upMYObR/AdNNOQF/TYuxv
 H/y+fnapTXG1Nua2S4vLhoapWT85pzxgHLHOTqyfHhDmYn6eteVM1LNyXN7EdJ2bBO25
 sOP5LaWrtRtjU/nkKFBxfr5BZuoCzc7hCasHBVjuqY+uqYTmgjp14umunzR6u11NHKaG
 syKg==
X-Gm-Message-State: AOJu0YxaIqz1J3W0BAsk/xO+/W7Er4TZxK9TCBg3iS6eVGXUC3rhXphO
 GvffZhE8NOlJL72eT3l2GTUmSkbBYQre+D30qEsyC8d5SGL7aEJy1BphEZ8eHN8vUh9JyGmZAcT
 w
X-Google-Smtp-Source: AGHT+IEboVsvAo3ZkuQQvkvkBnBIVNVHbqRsGd1fzD63rvjY0Es6kHHL5MoNRjjcsoFLTZfNqhZJ+A==
X-Received: by 2002:a17:906:99d0:b0:a6f:7834:d3fa with SMTP id
 a640c23a62f3a-a6f7834d5dfmr861808966b.18.1718726506966; 
 Tue, 18 Jun 2024 09:01:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db6dfesm624580866b.87.2024.06.18.09.01.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 11/76] hw/smbios: Remove 'uuid_encoded' argument from
 smbios_set_defaults()
Date: Tue, 18 Jun 2024 17:59:33 +0200
Message-ID: <20240618160039.36108-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
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

'uuid_encoded' is always true, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-12-philmd@linaro.org>
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
index 66cef201ab..b7ea17d5f3 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -556,7 +556,7 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
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


