Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394CCC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts48D-0008Dp-Pe; Tue, 11 Mar 2025 14:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47P-000762-MQ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47L-0006je-Tk
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oz80cud8d/O9AxwXlwq1eflo4nCDY3v+ve3Qqy7+aDg=;
 b=A3KpYqUWuSodXYQQx5vtELAuG9iqFhxG0P2L1N9SMjGmGpzKE8kYFYTaiZo8jwgV+7Znfo
 dQXnUEnZ1QwfhGCQaL+S4WFbG9g9Ok7e7KRhN5KMc682wg2xp3N7Gt9PV4Xz+isQZG7pri
 AFs/wMrQwy5mM/pLGh1QuujkzDAJfkY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-TzCahFhnMH-5SIHMyPQ3Pw-1; Tue,
 11 Mar 2025 14:14:05 -0400
X-MC-Unique: TzCahFhnMH-5SIHMyPQ3Pw-1
X-Mimecast-MFC-AGG-ID: TzCahFhnMH-5SIHMyPQ3Pw_1741716844
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62B6519560B2; Tue, 11 Mar 2025 18:14:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A109418001E9; Tue, 11 Mar 2025 18:14:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/21] system: Declare qemu_[min/max]rampagesize() in
 'system/hostmem.h'
Date: Tue, 11 Mar 2025 19:13:19 +0100
Message-ID: <20250311181328.1200431-13-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Both qemu_minrampagesize() and qemu_maxrampagesize() are
related to host memory backends, having the following call
stack:

  qemu_minrampagesize()
     -> find_min_backend_pagesize()
         -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)

  qemu_maxrampagesize()
     -> find_max_backend_pagesize()
        -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)

Having TYPE_MEMORY_BACKEND defined in "system/hostmem.h":

  include/system/hostmem.h:23:#define TYPE_MEMORY_BACKEND "memory-backend"

Move their prototype declaration to "system/hostmem.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250308230917.18907-7-philmd@linaro.org>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250311085743.21724-2-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/exec/ram_addr.h    | 3 ---
 include/system/hostmem.h   | 3 +++
 hw/ppc/spapr_caps.c        | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/vfio/spapr.c            | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3d8df4edf15cd916d477250444ac6833c76f0286..e4c28fbec9b470f0f64eb07ad5fcba6b43a5fcc4 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -102,9 +102,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 
 bool ramblock_is_pmem(RAMBlock *rb);
 
-long qemu_minrampagesize(void);
-long qemu_maxrampagesize(void);
-
 /**
  * qemu_ram_alloc_from_file,
  * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 5c21ca55c0176af7356905e1b04358c52fc8a5f8..62642e602ca97dffa4baec29f9b73ccf56c29700 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -93,4 +93,7 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
 char *host_memory_backend_get_name(HostMemoryBackend *backend);
 
+long qemu_minrampagesize(void);
+long qemu_maxrampagesize(void);
+
 #endif
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 904bff87ce125cd0d69560f2b2ec54ed0a5e94e9..9e53d0c1fd1cccf366f7306a83f8859e22f39da3 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -34,6 +34,7 @@
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
+#include "system/hostmem.h"
 
 #include "hw/ppc/spapr.h"
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a9b3db19f63d5b50a87ed751d856294f2c0c17d5..75b32182eb01991fdc63fa1d38c838d5dc95d82b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/s390x/tod.h"
 #include "system/system.h"
 #include "system/cpus.h"
+#include "system/hostmem.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index ad4c499eafea27906a028d0674944fbe63e3f03a..237f96dd3fa2b7e1c859471fee014d5a3d31f1f0 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,6 +15,7 @@
 #include <linux/kvm.h>
 #endif
 #include "system/kvm.h"
+#include "system/hostmem.h"
 #include "exec/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
-- 
2.48.1


