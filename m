Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAA9CD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQkV-0004W1-QO; Tue, 16 Jun 2026 06:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkT-0004A0-A2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:25 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkR-0004S2-EE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:25 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c85822059d8so2746778a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604622; x=1782209422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DOg/38V/OeL8frN48NwIaGCLBgQVXoAi5N9B10G0OM=;
 b=ENTTgdFg/HbcluNS5Ik2Tm/zj5gx7zmAhhfegn/FE/9wG2zTd1UmOX++4XByqDbXSQ
 pkREswga6IABZGVYTUMWOEi4yNF4PLB3ftNVXPsTKXQVbM3OwKTniMM2T4zeNc8c2ftx
 MzjsniKhkbmbOInDpnsiFf0L/hxEX1547eMgk/dzggn+cQXEWUqCLzlKrmpxUpwCEYhL
 Hbsk2eOK5r59xOaEPTfL3tCdzdb3mGR7sXqBwtN1BdZw4fujnVt/nHfRAfK3IG/pYEpj
 iqAFoD8uRrpsLTugpr1arUbopxuRQfdMPCgX/njXSrnf4dC+0Mjnk3eBnUFFTVQ4T5kG
 TwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604622; x=1782209422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+DOg/38V/OeL8frN48NwIaGCLBgQVXoAi5N9B10G0OM=;
 b=fmpRS10sNsHM4ETzXqVW95frX3jsLFUxa2qtAUu9Csush+b/rLFAFiIVgSPnYtGrbP
 RpxbXNBWPvDwxl/S8jC/lHZrSxOoMlKHexB0ofMVEG+X72RUWmm/TXN9Edwkr0wYcT/z
 bDTYOkVF/gCJ+0oaorRigp5hDVdUyhpMn3KJV7eEP+AK95JEOrdLaO2Fkmo0OyAXMUWT
 AxUIvFEhBGBiIAn4AkrWdlX++QolSjp3WVFANEBp74xQoWkcVbV5IyHiof2JX1FZaio4
 MoM2ARbo1en8WYhRWJvY2i30NU+EXtxcT8T53M+oPvqXrHJaA4pOO0e2kksNkagYaYRI
 yO0w==
X-Gm-Message-State: AOJu0YxL8h7tnCl+wmyqaUMDLH9e5/KTSli+vs+oiXmWzvGiCOHiwz5E
 grdLSFQ8s0+SFnI7mKxNHGFD9KIDpgNWHHc2bwwnnHwo0SS9ZUh8BBljiej0Ut/y
X-Gm-Gg: Acq92OH1jkpY52KHKxbGpPiNvvxRdy36cPdSvVx9aETeYey/Qt4xWLrQS3vFlFg55Ig
 nomBjNK1bZOM24e9XF7M/85qbiXGRswwErpNh/7ZPSdkl/Ej7dSpCfXDpILDmcvmt4Ir6xrbyZz
 jc7hfh7JPZrwVZpgLEoWRtgh6VOEHDol/hXQQbprN+v9pB2yh0pq9yaXnoTH2w6PrP7kXPr6LyN
 s2dXEiMreer8hJKFdHxdveLMLaTEJm9DsNqV2cUkZyAjcO4Hx3D1M45gnQLX7XbGbiuWoEXJBZy
 iB5l9wMG3wyqSEJeCbuUK3nYLSayoyRiA+AL5rohAvS8cJNLeXWsgErCADwI6vqYBWYjCsTTA3i
 Nyzkdrkrd+UBTtes8Ew+/4jivQj7EMk8sTjLpryXKAETIdIbY6JhERErdRIv8moPOu/qbpLHXB3
 oof9fgFUvzRgxdwWCECGv+GpS7mZ4yGFI0WCCzaaEY
X-Received: by 2002:a05:6a20:94ce:b0:3a0:adc5:52c1 with SMTP id
 adf61e73a8af0-3b7e473ff32mr3287459637.11.1781604622063; 
 Tue, 16 Jun 2026 03:10:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 83/83] hw/riscv: add create_fdt_socket_cpu_sifive()
Date: Tue, 16 Jun 2026 20:05:26 +1000
Message-ID: <20260616100527.1939565-84-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

This sifive_u only helper shares DT code with other boards.  The idea is
to reduce code repetition while keeping sifive_u characteristics in
place.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-14-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  4 ++++
 hw/riscv/fdt-common.c         | 11 +++++++++++
 hw/riscv/sifive_u.c           | 24 +++---------------------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 3af9d5c3fd..2d6b9a5d03 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -26,4 +26,8 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
                             int socket_hartid_base, uint32_t *phandle,
                             uint32_t *intc_phandles, bool numa_enabled,
                             bool is_32_bit);
+void create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                                  int cpu_id, int socket_id,
+                                  int socket_hartid_base, uint32_t *phandle,
+                                  uint32_t *intc_phandles);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 70168ad657..b27ff13bca 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -189,3 +189,14 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
                                        is_32_bit);
     }
 }
+
+void
+create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                             int cpu_id, int socket_id,
+                             int socket_hartid_base, uint32_t *phandle,
+                             uint32_t *intc_phandles)
+{
+    create_fdt_socket_cpu_internal(fdt, clust_name, NULL, cpu_id,
+                                   socket_id, socket_hartid_base,
+                                   phandle, intc_phandles, false, false);
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 27c1a74d99..0c6e4204cb 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -145,12 +145,9 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(fdt, clust_name);
 
     for (cpu = ms->smp.cpus - 1; cpu >= 0; cpu--) {
-        int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        g_autofree char *core_name = NULL;
-
         qemu_fdt_add_subnode(fdt, nodename);
+
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
             if (is_32_bit) {
@@ -162,25 +159,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         } else {
             riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
         }
-        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
-        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
-        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
-
-        intc_phandles[cpu] = phandle++;
-
-        qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandles[cpu]);
-        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
 
-        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
-        qemu_fdt_add_subnode(fdt, core_name);
-        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+        create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
+                                     &phandle, intc_phandles);
 
-        g_free(intc);
         g_free(nodename);
     }
 
-- 
2.54.0


