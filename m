Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63146D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg4f-0005je-C8; Wed, 03 Dec 2025 01:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4W-0005Si-UZ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:10:43 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg4P-000126-NU
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:10:38 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42e2e2eccd2so2390257f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764742227; x=1765347027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVXB3iRjkS/JqWijITJpgknPo95A88NyGKC2Fvc8rOY=;
 b=d7gmmpL8KutWywFMZBw+T1uxQfOvoPExh5YzzW49dNyb/QVRyZrjeu+hGRmxnqACSb
 zyhabj/VE6unwwkv3vyc+vWtp9BFxUwPlLx+qDliyDI5A4947J0PsqaCnOSw6EXIDk1M
 hJGPYRVG6nMjAtVZmdA4I3kaAJSjH43ycUFyY0V1LPxd3qQur7d8RIxYceNxSDYiEuUB
 6mmozPyutCsgOqmnI5Oo1lNwskDI8EEcmoJefsmFDXqgT8C26e/DZfKTEiPl2J5XgdDi
 c20a2DTTSThqfUg+DumpWZHldL5rhlVe3UozRgBw0aX/vdNiVecO8puJou9rsqHXQAnw
 Sv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742227; x=1765347027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JVXB3iRjkS/JqWijITJpgknPo95A88NyGKC2Fvc8rOY=;
 b=J3q5GdV3D4ypCW0d6cNJdb3sai2xx4vbLmytUk6XGBhFPVPITkUhKyCcQJ+JU+k3b+
 itrWmiL7+fji4ZRhtBA6G67dtV0Fwa18KEx0rTBDmfEYKSy93ylGhaDtEnkaMHw2s5p2
 BbniMfisr/5e6fzAISRFCQAGGAOSvaVncAbeLVhBgWpIy0G5RduzYwi69gOF7go0bLd7
 xloVX+Lfnf9tL0V5jmqKZ8lHD9NpnzHW4bIBFiFxfDOOrRfxMDcnbwK/e+26cXdsy4my
 o9JTr6D6L4EHgfLK7o/VquCycdxsyePUblrDKzqHdVcRMVV6VgzSPL8owRWHjifhkpNU
 PY/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzVY5Vvft27Evs/KU/wC5zAHH7xFfpJJgAYaYzXbsrXIrMxaDy6aW1wPQDSVHQlx3A9pgxEGZZv024@nongnu.org
X-Gm-Message-State: AOJu0YzK8N5W5TXv3q+NpYyiO2tXcppEjr3oy/fOZoRwbwClIzXgQstm
 RHl+IdsXQLKJsHEXlLv5oI7RQI4sBro+Q4gyiqdRqguk1rbuHhF8abFReiCOoPvDGD7N4KPE36W
 uYlf0UwM=
X-Gm-Gg: ASbGnctYnkCUOMjrmmQeE9WZKEgbvzGyNcz9plnomlcHT3y6tW8q+51xJCbakdjgf1J
 /UTAK0hmO2PV8PVR+hpWfW4z/RbkZ+1sJlx8NgQPD+dSgiYyrV9h/YcsvExiDcFw8tG67Dey/3d
 X4SUP04eH6jtCU2GHpXtyUEjM6EuwIfx32TmynztC3ANU6jgXI4Wdb6X4hkvhjRBYBa15LcOZY+
 TmABG5x1a7oLEVEWN+qYS8v3DFdGWApln4ZQATL625t50HYkg6Q9HJDSLtLtp8UXGBr/bbRM2lY
 s2Edi95ON3C5ZygoYT39DrNc9gsqF3wjKo4ydInNfP1vXcb7lrwasOgv6QlXhX4YyyUAJ/oS5Tq
 Gjp+lHg3B05kbA+nghFQfW1+IPwZLwREvZBPycqD8o2tRtIyaCPUFNHQuMqkQtHbz8mshnnELLE
 11KxM9zd4UlXCgZx0Jl6ms9zVNLIYP6BpBDM1pYpK6W5GSN6w0oAZQTktplT58
X-Google-Smtp-Source: AGHT+IHwBGOUJJmGg47LMcX4Itx+dFea8UbTf5C3SnGsCjzHfNNw9xAGFgYsn7layyaV9ofxhYknRg==
X-Received: by 2002:a05:6000:2504:b0:42b:4177:7135 with SMTP id
 ffacd0b85a97d-42f731a2fc1mr770032f8f.41.1764742227111; 
 Tue, 02 Dec 2025 22:10:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3c8csm44612355f8f.2.2025.12.02.22.10.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 22:10:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH-for-11.0 v6 06/13] hw/nvram/fw_cfg: Factor
 fw_cfg_init_io_internal() out
Date: Wed,  3 Dec 2025 07:09:34 +0100
Message-ID: <20251203060942.57851-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203060942.57851-1-philmd@linaro.org>
References: <20251203060942.57851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Factor fw_cfg_init_io_internal() out of fw_cfg_init_io_dma().
In fw_cfg_init_io_dma(), assert DMA arguments are provided.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/fw_cfg.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 34d7d107678..2699e593860 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1019,8 +1019,9 @@ static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
     qemu_add_machine_init_done_notifier(&s->machine_ready);
 }
 
-FWCfgState *fw_cfg_init_io_dma(MemoryRegion *iomem, uint32_t iobase,
-                               uint32_t dma_iobase, AddressSpace *dma_as)
+static FWCfgState *fw_cfg_init_io_internal(MemoryRegion *iomem,
+                                           uint32_t iobase, uint32_t dma_iobase,
+                                           AddressSpace *dma_as)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
@@ -1053,6 +1054,13 @@ FWCfgState *fw_cfg_init_io_dma(MemoryRegion *iomem, uint32_t iobase,
     return s;
 }
 
+FWCfgState *fw_cfg_init_io_dma(MemoryRegion *iomem, uint32_t iobase,
+                               uint32_t dma_iobase, AddressSpace *dma_as)
+{
+    assert(dma_iobase);
+    return fw_cfg_init_io_internal(iomem, iobase, dma_iobase, dma_as);
+}
+
 static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
                                             hwaddr data_addr, uint32_t data_width,
                                             hwaddr dma_addr, AddressSpace *dma_as)
-- 
2.51.0


