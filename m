Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA85C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8NS-0007hC-6A; Wed, 29 Jan 2025 08:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NP-0007fV-A0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NN-0008MU-HE
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738158304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WondAvZ/n5a1SFkDwYqS9KCSNSrSWDpI4BteXa+G/U8=;
 b=RoOOPB+VrdAh++HsosvMFCuWYulYlt3SIm9+IV0fQTnqAFgJLVQByrJReBXzlMzhgk77I8
 4PhOoGgzPtmncMH1Oc9NhHIrvunpLqoRvy6Har6P2raxdbo6Ki8C5MAG5FsZhdWAsR4NWB
 LZYhsEm0feAynYlVOqlUF2uBNhqPbhI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-VRFeNc4tNQu7EsQTyMPkew-1; Wed,
 29 Jan 2025 08:45:01 -0500
X-MC-Unique: VRFeNc4tNQu7EsQTyMPkew-1
X-Mimecast-MFC-AGG-ID: VRFeNc4tNQu7EsQTyMPkew
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303CE1800374; Wed, 29 Jan 2025 13:44:59 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E0FC1800955; Wed, 29 Jan 2025 13:44:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu,
 npiggin@gmail.com
Subject: [PATCH 5/6] Revert "tcg/cputlb: remove other-cpu capability from TLB
 flushing"
Date: Wed, 29 Jan 2025 14:44:35 +0100
Message-ID: <20250129134436.1240740-6-imammedo@redhat.com>
In-Reply-To: <20250129134436.1240740-1-imammedo@redhat.com>
References: <20250129134436.1240740-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

1)
This reverts commit 30933c4fb4f3df95ae44c4c3c86a5df049852c01.
  ("tcg/cputlb: remove other-cpu capability from TLB flushing")

The commit caused a regression which went unnoticed due to
affected being disabled by default (DEBUG_TLB_GATE 0)
Previous patch moved switched to using tcg_debug_assert() so that
at least on debug builds assert_cpu_is_self() path would be exercised.

And that lead to exposing regression introduced by [1] with abort during tests.
to reproduce:
  $ configure  --target-list=x86_64-softmmu --enable-debug
  $ make && ./qemu-system-x86_64

  accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx:
    Assertion `!(cpu)->created || qemu_cpu_is_self(cpu)' failed.

which is triggered by usage outside of cpu thread:
    x86_cpu_new -> ... ->
      x86_cpu_realizefn -> cpu_reset -> ... ->
          tcg_cpu_reset_hold

Drop offending commit for now, until a propper fix that doesn't break
'make check' is available.

PS:
fixup g_memdup() checkpatch error s/g_memdup/g_memdup2/

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
I'll leave it upto TCG folz to fix it up propperly.

CC: npiggin@gmail.com
CC: richard.henderson@linaro.org
---
 accel/tcg/cputlb.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 71207d6dbf..db1713b3ca 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -416,9 +416,12 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
-    assert_cpu_is_self(cpu);
-
-    tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
+    if (cpu->created && !qemu_cpu_is_self(cpu)) {
+        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
+                         RUN_ON_CPU_HOST_INT(idxmap));
+    } else {
+        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
+    }
 }
 
 void tlb_flush(CPUState *cpu)
@@ -607,12 +610,28 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
 {
     tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
 
-    assert_cpu_is_self(cpu);
-
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
 
-    tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
+    if (qemu_cpu_is_self(cpu)) {
+        tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
+    } else if (idxmap < TARGET_PAGE_SIZE) {
+        /*
+         * Most targets have only a few mmu_idx.  In the case where
+         * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
+         * allocating memory for this operation.
+         */
+        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
+                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
+    } else {
+        TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
+
+        /* Otherwise allocate a structure, freed by the worker.  */
+        d->addr = addr;
+        d->idxmap = idxmap;
+        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_2,
+                         RUN_ON_CPU_HOST_PTR(d));
+    }
 }
 
 void tlb_flush_page(CPUState *cpu, vaddr addr)
@@ -775,8 +794,6 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 {
     TLBFlushRangeData d;
 
-    assert_cpu_is_self(cpu);
-
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
@@ -797,7 +814,14 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
     d.idxmap = idxmap;
     d.bits = bits;
 
-    tlb_flush_range_by_mmuidx_async_0(cpu, d);
+    if (qemu_cpu_is_self(cpu)) {
+        tlb_flush_range_by_mmuidx_async_0(cpu, d);
+    } else {
+        /* Otherwise allocate a structure, freed by the worker.  */
+        TLBFlushRangeData *p = g_memdup2(&d, sizeof(d));
+        async_run_on_cpu(cpu, tlb_flush_range_by_mmuidx_async_1,
+                         RUN_ON_CPU_HOST_PTR(p));
+    }
 }
 
 void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
-- 
2.43.0


