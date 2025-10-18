Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E49ACCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA8b1-0008JC-Fb; Sat, 18 Oct 2025 11:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA8ay-0008HY-1d; Sat, 18 Oct 2025 11:11:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA8aw-0005hz-Iy; Sat, 18 Oct 2025 11:11:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 124475972F4;
 Sat, 18 Oct 2025 17:11:45 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id cX8MZRavzLAx; Sat, 18 Oct 2025 17:11:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 196585972DF; Sat, 18 Oct 2025 17:11:43 +0200 (CEST)
Message-ID: <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1760798392.git.balaton@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 11/13] hw/boards: Extend DEFINE_MACHINE macro to cover more
 use cases
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Sat, 18 Oct 2025 17:11:43 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
versions with less parameters based on that. This is inspired by how
the OBJECT_DEFINE macros do this in a similar way to allow using the
shortened definition in more complex cases too.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/hw/boards.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 665b620121..fd3d549ff5 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -762,7 +762,8 @@ struct MachineState {
         } \
     } while (0)
 
-#define DEFINE_MACHINE(namestr, machine_initfn) \
+#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
+                                machine_initfn, ABSTRACT, ...) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -770,8 +771,11 @@ struct MachineState {
     } \
     static const TypeInfo machine_initfn##_typeinfo = { \
         .name       = MACHINE_TYPE_NAME(namestr), \
-        .parent     = TYPE_MACHINE, \
+        .parent     = TYPE_##PARENT_NAME, \
         .class_init = machine_initfn##_class_init, \
+        .instance_size = sizeof(InstanceName), \
+        .abstract = ABSTRACT, \
+        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
     }; \
     static void machine_initfn##_register_types(void) \
     { \
@@ -779,6 +783,14 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+#define DEFINE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, { })
+
+#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, __VA_ARGS__)
+
 extern GlobalProperty hw_compat_10_1[];
 extern const size_t hw_compat_10_1_len;
 
-- 
2.41.3


