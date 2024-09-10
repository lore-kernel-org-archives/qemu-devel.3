Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F813EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so58k-0006Mc-2o; Tue, 10 Sep 2024 13:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58a-0005T6-3U
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58W-0006P7-TQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXfRYJdBWdC6uIFmmtGPcnCUGs5Sw5Ia9+QOX0qiRW8=;
 b=UiKUGK0NxfnBITFpln3JtM+2F8ukeKUPYTPeDtsTCZY8E3TkYGGc/UTCJsbBcaFn5vMMDT
 XniTNET0sC/umKFNtDlIl+72yN0ODg+fGPxYsXpSPBZsKeD3WXXqE20WvT28X+4Bexxlhf
 qO/8ikHyD79zkIdUBrWhLyVXAzHcbM0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-f2D7RY_xO7KUWR1Oz2jXiw-1; Tue,
 10 Sep 2024 13:58:39 -0400
X-MC-Unique: f2D7RY_xO7KUWR1Oz2jXiw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A20F51955F56; Tue, 10 Sep 2024 17:58:37 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EFD819560AD; Tue, 10 Sep 2024 17:58:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 04/14] s390x: rename s390-virtio-hcall* to s390-hypercall*
Date: Tue, 10 Sep 2024 19:57:59 +0200
Message-ID: <20240910175809.2135596-5-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's make it clearer that we are talking about general
QEMU/KVM-specific hypercalls.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/meson.build                               | 2 +-
 hw/s390x/{s390-virtio-hcall.c => s390-hypercall.c} | 2 +-
 hw/s390x/{s390-virtio-hcall.h => s390-hypercall.h} | 6 +++---
 target/s390x/kvm/kvm.c                             | 2 +-
 target/s390x/tcg/misc_helper.c                     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename hw/s390x/{s390-virtio-hcall.c => s390-hypercall.c} (97%)
 rename hw/s390x/{s390-virtio-hcall.h => s390-hypercall.h} (86%)

diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 482fd13420..71ec747f4c 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -12,7 +12,7 @@ s390x_ss.add(files(
   's390-pci-inst.c',
   's390-skeys.c',
   's390-stattrib.c',
-  's390-virtio-hcall.c',
+  's390-hypercall.c',
   'sclp.c',
   'sclpcpu.c',
   'sclpquiesce.c',
diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-hypercall.c
similarity index 97%
rename from hw/s390x/s390-virtio-hcall.c
rename to hw/s390x/s390-hypercall.c
index 4cddf69fbb..f09e8a1d81 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/boards.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-hypercall.h
similarity index 86%
rename from hw/s390x/s390-virtio-hcall.h
rename to hw/s390x/s390-hypercall.h
index e4f76aca82..b7ac29f444 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -9,8 +9,8 @@
  * directory.
  */
 
-#ifndef HW_S390_VIRTIO_HCALL_H
-#define HW_S390_VIRTIO_HCALL_H
+#ifndef HW_S390_HYPERCALL_H
+#define HW_S390_HYPERCALL_H
 
 #include "cpu.h"
 
@@ -21,4 +21,4 @@
 
 int handle_diag_500(CPUS390XState *env);
 
-#endif /* HW_S390_VIRTIO_HCALL_H */
+#endif /* HW_S390_HYPERCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index ac292b184a..062296206a 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -49,7 +49,7 @@
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "target/s390x/kvm/pv.h"
 
 #define kvm_vm_check_mem_attr(s, attr) \
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 58757585a2..718985f3a3 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -36,7 +36,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ebcdic.h"
-#include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
-- 
2.46.0


