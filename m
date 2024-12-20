Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A971E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFz-0001Id-VH; Thu, 19 Dec 2024 20:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFn-0000FN-BD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:35 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFl-0004bO-D6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:35 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-725ce7b82cbso1711020b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659792; x=1735264592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQS//T0GoR55hAf+FcAjZTbaJGtVUJI7ZxjrQ9eUp70=;
 b=guAuf3zt9xT7EQ5xYXd6igJA0YR3r2WGDN749Jhm6KwBt/D9TJiwLHfcYndvxVe0Y2
 qnX+mly1E85Lx61K4WUIpRjqsFTORcC2O94tiGst1w77fEVP5EXruIUdIb/bataDR50q
 19Wr5GtjP712BrXUriH15Icz500NtlDS4J8vCHAXRj/zRhtZR0RxaKe9tlgq8f2ryvRe
 ShW79U9KVofQ/cAGSdSexe1WEW10Y9xQqCWhoU55n+9iDdKb6lBelikRbCbwdZKO5g2v
 KLL5PL+nxz47Ofx4VnYhq+QSz00/2YIysNB74EOZJDt+m5mHXHRcJHExQ7pDnUE9EaeV
 UJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659792; x=1735264592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQS//T0GoR55hAf+FcAjZTbaJGtVUJI7ZxjrQ9eUp70=;
 b=cpPYurYc7+RUV10GfYmLPmI6tcZAe8qntLYbCfBmNgP3qO1uEYqctBWuSKoWFRLV40
 N7/dOBIiHwfyD+h+SNQMwysZS4VRlRJwm/tHvD2xZpRJBDX4gcBF4NQbiwwW3w35ntPW
 feDHGQZEfU9WxVMnlZZOIZncaHN4NSZ5ifQ1LrIa7bEjdiBZIktKKTSZFe6L6OTAaoQl
 2Ed7YWTs7ACpU1PiaCIM+tGUiteE1rR7+PC2216sGBeM4wHs+rxhjuzH17OWo/YWAy8Z
 /fZ1k7Owmzpp0zxUqbfa+iQFh3zm+T4gtSXLgeuLLKAR5HPw5mZrHbDVJhbcKcLB6naj
 2oNw==
X-Gm-Message-State: AOJu0Yx371Ncr2azx4HwGTctVNIUCXd0A/W2v11GLYr3HUqd6UX0ZPhq
 re9WouoyTX5CaCqg5VO6K+80x/U7T5qkSDhyLSVl2eGIcf6x9DJmq83annC6
X-Gm-Gg: ASbGncs3dm66ZrXka3HkEodgUS6tv57tHzV3FMgtEjW0yDLs6knjOrF/6SQSziF0rTJ
 7q6RFe6sVvGvNYJ5j6hFcjoObZn5hHOAYYF5PmS8YKHtcQefxAF0loN1nD5h62mQ2gjs4dlZMIs
 XMKTkW+C1s2mkGlrXbpDnu+ZLdXRwBiZLmz1g65Onqz/5h6EBXUD2DP/e714by8HZpQMVy5+fBN
 nOl469GcVK80Qku0LSgoVOjp/eZu9W2d1pjy/++XtCZKUvacj6d9IaiGuyHJnCshRRYCWT1sPC5
 4OtEfSMCcjcuWnAfbTO1ZgAj3vT4BAsgqYsEE+gEAG2JTMpAumZy5cjL7oWRHLU=
X-Google-Smtp-Source: AGHT+IE55mt7DO3RWxj3kXcbY5uEPu3BwY+mCh9aihNZaseidsXdt90HyvJ/HK8AS7RvXaUDh9Tghw==
X-Received: by 2002:a05:6a20:6a24:b0:1db:ff9d:1560 with SMTP id
 adf61e73a8af0-1e5e0484baemr2196547637.18.1734659791640; 
 Thu, 19 Dec 2024 17:56:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Jim Shu <jim.shu@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 32/39] target/riscv: Check memory access to meet svukte rule
Date: Fri, 20 Dec 2024 11:54:32 +1000
Message-ID: <20241220015441.317236-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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


