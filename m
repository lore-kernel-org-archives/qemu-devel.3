Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AEFC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDP-00023t-Ew; Tue, 29 Apr 2025 02:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDI-0001n9-MB; Tue, 29 Apr 2025 02:13:04 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDH-0005P3-4Z; Tue, 29 Apr 2025 02:13:04 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224019ad9edso84833855ad.1; 
 Mon, 28 Apr 2025 23:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907181; x=1746511981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOYvObSGVQcPGHwcgkBZGdkILj0IlErh2IJkkAXBH8w=;
 b=T13PIwsp+4qBnGXYSrPOkvzX+mCr5rPnhfv/htozojyPgUkx2qSxUeSf8O00pc5ltE
 TxRC7NXxZlZ4Qq5ym8+8xDhWRruk2yfyCLm2LfBElj9GG3nruKUfNqHPH/a2lVs0sCB4
 JZPjKA5rTB/wR3eeKI9qquQunynqZ6AoWNtnczl38mSYWqwlFsAoSAN0g6ur8fLHb3+t
 bxgZz39Vu/MjbjK0Wdi89PeUZN3nw4pfDTz4tPwKRwcrd6nXc8ZNq0zSKfMTUPmvBIcE
 QUynlJiwxQ0SrXbUtbIPo6D+DcqKbfD4f+CTZDLbYOLg9BOz/piPaszaCF+ygsbSnED2
 2IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907181; x=1746511981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AOYvObSGVQcPGHwcgkBZGdkILj0IlErh2IJkkAXBH8w=;
 b=ZM/6Av7E9OqY3F/GhEZX/pCLjSo0q/yzUSlkRWS/oCxszTlWvnG0R+Y1Ld1rBXr2gr
 NcTp5Z0VKrn3v011jBlnhC6oMAOny8xvtmJqEJoCCEsoc+vKtK5fXPpuwn1+mhpD/2gz
 6KasRtZHpJaay3sEbWtRR5o2KNwWcl/DuBAMvOnoOsQczRW9WOc3FlvAR5NJcdkha1WU
 bWhB7IwfOwDzSSpxCWIxrEjyW/msb72K0njaOyqFLIavA8vLSBeZazW6wOJtQOIDeeud
 DXHIAAVe26YzzIImC+9WNHOR1EbgQ0NtlxhxazeuLBjHwhskekQnNMR2hz1irHz52xUg
 wSTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8PcK3zaFQJnRW43ZYw/yksz6rHw3Mug5QCFBB7zn4B90hUhzSJMJAAKzxZuqtLF3qhpHPv7NL/w06@nongnu.org
X-Gm-Message-State: AOJu0YyFPcqe3dIahDrUy3dG16OkkSaWmxbEUC1+bAOhrz96EQVutL3k
 Je+wJKJFtD7OR7xtWcBybk0eCV+oqjPcLReRhN1AZk6nuv68ftUY
X-Gm-Gg: ASbGncs2mq1ry4BUjviNjHqekuY+FcI2AbbwI+vYMD8mn/x9Xm4L4qKBkql/2ziVwwQ
 I84loRDOnZXhyg8LoqPhDOUj38tpBJeayI/m9iqajmp3ZVGlcqzpr9Q2S0iapxzBSuDcrDXnMdp
 GpTaKwBSWlQPD/QeegsL+btJBSwJp3Ni0cvyHMAhf+tIme4dFGm2dUXyxEQcPcq84Maa/t4m89/
 uJ45V2Qbr1u4TBbdtSoxZO1dtGZ3dvAxWjlfw2pCIIxapm9zuBMl8L1w2xFEgGDAIuRS3Nax0/0
 68Dei0U7k3chHGeuazsL4idmNqfDiJYJk07YkXCzjPeztgjyhTk=
X-Google-Smtp-Source: AGHT+IF+SetXz7acNOBSgo2ffDQeHc73ugUdIIBrtyztYYWkVVKmtvhyKbcdCNn3uamsJrAio2ov9Q==
X-Received: by 2002:a17:902:e5cd:b0:223:6180:1bea with SMTP id
 d9443c01a7336-22de7012492mr24342605ad.37.1745907181291; 
 Mon, 28 Apr 2025 23:13:01 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:00 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/13] hw/riscv/virt: Use setprop_sized_cells for clint
Date: Tue, 29 Apr 2025 15:42:11 +0930
Message-ID: <20250429061223.1457166-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e4c0ac8a2a9a..873d41d10c70 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -346,8 +346,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
     qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
                                   (char **)&clint_compat,
                                   ARRAY_SIZE(clint_compat));
-    qemu_fdt_setprop_cells(ms->fdt, clint_name, "reg",
-        0x0, clint_addr, 0x0, s->memmap[VIRT_CLINT].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, clint_name, "reg",
+        2, clint_addr, 2, s->memmap[VIRT_CLINT].size);
     qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
         clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     riscv_socket_fdt_write_id(ms, clint_name, socket);
-- 
2.47.2


