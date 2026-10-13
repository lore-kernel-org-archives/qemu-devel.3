Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDB3CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8F-0006Yq-5R; Tue, 13 Oct 2026 04:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY49-0000LC-Vr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY47-000867-Ay
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso24201825e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880854; x=1792485654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=77m1KUCe87mNvexEH9gGkpi1V3Hg5U+1YnpivtmqzJw=;
 b=XV40wo7hIv41XRB+1x4Bgm5NyAiTdnoaOYt0UjZHZbXY4MvbPGwKMCLN9zAjaR/mlr
 PsS0OUdhOMZCxs7HmPc74hl5vCJYIuZWMyZ4/7Q0ZzwS+C369ChuXi+UVT+lJ0GZwxsL
 KAQDOLYXjLRgfz86vXoiI1YLhihV7vvDLQfsPz1FGYFMo1lc/nxjHoxy0KLvqB6fP3qJ
 ZUGiJhXjYzdBYAAreVnMoRS7OljV5Hx/4FLw1Mlf2c74Tn1uLMQC9qIThBsPBfapkNZc
 9ICdKM34jQ6hN+Ks9nxvGkYXA3F5qsqk2+7vyD1hoUlsg9y24jBGtRAU0VZFYP18t9Xu
 KYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880854; x=1792485654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=77m1KUCe87mNvexEH9gGkpi1V3Hg5U+1YnpivtmqzJw=;
 b=or1NX3uu9Xh1MjX7XKBhPDTGL3WjN53E3asTfSMOmyilkjIjdotwkt5IaI0Jks1V+J
 ZVOa9LxvM2Ku9ymrCWaYzht/TCugV/n7w8ZDH2JdqMak+Z01cXZULtkMBm6gxVVtiZug
 etv5SpxuJJN8N7mmixtQz/3PiBVaM6Rr8+kp8n9BTo9KJqolo7rIIieswrsmG35gZeqN
 WP42iAdYTUg6gu1h1rWi5CXPVNBbbQ71sqL9WF9OkDgXkmomN7EKh3raC2mNSGZjOCZJ
 g3yDq9cuBkFMbRxLaV//DUB0/TAt2D3Opv5lwUuWbjgai6ZLESyLVc9eaJKBsT4OuCfj
 dbZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcmvBQ3wN3IgDcOPLIzu13yVDe/vlM0HleKb9RyRkl50Z5FGcQJmElLZny119oa5/YD1uqjhJS+KLL@nongnu.org
X-Gm-Message-State: AFq9FYLDHkgaqM7Su0CAyEXJkuT5aQQHJJ/SC1L6Qyv5UGNwgtr38p6x
 gXLj55La9bSsHSDtSvczSt0vG9JTLKIAPXrkWT8K5fFlP75VMkucHOycc15yBeFyFPg=
X-Gm-Gg: AYBFou2kTinbBdqOttvrh7uSasck+4rSO+gndv4uLRh8llxftMEoUwGHuRnIkNxObGC
 uJQvptnFMaa+n5SW5Staa/XZ7RHE8+qUErMJ9MogndaCISlyvwIue85RBdbXHsW0cLBmniWxZfY
 icCouD3TnBvbQ2xB625R6jip3iL5810VmijMG4WfAcEFbAQ4TaTtWyvOndnFv0pydtlfIEqgLBA
 ZrhSVBeL8QP1Uz9gCdZ4D1qCc38Dkkx/BzDqv3VUmGnYnuNk/uUjfneaH7H2wddYjDTsVtQlCXd
 jDFvNflUzEynZcpb8eqaDwQRlI0Is1ObH1AvJwhj4J8OLNVmQCP+EzEXSkbirIfSgp8LdPNGzOD
 ytoAJEv5deTEAVc0+FXcb3LokKAnn9o6VIi6swSmoHHoIJywCmZ7rr6D49eddOq//LZ+FqG0vo0
 9JsyNMdzbArCIplh4OKJRShfE9rxJkAwIz0+8zVEigIZbA9HYludIroLv9wm/AvvPNGFGvcwFm/
 Tu26+92zzBq2cgI/4F+QMDABNcm46Da63EDbU1TicXYqo4m9xhZaSaiF8M60zvTJa87lyVX0DNO
 ReykoBa+zuNwig==
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4a18e4f56bcmr239711095e9.33.1791880853808; 
 Tue, 13 Oct 2026 01:40:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 59/86] hw/intc/arm_gicv5: Populate VM cache when VM table
 becomes valid
Date: Tue, 13 Oct 2026 09:39:06 +0100
Message-ID: <20261013083933.1024405-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Unlike the IST data structure, the VM table entries are allowed to be
set up in guest memory with the VALID bit set, so that the VM becomes
valid when whe VM table is made valid (e.g.  by setting up the L1 VM
table in IRS_VMT_BASER, or by making an L2 VM table valid through
IRS_VMAP_L2_VMTR).  So we need to scan through the VM table in memory
to populate the hash table when these things happen.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c              | 80 +++++++++++++++++++++++++++++++-
 include/hw/intc/arm_gicv5_regs.h |  3 ++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index b66bc5b95df..3e8b20b6e9a 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1257,6 +1257,72 @@ static void cache_vmte(GICv5Common *cs, GICv5Domain domain,
     trace_gicv5_cache_vmte(domain_name[domain], vmid);
 }
 
