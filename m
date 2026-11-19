Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9610606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=n2eRUugv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0OC-0004yo-AZ; Thu, 19 Nov 2026 06:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU0O9-0004pa-O4
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:33:13 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU0O8-0000Jl-53
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795087990; bh=/HPHV+TSxZmS95HX+EawsUVB+TdFHTvgM2adYaMvXWs=;
 h=From:To:Cc:Subject:Date;
 b=n2eRUugvqRxi+NGMnjGkm6+GH0bIYvJ1kkG1qoy7R9Afrto0JdxjlM054Mie5sfNM
 7aXetEYur56R2FRN33aCzjqs/hPamjaZ9rt99FieI4qNvUGfxKJ+7wg3e3wTq3yofL
 Tinhn3OGiOrQBcT43vsy0n4tNuw33CY8MnZOeFhapukT2XqbDqD6RWfEi8VU0Pd88/
 mVus0t2lgQVQ7NozDJFaQ++4HTmCBf1LJycCCAzKmneI5aoGIcP8NYJI2RZ3m05NHc
 jSsNRT8UOm38UgluiDCEHEpLdihpDK4vk/X8PzVLljUMcKHmpbDOECrC7m80Jsj7S5
 OMpkZ2OrM9LLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 133021E7EFE;
 Thu, 19 Nov 2026 14:33:10 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0DB184617E5;
 Thu, 19 Nov 2026 14:33:10 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 03C3CBC7F6; Thu, 19 Nov 2026 14:33:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, David Hildenbrand <david@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 for-11.2] hostmem: allow building without KVM support
Date: Thu, 19 Nov 2026 14:33:06 +0300
Message-ID: <20261119113309.1205353-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On architectures where KVM is not available and so including <linux/kvm.h>
does not work, buildnig backends/hostmem-memfd.c fails since 7ca43d7ad02f:

 In file included from backends/hostmem-memfd.c:23:
 linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
   16 | #include <asm/kvm.h>

Do not include <linux/kvm.h> because "system/kvm.h" already includes it for us
when KVM is enabled, and guard the actual code using memfd definitions with
<linux/kvm.h> too.  When using #ifdef like this, we can also provide a more
clear error message.

Fixes: 7ca43d7ad02f ("hostmem: Support fully shared guest memfd to back a VM")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 backends/hostmem-memfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 46489212a23..698ec930a5c 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -20,7 +20,6 @@
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
-#include <linux/kvm.h>
 #include "qapi/qapi-type-infos-common.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
@@ -71,10 +70,15 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
             return false;
         }
 
+#ifdef CONFIG_KVM
         fd = kvm_create_guest_memfd(backend->size,
                                     GUEST_MEMFD_FLAG_MMAP |
                                     GUEST_MEMFD_FLAG_INIT_SHARED,
                                     errp);
+#else
+        error_setg(errp, "guest-memfd=on requires KVM which is not enabled");
+        return false;
+#endif
     } else {
         fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                                m->hugetlb, m->hugetlbsize, m->seal ?
-- 
2.47.3


