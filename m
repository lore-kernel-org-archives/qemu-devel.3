Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A04DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 16:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlVlh-0003Lf-JE; Fri, 21 Feb 2025 11:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tlVlc-0003KP-Vx
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:20:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tlVlb-0008Af-2n
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:20:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43998deed24so22412285e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1740154841; x=1740759641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvG5UOt6ZOphF01EohXBlW71lQutMKsfYBbH5I4BZ3Q=;
 b=BPBS1MFMcHWIlUE5g/bkvcphiXO/rU1MOYP2rkzJBX3917bmBYUaqKhY5f0LUUaOJw
 Ye5DE2rQPNp0twfirDtc2UYIPMnkCwgfd1I+6ClFPRxR9XYCl9VuXgku0kF3lRvQr2BA
 VgilOgJeGC38A/ItiwyDkj9NYtQTlN46SG5LbxZjmuCEIASUbYKvakm6R1jzADmhYVLo
 2uFrYzOtg89A2jdHB30SdLsYLnOPSSHWt2ceruXVUcgWzCJP/PaeJOqEpc3CvCIN1kCT
 jlvQl70D/Tll1xeAkGBNRDNF8GFOaw0Bg2CxVJSOGIsWHb32hFJMnll7Rj+GOcM3qcbc
 S+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740154841; x=1740759641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvG5UOt6ZOphF01EohXBlW71lQutMKsfYBbH5I4BZ3Q=;
 b=A79NFm5kiF7zwMcV8xHY5ReSJECSm2NiadWfxZn8wa7aADvUfI5jlSpuQa7jBZEr3Z
 EmXtiPxsLG6liW/jY3FVFJjC5pUiPmck8h8CscvpFLYDxOcLUZYUuOFs9HGlUbMKDUub
 ghuhi/LtqgoCSspqQG0n+La2g5yfAb5ZAAuOWk5zqsQPugf62inIKra1zKmiaZc9dYt/
 2kqFOb+J41a8yVhx7Kh90/GSASWFhXe7mFHSazRbrPsOxJr5yMQ/79Zvkg53CyrNNvQd
 G5qrN4K7NR3cwtd5N4KftRVmc7nF2Mx4U0rqSIsWAACH2h7tY0GTaAwIEDKrVG5/gv4P
 /xrA==
X-Gm-Message-State: AOJu0YyXNk24cnnsawvH3SVh+10df6RW2jZ2bppXs8A0iMw65MGALXDD
 FRNXT73qnSjuJtb+PpTc4V0NI18bk+oMkf8/oPeW1S6mMQsleOGJhgKn0rjIhoUzBioIJLC1+uG
 edYqoBw==
X-Gm-Gg: ASbGnctOaVBrZmXIELEYGnpCHA+vkSf6+BT1ETnek4TyaFYhYYa8OkD39avRfnxX1T7
 WUgrdUsajjrUjqVMWhyUOIO4qh/uA7PZShzHt/+dfOKZnXhmpThz0XILm28HicApwyWL+DMyeZg
 plEZhpjQ3DNKxkIJHEUVB/vcXo0EbIsLkXMJKyGBzOFMRra+UU3vVimac/BTX6nMmTk6ACPvuoS
 6WwDw2EUictfbJoR8crcba+a2TmajdnUZ+Z0rBFRTnOZ+SE5UJD4Tzt0HdrJKrzSmTM8VxmImeR
 ROEbmULI1ArQO8P9KkhsBYW5cNADBm9MWmWJvIkMoBRB
X-Google-Smtp-Source: AGHT+IH79xNvUmr+gjrlIM1Tip1BpzNRqJ78Dd2k3CxraUVWO3+WJxVrMG1r58VFZWX2PkUSZOZ3lQ==
X-Received: by 2002:a05:600c:1c04:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-439aeae1c10mr29278265e9.3.1740154840766; 
 Fri, 21 Feb 2025 08:20:40 -0800 (PST)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:1f03:a9f0:23a0:9bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02e4245sm21732575e9.18.2025.02.21.08.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 08:20:40 -0800 (PST)
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
Subject: [PATCH 1/1] [RISC-V/RVV] Expand the probe_pages helper function to
 handle probe flags.
Date: Fri, 21 Feb 2025 16:20:36 +0000
Message-ID: <20250221162036.61521-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221162036.61521-1-paolo.savini@embecosm.com>
References: <20250221162036.61521-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 target/riscv/vector_helper.c | 57 +++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 772cff8fbe..c0f1b7994e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -114,25 +114,42 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
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
@@ -332,8 +349,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
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
 
     VSTART_CHECK_EARLY_EXIT(env);
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
2.34.1