+static void fill_vmt_cache_from_l2_vmt(GICv5Common *cs, GICv5Domain domain,
+                                       GICv5VMTConfig *cfg, hwaddr l2_addr,
+                                       hwaddr l2_limit, uint32_t vmid)
+{
+    /*
+     * Scan an L2 VM table in guest memory, and populate our VMT
+     * cache for each entry that is marked as valid.
+     */
+    for (; l2_addr < l2_limit; l2_addr += 32, vmid += 1) {
+        uint64_t l2_vmte[L2_VMTE_WORDS];
+
+        if (!read_first_vmte_word(cs, cfg, l2_addr, l2_vmte)) {
+            goto txfail;
+        }
+        if (FIELD_EX64(l2_vmte[0], L2_VMTE_0, VALID) == 0) {
+            continue;
+        }
+        if (!read_other_vmte_words(cs, cfg, l2_addr, l2_vmte)) {
+            goto txfail;
+        }
+        cache_vmte(cs, domain, cfg, vmid, l2_vmte, l2_addr);
+    }
+
+txfail:
+    /* Reportable with EC=0x0 if sw error reporting implemented */
+    qemu_log_mask(LOG_GUEST_ERROR, "L2 VMTE read failed for VMID 0x%x at "
+                  "physical address 0x" HWADDR_FMT_plx "\n", vmid, l2_addr);
+}
+
+static void fill_vmt_cache_from_l1_vmt(GICv5Common *cs, GICv5Domain domain,
+                                       GICv5VMTConfig *cfg)
+{
+    /*
+     * Scan the whole VM table in guest memory, and populate our VMT
+     * cache for each entry that is marked as valid.
+     */
+    if (!cfg->structure) {
+        hwaddr l2_limit = cfg->base + (1ULL << cfg->vm_id_bits) * L2_VMTE_BYTES;
+
+        fill_vmt_cache_from_l2_vmt(cs, domain, cfg, cfg->base, l2_limit, 0);
+    } else {
+        uint32_t vmid = 0;
+        hwaddr l1_limit = l1_vmte_addr(cs, cfg, (1ULL << cfg->vm_id_bits));
+
+        for (hwaddr l1_addr = cfg->base;
+             l1_addr < l1_limit;
+             l1_addr += 8, vmid += VMT_L2_TABLE_SIZE / L2_VMTE_BYTES) {
+            MemTxResult res;
+            uint64_t l1_vmte;
+            hwaddr l2_addr;
+
+            l1_vmte = address_space_ldq_le(&cs->dma_as, l1_addr,
+                                           cfg->txattrs, &res);
+            if (res != MEMTX_OK) {
+                continue;
+            }
+            if (FIELD_EX64(l1_vmte, L1_VMTE, VALID) == 0) {
+                continue;
+            }
+            l2_addr = l1_vmte & R_L1_VMTE_L2_ADDR_MASK;
+            fill_vmt_cache_from_l2_vmt(cs, domain, cfg, l2_addr,
+                                       l2_addr + VMT_L2_TABLE_SIZE, vmid);
+        }
+    }
+}
+
 /* Data we need to pass through to irs_clean_lpi_cache_entry() */
 typedef struct CleanLPICacheUserData {
     GICv5Common *cs;
@@ -1461,6 +1527,9 @@ static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 
         cfg->valid = true;
 
+        /* The VMT may already have some VMTEs with VALID=1 */
+        fill_vmt_cache_from_l1_vmt(cs, domain, cfg);
+
         trace_gicv5_vmt_valid(domain_name[domain], cfg->base,
                               cfg->vm_id_bits, cfg->structure);
     }
@@ -1472,7 +1541,7 @@ static void irs_vmap_l2_vmtr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     GICv5VMTConfig *cfg = &s->vmt_config[domain];
     uint32_t vmid = FIELD_EX64(value, IRS_VMAP_L2_VMTR, VM_ID);
     bool m = FIELD_EX64(value, IRS_VMAP_L2_VMTR, M);
-    hwaddr l1_addr;
+    hwaddr l1_addr, l2_addr;
     uint64_t l1_vmte;
     MemTxResult res;
 
@@ -1514,6 +1583,15 @@ static void irs_vmap_l2_vmtr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         goto txfail;
     }
 
+    /*
+     * The L2 VM table we just made valid can have VMTEs which
+     * already have VALID=1 set: read them into the VM cache.
+     */
+    l2_addr = l1_vmte & R_L1_VMTE_L2_ADDR_MASK;
+    fill_vmt_cache_from_l2_vmt(cs, domain, cfg, l2_addr,
+                               l2_addr + VMT_L2_TABLE_SIZE,
+                               vmid & ~MAKE_64BIT_MASK(0, VMT_L2_IDX_BITS));
+
     trace_gicv5_vmap_l2_vmtr(domain_name[domain], vmid);
 
     return;
diff --git a/include/hw/intc/arm_gicv5_regs.h b/include/hw/intc/arm_gicv5_regs.h
index 51ea451b6b6..f1ebbb6aaf8 100644
--- a/include/hw/intc/arm_gicv5_regs.h
+++ b/include/hw/intc/arm_gicv5_regs.h
@@ -296,12 +296,15 @@ FIELD(L2_VMTE_3, SPI_ID_BITS, 59, 5)
 
 /* Size of L2 VMTE in 64-bit words */
 #define L2_VMTE_WORDS 4
+/* ...and in bytes */
+#define L2_VMTE_BYTES (L2_VMTE_WORDS * sizeof(uint64_t))
 
 /*
  * L2 VMTEs are always 32 bytes, and the L2 table is always 4KB,
  * so the lower 7 bits in a VM ID index the L2 table.
  */
 #define VMT_L2_IDX_BITS 7
+#define VMT_L2_TABLE_SIZE 4096
 
 /*
  * Format used for gicv5_request_config() return value, which matches
-- 
2.43.0


