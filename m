Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278DFCAC599
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4mT-00081s-Qj; Mon, 15 Sep 2025 04:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4m9-0007bh-1d
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lo-0002Q4-Gu
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77615d6af4fso3174225b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925665; x=1758530465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w59KJPz36Tnsb1mWpiOvhUSWgpS/ZJf1PArkuJeC/pE=;
 b=DQBpBJLQLIZ7V2p61l5uN68joOdmT2JeuVsKPw21i1EuEFHqBWQqUypozJkf+VgYY+
 95iOeO/SwE5e9vPMu5Pc0fu0ChUU/x8XPV/LWpYYDENy0BBHmK3nl9bVfABJZUx3/NSF
 csGOqlahQpbyxD5XTgpZofFdwS5e0u3Gk9CKRelz6z+3Rrm3YqHVHtsNwSV9Gvtjnf3N
 JhIM2ZGAVgXHXbks3OJQf3ZHoA/EgsQiDkCYlw2dzGp/1BDDukfhDJWCNlmwfalRm/x9
 0K8RTVR1HScUGA1cbvo6LaaxRdNRBPcHfdVmcQcU6YleCWe9Np6THMQYLBRklCXUzJZE
 0tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925665; x=1758530465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w59KJPz36Tnsb1mWpiOvhUSWgpS/ZJf1PArkuJeC/pE=;
 b=SnfXPWbpSpJyyY8nWU5bwvbzHoXZR9S3rEz2V1zUvnoVx0uy/IA0obp+diQsjOldzJ
 Yn7ltHqebQQWOA+Ij5TYciAzwdt+AjHZ7hitHyWJuy8AryX/dQCg2P/f4tveN17ogggB
 GsVacsfCs9yYLrobMjJ1J0TLAbj0jQxmTwMC2LvwQ45XLxQ/uPH/tfFinxAOMNhOPlY+
 Ge3KPDApN5EKhJcGYmO3DRuhfft4SPEv4Mhaq7hYtAb8W6fUlw8BgcCD7idM2Ys6bNlV
 z2upykDezFzazvwVjkBw1XScXmh/W2YdQm+1ioipVBDvUi1Fd6TlfLtOv6L0gN2FDNvU
 cB9g==
X-Gm-Message-State: AOJu0YysoTQ9IaQ9sgAT+yT32RB9A0EjB8h1Sy7/HqJyxZ+Yt1FZB1M7
 8a3AqyrRQ+D5zGJkMkI+DCzl8ZCWXNpdged47nrLJ09ZXfG6HQVRdcAdHqM/rVfuXSIDmZVj97J
 TreDSA+PrSwQ/W9C43xPx5gqlZnkLzKmIl+1E4sS6Tj1GF7VUIUcTbdWliiUbmfpykuVHZHC2S2
 ROM0dpwFc9gxDFyPkjMCfmZXsuKIMQ3Pdsh2X+2nJX4A==
X-Gm-Gg: ASbGncvyu1zgbyfGjBDl9YWkRyzAFcS5nS4pRNQQtfqE+Hk0aCvfO2TUx5Mds/KAe+A
 7KUl2XcCozFHfXNCPKvleLEJQ/xr11UM4OU/+5gS82ruRS8TrPsL4v+33hynlmARvctR1zL7GLn
 +ZZG+M/Ob35PX6hDqXpi9RV7+KFR5I6tGGDDInAUQK+t2LSOxqQ/d7PtogZrwxWC/Vojv0Qblpz
 mQkryZ/VIN6wVdRL1I8/kQ4rckXVPTjis56TAz4eh4FC5sXwEJhqTg71wHvTjVZScBy4Lyo1uAn
 EQ/PFBA56je4+KtxyJbH0Mc9oDw3R6ETWH6SgUQcSisgINSzusyXkKNWtU1wMwJ4j2wMVL+PIyC
 pJiP1gQPAIdGPj5CRPu26losZDHQh0zEXPDJmUEY9OHbzM97+yKTfOLfrkw1wtTv6Qlc=
X-Google-Smtp-Source: AGHT+IHzJ4OefIkhkFN84al22APEs+lLf7cQMJ5R32Zs4+hwnM+OEAixu3JfZNRx+iKieDZOk9dVFg==
X-Received: by 2002:a17:902:cecf:b0:246:cf6a:f00f with SMTP id
 d9443c01a7336-25d2647015dmr155621335ad.31.1757925665000; 
 Mon, 15 Sep 2025 01:41:05 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:41:04 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 5/8] target/riscv: Introduce altfmt into DisasContext
Date: Mon, 15 Sep 2025 16:40:33 +0800
Message-ID: <20250915084037.1816893-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915084037.1816893-1-max.chou@sifive.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2a..8ad147946c9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -100,6 +100,7 @@ typedef struct DisasContext {
     bool cfg_vta_all_1s;
     bool vstart_eq_zero;
     bool vl_eq_vlmax;
+    bool altfmt;
     CPUState *cs;
     TCGv zero;
     /* actual address width */
@@ -1281,6 +1282,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
 
     ctx->pc_save = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
@@ -1300,6 +1302,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
+    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
-- 
2.43.0


