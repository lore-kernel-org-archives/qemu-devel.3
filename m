Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4CAC021B9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTlt-0000M0-6K; Mon, 24 Feb 2025 03:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlk-0000Fz-Vi
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:53 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlj-0001CH-1m
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:52 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2210d92292eso121843545ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740385489; x=1740990289; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KrqoTxsIbTe1eFZuZfpt0EkzCEKWtzl1UCfgmQ9eTvw=;
 b=RIq80Msy5QGT+ggf86lshkCuaAAO3FUCTSFNMGFW+z7G+62n4d3/yZq2NXHZz7tZtq
 3tGLMVj+YRDM9CDNZomESWXX9qbzgaf0+sOi7soLE6BDMIP/X4BtC+xOsLD6yEnZSVKo
 28BitcAkArcDDN+OqUTkNZlwl0RdMycS8XG16t0ruIAEYrzBsoqLJv000GxWZCQ7rkjy
 a/y6O4eMOPhTLYmRyBuvW3xj7u7j+uYDwwwPZp+2OQvg0OXVgQxYh7FOiZHTor1NrVHc
 i4x/7lc7fi3EhQ4GQjByJ/Aq8WApl+553lmPnOqqcBO4Aeh37bMzDRg/sIMXFGSFSms7
 lxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385489; x=1740990289;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KrqoTxsIbTe1eFZuZfpt0EkzCEKWtzl1UCfgmQ9eTvw=;
 b=SrzKcar9s/MjoSGoG0VrQ09bP1gX1CSIrDUqhrtBgcKtzX2lYmSRJ5Gsa5Qsd7179A
 PxCf0GIsuh6nNecloBV8n4anPhn/MFh6dRjlEls8+DhMyGzes8moWBL66CkDc/37Sch7
 kTpSGVPXX+BjvJNPueltv4cWNtv8Gzu1Xuapc6byjrC9ue+bs6t+9zEdcG1q7PLCzQiY
 0ULbXRqtox69/b3mAXPl732m1PF2klDvKlXdkD/2kptpROwkzHr6Oxa3Oaq2+AnxU8Uu
 aoNK0MFANsyAZKF5Rjc4pmOwtOYw98AUc3RwClI2iSW0INnmsdaLhcCLiqxzUSeG1DP2
 b1ug==
X-Gm-Message-State: AOJu0YyqBSpkuvCO/3tnebaxL/1JZRcWz47zxHtw1ArBkQ4nULGjYB6S
 8paTKihsh/a/QkXWuVEUNMMz7OhCfr9GUI0KBYjPWp6/BCbMvksJ1lYoyrtEp/6qFGFYBNicrUK
 0X7kFGSDv1RL0lJ6klH+m4s8N0SrWLuinXG20uKIgtj2KmFOTPB5LLK7UTmMu4xyzGJHSsRzG5Q
 zEl53WVmGT3uPxPkchqampJtzWfTX3EZXY0gJCm0ZPoQ==
X-Gm-Gg: ASbGncvauCRjc0WH0Fo3CK0UCZ1RUaJd+zAMuAPfdRpf8mZFg3k2HtcNIDfvTXnB4bj
 qLz8thf+e0Y3r1Nui3V8pjNKvDFQuWTXzj8cBOleUhoC6n6XG1c3cTqGln93YQZr8tHIYvvVBBF
 Z/Pkher/eA60eVGpxACfdBZZ//fQr5Gp6V3b5YJU/Jau2AHzs68mBc2NBdt3iFFgCMWp7bPDCxb
 PCOPjkvvAsYr8JQqfQRwM53OcTvYBuCMpwTiNpux537/78jUdl6JtWtDsGD/vYc0XbqA0P6sxKO
 +X4+odUb1x0IMtUAjKXQvoy/QY3F8QDRAsv7j7U0oABkb8NhWU/rPhiR
X-Google-Smtp-Source: AGHT+IGjH/BQi3tAyYa2ZKm8trvfQ3aVH+LXY8Fjnh9aGJG61UkeaPcdTC2CdkykPoDwTSzfKFXGNQ==
X-Received: by 2002:a05:6a00:2d07:b0:728:e906:e446 with SMTP id
 d2e1a72fcca58-73426daad0cmr19196912b3a.24.1740385489359; 
 Mon, 24 Feb 2025 00:24:49 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325c88d74esm17714914b3a.149.2025.02.24.00.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 00:24:48 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/8] target/riscv/kvm: rewrite kvm_riscv_handle_csr
