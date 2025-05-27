Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE1AC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Tx-0003Kd-VZ; Tue, 27 May 2025 19:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tv-0003Jt-MW
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tt-0001EX-9v
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN1Hn3+Uw7/ALbIafIFeVK7MaEfBIWOZWsDHjGTYDrs=;
 b=J/H2HQm6Sg9uaigbGn/+m7nqI5I8IvHWDPI44DBAtWO4CwGDXm/YBJA27Ctryv5UUGmY67
 CP8ByHE19TwDF8QH2EIM5Wg38i2Nb+6TTt/syvXh1iDhs25+WtpwikN4pf4HsMHcxoVOkj
 Bp5kYstSNDXdlwJNsuulynlRkv+bgOA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-dsN6Ef0FNSGdZcIq25jBlA-1; Tue, 27 May 2025 19:13:11 -0400
X-MC-Unique: dsN6Ef0FNSGdZcIq25jBlA-1
X-Mimecast-MFC-AGG-ID: dsN6Ef0FNSGdZcIq25jBlA_1748387591
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4770cbdb9c7so79665961cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387590; x=1748992390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CN1Hn3+Uw7/ALbIafIFeVK7MaEfBIWOZWsDHjGTYDrs=;
 b=d5HzgeN7kBysWju+war5hVvZi9PfdPeQNtf6RVQzL70G4NGgzDWAKsWKs1SwBgnyuu
 lWiRSIMwC26f5lyG1pNfc+ACSMsvXWTVUGPMO4BSdPrGtCvLfyxyd3HGrLylrqO9oiVA
 EZwmAms5R4SQX3QBjbHYP4nuqqcZCOb6bBbOaFqpknWPygvb7+eqV2KLkhkof4HTbcOo
 5YV24qeykMeguA5FTjAG59cBbLneL4WZxoWzsFU67OIpRmMGN9R2cC26vKcWeDYayLL9
 tERP1gT/C4ulYGRFEhIeztW0cq6cVqjE8sUbN4LqCKjyR72ha9PNpjfqNcEEvPUloIhD
 W6kA==
X-Gm-Message-State: AOJu0YxjGPAM2P2orXAwGeirNkjFrcwhaLk+z1tfWXjFQFEchZQQVkEB
 xeWT7MjlGU0QAdz6pkwMhrXu4+lQp2pxQKqau9zWj+GFr+kFoSx7bhZOQIfoPHdRuARxw4bXxo0
 OuVCyVRVbKlvhxrGfkCsyUdzsFX5PerPg8KRL/4XgPCQANuwu+ipsOLe7bofVy378uUrZoNI7pC
 cbi5sgdn4BNlEezvsE3OYq573cC8t/vFrnEkCM+g==
X-Gm-Gg: ASbGncuPcp5mNazhmfsGen4uWKC1RcXnpHjvtXTNnzc+TbQsL6vAXAVXYHNtTJFQ2r9
 0lWPaEtjm1L+PfdvYHYubn/ox7hljHa14hXtsTSF66KEFLG0ik5niIBcHTLGVe/tLQA6VQkYXvO
 v1bIAUu9dC8mkfTmoxL51sQuuu3GnBrC16p5ubRv88kPdkxMlS1IxWThuf8dt5chCljjzpJD1M7
 drsNwxTj4M7xq0OmyIx43FinfPaxjF3hAwfXsfRGAnm4O4IB5s3AtJwvhlzyWXr3CYaN5CV/iuE
X-Received: by 2002:a05:622a:4ac4:b0:475:16db:b911 with SMTP id
 d75a77b69052e-4a38c7e0c09mr1188661cf.52.1748387590399; 
 Tue, 27 May 2025 16:13:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhW5UjgGIFP8Pm19xZOrD1s8F3ZJTbdBPDl0HxqELKV+dhCRfZesWfTJR/UNDH//29fAj0hw==
X-Received: by 2002:a05:622a:4ac4:b0:475:16db:b911 with SMTP id
 d75a77b69052e-4a38c7e0c09mr1188341cf.52.1748387589998; 
 Tue, 27 May 2025 16:13:09 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 10/13] migration/postcopy: Cache the tid->vcpu mapping for
 blocktime
Date: Tue, 27 May 2025 19:12:45 -0400
Message-ID: <20250527231248.1279174-11-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527231248.1279174-1-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Looking up the vCPU index for each fault can be expensive when there're
hundreds of vCPUs.  Provide a cache for tid->vcpu instead with a hash
table, then lookup from there.

