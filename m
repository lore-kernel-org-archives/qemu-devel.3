Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDF7CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1fF-0006BM-Hc; Tue, 09 Sep 2025 12:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fC-0006Ap-Ez
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1f9-0007Wz-8Q
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfxFnH+lEOQAd+2OGBF/DRY1rm//a62ECPegzMFOTXo=;
 b=QvJG95EBu50vNUFFtKU2xYfYDZNPsMKFQMZLk9uCf//Bm7dPyN5LZSonV4LwviHBFIsSg6
 vlIxgUKeaisUmIze4OHiw7cv/uw8kJ8ZviDh9Vlc2KjlMC4DzR3VXofpTYpQekfY+/E7sU
 xNU8ZLHdpXA0kQ2nzRyqO9gRmABehKw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-FMbmylTdOmObc010OEyBjg-1; Tue,
 09 Sep 2025 12:57:39 -0400
X-MC-Unique: FMbmylTdOmObc010OEyBjg-1
X-Mimecast-MFC-AGG-ID: FMbmylTdOmObc010OEyBjg_1757437059
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15A97180047F; Tue,  9 Sep 2025 16:57:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A31581800446; Tue,  9 Sep 2025 16:57:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/15] machine: add 'require-secure' and 'prohibit-insecure'
 properties
Date: Tue,  9 Sep 2025 17:57:14 +0100
Message-ID: <20250909165726.3814465-4-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Both default to 'false' to maintain the historical behaviour.

If 'require-secure' is set to 'yes', then types which
explicitly declare themselves as secure are required.

If 'prohibit-insecure' is set to 'yes', then types which
explicitly declare themselves as insecure are forbidden.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/machine.c   | 60 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h |  5 ++++
 2 files changed, 65 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 38c949c4f2..b43c315bab 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -440,6 +440,34 @@ static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
     ms->dump_guest_core = value;
 }
 
+static bool machine_get_require_secure(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->require_secure;
+}
+
+static void machine_set_require_secure(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->require_secure = value;
+}
+
+static bool machine_get_prohibit_insecure(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->prohibit_insecure;
+}
+
+static void machine_set_prohibit_insecure(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->prohibit_insecure = value;
+}
+
 static bool machine_get_mem_merge(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1245,6 +1273,17 @@ static void machine_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "memory",
         "Memory size configuration");
+
+    object_class_property_add_bool(oc, "require-secure",
+        machine_get_require_secure, machine_set_require_secure);
+    object_class_property_set_description(oc, "require-secure",
+        "Define whether explicitly secure impls are required");
+
+    object_class_property_add_bool(oc, "prohibit-insecure",
+        machine_get_prohibit_insecure, machine_set_prohibit_insecure);
+    object_class_property_set_description(oc, "prohibit-insecure",
+        "Define whether explicitly insecure impls are prohibited");
+
 }
 
 static void machine_class_base_init(ObjectClass *oc, const void *data)
@@ -1269,6 +1308,8 @@ static void machine_initfn(Object *obj)
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
     ms->dump_guest_core = true;
+    ms->require_secure = false;
+    ms->prohibit_insecure = false;
     ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
     ms->enable_graphics = true;
     ms->kernel_cmdline = g_strdup("");
@@ -1362,6 +1403,25 @@ bool machine_dump_guest_core(MachineState *machine)
     return machine->dump_guest_core;
 }
 
+bool machine_check_security(MachineState *machine,
+                            ObjectClass *cls,
+                            Error **errp)
+{
+    if (machine->require_secure &&
+        !object_class_is_secure(cls)) {
+        error_setg(errp, "Type '%s' is not declared as secure",
+                   object_class_get_name(cls));
+        return false;
+    }
+    if (machine->prohibit_insecure &&
+        object_class_is_insecure(cls)) {
+        error_setg(errp, "Type '%s' is declared as insecure",
+                   object_class_get_name(cls));
+        return false;
+    }
+    return true;
+}
+
 bool machine_mem_merge(MachineState *machine)
 {
     return machine->mem_merge;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 665b620121..61f6942016 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -36,6 +36,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
 bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
+bool machine_check_security(MachineState *machine,
+                            ObjectClass *cls,
+                            Error **errp);
 bool machine_mem_merge(MachineState *machine);
 bool machine_require_guest_memfd(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
@@ -403,6 +406,8 @@ struct MachineState {
     int phandle_start;
     char *dt_compatible;
     bool dump_guest_core;
+    bool require_secure;
+    bool prohibit_insecure;
     bool mem_merge;
     bool usb;
     bool usb_disabled;
-- 
2.50.1


