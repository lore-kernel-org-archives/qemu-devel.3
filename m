Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A30EE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvD-0005cc-R0; Thu, 12 Feb 2026 09:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXul-0005Ko-L1
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXu9-0005i2-S2
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szAIg0k+mHe4c3qMioMT70O09QSk/0gvWDwX1okGjgQ=;
 b=ig9fAwjBP1Nu1oPJl4Dv+ea7vGjFJvDVdfy5swRSnOxnHK8RT5tVsGbmYWIxDGFch/+6Ut
 s15Mrd1f4WlSobk+BDSDE4JYl4OKaga+DWmM+iZ/VlpmNf0xgXhHKLVzAEF2MU4mF7Isk8
 jBfMJRvFwqpo57QIFJjPHtN+bPPWncM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-geDZpvomMri955dLHkdvdA-1; Thu, 12 Feb 2026 09:42:50 -0500
X-MC-Unique: geDZpvomMri955dLHkdvdA-1
X-Mimecast-MFC-AGG-ID: geDZpvomMri955dLHkdvdA_1770907368
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48079ae1001so63989335e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907367; x=1771512167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szAIg0k+mHe4c3qMioMT70O09QSk/0gvWDwX1okGjgQ=;
 b=P7YiclgC6rv5GhBefYVACDss91ZS5EQPtk+VQSd5k22vps7GhflspSy0P+1CgZsYZ3
 xSD7e2gjWFDDkrAcrT4WD9NUrKPLC+OF5XCXP86fws9RKmoRmeXhyshuffkbaH4j/y/S
 Nlkbf4PRInRgYxKVzyTeUNkYdKZhnu41obJnVZOULWG3GlxZLfnRkKi5ytMpcPrCZzaq
 4mlcAxerKFKIwx7ZpD2lF4SFx8AiriOf2tbviiwejy/QIPX5aYQp93RJZnyKbGW4Vd/Y
 1HKM6Rahb8zw4+PRzaOd+inTSzw96DDJjWkHOs41XmWPUDP1QYL2p8tWS/ZQknUtlMft
 z49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907367; x=1771512167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=szAIg0k+mHe4c3qMioMT70O09QSk/0gvWDwX1okGjgQ=;
 b=T3BBZe9RoRCNxtsCGHWJcIMwv9aaR5p0PpCi3SKBC5wIckcWQrAqmJe/GSFab33UfI
 FndT5i2WvbnXEwxTrfkZekOkSxLbzJXest7MnbXqK6oGO/KQKGMCy5IysYU2onu+P4bV
 TLwYNj4jAea7m7cWzalt85Y31j1zZyJS/KHy9K4X/vWVqevgvNJnsWdsBLkgkT2YbFTH
 z9DlUX0YNtlJ02NDVHMhv/dj00nxPzOUqxYSPq9iEznjimVJQ5AYs81NSRrKQCAofIQN
 Khb0P4Mczm/WOOT+nY9S9POwLBaVQ7Cu0E6K2sBl0ANjhuFeq+ntcFL/36HX3rsHBCgQ
 HeZQ==
X-Gm-Message-State: AOJu0YxAuRNxZ/U97XKTyg9x27vgsj/h88/qfhL7Eo9h30kWay3TEaWu
 T7yh7dubms8oDrur2XNipL3ZSBsvrxE1xgZ+6f2PdnPPlMq4zunZHeSVFksp2OSuQ6olMMeprf1
 5NC2zOZ3zzUcP88FiXN5HTGpYcBjzoeanLC8J/M/jGb6/SmkNGD8kYC8bMammx8NJXeUx44dnkH
 YtL/osAbiJhPouX32iVNqCwReCmL9g3cr0qh3mqaVl
X-Gm-Gg: AZuq6aLBBvzO90oRpZq0PpVUxwBLwPi8w3727nE9ua2uw+Pvd/YuCwtaA/BI3fcCpo6
 SHlwF+22bHYBDJHdBSGQXEpkzmwoLQ0t3YQ/W8GXjZAzd4MXjJ2vrViKtYv7vWFOt41pjgza/og
 d2/PiIdmiqpeD5v4T5yccOryBgLn2a6YtxFfv/WiaVW1DLsFPOKuq1das+cGsvPekticRfBpkq5
 GYq2DzqSJC3irzECv0SWBqMjiFwjfCVb91t++BlB9K07h2CxAF2JqRqEtyQhbyq9lC0NLucPi0A
 xVfjqsN0eIPG0mPRvVBN/tgZxSV5s0gta/I/gMI5bhTg3lsG+ebtl6NvacT5NCV2rRdm7UioOaz
 m40P11vzym1Tr7EqBdaahVTSeQOArrgnq1vXrPmak060g9QElHfdrPKUn8n+tCVM+TSiJwOb8yA
 7AnloF3oWWKS9mG4Rzd9R7gA43mNqiA/+WcTJKjs4c2N9IjN5n3zw=
X-Received: by 2002:a05:600c:4eca:b0:47e:e20e:bbb0 with SMTP id
 5b1f17b1804b1-483656adec5mr45736815e9.6.1770907367071; 
 Thu, 12 Feb 2026 06:42:47 -0800 (PST)
X-Received: by 2002:a05:600c:4eca:b0:47e:e20e:bbb0 with SMTP id
 5b1f17b1804b1-483656adec5mr45735935e9.6.1770907366469; 
 Thu, 12 Feb 2026 06:42:46 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba3df7asm62575835e9.4.2026.02.12.06.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jin Liu <jinl@redhat.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PULL 01/41] target/i386: convert SEV-ES termination requests to
 guest panic events
Date: Thu, 12 Feb 2026 15:42:03 +0100
Message-ID: <20260212144244.22579-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


