Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4BFE6C5F8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJjy-0007x7-Bz; Mon, 02 Dec 2024 22:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJju-0007vO-Tr
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:19 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjt-0005Zj-4u
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:18 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-724f383c5bfso3840794b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733197095; x=1733801895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3e3WI4iosSzHiwP41BBTJfjUZj6un22IUON5rwHeyqA=;
 b=GBpphTnQDHwMHepPk35GuhoBsjVZzDqu3Ew6IG0dERfdeP9Et52QLOx28C8AVrY9tA
 RfWqnvS5rhVM4TAbNr2aEAsoA55dS/KZmVWscVNphB3HoPJO65+0b2expHd+8c4Z97+2
 ZmGXcHm3ebG4Ue8XKRqssfhfCejJmq/qT228+aS2A+ssaYkxRQj5cOjgNmHmzva07K2C
 QxEiJOA/35z1yawCW7xCcQ9V/tScZ49d9Wz8MhHqUVLkRGmaQTLO1gZa+9Q1oXeaLwnW
 sQtY10eaHcaD5EGkKlHiWY9YkJP+VPVUMxOwj9b+QTocBiaMA6BVfqP2kWsGBItzrwm9
 mOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197095; x=1733801895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3e3WI4iosSzHiwP41BBTJfjUZj6un22IUON5rwHeyqA=;
 b=cnsZDE7qEaLDB3a+cQMbZMpJg92yNyoBX/j8MQglshDRIhEXRti4HkqBrPtV6pIGYs
 OUM3XmUT6KLf2o6V8vEDVSwdpA/D4uvV8PLKbkdrj5kkr/eZYH08B8e12PH5f8DUd5UL
 evoMWKrcL1evGJNBzUgvnzFG3D2q4fmzck0YJexJd1XdRDR/jo5itrpUP4CPNlAay6Xj
 8Y07C9imTzkAfHUU6G5zQTh/9QPrX6wYMgPtcmguU78XHv+qfHZej+on0eHnnphqqQJ2
 gM6qc1uyxj+AA6kiSvzir6flJR9br71cmG3MXF4b4XsgdNY35lvshX5qIKK7MCt3+8OE
 R4dg==
X-Gm-Message-State: AOJu0Yzfr2goRe+UgfQdIGkhF8ObLJnCHJjkEShReoPNCb+zTxaK2rsI
 Y1sAmMoq/uDHPFBzWAjVREQWXdGY7mrWUQqtezcKRiXV9BiH6w1ySfKeDoiv/JM7AnC9FkH4VIQ
 KETzzlKwSZUUQkpAP245MHAdTmhOpdfiB9nttBOch+BTsZ2eQM/9+eKkD8sEYcisHe6bAN3CukT
 yl3FG0b8QFDwsDTdAmmUTZsDEgZgdeh4PrFWOQvw==
X-Gm-Gg: ASbGncvYT2Sz9taukEuOvtmgFg7zsTPI9qNy5i31fBvv9mOrTD0o7PUZrajHk54sK7J
 f4EGKv3YhZzdycMlXlfmGROsJE2M7ckLdNCLiQ6N+WaFzVPWBTSkIPIZ+x16mbFvHy2YTKlmsx7
 WwBBRtN52AbbshQMvZiDAAaUTYhwdaL3MmwzWVYwLmEjSmUnPDSL+lugWDkPFjjvMHD5NKYI7bY
 oVLqtA1D/xIw/09jfl9AHD/6I5mt3Wte/I9R+M1lkj8MIHwIBttoU1AtLQ4gRtDlR64q5DTlhht
 Cs9yxn6Z
X-Google-Smtp-Source: AGHT+IHChw8ilVuNDdZLO9KNu2E6zKuzK24BSJF48DrsU2UbYaXZ/ELE/scUEwE3aXg5/ImGVx/wkQ==
X-Received: by 2002:a17:902:f642:b0:215:6816:632e with SMTP id
 d9443c01a7336-215bd13ca9emr18544585ad.48.1733197095259; 
 Mon, 02 Dec 2024 19:38:15 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21566732e1fsm47111135ad.134.2024.12.02.19.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 19:38:14 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v5 4/6] target/riscv: Check memory access to meet svukte rule
Date: Tue,  3 Dec 2024 11:49:30 +0800
Message-Id: <20241203034932.25185-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203034932.25185-1-fea.wang@sifive.com>
References: <20241203034932.25185-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42b.google.com
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
---
 target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69ea..edb106b8a0 100644
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
2.34.1


