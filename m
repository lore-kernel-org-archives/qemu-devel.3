Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DFCC021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 03:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlJbP-0002IV-0J; Thu, 20 Feb 2025 22:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tlJbM-0002II-1U
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 22:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tlJbJ-0005jh-GB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 22:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740108074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zdaBW7JapAxNz4MDJX9rFAsTtsG9gzV/VtvAiXL6qhs=;
 b=b1kH2o6WIH/rXt1YD0XCXSCmFzk6bAqrv85NEFScu2H6RbTIXkAAJ3lgVfiJ2IfmO53Ty6
 afop3A1GTQf1JnVL5v/Z7o0M78X6nGxBBK05pwsuX5r+farXPE4im9e+JESPkdwH2P0LcB
 nqKmze9faqnN40HzlZjhYXM0M1cFEHY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-R8pCLglYPlu2PtqmUbOzFw-1; Thu, 20 Feb 2025 22:21:11 -0500
X-MC-Unique: R8pCLglYPlu2PtqmUbOzFw-1
X-Mimecast-MFC-AGG-ID: R8pCLglYPlu2PtqmUbOzFw_1740108070
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-220ff7d7b67so34814105ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 19:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740108070; x=1740712870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zdaBW7JapAxNz4MDJX9rFAsTtsG9gzV/VtvAiXL6qhs=;
 b=MOqc9mqgkAlZxSOX5/4zwI7aLi4yTkNyY4WA05maa3onYf1WL/6zJw8WefiVfOCjNo
 uzPwI6v1QxLRV6odaZW8ur3dkgDkSnsp6E0CQ4oB7D+f8E3/tBKzW5XW1UfVexKDPglE
 0/x658PAC1hIZRob8ZxVGit0/JFrutTpRoeqm+O3+g8GYTBHJaCi7ivYr8JXtF+F1ysu
 Ar1hDZvcRLOOjWwc0AGiEO+naSACGCxvrSNLvJketuwB01QVOeleHw+ovoJtmBCOE+Hk
 /rb5Aa9TdfXP+mNCojTwAc6mw7jBqz1dq5m4m0PqCX4KP+NSHI7uqCqoIHJzP/S0mnKA
 9ufQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLc7DbDtNPh14qGN+8BulTR3VP6MQwsxhn/EThk0JLS3jjSErsZlmLwJQc3ssbstFNhaelAN2EEck1@nongnu.org
X-Gm-Message-State: AOJu0YyG2j96z7QAihiSrNztM+UqAuI1+FdA9rPN1ApGT7KOKK9C4Gfo
 MFa/Whc8kRHscvdW4muA/dWaMuyVNk8bjcdNDzIVzF7kBHIerjm5g+vsdS/Gk52aAru7e1lgfKC
 uXcxRpPcJdN2nylMvruEuhAnXS14XqfOx3A4///9iCa7ULbHGjGU/
X-Gm-Gg: ASbGncvoDC2ypNeEWpG3q2HP8U5VqyNTQC+J0Mjv9F3EdVvxe5MEEqtjgby7aqmb0kw
 EvFI0QlBqnf8AEGXshymljhvVVM1ovymwR/Tbd9397YkRoKM9160wQXb5X0QoMw57tL1Pudfnie
 99lntCRQ9TbvEgb2C4Jqd9AcANtiZdq8Gw0/RyRN8B3RJHjXHSigMHXJabQdeg5s3RzstGzO3Sx
 mEBb59Fu9nf/fM+2jSqDDXDctzmBky5TB4QzzpbzVcb+0WMKw+fUUyDOH+k7EQJPyvgPGRdReYO
 HPlGX8yEC6fyeLPYdL4XxEq7vJe4Wg==
X-Received: by 2002:a17:903:2f43:b0:215:89a0:416f with SMTP id
 d9443c01a7336-2219ffc2dcbmr22236655ad.30.1740108070317; 
 Thu, 20 Feb 2025 19:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF64fAdzhGhjXwZnLqyRIG6yss5I/fro+y/EOohGg2FIeFsncXgeVVEbVkA87uLVkcpivF7WQ==
