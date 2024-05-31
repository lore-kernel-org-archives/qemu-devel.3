Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D81C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8rg-0002uo-7j; Fri, 31 May 2024 16:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rd-0002uN-4b
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:37 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rb-0000pJ-Lx
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7024426c75dso1129832b3a.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187314; x=1717792114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEwzMtiXvaSjUielpaJM9jsU8kuFGmJjx5SbXBr0Ds8=;
 b=UA75zMhvImAmJYF14aFU016jv4d4UYRBNmmVDOQF+wImLQZ9jhl0gast9snHOl4fr/
 FBqnhHozwoJ04V20clERBD0TmPZ9ry767b2xzZ2pVhe+WHvPsv9wPOg86aBiljFEEvfa
 XCDg4agCgutz0pM7MvR2hwDKssl1PF20g0bvj+e9KwLlM7qOAuCAJCAYmcAa/Ex2PLWP
 vxZeGMIigBLAca23qdC4/Z8zqK1cNn+tCPOGsKoMVyYXmV9L711JXxGQNNCqHCpopf5E
 fnFysZnCHJju3MRutYR1XFepHAG8FehvqlVWTzbDTxooN1Lrscmq8kcqgaYPbmMOUws5
 AhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187314; x=1717792114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEwzMtiXvaSjUielpaJM9jsU8kuFGmJjx5SbXBr0Ds8=;
 b=Fc7eAQb2Q2/PA8v5vBVDrFrTrq/YHGxMA0mBVjv+Mr8UiEpoW6mjynTy4xTBWiCtR/
 q40pYYDL0zpvgCoDMg7JU927oElbG24HVl3ttxJ6WtpkBHwq9o4AImShjiyK9m+KQDFv
 aH092dnafyoLDbpxh2CnmlPC+bJc93n8GP5AOFhwurAm1alpxteH4jgZ0ISJRdFYi1dE
 IoObhhpmYnw9c9f9pL5JdoniKeFML+hhYqxH7VlbaUBAY3Qv9zPO0+wE5jxPpcwv6AZa
 fh14jc6qrMOcAl7DqOTlwr4Sl25WIB4FnXl70laZ4SA5hc3US52DFhiMNjgZlO/c7BcR
 brww==
X-Gm-Message-State: AOJu0YzGbkq6cIvq3gO+UQuxHaYTTt/XS31gfDTDmwfVlM/XvW52dEEE
 H2jLTAX4pn2ONi59Dz3sqKXK+QLIyQzDcBrasenxCd7PQyZUIs94iYG5xYJ/jC88PSlZ2hVJ88m
 t
X-Google-Smtp-Source: AGHT+IFemzpPHqt8HZrACpayB+u/FYiqav7LBeHlDqMZBZIi3E6KV5RpB0aYN5dP0qpFkul87372lw==
X-Received: by 2002:a05:6a21:1f0f:b0:1ae:3f36:28d3 with SMTP id
 adf61e73a8af0-1b26f253b19mr3311324637.49.1717187314109; 
 Fri, 31 May 2024 13:28:34 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 6/8] hw/riscv/virt.c: change imsic nodename to
 'interrupt-controller'
Date: Fri, 31 May 2024 17:27:57 -0300
Message-ID: <20240531202759.911601-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

The Linux DT docs for imsic [1] predicts an 'interrupt-controller@addr'
node, not 'imsic@addr', given this node inherits the
'interrupt-controller' node.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0a18547c6d..56d7e945c6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -538,7 +538,8 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
         }
     }
 
-    imsic_name = g_strdup_printf("/soc/imsics@%lx", (unsigned long)base_addr);
+    imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
+                                 (unsigned long)base_addr);
     qemu_fdt_add_subnode(ms->fdt, imsic_name);
     qemu_fdt_setprop_string(ms->fdt, imsic_name, "compatible", "riscv,imsics");
     qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
-- 
2.45.1


