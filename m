Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27974C27C50
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8rP-0002pv-9t; Fri, 31 May 2024 16:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rM-0002oz-CK
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rK-0000nX-Mu
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70245b22365so944766b3a.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187297; x=1717792097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+v0oYsrs60BFJiSO6oNRIio4iuCfxznllRGF2qwCVI=;
 b=b0K8qvYkiLSI+0itwTphLE2IdwpexNhgOyC1rQJiaguWHh1aPF1iBHchgbvBqXQYe0
 O/e2qjDUM2SwqSq1znJ6izh50Vtn5awsqMTfDPnR7KharElRSoYTdF81nQWRD46BMr3U
 MWp+2dvJIKNNw6ri/bi+umiE8Z4rjA1rNUYQCzGK91Q46llatpbPtPZqC6AEtEM5bUKY
 U35uH8OD/2vkK2tT/tAP8bsLjbKIOCeL1CjlZGAje9hilYhY74OSb+aWSzoFQpvG/AZi
 4MUKF9FdrNpxTtKHnmrqiuDg3AvbhhYI6wlFno0eNr1A0c/b7wNnLVLrE7ePQhlQ4HR3
 Yuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187297; x=1717792097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+v0oYsrs60BFJiSO6oNRIio4iuCfxznllRGF2qwCVI=;
 b=VkD/b4SoWypEKgqA5CVQjRm2dXLza2rxWba2gJJRNz9mni6lMU5vhWmmLS05Zclo/i
 iImUSIJWXQ1ZTh30IzyXedqHO9qyVpiQTmXJCWgz26d4RIus2OrGBcsWdENcVt8BDFLK
 ePwEKTm2TqMYCfMFuC75Ncp7Ul+hHcq3ZvWE0l2aNLjprMUI8/LSwGdtONCCY9vVER2Z
 k1dMzQElocPm/Gpz5ZVUDZTYXAp6iRcm8sxxWA7auG9IeELG41UIoM7RH2S8t3sEz8LV
 XszUKiAtNRZpxZXIyraueD2dNpXDnWxoJSbLySn0eRC2EardxJjtfI9bhOaRALzlEOow
 b+7w==
X-Gm-Message-State: AOJu0YxUyX6LpcfPgvJUfdVsu/Hh88uY+V+TwC43V4LrhzW7x3HYBBo6
 430dMBfuWy7PGl1YVifsWwx+J6HFefQAreStwxCsVhRnkIHOeWwBWqdu5D00CcSwYq9y1nwi1IT
 W
X-Google-Smtp-Source: AGHT+IFi26WDHZRmk9PwU0pSBWGScPFKyKDf0saOo2VuuREYs24i6bQ6SQlFZ9ofEFsgxIxrDHHlKA==
X-Received: by 2002:a05:6a20:7f96:b0:1b2:6054:c8ba with SMTP id
 adf61e73a8af0-1b26f30e4d4mr3047560637.56.1717187296779; 
 Fri, 31 May 2024 13:28:16 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/8] hw/riscv/virt.c: add aplic nodename helper
Date: Fri, 31 May 2024 17:27:53 -0300
Message-ID: <20240531202759.911601-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We'll change the aplic DT nodename in the next patch and the name is
hardcoded in 2 different functions. Create a helper to change a single
place later.

While we're at it, in create_fdt_socket_aplic(), move 'aplic_name'
inside the conditional to avoid allocating a string that won't be used
when socket == NULL.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1a7e1e73c5..07a07f5ce1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -588,6 +588,12 @@ static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memmap,
 
 }
 
+/* Caller must free string after use */
+static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
+{
+    return g_strdup_printf("/soc/aplic@%lx", aplic_addr);
+}
+
 static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
                                  unsigned long aplic_addr, uint32_t aplic_size,
                                  uint32_t msi_phandle,
@@ -597,7 +603,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
                                  bool m_mode, int num_harts)
 {
     int cpu;
-    g_autofree char *aplic_name = NULL;
+    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
     g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
     MachineState *ms = MACHINE(s);
 
@@ -606,7 +612,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
     }
 
-    aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
     qemu_fdt_add_subnode(ms->fdt, aplic_name);
     qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
@@ -648,7 +653,6 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
                                     uint32_t *aplic_phandles,
                                     int num_harts)
 {
-    g_autofree char *aplic_name = NULL;
     unsigned long aplic_addr;
     MachineState *ms = MACHINE(s);
     uint32_t aplic_m_phandle, aplic_s_phandle;
@@ -674,9 +678,8 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
                          aplic_s_phandle, 0,
                          false, num_harts);
 
-    aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
-
     if (!socket) {
+        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
         platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
                                        memmap[VIRT_PLATFORM_BUS].base,
                                        memmap[VIRT_PLATFORM_BUS].size,
-- 
2.45.1


