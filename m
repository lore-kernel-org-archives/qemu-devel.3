Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB91FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITra-0008CT-2s; Thu, 30 Apr 2026 12:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrO-0007dZ-GU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrL-0007B8-QD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777565005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTQH8Xk4rqvkiYnv2/aGbRTg+OAKN8L11IMTTxA0LDs=;
 b=XsKVoato7FLGJvbW+bn5NV05Fsy52u39J5lq2mR6U+ZcBTLZX3aUDkIMhm1DLMkw8LrG7/
 lpAyNljEDOLy7K35tPrZov3CPO7tUOMdRrYEEr22+n/uFE0A55gfKKF8J1sUCZdJ9wwEmy
 lKyjLJf/vMxCGsltXe/Geazkba6Iv88=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-4q6-AtfJOU2ff1wXRRMGFw-1; Thu,
 30 Apr 2026 12:03:18 -0400
X-MC-Unique: 4q6-AtfJOU2ff1wXRRMGFw-1
X-Mimecast-MFC-AGG-ID: 4q6-AtfJOU2ff1wXRRMGFw_1777564997
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57A191800620; Thu, 30 Apr 2026 16:03:17 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.50.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4F491800446; Thu, 30 Apr 2026 16:03:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 02/11] target/s390x: Replace legacy ld/st_phys ->
 address_space_ld/st (cpu)
Date: Thu, 30 Apr 2026 18:02:58 +0200
Message-ID: <20260430160307.634093-3-cohuck@redhat.com>
In-Reply-To: <20260430160307.634093-1-cohuck@redhat.com>
References: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.
This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result). No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260319185203.11799-2-philmd@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/tcg/excp_helper.c | 21 +++++++++++++--------
 target/s390x/tcg/mem_helper.c  | 12 +++++++-----
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 41b0017d767c..05e448d3f20c 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -54,8 +54,9 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     g_assert(dxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Store the DXC into the lowcore */
-    stl_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, data_exc_code), dxc);
+    address_space_stl_be(env_cpu(env)->as,
+                         env->psa + offsetof(LowCore, data_exc_code), dxc,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 #endif
 
     /* Store the DXC into the FPC if AFP is enabled */
@@ -71,8 +72,9 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
     g_assert(vxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Always store the VXC into the lowcore, without AFP it is undefined */
-    stl_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, data_exc_code), vxc);
+    address_space_stl_be(env_cpu(env)->as,
+                         env->psa + offsetof(LowCore, data_exc_code), vxc,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 #endif
 
     /* Always store the VXC into the FPC, without AFP it is undefined */
@@ -619,11 +621,14 @@ void monitor_event(CPUS390XState *env,
                    uint64_t monitor_code,
                    uint8_t monitor_class, uintptr_t ra)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = env_cpu(env)->as;
+
     /* Store the Monitor Code and the Monitor Class Number into the lowcore */
-    stq_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, monitor_code), monitor_code);
-    stw_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, mon_class_num), monitor_class);
+    address_space_stq_be(as, env->psa + offsetof(LowCore, monitor_code),
+                         monitor_code, attrs, NULL);
+    address_space_stw_be(as, env->psa + offsetof(LowCore, mon_class_num),
+                         monitor_class, attrs, NULL);
 
     tcg_s390_program_interrupt(env, PGM_MONITOR, ra);
 }
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 2a79a789f639..8474a6941107 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -41,6 +41,7 @@
 #else
 #include "hw/s390x/storage-keys.h"
 #include "hw/core/boards.h"
+#include "system/memory.h"
 #endif
 
 #ifdef CONFIG_USER_ONLY
@@ -958,13 +959,14 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint32_t r1, uint32_t r2)
 inject_exc:
 #if !defined(CONFIG_USER_ONLY)
     if (exc != PGM_ADDRESSING) {
-        stq_be_phys(env_cpu(env)->as,
-                    env->psa + offsetof(LowCore, trans_exc_code),
-                    env->tlb_fill_tec);
+        address_space_stq_be(env_cpu(env)->as,
+                             env->psa + offsetof(LowCore, trans_exc_code),
+                             env->tlb_fill_tec, MEMTXATTRS_UNSPECIFIED, NULL);
     }
     if (exc == PGM_PAGE_TRANS) {
-        stb_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, op_access_id),
-                 r1 << 4 | r2);
+        address_space_stb(env_cpu(env)->as,
+                          env->psa + offsetof(LowCore, op_access_id),
+                          r1 << 4 | r2, MEMTXATTRS_UNSPECIFIED, NULL);
     }
 #endif
     tcg_s390_program_interrupt(env, exc, ra);
-- 
2.53.0


