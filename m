Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF68E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcrv-0003Kq-Uj; Fri, 06 Dec 2024 13:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcrI-0002e0-1e
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:15:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcrA-0005Sl-JL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:15:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so16581035e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508911; x=1734113711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drnor6SocDhMk0Sf/VXY5/KGSh3UPEWhTs9UqjHuGlg=;
 b=BSDhbKH4cTIS9c9S3Rsrp4CKbevQE5m+sQYvxe9VEntFqFC1mbS4wwsYD8ArzZ3Hin
 tONTi/Z5KYVMtmUTXJIZq0RTdCxH26L3lV3uV1eodXpdviCYRIzQbt2aj+khT/ZIWfnN
 Mj9XGSztoUGv0RcM+wsJL2mFDsZEQRzOQOy6zgBJerAvxVpyN+kYOYTtVmvTzFahFQzA
 vzEHmtcVR1efdcEzHv1q5qAtrbLSBKwDGbL0u0JL4QFMF0gtHtMMZxD5xmtCZu1nsTLb
 jZbFj6fbpbWFL9Mqa2l4vAZ7fNSlCgDX4VF8knITirzkR4FWPReeNVXI6WlUnaWEq4xp
 Chmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508911; x=1734113711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drnor6SocDhMk0Sf/VXY5/KGSh3UPEWhTs9UqjHuGlg=;
 b=t0Pnh4/0mU1BcJMHigZu3S8+BOslwWKWcKiWKDT+qNERYzgf+L9CEyRTXH4V3gguU/
 Qwl1tQW/2uObwi1qp64/0ocoGq4V1z7QbJRtmfiCF+zlS6ohhE9jFnYB8AfSy0EOCUp9
 OQYi07g118FFrGrT0kdEWr88I7S/ALH4bwpmrmmi0JbFkpsC154bicK5DPzr07N+d67U
 wj17L/tUjiLZlMvjiH4mJtGd1VE0LKHzKY3T14po1LTziFeSsGen1YTGBXH9vjNNBqL1
 9RmksGbCUonug8EeS9N/TOa/0xLjU8vhanpbko+Ieu4f3hK+XYz9Ickx186lI3DwQjz7
 vIWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN/jUQG37qXRQXXKtSe4B5fyf2EnvsFbxAstVy8RLyu8r27ImQHfeamHLRZuLbXTRBGnoAeupCNsCz@nongnu.org
X-Gm-Message-State: AOJu0YzKoHVLMjptS7hnVfN7dkt4Jh+Wv+sw9I1AqbPfp6OLvppAjHi+
 VOsvaqG73sd3GzBCdoT/ByhKAF8AqhCcUeLFT4pYZcFsMfYAGRQSytoG7jXKBrs=
X-Gm-Gg: ASbGnctne1z0jRK54MjhKCbFMfPdSo3vyrlF269Caf4noLX1y8Ua9asZK6G3RylOdGs
 dRcB8xJPFRjjjWtninbtOl5+SSD0wF6GrDRko0eJ+G4zqoEHsTjOUctsxA3Axvz55fXdcjpU6lI
 RZnN/ECHe8d40WgB37AfEjreQtCfwCH12FfyOo9dzRPOcc7xJm2NrYC2dUdv9pLMO+JJDEyyVU0
 MdnJXUrxndOSjbJ4wjZ17AtI+0zg6hfBDpd/Nlhs8JPUKsLoNJbHb4M06s6JAaZLGk=
X-Google-Smtp-Source: AGHT+IGk6jyHWGkuEqUt2nikNgIYoWi02w1uOvaD7SfUIJVYOlUZ9MUpEoMHqHxXGJHFI6dagna2Qw==
X-Received: by 2002:a05:600c:3aca:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-434dded69bfmr34076075e9.24.1733508910870; 
 Fri, 06 Dec 2024 10:15:10 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da1133c3sm62876255e9.31.2024.12.06.10.14.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 10:14:54 -0800 (PST)
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
Subject: [PATCH 6/6] hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()
Date: Fri,  6 Dec 2024 19:13:52 +0100
Message-ID: <20241206181352.6836-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206181352.6836-1-philmd@linaro.org>
References: <20241206181352.6836-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
---
 include/hw/nvram/fw_cfg.h |  9 ---------
 hw/nvram/fw_cfg.c         | 23 -----------------------
 2 files changed, 32 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index fcb06f18cc3..80a1549ad05 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -312,15 +312,6 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
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
index b94cd27bd85..053db7e08cc 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -41,7 +41,6 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/loader.h"
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
@@ -1057,28 +1056,6 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
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


