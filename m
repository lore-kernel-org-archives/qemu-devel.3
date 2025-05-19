Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7FEC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3x-0001Xg-Nu; Mon, 19 May 2025 00:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrpF-0000Gv-31
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrpA-0004QW-6s
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:04 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af59c920d32so2500417a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627798; x=1748232598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQSw6D7ZUAhjEzYSKPNSeo9XeM/QAz6Kitga+BI42pg=;
 b=XFOadaYFgZiyr3xZP5g8IT0uswrSP5eBWZPxJfy4JVf+xC+4km/UGsX1lDflTbVMIE
 WgJ5rkXD/YiOXqHP+V9sW3NNw+oAz7h7/UQdnON+mhG2TaZ6ZiHCzzSBNxTUsXdUiRJ1
 PzQyxlWpJ2+TGqL445WEbP/ic2zWciOxCulp6nGbTb49QSN0q0NxxSH4onDfHucGIcXr
 pl74E5XVX8gme7M2lyxL4HYSLhyziW9xvH2mNvRe856MGfHT7HQWUBopsUKeH01UtqIQ
 5dewXJ+jF4QKraEWP++TOL73FdqNG5wOZ/qbJa8ZJwMx/h2nNm1IVRE3SKs9KMH4dmvX
 JmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627798; x=1748232598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQSw6D7ZUAhjEzYSKPNSeo9XeM/QAz6Kitga+BI42pg=;
 b=sOoiOgn2Tm6nxUxBFOa/4KTFKFPSVE3sx0V3MIvPgHIs6g0UKgR6A1LeFOX2i9DGRe
 dtj1wwbZAzthzPk6lM6xUOm/a8N+sqlmETTsJmE7/0r4m8cWjW5YC8sSJqlGwqFjTfFw
 X6n3UWwN3B6FUgccwLayN1YA82+NCnM9pUHwznMvbyu1XpjHBA/PUpHa9458kl494WvU
 /MYZy5VdUMadocA+d8Y8BG02FamdfxPlRtCmQU6mXcGBjhtzCjkLW/Va0UvKv31BlYHX
 7E9vxe5/VWcg7ZoxVX6rNIiWRCvgtRISUUXoW54mzJrEBuM9dd0qBRuK8VYGEbRHJ0qh
 arjw==
X-Gm-Message-State: AOJu0YyXqp0E88xmiu/lR/AwRckQYO5ytXNJgwpfoOPvzu8vcQux9kft
 glsR4KeL46MXkhaxACeRiYSl3Qf3vZ0MBiz0q8ulTCBJ3B7Oo03koSoY2xnhig==
X-Gm-Gg: ASbGncv4rbjw8gF3ffkJDw00ZZ1ztT2sWh4OgM8sj9MRifyDW5nCham45uCxbFi2AmS
 fgTVo7PB5XUQmbL56eoK1JVyUf0+2w7w5MIrI7lJY5j1HSoIZOBPAv4kg0VXEkRy3CUIUEBCv40
 jve6v5LhCpp24XPz8T0onqbSOtosTvvGUSD0cYaokcqHFoxGRzQIUfzGy6u8lXEg01njqlS5Kue
 dVoZ/AkBjcdwqB1SrW8V7Is123/4OAepEiPBdH2xOeljywboggCw63dWVcLSOMrI/AqvER1CT8c
 aeQoigldpVRfl3cyZ6vOFA9yCg6wgXohn3WXCgcO8mHhymBiy092bJSsgGCyqLMzt5dQhShaHu+
 4MVXOOsDRKYCJG+LipYl4AcQdEoLkWcuo4RNF7wgXaMZdqMXTdFJ/WMM8
X-Google-Smtp-Source: AGHT+IHWPenBtXIRioYN0l8atPCzxKhZSrMrQygNwTTtUmeS3dR+Nv4iCcu9pZbEG+Ww6ZShTiJzLQ==
X-Received: by 2002:a17:903:4b4b:b0:224:a74:28d2 with SMTP id
 d9443c01a7336-231d452c4bbmr172796695ad.26.1747627798495; 
 Sun, 18 May 2025 21:09:58 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 54/56] hw/riscv/virt.c: use s->memmap in create_fdt_virtio()
Date: Mon, 19 May 2025 14:05:51 +1000
Message-ID: <20250519040555.3797167-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e66a46f524..37bd720068 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -842,21 +842,24 @@ static void create_fdt_sockets(RISCVVirtState *s,
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
@@ -1135,7 +1138,7 @@ static void finalize_fdt(RISCVVirtState *s)
                        &irq_pcie_phandle, &irq_virtio_phandle,
                        &msi_pcie_phandle);
 
-    create_fdt_virtio(s, s->memmap, irq_virtio_phandle);
+    create_fdt_virtio(s, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
         create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
-- 
2.49.0


