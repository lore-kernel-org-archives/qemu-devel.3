Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECD1CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v292y-0006a5-MD; Fri, 26 Sep 2025 10:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292t-0006Tb-Ng
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292e-0004ln-7h
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVrAynmvaUFzruaGCEo1jmveHQiY6eBskywHu4uSLF4=;
 b=Yv1pQsuAjXWsbSskNMZNWGu4AS+0AYpWihc9cs5cj+NSNv/W4bcWVQoH2eZ4XLOFn6z3ru
 1I5HRwXC3CTvYLD5zCJnWzflueQ+vFYdV/An9Pg1k2vW/8QTDAyw9pxCqmfPInKQSlxrZm
 sVhzuqrnJfcAqo6hneOVktdIghukAuY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-NQZhS5cDPkuLPkhdrZ_sFQ-1; Fri,
 26 Sep 2025 10:03:10 -0400
X-MC-Unique: NQZhS5cDPkuLPkhdrZ_sFQ-1
X-Mimecast-MFC-AGG-ID: NQZhS5cDPkuLPkhdrZ_sFQ_1758895389
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9D1A180AB1D; Fri, 26 Sep 2025 14:03:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0AF8F1956095; Fri, 26 Sep 2025 14:02:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 13/32] machine: add helpers for declaring secure/insecure
 machine types
Date: Fri, 26 Sep 2025 15:01:24 +0100
Message-ID: <20250926140144.1998694-14-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The current DEFINE_MACHINE macro will declare machine type without any
explicit statement about the security status. As such the machine type
will be treated as implicitly insecure at runtime.

Introduce new DEFINE_SECURE_MACHINE and DEFINE_INSECURE_MACHINE macros
that allow code to make an explicit statement about security status
of the machine. All machine declarations should transition to the new
macros allowing the implicit macro to eventually be removed.

The same is done for the specialized i386 PC related macros.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h  | 12 +++++++++++-
 include/hw/i386/pc.h | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 665b620121..8105c54a90 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -762,7 +762,7 @@ struct MachineState {
         } \
     } while (0)
 
-#define DEFINE_MACHINE(namestr, machine_initfn) \
+#define DEFINE_MACHINE_IMPL(namestr, machine_initfn, issecure) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -772,6 +772,7 @@ struct MachineState {
         .name       = MACHINE_TYPE_NAME(namestr), \
         .parent     = TYPE_MACHINE, \
         .class_init = machine_initfn##_class_init, \
+        .secure     = issecure, \
     }; \
     static void machine_initfn##_register_types(void) \
     { \
@@ -779,6 +780,15 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+/* Implicitly insecure, prefer explicitly declaring security status */
+#define DEFINE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_IMPL(namestr, machine_initfn, false)
+
+#define DEFINE_SECURE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_IMPL(namestr, machine_initfn, true)
+#define DEFINE_INSECURE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_IMPL(namestr, machine_initfn, false)
+
 extern GlobalProperty hw_compat_10_1[];
 extern const size_t hw_compat_10_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e83157ab35..1ccb6ed9fc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -301,7 +301,7 @@ extern const size_t pc_compat_2_7_len;
 extern GlobalProperty pc_compat_2_6[];
 extern const size_t pc_compat_2_6_len;
 
-#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+#define DEFINE_PC_MACHINE_IMPL(suffix, namestr, initfn, optsfn, issecure) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
     { \
@@ -313,6 +313,7 @@ extern const size_t pc_compat_2_6_len;
         .name       = namestr TYPE_MACHINE_SUFFIX, \
         .parent     = TYPE_PC_MACHINE, \
         .class_init = pc_machine_##suffix##_class_init, \
+        .secure     = issecure, \
     }; \
     static void pc_machine_init_##suffix(void) \
     { \
@@ -320,6 +321,16 @@ extern const size_t pc_compat_2_6_len;
     } \
     type_init(pc_machine_init_##suffix)
 
+/* Implicitly insecure, prefer explicitly declaring security status */
+#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+    DEFINE_PC_MACHINE_IMPL(suffix, namestr, initfn, optsfn, false)
+
+#define DEFINE_SECURE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+    DEFINE_PC_MACHINE_IMPL(suffix, namestr, initfn, optsfn, true)
+#define DEFINE_INSECURE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+    DEFINE_PC_MACHINE_IMPL(suffix, namestr, initfn, optsfn, false)
+
+
 #define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, isdefault, malias, ...) \
     static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
         MachineState *machine) \
-- 
2.50.1


