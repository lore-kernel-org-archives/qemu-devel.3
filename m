Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0918DD2F038
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk0p-0004xi-VN; Tue, 27 Jan 2026 09:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkk0o-0004xA-Ke
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkk0l-0003G9-Ql
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769523942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=szAIg0k+mHe4c3qMioMT70O09QSk/0gvWDwX1okGjgQ=;
 b=Oi0b96xz5Qt9acU3UC08NPQsuOV0L8TpHzt424KLLfHjWbENcOC/lFEtKNylQBkdIg8Ewh
 7xDHS4ZlKUiERzBk/ERmv16DDHk6QcU0T5CdGazFfF5WQadSTJqNDandRhGxRb7BszDcca
 0JjUb93lxv1RKQkNjd63iEUbygO0TDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-qcwUTpITNDSQv9OeruR00Q-1; Tue, 27 Jan 2026 09:25:41 -0500
X-MC-Unique: qcwUTpITNDSQv9OeruR00Q-1
X-Mimecast-MFC-AGG-ID: qcwUTpITNDSQv9OeruR00Q_1769523940
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee33324e8so43190425e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769523939; x=1770128739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=szAIg0k+mHe4c3qMioMT70O09QSk/0gvWDwX1okGjgQ=;
 b=bSZIfgc/EC+WrLcc25O7YrqtohhLJHSBOKAkWBsD4OXMKSad30kdhsdDarVsFKEF2g
 oPDDPeaikvCKb6FrcNWIziRdybyC/wq/v24jvospnlGH3kkzbjNDpvPk7dlNcdAh0/Ez
 bFsLq1WGK52e38WXMI/DohvLlhCjnGtgekGOEyc8mTH+8IxYZnVOF16ffyiNW1eSNYCd
 cCdizsfI/4FlyZ9alcYsTjuZS88QU42WI4ZLFxJBjwpG8l83q7280a65qwLCPe5Y09MZ
 kDIuiIflcG0QWo51Uub1KDRXbSIgI0y1fT/zEZoqQf5NvfCp//Cm+Hr7LPktrPVp5hPP
 ODew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769523939; x=1770128739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szAIg0k+mHe4c3qMioMT70O09QSk/0gvWDwX1okGjgQ=;
 b=F5ViHLxUYuyfzeZyXD5aMqm5Hh8G/YXQWbnwrgzZaQsGpP9IEO+hiKNv/M2CqLX65D
 cQXVcxM2KW5Yho9gYfJdv3lhXWGDSM1nqCtQQ3dqKQi8l2g9IjA0UV/Mxj43V0jyG7VT
 17vsKtMiEY+13MknM1/C8y3KUD9dpXaxF0rwht8uAm8RMDea3L97mI7WLUX7C8DaSnks
 6lohQMRovrlXVXnnOQWwncnBRIGglAMNvOnRFuKyYPTe3MZ8Y9xK+V01KD22bcURsKJe
 cZqRSeeLKzOOmvXII1PCKz4hHxSlwcSL7NkYEdr638wSjvXT0LW3I0Y0WRFaKv6RU/t0
 bsmg==
X-Gm-Message-State: AOJu0YzaKj+MSN5CfWzoMf1gcwrftYzpKSuJ+4Any2JbeMOZRVcKohzu
 8JBzdmRsDwgqmWNn4CapC5P6aBN57+8MSnciXisLYcY1Z9o6GOzYkrmsqPEBRSmouEDU8WV8iid
 YNziAlPJ+1T/3HlfmcobzQ4/vkuPdkeVe+0xc50eRKOugnR94BPkt2pGEQe3W/SX5P5y4fxR1gb
 2KsmMib6qHGjZI8GIJDfxoOpRnWdjAQFrQ0fd9KubK
X-Gm-Gg: AZuq6aLTkoEMLKrYEnnhcIVmaZqTaVysNonQjA8Q9a3aySm1avT/YpwQXJ8eRwC3Afx
 OXr/qqxdd+iuvb9C/eTVu6UjvZBA+hSHGXttpmo9kaVjwMwHn8yOxqnbH65sF8EfoMCSsMnaCsL
 lI3DYKp8j4gntFJjMO8nbYbpbSDl4pVEH1EVjO4i2phjO6LvJA2sxkupasxgrShRC5hS5ooL0M9
 3A5/kMbBMGr/X4u4wdHKyLtp8Fve8pxp4nsIDP6MjTtmxflXTqC2ReVvAPvkWlUcpX/DAA6gln2
 L4bYF24aX8hQUXOhoRmO4Xv/gADqlp/ZgEljx/jJbKuQ85+zvUKGPeY3OZPGJarLXNCP0QJKMkl
 0c1CuAH2UbRkGKnN7unEbXXCPzoHt+jrIjZOOg8yOE7urahngdPXptQqVO0hDn8DD4OpxTY2EcO
 HUPCvC2VeoFg2XiA==
