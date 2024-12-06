Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F00E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcqy-0001tU-3U; Fri, 06 Dec 2024 13:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqn-0001p5-PL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqm-0005R1-6A
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:49 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so1046802f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508886; x=1734113686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvVPy+gwf8NA8vrmhM2eQ3IGQk6ahNK7Fgaq5e8ko14=;
 b=PYc4rXasb3NI1BFNCi5nsKR4zPfNLk9ooRYSz4Mvbf2LGKwddbzZ//PfntnGC74Iwx
 bdYpn7AznzmK1Us7jzntkptkh8PvUrSE6PC/xJ6QhXgUNt2EJnrI2yCn0igOq+9y2SYm
 MzbrfpfUVNvO0EoSPn27u3L5n+8K/15gvMqzGtMXEagRA9lqoOyByZII8SRFhrN0bZu4
 txDpHUAnqwkuxno7GPv6pk07qhMDT3s+Ttz+XKzzF9SO+4Sy89VSeBzaEunQPX4bxWKl
 2i7CW33sLntD3OrlfW+wZ1fh8nQeBDdKGLkDge4H8hOExQ8nn45koNVbxpL2m+xpnmg0
 hM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508886; x=1734113686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SvVPy+gwf8NA8vrmhM2eQ3IGQk6ahNK7Fgaq5e8ko14=;
 b=MgG2xKnDM2bnAfdcSZh+L/QjpYjYwmVnev0OCoQNyhU6S8giksl4ABsoZzm6mUFitv
 v8VjUFl22Yjw0S9M0M+Cx5nHMkcNb/eRlri6MhYVH6ekeVoFrvXI+Q7iIz3LErTNRfir
 /GksZVe6W2ZO8tJnu00dNglfAdlvpg3KRwXzqzGxYYvpl2X6Q3r8y6+a2fuYYiF480AG
 /kA7FLEGGEXc+ZKqzSWWqy2dcYdhR8AJ92UaFCQQPh7/cEAsWEkJKWcOqzc7aYyuHGo+
 T4tv+lsMepQJ6woUyttgoDKNwOnkYs7yh75nxzYTOFghp51vLdxIBO6jINzzrjn0HHnp
 Vi8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYTigZv1ctG+p11xknjTj6JBKznz0YOtfl43vwE5wue2JDqNlez+k0g4uZmmuW/TNCfk6MBHamKep5@nongnu.org
X-Gm-Message-State: AOJu0Yy9KxdJ72a+t/LfGS/jKqAeknN/rcKGx9Cmw40j4XdrQd5U8ikU
 3lL/AmQivXbxhlPznJSL/3f92DGP7gEhEFELk3Gh7rtH+wGUmV6r64qtj1tMAyY=
X-Gm-Gg: ASbGnctr/HU+fMSqMX9Z0gVRGPt1X4ZX0Y2Ep5e97mv0rA4X8Q8jVC2tGnQv1ZJd6PK
 iAirpL0SHXXUxfaP1Do/JGhuDYDY2iRB7UXWOPbEQUdxtJXHkExhFLdnCGzt7YTnOzGpAo5DkBp
 g0X892uiC/BorzNzy0irE+3gFuupCqTHcQBPLKSIQAigbhTURx2FY9tlwJtUPKzaXK9YuWfdLH2
 3kMJSD3tFPk2WtXr4cQTYr7OXAT0qYA8JDITBY3cfSZ2XVSCNEOsHZmzqazvOB+G+Y=
X-Google-Smtp-Source: AGHT+IEmBrSnwEMO1xN+Ij87gZA/44nrHOI7vutX+9aTDBxlIheYbpedBUK3+qkTNdfHuU8vuMXzWg==
X-Received: by 2002:a5d:59a6:0:b0:385:e013:73f6 with SMTP id
 ffacd0b85a97d-3862b3e8503mr3000827f8f.50.1733508886570; 
 Fri, 06 Dec 2024 10:14:46 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862e767db6sm1612934f8f.26.2024.12.06.10.14.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 10:14:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiahui Cen <cenjiahui@huawei.com>,
	qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 5/6] hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
Date: Fri,  6 Dec 2024 19:13:51 +0100
Message-ID: <20241206181352.6836-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206181352.6836-1-philmd@linaro.org>
References: <20241206181352.6836-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

We want to remove fw_cfg_add_extra_pci_roots() which introduced
PCI bus knowledge within the generic hw/nvram/fw_cfg.c file.
Replace the calls by the pci_bus_add_fw_cfg_extra_pci_roots()
which is a 1:1 equivalent, but using correct API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c     | 3 ++-
 hw/hppa/machine.c | 2 +-
 hw/i386/pc.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2bd..191e1d65a8f 100644
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
index 317aaca25a0..3a656f398fd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -628,7 +628,8 @@ void pc_machine_done(Notifier *notifier, void *data)
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
-    fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
+    pci_bus_add_fw_cfg_extra_pci_roots(x86ms->fw_cfg, pcms->pcibus,
+                                       &error_abort);
 
     acpi_setup();
     if (x86ms->fw_cfg) {
-- 
2.45.2


