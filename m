Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EAED374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rsg-0003lt-04; Thu, 17 Oct 2024 10:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rsc-0003iM-L3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:35 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rsb-000708-0Z
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:34 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso716891a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176812; x=1729781612;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2s51bbIA+3Sg7MDcZ62+3olj5EFQQVwUP1bfkF2EpU=;
 b=0gYX7VG/jYmaFL5PiWmambo5IYL+xKYRmN8zPJZ76UXGBcY6pMWNeiZYxxB2Lx9/HY
 25E6puPaj/GM2WL4OPXOAVzsxM+VqnMLem+5xxKRwxdgy+I67dWHlK1vJMAnHRTvQ7PC
 EfqtgtvTHhgcDvPWv1V+Z36vr+6HFnP0NN0RmTVrX6eXWT1BASNlqQWyQuboNbbHCjKz
 EhrvrVj41FiAqESHR8sDji3RFGaECFIowx43pTzBVyPCbXOglWIKhwqCPlNFcNzDtWVX
 cGZRknChzZW0iHeag1FEJLOWEANeqzFTTXvXeqgM1tT/fpwRLI0bB+PRhogHTaZt+SEr
 HLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176812; x=1729781612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2s51bbIA+3Sg7MDcZ62+3olj5EFQQVwUP1bfkF2EpU=;
 b=e/mZAFX6NwA54EAWI/8ard9jy/CD+fapoYy8cPC1tw/NwxBA86uMwS5Zg6lvvNmxBR
 pOlmvNfVHO3ZKzGfKV5ilTCANrB1cXhivScM5k2WS0Zqad6natyFwuzsqKxNZinGDhYV
 raYixECmlJ1JCSFmag5A6FJLARwYorV5W3+0QAHBq/MXDg+xiwXbhsW6HTtX/dWvJQXh
 8Eq4h7bWuUPtRpzaodkoz5AkZ4IBhOARMbOaU4kUYsUuY37/mrhHV0Ek32BCLR9DTo6S
 dBt/ijtoFEIZJ2YKpfPwQg9IvTX1y2Zi2taoyyKlgCp2IT73exyS27THLHJNaYHLvsUm
 NoGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKQWUunZ87bE9sKDRyBNs2h9Q2IjNoHn4txksSG8P8e4Et1Bn/LAMYWS/isekvFbSwxKy2DUDhTrgR@nongnu.org
X-Gm-Message-State: AOJu0YyPPztJXKZqSIVNVrn4XqAY5aT31CoUV6uVXQ+t24+FergbFuRr
 BZ/iS+OkuxFDS9SyWckGWaY1b+7lIWZsVNECHRiAyjOjr5D1Rs7ysQfsx8A+hXI=
X-Google-Smtp-Source: AGHT+IEuiAZBrH6mkYBM690ikUM4r78bHha+WLIH2Nxr16orOxO27pgdwoEI39nxS20uRkjORcJk6Q==
X-Received: by 2002:a05:6a21:3990:b0:1d9:2408:aa4c with SMTP id
 adf61e73a8af0-1d92408b3f0mr2404315637.23.1729176811731; 
 Thu, 17 Oct 2024 07:53:31 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:53:31 -0700 (PDT)
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
Subject: [PATCH v4 7/9] target/riscv: Implement Smdbltrp sret,
 mret and mnret behavior
Date: Thu, 17 Oct 2024 16:52:18 +0200
Message-ID: <20241017145226.365825-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x529.google.com
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

When the Ssdbltrp extension is enabled, SSTATUS.MDT field is cleared
when executing sret if executed in M-mode. When executing mret/mnret,
SSTATUS.MDT is cleared.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/op_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index dabc74de39..64c5792af8 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -299,6 +299,9 @@ target_ulong helper_sret(CPURISCVState *env)
         }
         mstatus = set_field(mstatus, MSTATUS_SDT, 0);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp && env->priv >= PRV_M) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -375,6 +378,9 @@ target_ulong helper_mret(CPURISCVState *env)
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -412,6 +418,12 @@ target_ulong helper_mnret(CPURISCVState *env)
         env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        if (prev_priv < PRV_M) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, false);
+        }
+    }
+
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
     }
-- 
2.45.2


