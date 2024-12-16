Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8251E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 10:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN8h6-0004N7-Fx; Mon, 16 Dec 2024 05:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gy-0004HF-JB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gx-0005Pr-0o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734346270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYv39TQS5f7D5KqQeGcA0dHKLC9ifleIi7aQvEXd6Ww=;
 b=KXaXldwx/x2yCtOigJQMf/3oaeA5brfFHGJ9W7HDBI5MdzhTHyogEamtvC7E7aRZ4fhQTx
 l3AuHqj5+Mch9b1yShG2PCQwOMWIFltG/EWHFlc/7JhMEcwp8GRf+EPmuJH7mKY+fQpu13
 sC9TT4ho6xQLdM5wU/+WQ8Pf1Ou0S+s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-d-soHxxNOpGurguOc9z47g-1; Mon,
 16 Dec 2024 05:51:07 -0500
X-MC-Unique: d-soHxxNOpGurguOc9z47g-1
X-Mimecast-MFC-AGG-ID: d-soHxxNOpGurguOc9z47g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7639E1956095; Mon, 16 Dec 2024 10:51:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 897CD30044C1; Mon, 16 Dec 2024 10:51:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F371718003BA; Mon, 16 Dec 2024 11:50:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/7] x86/loader: add -shim option
Date: Mon, 16 Dec 2024 11:50:50 +0100
Message-ID: <20241216105053.246204-5-kraxel@redhat.com>
In-Reply-To: <20241216105053.246204-1-kraxel@redhat.com>
References: <20241216105053.246204-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
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

Add new -shim command line option, wire up for the x86 loader.
When specified load shim into the new "etc/boot/shim" fw_cfg file.

Needs OVMF changes too to be actually useful.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240905141211.1253307-6-kraxel@redhat.com>
---
 include/hw/boards.h  |  1 +
 hw/core/machine.c    | 20 ++++++++++++++++++++
 hw/i386/x86-common.c | 16 ++++++++++++++++
 system/vl.c          |  9 +++++++++
 qemu-options.hx      |  7 +++++++
 5 files changed, 53 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7456889c37eb..5723ee76bdea 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -431,6 +431,7 @@ struct MachineState {
     BootConfiguration boot_config;
     char *kernel_filename;
     char *kernel_cmdline;
+    char *shim_filename;
     char *initrd_filename;
     const char *cpu_type;
     AccelState *accelerator;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e6900b43efa2..d970f753e370 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -305,6 +305,21 @@ static void machine_set_kernel(Object *obj, const char *value, Error **errp)
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
@@ -1082,6 +1097,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
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
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 1cef3045ad83..3f7818269234 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -965,6 +965,22 @@ void x86_load_linux(X86MachineState *x86ms,
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
index 4a370da624a7..09202b57e73b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2427,6 +2427,7 @@ static void configure_accelerators(const char *progname)
 static void qemu_validate_options(const QDict *machine_opts)
 {
     const char *kernel_filename = qdict_get_try_str(machine_opts, "kernel");
+    const char *shim_filename = qdict_get_try_str(machine_opts, "shim");
     const char *initrd_filename = qdict_get_try_str(machine_opts, "initrd");
     const char *kernel_cmdline = qdict_get_try_str(machine_opts, "append");
 
@@ -2436,6 +2437,11 @@ static void qemu_validate_options(const QDict *machine_opts)
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
@@ -2912,6 +2918,9 @@ void qemu_init(int argc, char **argv)
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
index dacc9790a4b8..cc694d3b890c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4145,6 +4145,13 @@ SRST
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
2.47.1


