Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3744EFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwuF-0001UG-0r; Wed, 29 Apr 2026 00:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwu1-0000x9-42
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwty-000179-9Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b24fede2acso80046105ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438317; x=1778043117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9DymTxIeXo8zUEFCFX6E1SMqxSkLlASH4pmiq50A40=;
 b=ZQ/3elzkLpBwGGPVg2mtfBivIO8rKD8BYfSMG0VhupoAyytuWTugRsJRAniTTbw20G
 TjrlN6lqVsbd38Z3R+izwQ/WY3N8mlzeQt3mJ+ppxWewcZizzJy+V9lyeN01Tjdq1gAq
 76Uqy0RVAby1oIb7PymI6Q/YFGeXXhI8fNnW29xMEGt5IRIktjUVvQLX7C6QB9vL+yLA
 ca477ITAFYIAR/GE74mlpA03g9R/Nun/CxHEAY/XSj7mPGhahy0Thg5xW5vQ3Ds5fUe9
 IEoguA8FwBdPXOU35UjXHTqfF+koE1AxYDq8iIERiF0UeEgA3jE2zdOdfyY/u7LeVhgB
 7N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438317; x=1778043117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g9DymTxIeXo8zUEFCFX6E1SMqxSkLlASH4pmiq50A40=;
 b=AGOj5CFGiop3LxVLYC1KsxI7BDc9BVbHud2cHuXiQGHETly6BGB1Cgs5wszUkHygVE
 buQe7/aBSBoKfVl6qjHM0tuXXbKxNj8KoFzag4dpkiKTDwWtBKpyL8ttUULm5iVkODpZ
 sADdZ6P3XSErLiJ7VwEanbSokEK++Ui6p/v/FtuWq5ue738hCZav0X7ql8Lo0scOFthu
 isa8uAf6+GWISSNISqm3TsHBXeS+v1Nrfhsf9T7L4t2XoT6LuRrhxqwmpfEdlLXElZPx
 4mCYlGyP+uBrOa42S2jw/Fx7yqxgoMpWjgvJWWic9/ppnaAaF/EeB2hZJFDkLzuH6asN
 c6LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QsJ18+2KtRY6w5qC6vXwDzvljeeNnb45QXGfbuQbbNZtQMsTFTXwuhi1W2tq6uQ6EVqTPNmSIK+sT@nongnu.org
X-Gm-Message-State: AOJu0YwsoMduptaPSEOrjE2vqN6cxZL4cXCz8p4PuHzZpS2MpbveCOA/
 gV+pZ+3Mhyi/MajjR4dHXl+Edkm2R1QhuXYxoAJ2Xt3TmiOIKe8k4gtR
X-Gm-Gg: AeBDievz4a+tLWQ4b5zZnwnSPgVZsEu8+U1OgS8YACZdVHH03wEeBWU5QUFrCTHZvJ7
 spNuIMWh2bQgAc0gtNosBO8oHL5GjhR2rlpHafxq4y2h9ax7nnrl0sOc2yHygjCDpLW8UZ0A1QC
 3Ujk4DBbAcVqK4S+U+M5ZaZ8GQkm/wa1mO9IWHVbykpbkdgvTJNAbycXVsEs4vrWUISSoARV3kk
 ds6SYQRlgqKOWsRZgbA0TgGmzXtMsufwlOfFnC8eVDM7aMs4b162+uXr161g8VQ8yLo5D1dLU3s
 5ZlV5f216NhAnJA1X0UxGIal2gRFR7pAVX5vwLi2Or2/sx7oi6cP1XkIvC3RIWQT4HthH8cdSdu
 HZdgV7VFTf//Qqr3GVae4GRAviDjqekC851A+Pz2EeaA9WoUjZl2b6lbSTnemfB2u3itTX0eTKX
 a07fwHHFJS5Y87ll5MFkpbZJY42uOHDKXZOJunBJRZX2BpHAKRUm7h
X-Received: by 2002:a17:903:1b2e:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b98733d3e1mr19772065ad.15.1777438317009; 
 Tue, 28 Apr 2026 21:51:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/51] target/riscv: fix address masking
Date: Wed, 29 Apr 2026 14:47:46 +1000
Message-ID: <20260429044752.4176397-46-alistair.francis@wdc.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The pmlen should get the corresponding value before shifting address.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421093715.2995067-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index ab8dea45c9..d090db2641 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -222,8 +222,8 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
     if (!is_virt_addr) {
         signext = riscv_cpu_virt_mem_enabled(env);
     }
-    addr = addr << pmlen;
     pmlen = riscv_pm_get_pmlen(pmm);
+    addr = addr << pmlen;
 
     /* sign/zero extend masked address by N-1 bit */
     if (signext) {
-- 
2.53.0


