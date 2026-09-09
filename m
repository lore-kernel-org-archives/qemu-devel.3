Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3099FC79FB8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DtG-0008FV-Ki; Wed, 09 Sep 2026 04:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtF-0008FJ-PT
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtE-0003Ik-6e
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d91ff7d9acso48058765ad.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788943363; x=1789548163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JmH3bJrn2KxIguqbsDJoQtnz4vzZycqSDA0K9jBnEPs=;
 b=E/3Izq2Jk1JReOQ6Yp/wvKzoQWfH0JDCj1DjQzAqlACBB7MKhj0p10CfiUdvse+q3k
 ZNouQK1I7xvggx3BGf9h7QgnBt73cBrfR6ozeluTDQ5BGfc35CHJfjQx09uNB1NT4im1
 fXT/LnWP4CCVzR3p+ElDYdLFjry1q34nyW6vnNshnr3a0xmrfAnP8XcdM8E2qwsfMi8I
 w874SQ8gfOMvmqGlFf5ZdK9uT7TbiSYhJc9TFcrCeaYoEtczbWdQJuoqQobWCEpCEyaK
 CguU1gu9mVUSan7taqLNnEfBxoDL6ImwChPBnFyQkRuUI4DMT06L7Y30X+YtH9Q60m1Y
 a7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943363; x=1789548163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JmH3bJrn2KxIguqbsDJoQtnz4vzZycqSDA0K9jBnEPs=;
 b=o+sP43CuXMkFzj6ezLcGw6eY5zpPo2qCJNdS7V4O+9u7/gYbRdhRGjnNCZYNVKmpSR
 mRNf4LgQQan05tMb0yHymmjpxUnHvuv3+v1odrrbdA8ooeWvFf1CAS9IdIf02IQ4+qUX
 pvucjuE/bP8+SrwJftRtMCFE9Vl+e4mhiRG4IRn8ecofM40rJFOTOkg6lvhsIKl2Nmg/
 1nkkpox++Hk3mzjyQx4s9dJp7geYBLfIRFqgf3EyUpUrqjVyqDXbAcB238wQ3Fjvqm5r
 74tqOIGCR+1nQZlJrAlRorkNDrhctJudMB+6pIdWgNbiISQgkzB8egKdM0Kbe0zZPLrN
 tGtQ==
X-Gm-Message-State: AFuF++mupK1E9SyhaJKu9RYmJLTGlM+y0xS3T4tdPHiP7gd4lR1edqSH
 cKiHH+ydRetcHHXN5ZRfSgPs9pA3SMnSNnN1TTfB1O7+dpheMJqoi3c/sIJUKr0Oi1rmTLgISES
 7U7sHiFuepv7BoY72ICWmDrZhYzUmiJRqWIGMvDth5VyqgU7FufFkPxweyNUF/pQpeWrV74Trqd
 8E4vzq+dY2/a616zRR+xI738KvpuYsem74pL/apf2mtA==
X-Gm-Gg: AYBFou0Nltw2ID+/fXQanL1pXmM5UteADIkUx0lCIXRVAloZ3rXmObUrFnIR68ANqVy
 63x25HRyevphAynvBZxV0AY/adLpALy1RIf+aZJQzV3bWd1Z+Mh/BY7nDCcyMldlzn3FVI1zDiR
 DAdMiaOk/9Z85JUCs5NKG5YMAT0s6thhgPx2TE7h2QLe7D88CmpFuchF8PF8LxvVX7bDEt9+025
 bqfGhLKn8eqqLgOhS9k7bk63a/dsMB0+EPUzadKkUt0Cr3DHJx3kuiv2qbrSBxn98nyK9wA7/Yr
 YD8wbxmgLhRyLtcDBUgkelQPFpzSCoBcudx1noviocxBacmTLyKwNvtgWpmfT5xCcfwxkx2uG2g
 v7uSufqzElyOIkKLCRebIQpKG1Ty7guV66Co2dXm6rIrYCBq2RmT/mjqqmoc6/TdXIy+Jr7uZJu
 IYL79JPQaysEKL9GctvGQwtJmZKJUMdb94/IKjE1a7/ZnagTTAABLCQZqVyCpsKPaki2wwqMiQS
 HI+qYqmSbqc5C9vRiMr95lkYdE+oFqa3oOg640P8JJCoeUKjW1sZJ9Z0eUwbs5Bx+OhEsFkXg==
