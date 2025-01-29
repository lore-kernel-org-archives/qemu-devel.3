Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F686C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9J9-0001Df-2f; Wed, 29 Jan 2025 09:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1td9J6-00015u-L6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:44 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1td9J3-0001R3-U4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:44 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863703258fso535868f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1738161880; x=1738766680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1C/J9uCSlWbjvXbc+Puqx9H3UViVHSv3el8cbY4rC4=;
 b=ZhAgHnDHsq8t7gk44myFXx8lkPtwFofn87up+XLJRQe8o/x+b0/vZGvD3Bk9irw6ju
 iWCWZ8L1iuVGz8/bQSUzRNShHWfVmU9ndJxUYO00kc2//GMIA/MPmTz+gAvhDt2jTNPm
 lvkDKtFJSCvbwDmTUrngnQSuW9XjuNWC5H9glVrVMum1gsUl1bEmDSpwblMICp0C0wbu
 yvIJzkDC992wtbVIcpN+G+5Cd+CVe4hoHnxrVYz3YDItyigJn5P9FIqmdV+hxZRUAsvj
 TLq3u9CTQ05CBEfBrzU73ONcPcfl/KieCHB8RFEBz8B2toTucd9K/30FuovSpb6ZJVjh
 R2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738161880; x=1738766680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1C/J9uCSlWbjvXbc+Puqx9H3UViVHSv3el8cbY4rC4=;
 b=Ea4tVHnlIlIqnHkyRDd7LIDJA0gFSjSdiZqnclxkElYjjVTPvsE3aD1cxgTbQOq40D
 i+zmuZAsjiWkppMzllmUynzJPaWIu703Mt5XU5Jq5KWxNu5OxSBEtsq9ieSDAyV0iW/g
 QLVP/q6His3hCyMtddzkJfBf9pLi5Er7BtrIX0cNe7Smasbae3tmMefhuuRo/5YtH1Tf
 hCMWLdy3tSPAp2KsuNWJSBLnMZCOVJA4qo9OyiD99cQ/5cifOzTKZk501jzUmRtt3N15
 KHqd7QH7g+/gV7m7hESWimeUbHXLnpBgoQMz1V58cIq08ibv/YRUtueGfZZEGbNvzDM3
 efPg==
X-Gm-Message-State: AOJu0YypNM3LjvspMjgoocMxSZY9ZOWEkIQkLBVbjoIzUkwyPmqvRL6e
 /bsYsZNTf9srnVPCinXYAERrCqlZiM6NB1VXlbFjv7qxWvpiAzXDgij66MsgEwvO7d2O6HQXG8+
 8A6Q=
X-Gm-Gg: ASbGncvD40ZhthUn2jlVA3waC+dfAOgUVwd+e36QB0Al7TlnL6Ft7Ni6EIN6jlY4FtE
 PdfMzKFwabu7bWsZIMLnBjwg+oc+yEAczYpd/FDpvpqyLHLpMBfpuIV2FOhlMBYdHArjrICKuS+
 1BDCb4gDvQe/ulr8aDaY7NcP7Nz0mn/sKEZCJHS1KyZ1R1enger9mG2ik7/WCbkhqBLMHewwofX
 +nEy/MzPoGu8DpHVNmmHxMvw2VODDtJz8t5t3PJi4Cqw2ykiePfDEYVQ8lyE8JBGKJdxqGZi+QO
 nAlGoWU1nd7BptzFEPblbjy0xpT/bu3LFU75hwrpuGUkS/j/4dZMm0yf
X-Google-Smtp-Source: AGHT+IHEB37kU1JBpkBUcL1DAmLi2+8ppbJk9xkhrkltPgR3/OX0cqHWoC3IAR2C5hqGm7umrxIdNA==
X-Received: by 2002:a5d:64cf:0:b0:38a:4df5:a08 with SMTP id
 ffacd0b85a97d-38c49a63339mr7432462f8f.22.1738161880152; 
 Wed, 29 Jan 2025 06:44:40 -0800 (PST)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc51df6sm24665255e9.38.2025.01.29.06.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 06:44:39 -0800 (PST)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [RFC 1/1 v1] target/riscv: optimize the memory probing for vector
 fault-only-first loads.
