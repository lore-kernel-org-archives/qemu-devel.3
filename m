Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F086C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxa-0004YZ-H6; Wed, 29 May 2024 06:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxY-0004Xx-Sa
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxU-000359-9w
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D649wpf7fiL4benJY0EmDtgPf0hrsPfPJlzQXEO2rsk=;
 b=gIQM/dJbfEa/Dgywt4VP257j+jOE6SgspoYjdS3BDk56a/tqgyFdkw3gA7BCktaXqyTdrP
 D6unomTEzd6hv5knz1EZV94+Rkg9nkghZDVQqMuJ4AzaWsEwQvuHOu9P8s7eDBp4lRdTdb
 BkGgMCS3tF5W3GTecoztSJQcDKyGrKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-JgcYcQ2bOWG9vOeN-sNcaQ-1; Wed, 29 May 2024 06:54:59 -0400
X-MC-Unique: JgcYcQ2bOWG9vOeN-sNcaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B4C481227E;
 Wed, 29 May 2024 10:54:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFC4B105480A;
 Wed, 29 May 2024 10:54:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 02/22] target/s390x: Move cpu_get_tb_cpu_state out of line
Date: Wed, 29 May 2024 12:54:34 +0200
Message-ID: <20240529105454.1149225-3-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240502054417.234340-3-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu.h | 23 ++---------------------
 target/s390x/cpu.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 414680eed1..950f84f316 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -413,27 +413,8 @@ static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 
 #include "tcg/tcg_s390x.h"
 
-static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    if (env->psw.addr & 1) {
-        /*
-         * Instructions must be at even addresses.
-         * This needs to be checked before address translation.
-         */
-        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
-        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
-    }
-    *pc = env->psw.addr;
-    *cs_base = env->ex_value;
-    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
-    if (env->cregs[0] & CR0_AFP) {
-        *flags |= FLAG_MASK_AFP;
-    }
-    if (env->cregs[0] & CR0_VECTOR) {
-        *flags |= FLAG_MASK_VECTOR;
-    }
-}
+void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags);
 
 #endif /* CONFIG_TCG */
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f7194534ae..a8428b5a1e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -324,6 +324,28 @@ static void s390_cpu_reset_full(DeviceState *dev)
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
+void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    if (env->psw.addr & 1) {
+        /*
+         * Instructions must be at even addresses.
+         * This needs to be checked before address translation.
+         */
+        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
+    }
+    *pc = env->psw.addr;
+    *cs_base = env->ex_value;
+    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    if (env->cregs[0] & CR0_AFP) {
+        *flags |= FLAG_MASK_AFP;
+    }
+    if (env->cregs[0] & CR0_VECTOR) {
+        *flags |= FLAG_MASK_VECTOR;
+    }
+}
+
 static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .restore_state_to_opc = s390x_restore_state_to_opc,
-- 
2.45.1


