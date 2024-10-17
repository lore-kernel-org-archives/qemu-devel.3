Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965D7D374A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rrx-0002a8-7G; Thu, 17 Oct 2024 10:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rrv-0002Zl-G9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:52:51 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rrt-0006s4-Pi
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:52:51 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea784aea63so621367a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176768; x=1729781568;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eg+2AFKnUk0+TQpBNtTr72DYLo/5v1jGGUKbtDh4A4=;
 b=UM18RA7i/8/5kufIiSHVg2vH1qv8IDfgveN9KF+eycfmuphNp63qSd1XfwyQQpYMfl
 wq06cwwoHeB0cU0c7xJIfKAvaHp7nJhGyW1kMj0kqhO1lgpE+MOB9iXTKNp7kgoIyCkc
 xgLL0MDfGc+3aaR39NBG0vVbo7htrh94AH8TMlG/TQSLL4Mz1ROtePukhYZjfPwBGU7W
 K2PnXrXF+qGiyly27uhaXllBgdJb99BqVRiiKdFq/k9FH5boZk/9gPjCiT1UFM8jBLIn
 bJc8Cnv7E3euHzn0JmcPrwz91LMnHRYhLvmk9wMcLdlupj4CLUEyzFhzHc6SpoK0AkN9
 aOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176768; x=1729781568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eg+2AFKnUk0+TQpBNtTr72DYLo/5v1jGGUKbtDh4A4=;
 b=Y0mc0el+CO/l61/vtDibOIwKPQKiDn0rIgjcZ05NiupuGIWa93MfFjA6OkFFs0pDxv
 vNLcZO2EFIfGf9RFPR2Z5x3pDi2/vuVqd+ivt5pfUQCyBmmvOaLek5gJ85WcFs3c7QBt
 C55itc1+KSimToTsYzefRGibaA/YvfySLhRom+Yp2gp2tlAH9fY1I7EyGbHbsOgwKOy/
 3Ov/RHvXKNaoCBWtGvk5x220opJkFNvIAlSHPCvAVLrOmwhk661I47Rjd3nylI7Ql+vk
 1PoHNVugoXeUn4evoa5cnUo+cUrjw37G4ydQgfQirorSCUsLDfcPAd9W6c/R5hodVmwC
 9d5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0XPTfj9nXemyLxp9HBu5HRcTOuO2nlL2G8Jj5fnBW+q6JoI64DoqYeu2DiXwvgDJje8yM6a8LGyZB@nongnu.org
X-Gm-Message-State: AOJu0YwR/jXIw1BFzm9iyMb4ZdYuGPQtA675MNPTsuMfh+Ny3OoEMkef
 5yZSU3MNpoEYM8atZwVOp4jccTbxuVx2GKIo807XW68dm4vsQJ37wuHgWtIeBhA=
X-Google-Smtp-Source: AGHT+IGEhPbqJ9/0OpFcNbDpzNRRmPj9I5OQcut0Uop5LuFZe7PvkfhaQYWQZj8HHyB5UjBXKIJJgg==
X-Received: by 2002:a05:6a21:680d:b0:1d9:18af:d150 with SMTP id
 adf61e73a8af0-1d918afd18dmr6080330637.21.1729176768451; 
 Thu, 17 Oct 2024 07:52:48 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:52:47 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 1/9] target/riscv: fix henvcfg potentially containing stale
 bits
Date: Thu, 17 Oct 2024 16:52:12 +0200
Message-ID: <20241017145226.365825-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With the current implementation, if we had the current scenario:
- set bit x in menvcfg
- set bit x in henvcfg
- clear bit x in menvcfg
then, the internal variable env->henvcfg would still contain bit x due
to both a wrong menvcfg mask used in write_henvcfg() as well as a
missing update of henvcfg upon menvcfg update.
This can lead to some wrong interpretation of the context. In order to
update henvcfg upon menvcfg writing, call write_henvcfg() after writing
menvcfg and fix the mask computation used in write_henvcfg() that is
used to mesk env->menvcfg value (which could still lead to some stale
bits). The same mechanism is also applied for henvcfgh writing.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/csr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b84b436151..9e832e0b39 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
@@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
 
     return RISCV_EXCP_NONE;
 }
@@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
@@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
+    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
+    uint64_t menvcfg_mask = 0;
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
@@ -2443,10 +2450,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
+        mask |= env->menvcfg & menvcfg_mask;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
+    env->henvcfg = (env->henvcfg & ~menvcfg_mask) | (val & mask);
 
     return RISCV_EXCP_NONE;
 }
@@ -2469,8 +2477,9 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
-    uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
+    uint64_t menvcfg_mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
                                     HENVCFG_ADUE);
+    uint64_t mask = env->menvcfg & menvcfg_mask;
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
 
@@ -2479,7 +2488,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
+    env->henvcfg = (env->henvcfg & ~menvcfg_mask) | (valh & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.45.2


