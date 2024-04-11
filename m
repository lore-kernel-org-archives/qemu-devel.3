Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02AFCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rur3J-0006mp-Ot; Thu, 11 Apr 2024 05:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur3I-0006mN-9x
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur3G-00038F-KU
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712828941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viXpoVwiwK7UNIPqMm+1exr+Ny85uo8eo7xr3X36SbU=;
 b=ZpVS+cwyMZ7gkZi2Ykpq/lYGNH+ctdzBYabErWBjXZGXtJ2ofhJHvkxkF/vEInz1VzyJEP
 tq/rbuv401jMGQhvXA5Mcfdhtw80xHaVTiD3qskx2m/kEeqVJX3K5RnU6AR28o2gahATw6
 ywiCUv5eqzO09JBVtJDrPUR7c2Fe/Lg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-xyrjQADPNXW8tkRnC0ka5g-1; Thu, 11 Apr 2024 05:48:58 -0400
X-MC-Unique: xyrjQADPNXW8tkRnC0ka5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BCCC8007AD;
 Thu, 11 Apr 2024 09:48:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E1C0C27EAF;
 Thu, 11 Apr 2024 09:48:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9302F1800D5B; Thu, 11 Apr 2024 11:48:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/5] x86/loader: add -shim option
Date: Thu, 11 Apr 2024 11:48:29 +0200
Message-ID: <20240411094830.1337658-6-kraxel@redhat.com>
In-Reply-To: <20240411094830.1337658-1-kraxel@redhat.com>
References: <20240411094830.1337658-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

Add new -shim command line option, wire up for the x86 loader.
When specified load shim into the new "etc/boot/shim" fw_cfg file.

Needs OVMF changes too to be actually useful.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/core/machine.c   | 20 ++++++++++++++++++++
 hw/i386/x86.c       | 16 ++++++++++++++++
 system/vl.c         |  9 +++++++++
 qemu-options.hx     |  7 +++++++
 5 files changed, 53 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8b8f6d5c00d3..37da417cb029 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -399,6 +399,7 @@ struct MachineState {
     BootConfiguration boot_config;
     char *kernel_filename;
     char *kernel_cmdline;
+    char *shim_filename;
     char *initrd_filename;
     const char *cpu_type;
     AccelState *accelerator;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 37ede0e7d4fd..f27f6ae8e199 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -313,6 +313,21 @@ static void machine_set_kernel(Object *obj, const char *value, Error **errp)
     ms->kernel_filename = g_strdup(value);
 }
 
+static char *machine_get_shim(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->shim_filename);
+}
+
+static void machine_set_shim(Object *obj, const char *value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->shim_filename);
+    ms->shim_filename = g_strdup(value);
+}
+
 static char *machine_get_initrd(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -988,6 +1003,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "kernel",
         "Linux kernel image file");
 
+    object_class_property_add_str(oc, "shim",
+        machine_get_shim, machine_set_shim);
+    object_class_property_set_description(oc, "shim",
+        "shim.efi file");
+
     object_class_property_add_str(oc, "initrd",
         machine_get_initrd, machine_set_initrd);
     object_class_property_set_description(oc, "initrd",
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6724e408e576..3e95f196fb40 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1128,6 +1128,22 @@ void x86_load_linux(X86MachineState *x86ms,
     /* kernel without setup header patches */
     fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
 
+    if (machine->shim_filename) {
+        GMappedFile *mapped_file;
+        GError *gerr = NULL;
+
+        mapped_file = g_mapped_file_new(machine->shim_filename, false, &gerr);
+        if (!mapped_file) {
+            fprintf(stderr, "qemu: error reading shim %s: %s\n",
+                    machine->shim_filename, gerr->message);
+            exit(1);
+        }
+
+        fw_cfg_add_file(fw_cfg, "etc/boot/shim",
+                        g_mapped_file_get_contents(mapped_file),
+                        g_mapped_file_get_length(mapped_file));
+    }
+
     if (sev_enabled()) {
         sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
     }
diff --git a/system/vl.c b/system/vl.c
index 0c6201c5bdc5..4df42ba8c7a6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2407,6 +2407,7 @@ static void configure_accelerators(const char *progname)
 static void qemu_validate_options(const QDict *machine_opts)
 {
     const char *kernel_filename = qdict_get_try_str(machine_opts, "kernel");
+    const char *shim_filename = qdict_get_try_str(machine_opts, "shim");
     const char *initrd_filename = qdict_get_try_str(machine_opts, "initrd");
     const char *kernel_cmdline = qdict_get_try_str(machine_opts, "append");
 
@@ -2416,6 +2417,11 @@ static void qemu_validate_options(const QDict *machine_opts)
             exit(1);
         }
 
+        if (shim_filename != NULL) {
+            error_report("-shim only allowed with -kernel option");
+            exit(1);
+        }
+
         if (initrd_filename != NULL) {
             error_report("-initrd only allowed with -kernel option");
             exit(1);
@@ -2908,6 +2914,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_kernel:
                 qdict_put_str(machine_opts_dict, "kernel", optarg);
                 break;
+            case QEMU_OPTION_shim:
+                qdict_put_str(machine_opts_dict, "shim", optarg);
+                break;
             case QEMU_OPTION_initrd:
                 qdict_put_str(machine_opts_dict, "initrd", optarg);
                 break;
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ce85d45598d..b5151857afe5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4002,6 +4002,13 @@ SRST
     or in multiboot format.
 ERST
 
+DEF("shim", HAS_ARG, QEMU_OPTION_shim, \
+    "-shim shim.efi use 'shim.efi' to boot the kernel\n", QEMU_ARCH_ALL)
+SRST
+``-shim shim.efi``
+    Use 'shim.efi' to boot the kernel
+ERST
+
 DEF("append", HAS_ARG, QEMU_OPTION_append, \
     "-append cmdline use 'cmdline' as kernel command line\n", QEMU_ARCH_ALL)
 SRST
-- 
2.44.0


