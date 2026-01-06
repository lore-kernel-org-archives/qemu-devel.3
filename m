Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6803CEFCEB
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdBwZ-00081U-Ut; Tue, 06 Jan 2026 13:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vdBwU-00080t-Ve
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vdBwS-0002uN-Cp
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767724682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cs0d/Whb67p4rhqOVd8pNKSJF4qon8ztCFF10BlCZRI=;
 b=feeXyMTUB8L0QONGKTCGA7MMKk4Nu3FI/3ZZarTV1EJ8RADuxPgKbS9Vylr4Or5qd4YxFH
 IxBR+fD6uyNf3SGjhYw/puDZfoe+WOPWH8FJgnYFEoUR6Qu1+81/YdKEtlYybktf4u6sB7
 66asBSSopqytTcuU8ZyWMs0GVt07w9s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-5nMqeKUNO7yu3Gh36mD6JQ-1; Tue,
 06 Jan 2026 13:36:27 -0500
X-MC-Unique: 5nMqeKUNO7yu3Gh36mD6JQ-1
X-Mimecast-MFC-AGG-ID: 5nMqeKUNO7yu3Gh36mD6JQ_1767724586
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20A24195609D; Tue,  6 Jan 2026 18:36:26 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCEAA30001B9; Tue,  6 Jan 2026 18:36:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org (open list:X86 KVM CPUs)
Subject: [PATCH] Add query-tdx-capabilities
Date: Tue,  6 Jan 2026 22:36:20 +0400
Message-ID: <20260106183620.2144309-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Return an empty TdxCapability struct, for extensibility and matching
query-sev-capabilities return type.

Fixes: https://issues.redhat.com/browse/RHEL-129674
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/misc-i386.json        | 30 ++++++++++++++++++++++++++++++
 target/i386/kvm/kvm_i386.h |  1 +
 target/i386/kvm/kvm.c      |  5 +++++
 target/i386/kvm/tdx-stub.c |  8 ++++++++
 target/i386/kvm/tdx.c      | 21 +++++++++++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 05a94d6c416..f10e4338b48 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -225,6 +225,36 @@
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
 
+##
+# @TdxCapability:
+#
+# The struct describes capability for Intel Trust Domain Extensions
+# (TDX) feature.
+#
+# Since: 11.0
+##
+{ 'struct': 'TdxCapability',
+  'data': { } }
+
+##
+# @query-tdx-capabilities:
+#
+# Get TDX capabilities.
+#
+# This is only supported on Intel X86 platforms with KVM enabled.
+#
+# Errors:
+#     - If TDX is not available on the platform, GenericError
+#
+# Since: 11.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-tdx-capabilities" }
+#     <- { "return": {} }
+##
+{ 'command': 'query-tdx-capabilities', 'returns': 'TdxCapability' }
+
 ##
 # @sev-inject-launch-secret:
 #
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 2b653442f4d..71dd45be47a 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -61,6 +61,7 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_has_x2apic_api(void);
 bool kvm_has_waitpkg(void);
+bool kvm_has_tdx(void);
 
 uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7b9b740a8e5..8ce25d7e785 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6582,6 +6582,11 @@ bool kvm_has_waitpkg(void)
     return has_msr_umwait;
 }
 
+bool kvm_has_tdx(void)
+{
+    return kvm_is_vm_type_supported(KVM_X86_TDX_VM);
+}
+
 #define ARCH_REQ_XCOMP_GUEST_PERM       0x1025
 
 void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask)
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 1f0e108a69e..c4e7f2c58c8 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
 
 #include "tdx.h"
 
@@ -30,3 +32,9 @@ void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
 {
 }
+
+TdxCapability *qmp_query_tdx_capabilities(Error **errp)
+{
+    error_setg(errp, "TDX is not available in this QEMU");
+    return NULL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 01619857685..b5ee3b1ab92 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -14,6 +14,7 @@
 #include "qemu/base64.h"
 #include "qemu/mmap-alloc.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
@@ -1537,6 +1538,26 @@ static void tdx_guest_finalize(Object *obj)
 {
 }
 
+static TdxCapability *tdx_get_capabilities(Error **errp)
+{
+    if (!kvm_enabled()) {
+        error_setg(errp, "TDX is not available without KVM");
+        return NULL;
+    }
+
+    if (!kvm_has_tdx()) {
+        error_setg(errp, "TDX is not supported by this host");
+        return NULL;
+    }
+
+    return g_new0(TdxCapability, 1);
+}
+
+TdxCapability *qmp_query_tdx_capabilities(Error **errp)
+{
+    return tdx_get_capabilities(errp);
+}
+
 static void tdx_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
-- 
2.52.0


