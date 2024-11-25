Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39E3D58D4D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZkW-0003bC-0O; Mon, 25 Nov 2024 09:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZkP-0003Yf-T2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:07:29 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZkN-0006pI-De
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:07:29 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ffbfee94d7so11542021fa.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543645; x=1733148445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhPIY1VBzTRWV9NVUC530URyYQIaOfJGukKvr94mbQc=;
 b=KTVO1eLkQUjYC709Nr3k+IqVD5ayywzIL0QgrkyJ/tl8nMd0z651yzXC4rTW0miucx
 NPhWW6WfINbBe9C3YyK3IPVPOdhjsldLeFl8F9w/fwu/e8xsrmfKw9maWPXH8qqkNSLc
 +xLWUe2Hq4XwwofJpLZoB+yB2wjgYmjxpjdYBZxtkWNmZ/48l62+fiLWmnQr42NU3fJx
 rGFWSJ0fbOEpDNmvCA6r6oiCy/XsNgxWh5+2YswGCy9JN/aQG+N9GoEOzxTWd3Pk3qlH
 wsxAbrra4/2Gox90Q/+p4HHgXiOW81DWeNcRI+p/xN3nA+bFYm0lqWMsA8nsQ5tcziBh
 I7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543645; x=1733148445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhPIY1VBzTRWV9NVUC530URyYQIaOfJGukKvr94mbQc=;
 b=SsV4zaQYTdeNUB+PZdfNVPI0Vpm4SRs1/zv4CVU/az8nkrL32sknvj1qw/zs6pi0JH
 KwcXa24vLirG+64t20g6HmBveXPQ5K1IMx2rEgTW9Xiy3rx7+TEgXCqWsedVs7cSzZT+
 jDtpE83ackaaGBWrIsLM8WLBuntbCfxa7aeKFxKi4jaT2kB4aM1oslv7bAbB6XhY7gsc
 wsrTAzqxTBhwRvTq/mVJes33lENCtx0b87yUNlYwJxpJN1X8z5c6EMESRLSetk5vt+j1
 0yT5gYVf9ZUFySKjhKt/8gDmQ2m1utbrosaKPXVb9i2y4utr+7h5dbGt+pfLfnEjz+o+
 1EVw==
X-Gm-Message-State: AOJu0YzanlioKNBohY3Tsx3hul4rGSpYPex0E4JCxlstWuzUiB46mKE2
 mKeUGb/qHXyjkvT/GwMQ7jzeBqOKQLnK3s6BE89Kd5vWPrEDy70JjFPJibSXzXd2Ut/MijNumYI
 G
X-Gm-Gg: ASbGncvQnMPpm45OMSfrHkY5M0Zq3CwNnbkTJqTkgT0hZ1ifCJYDKIN2pQ1Js25mUQ1
 zu5I4lsCkTeI5ONbte+brOvo19zsZBGS7W19rEAoa139vQ8PBQw80bbri3gjaSC9cOOZMpZ6p6s
 D+Z7tY6ALeVzKi0Ng8tFcc+u+9tTJ6pF0oNZlKXIT4xILdQKaPiq+DHr5WnJztX6PRV/Y3W7cLM
 pyURzbF+3L0Zcg7qyPM08H9Rsb0z3AwCXHDtbGeg0/eUTzjIWVB/UKoOPPrxpRrrO23XBEG
X-Google-Smtp-Source: AGHT+IEbf0beO52iSpVocxIGp0kqvDpasec8DZVORrD5VJMHU1FsQgCTWd+2Zd9KjuUFZexnRUtDug==
X-Received: by 2002:a2e:a546:0:b0:2fb:5a19:5b9b with SMTP id
 38308e7fff4ca-2ffa70f08a3mr71798411fa.8.1732543644987; 
 Mon, 25 Nov 2024 06:07:24 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432f642f15esm210421055e9.0.2024.11.25.06.07.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 06:07:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 8/8] hw/pci/pci: Remove legacy
 MachineClass::pci_allow_0_address flag
Date: Mon, 25 Nov 2024 15:05:35 +0100
Message-ID: <20241125140535.4526-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125140535.4526-1-philmd@linaro.org>
References: <20241125140535.4526-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

All users of this flag now set the PCI_BUS_IO_ADDR0_ALLOWED
PCIBusFlags. Since there are no more users, remove the field
in MachineClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 1 -
 hw/pci/pci.c        | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 36fbb9b59d..66fb2eddd3 100644
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
index de3f93646f..d27166dd75 100644
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
@@ -1472,10 +1471,8 @@ pcibus_t pci_bar_address(PCIDevice *d,
 {
     pcibus_t new_addr, last_addr;
     uint16_t cmd = pci_get_word(d->config + PCI_COMMAND);
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    bool allow_0_address = mc->pci_allow_0_address;
+    bool allow_0_address = pci_bus_allows_io_addr0_access(pci_get_bus(d));
 
-    allow_0_address |= pci_bus_allows_io_addr0_access(pci_get_bus(d));
     if (type & PCI_BASE_ADDRESS_SPACE_IO) {
         if (!(cmd & PCI_COMMAND_IO)) {
             return PCI_BAR_UNMAPPED;
-- 
2.45.2


