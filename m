Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A054E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGG-0002IP-Vw; Thu, 19 Dec 2024 11:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiW-000399-9I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiU-0002MD-N2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VQaKwg1D2Qf4PHe4EtWcKabR8++ETW6oPSveqgKZuc=;
 b=huNjhLGwNOoWo9XFYsVbrkfmNoGJlZKUvHtYR2azOa5VNtBVGhWU6zXKxX7fYOhaAlw/Hz
 QAbqMNewzoQ/8yZz/MaQP4KA1GmPg2dNVMXM6IT8GPBR2VoxdfAhM8uXweI44uQpc98mnX
 xH5mih59mqV1cp7WSg9e308AeaFCHes=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-euvJhC7OPw-O7cBDgdzhEw-1; Thu, 19 Dec 2024 09:41:27 -0500
X-MC-Unique: euvJhC7OPw-O7cBDgdzhEw-1
X-Mimecast-MFC-AGG-ID: euvJhC7OPw-O7cBDgdzhEw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so597313f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619286; x=1735224086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VQaKwg1D2Qf4PHe4EtWcKabR8++ETW6oPSveqgKZuc=;
 b=ojzSstP7gcOeLE0DxdjBRKCFUwqTgh6yV+2NmlBSYSshoFKY8eJX9QiC5SfHQj/yWI
 4MiHtKEEAE0HuZ3KNVq32mUvoCfw/VPZr6msi3XEVnKxMtl2hT6H0n9Soe2xr13AAB3k
 dCWy64s+Duh+VgToaLdLp6DSXlhZq45A66sXN44SJtcW4Hr5Qvut/yxBF+hTwVULkAzr
 BMtB+/UVTHNLcm5dliA8dnxXzULh7LkhRV0HKbQWvxqgxTNZnsthS6rJk2+OiMkgzDDd
 uBAWtUQX/c2jREUqLHolzMPY64qUTJ1VrAWryt6hMJ+z5uqlMm3A5x1vAcvK8j1lZg8u
 ByAA==
X-Gm-Message-State: AOJu0Yyr+CQXlhsepRyn0DbIANF+i3lL/eb/OFgWZiq69CCfNhvhdKc4
 auVpJceSGZY8N7Hf1pFUB6EvTO1sAqsongIqXqVGYv7kCUm5hYqM4pUQYUAh51Z0Is+PHjGh0uI
 IlmD8zOmuPjGCZ4rIWwrzrFvBawswkhstRJq/7Uh/5TIifBYe+b9IMXKHTJ/xnj/TR+fvQD6JK1
 YTSjut54ALWMgzyhUAlkQsaoil6ky1wQudSs8=
X-Gm-Gg: ASbGncvV8j/mhl2dTu1e8APlboqxx2FeFKv4FQJM7IC8+pPvSFSgsbCQ8VEPKnGBgpl
 znU4/aJ4rpQREML4H4eqhnFi1ZxOUyt+V7WAbeHFyfcA0UGqHsXbVPgRRbEdqRQd+85NHAX+jHZ
 1tpCJOV77Yn439Fuwk2VieaO6RtNOASR1Tl4/3Bvj/veDCpex2aj8MH0gMYILCJ6n0nr1qQHAW6
 NuEfLNm8hD/rzYGhikyr33moMFfcDY/K5C/Dyp6EP0Basbl3SLF5gwU1u/tZzTju1GEtzxOFhRR
 iDCZ+ao2aWjr1rak2X0zL3SNqc7mIeQnTA5YP++O
X-Received: by 2002:a5d:64a2:0:b0:385:ec8d:8ca9 with SMTP id
 ffacd0b85a97d-388e4d8df0dmr4694176f8f.42.1734619286180; 
 Thu, 19 Dec 2024 06:41:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIEgkc+OWymXfFtvw7wa43e2Ok9cgC15n/X7Sias5HbodnR2vSsXI6yd3ff9qoB4yE0t+j5A==
X-Received: by 2002:a5d:64a2:0:b0:385:ec8d:8ca9 with SMTP id
 ffacd0b85a97d-388e4d8df0dmr4694139f8f.42.1734619285680; 
 Thu, 19 Dec 2024 06:41:25 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c84840asm1700557f8f.61.2024.12.19.06.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:24 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/14] s390x/s390-virtio-hcall: prepare for more diag500
 hypercalls
