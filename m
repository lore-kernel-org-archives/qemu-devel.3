Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3991091931
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MlQ-0001fY-Vk; Thu, 19 Mar 2026 19:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MlC-0001Qp-Pk
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MlA-0007j9-T7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2aecefc7503so8911175ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962790; x=1774567590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tJUDngHbr1KPsf6/Ca4HvKW/nIzxeybSJmdbm3AcVc=;
 b=b2EOjBXyIBkr/HYMQTyJ0xHXPrw2nlW3NoEpbtDEROw3m0Rci8J+V1H2E3w/OpgJHx
 n/UmMlUEzPY8XHv0Xy7jaAtzvdM5OzsQPDo7NoDtyjv4tQEiLwjf9VpllzdOiqmKANZi
 si2aeN0SLAzZwl5hF9nWE4Pwmru4pQIzaIU5tkbX88BfGyHG3grYtiFavXW6TQEbhCRA
 ZY+G6UQOt1rxuFOEEdS34/mMMwCJO0Xd7iuArqxeLjSxWkJKm12drxHlMaXp4RtCcQtd
 4KuetWrfmZtcs5qtt5s61Dai7gMs3bzXJCjC7srCdC6PrCkwj5FiMWRfLU2osRaGujY2
 461A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962790; x=1774567590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5tJUDngHbr1KPsf6/Ca4HvKW/nIzxeybSJmdbm3AcVc=;
 b=bHmLINHKC86uUxt3F3PcGBPLTNF3+5ITSRnqL9+HJR9Hl0GyuzuTvS7l+yohY9ZI/R
 k/Rlovr0e4pqG2EzKHi0Pd8ljQNhodwL7OPq8ZOtlYPsb4uyqpTk9RLXbGelnMML5TMZ
 gYa8ycS4H4wBR60sUnt11q8CPBVdvZF+fKBKxCF+A0ol+/3LiPkolnLoG+bd7F+rwmXs
 9LWLRPiq8oBub/ulByGPfzgM865pOquI0dvuwEut1XY+RGb1YBZCxLSZXb1MQPFnCY9/
 X/FUfTLwBo/iOtpFzUu0vk01HSGCAyGPk70BDIWk1IRIbxdVFWVC5sQDP2na+vPsfSCZ
 FicA==
X-Gm-Message-State: AOJu0YytM8PRf9pMxikI/I9Fci9qQDwFaHRsyEvPJvDOil8eaD/lKbI+
 rbZv1Op9ES4bwDGAXy14TCeJhXLhD1bZsP404UCdt98rfMecRpLtHEXZpv+m1Q==
X-Gm-Gg: ATEYQzyBzEQdo6PyLT8ojtEJ4qZXmhuzgpm9jhmllt497ELK+4GjvkR9t5HDB8m577W
 Wdqun6a3n4q8G2HxhkZ2zeuvL1ERHm1C5tJsYuyH4NIv0P/twOEBCwZ+vZUXcXH3yw5lQB8CEgo
 rdHYbEnPR2d0TdNNuAuEVU7nbA8MwpND6hLScZQV+4XnNKAu/D50KxrQYmg4TWuIScdyAlVQcas
 B5CF+y4SjI/gqSUZPfVLmAe44xaJvVCBky3Bla+XTKSY5Bq++vDkLo4ZlvYwAVZ6PcImcDMdCm3
 JAplspgpuesPFCSZWjoS++4VtoN//V0KGmL8QoMcIC+rXjOk3Y1ij/CNiJAiTamaXVSdGpzOW0V
 uXqGeJQnJ/7Wk4rgTNe5IQ5z5bzpmdQeWqMr7dc3lOuRHakusegOB8vugOxpB3d+gmmittjl/uW
 raqbkWEdCWeRLtu28ZvA86BXy18+Szc2/76ysvIjsu8w==
X-Received: by 2002:a17:902:e883:b0:2ae:5eab:132e with SMTP id
 d9443c01a7336-2b0826dd612mr7362785ad.12.1773962790185; 
 Thu, 19 Mar 2026 16:26:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/17] target/riscv: rvv: Fix page probe issues in vext_ldff
Date: Fri, 20 Mar 2026 09:25:21 +1000
Message-ID: <20260319232522.1867400-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Max Chou <max.chou@sifive.com>

Commit 17288e38bebf ("optimize the memory probing for vector
fault-only-first loads") introduced an optimization that moved from
per-element probing to a fast-path broad probe. Unfortunately it
introduced following bugs in cross-page handling:

- Wrong condition for second page probing: checked "env->vl > elems"
  instead of "env->vl > elems + env->vstart", failing to account for
  the vstart offset.

- Incorrect second page address calculation: used
  "addr + (elems << log2_esz)" instead of "addr + page_split".
  For segment loads (nf > 1), this would probe the wrong address,not
  at the page boundary.

- Wrong second page probe size: used "elems * msize" (the first page
  size) instead of calculating the remaining size as
  "(env->vl - env->vstart) * msize - page_split". This would probe
  too little memory and could miss faults.

This commit fixes these bugs by leveraging the probe_pages helper
which automatically handles cross-page memory accesses correctly.

Fixes: 17288e38bebf ("optimize the memory probing for vector fault-only-first loads.")

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318013805.1920377-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e60248d6d3..83dd26314d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -658,9 +658,9 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
-    target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
+    target_ulong addr, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
-    int flags, probe_flags;
+    int flags;
     void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
@@ -674,16 +674,8 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     }
 
     /* Check page permission/pmp/watchpoint/etc. */
-    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, &host,
-                &flags, true);
-
-    /* If we are crossing a page check also the second page. */
-    if (env->vl > elems) {
-        addr_probe = addr + (elems << log2_esz);
-        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
-                    mmu_index, &host, &probe_flags, true);
-        flags |= probe_flags;
-    }
+    probe_pages(env, addr, (env->vl - env->vstart) * msize, ra, MMU_DATA_LOAD,
+                mmu_index, &host, &flags, true);
 
     if (flags & ~TLB_WATCHPOINT) {
         /* probe every access */
-- 
2.53.0


