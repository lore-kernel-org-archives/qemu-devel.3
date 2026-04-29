Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2DCFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwsE-0004vZ-0w; Wed, 29 Apr 2026 00:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsC-0004rU-IC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsB-0000Mo-0k
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so53035935ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438205; x=1778043005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LT1/EJ4TmcNjWWSWxvrhRM1oUkyUaxsMz6fDhIwFOg=;
 b=fz4BG+bGwBVYlMHfjfbxzbaglFp3atiGW1sYJqELE8H1F3zLfqQVu7i9ILHQRqxIPb
 oNusGJx7TZChTvf2zCuIx35fLKQHSFtQo9W+ctTmUj9vX7k0AQAyP3NcnlJk7b23PvYH
 ErKHkKeNKUq3djenFDxNWZCA2p4BGWfZAhDaFymmneiaRjUCbeeWNgf1K958dQ0b7sdv
 0yX/oBp0r4qltOAnI6Rzzk9e2Vnktkv5unoHHMnZDNIGT1EV9/YNSb/alUj1NscRliHV
 F0EanEBAOEvtTxRzxf0QjqrUTtr0S6i8o6IhcwprNNWlfsiPpPHC6NWs33Oi4DRkjbRn
 AyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438205; x=1778043005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6LT1/EJ4TmcNjWWSWxvrhRM1oUkyUaxsMz6fDhIwFOg=;
 b=gWSEB9BU4yCNXFVNJpxNYlYdfSalHj4Rz3pAB822f7+Lfcx4nUAyCdS64qg7Kwhv9t
 H1HKNExhcSOCK+EDGi9Dx56dhGIwJMmX+e5NuT3tCnmXh1U5h5OfvtKu9jUWYf6jrbcw
 dgjMgkoMVmhoorCxaW0TR7R6dcWatR+taxVcABoEj9MVVGT6ibY2ona1hgJUOodYizll
 fgFggLFBxCKOYzO/E0b2p3hlDwIjdLkqiDgIhPuKoa6AiU5hwptnMR5ihD8+9PsZohbn
 FAEhhQXO/EoLH9ge4eKOSEdQn9xoC5TFMZtYTtpo++++x7kVBCeZS1ecU8L8fK9L1hLp
 5ZBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lV3okcGJa296ihZfvvpmHzi6GhvFsn3jvobSJZPU0+6ZI/caMQPr8OcW7PgW7N0RRc7E9iqZDU9tE@nongnu.org
X-Gm-Message-State: AOJu0Yw8cxqxSXZKqxY0U1vNlBjzO0TAz2YiSZBavsAxC/lN1+MWCYz3
 wQAcsOODZL9BxW3JRh40Vy/LPrHLWmgaLhpe+pv6L3eyWIzbOfOiJ8RJ
X-Gm-Gg: AeBDievjyOZZGR2QGSOwCZv5IFhFn70UImEXyv6h0zLG2d2LFmbEkSirDO4QQDmYdcN
 nEe1gPw5zXPfo6u3NAlLgKYkKB5yK6WYUUvG+7mKTzvuyhLkUk7NTUb7IzC1ZD6fUsSTXpRMcfw
 GpJ5OjfdlET1Sp+Tme3wS7A/HlrNIufbRwEDelHbBjNLCrpMgNsJL66B0p/x4pnBkqp3gfEhswJ
 Fzhy3VeTMj1qLwRR8LdEfc/AkFM4dkauNKw+Fqni0pgOk4pdzSkqAiP1WbPC9OtEBQUXGnj8/tF
 G62U8W936jL7wyOkkqSHTrn0Z5ARQxBQy6f58ZEU42f7c2sVmJADE3e12VAAOIlL2sx6QeSYyhy
 W1/VuUl5+7xnncNirANlSVQAP1jpw090MJQ9pA3ttfED+ZtNKFayJLlKTjEw2r48nl2FJs7k/Yy
 F7bXKDy60JFgP+nJNolEU0/CyVAKwQa/1FxmiHbaUFnqvrEhb2iJLXf8uXRq83USo=
X-Received: by 2002:a17:902:f212:b0:2b4:5743:2395 with SMTP id
 d9443c01a7336-2b97c4b2a2fmr41125825ad.19.1777438205527; 
 Tue, 28 Apr 2026 21:50:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/51] target/riscv: fix stale ptshift and base on page walk
 restart
Date: Wed, 29 Apr 2026 14:47:24 +1000
Message-ID: <20260429044752.4176397-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

When the atomic compare-and-swap for updating A/D bits in the page
table entry fails due to a concurrent PTE modification by another
vCPU, get_physical_address() jumps to the 'restart' label to re-walk
the page table from the root.

However, neither 'ptshift' nor 'base' are re-initialized before the
restart. After the walk completes, ptshift has been decremented to
its final value and base has been overwritten with an inner PTE PPN.
On goto restart, the for loop resets i=0 but ptshift and base remain
stale, causing the restarted walk to compute incorrect PTE addresses.

In an SMP guest with MTTCG and Svadu active, this can result in
incorrect physical address mappings or guest crashes.

Fix by saving the root base address and re-initializing both ptshift
and base on each restart.

Fixes: 0c3e702aca ("RISC-V CPU Helpers")
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260401053853.10473-1-sebasjosue84@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c28832e0e3..659150c646 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1316,12 +1316,15 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         adue = adue && (env->henvcfg & HENVCFG_ADUE);
     }
 
-    int ptshift = (levels - 1) * ptidxbits;
+    int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    const hwaddr base_root = base;
     int i;
 
  restart:
+    ptshift = (levels - 1) * ptidxbits;
+    base = base_root;
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
         target_ulong idx;
         if (i == 0) {
-- 
2.53.0


