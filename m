Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57627C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxor-0004pA-2L; Wed, 03 Jul 2024 07:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxon-0004ng-M8
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxoc-0006V4-VS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5AE821BA1;
 Wed,  3 Jul 2024 11:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iXhKUDEJa0qxAI6PrHPWgNvkEnW2mk4LdNoS8cF0Kw=;
 b=CZNw5Zqox9brUDnzzoQ/ZP+gx5RI+D2qUQvhbvwzV+WcHw+BmRuSYQu612jR0zoDFXKTlk
 OKF/5qMIYwlipkbv/UjXZ5BHil/nEFvDvcQoKGjuswLiG6qHUFT4VDGZjgxB4cjfGtvB1V
 G4gU8+4jFPEfOjYf1m0Xc+QPoXUJFOA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iXhKUDEJa0qxAI6PrHPWgNvkEnW2mk4LdNoS8cF0Kw=;
 b=X3/WJqx8F/aDfBTZL5Q7qbkQ05TyroXIFVfrq25vqByn20QGaCioWdDxtq0ZgxPnMj1wPU
 GrO7kytDExm3MTs7XZ6U7D5yhD1zFUahSAXtMOtmjwE4BTTYBLvLlUxDWPfA0udzxLkLmK
 fS3vZOUY10GeHx44HeM4RtWaOB3ZeGg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27CB913974;
 Wed,  3 Jul 2024 11:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gKq+B6wwhWZ6cgAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Jul 2024 11:06:20 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v4 04/17] hw/i386: Add igvm-cfg object and processing for IGVM
 files
Date: Wed,  3 Jul 2024 12:05:42 +0100
Message-ID: <f8cd2ee02a96d48ce835a552b5a31c2cc63790fc.1720004383.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720004383.git.roy.hopkins@suse.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 R_RATELIMIT(0.00)[to_ip_from(RLm8d31jk6dhzwhww9bgqrb1jt)];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

An IGVM file contains configuration of guest state that should be
applied during configuration of the guest, before the guest is started.

This patch allows the user to add an igvm-cfg object to an X86 machine
configuration that allows an IGVM file to be configured that will be
applied to the guest before it is started.

If an IGVM configuration is provided then the IGVM file is processed at
the end of the board initialization, before the state transition to
PHASE_MACHINE_INITIALIZED.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 include/hw/i386/x86.h |  3 +++
 hw/i386/pc.c          | 12 ++++++++++++
 hw/i386/pc_piix.c     | 10 ++++++++++
 hw/i386/pc_q35.c      | 10 ++++++++++
 qemu-options.hx       | 25 +++++++++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..4abe3afaba 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -25,6 +25,7 @@
 #include "hw/intc/ioapic.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
+#include "sysemu/igvm-cfg.h"
 
 struct X86MachineClass {
     /*< private >*/
@@ -97,6 +98,8 @@ struct X86MachineState {
      * which means no limitation on the guest's bus locks.
      */
     uint64_t bus_lock_ratelimit;
+
+    IgvmCfgState *igvm;
 };
 
 #define X86_MACHINE_SMM              "smm"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 77415064c6..03d29e9e48 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1825,6 +1825,18 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
+
+#if defined(CONFIG_IGVM)
+    object_class_property_add_link(oc, "igvm-cfg",
+                                   TYPE_IGVM_CFG,
+                                   offsetof(X86MachineState, igvm),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "igvm-cfg",
+                                          "Set IGVM configuration");
+#endif
+
+
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9445b07b4f..d537dd50fb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -365,6 +365,16 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) == -1) {
+            return;
+        }
+    }
+#endif
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 71d3c6d122..d4d66be5a5 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -329,6 +329,16 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) == -1) {
+            return;
+        }
+    }
+#endif
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34ef0..fd36390416 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5719,6 +5719,31 @@ SRST
                  -machine ...,memory-encryption=sev0 \\
                  .....
 
+    ``-object igvm-cfg,file=file``
+        Create an IGVM configuration object that defines the initial state
+        of the guest using a file in that conforms to the Independent Guest
+        Virtual Machine (IGVM) file format.
+
+        The ``file`` parameter is used to specify the IGVM file to load.
+        When provided, the IGVM file is used to populate the initial
+        memory of the virtual machine and, depending on the platform, can
+        define the initial processor state, memory map and parameters.
+
+        The IGVM file is expected to contain the firmware for the virtual
+        machine, therefore an ``igvm-cfg`` object cannot be provided along
+        with other ways of specifying firmware, such as the ``-bios``
+        parameter on x86 machines.
+
+        e.g to launch a machine providing the firmware in an IGVM file
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \\
+                 ...... \\
+                 -object igvm-cfg,id=igvm0,file=bios.igvm \\
+                 -machine ...,igvm-cfg=igvm0 \\
+                 .....
+
     ``-object authz-simple,id=id,identity=string``
         Create an authorization object that will control access to
         network services.
-- 
2.43.0


