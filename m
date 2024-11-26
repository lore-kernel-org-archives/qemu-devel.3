Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC5D3B987
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtha-0000ZD-W2; Tue, 26 Nov 2024 06:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfq-0004vT-8o
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:24:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfn-00033O-PT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:24:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso19877025e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620242; x=1733225042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1K533phtUA49BKbxwAi+Y+nPI04Ofc/dicjSAgZ7ZU=;
 b=dvdaaZ5TohMDmblaYitF2ib78JY/Cpoqr22fu1Ye4gZegV/9NYV1ZqWIFxkr/tbotn
 3wNbIpJkRhZGua68n4ab+VfUNAgPb+azSzC0B+YO8CwRxoGbyUxWTrCIIhQbdi1pa1kD
 OxYQAmEz0BQT9Ve0a8o8iUpWl8Ldwglzst6XbV87AtDh5JTPi2YmucxQSjUJLtyS6uvZ
 Jt5xKFKMJ9zA0SuMys4Qp0ZYTw8XWqGfSfSiFjcjUYtSHLSxn0rQwPj5AFbpCHJ90Yl5
 m5my4UPiDsFGsPCaC6eFOnchyrTee363fZ3gsaeaZjUEdnFCjtqi/fut6Yc/hw8nc/OY
 Vp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620242; x=1733225042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1K533phtUA49BKbxwAi+Y+nPI04Ofc/dicjSAgZ7ZU=;
 b=HkhHEqMqrW4VwWjpS6WrSGRHH7faCR8kx6KtpHBAElS+HsYxh01YuYbEPd0HpNjXAu
 2w04Xap6oyb+fSkXU+575B8m5vCHRNtc93czyMGqTL8RgQHESSAz18piEJj0zVLhPSSD
 TTP6IWYfy9TvLrGzdLQ9o4OUgzdMEoCgqm8dCJz+HOQ0wL/lau+1C8H0YoTFM+BHk/IP
 mXFuPE1yt1hmqBim5LA/Kkm6bbw1bJxEsWFxhnGbamuR+9HyqF0yZJ9Q/P2vBAna9Y92
 Nr1vRcbXsHKOBxENhjpl3ROJmJ6VY4XFwYA3/IV0eYLhOGTHzelhMvbFj38rLCbxvckT
 RcOg==
X-Gm-Message-State: AOJu0Yx7a/qpATql9TzDQe3HsqKGOcIiWT1kzBeqRGlu376bw4jx4Rsu
 rC8F/4YzPbpy80snafOneqSkcRg6FJkLlgIrQJVEXRnJs6Ec+fbfRG+/a+7BEeBBJLVzcWeqYa+
 c
X-Gm-Gg: ASbGncv8EIv0I23d8lAn3G3xNZ63etXDI2QVmdtFAiWycv0yW6I2pTw3dTb8kt6WPgW
 r2aeB6Rac+1Nh4/dSZCgqcOuXYqO/5afYPMwEwtJBKv/phukeFsYZXUdrwty5TOJF3T8qhasLhR
 Xo5xoTVwUTq5dfbSljp5NQoi8l0jPhgxS7rcPD23F3yezbwcGY4torW/xGOmRONIgA9vzXTCNwD
 0oUm+JTGE8QyFPcSum8OaZtFsXmLH/7Xw5Xkrf2AWsdMMFSCcmo/qxAz7CMUoNlSfhEnmmh
X-Google-Smtp-Source: AGHT+IHP+w7KPVZqFwGD6ZQa1TaFx7h4ILbPIh23SwG6AbXHFY77A2H/DCB+w8KbnsjoKbp+aTe7IA==
X-Received: by 2002:a05:600c:3d9b:b0:434:a4a6:5212 with SMTP id
 5b1f17b1804b1-434a4a65461mr31141935e9.0.1732620241847; 
 Tue, 26 Nov 2024 03:24:01 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faff9cdsm13070159f8f.28.2024.11.26.03.24.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:24:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 13/13] hw/pci/pci: Remove legacy
 MachineClass::pci_allow_0_address flag
Date: Tue, 26 Nov 2024 12:22:12 +0100
Message-ID: <20241126112212.64524-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
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

There are no more users of MachineClass::pci_allow_0_address,
remove the field along with the machine_refuses_bar_at_addr_0()
method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h |  1 -
 hw/pci/pci.c        | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 36fbb9b59df..66fb2eddd34 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -284,7 +284,6 @@ struct MachineClass {
         no_floppy:1,
         no_cdrom:1,
         no_sdcard:1,
-        pci_allow_0_address:1,
         legacy_fw_cfg_order:1;
     bool is_default;
     const char *default_machine_opts;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 889821f64c0..20362da7b89 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -45,7 +45,6 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/hotplug.h"
-#include "hw/boards.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
@@ -520,13 +519,6 @@ bool pci_bus_bypass_iommu(PCIBus *bus)
     return host_bridge->bypass_iommu;
 }
 
-static bool machine_refuses_bar_at_addr_0(void)
-{
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-
-    return !mc->pci_allow_0_address;
-}
-
 static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
                                        MemoryRegion *mem, MemoryRegion *io,
                                        uint8_t devfn_min,
@@ -538,7 +530,7 @@ static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
     bus->address_space_mem = mem;
     bus->address_space_io = io;
     bus->flags |= PCI_BUS_IS_ROOT;
-    if (bar_at_addr_0_refused && machine_refuses_bar_at_addr_0()) {
+    if (bar_at_addr_0_refused) {
         bus->flags |= PCI_BUS_BAR_AT_ADDR0_REFUSED;
     }
 
-- 
2.45.2


