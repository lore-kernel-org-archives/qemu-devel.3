Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE36606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q9Q17i16
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoPH-0004nw-BS; Tue, 24 Nov 2026 06:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVoPF-0004nY-Po
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVoPD-0004GO-Sm
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795518586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qC7LhwYFT0RIC5t7Qq18dOJrfylyMvlslE87OLT/g8Y=;
 b=Q9Q17i16TMmzL4NIyWOuyYfYY9lEIL0X7V0khnhTQS+2ourHhbNO/qALX8gDmysLh1s13j
 xZ7hxEr7x+foBJBuFwyuTC/5gPPL10mJ8CUiPoCxZqsHKBjAcy1brCYQODH2Ay4jGbyg0Q
 omrkT/03CpuSdTv+JKDZgDw/+0OKGSo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-3wVlUeGqPlq109ZdAiYFDA-1; Tue,
 24 Nov 2026 11:09:42 +0000
X-MC-Unique: 3wVlUeGqPlq109ZdAiYFDA-1
X-Mimecast-MFC-AGG-ID: 3wVlUeGqPlq109ZdAiYFDA_1795518581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52BA81933E36; Tue, 24 Nov 2026 11:09:41 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A17430001A2; Tue, 24 Nov 2026 11:09:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v3] hostmem: allow building without KVM support
Date: Tue, 24 Nov 2026 12:09:38 +0100
Message-ID: <20261124110938.1480880-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Tokarev <mjt@tls.msk.ru>

On architectures where KVM is not available and so including <linux/kvm.h>
does not work, buildnig backends/hostmem-memfd.c fails since 7ca43d7ad02f:

 In file included from backends/hostmem-memfd.c:23:
 linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
   16 | #include <asm/kvm.h>

Do not include <linux/kvm.h> because "system/kvm.h" already includes it for us
when KVM is enabled, and guard the actual code using memfd definitions with

Fixes: 7ca43d7ad02f ("hostmem: Support fully shared guest memfd to back a VM")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Link: https://lore.kernel.org/r/20261119111050.1203459-1-mjt@tls.msk.ru
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build              |  3 +--
 backends/hostmem-memfd.c | 10 +++++++++-
 tests/qtest/libqtest.c   |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 4d267e10b5f..303f57a7cb6 100644
--- a/meson.build
+++ b/meson.build
@@ -2422,11 +2422,10 @@ endif
 
 config_host_data.set('HOST_' + host_arch.to_upper(), 1)
 
-kvm_targets_c = '""'
 if get_option('kvm').allowed() and host_os == 'linux'
   kvm_targets_c = '"' + '" ,"'.join(kvm_targets) + '"'
+  config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
 endif
-config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
 
 if get_option('module_upgrades') and not enable_modules
   error('Cannot enable module-upgrades as modules are not enabled')
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 46489212a23..80ea5b9674d 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -20,9 +20,12 @@
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
-#include <linux/kvm.h>
 #include "qapi/qapi-type-infos-common.h"
 
+#ifdef CONFIG_KVM_TARGETS
+#include "linux-headers/linux/kvm.h"
+#endif
+
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
 
@@ -71,10 +74,15 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
             return false;
         }
 
+#ifdef CONFIG_KVM_TARGETS
         fd = kvm_create_guest_memfd(backend->size,
                                     GUEST_MEMFD_FLAG_MMAP |
                                     GUEST_MEMFD_FLAG_INIT_SHARED,
                                     errp);
+#else
+        error_setg(errp, "guest-memfd=on requires KVM which is not enabled");
+        fd = -ENOSYS;
+#endif
     } else {
         fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                                m->hugetlb, m->hugetlbsize, m->seal ?
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3b..b859ff728bf 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1165,6 +1165,7 @@ bool qtest_has_accel(const char *accel_name)
     g_autofree char *accel_type = NULL;
 
     if (g_str_equal(accel_name, "kvm")) {
+#ifdef CONFIG_KVM_TARGETS
         int i;
         const char *arch = qtest_get_arch();
         const char *targets[] = { CONFIG_KVM_TARGETS };
@@ -1176,6 +1177,7 @@ bool qtest_has_accel(const char *accel_name)
                 }
             }
         }
+#endif
         return false;
     }
 
-- 
2.56.1


