Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51171C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfuFR-00012E-9T; Mon, 19 Aug 2024 00:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfuFP-0000yJ-R1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:44:03 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfuFO-00076H-5b
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:44:03 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3dc25b1b5so2034349a91.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724042640; x=1724647440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGsmnqzLC2b2m4nbcn/Jq/WcOMqbgAa0Q2bcHmuaMK4=;
 b=IjHUqzLqE/qh07aA9Ubgyww4ZLhC6cvXVo2MAxkFerdVPoLIyhOyJRY40rkiCO4GgE
 zkKwyOJUFnq+Sh8E1ZtJ22JLJd4na8sNrYlPJJFxtYnhgFZHejPOscysnLveONPiqAmF
 ptca6aGiZTA7FirOrVEyTJs0bBX0w65/71S1oukOe6flL3KDgQWcubcgbgtPtRS/ZHLl
 MLtgSN6DeZfs9qU6rrQXJB78WOcuGWwml+Fd4z7FmU6nhkd7/aEUGz9zwNFQY+ez/Aym
 2TnzJli6YKA3ZwSCUH8PumwcrxCyfLF+HQ2wcDR3WwkcX+982GIrb4WI4mX1ekapm163
 wZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724042640; x=1724647440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGsmnqzLC2b2m4nbcn/Jq/WcOMqbgAa0Q2bcHmuaMK4=;
 b=a4J1R5wVpBQQO2gmha2ttH/mnOlbQ9sHcBky/x85oD56F/ClMgnxkrxMH44n2vGCMS
 i0DrZQa5yZOHeWOpPvnzl7+dBmO97a6jYsakqR7u2Wv0i9JpuNvaTeFP+R9V1fq8dpx8
 TvJyLLWV8QJjrKf1EKKuGkhI9D+Dt1AIy+Kjl88GvQZkUopkgxB/IZKnAIp+/zZFqOgx
 w9+AMKrVtt6uMYfHJxC3gcDtd/bmJ1lN69fopxSt+l4oO4dJjV5WOZcvcpATGi1aIXeB
 w0BYIhPaZV8ODaEif6OIlAUiJC5/RdXY/v+be6pY8rn6dKBOv6Lt+U9CLp4PG+i7Cbw7
 f/fw==
X-Gm-Message-State: AOJu0Ywn1+Q2Pkt7q7+vFFP51sTqd3frNasEd2H30mVmCH+vFgIWCHRf
 PkPZIk7ROsKQI7X73q3PG+LfNCJRUg3+0s+XkJlFaXPuZUL9b6CWdLDxBCIIykY=
X-Google-Smtp-Source: AGHT+IFcvrD5ZK4A5VWBfefmWpNdSOKc5IoaCis5uHW8L5qTxNGFnRICZui6JchydUkxpPPNMCdLqg==
X-Received: by 2002:a17:90b:14e:b0:2d3:c0d4:2c33 with SMTP id
 98e67ed59e1d1-2d3dfc6e82dmr7791170a91.17.1724042640237; 
 Sun, 18 Aug 2024 21:44:00 -0700 (PDT)
Received: from toolbox.alistair23.me ([129.253.180.115])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3c0b87dc8sm8343345a91.38.2024.08.18.21.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 21:43:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 1/1] Revert "hw/riscv/virt.c: imsics DT: add '#msi-cells'"
Date: Mon, 19 Aug 2024 14:43:44 +1000
Message-ID: <20240819044344.2939218-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819044344.2939218-1-alistair.francis@wdc.com>
References: <20240819044344.2939218-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.

Linux does not properly handle '#msi-cells=<0>' when searching for
MSI controllers for PCI devices which results in the devices being
unable to use MSIs. A patch for Linux has been sent[1] but until it,
or something like it, is merged and in distro kernels we should stop
adding the property. It's harmless to stop adding it since the
absence of the property and a value of zero for the property mean
the same thing according to the DT binding definition.

Link: https://lore.kernel.org/all/20240816124957.130017-2-ajones@ventanamicro.com/ # 1
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240816160743.220374-5-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9981e0f6c9..cef41c150a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -552,7 +552,6 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                           FDT_IMSIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
-    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
                      imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
     qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
-- 
2.46.0


