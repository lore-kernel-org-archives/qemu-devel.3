Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ADAE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxh-0005xs-4h; Sat, 27 Dec 2025 04:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxg-0005uQ-CE
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxe-0007Wp-Hu
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Deewm7Dlj2izzGqvYhNToDgUlCdOD6wk8rZjXJhmSHg=;
 b=eAnZNuRaxEYx4vW753H5sZxa1mv/jDzkub1FKSBteRum0grfMxo0BlM3qIul7wBWNlEOZO
 En8fcjm98Y4K+1ZQ4crCUmODTgYixYUw9xBw56AJmtkym5jpMHcv1L2yNwJ1r89g7y62Nr
 AUN/tRRvuihpdbj4AkiiWpGDmpCaZeQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-N3rJuE1rNICL8wlmf-TARw-1; Sat, 27 Dec 2025 04:51:44 -0500
X-MC-Unique: N3rJuE1rNICL8wlmf-TARw-1
X-Mimecast-MFC-AGG-ID: N3rJuE1rNICL8wlmf-TARw_1766829103
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so65324005e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829103; x=1767433903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Deewm7Dlj2izzGqvYhNToDgUlCdOD6wk8rZjXJhmSHg=;
 b=Jo4gsEZHa7LbTb59Bkar+QCSeqKbxj2hVOKEIt7Q65ny4ZGuQ+xrnYiLAFgK1yggJJ
 FnOojzAhN1hS4B+1DwAsT/1nxYmQCNr30DR2/JqZ/1xg5KAcNEqq+5lYx/0qIZggX5M0
 gkdW/5i41kHfJjnELa4pfH9XMdMEs1pD9yDT6w02J1Q+9+6cqR5mUZbfIIAtSNI9F2WE
 c5FR2gCM/7+aiD3jocPpE8Mlt29gaYofnRDIV+tR7Szwn8spq2L0Gwqs9gzo/4SOHjgJ
 zi500WA+vH6P151IJO+lg/pKEFMdV7BuntH8ofIDfIlWvCwotmVef7Tw+/FoaqvaVXmd
 lgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829103; x=1767433903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Deewm7Dlj2izzGqvYhNToDgUlCdOD6wk8rZjXJhmSHg=;
 b=B91v7vUbda1TUz+0asNfy12BBOOS4wN0a4Dleoox7fqWUcyMAaPCBUxHKiLKmQ3J+5
 H9zHac/nilMR6EeedvAb3lFEjX80x3me8rAXCBur7AfFFmedLokBbiDLKKXyZkAD4MNr
 TB2Lpn60WjL1V4mEXwbLAfvPxU0+KYJRmmTA9gA+EaByXJaA+7n8FroVuWarq77WMgIK
 c7xzsRRbc8DXlJFFhA1//Qoy1Vprd2SvUA2F+ak/XLHkMJAzog6zksOsAyFii+J4Gid9
 H8sTYPDhObZBJpDTAHrTWFgH3RyMLbbModB1rjl0SNCT+ZU9w1Qw3Kl5s4txnb8S/diO
 qIag==
X-Gm-Message-State: AOJu0YwRDzMpSxZdCzx0kzf6hAIqOBaHE59XeOWNd1KZu8ZhFP6ANyyh
 cAQTEk9xHCiWHHI/ARaB2kOdHiftRL9y8DLyVrbwpFUGxLgp9E0eI2sXzcBCVoxHB8JJ/L4DwmE
 gNg4qeVmKq3ou155UF9Q06BX48THCqWWpusghh+eUb8P0kDr+wANKtBcRKnrl78/NfgMbwl6qjl
 cTGgjdGRelaVwSQwamMNLWvyVEAytHoly1avRw4wug
X-Gm-Gg: AY/fxX4AtRKjDDVl+qeYIdUDRbL0knx2JnMTq3fvzAWAiTqXfXIWtkQZ5clkHDpWR5k
 9nkDNMxe+Q/sxhjyft1OxLxIPZaDpc+Gi39PueVFuLftTg39HuZxJ91JdNksN1eGINSAZJJX8iB
 IMc12OSKmFqGYw5fvsOVPSWORl0Zq0j5nkhD4yE2wXRLLH4+Xfq6p1C/QxpLtRj7CVwajEL5bzG
 MFSPQKZFjfVIYOtlBiv4PBHO5chCt8UPo5yxuA6LTfLUwejA/Yjzge60bVweyeW24vkY2nOiZTX
 42cWeVQOsQ4PlO46DOXEVTRcFAtiABIkQtwKUkYsZteS2n6xj/yRy1iYdpdcqo8ngXBOtnp5AKM
 3iGRvY7qze3e1MXPBejqCW/QBJA+h8lSP6XXqp/J2i1lj0wtzfFajFOl2U4/rAeyrvVXQrace26
 svgmK4aMp0NtzpAzo=
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d1958a43fmr253977995e9.19.1766829102705; 
 Sat, 27 Dec 2025 01:51:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbs/wWIFhT6w4/c8ZjB8Ygc85ji3nN7bKqfrLGkQ2SAA/sXcIM6e9awGz39CbVekA3EyPB7Q==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d1958a43fmr253977735e9.19.1766829102247; 
 Sat, 27 Dec 2025 01:51:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a4651bsm191597025e9.7.2025.12.27.01.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Marc Morcos <marcmorcos@google.com>
