Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91FEFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwt1-00074q-8T; Wed, 29 Apr 2026 00:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwso-0006w5-Kz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsm-0000nI-OF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso3398505ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438242; x=1778043042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7jK/u4DdaFgaTP8Rvh9WoNYZJWw9ae1XuCaZbNk3Mc=;
 b=cBnXY7O6i2VO6X6w3sM39UPd0s1smFbs4eLQ5oWyVKrrs57ObOxWiHXd6gQdtaC8Us
 djVPcl/aRgRukll1NdHUCbXY2Petv3jul8ATgw7LRYY2a8ddmGOFhriYKV+Uc/Bl9zwF
 ZQKk0VabXKyEhmGcQ/8VeTQBeaUvKtFRJj61A3JP62sT89x+MfS08Nl6cFLfsGzFxwj8
 JwhNAgSY00WXo/XwjSPlkaZwBkHRTYL2Mt+tHDu1rDS8fLtZA0c3nwXodF7fhJv5DSMp
 sAXVeMWXiyt60BWCkS5Ndeh0Kk99v7b9tSrV9pDrCgw9WGfb/uxaBDZhfurhr8eTMHD/
 b6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438242; x=1778043042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7jK/u4DdaFgaTP8Rvh9WoNYZJWw9ae1XuCaZbNk3Mc=;
 b=qhgog+SZxLXGgYebe0Pp9rUXGxUCDQilJa+TViFJ5xGbGMJD2hqAUrdBhNiKI77XC2
 HxeSo1YqHveHnXPBFboL4SuyqFPmnrueSUV6a6xsOflY9AZiS0H4XvIQnehPkjGUOK8I
 VHiY9+Qm8cd0mN3Zj5C13hvgOHEfxId6ZrKkHrPxWNCsrXHE+NDtMMeUnTXSdaibOrRe
 U2ZIQ7GmNamIZBqd+gFVG1s35xGrOCaFYQs8i7bWl3kiyH1YXpY0+unUYD2eU+kqgELI
 YLEfV6JgHd3TOUoslgPw5msnbBx4yf4yiIc82ULfagm7JnFU8ipliJ2KsTA+ihTJmdZz
 OupQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/U23ikB6DfEWgGINPZiYRjzkklC7ZhmyHosFHIxgBZaHO209dEMfw7vTeDpLcefTHA5xCBJ8DVLSo9@nongnu.org
X-Gm-Message-State: AOJu0Yx2NZDujWQADR51CSxmdQke/lo4FAxNX+cZEbuPYhs/u3k8Bhlx
 Koxnld1HlK+Yrh3qWsrBBe7dAN7bStKh2jyWC3msaihwTWZoWr3mxZ+U
X-Gm-Gg: AeBDies+1Kmp1A09JsVUVti2pxL3m752wwo1hu37XCodLsYXkqsZUas1yAgvarHzZcD
 SmLV4wQ7W9NniRUzNXweGfCh2r81/fs+Nnm8M85RvsEnqggDr20Tu77SUdMcntoFlGC+zvB+k1P
 mrwgy60f0XLCZ6BT8O7jnh17aePa6dIAvBFwoTpLzkPc/98G2IJNzyi9o5/M++6P60pt88CqP7c
 uasv1EcJ9lHYCU2eOXJoR0InmKXt/L4DnN80Y7scRgGankAfbBkYqibwlDjs/99iMcO5YHybCmI
 bLYkxY1JM+mvoQKiN626wZQtVupCFnS+31kduGtZ8xDbkjnzO7f2NP/YQG2DM+OxTYbApWS/e32
 ypikFuIl3WBkSnTqWtkMMsoiTvSf/rxDzVcOPTP+ccQWmZ9FyYDEtLQK9aWVwDNTeyOITdgDGfU
 83S92kF14QW7QKX4nibe6uahsmAQsQEyLGOK7/bfeZNH9OAOV49trp
X-Received: by 2002:a17:902:c405:b0:2b4:5bf8:a7e1 with SMTP id
 d9443c01a7336-2b9883991abmr16319885ad.6.1777438242115; 
 Tue, 28 Apr 2026 21:50:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 30/51] target/riscv: rvv: Introduce reset_ill_vtype to reset
 illegal vtype CSR
Date: Wed, 29 Apr 2026 14:47:31 +1000
Message-ID: <20260429044752.4176397-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Max Chou <max.chou@sifive.com>

Replace the same vill reset flow by reset_ill_vtype function.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-5-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 63ca6fe16b..1e0cce5ae5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     return reserved;
 }
 
+static inline void reset_ill_vtype(CPURISCVState *env)
+{
+    /* only set vill bit. */
+    env->vill = 1;
+    env->vtype = 0;
+    env->vl = 0;
+    env->vstart = 0;
+}
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2, target_ulong x0)
 {
@@ -93,11 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
@@ -113,11 +118,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
-- 
2.53.0


