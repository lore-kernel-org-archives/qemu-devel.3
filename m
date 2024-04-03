Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B70CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryY7-0002wH-5I; Wed, 03 Apr 2024 07:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryY0-00029p-2h
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:52 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryXe-0007S9-U0
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:50 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2723F5CB87;
 Wed,  3 Apr 2024 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1712142748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kGn6gRTUM6cZA8KPFOZmyP2ilG2g52i9vISczC0d6PM=;
 b=r0TS1JVeRkts32D4lfNRSi9129ar9cFok7LfEe8haUiV15M70lq1yc4vnLJvtzmf3rjY+Y
 vTaEci3vZxO6wAQsTM4i+MSGqbP6OciS1bBB4yaJJqJIDCWxwCIxcnAa6ncAuLf0Kez4rv
 ulRiydS7sUp2pA5YUss6EHA4mg5Glx0=
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A2A813A8B;
 Wed,  3 Apr 2024 11:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id eDuuB5s5DWayHQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Apr 2024 11:12:27 +0000
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
Subject: [PATCH v2 05/10] i386/pc: Process IGVM file during PC initialization
 if present
Date: Wed,  3 Apr 2024 12:11:36 +0100
Message-ID: <32b59ca0922721f1588f497b6604f064132b62e9.1712141833.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712141833.git.roy.hopkins@suse.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spamd-Result: default: False [4.39 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL1cdfboiju7js16zrknyuzw5d)];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_TWELVE(0.00)[19]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2723F5CB87
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

An IGVM file contains configuration of a guest that supports
confidential computing hardware. As part of the PC system
initialisation, the IGVM needs to be processed to apply this
configuration before the guest is started.

This patch introduces processing of a provided IGVM file at the end of
the current PC initialization steps. If an IGVM file has been provided
then the directives in the file are processed completing the
initialization of the target.

If no IGVM file has been specified by the user then no there is no
intended consequences in these changes.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 backends/confidential-guest-support.c     | 18 ++++++++++++++++++
 hw/i386/pc_piix.c                         |  4 ++++
 hw/i386/pc_q35.c                          |  4 ++++
 include/exec/confidential-guest-support.h | 17 +++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index adfe447334..79c0f3fc56 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -88,3 +88,21 @@ static void confidential_guest_support_init(Object *obj)
 static void confidential_guest_support_finalize(Object *obj)
 {
 }
+
+bool cgs_is_igvm(ConfidentialGuestSupport *cgs)
+{
+#if defined(CONFIG_IGVM)
+    return cgs && cgs->igvm;
+#else
+    return false;
+#endif
+}
+
+void cgs_process_igvm(ConfidentialGuestSupport *cgs)
+{
+#if defined(CONFIG_IGVM)
+    if (cgs && cgs_is_igvm(cgs)) {
+        igvm_process(cgs, &error_fatal);
+    }
+#endif
+}
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 18ba076609..f63ddb8e83 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -68,6 +68,7 @@
 #include "hw/i386/acpi-build.h"
 #include "kvm/kvm-cpu.h"
 #include "target/i386/cpu.h"
+#include "exec/confidential-guest-support.h"
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
@@ -366,6 +367,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+    /* Apply confidential guest state from IGVM if supplied */
+    cgs_process_igvm(machine->cgs);
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b5922b44af..3f24728cd3 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -60,6 +60,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
+#include "exec/confidential-guest-support.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -327,6 +328,9 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+    /* Apply confidential guest state from IGVM if supplied */
+    cgs_process_igvm(machine->cgs);
 }
 
 #define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index 9419e91249..c380eee2c3 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -145,6 +145,23 @@ typedef struct ConfidentialGuestSupportClass {
     ObjectClass parent;
 } ConfidentialGuestSupportClass;
 
+/*
+ * Check whether the configuration of the confidential guest is provided
+ * using an IGVM file. IGVM configuration can include the system firmware,
+ * initial CPU state and other configuration that should override standard
+ * system initialization. This function should be used by platforms to
+ * determine which devices and configuration to include during system
+ * initialization.
+ */
+bool cgs_is_igvm(ConfidentialGuestSupport *cgs);
+/*
+ * If IGVM is supported and an IGVM file has been specified then the
+ * configuration described in the file is applied to the guest.
+ * Configuration of a confidential guest includes the layout of the
+ * guest memory, including firmware and initial CPU state.
+ */
+void cgs_process_igvm(ConfidentialGuestSupport *cgs);
+
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* QEMU_CONFIDENTIAL_GUEST_SUPPORT_H */
-- 
2.43.0


