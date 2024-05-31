Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2447C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8rW-0002se-W6; Fri, 31 May 2024 16:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rU-0002rk-QZ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rT-0000oa-Bl
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70222db9bf1so2281692b3a.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187305; x=1717792105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzNPC1l1l92btYoSfQnEt7eZTgNylgvzDqncd7AHrIk=;
 b=Zkrinu360iCSkUVh4oZBZernn68gkH/NcpNlRTDlQrG5q2frHPVv9fHDXumUuMbQuz
 POibMuNUWT2KCR+LTFvZ38hs+DRMW6einZTwl2DCXt+xcUsnAdgBFl9yqzqx+BN2s9g8
 JidtWV+O1XxNBjVbcbDnspO9RzG5jF8vIrT0qLMoAaQrT5KFe6XFAil1VW+ytfE40atZ
 onBlUjnat5CAnKh2pN3Iq/AxyLgzbCKdNfv4RNGTaN/1dEfLDeoS3jpZK372SJtaSHEb
 bI9MxoVy1719v/fYWCyF9QrSKVJn+Mas/Q9naEJVhl2RZ5HRW4qHTKx2eR1CySZ/Bie/
 RPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187305; x=1717792105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzNPC1l1l92btYoSfQnEt7eZTgNylgvzDqncd7AHrIk=;
 b=ZSSGs3s0RSgMSde1D1CKmmcP+Yg8rpqpyQ9I2X1HU8BbVGptDerY58eeWn/5KnD3Go
 JfWnxdVHpnUgUEF+e71t+RE303w7oCvO1LubAo9Fymt8AkotIJRkFCrauszdqoW7QHV7
 N0sKRWQ6Hk2HA/p3PE4asfU4tERYpKcwABHuOcWC4XeJ9ewjY0d4LDVMjf/okxC2M3Xz
 ZLAzDMgBxp2gqdR0lKyLqlcOQ//jiw60+lYzEH8VdF6wFn6Hc4YDUmqiAui2IOBMah2g
 7zcQESg1IoBzNACarY1bCg2Q3oJmYujBDo7Z+jq/ceAjp9OG2q6p08yfl4JTiLOG7WbH
 zAfA==
X-Gm-Message-State: AOJu0YzjUvH5y1D6+UhpZviqP/Omvs4eaD1K3B0JmXSE2qfU31lGLsw+
 7ejMsZhdRq6FmWTfliFG+MfL0W1z/+ii7cLNHYWTZOH+RPz9kELKmyc1UmZN+SIdpHF8cYJxESv
 A
X-Google-Smtp-Source: AGHT+IEvkJsylHUTAcqIZnJsJykuKdsaHEly7//hw0lFmBXY4zaNJAxdfQS77zYJgSA12KtIxZvAdw==
X-Received: by 2002:a05:6a00:4099:b0:6f8:b6a1:317d with SMTP id
 d2e1a72fcca58-702478cc5famr3201287b3a.34.1717187305420; 
 Fri, 31 May 2024 13:28:25 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:25 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 4/8] hw/riscv/virt.c: aplic DT: add 'qemu,
 aplic' to 'compatible'
Date: Fri, 31 May 2024 17:27:55 -0300
Message-ID: <20240531202759.911601-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The DT docs for riscv,aplic [1] predicts a 'qemu,aplic' enum in the
'compatible' property.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5505047945..366fe042cc 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -606,6 +606,9 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
     g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
     MachineState *ms = MACHINE(s);
+    static const char * const aplic_compat[2] = {
+        "qemu,aplic", "riscv,aplic"
+    };
 
     for (cpu = 0; cpu < num_harts; cpu++) {
         aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
@@ -613,7 +616,9 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     }
 
     qemu_fdt_add_subnode(ms->fdt, aplic_name);
-    qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
+    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
+                                  (char **)&aplic_compat,
+                                  ARRAY_SIZE(aplic_compat));
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
                           FDT_APLIC_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name,
-- 
2.45.1


