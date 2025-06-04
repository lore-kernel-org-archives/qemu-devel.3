Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFCBC61CE5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIj-0002Bl-Gz; Tue, 03 Jun 2025 22:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIh-0002Az-9r; Tue, 03 Jun 2025 22:56:23 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIf-0000QE-QV; Tue, 03 Jun 2025 22:56:23 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so3434086a12.2; 
 Tue, 03 Jun 2025 19:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005780; x=1749610580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haOAiWr51e6r2Yb+LqRCwcRTvswrSE/JCNkLUe12L38=;
 b=gspWr2GpsTNmZU83O1UyBEbsfuOkaKbdJFHO8c9eazvJmB0Y8j82rOiEsEVIdyqEz7
 tlgDcm1q6k+3dtGW3UI+JrM6iSW616t8AktjM0SLrzsKjqIGk5BQAAIYTjR8CRKIApJr
 MooO/KEaAuM4W8LyFWpdrcE3t6wG6P7A8ELHnKgDYHr6sLMwX3pmgwx1RupU6bwV/XzT
 cK+2TQqxyMgOrIZneMycvt9zvH4HIzDesU7IN1XltOVwiaZqDEmf0wWPtZ4iue1VOjPW
 2cLRXXIZ44sfZCKgzVT8VxOkir+wW9JOUDy6MrZzgtBQnsJTRfY/NBHeBO7fGZcbaSRK
 +Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005780; x=1749610580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haOAiWr51e6r2Yb+LqRCwcRTvswrSE/JCNkLUe12L38=;
 b=FcehChEzDjbG8bG6Zk4pCTbE/Hecjc+DYquHC0Jjdb0qBcDt1WJwrhEzrG+GlhwFdr
 Zy3mxYgkdPh1/t+07NY5/oPLzriH1ZB3ggCYDdsS+F9SvpLo8QeD6XDsopbTn0HHWnEo
 4JUdKspBN9O4dUF+HjI62dr70E8+AVu9Y8tT+A3qPQk27qyJoXEvkcd9RnDq8xZqKHPF
 vPMdFcnRUWCOYhRnCCpFJFqjyvgwfNNweTcUrZaAABUzFYM/LGlnpDz3K4qIf+xWgH3u
 bMK2Qbcw6CfwvxcB8vEr38gV7woqklLZHpzJg2WBzEpJ2Zd47YeXlqKUYgyWOUMDoR2f
 ocDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX63T65bU7grf5dti6GwdBiXwAbXiDxZqaVQ8WkUUiWI0rAkX5zs+N267/Zt7IMQhT2VZ6suh3/AxjB@nongnu.org
X-Gm-Message-State: AOJu0YxBCXUESTpqzxIDu1ST37Ft4Eln/Hli+9ke211jpaG3apV3NZVC
 +I2cEX5BD/q8W6behp2+wa2cbhCRyDDs6n5/mgBNrhKy+m1FD1vDuFrw
X-Gm-Gg: ASbGnctcNYwerZflT6nfJaIU32TmUjA6B90DLaYHSGWBS5uqdAl8/OgmQl7V8ODymon
 3N5jBaUcWUzHX5r+yXPqkXL+eCzaFJpOcTCb0+lQLIkaiWoUfYWMIjbo9ti5ubNc7Zlaq3YOMgB
 gsAGHPNVtmVQsBNYGHrCBU8AWLZ9bLf0HevmgI/Y+fY+C7umfqfzQk2fzSGCICaJcj1bcPJIq/d
 IAJw9LsJ6oM7KjRmdUZkyQOXnxojFPZkQ29yza8TU98y3IxsFqXGfwdfvMAt2wznFGcfLZ8KECC
 20jrS0Oe75hvCM31zu3UQWlZ11LTfsrCl/ddGqlHS3h+VVWSQm2UYPOxINrRow==
X-Google-Smtp-Source: AGHT+IGNqF7KYywxERt/8FSIQkRQIKseB6Ofo9DigC3InAnKqXEo53jvvDL/A7VKxfi3DCCvza+teQ==
X-Received: by 2002:a17:903:2452:b0:232:202e:ab18 with SMTP id
 d9443c01a7336-235e11c7f69mr14880645ad.26.1749005780086; 
 Tue, 03 Jun 2025 19:56:20 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:19 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] hw/riscv/virt: Use setprop_sized_cells for uart
Date: Wed,  4 Jun 2025 12:24:45 +0930
Message-ID: <20250604025450.85327-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x529.google.com
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
 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b59f10dabe19..7c38a9048044 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -966,9 +966,9 @@ static void create_fdt_uart(RISCVVirtState *s,
                            s->memmap[VIRT_UART0].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_UART0].base,
-        0x0, s->memmap[VIRT_UART0].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_UART0].base,
+                                 2, s->memmap[VIRT_UART0].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-- 
2.47.2


