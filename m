Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD99C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reynd-00074Z-4a; Tue, 27 Feb 2024 09:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynQ-0006Xu-FQ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:05 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynN-0004Us-9B
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:04 -0500
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D9128226B7;
 Tue, 27 Feb 2024 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gH1uzqp5DgQbXGj0delkVVfwggMXXXMkMxeJlfyoobc=;
 b=HEC70uGy513wZszR80mCxhWLn7KTw7Dkr1G0lO5KjH8frU8VfHNqBJOjBpvKMvbPg3hUpA
 TTYpOAs8M7fUxap3KCHoQqUCuxr6B15VYrziycEXhX0ptnFPpn77Cp7QfQJHcB2qH6z96k
 rtPkdhGhpMRwhMc2tPhK/YZjTjTapCA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gH1uzqp5DgQbXGj0delkVVfwggMXXXMkMxeJlfyoobc=;
 b=HEC70uGy513wZszR80mCxhWLn7KTw7Dkr1G0lO5KjH8frU8VfHNqBJOjBpvKMvbPg3hUpA
 TTYpOAs8M7fUxap3KCHoQqUCuxr6B15VYrziycEXhX0ptnFPpn77Cp7QfQJHcB2qH6z96k
 rtPkdhGhpMRwhMc2tPhK/YZjTjTapCA=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 211A813ABF;
 Tue, 27 Feb 2024 14:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mMuvBdP23WXMAQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Tue, 27 Feb 2024 14:50:59 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH 5/9] i386/pc: Process IGVM file during PC initialization if
 present
Date: Tue, 27 Feb 2024 14:50:11 +0000
Message-ID: <e05414ac565023a97dae34f358eb34370cc52e2b.1709044754.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=HEC70uGy
X-Spamd-Result: default: False [-0.31 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL1cdfboiju7js16zrknyuzw5d)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.com:+];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D9128226B7
X-Spamd-Bar: /
Received-SPF: pass client-ip=195.135.223.130;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
initalization of the target.

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
index cb7651a8d0..881eef6b42 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -82,3 +82,21 @@ static void confidential_guest_support_init(Object *obj)
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
+        igvm_process(cgs);
+    }
+#endif
+}
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ec7c07b362..b449944ee8 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -66,6 +66,7 @@
 #include "hw/i386/acpi-build.h"
 #include "kvm/kvm-cpu.h"
 #include "target/i386/cpu.h"
+#include "exec/confidential-guest-support.h"
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
@@ -370,6 +371,9 @@ static void pc_init1(MachineState *machine,
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+    /* Apply confidential guest state from IGVM if supplied */
+    cgs_process_igvm(machine->cgs);
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 53fb3db26d..ecccf518e2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -58,6 +58,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
 #include "target/i386/cpu.h"
+#include "exec/confidential-guest-support.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -324,6 +325,9 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+    /* Apply confidential guest state from IGVM if supplied */
+    cgs_process_igvm(machine->cgs);
 }
 
 #define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index 1a017a8fda..2bc99d84cd 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -147,6 +147,23 @@ typedef struct ConfidentialGuestSupportClass {
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


