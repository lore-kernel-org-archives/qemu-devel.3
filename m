Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32409D12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg3s-00051G-Cq; Wed, 03 Dec 2025 01:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg3p-0004x6-26
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:09:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg3l-0000jr-1l
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:09:56 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so3486115e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764742191; x=1765346991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5u32GnbEayk/ZbK+2L0211NCDKiKLwsWPQOA+q6KCV0=;
 b=laPKl4Byok+7fWqWUDJw8klpigyHUq/Pis6DkZkPC7LWDMnj4wlehb3elNXk6k7qVm
 xh3xa8PPD4Z2iv8Pv8JHyVw7Md7lzxSXsGU70lcXKMssm9oYa1te+kphuEoS2V4tMelW
 j/1kXjRIGEzLM0eMESHrEMbal8aqLHtA0wqiqz/n4jffFu9zFu/c/U2VxGmtoMcnMDSr
 58DzftISku2STLhn9dgympXtZ64oYUEx69hvgfDHZ7Wg8Q4Le2VPbQAkcL0M2X51DVFC
 SJCgnbqzSO/iT/LEKgioKZWxcXLJAsx4evnw5GlfvxC9ZJtgIlsoGdJWHq/pDvaNlRif
 QyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742191; x=1765346991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5u32GnbEayk/ZbK+2L0211NCDKiKLwsWPQOA+q6KCV0=;
 b=xKyLfJOvjOPeE2rVxtTa41CViYC7RQbvLTdxVHG8+nUJoNPCroGzoIXMaHOHyVR27Y
 lFjZLQN8bgchFo2XCCcHwnG9uj9nMU4LTBptDQpmrjY0PE+e2ungtpZoMvaMOF0hMKtS
 nQkh0EEVFuAJET3HzV6P9R2qpzMljgH+9yB5/ADugL16huzVtskvqskPjEnu2Xidic2l
 ioqmaZ3WZeaFesrScT08oCpojEIRl8CZirCrxNDOW40cqvtV3NuG7/HRv2DKCSAvt7AV
 Die1g7J/tU+rRnJIeNoiSxXFIV7mrwWQSSLcFwFaaiuXkBsrzvZ9IqWyIOremLCdf7Ec
 mWjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJSVz73fQA7/HZlLYDvuBqsVlsNEXqkTmyRBgzeVqcGB+BAL5dPPZ/9dYKYjnssrJKVr03IlCLAOiQ@nongnu.org
X-Gm-Message-State: AOJu0YyoCR8Fy8o2KHuYGdgQJ+zAT2SsabEwodrr8oClMtxAdbCEQHi4
 00xkLu0jptkaB3mnNd9/PQxvF2irr18/CFOCobsxWu1D3r+oq857ucP1gHUXC2mv5Ag=
X-Gm-Gg: ASbGnctdgEQwkf3DG3CGw1tOCPLJ4hCKOCY91wL5xu+6Au4Udgmbk8vHjMAYeJOKEMM
 1XFJIEFbHs3i0xUMM9B8NlQOllWLfn9qbt0ALgXZGCdQonRqovrqnFpOwBhYr+Dw1+zRM+79ocm
 5DkzgdLYzap8RlO+sg0d8mTWmq4cqk2CngkejFAVOcknDx+olPBVz5lWDhC+5BggvFSoWhacrjR
 yM406as1zQHCP+obKcFu8hJ83cQGj857Z1vujatcoe0XNGu3On6iOVL+htPwD3WgUP/ZvJ7IuA1
 jcjQcKSrsZPYgOw5xWVV4hd4+6JDL1Tqh90g/8iuv3CHlvNF+hW4Xr3oK53DFV5yXQ6wfELhbOv
 ZAeympafxV97/umBVZatB2Bn2TzZB9/jIe8fLRarcfSf2IjrxQoPIuz2WM0j6GVHT+WF1ctyxJt
 Wa4ja386uaULkLdpdExTslh4+UnbUWVMmiJixMdlWjUoaNc3Y2j6jXEHN4l/K1
X-Google-Smtp-Source: AGHT+IHyqzLifzMM5fV6KNGaF2zmFaEUl4habTG48tM4Bpx8cOpFrQ0UprGIJBJm2fslY5abnS9CRw==
X-Received: by 2002:a05:600c:470c:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-4792aee0404mr9789495e9.1.1764742191145; 
 Tue, 02 Dec 2025 22:09:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a79dd0esm27638635e9.4.2025.12.02.22.09.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 22:09:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 v6 01/13] hw/ppc/mac: Use fw_cfg_init_mem_nodma()
Date: Wed,  3 Dec 2025 07:09:29 +0100
Message-ID: <20251203060942.57851-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203060942.57851-1-philmd@linaro.org>
References: <20251203060942.57851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Use fw_cfg_init_mem_nodma() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mac_newworld.c | 11 +----------
 hw/ppc/mac_oldworld.c | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 951de4bae4b..89cd1ed0311 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -453,16 +453,7 @@ static void ppc_core99_init(MachineState *machine)
     pmac_format_nvram_partition(nvr, MACIO_NVRAM_SIZE);
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_new(TYPE_FW_CFG_MEM);
-    fw_cfg = FW_CFG(dev);
-    qdev_prop_set_uint32(dev, "data_width", 1);
-    qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(machine), TYPE_FW_CFG, OBJECT(fw_cfg));
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_mmio_map(s, 0, CFG_ADDR);
-    sysbus_mmio_map(s, 1, CFG_ADDR + 2);
-
+    fw_cfg = fw_cfg_init_mem_nodma(CFG_ADDR, CFG_ADDR + 2, 1);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index cd2bb46442f..25fb8ed070d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -294,16 +294,7 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* No PCI init: the BIOS will do it */
 
-    dev = qdev_new(TYPE_FW_CFG_MEM);
-    fw_cfg = FW_CFG(dev);
-    qdev_prop_set_uint32(dev, "data_width", 1);
-    qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(machine), TYPE_FW_CFG, OBJECT(fw_cfg));
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_mmio_map(s, 0, CFG_ADDR);
-    sysbus_mmio_map(s, 1, CFG_ADDR + 2);
-
+    fw_cfg = fw_cfg_init_mem_nodma(CFG_ADDR, CFG_ADDR + 2, 1);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
-- 
2.51.0


