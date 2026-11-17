Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0C606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QnUBk3ru
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT6dc-0003SU-Ml; Mon, 16 Nov 2026 19:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT6dY-0003OV-KK
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 19:01:24 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT6dW-0003QX-OO
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 19:01:24 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so210277b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794873681; x=1795478481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rXDpusdlPIZoSkpdHN32nrgNmQGbbMyVhAReGptt12M=;
 b=QnUBk3ruidCui6iqXOQ7vrd9uIe3I1aRGoicd/3v3N6Fph6asTu6i6EhVaOIQTr22p
 6vmnWV3wb/PswEEa5xp8DfRlER7UQJN5HbruVH8fcQtU+tgYemDVw9QJnud46PQAD5OC
 edzj7D2HlU1PdzVKgpT5U3X2K4hT5opZ65zi2L69a53MY0H/7s/pVQRSTqMVOFJzcAnT
 XqqIY8LsmnKv2WvBOYCMI2SFs+neettdtWlPC3P2DiKpW3KmthItzP2QuFeIMebUQeDZ
 vEiW9U+OrBdEtayebi7wz/+jBvU7eunfaDEQbYdbZ1f/JnZAJA2/KfRKk32eOJGVAYi8
 R4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794873681; x=1795478481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rXDpusdlPIZoSkpdHN32nrgNmQGbbMyVhAReGptt12M=;
 b=gcv6RW38G1fwUQnoKqcVLXfcJeYYgshIc6Qyw3XjDh/MAxuMw+Dd37ItZ+30iaWqxp
 It4xg8oLC937JrhvJGHMLVo7YIKoFULEP9J+AwEIiqG59/PSfZV+RZQFXToQrtRdm/ut
 AAZrXgqaA4H/UqJd+OMWap52ztgs/NMhg163OyZiArgd1eVnn2D9LBRDoXttHyk23TUX
 qDmaELm0JmL0AOfo9gstysFt7Fq5+1G23ooDNIufCkByoc12ac1o+5vuKakkE02q7R9Y
 WCV+1r1P56GIF5BtQ/FD5OiSx5JVGOVfDyoQ0C9Uf3ReR9bGtytHNDqxBXmXMm8Ua2OO
 G7bw==
X-Gm-Message-State: APuU4Z/ED1SCJTkyAf37R64nD4jm+LR3jft7WlhQ6mf3kPlNz2cyP30/
 jom4PejsymbqbTuCaDjV6eOeOfMggEtlbhy4RGl91wIVJxnGnoMYw747NiQE9nOdu/j7Fh2qefz
 xFLaC
X-Gm-Gg: AYBFou0Wql4+PadlNUqwHvbFXUJbrjdK+Wgz3d2/I6atUXdlwyGtM0WoMVM3unx+Uks
 ShKy8xNxthGjztBx903zcD2LH6bSSUWl21h5Nyd7JHbCaSRlcDwjVbhDNQ3/cdBgk5IONHrp+UQ
 7WQQdURqX18k11EHk3jIgo4xOUST5113yNPafyAbRERvSO/zzzutRLZT2SxqzHJePchABFwsjPy
 sfAckfR3usqZ935QJyU0lHH/ENpcEWIKgb/vDiggKQd+Xs5RP2hEsFO2oIwG1yWbtjYQFDu4x2P
 gFp4MjZHy3oAuXKFQEAQJytU8nmRq9/i7RMiFZ+YShM6eHXB4N6Y+itDkkc5I30vasNSv9ZTYVC
 4epILcaMNQ16VVJaYZjR+87aSIgDbADYqvRaqOx5QCN27+/NkKoU80Bhny2NKlwK8WMEPf+12P3
 QtuIL7aMPQCgv13sGrYav6qXUHF6qgCnp0AFbnP2CjX76C/beDBU+dN/4cHWC9WbY/mUXO4WJDt
 xo6UxqvO1y+sRLPd78H1lkmCw1qc4SFhjqbextbELWtHVeT7HyHj3WraadeHN30uVstHym4zAuq
 Bza6JQhNJXle9BsH/I8Tpz/7/JucTnKV/pRXUqSPplpnVRsacTy1JMSvaNFp
X-Received: by 2002:a05:6a00:3011:b0:8b9:227b:c0a with SMTP id
 d2e1a72fcca58-8c453bcb909mr610609b3a.5.1794873680672; 
 Mon, 16 Nov 2026 16:01:20 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed20548fbsm4505995b3a.37.2026.11.16.16.01.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 16:01:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-11.2] accel/tcg: Fix jump cache flush after large page
 flush
Date: Mon, 16 Nov 2026 16:01:18 -0800
Message-ID: <20261117000118.642891-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a large page flush occurs, flush the entire jump cache.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4873
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3ca484b039..9eb794929f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -472,7 +472,7 @@ static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
     tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
 }
 
-static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
+static bool tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 {
     vaddr lp_addr = cpu->neg.tlb.d[midx].large_page_addr;
     vaddr lp_mask = cpu->neg.tlb.d[midx].large_page_mask;
@@ -480,12 +480,13 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-    } else {
-        if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
-            tlb_n_used_entries_dec(cpu, midx);
-        }
-        tlb_flush_vtlb_page_locked(cpu, midx, page);
+        return true;
     }
+    if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
+        tlb_n_used_entries_dec(cpu, midx);
+    }
+    tlb_flush_vtlb_page_locked(cpu, midx, page);
+    return false;
 }
 
 /**
@@ -502,13 +503,16 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
                                              MMUIdxMap idxmap)
 {
     int mmu_idx;
+    bool lp_flushed = false;
 
     assert_cpu_is_self_or_stopped(cpu);
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((idxmap >> mmu_idx) & 1) {
-            tlb_flush_page_locked(cpu, mmu_idx, addr);
+            if (tlb_flush_page_locked(cpu, mmu_idx, addr)) {
+                lp_flushed = true;
+            }
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
@@ -517,8 +521,12 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
      * Discard jump cache entries for any tb which might potentially
      * overlap the flushed page, which includes the previous.
      */
-    tb_jmp_cache_clear_page(cpu, addr - TARGET_PAGE_SIZE);
-    tb_jmp_cache_clear_page(cpu, addr);
+    if (lp_flushed) {
+        tcg_flush_jmp_cache(cpu);
+    } else {
+        tb_jmp_cache_clear_page(cpu, addr - TARGET_PAGE_SIZE);
+        tb_jmp_cache_clear_page(cpu, addr);
+    }
 }
 
 /**
-- 
2.53.0


