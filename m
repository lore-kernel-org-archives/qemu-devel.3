Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144F4E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIa7-0005qr-Lo; Wed, 11 Dec 2024 04:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIa5-0005qV-Qm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIa4-0007pJ-2C
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dxDc22YP4Eyy/4L7iCCPLQYp58xT/xQlzHGS8WYxZA=;
 b=KIv6v44PZDUylpzxM9VESU01IX8zUOTKW+8NKQoXnhCgmkwPr8qVLFlTyf29QTCfdqF8wk
 3AEhOCAa1k/NP2YdykpzGLOPNJR9rS1GlsRPjQVk51JCaJrFvL/TcjptALMKqiUK8uj+cs
 Dl3gSiozffzI4lIGdzX//ucT/F7PLGw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-XPFejslwOP6QP9t3NlC5GA-1; Wed,
 11 Dec 2024 04:00:24 -0500
X-MC-Unique: XPFejslwOP6QP9t3NlC5GA-1
X-Mimecast-MFC-AGG-ID: XPFejslwOP6QP9t3NlC5GA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC45D195608B; Wed, 11 Dec 2024 09:00:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E97D1956089; Wed, 11 Dec 2024 09:00:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 01/26] hw/i386: define _AS_LATEST() macros for machine types
Date: Wed, 11 Dec 2024 09:59:45 +0100
Message-ID: <20241211090014.619351-2-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Follow the other architecture targets by adding extra macros for
defining a versioned machine type as the latest. This reduces the
size of the changes when introducing new machine types at the start
of each release cycle.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240910163041.3764176-1-berrange@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20241126103005.3794748-2-cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/pc.h |  4 +++-
 hw/i386/pc_piix.c    | 11 +++++------
 hw/i386/pc_q35.c     | 11 ++++++-----
 3 files changed, 14 insertions(+), 12 deletions(-)

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
-- 
2.47.1


