Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12BBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnp-0008KH-QR; Tue, 23 Apr 2024 11:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnj-0007f8-EG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnh-0000QP-IG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqJQm4y6zppoxY68MoDm2jDZIZGmDU1FCx6RM46Mbno=;
 b=i20ZYrEg7aJOSp8GD3BLa7caJw6jDj7Q0D2wHKfoBWqo00bY8X2beN4MO2gU6Xly45/2I+
 lCr6+sW42iO+j1dH2eYyQK1BHY/lnly+DYMC4vXe07WOrP6OBxhNKXnjvxiaZUbC9dU1S1
 iUUt5/LexdJIFWV0K1Ts5xkfUIcixjI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-K17nFj_JNjClNfzzLqDvGQ-1; Tue,
 23 Apr 2024 11:10:35 -0400
X-MC-Unique: K17nFj_JNjClNfzzLqDvGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9298F29AC013
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:35 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD72203397E
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/63] target/i386: introduce x86-confidential-guest
Date: Tue, 23 Apr 2024 17:09:30 +0200
Message-ID: <20240423150951.41600-43-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a common superclass for x86 confidential guest implementations.
It will extend ConfidentialGuestSupportClass with a method that provides
the VM type to be passed to KVM_CREATE_VM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 40 ++++++++++++++++++++++++++++++++
 target/i386/confidential-guest.c | 33 ++++++++++++++++++++++++++
 target/i386/sev.c                |  6 ++---
 target/i386/meson.build          |  2 +-
 4 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 target/i386/confidential-guest.h
 create mode 100644 target/i386/confidential-guest.c

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
new file mode 100644
index 00000000000..ca12d5a8fba
--- /dev/null
+++ b/target/i386/confidential-guest.h
@@ -0,0 +1,40 @@
+/*
+ * x86-specific confidential guest methods.
+ *
+ * Copyright (c) 2024 Red Hat Inc.
+ *
+ * Authors:
+ *  Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef TARGET_I386_CG_H
+#define TARGET_I386_CG_H
+
+#include "qom/object.h"
+
+#include "exec/confidential-guest-support.h"
+
+#define TYPE_X86_CONFIDENTIAL_GUEST "x86-confidential-guest"
+
+OBJECT_DECLARE_TYPE(X86ConfidentialGuest,
+                    X86ConfidentialGuestClass,
+                    X86_CONFIDENTIAL_GUEST)
+
+struct X86ConfidentialGuest {
+    /* <private> */
+    ConfidentialGuestSupport parent_obj;
+};
+
+/**
+ * X86ConfidentialGuestClass:
+ *
+ * Class to be implemented by confidential-guest-support concrete objects
+ * for the x86 target.
+ */
+struct X86ConfidentialGuestClass {
+    /* <private> */
+    ConfidentialGuestSupportClass parent;
+};
+#endif
diff --git a/target/i386/confidential-guest.c b/target/i386/confidential-guest.c
new file mode 100644
index 00000000000..b3727845adc
--- /dev/null
+++ b/target/i386/confidential-guest.c
@@ -0,0 +1,33 @@
+/*
+ * QEMU Confidential Guest support
+ *
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Authors:
+ *  Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "confidential-guest.h"
+
+OBJECT_DEFINE_ABSTRACT_TYPE(X86ConfidentialGuest,
+                            x86_confidential_guest,
+                            X86_CONFIDENTIAL_GUEST,
+                            CONFIDENTIAL_GUEST_SUPPORT)
+
+static void x86_confidential_guest_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void x86_confidential_guest_init(Object *obj)
+{
+}
+
+static void x86_confidential_guest_finalize(Object *obj)
+{
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index c49a8fd55eb..ebe36d4c10c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -35,7 +35,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "exec/confidential-guest-support.h"
+#include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
 
@@ -54,7 +54,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
  *         -machine ...,memory-encryption=sev0
  */
 struct SevGuestState {
-    ConfidentialGuestSupport parent_obj;
+    X86ConfidentialGuest parent_obj;
 
     /* configuration parameters */
     char *sev_device;
@@ -1372,7 +1372,7 @@ sev_guest_instance_init(Object *obj)
 
 /* sev guest info */
 static const TypeInfo sev_guest_info = {
-    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
+    .parent = TYPE_X86_CONFIDENTIAL_GUEST,
     .name = TYPE_SEV_GUEST,
     .instance_size = sizeof(SevGuestState),
     .instance_finalize = sev_guest_finalize,
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 7c74bfa8591..8abce725f86 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -6,7 +6,7 @@ i386_ss.add(files(
   'xsave_helper.c',
   'cpu-dump.c',
 ))
-i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
 
 # x86 cpu type
 i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
-- 
2.44.0



