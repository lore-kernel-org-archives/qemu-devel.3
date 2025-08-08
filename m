Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDBFC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLo8-0005s1-T5; Fri, 08 Aug 2025 08:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnW-0003rb-BY
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnQ-00078H-K5
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCITsgCv3Hu/JlCctom2/aI1GK8hv6Ze3+Vz7OME/UA=;
 b=btD2v0IwZmC74mZMA6GI8GFXh3t743qu3umXELld0fvh9DWtkmAaQPlEH2bh+Osv6ouR/6
 QUkOpC8mPz1BZxQiFaWPBwY5JA06NCMpjjb0hQIEKSK81AnmNXlJY8WX+Og3+cWV1+cbOH
 8ssxgld4pjYEIQ1uOP5VzqaNZ2BI8IU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-pxb0y70RMEWLPNJUvXlaBA-1; Fri,
 08 Aug 2025 08:01:59 -0400
X-MC-Unique: pxb0y70RMEWLPNJUvXlaBA-1
X-Mimecast-MFC-AGG-ID: pxb0y70RMEWLPNJUvXlaBA_1754654519
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F197819560AF; Fri,  8 Aug 2025 12:01:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84C3919560B0; Fri,  8 Aug 2025 12:01:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 06/10] introduce cpu_test_interrupt() that will replace
 open coded checks
Date: Fri,  8 Aug 2025 14:01:33 +0200
Message-ID: <20250808120137.2208800-7-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

the helper forms load-acquire/store-release pair with
tcg_handle_interrupt/generic_handle_interrupt and can be used
for checking interrupts outside of BQL

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/core/cpu.h     | 12 ++++++++++++
 accel/tcg/tcg-accel-ops.c |  3 ++-
 system/cpus.c             |  3 ++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5eaf41a566..d0460c01cf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -942,6 +942,18 @@ CPUState *cpu_by_arch_id(int64_t id);
 
 void cpu_interrupt(CPUState *cpu, int mask);
 
+/**
+ * cpu_test_interrupt:
+ * @cpu: The CPU to check interrupt(s) on.
+ * @mask: The interrupts to check.
+ *
+ * Checks if any of interrupts in @mask are pending on @cpu.
+ */
+static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
+{
+    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
+}
+
 /**
  * cpu_set_pc:
  * @cpu: The CPU to set the program counter for.
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3b0d7d298e..02c7600bb7 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -97,7 +97,8 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    qatomic_store_release(&cpu->interrupt_request,
+        cpu->interrupt_request | mask);
 
     /*
      * If called from iothread context, wake the target cpu in
diff --git a/system/cpus.c b/system/cpus.c
index 256723558d..8e543488c3 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -256,7 +256,8 @@ int64_t cpus_get_elapsed_ticks(void)
 
 void generic_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    qatomic_store_release(&cpu->interrupt_request,
+        cpu->interrupt_request | mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.47.1


