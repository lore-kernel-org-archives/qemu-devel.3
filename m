Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCE0E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5pI-0006Sg-Hh; Fri, 13 Dec 2024 08:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5oT-0005MZ-UU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5oH-00018F-2W
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so21065065e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096863; x=1734701663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLaEA7eBzqJ7BvxdEYXe8LSu5E5jEsYMhIQgut2X7lQ=;
 b=MHN9wF8AE42JLqa6DAC8bZOiIArK+rDphhCIigShCqRbYOUKoYVAj4CWCdY6ZnwfeE
 MX3NMo2cDfJRDSmHI+byArIHivKOwrIsvqPz3is0dDknGQ8EGMe6pyX642KMbMakPDFg
 KrmHTtEzbhVTux14YYw8YfiD3U9OtW1C1uVk6g296n/MLxAw9QLsfUL0KmK52aEJHJlP
 mzIiuPE8MKKy08R1ByZiOJNts53AbgS2NUAJvu99UzNIC24Y70OITP0eCIVEK/jMXZFQ
 +/KEhg/fMbCYXXYyuepu6/51mbqR4EdXwSySyzUSdCbVIB/Cl2xKkZJDkaozZRd5/zfU
 8pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096863; x=1734701663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLaEA7eBzqJ7BvxdEYXe8LSu5E5jEsYMhIQgut2X7lQ=;
 b=wvojwk7iWWj9K3WDSzHAGQMdIzqjJfhnAVUOyEe83Qo/h7kB4H5fd9Utj5uKm2ibjH
 7LWvRq6hQMHWIv/bYDhEicA4Tf/1Hm21H9pgQfsbx5TghNBweAk82SoO4qZgZhff3OCT
 khGLjSIItc2gbOGM1TyTWGWmeUidwtZ35wmLI6kfJaMZ/75sYfpUhsDRsBgsM6qqalf9
 3i9/jc58ofVprjXoOWF4kq3Elf4iyX9FRt88j9rJySM48YMvY4qVCCyg4k/GflQ3VThJ
 2RvrqzG1umCKdvblJsfAqtG9plaa+H1hHuVLrpdr1kQS4yUefNoHZDemShicyK+A/42I
 LuHA==
X-Gm-Message-State: AOJu0YwwuhR24Opm5q28duQOsII65YudVW8mP9ZaM2zb7WkOuUaymsZ1
 eP1TD134fLLSb323KewfexF0QHRP6mxkqT2/LHccjNqP3AZ/rWWF65T2v1zrhcWmdKOruKhIs8l
 r
X-Gm-Gg: ASbGncsfCsI5bKTJRhWlr8WzR+PhPIoGdz14iwdwRjKtKKwq5vHa+4u7EV3Q2gXUwzj
 puwnjhoC8VuJuxZp256HAYivKLYjGlKQzU65g81NlmDRJtHA5fWprRgzVHSitO9ncYh2T3TDMxT
 EeLRgFpZj4SxWbTGWeUvcdVyt8KrgMr76IMuxEYlG0qqELSnONWx/67W4GU9rMp2NgN+c/8VAdE
 I1caYaZl0NGVN0vEyui+2gC69TXJDFRl3C0oRRLf6bsbcaCsVj880FUSP1WIkpfMkZYVlvcqPI2
 GR6TPTzr9528Y0nPDtuOf8WIf0kPrvMxLVTm
X-Google-Smtp-Source: AGHT+IHLm57BWQ7/aJ35UDzZH//jdwPivuxbY6VorgTrgAVxM9l/WZBDnKZy3u1pUY8rf8Xh1VFx/w==
X-Received: by 2002:a05:600c:83cf:b0:436:1ac2:1acf with SMTP id
 5b1f17b1804b1-4362aa9901cmr21719385e9.20.1734096863269; 
 Fri, 13 Dec 2024 05:34:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706caesm49386565e9.32.2024.12.13.05.34.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:34:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
Date: Fri, 13 Dec 2024 14:33:51 +0100
Message-ID: <20241213133352.10915-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
References: <20241213133352.10915-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

We want to remove fw_cfg_add_extra_pci_roots() which introduced
PCI bus knowledge within the generic hw/nvram/fw_cfg.c file.
Replace the calls by the pci_bus_add_fw_cfg_extra_pci_roots()
which is a 1:1 equivalent, but using correct API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c     | 3 ++-
 hw/hppa/machine.c | 2 +-
 hw/i386/pc.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bd9dd0f863..333eaf67ea3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1750,7 +1750,8 @@ void virt_machine_done(Notifier *notifier, void *data)
         exit(1);
     }
 
-    fw_cfg_add_extra_pci_roots(vms->bus, vms->fw_cfg);
+    pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
+                                       &error_abort);
 
     virt_acpi_setup(vms);
     virt_build_smbios(vms);
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a31dc32a9f7..4e673353225 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -240,7 +240,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
                     g_memdup2(qemu_version, sizeof(qemu_version)),
                     sizeof(qemu_version));
 
-    fw_cfg_add_extra_pci_roots(pci_bus, fw_cfg);
+    pci_bus_add_fw_cfg_extra_pci_roots(fw_cfg, pci_bus, &error_abort);
 
     return fw_cfg;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 99b9b105e26..92047ce8c9d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -631,7 +631,8 @@ void pc_machine_done(Notifier *notifier, void *data)
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
-    fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
+    pci_bus_add_fw_cfg_extra_pci_roots(x86ms->fw_cfg, pcms->pcibus,
+                                       &error_abort);
 
     acpi_setup();
     if (x86ms->fw_cfg) {
-- 
2.45.2


