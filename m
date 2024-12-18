Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18005E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2aq-0004iy-0L; Wed, 18 Dec 2024 17:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aF-00045a-9E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:06 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aC-0003UR-To
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:58 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21636268e43so2080735ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561115; x=1735165915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQS//T0GoR55hAf+FcAjZTbaJGtVUJI7ZxjrQ9eUp70=;
 b=j28NhCSZzqf3UEAQ4J7MsoSTNX+qsBMv82MtxJfeZCksLPyF8tC9lqL8bnABTuCVu4
 tN1aqezco5ER1lmZCI6A7+rszsebjdEE0O7vs2V08rc24Aiw/tUjNlwSVuKB6kkBSfBn
 RNySybOh4cHvX2x1eSHyT/lIQ3oJirxSv0sGKcCjQs458jMptmiUzdzsUUwN/Zfv8pwK
 +IEjLcyubeuIwU/p1/ZQn/NWRqYajQAT1/dOFW/J6R2Tpooc7PUoJG5SHUAwrLo/VwMp
 SM2D5atf5tpTf9EAgAoIhmO5xNra9ngBdD4GuGCAzkCk4P9yTN6h5RWN8kNNtBS/YArB
 cVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561115; x=1735165915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQS//T0GoR55hAf+FcAjZTbaJGtVUJI7ZxjrQ9eUp70=;
 b=t6LSm9pRllcVMzJvhrI2nOrbCe3dUQ3y0XgVh0D5x+KQg5vVd6m15S7kfeO0PpCUCg
 qaj3SGBUT1Iwawj5cWGdxxy4StNJoq/HeQcbtEym4ie2S2UAzDxE+4BEdUPvQM8q6zza
 opJWu9u0aSS+fTQb+m4b3wEZzled9yfOTBEc9LzhR1c8+ebadWs35bU+LmBc+0SbErCH
 Gd4N4n46hBeQGAAG+/GEmm6r2eQiBXKMWeewOhtExnPUqcwKAVw+45QQ1SXXp0qf3rIc
 iNCthaJBk3nkpR4i5itT7/wQQtCkHfmPuX0J/Uk0/cLXjqqhdeBjWEtVN8acZLZ2g/+7
 r+ag==
X-Gm-Message-State: AOJu0YzYGi8li7pGI6mSlMoklwlxxoassif0Uymw3Mvu1WyQB8G6FsSL
 mqaVWjHJEZkUk3QjRdNePA+9eA9VZpmdRKQUs3uFI9DeGglNJ6CJGsfw74SC
X-Gm-Gg: ASbGncsuBuNOLbAZ9h+uy6QO7CqQEPKtmJTPWqYi8PRKyVV+nZyl9gLDe2V1yBx5IK3
 8aCJqFIbfvL5N6LzKbzZIsS8FQl0RiigXkVrGfj9YLCs/5EFwMDe0bM+p4rjs9IJtEUzU7VoVFt
 PRqtcwkNAzo6xkLefwx6JWBlhWIOsGuuMPoztitHsSQYcHy99UiIcD4ppjUk0EcTQ3EmbSujo1H
 Ua30c0/zXiNgTMyVKHcFZsssTFN3UOmQNH5/Es6VLtVXKtoNAqsnAzspuLE0p4jyecBRmVw5+Gi
 Gg/nJcDI1M+P5AG2zeu9xQjg9ki9LeXOX1GJpuv1g/Yh7qxpFYt45eiEE7yqArQ=
X-Google-Smtp-Source: AGHT+IF5+HkwQygOaNKbghVRI60s/aS0/ub2pZtI7KrfVAadqMRlb67gbVgv+02w1ALA0TbXYjW7/w==
X-Received: by 2002:a17:902:d2ca:b0:215:8695:ef91 with SMTP id
 d9443c01a7336-219d965c6c8mr16156645ad.6.1734561115171; 
 Wed, 18 Dec 2024 14:31:55 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Jim Shu <jim.shu@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/39] target/riscv: Check memory access to meet svukte rule
Date: Thu, 19 Dec 2024 08:30:02 +1000
Message-ID: <20241218223010.1931245-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Follow the Svukte spec, do the memory access address checking

1. Include instruction fetches or explicit memory accesses
2. System run in effective privilege U or VU
3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
instruction is HLV, HLVX, HSV and execute from U mode to VU mode
4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
5. Raises a page-fault exception corresponding to the original access
type.

Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-5-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 45806f5ab0..750c0537ca 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -857,6 +857,55 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
     return TRANSLATE_SUCCESS;
 }
 
+/* Returns 'true' if a svukte address check is needed */
+static bool do_svukte_check(CPURISCVState *env, bool first_stage,
+                             int mode, bool virt)
+{
+    /* Svukte extension depends on Sv39. */
+    if (!(env_archcpu(env)->cfg.ext_svukte ||
+        !first_stage ||
+        VM_1_10_SV39 != get_field(env->satp, SATP64_MODE))) {
+        return false;
+    }
+
+    /*
+     * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
+     * executing HLV/HLVX/HSV in U-mode.
+     * For other cases, check senvcfg.UKTE.
+     */
+    if (env->priv == PRV_U && !env->virt_enabled && virt) {
+        if (!get_field(env->hstatus, HSTATUS_HUKTE)) {
+            return false;
+        }
+    } else if (!get_field(env->senvcfg, SENVCFG_UKTE)) {
+        return false;
+    }
+
+    /*
+     * Svukte extension is qualified only in U or VU-mode.
+     *
+     * Effective mode can be switched to U or VU-mode by:
+     *   - M-mode + mstatus.MPRV=1 + mstatus.MPP=U-mode.
+     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=0.
+     *   - U-mode.
+     *   - VU-mode.
+     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=1.
+     */
+    if (mode != PRV_U) {
+        return false;
+    }
+
+    return true;
+}
+
+static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
+{
+    /* svukte extension excludes RV32 */
+    uint32_t sxlen = 32 * riscv_cpu_sxl(env);
+    uint64_t high_bit = addr & (1UL << (sxlen - 1));
+    return !high_bit;
+}
+
 /*
  * get_physical_address - get the physical address for this virtual address
  *
@@ -894,6 +943,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmuidx_priv(mmu_idx);
+    bool virt = mmuidx_2stage(mmu_idx);
     bool use_background = false;
     hwaddr ppn;
     int napot_bits = 0;
@@ -901,6 +951,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
     bool sstack_page = false;
 
+    if (do_svukte_check(env, first_stage, mode, virt) &&
+        !check_svukte_addr(env, addr)) {
+        return TRANSLATE_FAIL;
+    }
+
     /*
      * Check if we should use the background registers for the two
      * stage translation. We don't need to check if we actually need
-- 
2.47.1


