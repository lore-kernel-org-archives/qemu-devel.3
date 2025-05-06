Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E2AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJR1-00029b-M0; Tue, 06 May 2025 10:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPP-0008Ss-AO
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPN-00018k-ER
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso6173832f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542191; x=1747146991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihC29KJK2kV6HuZmrEMz/ndVgqfnic8/f3HiKbbLAOs=;
 b=iteMyvcqOfz2lOUoBpUvgD9wq1QH59Hkzb46uovdfSNE4xCQL343aoyRT4i5G2BA2X
 f+cncX/Irxg3vXroDPHxyvt9OWPegRM4brsz9BlqMuN1DAVXyy0Bw7WxcefH2Pkyfu06
 gUEhJbrKKScZ18NYEXRcAcG+G3DgmzBqnZsyfxlN52vZBlxtu9sLLEwLzlYInKpZxnP8
 Z6hWMjg/tT1Yn+E2p3GaLOvTMaqKaUXiw+yTHI0F5DKJ2mYtIkVDUNVI2YAM4plNBANp
 cQV2w/MM87Xva3QY1NmdaRUyZV9ha1cjZmQdUo1X10Djty9I++4hQvsNE7Azk11hnwqQ
 /01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542192; x=1747146992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihC29KJK2kV6HuZmrEMz/ndVgqfnic8/f3HiKbbLAOs=;
 b=oWCU1hQxkFq71NrgolWsEyt0OKyVaWGCEf2a42/pgH2Cpr6VBvgkgVb3AAhQqKRbwd
 nxp8VZaCmRW0EnXK4SlPyGoBbLWbbkHryGLne07KIpNmwYie8lu5BTVhCrGfpXhKA9Fg
 fx2HlnDAZbsh+GCqddpMrSiVozz8InvtL/xhBUpFWdbrtRMMBgSY2aHFSpVqyEHIZRz/
 CnngMBplVB84WjsYu+fZrzjcJsCmpB6JvZ4ay8k+LJxDZCzGe+LqGX0Cj5klkLENj95i
 dP8yVrbQgAEr5adUdh19ZEPNUL+DMP1EfyoKUy/cKCtPMfbO0oFRVTNzN245yfS9Ynek
 NbZg==
X-Gm-Message-State: AOJu0Yw55nIq6Bw4xsqMdAim5kHchq3PQwjjrfxIqIu2G1VSjsdnz+Ec
 n/cK3svI+YLfMArRU2rmF3hqQKWQ1Lu+y7m89QARoBZnFZ7/wblargHatCrd59ZwXO1eBH8hEdP
 w
X-Gm-Gg: ASbGncu0sBeXQW+qcYDI/K9yD70XUKB6KSpUq/6PtQ1rNXEbktqsLty2YY8BIB2ICmO
 FuMBML8+6ivnfijTpGBifGlyE63dplA+UYbVo7TYw6CmnrTmnA7Rv+XJj/rt/Gwl3vYiDxdHtdb
 tSW5jDOa119WRY3BfBrJGIo2wSobcmsMk3smkjv0w5SLRJ87tu7JDVgGYz3cuJgr3acLzgWiUNk
 eg3bpCTKgCq9r85f7QkFyTts+vfw5jr1FpevZFtik/Np8+0AA5XqpVrNQkFHXQt/gOX0VLxmgLA
 wEK8Om9NNamFjCydlgmOH9YejGS2dpXsgcZoH3DIoTH8i52l/W9ZjGsTLCK1YzlQuLNe+6invX2
 vxtxsbYTlFIkmRhpy9hil
X-Google-Smtp-Source: AGHT+IHohNm10sFWt/dfO5D0SNek2cPk+iqHjeVDVjJW9UtncttZwWPKctDW/WOuKuECc3PNMZOWWA==
X-Received: by 2002:a5d:584d:0:b0:3a0:7fd4:2848 with SMTP id
 ffacd0b85a97d-3a0ac3eb15bmr2946336f8f.52.1746542191668; 
 Tue, 06 May 2025 07:36:31 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3ccdsm14030191f8f.38.2025.05.06.07.36.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/22] hw/pci/pcie_port: Fix pcie_slot_is_hotpluggbale_bus typo
Date: Tue,  6 May 2025 16:35:05 +0200
Message-ID: <20250506143512.4315-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250428102628.378046-2-eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pcie_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 54f639e3d4f..f3841a26568 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -188,7 +188,7 @@ int pcie_count_ds_ports(PCIBus *bus)
     return dsp_count;
 }
 
-static bool pcie_slot_is_hotpluggbale_bus(HotplugHandler *plug_handler,
+static bool pcie_slot_is_hotpluggable_bus(HotplugHandler *plug_handler,
                                           BusState *bus)
 {
     PCIESlot *s = PCIE_SLOT(bus->parent);
@@ -221,7 +221,7 @@ static void pcie_slot_class_init(ObjectClass *oc, const void *data)
     hc->plug = pcie_cap_slot_plug_cb;
     hc->unplug = pcie_cap_slot_unplug_cb;
     hc->unplug_request = pcie_cap_slot_unplug_request_cb;
-    hc->is_hotpluggable_bus = pcie_slot_is_hotpluggbale_bus;
+    hc->is_hotpluggable_bus = pcie_slot_is_hotpluggable_bus;
 }
 
 static const TypeInfo pcie_slot_type_info = {
-- 
2.47.1


