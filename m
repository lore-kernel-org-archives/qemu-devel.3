Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F62E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF8x-0003hq-TM; Fri, 13 Dec 2024 18:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8W-0003Ky-Au
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8T-00033E-LW
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso15706065e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132710; x=1734737510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98G7xGgH42NoM+rpRevb74bw82XH4wpKnmxY8jqwlAI=;
 b=kChkK25VddsA/DX66gokTD61h9FD8XoDkX9/vEITaSZf6YcHKs6jLzeCsfcwCvRhr2
 2ekLU/xVmcR1upFC+MpoHoTzJSR7Q8KYlQ+mfXsaTtFDfjMviDahmn6D78Cqmocff0jD
 EfFCtPXcmUNdOrnW+lSI6NM+6kTouDwRBZF+BcNsKwAfPIbBVcIA1aSmvifZZQ+H7zEb
 TIOUbF7sFJ4yy3glTGP5DQotex3XFBfYu8mPcc6HAIUzVrovkEFNSDxnXwDD88k2Xn8l
 QipqOo6cfhN3oPCA8MFm74MUuDnN5Ly9ZyS8Q+pLo6j2e0Xc4zZHCGg3R6PG7tI2tTq9
 OzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132710; x=1734737510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98G7xGgH42NoM+rpRevb74bw82XH4wpKnmxY8jqwlAI=;
 b=YHbLBHg+j7wH4evAMBKod7j7cZCcBk3a8ENBxrZExDBcNxqRgcwaSx/a0kkz/FuAFB
 uRpKYqP3F04eSf+Gfc2GBRQYAkQwan6KvELPQ5fzOVgsJeiJCxagmdHYk9wIkBv7KL7S
 m6oHJo7BYhGd0y3wQ5EqW+xw9gtYJ8PRn/4N48VApXsFgQfTEkMDS+/fsxgWrNh8XAdG
 g13De/6K1G9/mYd/Oc34JqSPX/Tdu5+arYGy6ptXJkNzwm08xJXPl8MQ+13gAsoZmeoc
 t1x9WFsGz8f/guexyeT/erMtkc15EMtcvQ2BWtMHiOO2MQwW9zyHQec6Rl9YDyKfNgE0
 UWCg==
X-Gm-Message-State: AOJu0YwmauB2chtPeyNZGe4BJNd/xQs6F0/CDkX4lFkH5rK0z1wNS0bY
 por6fxS5575YgAG5sxJvC/G1okHoaF1crPjCxtD8qUBJtW7Cd6Kl5GK5iOdlNELgtLtSzHDHlJu
 nKDY=
X-Gm-Gg: ASbGncvG4Oh64AlO9grQv0msu1varu6FubfvcQioGYZpa7jrgC6Y8EIWlKr76nFJ/NT
 q4RoyLoZLEEcy4uCwjOscMfrHOfkk+UA2iuQWVvReEF7szJhrThKXn6igmlcKWmYg2QtyIQa2Tg
 yLhalVk9tCMuL7OwF7g/Hzs4N5aIMxi2KyKKF8dgo+iFJVQL3UgMA802Q2kDooH6+IiuALpykL3
 cJomCu9a0NhxrHqMrnpsKtiastS/6xDDKPhXx1w2Vwz6+pfewZ1Bx+AcB4iJNLzOgwM5+b8XxIm
 vbbPgw==
X-Google-Smtp-Source: AGHT+IGdDfTyJFPa9nDlnyDHRBLkiHX2GHeNgF5fGiJL/xYvN7MrDfaR8PeoB0fHSzh/GhQAFY8Y/A==
X-Received: by 2002:a05:6000:4710:b0:386:1cd3:8a0b with SMTP id
 ffacd0b85a97d-3888dcd467fmr3133349f8f.17.1734132710462; 
 Fri, 13 Dec 2024 15:31:50 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c71sm796788f8f.65.2024.12.13.15.31.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/20] hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
Date: Sat, 14 Dec 2024 00:30:45 +0100
Message-ID: <20241213233055.39574-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241206181352.6836-6-philmd@linaro.org>
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


