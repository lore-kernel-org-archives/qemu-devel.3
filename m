Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF7FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs38-0000WL-KN; Mon, 19 May 2025 00:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnD-0004vh-3O
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:59 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnB-0004BH-4F
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:58 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso2494512a12.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627675; x=1748232475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyCQ824gLoHCHmY0N4YlJh0JlUxFJBMJlywNlclO9X0=;
 b=ktlMbVqMS8GaVdi0kx3eUSsAzvA525K1gqq3k1OyofmHsb4ogR46n7EHwCP0kDQGA9
 EDqwGA6tSUphCV7yWJiuKA6VU7ZpDlG2Z1bvX46a9w1nkfLSxGESYU+woWCXRBIw0WX2
 lSbIuMLL+XnuAfOE5pL6tPoae6PgR0x5eyXgcap8ah+sLJOGkZLc2KL23dE3DRWlEMku
 V5UTJOhiMVSQfRM/V33zTWOS6ggh6UZggL5PGsv0O4ykqiV7J+I7VcZw3Vu65mU4MDma
 dEigRas9G2phnuHSKTK5Nd9hZXQVHsUxOWRZChFdKv+fhy1msD942jZyCJQaQ8rYdIIU
 qRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627675; x=1748232475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyCQ824gLoHCHmY0N4YlJh0JlUxFJBMJlywNlclO9X0=;
 b=ncjR0ETOnSZkBiNEVsTD/TFQzMb+umyTCLvBcrBk+KStBVhb12fGZw1uPpl+J65QJA
 b2d6rCr6U/vug2jmy1oJELYbnZrEFlFpvEGIljQqKeQRsdGq5XYJILcO/Esa/Ja+D8vN
 ZEBtkBqBjb/YK102uGRM4A5BXRPxdBGHctwsJou/z9632zspCNQMqaIzjdl+1lBuw6mV
 R6QtWlozU2TUT7rk5lGQq4211gXzlyE/tmcBV4yrsjjjwEXf+RZCZF+o3vRYAj0juPuP
 6JrDHmZ6rYiyuvPFqS7NUUehQ2TIshKsNUesqggd11u2MtDVkrH0GyN889Mf136/CsaX
 t4wQ==
X-Gm-Message-State: AOJu0YzNMViyoU/ukX1glkRGansztJSliPG/oBCyy3zbTPv+NLhaYB0n
 ExY4mhJSEG+fm4ZO5f9QN+cDa3wBtlfIYg9CriF3CDmzKXtme4LyejjWd+nDpg==
X-Gm-Gg: ASbGnctqxzU+nHHlu+n+s42630crz/o0AgdM6cMfsZSZsiuYtCq+PDas08DufPBkJ5+
 VORGMl4kLfxf0BuL/pPAPBVWqEOw/5oeNaABydzLAGdLQ7cgkx2qsCTh0s7SDS4XDiGnRXh+LLq
 bSmjiaIoMybIkTe81z/kDNtOCq2eFKBPX4RVnacXekdjPUmcJHNpXtxmTXUUM+QF/K/e3845SVY
 MvACt2oWFuM1eCLSZJjmwTKTnKn4gn0LrCgXi8wKAb51HTXvzxfgcxWpOR/bXYehzM7DSV77plY
 9KkCCo6j1ae7wqTfiqbPUjE5b79tE3ZCCVqzSPqX/mk4RhbvjunYxrWQ/bLutPtGQfPnpMxj4lK
 HWK89UcqodBfvGFP8IQO6vpzFCOgUsU974NSMV4uuBJUOxkP7VRWtpjF0
X-Google-Smtp-Source: AGHT+IH5O/s7k6StBYwOK0iZqdMv4nhYbfcmWByESEBx3STJj0d8+OR0Xa6Kf5n2YKV1waIzhw7cqw==
X-Received: by 2002:a17:902:c411:b0:231:c6b9:ddba with SMTP id
 d9443c01a7336-231de36ba26mr130223815ad.20.1747627675140; 
 Sun, 18 May 2025 21:07:55 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Paolo Savini <paolo.savini@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/56] Expand the probe_pages helper function to handle probe
 flags.
Date: Mon, 19 May 2025 14:05:13 +1000
Message-ID: <20250519040555.3797167-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

From: Paolo Savini <paolo.savini@embecosm.com>

