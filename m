Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EB8CE7A81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHBV-0006aK-HP; Thu, 05 Sep 2024 14:26:21 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smHBE-0006Z9-TD
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smHAa-00021z-GR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725560641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ra2wlNbNMXGvt6e7bhm/Vqie5lM+zWVUDps2Y8ULacI=;
 b=PVMSa3RK1c3yfjPYDfufpF9SNBjVQum5tycpSWfwHUjzF87Jx2ABWCtARgG3aGUfhXDSc1
 FHONLfBFotIhPHGnEHvyHItc6iFb1WTAhQ1EHiWVDyXAXCk3qmKUxwsN4NlVL+U08Bw8RU
 LUyWm8chVXYT0+R5Znf7bCDWo8Nc9cs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-Lc1rI1wfM6KNWCg5nVFbcQ-1; Thu,
 05 Sep 2024 14:21:11 -0400
X-MC-Unique: Lc1rI1wfM6KNWCg5nVFbcQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9C1819560AB; Thu,  5 Sep 2024 18:21:10 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.53])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE7EC1956086; Thu,  5 Sep 2024 18:21:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/i386: define _AS_LATEST() macros for machine types
Date: Thu,  5 Sep 2024 19:21:06 +0100
Message-ID: <20240905182106.3663665-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Follow the other architecture targets by adding extra macros for
defining a versioned machine type as the latest. This reduces the
size of the changes when introducing new machine types at the start
of each release cycle.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc_piix.c    | 11 +++++------
 hw/i386/pc_q35.c     | 11 ++++++-----
 include/hw/i386/pc.h |  4 +++-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 347afa4c37..f04592ad4d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -446,7 +446,10 @@ static void pc_i440fx_init(MachineState *machine)
 }
 
 #define DEFINE_I440FX_MACHINE(major, minor) \
-    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, major, minor);
+    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, false, NULL, major, minor);
+
+#define DEFINE_I440FX_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, true, "pc", major, minor);
 
 static void pc_i440fx_machine_options(MachineClass *m)
 {
@@ -477,19 +480,15 @@ static void pc_i440fx_machine_options(MachineClass *m)
 static void pc_i440fx_machine_9_1_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
-    m->alias = "pc";
-    m->is_default = true;
 }
 
-DEFINE_I440FX_MACHINE(9, 1);
+DEFINE_I440FX_MACHINE_AS_LATEST(9, 1);
 
 static void pc_i440fx_machine_9_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_i440fx_machine_9_1_options(m);
-    m->alias = NULL;
-    m->is_default = false;
     m->smbios_memory_device_size = 16 * GiB;
 
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f2d8edfa84..ec4f373b07 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -327,10 +327,13 @@ static void pc_q35_init(MachineState *machine)
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
-    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, major, minor);
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor);
+
+#define DEFINE_Q35_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, "q35", major, minor);
 
 #define DEFINE_Q35_MACHINE_BUGFIX(major, minor, micro) \
-    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, major, minor, micro);
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor, micro);
 
 static void pc_q35_machine_options(MachineClass *m)
 {
@@ -359,16 +362,14 @@ static void pc_q35_machine_options(MachineClass *m)
 static void pc_q35_machine_9_1_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
-    m->alias = "q35";
 }
 
-DEFINE_Q35_MACHINE(9, 1);
+DEFINE_Q35_MACHINE_AS_LATEST(9, 1);
 
 static void pc_q35_machine_9_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_9_1_options(m);
-    m->alias = NULL;
     m->smbios_memory_device_size = 16 * GiB;
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4e55d7ef6e..5775addb90 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -317,7 +317,7 @@ extern const size_t pc_compat_2_3_len;
     } \
     type_init(pc_machine_init_##suffix)
 
-#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, ...) \
+#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, isdefault, malias, ...) \
     static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
         MachineState *machine) \
     { \
@@ -331,6 +331,8 @@ extern const size_t pc_compat_2_3_len;
         MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
         mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        mc->is_default = isdefault; \
+        mc->alias = malias; \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
     { \
-- 
2.45.2


