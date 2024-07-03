Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F4C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxot-0004qh-NY; Wed, 03 Jul 2024 07:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxon-0004nm-NO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:33 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxod-0006VO-0i
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8F9921BBE;
 Wed,  3 Jul 2024 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRRRu1HVMhQopycJAChyulAE58PCso61Wo9ldIbqjbA=;
 b=kSktW48HBGeiQeHhluhn1nAxnTZu+mOrI2UzGfHvE7t1GcR2J6iGN8ANhxrAs1TTLnx3HU
 QOufQblIYMwKHgF7K7nPlGlRt2TyclvB0T4c1e1yZAc07LEeCCQ6FGF0hMCGNKZhChQd7V
 2dy3UcXNSvhWyQLzMwOC62pWaM4cOYM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRRRu1HVMhQopycJAChyulAE58PCso61Wo9ldIbqjbA=;
 b=kSktW48HBGeiQeHhluhn1nAxnTZu+mOrI2UzGfHvE7t1GcR2J6iGN8ANhxrAs1TTLnx3HU
 QOufQblIYMwKHgF7K7nPlGlRt2TyclvB0T4c1e1yZAc07LEeCCQ6FGF0hMCGNKZhChQd7V
 2dy3UcXNSvhWyQLzMwOC62pWaM4cOYM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA97F13A7F;
 Wed,  3 Jul 2024 11:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KKtAN6wwhWZ6cgAAD6G6ig
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
Subject: [PATCH v4 05/17] i386/pc_sysfw: Ensure sysfw flash configuration does
 not conflict with IGVM
Date: Wed,  3 Jul 2024 12:05:43 +0100
Message-ID: <c58c4b5cc8a35245b7ef31fefcc67a72e6346a07.1720004383.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720004383.git.roy.hopkins@suse.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.69 / 50.00]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.01)[49.25%];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLm8d31jk6dhzwhww9bgqrb1jt)];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.130;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
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

When using an IGVM file the configuration of the system firmware is
defined by IGVM directives contained in the file. In this case the user
should not configure any pflash devices.

This commit skips initialization of the ROM mode when pflash0 is not set
then checks to ensure no pflash devices have been configured when using
IGVM, exiting with an error message if this is not the case.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 hw/i386/pc_sysfw.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ef80281d28..f5e40b3ef6 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -219,7 +219,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
     if (!pcmc->pci_enabled) {
-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
+        /*
+         * If an IGVM file is specified then the firmware must be provided
+         * in the IGVM file.
+         */
+        if (!X86_MACHINE(pcms)->igvm) {
+            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
+        }
         return;
     }
 
@@ -239,8 +245,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
     }
 
     if (!pflash_blk[0]) {
-        /* Machine property pflash0 not set, use ROM mode */
-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
+        /*
+         * Machine property pflash0 not set, use ROM mode unless using IGVM,
+         * in which case the firmware must be provided by the IGVM file.
+         */
+        if (!X86_MACHINE(pcms)->igvm) {
+            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
+        }
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
@@ -256,6 +267,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
     }
 
     pc_system_flash_cleanup_unused(pcms);
+
+    /*
+     * The user should not have specified any pflash devices when using IGVM
+     * to configure the guest.
+     */
+    if (X86_MACHINE(pcms)->igvm) {
+        for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
+            if (pcms->flash[i]) {
+                error_report("pflash devices cannot be configured when "
+                             "using IGVM");
+                exit(1);
+            }
+        }
+    }
 }
 
 void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
-- 
2.43.0


