Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C2DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfgc-0005r9-Jq; Thu, 13 Mar 2025 06:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1tsfgZ-0005jI-PU
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1tsfgX-0002Pp-1y
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tS5d0O3NsoPh+I/T8KDlewKJRVwL+zofgShLngZjiiM=;
 b=HjXaJuJFFwKZS1y3shAVIXcRqeYxkpqSpHryBAt2QkFW7vRh1GNh4gktJv/tGIqn/eIpgq
 f5uIRGD8Bf+60VI3ySJRE2M/kcHHyAUbjZU7GC2My13M/6xP7ibt5y6gFL4G88Nt09ytFA
 hRXg8jlu/KhhzfvAp5KKPYxodpswBY0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-w6Nl9sn4Pt-uXxCfDrE6Vg-1; Thu,
 13 Mar 2025 06:19:19 -0400
X-MC-Unique: w6Nl9sn4Pt-uXxCfDrE6Vg-1
X-Mimecast-MFC-AGG-ID: w6Nl9sn4Pt-uXxCfDrE6Vg_1741861158
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0B38180034D
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:19:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B64D300376F; Thu, 13 Mar 2025 10:19:15 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH 2/2] target/i386/kvm: Change error_report() to tracepoint in
 vmsr_read_thread_stat()
Date: Thu, 13 Mar 2025 11:19:02 +0100
Message-ID: <20250313101902.835556-3-aharivel@redhat.com>
In-Reply-To: <20250313101902.835556-1-aharivel@redhat.com>
References: <20250313101902.835556-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Threads in QEMU are frequently created and destroyed, leading to
non-critical errors. Replace `error_report()` with a tracepoint to
prevent flooding the serial terminal with non-essential error messages.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 target/i386/kvm/trace-events  | 3 +++
 target/i386/kvm/vmsr_energy.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/trace-events b/target/i386/kvm/trace-events
index 74a6234ff7f5..527750e3b23d 100644
--- a/target/i386/kvm/trace-events
+++ b/target/i386/kvm/trace-events
@@ -13,3 +13,6 @@ kvm_xen_soft_reset(void) ""
 kvm_xen_set_shared_info(uint64_t gfn) "shared info at gfn 0x%" PRIx64
 kvm_xen_set_vcpu_attr(int cpu, int type, uint64_t gpa) "vcpu attr cpu %d type %d gpa 0x%" PRIx64
 kvm_xen_set_vcpu_callback(int cpu, int vector) "callback vcpu %d vector %d"
+
+# vmsr_energy.c
+vmsr_read_thread_stat(const char *path) "Error opening path %s"
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index f3861d0607bb..f99aa9cfeb94 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -19,6 +19,7 @@
 #include "hw/boards.h"
 #include "cpu.h"
 #include "host-cpu.h"
+#include "trace.h"
 
 char *vmsr_compute_default_paths(void)
 {
@@ -280,7 +281,7 @@ void vmsr_read_thread_stat(pid_t pid,
 
     FILE *file = fopen(path, "r");
     if (file == NULL) {
-        error_report("Error opening %s", path_name);
+        trace_vmsr_read_thread_stat(path_name);
         return;
     }
 
-- 
2.48.1