X-Received: by 2002:a17:903:2f43:b0:215:89a0:416f with SMTP id
 d9443c01a7336-2219ffc2dcbmr22236365ad.30.1740108069924; 
 Thu, 20 Feb 2025 19:21:09 -0800 (PST)
Received: from localhost.localdomain ([203.163.237.246])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2fceb02d990sm229311a91.1.2025.02.20.19.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 19:21:09 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/i386: introduce x86_firmware_reconfigure api
Date: Fri, 21 Feb 2025 08:50:51 +0530
Message-ID: <20250221032051.35033-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Normally, there is no need to perform firmware reconfiguration once the
virtal machine has started. Hence, currently ovmf firmware parsing happens only
once. However, if the firmware changes betweeen boots then reconfiguration needs
to happen again. Firmware can change if for example the guest brings its own
firmware bundle and installs it with the help of the hypervisor[1]. Therefore,
this change introduces a new api with which firmware configuration steps can
be forced again.
This is mostly refactoring work. No functional changes. CI pipeline does not
break with this change.

1) https://pretalx.com/kvm-forum-2024/talk/HJSKRQ/

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_sysfw.c            | 25 +++++++++++++++++--------
 hw/i386/pc_sysfw_ovmf-stubs.c |  3 ++-
 hw/i386/pc_sysfw_ovmf.c       |  5 +++--
 include/hw/i386/pc.h          |  3 ++-
 include/hw/i386/x86.h         |  1 +
 5 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1eeb58ab37..0b9913d7b9 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -258,16 +258,9 @@ void pc_system_firmware_init(PCMachineState *pcms,
     pc_system_flash_cleanup_unused(pcms);
 }
 
-void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+static void x86_firmware_configure_sev(hwaddr gpa, void *ptr, int size)
 {
     int ret;
-
-    /*
-     * OVMF places a GUIDed structures in the flash, so
-     * search for them
-     */
-    pc_system_parse_ovmf_flash(ptr, size);
-
     if (sev_enabled()) {
 
         /* Copy the SEV metadata table (if it exists) */
@@ -282,3 +275,19 @@ void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
         sev_encrypt_flash(gpa, ptr, size, &error_fatal);
     }
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    /*
+     * OVMF places a GUIDed structures in the flash, so
+     * search for them
+     */
+    pc_system_parse_ovmf_flash(ptr, size, false);
+    x86_firmware_configure_sev(gpa, ptr, size);
+}
+
+void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size)
+{
+    pc_system_parse_ovmf_flash(ptr, size, true);
+    x86_firmware_configure_sev(gpa, ptr, size);
+}
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index aabe78b271..a8c0c265d7 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -20,7 +20,8 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data, int *data_len)
     g_assert_not_reached();
 }
 
-void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
+void pc_system_parse_ovmf_flash(uint8_t *flash_ptr,
+                                size_t flash_size, bool force)
 {
     g_assert_not_reached();
 }
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 07a4c267fa..7d54622771 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -36,14 +36,15 @@ static bool ovmf_flash_parsed;
 static uint8_t *ovmf_table;
 static int ovmf_table_len;
 
-void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
+void pc_system_parse_ovmf_flash(uint8_t *flash_ptr,
+                                size_t flash_size, bool force)
 {
     uint8_t *ptr;
     QemuUUID guid;
     int tot_len;
 
     /* should only be called once */
-    if (ovmf_flash_parsed) {
+    if (ovmf_flash_parsed && !force) {
         return;
     }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f..769f1361ce 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -210,7 +210,8 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
-void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
+void pc_system_parse_ovmf_flash(uint8_t *flash_ptr,
+                                size_t flash_size, bool force);
 
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..18c0d6851a 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -155,5 +155,6 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state);
 
 /* pc_sysfw.c */
 void x86_firmware_configure(hwaddr gpa, void *ptr, int size);
+void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size);
 
 #endif
-- 
2.42.0


