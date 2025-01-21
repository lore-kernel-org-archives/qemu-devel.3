Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1F9C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBw9-0006i0-S8; Tue, 21 Jan 2025 05:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvx-0006ef-Sh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvs-00056Z-Qt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737456991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7y2fdrZMckfoQ3ZY0BldNlgQWpxrizZusmKLoxlslvw=;
 b=gEBeYD6CFrACyAE5uHDJm3coov88zYmTNu9lZGVBUprawsIK46RhjWn40YexKqfnnyuW3I
 PykRZ3OyMQqbC6/M5YLhULSLKH+LbI4F5qzyEAQzpJiNNwHqzaIe1rVO8CoAIrlG+6HcGK
 jM0TvkroMSXCmPvlKGCDuHfJwpkIqsk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Wjiy3NBtOpmS_7vDx9CzAQ-1; Tue,
 21 Jan 2025 05:56:29 -0500
X-MC-Unique: Wjiy3NBtOpmS_7vDx9CzAQ-1
X-Mimecast-MFC-AGG-ID: Wjiy3NBtOpmS_7vDx9CzAQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4029419560B7
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:56:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D67B19560B1; Tue, 21 Jan 2025 10:56:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 4/9] hw/s390x: Fix crash that occurs when inspecting older
 versioned machines types
Date: Tue, 21 Jan 2025 11:56:06 +0100
Message-ID: <20250121105613.1286672-5-thuth@redhat.com>
In-Reply-To: <20250121105613.1286672-1-thuth@redhat.com>
References: <20250121105613.1286672-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

qemu-system-s390x currently crashes when trying to inspect older
machines types, for example:

 $ echo '{ "execute": "qmp_capabilities" }
         { "execute": "qom-list-properties","arguments":
           { "typename": "s390-ccw-virtio-3.0-machine"}}' \
   | ./qemu-system-s390x -qmp stdio -no-shutdown
 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
  "package": "v9.2.0-1071-g81e97df3e7"}, "capabilities": ["oob"]}}
 {"return": {}}
 **
 Bail out! ERROR:../target/s390x/cpu_models.c:832:s390_set_qemu_cpu_model:
  assertion failed: (QTAILQ_EMPTY_RCU(&cpus_queue))
 Aborted (core dumped)

The problem is that the versioned s390-ccw-virtio machine types
use instance_init() to set global state that should be initialized
before the CPUs get instantiated. But instance_init() is not called
only for the machine that is finally used, it is also called for
temporary instances of objects that are e.g. just created for
introspection. That means that those instance_init() functions can
also be called while a machine (and its CPUs) is already created,
which triggers the assertion in cpu_models.c.

So we must not use instance_init() for setting global state, but
use the machine->init() function instead, which is really only called
once when the machine comes to life.

Fixes: 3b00f702c2 ("s390x/cpumodel: add zpci, aen and ais facilities")
Message-ID: <20250120085059.239345-1-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 38aeba14ee..3af613d4e9 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -782,7 +782,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
 
     s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
-    mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
@@ -852,6 +851,12 @@ static const TypeInfo ccw_machine_info = {
 };
 
 #define DEFINE_CCW_MACHINE_IMPL(latest, ...)                                  \
+    static void MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__)(MachineState *mach) \
+    {                                                                         \
+        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(mach));         \
+        MACHINE_VER_SYM(instance_options, ccw, __VA_ARGS__)(mach);            \
+        ccw_init(mach);                                                       \
+    }                                                                         \
     static void MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__)(                \
         ObjectClass *oc,                                                      \
         void *data)                                                           \
@@ -859,24 +864,18 @@ static const TypeInfo ccw_machine_info = {
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
         mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
+        mc->init = MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__);              \
         MACHINE_VER_DEPRECATION(__VA_ARGS__);                                 \
         if (latest) {                                                         \
             mc->alias = "s390-ccw-virtio";                                    \
             mc->is_default = true;                                            \
         }                                                                     \
     }                                                                         \
-    static void MACHINE_VER_SYM(instance_init, ccw, __VA_ARGS__)(Object *obj) \
-    {                                                                         \
-        MachineState *machine = MACHINE(obj);                                 \
-        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(machine));      \
-        MACHINE_VER_SYM(instance_options, ccw, __VA_ARGS__)(machine);         \
-    }                                                                         \
     static const TypeInfo MACHINE_VER_SYM(info, ccw, __VA_ARGS__) =           \
     {                                                                         \
         .name = MACHINE_VER_TYPE_NAME("s390-ccw-virtio", __VA_ARGS__),        \
         .parent = TYPE_S390_CCW_MACHINE,                                      \
         .class_init = MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__),          \
-        .instance_init = MACHINE_VER_SYM(instance_init, ccw, __VA_ARGS__),    \
     };                                                                        \
     static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
     {                                                                         \
-- 
2.48.1


