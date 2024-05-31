Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D146C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8rl-0002vs-5p; Fri, 31 May 2024 16:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rj-0002vg-MI
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rg-0000pu-2K
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7023fb5a753so1390832b3a.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187318; x=1717792118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvxnRxIgg2C4FNw5J/4rkmdz86iMxWSW5G+jsM08/4E=;
 b=h2uZ2flDg4NiJuvzv1IeRg19Lt19smnEicj2S65gdYjQGom2m8kPOXoWs4qy2fwcHQ
 g12UPyBTR4cv6u25R6WxZt1+rMyAfKZUxk81UEn3MuVoOTgsAwQrq7vSlV88HDcxKrkC
 LN5Of3/aRPx0bOMOn1BnNkGfr9YUJZ1js+5d5//7lOIMDM+huTXm6scjRHjt6KaM3Q69
 ESpwRdptsycaVUoJC9gL9IL1JtHa/yXFTkNA0suW5jZV5Kmhzt3QGHqyIcD21ThMT3QQ
 n/QMzvfsGqHvDh1Turp7PnOiaCmocS4oqa4GgzLkuGlzDn8uFZuaQ4+1+n6w7AyBaTCS
 o/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187318; x=1717792118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvxnRxIgg2C4FNw5J/4rkmdz86iMxWSW5G+jsM08/4E=;
 b=AEcGG32cMkt+X/BqPszDjySonCxkfYACNoYmgfj5WDDTp7LgN+rAqSJuqmPRHrZWuY
 9qg32c06WhKLw17Fe2w2Sk13M8nM18kT5eIkSChnIkNSQLXiG/WZfRvycTSJQ52jyY31
 AofknHn/Y3YGFkTY2ttjdVU+SaCCZH/uPTGRaaHPiMIIKrliRgdLzhagVpljCg0CRw3g
 5Pxq5lehtkoBSeYT+LV2A0MOhRdbPvFLAuZc3eCmeefv+zGYGjL9LAFQeQZjx39Qyqqm
 fgwFPoD9CtoqtjAZeTpBeM0m61C15aGbGgBlJsNv20uFz0zixZ5/T1WdQjRDikbtIhW2
 Q/qw==
X-Gm-Message-State: AOJu0YwnpHEm7b6IaTRBlhItuaIOC7RkpJdLkaYv1SjtDZ6g2To6iSLW
 mUTtquH37xeR+yXnor5SjoDdloAzD+UeXL+4GhMvI0y6s0BjQUh3KZrNO8S4zNrUdgblt9kx1UR
 S
X-Google-Smtp-Source: AGHT+IECwhHm8hkeK1ZzDPCdT+VYTSe+bLH+52gEz8Ds3fCi49EfRoUVrdLDSh9zogpkFeDv9vT7rg==
X-Received: by 2002:a05:6a00:22cd:b0:6e5:43b5:953b with SMTP id
 d2e1a72fcca58-7024780448bmr3415564b3a.14.1717187318402; 
 Fri, 31 May 2024 13:28:38 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 7/8] hw/riscv/virt.c: imsics DT: add 'qemu,
 imsics' to 'compatible'
Date: Fri, 31 May 2024 17:27:58 -0300
Message-ID: <20240531202759.911601-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

The DT docs for riscv,imsics [1] predicts a 'qemu,imsics' enum in the
'compatible' property.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 56d7e945c6..ac70993679 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -515,6 +515,9 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
     uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
     g_autofree uint32_t *imsic_cells = NULL;
     g_autofree uint32_t *imsic_regs = NULL;
+    static const char * const imsic_compat[2] = {
+        "qemu,imsics", "riscv,imsics"
+    };
 
     imsic_cells = g_new0(uint32_t, ms->smp.cpus * 2);
     imsic_regs = g_new0(uint32_t, socket_count * 4);
@@ -541,7 +544,10 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
     imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
                                  (unsigned long)base_addr);
     qemu_fdt_add_subnode(ms->fdt, imsic_name);
-    qemu_fdt_setprop_string(ms->fdt, imsic_name, "compatible", "riscv,imsics");
+    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
+                                  (char **)&imsic_compat,
+                                  ARRAY_SIZE(imsic_compat));
+
     qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
                           FDT_IMSIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
-- 
2.45.1


