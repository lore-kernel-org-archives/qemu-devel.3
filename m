Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FCEC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIl-0002CW-U5; Tue, 03 Jun 2025 22:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIj-0002Bm-Tk; Tue, 03 Jun 2025 22:56:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIi-0000Qg-Er; Tue, 03 Jun 2025 22:56:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234ade5a819so56348575ad.1; 
 Tue, 03 Jun 2025 19:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005783; x=1749610583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkqK6XnqHK1/oK/4bd2jOxngmEcZko8Z16pkYXUDEX4=;
 b=NRahlBGC5n6K028/2Ni1XtasaPolx0KBkxnemScCRdr/3/dFScHesDxW4UWUvkWT/o
 3aZJmOvs/D94EHTf/flBSQjuWwxoscpdwWi6JAdlsdOIYMDlepMuaU+uT1qsYJdhNZIP
 J/GAyAIXlHqqck9QAxuTrl2kMM5I5dWLEL2Yel8CrSaWRB+saJF0uXE6DjNTImj20CYx
 gcDxIKwbsWOKpGctiQ219R8Yu6prGsu6dGmdqgjuZKeGTWvJdQPBD0/ItyIOosfFn5Pc
 RYIVjhnv07KbMrck0hft4vDNRc4NJtMAHcIOJxxXSagOoVV069YQ1g1ggopvLUSHILT6
 xCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005783; x=1749610583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lkqK6XnqHK1/oK/4bd2jOxngmEcZko8Z16pkYXUDEX4=;
 b=pl1Bcf/WbnFw9aPSFtDM9FYf6HzL7Od3xjxc/Y0hvLFZRknwbM6ecY0WaCI0oX7ePA
 V6b3h+5pWDGBfbRjkbhsN8FTvjVqYZwNvAVLMwgCSKOgHGktxiXbwzTZfBYIkFVlYbqL
 8L5gADtB+ZF/y+hPKVTXj/DyFPoxmFd6oZGyyYclCtZBg5j67nK2Kcigp5oW3ahGf4Oc
 pnURQPwEEGuY+KL+brNPf7NPi3u/N93ziXRLddiXU4YfvKvC2fdONNB9HFdMDBTHmCqj
 Lv+DHmVll4/YGhRGIyoHLBTu58gzhi+0SVqUGn1kKiIrmT6WOWm1+wtBfWY25kgUoQky
 gAFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNkbyxw/q+xUyq0qbp0GygRjmxT+JVj/bXK820IXyO1EpPULVtHrgO/0JuvlaDwwni7bFkhKCXj9e2@nongnu.org
X-Gm-Message-State: AOJu0YwBK585q4aiQnlnt4lUQVZO/xuEfxQRszV7OInewnFUzJHk4F/X
 dc8xu1TiitK01aMg2DxeCUKX4VlPocUj7RO+iEQfYB9/DknkPQTcWOTfT0/pmTOn
X-Gm-Gg: ASbGncvT0wO4HDCQ5EpjjWRz7CYxvCh+cc7XbFEx9MGbb62J8E4+qEbqoRXnf5GAhHM
 d7oJXo0MxYna1S+8FZhL22tG9Bf7eZSkxgOgMjVKQyuc+jhYGwXSIeQmTJNnL+eqEM9jYoQjJJh
 pdJi/VjGB/hAtRtJHAxZhJxxJfxkZJW94zsHv1taDrhhxXsa51rQvjejuCEi6tIndGDFuN2meIA
 4w2FGp8yMElU1IanwNqldV24OBnG2IOkjUx89B2+ErEELnY6GLn7ol1TF4GcSrptnj5JPQCr+K9
 nVIh3g1eURzGNfs+LzgBIezyXjmHLOwd+cZoVV/gRD/BGgqNntuQDGoJWeTqQgnhXHv4hHJU
X-Google-Smtp-Source: AGHT+IEyjBG5cmJRW3tH8JMmScQa1bFr8eJr2Ta1PS24F5uounN7kkPn92IVimIjwVCqCwucj9uYPA==
X-Received: by 2002:a17:903:46c8:b0:234:d7b2:2ac4 with SMTP id
 d9443c01a7336-235e1126ed5mr16451125ad.17.1749005782879; 
 Tue, 03 Jun 2025 19:56:22 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:22 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] hw/riscv/virt: Use setprop_sized_cells for rtc
Date: Wed,  4 Jun 2025 12:24:46 +0930
Message-ID: <20250604025450.85327-11-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62e.google.com
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
 hw/riscv/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7c38a9048044..4fa2bad24804 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -992,8 +992,9 @@ static void create_fdt_rtc(RISCVVirtState *s,
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "google,goldfish-rtc");
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_RTC].base, 0x0, s->memmap[VIRT_RTC].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_RTC].base,
+                                 2, s->memmap[VIRT_RTC].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
         irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.47.2


