Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A46C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeNN-0005n3-Db; Fri, 04 Jul 2025 07:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMY-0002zo-7a
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMV-00041o-Bs
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-234bfe37cccso9928725ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627625; x=1752232425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=co3a1xRLGQ7HekYeYvHj3VeR9v5FYdh85Xw624+7+Pg=;
 b=iIdAvUm/N1HgAZf4RbyAnaykzZ0P7YVYxgNzdhoNiyYZAQEjRkwAT3jDND+jmJ7FVk
 OoVWgdOo2Ase+jIixPnJjrLN7PUGKxEzVE7VO8wdlJ+PmBcQX+q6MUBBQKEic3uqatf2
 ddJAdzKpFVTwAfbItbQSnIfaqgpkLuOi/Qu87NTdFoQQpH3qztSKLCcZRayFsujJhmrT
 jF65YJ5eK2kPAyiFOePRGmghE6HWQZQlvvWWFahGNmlw4J/xdI1cJKC1kY8bA7YbQ2e4
 LevzMvD//9bXNzmP70eGnxr0ataYcS8WzaHRzmhe6nZKVFjj3LmqDV9x17g9S8sMdgf3
 M0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627625; x=1752232425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=co3a1xRLGQ7HekYeYvHj3VeR9v5FYdh85Xw624+7+Pg=;
 b=u/zZLdXlouZCi3jg1pFgQTFLx0QpFgJiMZHKHU11rY+VSXK+Wv+igEk7ULTV5VfGio
 nfuUr2uPSQ9BwBQFs6hBQJWWZOP/xHmpEUCNpC5JkPGrHDAYySRb/9Jas7vtZ+DMV0Ar
 jNIWOgP00y2u/3tr9FgpuV470zKSZXGSrgNxbtruiuXGd2gYao6oznjYwuwBMiyrr5xK
 i8VmUCFNQQ0XAAP37SimsOVHuOLYxPHig5ElKdMlhIYqfbnKk/+rlF38vEVzpi+/+Abz
 hONW7a10rZ7MSFv7UvskR4/ulNyInZ7JfG0ww3WDa8pFUf4S6FoMU1LsHcV3ArXWFyZl
 dD7A==
X-Gm-Message-State: AOJu0Yz4yRV52/Zx17slzOmsn1VAshhMitXbHrdGboHbDMXVTtvY7ti6
 SPwydDmAWDt7sj5Aai+7V41jmXeqt8V4x+Lpg248cG4QgPb5HY7Dr8E+CRSyYQ==
X-Gm-Gg: ASbGncuMn85sBlA01tb+7TbFwSltj+XaY/7PsORoKR99RQwimAFuKzBjGGcYAisFULk
 zYZJ+ihH0AdqAyIyvQaIsjE+OANeALq2R5VJuKeSURGz0xAI81fjna7Mkoc4OuzzI7XE56Kbdjq
 58RAaHdqJj6YOJLCW+1hYzOqIG0TWWTAtstnqTZEAs03IOdOIVQzXWy/4vaYgDWHQZfxzOj4MEX
 RWX/BVHmp08yQUrvEhgt9pfMaHuzyjaeZkz3yUhS3pM8coTW4Mn5E53zhXVUwtvbm2KIv+rqfLx
 TkCcqagiIMeq732DQX595L1Nn11I3I/ahszixYGBU5RO9HhMImn5TgsWuIw0z90x9GIXaIB15z5
 hWztSQdQYFz5zRw7y5Qc9JS5JjuW0V6cVMRJTnWkO+r0ebjk/r5Yn4rLwYrGpxTVOmdOrokQp+Y
 FrXA==
X-Google-Smtp-Source: AGHT+IGtYM3X27SrgmcT+Cvmu6/3Q/XCKptPGqGjDSd3TTCOdIUg618BSWRQNe7uPlUMrRMM349jIw==
X-Received: by 2002:a17:902:ccd0:b0:237:ec18:eab9 with SMTP id
 d9443c01a7336-23c8611e444mr32551995ad.32.1751627624881; 
 Fri, 04 Jul 2025 04:13:44 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/40] hw/riscv/virt: Use setprop_sized_cells for aclint
Date: Fri,  4 Jul 2025 21:11:52 +1000
Message-ID: <20250704111207.591994-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Joel Stanley <joel@jms.id.au>

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-6-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 205fa6e44f..4fd966a342 100644
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
2.50.0


