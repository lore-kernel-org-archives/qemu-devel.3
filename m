Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA332EDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so3lb-000171-TN; Tue, 10 Sep 2024 12:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1so3lX-00015t-8z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1so3lV-0006A8-I8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725985851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tGWwuVYffN6mlDfiJlq0NqjWPLjOr3yEumw0xSygBNA=;
 b=dTZWnLVbJz8/c3r8W5slNxdLD8yp6qtoEgf3JpWUxBgQAjMqFkcTwlTnFQqF3Msr1jQoR9
 QSTZ6ENaPiIQ98+6TnRH8gxgOsTZREPZHhgu3t3XYY1rmzY3ArOI3vRk0jvIoA25gx6Fyr
 D8zJtPZTZchpm+zvcYawWaIXKPmWu0Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-Qg_LC66IPLiA1VwRmDG3Ww-1; Tue,
 10 Sep 2024 12:30:47 -0400
X-MC-Unique: Qg_LC66IPLiA1VwRmDG3Ww-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82EC7193584E; Tue, 10 Sep 2024 16:30:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.154])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8703E1956088; Tue, 10 Sep 2024 16:30:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/i386: define _AS_LATEST() macros for machine types
Date: Tue, 10 Sep 2024 17:30:41 +0100
Message-ID: <20240910163041.3764176-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Follow the other architecture targets by adding extra macros for
defining a versioned machine type as the latest. This reduces the
size of the changes when introducing new machine types at the start
of each release cycle.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

In v2:

 - Rebased on top of new 9.2 machine types

 hw/i386/pc_piix.c    | 11 +++++------
 hw/i386/pc_q35.c     | 11 ++++++-----
 include/hw/i386/pc.h |  4 +++-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2bf6865d40..4953676170 100644
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
@@ -477,17 +480,13 @@ static void pc_i440fx_machine_options(MachineClass *m)
 static void pc_i440fx_machine_9_2_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
-    m->alias = "pc";
-    m->is_default = true;
 }
 
-DEFINE_I440FX_MACHINE(9, 2);
+DEFINE_I440FX_MACHINE_AS_LATEST(9, 2);
 
 static void pc_i440fx_machine_9_1_options(MachineClass *m)
 {
     pc_i440fx_machine_9_2_options(m);
-    m->alias = NULL;
-    m->is_default = false;
     compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
     compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8319b6d45e..42bdedbaa4 100644
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
@@ -359,15 +362,13 @@ static void pc_q35_machine_options(MachineClass *m)
 static void pc_q35_machine_9_2_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
-    m->alias = "q35";
 }
 
-DEFINE_Q35_MACHINE(9, 2);
+DEFINE_Q35_MACHINE_AS_LATEST(9, 2);
 
 static void pc_q35_machine_9_1_options(MachineClass *m)
 {
     pc_q35_machine_9_2_options(m);
-    m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
     compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 14ee06287d..890427c56e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -320,7 +320,7 @@ extern const size_t pc_compat_2_3_len;
     } \
     type_init(pc_machine_init_##suffix)
 
-#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, ...) \
+#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, isdefault, malias, ...) \
     static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
         MachineState *machine) \
     { \
@@ -334,6 +334,8 @@ extern const size_t pc_compat_2_3_len;
         MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
         mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        mc->is_default = isdefault; \
+        mc->alias = malias; \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
     { \
-- 
2.43.0