Date: Mon, 24 Feb 2025 16:24:12 +0800
Message-Id: <20250224082417.31382-6-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224082417.31382-1-yongxuan.wang@sifive.com>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rewrite the kvm_riscv_handle_csr() to support additional CSR emulation
in user space with KVM acceleration. This update reuses the TCG CSR
emulation function to simplify the implementation and reduce the
redundant work. Also it introduces two hook functions for certain CSRs.
Before emulation, the related VS mode context of the CSR can be loaded
from host in context_load() hook. After the CSR handling, the modified
VS context is written back in context_put() hook.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/cpu.h         |  2 --
 target/riscv/csr.c         | 18 +++-------
 target/riscv/kvm/kvm-cpu.c | 68 ++++++++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index df10ff63474b..81b8081d81e0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -928,8 +928,6 @@ static inline const char *riscv_get_csr_name(int csr_no)
 }
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask);
 
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d0068ce98c15..a2830888d010 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5389,8 +5389,10 @@ static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
 #endif
 
 /* Crypto Extension */
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask)
+static RISCVException rmw_seed(CPURISCVState *env, int csrno,
+                               target_ulong *ret_value,
+                               target_ulong new_value,
+                               target_ulong write_mask)
 {
     uint16_t random_v;
     Error *random_e = NULL;
@@ -5414,18 +5416,6 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
         rval = random_v | SEED_OPST_ES16;
     }
 
-    return rval;
-}
-
-static RISCVException rmw_seed(CPURISCVState *env, int csrno,
-                               target_ulong *ret_value,
-                               target_ulong new_value,
-                               target_ulong write_mask)
-{
-    target_ulong rval;
-
-    rval = riscv_new_csr_seed(new_value, write_mask);
-
     if (ret_value) {
         *ret_value = rval;
     }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index d421c7a1b65d..b088b947adae 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1626,26 +1626,72 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
+/* User-space CSR emulation */
+struct kvm_riscv_emu_csr_data {
+    target_ulong csr_num;
+    int (*context_load)(CPUState *cs);
+    int (*context_put)(CPUState *cs);
+};
+
+struct kvm_riscv_emu_csr_data kvm_riscv_emu_csr_data[] = {
+    { CSR_SEED, NULL, NULL },
+};
+
 static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
 {
+    CPURISCVState *env = cpu_env(cs);
     target_ulong csr_num = run->riscv_csr.csr_num;
     target_ulong new_value = run->riscv_csr.new_value;
     target_ulong write_mask = run->riscv_csr.write_mask;
-    int ret = 0;
+    struct kvm_riscv_emu_csr_data *emu_csr_data = NULL;
+    target_ulong ret_value;
+    RISCVException ret_excp;
+    int i, ret;
 
-    switch (csr_num) {
-    case CSR_SEED:
-        run->riscv_csr.ret_value = riscv_new_csr_seed(new_value, write_mask);
-        break;
-    default:
+    for (i = 0; i < ARRAY_SIZE(kvm_riscv_emu_csr_data); i++) {
+        if (csr_num == kvm_riscv_emu_csr_data[i].csr_num) {
+            emu_csr_data = &kvm_riscv_emu_csr_data[i];
+
+            break;
+        }
+    }
+
+    if (!emu_csr_data) {
         qemu_log_mask(LOG_UNIMP,
-                      "%s: un-handled CSR EXIT for CSR %lx\n",
-                      __func__, csr_num);
-        ret = -1;
-        break;
+                      "%s: un-handled CSR EXIT for CSR %s\n",
+                      __func__, riscv_get_csr_name(csr_num));
+
+        return -1;
     }
 
-    return ret;
+    if (emu_csr_data->context_load) {
+        ret = emu_csr_data->context_load(cs);
+        if (ret) {
+            goto handle_failed;
+        }
+    }
+
+    ret_excp = riscv_csrrw(env, csr_num, &ret_value, new_value, write_mask);
+    if (ret_excp != RISCV_EXCP_NONE) {
+        goto handle_failed;
+    }
+    run->riscv_csr.ret_value = ret_value;
+
+    if (emu_csr_data->context_put) {
+        ret = emu_csr_data->context_put(cs);
+        if (ret) {
+            goto handle_failed;
+        }
+    }
+
+    return 0;
+
+handle_failed:
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: failed to handle CSR EXIT for CSR %s\n",
+                  __func__, riscv_get_csr_name(csr_num));
+
+    return -1;
 }
 
 static bool kvm_riscv_handle_debug(CPUState *cs)
-- 
2.17.1