When at it, add another counter to record how many non-vCPU faults it gets.
For example, the main thread can also access a guest page that was missing.
These kind of faults are not accounted by blocktime so far.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 68 ++++++++++++++++++++++++++++++++++------
 migration/trace-events   |  3 +-
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e73f5d1cc7..4fb1d92d7b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -127,6 +127,17 @@ typedef struct PostcopyBlocktimeContext {
     /* number of vCPU are suspended */
     int smp_cpus_down;
 
+    /*
+     * Fast path for looking up vcpu_index from tid.  NOTE: this result
+     * only reflects the vcpu setup when postcopy is running.  It may not
+     * always match with the current vcpu setup because vcpus can be hot
+     * attached/detached after migration completes.  However this should be
+     * stable when blocktime is using the structure.
+    */
+    GHashTable *tid_to_vcpu_hash;
+    /* Count of non-vCPU faults.  This is only for debugging purpose. */
+    uint64_t non_vcpu_faults;
+
     /*
      * Handler for exit event, necessary for
      * releasing whole blocktime_ctx
@@ -136,6 +147,7 @@ typedef struct PostcopyBlocktimeContext {
 
 static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
+    g_hash_table_destroy(ctx->tid_to_vcpu_hash);
     g_free(ctx->vcpu_blocktime_start);
     g_free(ctx->vcpu_blocktime_total);
     g_free(ctx->vcpu_faults_count);
@@ -150,6 +162,36 @@ static void migration_exit_cb(Notifier *n, void *data)
     destroy_blocktime_context(ctx);
 }
 
+static GHashTable *blocktime_init_tid_to_vcpu_hash(void)
+{
+    /*
+     * TID as an unsigned int can be directly used as the key.  However,
+     * CPU index can NOT be directly used as value, because CPU index can
+     * be 0, which means NULL.  Then when lookup we can never know whether
+     * it's 0 or "not found".  Hence use an indirection for CPU index.
+     */
+    GHashTable *table = g_hash_table_new_full(g_direct_hash, g_direct_equal,
+                                              NULL, g_free);
+    CPUState *cpu;
+
+    /*
+     * Initialize the tid->cpu_id mapping for lookups.  The caller needs to
+     * make sure when reaching here the CPU topology is frozen and will be
+     * stable for the whole blocktime trapping period.
+     */
+    CPU_FOREACH(cpu) {
+        int *value = g_new(int, 1);
+
+        *value = cpu->cpu_index;
+        g_hash_table_insert(table,
+                            GUINT_TO_POINTER((uint32_t)cpu->thread_id),
+                            value);
+        trace_postcopy_blocktime_tid_cpu_map(cpu->cpu_index, cpu->thread_id);
+    }
+
+    return table;
+}
+
 static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -160,6 +202,8 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
+    ctx->tid_to_vcpu_hash = blocktime_init_tid_to_vcpu_hash();
+
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
 
@@ -826,18 +870,21 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
     return 0;
 }
 
-static int get_mem_fault_cpu_index(uint32_t pid)
+static int blocktime_get_vcpu(PostcopyBlocktimeContext *ctx, uint32_t tid)
 {
-    CPUState *cpu_iter;
+    int *found;
 
-    CPU_FOREACH(cpu_iter) {
-        if (cpu_iter->thread_id == pid) {
-            trace_get_mem_fault_cpu_index(cpu_iter->cpu_index, pid);
-            return cpu_iter->cpu_index;
-        }
+    found = g_hash_table_lookup(ctx->tid_to_vcpu_hash, GUINT_TO_POINTER(tid));
+    if (!found) {
+        /*
+         * NOTE: this is possible, because QEMU's non-vCPU threads can
+         * also access a missing page.  Or, when KVM async pf is enabled, a
+         * fault can even happen from a kworker..
+         */
+        return -1;
     }
-    trace_get_mem_fault_cpu_index(-1, pid);
-    return -1;
+
+    return *found;
 }
 
 static uint64_t get_current_us(void)
@@ -864,8 +911,9 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     if (!dc || ptid == 0) {
         return;
     }
-    cpu = get_mem_fault_cpu_index(ptid);
+    cpu = blocktime_get_vcpu(dc, ptid);
     if (cpu < 0) {
+        dc->non_vcpu_faults++;
         return;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index 02cdb6e7cc..9c1f3b7044 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -310,8 +310,7 @@ postcopy_preempt_tls_handshake(void) ""
 postcopy_preempt_new_channel(void) ""
 postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
-
-get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
+postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
 
 # exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.49.0


