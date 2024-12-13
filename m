Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EEFE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF97-0003sZ-83; Fri, 13 Dec 2024 18:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8b-0003S5-Da
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8X-00033u-Nl
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso23437715e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132715; x=1734737515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyF+LNHtlBE2DVWP1MmQDXLiaOmadwbdYe33WN2RQTU=;
 b=h9UD0YnXfy6POzFYps8+i/+hKyKoBkRiWt8u9jQRbg7gmzhw8m54HpCarEmSvjjnML
 Ri11zb6yrm2j3QbcIeSsd6AX3C24s0Ek8d9O9xRHN4baOqhWnbz0wBgmIMVDbMWkdaFc
 Wr1GDEAUiuoltFdoqaY/448HxmguR/wTTUcAjaDK6jILMLH2uwJElXszFebz7XG8S+rR
 bkoN0nC/V/dBjQJjJSwgtAq8pxKRYO3IN5x5TXT6L5aOKtG0mUgVEEfLXDJM1Jlp+Ule
 DpoHHT7hs6pwxTX3PzRDt/cvkwh3lVgiOpu5bxgXJF3TzCzJ860qVDNS9tZ2h+tib3+8
 86Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132715; x=1734737515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YyF+LNHtlBE2DVWP1MmQDXLiaOmadwbdYe33WN2RQTU=;
 b=pQ7fwmxUdFCIqS516+PBMBC9I2NE8RyzaWVg3/HAsKLBlmO4mAL0AkeMITtYWHSY/N
 cYRCLu9GgdOZ9GwU8A6eOsI4r1V+RLi3UO3T4IQRK9QDAVQv+supy0EZDWtu25/l3DmR
 dEkVpHX3MK83L+M/3RxH5FEthdzZujkWyNMOyDkRYqj2u0M182E4IINzxmVHn9/W11T8
 +GQbw4XJHM7Ev/lbDuRG84UQuLw43wlidYBNyRQVfZiTF39FxXwxsTNA4gSzEu6+9rMB
 f1rRwTToxdJu7nBjh/OiSk0AP49DMD6EhVIzrRK3HB769bTybyuoSdy2Hzb7E0XkACnu
 d/0w==
X-Gm-Message-State: AOJu0Yz2wehmugqfAZJ8u1yCcoeR0N2mGSStd8VuJflB/XQkkALtJnD6
 BrWLIIz2F0dbqiZcZIWypMtj1VZsF9PlGyihzHBZsHV4La7sa3h1m6NdDeY/6m1pW0cgIoFdESR
 1ysE=
X-Gm-Gg: ASbGncu7baZvp0tO/PjrimyNIsGgnObVHAdG2FocKxpQCN9lhC9KED8f5zAjy9cIREf
 omMc6FYXYVRfNd6SbfBcwNXCMvFbUL3oxtQ3dfvNx/GTpBD7I19sn5RGAfkbYe76eqeEyXqv5np
 Io5t79EGbC9hYLP0KENUMPPwrp6XyBRZNfHw8StWCP23JBxzOpe84xD+a3e2LRSd/KiI/olBA1A
 5e2Zdd7X4MPyWSB1qGZ90+lay5TRTcAOqwl6XolvcHqtdVjQg1sc2xKrJmlQMhfqdDOjC2ajBOV
 dPUZ/w==
X-Google-Smtp-Source: AGHT+IGgKLF4CnuvMYkOzPZjjzPwMGV82HNY9yccmp6vJc4HwqQS2BoXSg98A2w79OvAL1Q9gwDJNA==
X-Received: by 2002:a5d:6da4:0:b0:385:df73:2f18 with SMTP id
 ffacd0b85a97d-3888e0c163amr3216961f8f.51.1734132714965; 
 Fri, 13 Dec 2024 15:31:54 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361ec75410sm78729495e9.1.2024.12.13.15.31.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/20] hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()
Date: Sat, 14 Dec 2024 00:30:46 +0100
Message-ID: <20241213233055.39574-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-Id: <20241206181352.6836-7-philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h |  9 ---------
 hw/nvram/fw_cfg.c         | 23 -----------------------
 2 files changed, 32 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 6089681f421..c60361dc9ee 100644
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
index 46c62c8f09e..97def3a88b8 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -41,7 +41,6 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/loader.h"
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
@@ -1058,28 +1057,6 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
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