Date: Thu, 19 Dec 2024 15:41:04 +0100
Message-ID: <20241219144115.2820241-4-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Let's generalize, abstracting the virtio bits. diag500 is now a generic
hypercall to handle QEMU/KVM specific things. Explicitly specify all
already defined subcodes, including legacy ones (so we know what we can
use for new hypercalls).

Move the PGM_SPECIFICATION injection into the renamed function
handle_diag_500(), so we can turn it into a void function.

We'll rename the files separately, so git properly detects the rename.

Message-ID: <20241008105455.2302628-4-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-hcall.c   | 15 ++++++++-------
 hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
 target/s390x/kvm/kvm.c         | 20 +++-----------------
 target/s390x/tcg/misc_helper.c |  5 +++--
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index ca49e3cd22..5fb78a719e 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390
+ * Support for QEMU/KVM hypercalls on s390
  *
  * Copyright 2012 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -57,18 +57,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
     return 0;
 }
 
-int s390_virtio_hypercall(CPUS390XState *env)
+void handle_diag_500(S390CPU *cpu, uintptr_t ra)
 {
+    CPUS390XState *env = &cpu->env;
     const uint64_t subcode = env->regs[1];
 
     switch (subcode) {
-    case KVM_S390_VIRTIO_NOTIFY:
+    case DIAG500_VIRTIO_NOTIFY:
         env->regs[2] = handle_virtio_notify(env->regs[2]);
-        return 0;
-    case KVM_S390_VIRTIO_CCW_NOTIFY:
+        break;
+    case DIAG500_VIRTIO_CCW_NOTIFY:
         env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
-        return 0;
+        break;
     default:
-        return -EINVAL;
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 }
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 3d9fe147d2..dca456b926 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390x
+ * Support for QEMU/KVM hypercalls on s390x
  *
  * Copyright IBM Corp. 2012, 2017
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -12,12 +12,13 @@
 #ifndef HW_S390_VIRTIO_HCALL_H
 #define HW_S390_VIRTIO_HCALL_H
 
-#include "standard-headers/asm-s390/virtio-ccw.h"
 #include "cpu.h"
 
-/* The only thing that we need from the old kvm_virtio.h file */
-#define KVM_S390_VIRTIO_NOTIFY 0
+#define DIAG500_VIRTIO_NOTIFY           0 /* legacy, implemented as a NOP */
+#define DIAG500_VIRTIO_RESET            1 /* legacy */
+#define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
+#define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
 
-int s390_virtio_hypercall(CPUS390XState *env);
+void handle_diag_500(S390CPU *cpu, uintptr_t ra);
 
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 32cf70bb19..508403609f 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1492,22 +1492,6 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
     return r;
 }
 
-static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
-{
-    CPUS390XState *env = &cpu->env;
-    int ret = -EINVAL;
-
-#ifdef CONFIG_S390_CCW_VIRTIO
-    ret = s390_virtio_hypercall(env);
-#endif /* CONFIG_S390_CCW_VIRTIO */
-    if (ret == -EINVAL) {
-        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
-        return 0;
-    }
-
-    return ret;
-}
-
 static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
 {
     uint64_t r1, r3;
@@ -1603,9 +1587,11 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
     case DIAG_SET_CONTROL_PROGRAM_CODES:
         handle_diag_318(cpu, run);
         break;
+#ifdef CONFIG_S390_CCW_VIRTIO
     case DIAG_KVM_HYPERCALL:
-        r = handle_hypercall(cpu, run);
+        handle_diag_500(cpu, RA_IGNORED);
         break;
+#endif /* CONFIG_S390_CCW_VIRTIO */
     case DIAG_KVM_BREAKPOINT:
         r = handle_sw_breakpoint(cpu, run);
         break;
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f44136a568..2b4310003b 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -119,10 +119,11 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     switch (num) {
 #ifdef CONFIG_S390_CCW_VIRTIO
     case 0x500:
-        /* KVM hypercall */
+        /* QEMU/KVM hypercall */
         bql_lock();
-        r = s390_virtio_hypercall(env);
+        handle_diag_500(env_archcpu(env), GETPC());
         bql_unlock();
+        r = 0;
         break;
 #endif /* CONFIG_S390_CCW_VIRTIO */
     case 0x44:
-- 
2.47.1


