Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C557FCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OE-00028C-G6; Fri, 10 Oct 2025 04:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OD-00027f-2s
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O6-00016t-Sy
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qF2iQktUqaSYd6/UA/G6360wiPvRXYzYs4yJ69J+Yg=;
 b=bInZ87Q4vSc+4jkafT1TSSi3jbAErY7OKNqrTY4+kKkxd9laaaJdohyAUr4wHVhHzxzEJ6
 YSl1IYEZberCaFkPNAJazHGawhMG212wCpRDO3Av9LUMImoc0051xncuKSFuQYnmICvlhC
 WR2fGQGjMwcH+Bm1TM8SO6dli1peeAM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-ebOyLaAHMTCNNoE7eEW_Kw-1; Fri,
 10 Oct 2025 04:22:00 -0400
X-MC-Unique: ebOyLaAHMTCNNoE7eEW_Kw-1
X-Mimecast-MFC-AGG-ID: ebOyLaAHMTCNNoE7eEW_Kw_1760084519
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A78D195608F; Fri, 10 Oct 2025 08:21:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 285B01800452; Fri, 10 Oct 2025 08:21:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/9] target/s390x: Replace legacy cpu_physical_memory_[un]map()
 calls (2/3)
Date: Fri, 10 Oct 2025 10:21:40 +0200
Message-ID: <20251010082145.576222-6-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Replace the *_map() / *_unmap() methods in cpu_[un]map_lowcore().
No behavioral change expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251002091132.65703-7-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a6d4a1ce05d..b01b7d9bbbf 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -26,6 +26,7 @@
 #include "hw/s390x/ioinst.h"
 #include "target/s390x/kvm/pv.h"
 #include "system/hw_accel.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "exec/target_page.h"
 #include "exec/watchpoint.h"
@@ -107,11 +108,13 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
 {
     LowCore *lowcore;
     hwaddr len = sizeof(LowCore);
+    CPUState *cs = env_cpu(env);
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
 
-    lowcore = cpu_physical_memory_map(env->psa, &len, true);
+    lowcore = address_space_map(cs->as, env->psa, &len, true, attrs);
 
     if (len < sizeof(LowCore)) {
-        cpu_abort(env_cpu(env), "Could not map lowcore\n");
+        cpu_abort(cs, "Could not map lowcore\n");
     }
 
     return lowcore;
@@ -119,7 +122,9 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
 
 void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore)
 {
-    cpu_physical_memory_unmap(lowcore, sizeof(LowCore), 1, sizeof(LowCore));
+    AddressSpace *as = env_cpu(env)->as;
+
+    address_space_unmap(as, lowcore, sizeof(LowCore), true, sizeof(LowCore));
 }
 
 void do_restart_interrupt(CPUS390XState *env)
-- 
2.51.0


