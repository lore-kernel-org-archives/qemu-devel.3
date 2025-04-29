Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985EFC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kXs-0002Ut-RB; Tue, 29 Apr 2025 08:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXq-0002UF-U8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXo-0000Bz-Nz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so86458095ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745931519; x=1746536319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Il7Z60D0Ge6+rnPqyqzpsxFlQSgSW8tUZpdULtIHcG8=;
 b=NUEF/377v3tWAQHnEeCJi2RLNysB6GbgbwclYbzvGZnn+a18iMDd2639Lyl1RtjOtw
 +khTdKXMN8XPrTelZcDm9sfhS+rMm2CKg0ahdDYxU6J5v80lHg9zDH2ylWtAlQ3mM4fJ
 xD+0D6rFeZk7ObJuFG8vyZv7Q9rlDyKaZ8WlNm4dyZUI8xSHO5bpo2vc61aBF2iwrzS4
 fqGxqUi6Y4ECDIExbqtTBWmx4Tej9J+5qxeJ5+S/8jELM5t7e0E4vBt/UtcOaMewASmn
 sXKkKAYVQwkwi7oqYAMSb5Pwod6ZTQS17W7Wp99VPP7wPYa7/Lqfn8OGk8+mhoRLGGMQ
 joTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931519; x=1746536319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Il7Z60D0Ge6+rnPqyqzpsxFlQSgSW8tUZpdULtIHcG8=;
 b=LKd22dBWWqhG28jCfWUyJsBOPUWePARFP4l4sRYAMFIL0E/bss9rx1s62GTeWH9whv
 jR+mF53jQQ7Z3xuE6TAyfdyYcbIj5K3cBSX1oXfB8JW5S5lMuTFEDF1t5WV6l9lYhnWH
 Sen0q2YyPUwdlULrSyedzIvA4ICmmK5YVZPOkMxkUEboDenSdEG97XkqJOnYmmQlTuk/
 DBfcGQfZ2hZXhonmWjdbM1M5ELRKO24MourhDlzPZ/wVGgoiyWExc82JB9jeX87NICZV
 ihvI1TPxf9GX7SF4B8l17tjAw/v7bA4zq1gqfb0I1t7oRVYD+rSgTlAS2aLYXbjoeBtS
 bcaA==
X-Gm-Message-State: AOJu0YwTaqR67VTnx59va5DsUu4pRG0lH6OATatGVoy1K24v1so9dm23
 lVnfmZYb7qqyS8EHAf6OkNxSwBDMRC0i705ogxm580Vl2jT6IQemtRX3gwkKstf7uR28ncby9nA
 i
X-Gm-Gg: ASbGncuAyg29bZzj7MUNSH4I1ALl5u8LgaGQ7iOECRrT1ALjUYJ0gL3tuvrYQzLxgyQ
 BGmmgED7u+7/ZJaTokgGAA1KKwqBw7xlZAAJsRYbBzL2PlR9EwPZ1DmUjlaCthi6A4N6lGenV5Q
 slBxo3j9rXuMx17MPRJmbIWjsEH5kIk9FZpf9ZlbTyJ4Fld8MRi1f/Gvdu4TvTm40vQIsADG8Mx
 Ds878VtAAXAfBnNkG3+7Mxg9NadlgnIRrmnDHgYXi9MUzV1jo5K7ZLgCGaC+x2IEc6swLuayvbS
 JUm8w1u9piGVrbZz6zLdGgwpbJyxq+sZGhFMN51ff6o=
X-Google-Smtp-Source: AGHT+IGs86F8XAgwqfg/s1bj4iOkKDnkHYn4Z2WvNFCk8UsnkzYYxSUQj7z2o+HS1ACUBepLbPDJdA==
X-Received: by 2002:a17:903:40d1:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-22de6f99676mr44746955ad.21.1745931518775; 
 Tue, 29 Apr 2025 05:58:38 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7fb7e54sm8889440a12.30.2025.04.29.05.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:58:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, joel@jms.id.au,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 7/9] hw/riscv/virt.c: use s->memmap in create_fdt_virtio()
Date: Tue, 29 Apr 2025 09:58:09 -0300
Message-ID: <20250429125811.224803-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429125811.224803-1-dbarboza@ventanamicro.com>
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

create_fdt_virtio() can use s->memmap instead of having an extra
argument for it.

While we're at it rewrite it a little bit to avoid the clunky line in
'name' and code repetition:

- declare 'virtio_base' out of the loop since it never changes;
- declare a 'size' variable. Use it to calculate the address of the
  virtio device in an 'addr' variable;
- use 'addr' in the 'name' g_strdup_printf();
- use 'addr' and 'size' when creating the 'reg' property.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2383a557bd..46ac42058e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -841,21 +841,24 @@ static void create_fdt_sockets(RISCVVirtState *s,
     riscv_socket_fdt_write_distance_matrix(ms);
 }
 
-static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memmap,
-                              uint32_t irq_virtio_phandle)
+static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
 {
     int i;
     MachineState *ms = MACHINE(s);
+    hwaddr virtio_base = s->memmap[VIRT_VIRTIO].base;
 
     for (i = 0; i < VIRTIO_COUNT; i++) {
-        g_autofree char *name =  g_strdup_printf("/soc/virtio_mmio@%lx",
-            (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size));
+        g_autofree char *name = NULL;
+        uint64_t size = s->memmap[VIRT_VIRTIO].size;
+        hwaddr addr = virtio_base + i * size;
+
+        name = g_strdup_printf("/soc/virtio_mmio@%"HWADDR_PRIx, addr);
 
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
         qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-            0x0, memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
-            0x0, memmap[VIRT_VIRTIO].size);
+                               0x0, addr,
+                               0x0, size);
         qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
             irq_virtio_phandle);
         if (s->aia_type == VIRT_AIA_TYPE_NONE) {
@@ -1134,7 +1137,7 @@ static void finalize_fdt(RISCVVirtState *s)
                        &irq_pcie_phandle, &irq_virtio_phandle,
                        &msi_pcie_phandle);
 
-    create_fdt_virtio(s, s->memmap, irq_virtio_phandle);
+    create_fdt_virtio(s, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
         create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
-- 
2.49.0


