Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147B9C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnevM-0007mo-7L; Thu, 27 Feb 2025 09:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <edff2bf1.AVIAAGMvUGQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHc2@a3031119.bnc3.mailjet.com>)
 id 1tnev7-00076C-MO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:31:26 -0500
Received: from o0.p27.mailjet.com ([185.189.238.0])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <edff2bf1.AVIAAGMvUGQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHc2@a3031119.bnc3.mailjet.com>)
 id 1tnev5-00067W-Js
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
 d=randomman.co.uk; i=roy.hopkins@randomman.co.uk; s=mailjet; x=1740673878;
 h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe-post:list-unsubscribe:
 cc:feedback-id:in-reply-to:references:x-csa-complaints:x-mj-mid:x-mj-smtpguid:
 x-report-abuse-to:content-type:content-transfer-encoding;
 bh=wlswxwumfmqWyMCJTOkK60i/m10r0H4MQHDPopGM2v4=;
 b=LlowocNmf0c+ki/va/9lPfzumwLFCL9Zkp/V/MYWLoYo/wWH/98y8Tndo
 qXVVgn95LWwsA/ma9/RunxhfTV1CK1XUrxNy5XZPj8bfvcp6+CsD+JZlfNLV
 13s+F88z22tus7R+bPz1j9jIrv80ezHU2jw/F++rcDwn5sJ4RjmhubkTeibF
 b5LksXOg4dE6QMUPBMAf1btYBGARa6oqo9jZjbnmN8v3fVVRPnR3tflwgF2T
 sJUi8r3W0o494JmmiDg7YBqSUPtZuDgsXc4PNB14cXocwvblv6PBHpFWkPp7
 94B1yJt+1pyUlk7D5SqjzEDk5SU94sLm9/w88gCxmmS0Q==
Message-Id: <edff2bf1.AVIAAGMvUGQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHc2@mailjet.com>
MIME-Version: 1.0
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/16] i386/pc_sysfw: Ensure sysfw flash configuration
 does not conflict with IGVM
Date: Thu, 27 Feb 2025 14:29:23 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>
Feedback-Id: 42.3031119.2785883:MJ
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid: AVIAAGMvUGQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHc2MvIl0w8CSlWyruy8T_x5OgAqgls
X-MJ-SMTPGUID: 38407107-47bf-4ffe-b0d7-e374ac88f84c
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.189.238.0;
 envelope-from=edff2bf1.AVIAAGMvUGQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHc2@a3031119.bnc3.mailjet.com;
 helo=o0.p27.mailjet.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 hw/i386/pc_sysfw.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1eeb58ab37..2460af7014 100644
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