X-Received: by 2002:a17:903:40c9:b0:2d6:f6ba:263d with SMTP id
 d9443c01a7336-2db124b451cmr471899745ad.7.1788943362496; 
 Wed, 09 Sep 2026 01:42:42 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db56c2a1f1sm38328225ad.78.2026.09.09.01.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:42:41 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/6] target/riscv: rvv: Probe unit-stride accesses by the
 first element
Date: Wed,  9 Sep 2026 16:41:49 +0800
Message-ID: <20260909084154.223529-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909084154.223529-1-max.chou@sifive.com>
References: <20260909084154.223529-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
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

Probe only the first access of the range with probe_access_full and
inspect the resulting lg_page_size: when the page is subdivided, fall
back to the per-element TLB path. Pages with uniform permissions keep
the direct host fast path.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/vector_helper.c | 45 ++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index efe10156daa..569da995482 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -406,6 +406,41 @@ static void vext_test_alignment(CPURISCVState *env, vaddr addr, uint32_t esz,
     }
 }
 
+static void *vext_probe_host_page(CPURISCVState *env, target_ulong addr,
+                                  target_ulong probe_bytes, uint32_t msize,
+                                  MMUAccessType access_type, int mmu_index,
+                                  uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    return probe_access(env, addr, probe_bytes, access_type, mmu_index, ra);
+#else
+    CPUTLBEntryFull *full;
+    void *host;
+    int flags;
+
+    flags = probe_access_full(env, addr, MIN(msize, probe_bytes),
+                              access_type, mmu_index, false, &host, &full, ra);
+    if (flags || full->lg_page_size < TARGET_PAGE_BITS) {
+        return NULL;
+    }
+
+    if (access_type == MMU_DATA_STORE) {
+        /*
+         * The permissions are uniform across the page, so probing the
+         * first access has validated the whole range. It has only
+         * marked MIN(msize, probe_bytes) bytes as dirty, though, while
+         * the caller writes probe_bytes through the returned host
+         * pointer. Probe the whole range as well, so that
+         * notdirty_write invalidates every translation block that it
+         * overlaps and the migration dirty bitmap covers all of it.
+         */
+        return probe_access(env, addr, probe_bytes, access_type,
+                            mmu_index, ra);
+    }
+    return host;
+#endif
+}
+
 static void
 vext_ldst_us_notail(void *vd, target_ulong base, CPURISCVState *env,
                     uint32_t log2_esz, uint32_t nf, uint32_t evl,
@@ -448,9 +483,9 @@ vext_ldst_us_notail(void *vd, target_ulong base, CPURISCVState *env,
     page_split = -(addr | TARGET_PAGE_MASK);
 
     /* Validate the first page is accessible. */
-    host = probe_access(env, adjust_addr(env, addr),
-                        MIN(last, last_in_page) - addr + 1,
-                        access_type, mmu_index, ra);
+    host = vext_probe_host_page(env, adjust_addr(env, addr),
+                                MIN(last, last_in_page) - addr + 1,
+                                msize, access_type, mmu_index, ra);
 
     /* Get number of complete elements in the first page. */
     elems = MIN(page_split / msize, evl - i);
@@ -490,8 +525,8 @@ vext_ldst_us_notail(void *vd, target_ulong base, CPURISCVState *env,
     /* Validate the second page is accessible. */
     assert(i < evl);
     elems = evl - i;
-    host = probe_access(env, adjust_addr(env, addr), elems * msize,
-                        access_type, mmu_index, ra);
+    host = vext_probe_host_page(env, adjust_addr(env, addr), elems * msize,
+                                msize, access_type, mmu_index, ra);
 
     if (host) {
         vext_page_ldst_us_host(vd, host, i, evl, nf, log2_esz,
-- 
2.43.0


