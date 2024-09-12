Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C777EEB56A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofVt-0003Sp-KH; Thu, 12 Sep 2024 04:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVV-0001rs-UM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVS-0000LQ-FB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so6231975e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130928; x=1726735728;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLp4r6f6llKlFkIQR3exhrK8GnjMUvUuiR9NnPTHniw=;
 b=AYS1Pddq9/vBZAXbWjW5SMDBExYN5+scNE7h4yRmCOGPZ6X3QdiWfUPvCH7I/ULzB5
 9WCTPGwXL5KMxP42WyKaX6HK0Lpl6nKRp/dz9fSwxkqzZzMRn85p97Ew/6f7yvxC1M3Q
 gUrnVuPHHNdqvY3T/z7MwFYcn2zjDxrUA1IBpBW1le01dOHjv6hqeYMotxy9ZhgGTqEa
 D+G6elOXJVOgmPd29SxMkpXLeXPUy6CEi/2sHTjqAnkMxVEX+V3bH6AEf/AL41h3nRCB
 BJBs4NcI/PLGzis0UEsw1BJAFesneYG74/da2CtWcJIqL+mi/K8UmzWCsoYnaUC+ysHz
 Cpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130928; x=1726735728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLp4r6f6llKlFkIQR3exhrK8GnjMUvUuiR9NnPTHniw=;
 b=gBxxD87czxWj7nfgrFAlxL7xo5KsuXp+9B1eVHF6m9TqKwwaJJuKF1imTmQyplAyIo
 Og4IzRfk2Iu0WuCd/A78Vz2XtQpUEKxWL7yfFKHDI32q/D6i2pl1BeYfRs3kslPiTKMS
 m6GnH3F7uq5KizhoxJzzuLjL+2TWB4e45lyZY7qHIVplpZr+aiJ4Oo3U9JDEiDfbCpVA
 UdbX9CUuJX+BW1YG36CPb4k3yjBePg066GP3f53pC6SYV3HK66g4d+i7c2HRyCjgGXwV
 VT/1qjkESyYtB52ZYqJFDo3/vfudoFx8Ck1bRLEnQbk6yso2uLrYivCltm6knBlJB37o
 w1Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3O/tda52E+bjcsZfC48uuiN3Uj9VVFMc4SEOlbu2eTp0+i7/nqx2xCb9A8fWyvYGc1RnPKcnWlcJa@nongnu.org
X-Gm-Message-State: AOJu0YxSLqC7uTEr8SnqCH0ECUBiOQsU2F7StkpW/LmI/hlX1l+dXlJx
 VcPSrlqEW5GYCik8D/BtS7sXFtekiCP+g6aju4MwYgGG47QdHH3xqc0CjvxjdIs=
X-Google-Smtp-Source: AGHT+IHBquSqPnlqqdkiF+kFXUuJDuWraYNQdq7vAriOAfcRap6bRouIlU1J2MGdiYd9ta24uFNpiQ==
X-Received: by 2002:a05:600c:5251:b0:42c:b995:20d9 with SMTP id
 5b1f17b1804b1-42cdb56dc28mr15917775e9.28.1726130927996; 
 Thu, 12 Sep 2024 01:48:47 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:47 -0700 (PDT)
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
Subject: [PATCH 08/10] target/riscv: Implement Smdbltrp sret,
 mret and mnret behavior
Date: Thu, 12 Sep 2024 10:48:27 +0200
Message-ID: <20240912084832.2906991-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x329.google.com
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
index 00b6f75102..9d0911f697 100644
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
@@ -416,6 +422,12 @@ target_ulong helper_mnret(CPURISCVState *env)
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


