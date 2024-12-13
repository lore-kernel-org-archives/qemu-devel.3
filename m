Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F69CE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5pC-00066D-MO; Fri, 13 Dec 2024 08:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5oV-0005OZ-N9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:39 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5oT-00018j-Gh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:39 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so1881367f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096868; x=1734701668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2qKUJQXHTauredWvRg6VWWi6TihRO/ewf0svr7HQas=;
 b=uUZImyce+XGjmiPBNbQiOUVoXk7op4akmi0Fuc+RPswTs6EGbspREbcVUUkAE2QLdA
 0fRpvwJIOnbCKsU8vhdfIY6YPycHWOCH5fLw5VSVptDixUcnpEUpErdSE2gC+lBIzgjC
 gnladO32ntHnRbp336evwkc1zYnUNTzzSiYQmFeed+Mmz+NdStQfkvs82f0N6sr+oZJ5
 jOMtOrY13CLmhl6/0F6dqEhnD9UPaQDwcZRalhqEBIWr9fzQ6+HuS7T0WuaAIDY+ipCi
 17XoYqsMpTFMP/WnhBWwS4gZKd2RjZqdAmakAA6XEu5cfwVyL0u7wgKsd9kmc3lfE40/
 nJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096868; x=1734701668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2qKUJQXHTauredWvRg6VWWi6TihRO/ewf0svr7HQas=;
 b=sTjFPfOc4XOzuO82yIYNXRYzyqSgJWlf/xHG7IF8F8/9XkKQYWSJEajt3kxklVpLwv
 d6ZixP6lq5cX+5AyioBuhEJLgHixQd9jpOaDcQsDtlefyXb1gYFIMp9hmn+Nx19jfgM/
 7qPlfOpgB7LxaGsIgv6FYuyqdIvW0K3GXFZT0xmCCJKPpDu9LraJjfqVWCjQNpe8YI2H
 hqJL78/Q64d9pxtATi7Fap/y+JtxcHptkSflAnL2ipt97N3OQTzPYXWlH/7nnADQBhB9
 v+2h8OZFDFUmUPEzuha1vE1tCJstek4AQwUSJTb5Z5piUTm8mDutp5ww1OifYH9u/KfX
 n6Hg==
X-Gm-Message-State: AOJu0YyzlQ7jL6yCEfgW8/u1D9imTfa4cU3hGC7DnCOm2amQBCBS1BO6
 9oFVlPtKwDUO2vpH6c43tmnWKAVuZU3f4p4Fr0VcyEZuG9RTZSZqXErasMA6VXIEtz7Zo8h82eL
 R
X-Gm-Gg: ASbGnctbbB4hDUM67uwOmnli5D7c4fodvTporSQBJOa6SLP/fy0+2oXMQmucepcEqtp
 NQHIlZTthzXl3q5B0crNn0Y69HtaUk3I1DmY1Iteq4XRE+3dz8kExGYXxX241JYixuISHz5JLqI
 e69DUwrPsi6Hci1dnXP/RD771PDMrjo6+4l19/FuwNN7V6/s7Vqm0p/PEK/4wZ24fG8grjuiKdp
 Xffe5hZbgJVnJrUXZYhHKEAy1RNByi1mBkCAhj4GWK3G2e2PSJ1VjF4LXGnlgVtfrv3+xVZ03x0
 /y2EfI6RZZhdcC2QMysVlmgssnr3szyGphD3
X-Google-Smtp-Source: AGHT+IEKB+oSY/XFteMRP1+vSsK8D57gc84/L4Pa+LmvapOY7su9VntvOrlUKpaBr0b/B9gZMHX3qw==
X-Received: by 2002:a05:6000:4612:b0:385:faf5:ebb8 with SMTP id
 ffacd0b85a97d-388c3651797mr1976046f8f.7.1734096867795; 
 Fri, 13 Dec 2024 05:34:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387823f1606sm7271653f8f.0.2024.12.13.05.34.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:34:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()
Date: Fri, 13 Dec 2024 14:33:52 +0100
Message-ID: <20241213133352.10915-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
References: <20241213133352.10915-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Now that all uses of fw_cfg_add_extra_pci_roots() have been
converted to the newer pci_bus_add_fw_cfg_extra_pci_roots(),
we can remove that bogus method. hw/nvram/fw_cfg must
stay generic. Device specific entries have to be implemented
using TYPE_FW_CFG_DATA_GENERATOR_INTERFACE.

This mostly reverts commit 0abd38885ac0fcdb08653922f339849cad387961
("fw_cfg: Refactor extra pci roots addition").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/nvram/fw_cfg.h |  9 ---------
 hw/nvram/fw_cfg.c         | 23 -----------------------
 2 files changed, 32 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 5211018fd8f..152e049819b 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -315,15 +315,6 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
                                     Object *parent, const char *part,
                                     const char *filename, Error **errp);
 
-/**
- * fw_cfg_add_extra_pci_roots:
- * @bus: main pci root bus to be scanned from
- * @s: fw_cfg device being modified
- *
- * Add a new fw_cfg item...
- */
-void fw_cfg_add_extra_pci_roots(PCIBus *bus, FWCfgState *s);
-
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7e1065e5f50..d56feca6bfe 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -41,7 +41,6 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/loader.h"
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
@@ -1059,28 +1058,6 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
     return true;
 }
 
-void fw_cfg_add_extra_pci_roots(PCIBus *bus, FWCfgState *s)
-{
-    int extra_hosts = 0;
-
-    if (!bus) {
-        return;
-    }
-
-    QLIST_FOREACH(bus, &bus->child, sibling) {
-        /* look for expander root buses */
-        if (pci_bus_is_root(bus)) {
-            extra_hosts++;
-        }
-    }
-
-    if (extra_hosts && s) {
-        uint64_t *val = g_malloc(sizeof(*val));
-        *val = cpu_to_le64(extra_hosts);
-        fw_cfg_add_file(s, "etc/extra-pci-roots", val, sizeof(*val));
-    }
-}
-
 static void fw_cfg_machine_reset(void *opaque)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-- 
2.45.2


