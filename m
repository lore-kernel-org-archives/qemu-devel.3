Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B027DFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcuP-0007Jv-64; Sat, 25 Apr 2026 09:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcu7-000791-HC
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:40 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcu4-000092-Si
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:39 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so7915814b3a.3
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123115; x=1777727915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ds3iAenO+UXvZzQuaJ+VaWdAeqbbsN56XKEzFwIJ67o=;
 b=sOTieoT7iGDU5z/X2eGho6cXeW2q8rRF/oEPknmCsvYZ8ixoJSqsNySyZou4uSrTJY
 gNduhhsit9F2QndHq1/OM69kL7239F2GIwv08p9JfAPfkYEhXWzhdIefaMUz+pLS06TT
 TW4+3oXwsuwPRisoKMlON2WxnXfEBHberlCjHZlWTLmkKfEJKSgK5Ci377GXTAC5tvgb
 rlF8T1wJzaFM7pbO1y0VQV6kfIUb80owfdJ5JKXsrlG2RauKhE/4n5T0r8R6uJt6p0yT
 +gtMhzjL0y/OvuIA5lzzVwbnpes9IjmIbTn7wSFSyj78OPeFGRf5QYExZ9e/yGM7TvED
 qx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123115; x=1777727915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ds3iAenO+UXvZzQuaJ+VaWdAeqbbsN56XKEzFwIJ67o=;
 b=UgO+cfeQS/1l9Qcse5zER0BI3417hJb9Am+qodcBT+4RnFwLXXxhnnXx2aZwgVFfWr
 UnAmcjLkFtSo/MRknUMcZ52vT5sKa6klwUwMuh+oi/YwxmqT9nh+bantM5JH0lPgJoKb
 yepj+x5lf15Wz0a2dPvCdvucDGJPkFFyPd2zCutNINlGfOwq/mUmC7dBUVFvleKmlb2g
 OQgWHzfJEv6sX2dLXT+ze93naqwP1I0ls0ixG/KwRoDalynWFKYEmoPrtAJOU6MWwmAO
 /ZcqVbCN7s3WT/Owb6N7/wAgsyo5OnlNI4ByurEkkd6kexocbMV6fYEv7mP817jbPqe6
 Dyzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xvr8oQd4N86K6OKobP5vdXGeACDi6RfYpVA0JUpre+fxEJ4SDDnBVO+f9MNG7aIekGZJhelZK8L+D@nongnu.org
X-Gm-Message-State: AOJu0YzX7+hFOhRkFvBREYFXlfMBQt1+njs04KPsxjMqVPrsCnGx3w4g
 RqPfEnh0JS6PpB2HNg2xX6k8ac2NMTn4L2OxjcQkJnTY55qHXXvNp09o
X-Gm-Gg: AeBDietmfPvEnFDcEfXnmKjkTkIIcVlSEQ/5dhEBcgkKTfRNt5HyoxqknAne2mOIk2m
 Z6A/UijE33AFYIUNV3HBgT1HNY5BKt50XxDArvzvh2qQde2YXDzSAIIz4hhzB5L26BFC05jBJ/S
 pZKLEB5SLaGxcY3wD2nNKEVepZhFtvK73FegsZ/lBJtjUzpA5470yttebrkhZPQRUhwN9ZVDdXA
 ZF/Kf+UZIn1undF1JG97YGATUZ0Fd328geC7ICN3ke3ZQK0QjD7JVlx/danvG5HCmaTwSZ7JMl/
 yy+T2L3t2BTPXsMRT9yNURWb2x3vHPeYVMwL+WiFQN3IdjRWjrtJVFWNmTS81k3m5ftubSGY0Rs
 XbYgi2J75gAjYEbCE4vWiQ65uahrPk+kpw9XwMWdD/XEQspTLxs1ddZdYB7VosJxCIC/NRltrGZ
 OFpnEMf5MwdmHHu1gn7Ax1fCEnyHl5gnPnj8te7ldcGtq6PnJnjUarwauvUv6EsqUXYhScDHYZt
 Di0zu7lSezD+XIlA/6zfMJi7SNfSPp7f1x5SOLd0gY=
X-Received: by 2002:a05:6a00:418b:b0:82c:7383:3745 with SMTP id
 d2e1a72fcca58-82f8c834458mr38844433b3a.19.1777123115541; 
 Sat, 25 Apr 2026 06:18:35 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:18:33 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 07/13] target/riscv: tt-ascalon: Enable Zkr extension
Date: Sat, 25 Apr 2026 23:17:13 +1000
Message-ID: <20260425131721.932250-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Zkr and the SEED CSR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37de..69649462dd89 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3190,6 +3190,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbs = true,
+        .cfg.ext_zkr = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zvbb = true,
         .cfg.ext_zvbc = true,
-- 
2.47.3


