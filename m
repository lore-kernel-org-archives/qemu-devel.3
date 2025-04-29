Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701C6C3ABA4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDU-0002Kk-Sw; Tue, 29 Apr 2025 02:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDQ-00026y-Ek; Tue, 29 Apr 2025 02:13:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDO-0005Pz-Pq; Tue, 29 Apr 2025 02:13:12 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2279915e06eso63118755ad.1; 
 Mon, 28 Apr 2025 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907189; x=1746511989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWkcFRsJpyggITDuSxIVooDZ/mBbjHxv03/6iVGQ8mI=;
 b=nekZXnimCoCUcS5Tz+DtSqlrVKYuhIha3OEN2kekxloIDXt/8LcN+7pWkPAd1pGbeT
 GRjWsfRW8hndLZpyiiTStaXJPDW+TYMZu5XkjSqBnpLUUNdsqNZpyRObj5srAGXwUSQn
 2gENg6m+NhyKIz6Ekd1BlN9qfnyOyckiVLefzsu+coayzgZZ+p+cCIeLOc2PKHrESm6u
 E9ohhl46c5Iy989tbjfy3lP5czS4/sTpv3J9KpEhQNjylcb2WHiAVtSTegb/khecM8JQ
 aYWWwR4VJ1M7TEBpl77rJi2aiwk5PR2YajcSlGFDIx/vBdYHtFkkWfkH1GVkh4pAy25z
 mnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907189; x=1746511989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cWkcFRsJpyggITDuSxIVooDZ/mBbjHxv03/6iVGQ8mI=;
 b=IdnP2BWbUD7UOwHSU0lYmx4nZuioG/JdyFefsTSibZ0ucvEYYpmQwv+49ds+0oqgJG
 T80r24Jkx/3EqyLJZ+POi20bK5Wtibxk27nhzxfRvFP4kayXJy+hkiZRSold3XR8g69X
 ZPfDS0+zCxf8S70So2ACN4nBd4NAF9BdSKlc+nhbRBO42U3wk/tQvMoYvDclQ1g+p8oA
 Y/K5ppR/H4kd5l49yAWAbqqXt1CFbUum7sy/8wEuGAcbGxt/CV3MqTqy7wCpoVqYgOtz
 avEUn17eV+45zLTYzXdSdNfZ0UM+YcqVh91D+RzYuYX0ys+AKO7XbEve7rodIIilBWlK
 HBTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCf+yeXX/eYULjW1EN8k1aiGcVGUCD9bBq1XekB68m3tZoe4NvV0JUXy8Am+2XZyFRNjxcugAZtdkG@nongnu.org
X-Gm-Message-State: AOJu0Yy69n+clJUsJQThcW/iU4/oSDK7Eg9UBD4udC/Lx9bA5A6dvq/z
 kMmcDwKyhU17zOgh/kRzW0xSYdtp8x/lkEbl4NCap5LLmJC6maaHf8MkjA==
X-Gm-Gg: ASbGncuY7f98POblDY5CMsP1hV4J+RwEVs5XUZzFmaRuIqE1ADZpc0kALcOygpak5Ta
 jhatBLlJycB7RPnW7j06V8jeQ1TVF1+cUF5HTDfSeIiXdHEGhgdWK1eMU1eQggFpgzmahZxVpFZ
 rPnkC3FSu4stOTV1wwiuBvpYYKOB6WZz7/De64FfNnfJysSe4gigdUhQtUnjFpr4dxqSng4kl7O
 B+bP6gZyObwFwXDX4cicUbwHBDqxEMp5I8KTYLf4wlfVO7etpcQisgEtNYn/8ahNmjQ4P58TZX5
 9lhDq6a98j/fkgFNpIjfoa+M+RmnJHjQAEKwPdLdH4yyfxgfkUo=
X-Google-Smtp-Source: AGHT+IEKFombNcX7/DtSRuUHsUQ/C+MUMn9/cQevxTulBHvuGUDhyk5GFeNlyKO6hH0XV9bjXk50IA==
X-Received: by 2002:a17:903:41d1:b0:224:2717:7992 with SMTP id
 d9443c01a7336-22dc6a6cff9mr182056625ad.33.1745907189043; 
 Mon, 28 Apr 2025 23:13:09 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:08 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/13] hw/riscv/virt: Use setprop_sized_cells for aclint
Date: Tue, 29 Apr 2025 15:42:14 +0930
Message-ID: <20250429061223.1457166-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x635.google.com
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
 hw/riscv/virt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 62200ea39d07..0141ea4795e5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -387,8 +387,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible",
             "riscv,aclint-mswi");
-        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-            0x0, addr, 0x0, RISCV_ACLINT_SWI_SIZE);
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+            2, addr, 2, RISCV_ACLINT_SWI_SIZE);
         qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
             aclint_mswi_cells, aclint_cells_size);
         qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
@@ -410,11 +410,11 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "riscv,aclint-mtimer");
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, addr + RISCV_ACLINT_DEFAULT_MTIME,
-        0x0, size - RISCV_ACLINT_DEFAULT_MTIME,
-        0x0, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
-        0x0, RISCV_ACLINT_DEFAULT_MTIME);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
+        2, size - RISCV_ACLINT_DEFAULT_MTIME,
+        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
+        2, RISCV_ACLINT_DEFAULT_MTIME);
     qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
         aclint_mtimer_cells, aclint_cells_size);
     riscv_socket_fdt_write_id(ms, name, socket);
@@ -428,8 +428,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible",
             "riscv,aclint-sswi");
-        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-            0x0, addr, 0x0, s->memmap[VIRT_ACLINT_SSWI].size);
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+            2, addr, 2, s->memmap[VIRT_ACLINT_SSWI].size);
         qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
             aclint_sswi_cells, aclint_cells_size);
         qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
-- 
2.47.2


