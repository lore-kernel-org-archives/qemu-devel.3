Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1574DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6v8-0007oa-Aw; Wed, 15 Jan 2025 12:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6v5-0007lz-VD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6v3-0006ci-KB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so71884635e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961064; x=1737565864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pa1qCoN+HFadRplHhWS5olMOGiE0VGbusTWsCAk4+KA=;
 b=HctiuCNckYM0/rmBwP5kYRJydkDSY8Db61NzhG0iebv4PUzmcyk2YooA+wHsf3K/Y4
 WrIxHQ6BCddHYimGq/pZGXTw7WfGpQSj3ef4/VxiC3NaygKmfS0m8dfxPXz3qKkeJweM
 1f4aWOqpZm3qfSs6sU2cn0FjVz4Zcdacvj3Y+hoa5Hvr3EPsa/xpFIOSMhrbfJZE0V4N
 AxtUHR8sN3AIp4d9lS5Z8m329fD0dJcbJUxJHejcOYFxaUsR1UWIVlaQk4zVxkqPfneL
 pQ746uNSxDqXGsebIdQESo06rkuZvlDi4csvbkzHbMTpVw+3VsikNxYY3NHLp/0p2o83
 57GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961064; x=1737565864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pa1qCoN+HFadRplHhWS5olMOGiE0VGbusTWsCAk4+KA=;
 b=MmWUm5qGjcUzT4b/H6EPx1pUSPHF3b3lxmG82K6Q5XLbMdSBPqKjkIrSjUx94imLaj
 xgsEn2bbw/rBY0IGAtxvSchXWCme1NJUH0uMnsF7z6uBl17kY6nA1DYxmRHkI3umKHe7
 EXDFykUTa4wrFrDwy2BWT9j7w08zT6G8C9MP6zOjjL5Z78FDka0epwN6qNhrVnzyOzOr
 G3sEkTU/AFUB9Uh/eVb+FexllYh5sorR4HBnzuefOkbswGcBXQeTRYR8ANko0sbw6FlW
 mubJpKN97IXlq7lPufbfxpyFCQASs2pkvSLbZ3/3Cxb3ZCoAkkOrBybioatE4wsjn0dY
 cNpQ==
X-Gm-Message-State: AOJu0Ywk+wuxuZ6hZ+oxfiRTuSQM4JvDQ53vXisWkyNphn7p0anWHCmg
 d+nXA+clw1oMGU/ky/WAIfh0XALx9FKYMEqoET60l9Dg2SgEyPPLoJYcCfBwfyGO8dm8Q7JPa1n
 yOd4=
X-Gm-Gg: ASbGnctiJK/nLzz+8VY7V5wwXfsKIqiU3WTxgj5baFCOYfhlDw6z5mlmqkLq19uefAa
 +75TIV58tUFVxWqy7Z0KneUVuX81DUVU9iaHAGTje6Q/OUHw6b/qBMcGrEKPo2zfHOSQ470bzoo
 qEetGO1ctelcUuhqLL2povDVYVeKk5rVUZNBtQCRHsgVzJwsVVGBXLxMgo67uunAtYNBlC0o/d1
 tkJAGUihZFursuQzptLZrq6vDoHWNj8IF6DMCgZv+o79Prct/GD+5dwe0NymVNdEkrWHV38+Yun
 eaZWcts7Rsa6rJU+qBkEANQZOZL8K+NIWwAj
X-Google-Smtp-Source: AGHT+IF3giBnmvgmdm9NPZ5PYYTESIR2khg8IQrYyCoPVH9dVMyJd+oLeKLgX93aeb5GfVSK1LOohg==
X-Received: by 2002:a05:600c:4704:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-436e267f796mr222655705e9.1.1736961063756; 
 Wed, 15 Jan 2025 09:11:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74f9ccasm29530045e9.39.2025.01.15.09.11.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:11:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/13] hw/arm/virt: Remove
 VirtMachineClass::smbios_old_sys_ver field
Date: Wed, 15 Jan 2025 18:10:07 +0100
Message-ID: <20250115171009.19302-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The VirtMachineClass::smbios_old_sys_ver field was
only used by virt-2.11 machine, which got removed.
Remove it and simplify virt_build_smbios().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9c531e28d04..b2cc012a402 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -118,7 +118,6 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
-    bool smbios_old_sys_ver;
     bool no_highmem_compact;
     bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ae331df9349..08117b396a6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1688,7 +1688,6 @@ static void virt_build_smbios(VirtMachineState *vms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(vms);
     MachineState *ms = MACHINE(vms);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area mem_array;
@@ -1698,8 +1697,7 @@ static void virt_build_smbios(VirtMachineState *vms)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product,
-                        vmc->smbios_old_sys_ver ? "1.0" : mc->name);
+    smbios_set_defaults("QEMU", product, mc->name);
 
     /* build the array of physical mem area from base_memmap */
     mem_array.address = vms->memmap[VIRT_MEM].base;
-- 
2.47.1


