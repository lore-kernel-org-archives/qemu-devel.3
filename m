Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B19CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OG-00028u-Hg; Fri, 10 Oct 2025 04:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OD-00027u-WB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O7-00010d-UV
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXv/Cu7q862t0pbzb6wi7PCL6APdP4WKt8M+wjFeRsc=;
 b=bnelYJfPCQg4rZP4EirqfRGngk6V+67Ne7BMELnKH3e/rKxvb+VykJluntZKK31EBlHIHs
 8oodPMI73ovvJ1RZUI+rNuV5S8FGeHRqL/2VlxlkCxxA6TuItdQxymvGEWheAquxmqswzj
 Cb8cxyvWEuxsK2Frbq9PGvj/QsaAthY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-hUrEdA6-N4aECN-afarWTA-1; Fri,
 10 Oct 2025 04:21:56 -0400
X-MC-Unique: hUrEdA6-N4aECN-afarWTA-1
X-Mimecast-MFC-AGG-ID: hUrEdA6-N4aECN-afarWTA_1760084515
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D1D71800366; Fri, 10 Oct 2025 08:21:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0ABB1800446; Fri, 10 Oct 2025 08:21:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/9] target/s390x: Replace legacy cpu_physical_memory_[un]map()
 calls (1/3)
Date: Fri, 10 Oct 2025 10:21:38 +0200
Message-ID: <20251010082145.576222-4-thuth@redhat.com>
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

Replace the *_map() / *_unmap() methods in mchk_store_vregs().
No behavioral change expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251002091132.65703-5-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/excp_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 4c7faeee82b..5e1d4dc9583 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -30,6 +30,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "qemu/timer.h"
 #include "system/address-spaces.h"
+#include "system/memory.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/boards.h"
@@ -418,16 +419,18 @@ QEMU_BUILD_BUG_ON(sizeof(MchkExtSaveArea) != 1024);
 
 static int mchk_store_vregs(CPUS390XState *env, uint64_t mcesao)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = env_cpu(env)->as;
     hwaddr len = sizeof(MchkExtSaveArea);
     MchkExtSaveArea *sa;
     int i;
 
-    sa = cpu_physical_memory_map(mcesao, &len, true);
+    sa = address_space_map(as, mcesao, &len, true, attrs);
     if (!sa) {
         return -EFAULT;
     }
     if (len != sizeof(MchkExtSaveArea)) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
+        address_space_unmap(as, sa, len, true, 0);
         return -EFAULT;
     }
 
@@ -436,7 +439,7 @@ static int mchk_store_vregs(CPUS390XState *env, uint64_t mcesao)
         sa->vregs[i][1] = cpu_to_be64(env->vregs[i][1]);
     }
 
-    cpu_physical_memory_unmap(sa, len, 1, len);
+    address_space_unmap(as, sa, len, true, len);
     return 0;
 }
 
-- 
2.51.0


