Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF87CCFA19
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmtc-0001Zy-Pu; Thu, 26 Sep 2024 07:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmt7-0000pg-RC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:26 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmt5-0005lJ-7s
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E996021AFB;
 Thu, 26 Sep 2024 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjnDKcrgxo/qpq9oq3UoN2hMARfmFi8Ku0QMqQO7ht0=;
 b=m1XaZfrpdKxesRDmqT+dVLeq3t+IQp3LQ5+kbkrDBb4Q4vAWrlTvCEqhV+MQRw+8b79PM9
 nQo3Q/Y33LiXNDuFiXqbnRzarbICU5D7sljoeC+t6XpbP1QgpGngAezBzFhUNiRoxCik3P
 i0qD9nHdyt0GztbiJ/7jNXukbgosDDY=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=IPjpLS5s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjnDKcrgxo/qpq9oq3UoN2hMARfmFi8Ku0QMqQO7ht0=;
 b=IPjpLS5s0lb8M3WGy3rKt3DKP1X+rbc2pmbMrby8E1VoF+3Wmvcq5/n65kb/NTiJT+Vua7
 JHm1yFXeGrE0xhl9fd7ws50GOs+oPEuEYXCKOOJOR77vQ/SOxeujgDdC93PB1li/L7tx1z
 kAYLXMBJoHK0XwHpMdhnCjAjqMcttcM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36F8D13793;
 Thu, 26 Sep 2024 11:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qOJkC51I9WbcRAAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Thu, 26 Sep 2024 11:42:21 +0000
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
Subject: [PATCH v6 04/16] hw/i386: Add igvm-cfg object and processing for IGVM
 files
Date: Thu, 26 Sep 2024 12:41:53 +0100
Message-ID: <9506d5c8954c78d5890d48129156abfb93691397.1727341768.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727341768.git.roy.hopkins@suse.com>
References: <cover.1727341768.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E996021AFB
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.com:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 ARC_NA(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.com:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLgjcjk3igk5en59wt86eb8xw3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c          | 12 ++++++++++++
 hw/i386/pc_piix.c     | 10 ++++++++++
 hw/i386/pc_q35.c      | 10 ++++++++++
 include/hw/i386/x86.h |  3 +++
 qemu-options.hx       | 28 ++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8d84c22458..695fc1dbfe 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1843,6 +1843,18 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
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
index 2bf6865d40..5adf7da6f4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -360,6 +360,16 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8319b6d45e..483e0a0a40 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -324,6 +324,16 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..01ac29acf6 100644
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
+    IgvmCfg *igvm;
 };
 
 #define X86_MACHINE_SMM              "smm"
diff --git a/qemu-options.hx b/qemu-options.hx
index d94e2cbbae..66292c160b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5927,6 +5927,34 @@ SRST
                  -machine ...,memory-encryption=sev0 \\
                  .....
 
+    ``-object igvm-cfg,file=file``
+        Create an IGVM configuration object that defines the initial state
+        of the guest using a file in that conforms to the Independent Guest
+        Virtual Machine (IGVM) file format.
+
+        This is currently only supported by ``-machine q35`` and
+        ``-machine pc``.
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


