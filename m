Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA28C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8ry-00032P-QZ; Fri, 31 May 2024 16:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rw-0002zM-LA
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rk-0000qP-Mu
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:56 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70255d5ddb8so17390b3a.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187322; x=1717792122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYrjc36HQnGLnYOXBz0ofJERm3ikZWbOl25GmTHs5No=;
 b=WDf+n5KKbBGcqRgl/eVnmKX/3AziwoChUYzzVmq8Bv1QnNDDf89R+MZvD64L4eIcMm
 UacL3WQ6WInpW+9u+aMZuUaJJj6qy0MPQhkVjUYEMmZI66Zp/dzS1mR33OQcOsZnxmZs
 cfayXfe8H14XTJF8BIRe2DRchg8AHTgRNiyo9TViRKm0lZFCf7YlzdZmjiy+RpVRKtzj
 O/OJwZIwyDbmvJ7mHU2kDCcDsyc/mMF8ofMKxvJCBMhBWygiZK7e/NXcQX/1amQZWnPN
 CjKEpg/IiUE3laGeXw+lPULDrTgs/YcoQd3KkwDx3ZszFenSLTroTL58Nwc8BtJAtvzZ
 aaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187322; x=1717792122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYrjc36HQnGLnYOXBz0ofJERm3ikZWbOl25GmTHs5No=;
 b=J5rC8rua5cAvZFwGenXn8RQGK8Ov2LFlsLSFpj+bGltx49nKT+UQQJ36AIJUvYMl2T
 PRVclJOzgN7C+RPKhVqx17EdSqXPkb2Jv4yaK4W/h2zlSiTyOHCbkXavd5QgePrYEWzn
 p/OPnQ4i6y5UP14DfBSbNh0Yu5wG/eoXA2daHcxjvi0SDbAym7y5R0uN7Uy87uYgEUC0
 zdT5zs3JMDMoYAyyryBqxIE2T+mL9VOinRecTV28X6ITajA6hO0cujK3w4Uynk2tqdpS
 vxcRGlbUKSr1yYLj4w1+Loi/9WusW7vHe4b0zFoRrLTxgdSleDp1w+QtaRP32G2m6Lwc
 g0Tg==
X-Gm-Message-State: AOJu0YydBgfzy+xey0awpu2Zt1s0xKQ/QALDV4sW+pQLSDCdUYSlj3GB
 1rfEEJW8xM/olji2UaBv8ejgzf6NAo6LmWEYYyoO5t4jaXT2vXKvpPu4tltkn66Swuisu/w8bqk
 G
X-Google-Smtp-Source: AGHT+IFAAt2lWUzhgZcjqCJ7P7RV2AoRnIGFgQkoK/cklXD92mc7RbYg9V+76nxirfwJpSDL47bnXA==
X-Received: by 2002:a05:6a21:2799:b0:1b1:f785:550b with SMTP id
 adf61e73a8af0-1b26f2cc9a7mr3108760637.38.1717187322686; 
 Fri, 31 May 2024 13:28:42 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 8/8] hw/riscv/virt.c: imsics DT: add '#msi-cells'
Date: Fri, 31 May 2024 17:27:59 -0300
Message-ID: <20240531202759.911601-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The DT docs for riscv,imsics [1] requires a 'msi-cell' property. Add one
and set it zero.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ac70993679..8675c3a7d1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -552,6 +552,7 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                           FDT_IMSIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
                      imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
     qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
-- 
2.45.1