Date: Wed, 29 Jan 2025 14:44:35 +0000
Message-ID: <20250129144435.82451-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129144435.82451-1-paolo.savini@embecosm.com>
References: <20250129144435.82451-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x436.google.com
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

Fault-only-first loads in the RISC-V vector extension need to update
the vl with the element index that causes an exception.
In order to ensure this the emulation of this instruction used to probe the
memory covered by the load operation with a loop that iterated over each element
so that when a flag was raised it was possible to set the vl to the
corresponding element index.
This loop was executed every time whether an exception happened or not.

This commit removes the per element memory probing from the main execution path
and adds a braod memory probing first. If this probing raises any flag that is
not a watchpoint flag (that per standard is allowed by this instruction) we
proceed with the per element probing to find the index of the element causing
the exception and set vl to such index.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
---
 target/riscv/vector_helper.c | 91 ++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5386e3b97c..d3ac99c72d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -635,45 +635,66 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t vma = vext_vma(desc);
     target_ulong addr, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
+    int flags;
+    void *host;
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    /* probe every access */
-    for (i = env->vstart; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, i)) {
-            continue;
-        }
-        addr = adjust_addr(env, base + i * (nf << log2_esz));
-        if (i == 0) {
-            /* Allow fault on first element. */
-            probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
-        } else {
-            remain = nf << log2_esz;
-            while (remain > 0) {
-                void *host;
-                int flags;
-
-                offset = -(addr | TARGET_PAGE_MASK);
-
-                /* Probe nonfault on subsequent elements. */
-                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
-                                           mmu_index, true, &host, 0);
-
-                /*
-                 * Stop if invalid (unmapped) or mmio (transaction may fail).
-                 * Do not stop if watchpoint, as the spec says that
-                 * first-fault should continue to access the same
-                 * elements regardless of any watchpoint.
-                 */
-                if (flags & ~TLB_WATCHPOINT) {
-                    vl = i;
-                    goto ProbeSuccess;
-                }
-                if (remain <= offset) {
-                    break;
+    uint32_t probe_size = env->vl << log2_esz;
+    addr = base + ((env->vstart * nf) << log2_esz);
+    page_split = -(addr | TARGET_PAGE_MASK);
+    /* Get number of elements */
+    probe_size = page_split / msize;
+    if (unlikely(env->vstart + probe_size >= env->vl)) {
+        probe_size = env->vl - env->vstart;
+    }
+
+    /* Check page permission/pmp/watchpoint/etc. */
+    flags = probe_access_flags(env, adjust_addr(env, addr), probe_size,
+                               MMU_DATA_LOAD, mmu_index, true, &host, ra);
+
+    /* If we are crossing a page check also the second page. */
+    if (env->vl > probe_size) {
+        addr = addr + (probe_size << log2_esz);
+        flags |= probe_access_flags(env, adjust_addr(env, addr), probe_size,
+                                    MMU_DATA_LOAD, mmu_index, true, &host, ra);
+    }
+
+    if (flags & ~TLB_WATCHPOINT) {
+        /* probe every access */
+        for (i = env->vstart; i < env->vl; i++) {
+            if (!vm && !vext_elem_mask(v0, i)) {
+                continue;
+            }
+            addr = adjust_addr(env, base + i * (nf << log2_esz));
+            if (i == 0) {
+                /* Allow fault on first element. */
+                probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
+            } else {
+                remain = nf << log2_esz;
+                while (remain > 0) {
+                    offset = -(addr | TARGET_PAGE_MASK);
+
+                    /* Probe nonfault on subsequent elements. */
+                    flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
+                                               mmu_index, true, &host, 0);
+
+                    /*
+                     * Stop if invalid (unmapped) or mmio (transaction may
+                     * fail). Do not stop if watchpoint, as the spec says that
+                     * first-fault should continue to access the same
+                     * elements regardless of any watchpoint.
+                     */
+                    if (flags & ~TLB_WATCHPOINT) {
+                        vl = i;
+                        goto ProbeSuccess;
+                    }
+                    if (remain <= offset) {
+                        break;
+                    }
+                    remain -= offset;
+                    addr = adjust_addr(env, addr + offset);
                 }
-                remain -= offset;
-                addr = adjust_addr(env, addr + offset);
             }
         }
     }
-- 
2.34.1


