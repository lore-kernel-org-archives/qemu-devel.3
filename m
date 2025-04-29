Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E0CC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kXj-0002Sf-QH; Tue, 29 Apr 2025 08:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXi-0002Rj-0A
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:34 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXg-0000A0-Db
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:33 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so5384191b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745931510; x=1746536310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Po6sO0gMdcjpyAu8oFiuPraREHUM/ABLiVfLZFw/jCY=;
 b=ksYVRDK4OAhixMVmAY9zKhbEAr/7YHRd04fXBhGQVOj+khNwpD2wFOnfd6GMIeKLmr
 6Bay/lFmZoComI7uBREUmiP9Ig4LmLjNhyAXcG7B80VliGBnBHQdrl9jG1/QfBtenVNR
 1RnJpF8DqV5qdLWPscVi1iO+x43PgZOViqa2af+bF/gYh0AMZIALZEcod7X3PhEUPcbS
 m7tCDGIcxwpheUHCpyPUINmf7CKvyGxUXMJcwwmfCn4yLlSgYSR3JS/uVj8oT42DZRmG
 hPcEa2y7Az1xotmwvwG6c0X1k6MXrv7WXovYiOt3gUqyUCHa46JcCxU2XhidyZdRYce3
 lrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931510; x=1746536310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Po6sO0gMdcjpyAu8oFiuPraREHUM/ABLiVfLZFw/jCY=;
 b=T4X1xQW5WJMfDZBHEL3d5jAXNwMavMFzstZrqAazLmrM3Le5oEWBXsDgPl0aE6q0SS
 QKwyM91o4mzLLGnDvEjhl9gMOOjYdRrVot4nsB/iSmfXXMAZ5RKm7+x4EweCKpbTehhK
 gJIA3dBOs92+LsexCGgrtjSsmfumGVMZk9kt9zpmmdsjNfoXUHmaCWohY+Xuxvsg98hz
 faZjCrhyxRqqL/VX3HzXqaAOJ8gWDBASmWY9JiHbxdqKm3dFxxESbSFjQMrjymR2+SYK
 1kHdILyAnXPoBa+82J8vUU0O0JdIgi8TiDcISfDZxqHJKicWOxdTjh53XdGDWw3vjRTj
 Jk0A==
X-Gm-Message-State: AOJu0YztGHC+DEBctNDEG6a1AnHk/nN01tAw3mGPmC+rbZ4ZY6mrX0QA
 I/M9TChyQF2i2RthdaUZ0jUODEgw2Rhx3a5C2bC/PNHe28JJk7eJZaVXfmGPjeqDKXkViIVzTzY
 U
X-Gm-Gg: ASbGncs5/31EUfxN5Ic0m+gmeErh4pa5ZzGQI7yAubU1mdce2eRXoc5XYSre5blgbvS
 CoT1xosnMbcDDuY25CwaQCX2v2unIFIPGtQD9RmGkDvOl2Xhtq5/YMBzg+RRZfpXBocTYtc6SnM
 MgklZzvjkf30vI16DQk0qoRv7IPXhyFXA6x8COxfbT00RX8m2qXmlNXcplGxaltOEB+SOnCw/a2
 TQVJqk6ogpH985McBoyZhCnRU4aNq51uvytPVTcC7PJjv2peRuAObtAVQFfZbQKdiCgtNj6GYVj
 sKFhmB/nV1RcIO9HP7CIwq8G5WkEdWcvu/MoDDYMknA=
X-Google-Smtp-Source: AGHT+IEySsDH+ilLLr16GfMw06miBjyLp5gAEg7hyplSVqPyKfi5TzvbhsnJg84x9EmTkUBisAuPbQ==
X-Received: by 2002:a05:6a00:2403:b0:736:34a2:8a20 with SMTP id
 d2e1a72fcca58-73ff7396a96mr18565364b3a.21.1745931509756; 
 Tue, 29 Apr 2025 05:58:29 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7fb7e54sm8889440a12.30.2025.04.29.05.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:58:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, joel@jms.id.au,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/9] hw/riscv/virt.c: add 'base' arg in create_fw_cfg()
Date: Tue, 29 Apr 2025 09:58:06 -0300
Message-ID: <20250429125811.224803-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429125811.224803-1-dbarboza@ventanamicro.com>
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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

The function can receive the value via s->memmap[VIRT_FW_CFG].base from
the caller, avoiding the use of virt_memmap.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f324777161..37f8abdd1c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1261,9 +1261,8 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     return dev;
 }
 
-static FWCfgState *create_fw_cfg(const MachineState *ms)
+static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
-    hwaddr base = virt_memmap[VIRT_FW_CFG].base;
     FWCfgState *fw_cfg;
 
     fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
@@ -1681,7 +1680,7 @@ static void virt_machine_init(MachineState *machine)
      * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
      * device tree cannot be altered and we get FDT_ERR_NOSPACE.
      */
-    s->fw_cfg = create_fw_cfg(machine);
+    s->fw_cfg = create_fw_cfg(machine, s->memmap[VIRT_FW_CFG].base);
     rom_set_fw(s->fw_cfg);
 
     /* SiFive Test MMIO device */
-- 
2.49.0


