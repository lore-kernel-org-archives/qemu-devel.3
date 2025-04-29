Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3685C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDt-0003Em-Ir; Tue, 29 Apr 2025 02:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDc-0002WQ-J6; Tue, 29 Apr 2025 02:13:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDZ-0005RE-E9; Tue, 29 Apr 2025 02:13:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-225df540edcso66427255ad.0; 
 Mon, 28 Apr 2025 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907199; x=1746511999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INpqRh2T9UJjALxwNPfMzJttYIUZLc9Q29sL9hwX7Gc=;
 b=cPX8VMpLiLnih5s4TRlF14JrF/V1aEen6/90yazDcQjtZvzOJRjZabbwWx0CSj8W8f
 NyzDZWm/TJD+mpE+u//kykWaxnZVL8T1AJEvXSdrAmMKRm2md3myE+pqnpUFKqWihEva
 8U0reLZlegTuoHQ2WcUFFc+HTHcfYXSGvCH8ahC0Mc3w0OWZaCpkTb/wM03jrD/Ruq33
 yb09tPBQwDgKl0B/eYbE+bxb8slwalQOLL/LOtt5R42v43VlCpxA+MXVchZCSQZmP1KD
 HxuFpj8FNuux5QP1EBRJFYy4Gi17PE9FdeCBFYUd5iEeL9A9ytrYFLiH2CFCi4OFrUyT
 O0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907199; x=1746511999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=INpqRh2T9UJjALxwNPfMzJttYIUZLc9Q29sL9hwX7Gc=;
 b=XyVrtcuKkTbMSzGVxBLwx/JqCXSS6C37158z++f/BY9fKYJ0t04vdmNhiBp6E8mikY
 DUWRP9YbXJh1fT4SgCNcpQ6JNScu+F1JyKwDagBwFOrnVdEepmuudhNNCbXdWbJQZP5L
 /IfhamBNMlVcXs5ryH+FjgAXd0P3o3cyLLah82cWdS0DlH7SMeoJ79qZUEaCJlQqp4VG
 qCwtIxLx4Z58cUvO4yc9DK7t9NLfN0Nv+wn+WPLv+L/9UZ3mJC0cqWpW8yxR3R9xBnyD
 WXQVGv79as4sDQKjX+0w4yGJX9Gm7PHeJ6hCaRaNUV8b+pm4foralLjDTHa0Nt+MiU0f
 60bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAuIYLgQRZ2CCDlqRdsw6+KzELH3bheEieDaq4s1yphpW5R6aV5X32e0Ry7yG6r1MMctIXQdDBgVpv@nongnu.org
X-Gm-Message-State: AOJu0YzJRVpMS+UY9tdZaQfoOfmVd7nBzlEdCWDjWLVf4QekqcM07T/2
 3Qmi41UBo4UNTY9wiMolqqjpdH2dNoplXCj5QHxhg3g3KHD96CTKIE3K2g==
X-Gm-Gg: ASbGncsTuE17guyoYXIqVEVGGDjG8ZPmKQNj9TGvGiWI+3PPDpIEAj8ydnafr7oVb4b
 UBeFS/pS0vVZTOfTOunmZmiqVwt1ixHreZM49WbQSjwpRlcaGm/Hj0R7UVU8BeMiyc9+T0xtF5k
 /YQG711+noLrEf/OXO+g+TsXx4LcDSiSLCdyCwY49Ip/GlrREyVzw8HDmgMIoV3nqkQaiFyP2Dt
 QEkYnhMBMPR8M/yd6z14iFAZUqVy0OJYy6ppko/bQ4sb2IPhRWbYuy0QZA1PP2ROD3mCkBd7YIE
 0L+PbYr7TRqlk/AFdPFu1JTS2u/ceyMj/Xo0nhnNNqf3a3aASN0=
X-Google-Smtp-Source: AGHT+IG0eegMiX3Tci+XA45yEuBDC0eREFeXygoXIJpLSeeC7y1oiQf2UaQ4XUbOGK7kShZa7vwaLg==
X-Received: by 2002:a17:902:cf10:b0:224:7a4:b31 with SMTP id
 d9443c01a7336-22de6bfdeb1mr24861335ad.6.1745907198956; 
 Mon, 28 Apr 2025 23:13:18 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:18 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/13] hw/riscv/virt: Use setprop_sized_cells for uart
Date: Tue, 29 Apr 2025 15:42:18 +0930
Message-ID: <20250429061223.1457166-11-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62b.google.com
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
 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index baa894b11aa6..d9303c9bb033 100644
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


