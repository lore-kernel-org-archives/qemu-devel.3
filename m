Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529B6C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeId-00029v-W2; Tue, 03 Jun 2025 22:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIb-00029B-UU; Tue, 03 Jun 2025 22:56:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIa-0000Pg-Cg; Tue, 03 Jun 2025 22:56:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23035b3edf1so57517665ad.3; 
 Tue, 03 Jun 2025 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005774; x=1749610574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TW2qvDv71buLaLj/Jgf+ppXxchJib0Z3gTkRO9ucyE=;
 b=APW3pJaHjDRlJGT6M/RA/HcTT1PP2VV+5lKFbrr+GAk0Ajvtm5jxlx/elp5gFMwlUi
 3MtZOyspHTi65hwv2pymRZ/ty2axfVLQC3cwqMcJ4FBwRU7UPutPuq1A2g/17BkLXNOs
 eKT3EoUNf0+B4IqzXi1Cm0uER0/ypCQ3Cum3nsNlydgrOnfE7vJaDKO7GXmXLNeMMYPK
 1GeP4ixo3QaTiVobHXHfa5FTultV3sHicRK8LOVKJkWP8K0X87BYXfqDbN82Q2DQKKwZ
 0K4z9mvAqeBEiwtLleLeYqqydcxaOcm3SM1hbI0o/e1xLIZocWdRCdRjwjgfD0/yHRu5
 UkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005774; x=1749610574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2TW2qvDv71buLaLj/Jgf+ppXxchJib0Z3gTkRO9ucyE=;
 b=K/OrHcjIn6Gm624PsUvkuM1eRmbiB5E9IGKAapqxnKFTHuHtM92KxXbWR+8MCn//qm
 fvk/3ZX13GuO7VD0oyXydnBcqmQDJg6NnfMLPJwULZlCJOlK7y7qLzn/GXjuOO8BocSv
 BzyRJqepPZ1XGgUkIURxMq8KO4bn29X0sElLbih1QJD59aTwulG+7KqRxVQkExmcakks
 Hr18RDLqIFJXPjogTGOFgFVOMHjSA2O8T8w7nJtF/b7lMVEEhS9j2G+U854JSEUV6Tt6
 dxbA/hy2Nejbvgcu00Lo8DM92LA2eeeSvOIZrrCA+O7Pywctuea48jTyS4o5ojWB3Pg2
 QoDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGscPa4RAUh4QEF7Giit/MD1PnS9rAI8Pgfs/MDkrzGWIb8BWDhCOpB1dn/zefOBI1GGK66b+3qmnO@nongnu.org
X-Gm-Message-State: AOJu0YxtzKIivynrSpImJREDsBIvr9FPCpx3eORlHC5vVYOHucT44aIi
 3LapH6xlLFCJUFHvzqrA3hxo3ZM9fvEaDKc4+dc7cwUeMyjZcYtRhbDk
X-Gm-Gg: ASbGncuO3mMG2KvTdLbgUdh3awzfATcmAoJSaPv4PQKPjUNuEy0yQx0NgP3UL/DU1s0
 DDcvh+N2n8vy3QC4ey60hMNgac00EWMJoVaWHeH/nMfhLmk4cNGYlmYDzWKiRA3HDN/MaXa92YF
 aGZefqmmy2i85hCgnVX6ZhJFfz/TiwMXlpLMV172Bono5yMrpQSQcJa8p103VFXlZ+iE6hZni1m
 jDHuXE1DJHOtc3Esd/4B5gcFh/PtzkN13oQaEwybfJE57gLOgCctuM1gScTgZ1Q59m55DGQuWYa
 YXDlTJFuHsr4K4rv6ysvmjAeXMuYR0cbL9KUDmyX8r/3+7h8/TJnGQgES7f6zg==
X-Google-Smtp-Source: AGHT+IE5nQMp5rPZ9tpEiPdq6ffxx6p/6RGswvmuZeosf0Pi5lVRHSNDlous3NxYm0iYD4WAS2ap3w==
X-Received: by 2002:a17:903:2291:b0:234:c8f6:1afb with SMTP id
 d9443c01a7336-235e12c4defmr16200855ad.0.1749005774607; 
 Tue, 03 Jun 2025 19:56:14 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:13 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/12] hw/riscv/virt: Use setprop_sized_cells for virtio
Date: Wed,  4 Jun 2025 12:24:43 +0930
Message-ID: <20250604025450.85327-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 67e60eec1f00..851c7cc82ad5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -856,9 +856,7 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
 
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
-        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-                               0x0, addr,
-                               0x0, size);
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
         qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
             irq_virtio_phandle);
         if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.47.2