Subject: [PULL 147/153] thread-pool: Fix thread race
Date: Sat, 27 Dec 2025 10:47:52 +0100
Message-ID: <20251227094759.35658-73-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc Morcos <marcmorcos@google.com>

Fix a data race occurred between `worker_thread()` writing and
`thread_pool_completion_bh()` reading shared data in `util/thread-pool.c`.

Signed-off-by: Marc Morcos <marcmorcos@google.com>
Link: https://lore.kernel.org/r/20251213001443.2041258-3-marcmorcos@google.com
[Use qatomic_set for writes to ret->ret. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/thread-pool.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index d2ead6b7285..8f8cb38d5ce 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -18,6 +18,7 @@
 #include "qemu/defer-call.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
+#include "qemu/atomic.h"
 #include "qemu/coroutine.h"
 #include "trace.h"
 #include "block/thread-pool.h"
@@ -39,9 +40,13 @@ struct ThreadPoolElementAio {
     ThreadPoolFunc *func;
     void *arg;
 
-    /* Moving state out of THREAD_QUEUED is protected by lock.  After
-     * that, only the worker thread can write to it.  Reads and writes
-     * of state and ret are ordered with memory barriers.
+    /*
+     * Accessed with atomics.  Moving state out of THREAD_QUEUED is
+     * protected by pool->lock and only the worker thread can move
+     * the state from THREAD_ACTIVE to THREAD_DONE.
+     *
+     * When state is THREAD_DONE, ret must have been written already.
+     * Use acquire/release ordering when reading/writing ret as well.
      */
     enum ThreadState state;
     int ret;
@@ -105,15 +110,14 @@ static void *worker_thread(void *opaque)
 
         req = QTAILQ_FIRST(&pool->request_list);
         QTAILQ_REMOVE(&pool->request_list, req, reqs);
-        req->state = THREAD_ACTIVE;
+        qatomic_set(&req->state, THREAD_ACTIVE);
         qemu_mutex_unlock(&pool->lock);
 
         ret = req->func(req->arg);
 
-        req->ret = ret;
-        /* Write ret before state.  */
-        smp_wmb();
-        req->state = THREAD_DONE;
+        qatomic_set(&req->ret, ret);
+        /* _release to write ret before state.  */
+        qatomic_store_release(&req->state, THREAD_DONE);
 
         qemu_bh_schedule(pool->completion_bh);
         qemu_mutex_lock(&pool->lock);
@@ -180,7 +184,8 @@ static void thread_pool_completion_bh(void *opaque)
 
 restart:
     QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
-        if (elem->state != THREAD_DONE) {
+        /* _acquire to read state before ret.  */
+        if (qatomic_load_acquire(&elem->state) != THREAD_DONE) {
             continue;
         }
 
@@ -189,9 +194,6 @@ restart:
         QLIST_REMOVE(elem, all);
 
         if (elem->common.cb) {
-            /* Read state before ret.  */
-            smp_rmb();
-
             /* Schedule ourselves in case elem->common.cb() calls aio_poll() to
              * wait for another request that completed at the same time.
              */
@@ -223,12 +225,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)
     trace_thread_pool_cancel_aio(elem, elem->common.opaque);
 
     QEMU_LOCK_GUARD(&pool->lock);
-    if (elem->state == THREAD_QUEUED) {
+    if (qatomic_read(&elem->state) == THREAD_QUEUED) {
         QTAILQ_REMOVE(&pool->request_list, elem, reqs);
         qemu_bh_schedule(pool->completion_bh);
 
-        elem->state = THREAD_DONE;
-        elem->ret = -ECANCELED;
+        qatomic_set(&elem->ret, -ECANCELED);
+        qatomic_store_release(&elem->state, THREAD_DONE);
     }
 
 }
-- 
2.52.0