X-Received: by 2002:a05:600c:8714:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-48069c16475mr26781225e9.1.1769523938907; 
 Tue, 27 Jan 2026 06:25:38 -0800 (PST)
X-Received: by 2002:a05:600c:8714:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-48069c16475mr26780775e9.1.1769523938384; 
 Tue, 27 Jan 2026 06:25:38 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d4faecbsm131168725e9.1.2026.01.27.06.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:25:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jin Liu <jinl@redhat.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH] target/i386: convert SEV-ES termination requests to guest
 panic events
Date: Tue, 27 Jan 2026 15:25:36 +0100
Message-ID: <20260127142536.412726-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This produces a good error message instead of:

KVM: unknown exit reason 24
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
ES =0000 00000000 0000ffff 00009300
CS =f000 00800000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     00000000 0000ffff
IDT=     00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Reported-by: Jin Liu <jinl@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/run-state.json      | 23 +++++++++++++++++++++--
 accel/kvm/kvm-all.c      |  1 +
 system/runstate.c        |  4 ++++
 target/i386/cpu-system.c | 22 ++++++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index a6bc94a44bb..a5771ad4681 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -504,10 +504,12 @@
 #
 # @tdx: tdx guest panic information type (Since: 10.1)
 #
+# @sev: AMD SEV-ES guest termination information type (Since: 11.0)
+#
 # Since: 2.9
 ##
 { 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v', 's390', 'tdx' ] }
+  'data': [ 'hyper-v', 's390', 'tdx', 'sev' ] }
 
 ##
 # @GuestPanicInformation:
@@ -523,7 +525,8 @@
  'discriminator': 'type',
  'data': {'hyper-v': 'GuestPanicInformationHyperV',
           's390': 'GuestPanicInformationS390',
-          'tdx' : 'GuestPanicInformationTdx'}}
+          'tdx': 'GuestPanicInformationTdx',
+          'sev': 'GuestPanicInformationSev' }}
 
 ##
 # @GuestPanicInformationHyperV:
@@ -625,6 +628,22 @@
           'message': 'str',
           '*gpa': 'uint64'}}
 
+##
+# @GuestPanicInformationSev:
+#
+# Information for AMD SEV-specific termination request (GHCB MSR
+# contents)
+#
+# @set: The reason code set provided by the guest
+#
+# @code: The reason code provided by the guest
+#
+# Since: 11.0
+##
+{'struct': 'GuestPanicInformationSev',
+ 'data': {'set': 'uint32',
+          'code': 'uint32'}}
+
 ##
 # @MEMORY_FAILURE:
 #
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8301a512e7f..0d8b0c43470 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3300,6 +3300,7 @@ int kvm_cpu_exec(CPUState *cpu)
                 qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
                 ret = EXCP_INTERRUPT;
                 break;
+            case KVM_SYSTEM_EVENT_SEV_TERM:
             case KVM_SYSTEM_EVENT_CRASH:
                 kvm_cpu_synchronize_state(cpu);
                 bql_lock();
diff --git a/system/runstate.c b/system/runstate.c
index ed2db564806..d091a2bdddb 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -669,6 +669,10 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                               "can be found at gpa page: 0x%" PRIx64 "\n",
                               info->u.tdx.gpa);
             }
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_SEV) {
+            qemu_log_mask(LOG_GUEST_ERROR, "SEV termination (reason set: %d code: %d)",
+                          info->u.sev.set,
+                          info->u.sev.code);
         }
 
         qapi_free_GuestPanicInformation(info);
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index b1494aa6740..c8bbf0cbafd 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/kvm.h"
 #include "cpu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
@@ -272,6 +274,26 @@ GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
     CPUX86State *env = &cpu->env;
     GuestPanicInformation *panic_info = NULL;
 
+#ifdef CONFIG_KVM
+    if (kvm_enabled()) {
+        struct kvm_run *run = cs->kvm_run;
+
+        if (run->exit_reason == KVM_EXIT_SYSTEM_EVENT &&
+            run->system_event.type == KVM_SYSTEM_EVENT_SEV_TERM) {
+            panic_info = g_new0(GuestPanicInformation, 1);
+
+            panic_info->type = GUEST_PANIC_INFORMATION_TYPE_SEV;
+            /* There should always be one data item, otherwise use zeroes.  */
+            if (run->system_event.ndata > 0) {
+                panic_info->u.sev.set = (run->system_event.data[0] >> 12) & 0xf;
+                panic_info->u.sev.code = (run->system_event.data[0] >> 16) & 0xff;
+            } else {
+                warn_report("Hypervisor did not provide any data for SEV-ES termination");
+            }
+        }
+    } else
+#endif
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_CRASH)) {
         panic_info = g_new0(GuestPanicInformation, 1);
 
-- 
2.52.0