This commit expands the probe_pages helper function in
target/riscv/vector_helper.c to handle also the cases in which we need access to
the flags raised while probing the memory and the host address.
This is done in order to provide a unified interface to probe_access and
probe_access_flags.
The new version of probe_pages can now act as a regular call to probe_access as
before and as a call to probe_access_flags. In the latter case the user need to
pass pointers to flags and host address and a boolean value for nonfault.
The flags and host address will be set and made available as for a direct call
to probe_access_flags.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250313123926.374878-2-paolo.savini@embecosm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 57 +++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8eea3e6df0..3aec9a7731 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -117,25 +117,42 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
  * It will trigger an exception if there is no mapping in TLB
  * and page table walk can't fill the TLB entry. Then the guest
  * software can return here after process the exception or never return.
+ *
+ * This function can also be used when direct access to probe_access_flags is
+ * needed in order to access the flags. If a pointer to a flags operand is
+ * provided the function will call probe_access_flags instead, use nonfault
+ * and update host and flags.
  */
-static void probe_pages(CPURISCVState *env, target_ulong addr,
-                        target_ulong len, uintptr_t ra,
-                        MMUAccessType access_type)
+static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
+                        uintptr_t ra, MMUAccessType access_type, int mmu_index,
+                        void **host, int *flags, bool nonfault)
 {
     target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
     target_ulong curlen = MIN(pagelen, len);
-    int mmu_index = riscv_env_mmu_index(env, false);
 
-    probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                 mmu_index, ra);
+    if (flags != NULL) {
+        *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                    access_type, mmu_index, nonfault, host, ra);
+    } else {
+        probe_access(env, adjust_addr(env, addr), curlen, access_type,
+                     mmu_index, ra);
+    }
+
     if (len > curlen) {
         addr += curlen;
         curlen = len - curlen;
-        probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                     mmu_index, ra);
+        if (flags != NULL) {
+            *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                        access_type, mmu_index, nonfault,
+                                        host, ra);
+        } else {
+            probe_access(env, adjust_addr(env, addr), curlen, access_type,
+                         mmu_index, ra);
+        }
     }
 }
 
+
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
@@ -335,8 +352,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
     /* Check page permission/pmp/watchpoint/etc. */
-    flags = probe_access_flags(env, adjust_addr(env, addr), size, access_type,
-                               mmu_index, true, &host, ra);
+    probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
+                true);
 
     if (flags == 0) {
         if (nf == 1) {
@@ -635,7 +652,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t vma = vext_vma(desc);
     target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
-    int flags;
+    int flags, probe_flags;
     void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
@@ -649,15 +666,15 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     }
 
     /* Check page permission/pmp/watchpoint/etc. */
-    flags = probe_access_flags(env, adjust_addr(env, addr), elems * msize,
-                               MMU_DATA_LOAD, mmu_index, true, &host, ra);
+    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, &host,
+                &flags, true);
 
     /* If we are crossing a page check also the second page. */
     if (env->vl > elems) {
         addr_probe = addr + (elems << log2_esz);
-        flags |= probe_access_flags(env, adjust_addr(env, addr_probe),
-                                    elems * msize, MMU_DATA_LOAD, mmu_index,
-                                    true, &host, ra);
+        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
+                    mmu_index, &host, &probe_flags, true);
+        flags |= probe_flags;
     }
 
     if (flags & ~TLB_WATCHPOINT) {
@@ -669,16 +686,16 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
             addr_i = adjust_addr(env, base + i * (nf << log2_esz));
             if (i == 0) {
                 /* Allow fault on first element. */
-                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD);
+                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD,
+                            mmu_index, &host, NULL, false);
             } else {
                 remain = nf << log2_esz;
                 while (remain > 0) {
                     offset = -(addr_i | TARGET_PAGE_MASK);
 
                     /* Probe nonfault on subsequent elements. */
-                    flags = probe_access_flags(env, addr_i, offset,
-                                               MMU_DATA_LOAD, mmu_index, true,
-                                               &host, 0);
+                    probe_pages(env, addr_i, offset, 0, MMU_DATA_LOAD,
+                                mmu_index, &host, &flags, true);
 
                     /*
                      * Stop if invalid (unmapped) or mmio (transaction may
-- 
2.49.0


