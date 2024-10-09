Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEFFCED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfns-0006oh-LU; Wed, 09 Oct 2024 19:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnq-0006mn-Ic
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:10 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfno-0000ho-3O
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:09 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e6ed072cdaso207620a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515346; x=1729120146;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jhy16U60jtENm6Kh0YtldQ0BHL4m1/+IxRhtKphPpfc=;
 b=kOMk5XMBab5MM8/GcskDfzA5zXmz7x21CUqKFfew0B45qWhWXQOI3xvHApXf9mDS6Y
 lXr/GPeTuyERHXVa2uhrWPgNlHLFvSLJKcVYFVhjhZSw3sUhSY/a640301sH/36lnuMN
 NWpuCcd4BfHNV9vpylZrnil3AlPz8Iuu0lN5T6f8WbtV3DPU3pNWA2/pX9nhSwantXcl
 /z0xw4B777tLTRVnf9uqIVdOGVzocT1NwRIIVT/Ndb2Kb2VUOyGP/uQuF6VJdcTjPyNX
 P9Th5FUqgug7P16c3l9os6UwSqvYcgseMSyYbLzm6VKB2cvbC1PKtPmK9f2iYsDRj/s4
 bedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515346; x=1729120146;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhy16U60jtENm6Kh0YtldQ0BHL4m1/+IxRhtKphPpfc=;
 b=sziFTSRgmiBnfQSEQAIaKBoa6dhMMbmXBIyuj86NIkxHXDYamS+n2vs+ytJgDpzk6B
 9ZkHIxXZW4xl03mC7qo7XkeBf0YzpwAEqu/KBZJhJmmiGep5pCL4VDru0B0dCFh/sa9T
 VeaiKHQxyj5xljSFHwtJBXWgswY8Naj4BTRcv2C/9Kr+/Hq20QoeSmf91YT62D9e+p7g
 z9UMqJGDe9LkC3wdWKx5qcKUgXQ1QvHBYaoR0TGWVMuJe1Ds2mXj8vrnK+t3Bckx9/SD
 X+MqTjoZSQFq6K+9Wr3E8NiD6/l5rlHf2ma2o/1HK96KeBk+J6WH1Z7dfnSn4TrF1NBo
 FI2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIzlAcR/RJNQr/iktLA6BjJalS0NfZkeCdThoyj0WtsuT9TG3no7CfZ2NPdejiR9EWGVyCvcO/0h3c@nongnu.org
X-Gm-Message-State: AOJu0Yw1xYsKe90aug10vU6BVQwCFff+Ibng3TWwra5qw6P0+cMVIVyK
 YlVKAa0aYpxCgfjdhrZ+Rh9rR0GJMebP4qzQn8HUr99KZEmRcGPRB/2HyI1+Xag=
X-Google-Smtp-Source: AGHT+IEwrLE4P1g4XZh4ckyUDVjSdXFV+1VTVyXnPnRmJ3Ys7SBAGunw7CgyWRi90Oqjq/ldQcJ9jw==
X-Received: by 2002:a17:90a:6886:b0:2e0:876c:8cb4 with SMTP id
 98e67ed59e1d1-2e2a253be16mr4753193a91.30.1728515346657; 
 Wed, 09 Oct 2024 16:09:06 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:06 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:01 -0700
Subject: [PATCH RFC 03/10] target/riscv: Protect the hashtable
 modifications with a lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-3-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x532.google.com
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

Add a read/write lock to protect the hashtable access operations
in multi-threaded scenario.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/pmu.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a63a29744c26..97e408b91219 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -496,6 +496,7 @@ struct ArchCPU {
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
+    pthread_rwlock_t pmu_map_lock;
     const GPtrArray *decoders;
 };
 
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index a88c321a6cad..21377518f4e0 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -271,12 +271,15 @@ static bool riscv_pmu_htable_lookup(RISCVCPU *cpu, uint32_t key,
     GHashTable *table = cpu->pmu_event_ctr_map;
     gpointer val_ptr;
 
-    val_ptr = g_hash_table_lookup(table, GUINT_TO_POINTER(key));
+    pthread_rwlock_rdlock(&cpu->pmu_map_lock);
+    gpointer val_ptr = g_hash_table_lookup(table, GUINT_TO_POINTER(key));
     if (!val_ptr) {
+        pthread_rwlock_unlock(&cpu->pmu_map_lock);
         return false;
     }
 
     *value = GPOINTER_TO_UINT(val_ptr);
+    pthread_rwlock_unlock(&cpu->pmu_map_lock);
     return true;
 }
 
@@ -388,9 +391,11 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
      * mapping.
      */
     if (!value) {
+        pthread_rwlock_wrlock(&cpu->pmu_map_lock);
         g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
                                     pmu_remove_event_map,
                                     GUINT_TO_POINTER(ctr_idx));
+        pthread_rwlock_unlock(&cpu->pmu_map_lock);
         return 0;
     }
 
@@ -410,8 +415,10 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
         /* We don't support any raw events right now */
         return -1;
     }
+    pthread_rwlock_wrlock(&cpu->pmu_map_lock);
     g_hash_table_insert(cpu->pmu_event_ctr_map, GUINT_TO_POINTER(event_idx),
                         GUINT_TO_POINTER(ctr_idx));
+    pthread_rwlock_unlock(&cpu->pmu_map_lock);
 
     return 0;
 }
@@ -597,4 +604,5 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
     }
 
     cpu->pmu_avail_ctrs = cpu->cfg.pmu_mask;
+    pthread_rwlock_init(&cpu->pmu_map_lock, NULL);
 }

-- 
2.34.1


