Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2476CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfnz-0006sT-PE; Wed, 09 Oct 2024 19:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnv-0006pb-7f
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:15 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnt-0000kY-Iz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:14 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e0b93157caso1093535a91.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515352; x=1729120152;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P6q/KHZBoxoAUwii9W1VeCsLQoaGoXXnAk+sVFIRKlQ=;
 b=CHVmC/9sl9twVdQwLzve23TXuueCMDbeep/GtLzrU6HiOOG6KrEfM/KJXlRqeyyH7g
 mo++I1XJ6jpvQg4F5m/tcoAMnnPlHKjczWVoW7TNl/yFUuFR2TlHldGAooE00pZqVlLm
 lLFlMIcfssYuJpSa/bv9QJtMJkRR5L0rjK0vIv/V9HRrtx9UFGNSod1JfSSqyVKKBjwT
 WUCydONNIbBUNwls5NNhj5j/2BymfYRzZS/O2x9UH5i3sgUGzkQQ1pcEtfMtHemuJtiz
 h+6nZQ8nz/oN41lyp3PzD8oy0ZufKu3ZNrNeq6OY82F/Xt/1rNVhzwKkI9fQlo8llg7g
 NNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515352; x=1729120152;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6q/KHZBoxoAUwii9W1VeCsLQoaGoXXnAk+sVFIRKlQ=;
 b=lTzJYOzgSUK+hN9VSx/cRG1y2VJLvI8rV7hcNIMX1OBhmVQMBd0E9WSY0Uh1k5MkFr
 l6DjsGf1VhJymsVjFjskHD8lQMHapeB6o0kmuVL1tg0BTs4xRYXfBe2yZhG2tI1UOHni
 S8pv/Ku1jE+1S/pjvzXBdfGIyhM+Y6SnX9uYfSiyjkeTeALI9uySwq2ryFAGbveZ4Rkj
 0x+z3c1UuL4cA/cvdYpj8BXChSjJ6PvZxpyZzw1+3w17uRxrbqhx6WUnY1HZiPoCp7LL
 iLG17obcixjmih1ZRuWGZZPS52kZe9KJyeVX3KXun3N34Pmuu2wgxEEAculkF9fAj3Jh
 ZBSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8piWssoix60xPUWdlhLLhXE4r8RdhLR74718TITwtcEN7KKNNPnZcI9cjLy7XtTNGMw4F578+19sg@nongnu.org
X-Gm-Message-State: AOJu0YxgbhNxwIua6CJnzh8knrvKaZvB/Xdm7sHDDC557MG2UzELTY0Q
 fV9T3qC+xbk2SUtbidkkIQcS62B3hAOK3l5wfdlJXQqTvDr9sqTyL57U2CM+YUI=
X-Google-Smtp-Source: AGHT+IEP6JQStqrLt7enuGR1fS4goBDxH5gm/72py7nlIq35BvsYLhUWqJba1xkI4mc/cRpg7DBkWQ==
X-Received: by 2002:a17:90b:a11:b0:2e2:85b8:14e with SMTP id
 98e67ed59e1d1-2e2c81ba3d3mr1912712a91.15.1728515352350; 
 Wed, 09 Oct 2024 16:09:12 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:11 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:06 -0700
Subject: [PATCH RFC 08/10] target/riscv: Update event mapping hashtable for
 invalid events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-8-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

If the software programs an invalid hpmevent or selects a invalid
counter mapping, the hashtable entry should be updated accordingly.

Otherwise, the user may get stale value from the old mapped counter.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/pmu.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 3235388c66e4..24c2fe82c247 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -387,39 +387,42 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
         return -1;
     }
 
-    /*
-     * Expected mhpmevent value is zero for reset case. Remove the current
-     * mapping.
-     */
-    if (!value) {
-        pthread_rwlock_wrlock(&cpu->pmu_map_lock);
-        g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
-                                    pmu_remove_event_map,
-                                    GUINT_TO_POINTER(ctr_idx));
-        pthread_rwlock_unlock(&cpu->pmu_map_lock);
-        return 0;
-    }
-
     event_idx = value & MHPMEVENT_IDX_MASK;
     if (riscv_pmu_htable_lookup(cpu, event_idx, &mapped_ctr_idx)) {
         return 0;
     }
 
     for (i = 0; i < env->num_pmu_events; i++) {
-        if (event_idx == env->pmu_events[i].event_id) {
+        if ((event_idx == env->pmu_events[i].event_id) &&
+            (BIT(ctr_idx) & env->pmu_events[i].counter_mask)) {
             valid_event = true;
             break;
         }
     }
 
-    if (!valid_event) {
-        return -1;
+    pthread_rwlock_wrlock(&cpu->pmu_map_lock);
+    /*
+     * Remove the current mapping in the following cases:
+     * 1. mhpmevent value is zero which indicates a reset case.
+     * 2. An invalid event is programmed for mapping to a counter.
+     */
+    if (!value || !valid_event) {
+        g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
+                                    pmu_remove_event_map,
+                                    GUINT_TO_POINTER(ctr_idx));
+        pthread_rwlock_unlock(&cpu->pmu_map_lock);
+        return 0;
     }
+
     eid_ptr = g_new(gint64, 1);
     *eid_ptr = event_idx;
-    pthread_rwlock_wrlock(&cpu->pmu_map_lock);
+    /*
+     * Insert operation will replace the value if the key exists
+     * As per the documentation, it will free the passed key is freed as well.
+     * No special handling is required for replace or key management.
+     */
     g_hash_table_insert(cpu->pmu_event_ctr_map, eid_ptr,
-                        GUINT_TO_POINTER(ctr_idx));
+                GUINT_TO_POINTER(ctr_idx));
     pthread_rwlock_unlock(&cpu->pmu_map_lock);
 
     return 0;

-- 
2.34.1


