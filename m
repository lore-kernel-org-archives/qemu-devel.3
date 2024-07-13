Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ADCC3DA45
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 17:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSgmb-0002kv-TB; Sat, 13 Jul 2024 13:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sSgmX-0002jG-8r
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 13:43:37 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sSgmU-0004dD-Fd
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 13:43:37 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d9e13ef8edso1837240b6e.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720892612; x=1721497412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZ9Qtt1unyHbvV/orG6ImKsXeJKmuPBmR7Zz1GsqIS8=;
 b=ppGcqsUloxXFQzcRnsxXlmMge69MNWJ91s66fqIW8fFexFGA+Cm2611pzdz1NGw6AA
 Z50/PysDWj5++HgQkJ7K/eMMft2psutRyEH09Z3I7Sd6zF3H3S7PihLrHwVjMvKv/A3E
 KUd/AX7u969zs5ghEB7tP4hoxbo0EpAuPM64G0JVPq8ydM/u1VITj/1ZzT9wsekakWEJ
 EE6HlFcCIsFOybISWxYhWLdyIZTW66M46QQ/L+Drh48l+iuqcJZSga9Z2SAQgep7YzGz
 WHdke0vr68jFJSU7WYtuAN8cEsXnlJfZVe9mxIF9NUYPOzmBI/NU9tt9ENg19pgQ1GiA
 5Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720892612; x=1721497412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZ9Qtt1unyHbvV/orG6ImKsXeJKmuPBmR7Zz1GsqIS8=;
 b=AF8RVxexPTDp0tKoOL6LP5bR7DrCXxaK20DOquTqlCy8ixPc10/cq6ok7pVp9Vxj6C
 G9a5TdnTtmdbpA00lfz/gQo9xqj74Ill/I6HnsiVwiEc3iOHlR5I7Nn8He2nlDSyicwx
 4zZ3nTC8Af4WAdc/OuWZxWBlZxCLTweILMx0jr8/nvIA3qs1yeRlV+VZUGHjScrRrlgg
 Jd9Sw5LZj2Rtgb2t3Wj+wXL2seM8YNyWVpmtaAaBSaE/1U/N/v5Ujnc7Ym53RvH0AQV7
 lsOEcbOzE5HARS4pbhEHj+raiHvFDyYXyEaM7WDmMBIHaojR2KoKGxfiVI6vLrTdik6l
 zomw==
X-Gm-Message-State: AOJu0YzCZoJv3G8N7QnzkkGApo0WbaNkqc/nBkyUuqTNE9fTfje30z9L
 oMqsFQCn0RxSQCyesGUGFvh8BBQgyaGNrByjGf4Em7wKPNy8IJPDnEzRlfbjCiNtG1ltl9XD9dU
 W
X-Google-Smtp-Source: AGHT+IEHB31ZPZW7Eztobk7tkKRQXSUsjF7xoyrF1gBdW2WrBXvNjGfvegUctgs9Vft/+PvBc2fQTA==
X-Received: by 2002:a05:6808:120c:b0:3d9:27fc:158f with SMTP id
 5614622812f47-3d93c03d628mr17591558b6e.29.1720892612483; 
 Sat, 13 Jul 2024 10:43:32 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eb9b3aasm1487225b3a.6.2024.07.13.10.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 10:43:32 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] hw/riscv/virt.c: re-insert and deprecate 'riscv,delegate'
Date: Sat, 13 Jul 2024 14:43:25 -0300
Message-ID: <20240713174325.107685-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit b1f1e9dcfa renamed 'riscv,delegate' to 'riscv,delegation' since
it is the correct name as per dt-bindings, and the absence of the
correct name will result in validation fails when dumping the dtb and
using dt-validate.

But this change has a side-effect: every other firmware available that
is AIA capable is using 'riscv,delegate', and it will fault/misbehave if
this property isn't present. The property was added back in QEMU 7.0,
meaning we have 2 years of firmware development using the wrong
property.

Re-introducing 'riscv,delegate' while keeping 'riscv,delegation' will
make current firmwares to keep booting with the 'virt' machine and
dt-validate won't complain about it since we're still using the expected
property 'riscv,delegation'. 'riscv,delegate' is then marked for future
deprecation and its use is being discouraged.

Cc: Conor Dooley <conor@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Fixes: b1f1e9dcfa ("hw/riscv/virt.c: aplic DT: rename prop to 'riscv, delegation'")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/about/deprecated.rst | 11 +++++++++++
 hw/riscv/virt.c           |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 20b7a17cf0..88f0f03786 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -479,6 +479,17 @@ versions, aliases will point to newer CPU model versions
 depending on the machine type, so management software must
 resolve CPU model aliases before starting a virtual machine.
 
+RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The "riscv,delegate" DT property was added in QEMU 7.0 as part of
+the AIA APLIC support.  The property changed name during the review
+process in Linux and the correct name ended up being
+"riscv,delegation".  Changing the DT property name will break all
+available firmwares that are using the current (wrong) name.  The
+property is kept as is in 9.1, together with "riscv,delegation", to
+give more time for firmware developers to change their code.
+
 Migration
 ---------
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bc0893e087..9981e0f6c9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -651,6 +651,15 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
                                aplic_child_phandle, 0x1,
                                VIRT_IRQCHIP_NUM_SOURCES);
+        /*
+         * DEPRECATED_9.1: Compat property kept temporarily
+         * to allow old firmwares to work with AIA. Do *not*
+         * use 'riscv,delegate' in new code: use
+         * 'riscv,delegation' instead.
+         */
+        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
+                               aplic_child_phandle, 0x1,
+                               VIRT_IRQCHIP_NUM_SOURCES);
     }
 
     riscv_socket_fdt_write_id(ms, aplic_name, socket);
-- 
2.45.2


