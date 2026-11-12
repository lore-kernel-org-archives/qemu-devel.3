Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0D606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YGkP4zWW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtv-0005vd-8a; Thu, 12 Nov 2026 08:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtp-0005uA-PV
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtn-0002Lq-2S
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgY5UT+Fe0KtLMph0z3ZhpKDf9pJ89rY4qFKKMqe/AA=;
 b=YGkP4zWWQhKBF2rMFAVQa4H9KiSUJI5QvrOSjKb1e9UVTOdghog6QRsItBxjr4LXENy1qs
 QAjGsmkitcqbV7zTMjsBZ4MwGFOkbOFn+aghiCFFwlsIMyKk2gYH84SIqcKW2/+pmstz9C
 jFQlHPhaKi7FogtnRURstaP/L4MEbhk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-itS2SE_UMoODZBjxj_rlUA-1; Thu,
 12 Nov 2026 08:31:26 -0500
X-MC-Unique: itS2SE_UMoODZBjxj_rlUA-1
X-Mimecast-MFC-AGG-ID: itS2SE_UMoODZBjxj_rlUA_1794490285
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACE2B1955F25; Thu, 12 Nov 2026 13:31:25 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F1DB1955DB9; Thu, 12 Nov 2026 13:31:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 15/48] hw/i386: convert machines to use AliasedClass interface
Date: Thu, 12 Nov 2026 13:30:21 +0000
Message-ID: <20261112133054.1977618-16-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stop setting 'alias' in the MachineClass and instead set
'aliases' in the AliasedClass.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc_piix.c | 20 ++++++++++++++++++--
 hw/i386/pc_q35.c  | 12 +++++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 88356bf0d77..8498dbeda81 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -66,6 +66,7 @@
 #include "hw/uefi/var-service-api.h"
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
+#include "qom/object_interfaces.h"
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
@@ -362,13 +363,23 @@ static void pc_i440fx_init(MachineState *machine)
     pc_init1(machine, TYPE_I440FX_PCI_DEVICE);
 }
 
+#define DEFINE_I440FX_MACHINE_ALIASES_LATEST(...) \
+    AliasedClass *alc = ALIASED_CLASS(oc); \
+    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
+    { \
+        MACHINE_TYPE_NAME("pc"), \
+        NULL, \
+    }; \
+    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
+
 #define DEFINE_I440FX_MACHINE(major, minor) \
     DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, \
                           {}, major, minor);
 
 #define DEFINE_I440FX_MACHINE_AS_LATEST(major, minor) \
     DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, { \
-            mc->is_default = true; mc->alias = "pc"; \
+            DEFINE_I440FX_MACHINE_ALIASES_LATEST(major, minor); \
+            mc->is_default = true; \
         }, major, minor);
 
 static void pc_i440fx_machine_options(MachineClass *m)
@@ -637,9 +648,14 @@ DEFINE_I440FX_MACHINE(4, 1);
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
+    AliasedClass *alc = ALIASED_CLASS(m);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("xenfv"), NULL,
+    };
+
     pc_i440fx_machine_4_2_options(m);
     m->desc = "Xen Fully-virtualized PC";
-    m->alias = "xenfv";
+    alc->aliases = aliases;
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9c6459b934d..37fbb58ef39 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -63,6 +63,7 @@
 #include "hw/uefi/var-service-api.h"
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
+#include "qom/object_interfaces.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -338,13 +339,22 @@ static void pc_q35_machine_set_wdat(Object *o, bool value, Error **errp)
     pcms->wdat_enabled = value;
 }
 
+#define DEFINE_Q35_MACHINE_ALIASES_LATEST(...) \
+    AliasedClass *alc = ALIASED_CLASS(oc); \
+    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
+    { \
+        MACHINE_TYPE_NAME("q35"), \
+        NULL, \
+    }; \
+    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
+
 #define DEFINE_Q35_MACHINE(major, minor) \
     DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, {}, \
                           major, minor);
 
 #define DEFINE_Q35_MACHINE_AS_LATEST(major, minor) \
     DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, { \
-            mc->alias = "q35"; \
+            DEFINE_Q35_MACHINE_ALIASES_LATEST(major, minor); \
         }, major, minor);
 
 #define DEFINE_Q35_MACHINE_BUGFIX(major, minor, micro) \
-- 
2.56.1


