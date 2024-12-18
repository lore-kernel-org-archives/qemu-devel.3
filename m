Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069E6E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNriJ-0001kS-CG; Wed, 18 Dec 2024 05:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhs-0000nG-Uo
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrho-0006zg-5y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uM+FWljAFEQKRezuys6B3I8zqsZ9FHnISAqVX/2eZI=;
 b=Y9+58KlfYcugPgy6DW3gP8ygF362rn+5tykTj/0/AZFltF6FVQp3ucMsNJBaFZc9NRoZPZ
 OP3gwClGmYwLdZkLfAvCv5lGdNloasOCf2lbntCEYLX5loKHTkwv0fqn2xYFqEhw0DVhvr
 MebUbJCVt2PGdsfzel3Cp+rYvSvmmMw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-6acG3tf4MYq-6N3JVdz1MQ-1; Wed, 18 Dec 2024 05:53:17 -0500
X-MC-Unique: 6acG3tf4MYq-6N3JVdz1MQ-1
X-Mimecast-MFC-AGG-ID: 6acG3tf4MYq-6N3JVdz1MQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38629a685fdso2004056f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519196; x=1735123996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uM+FWljAFEQKRezuys6B3I8zqsZ9FHnISAqVX/2eZI=;
 b=bbMBUQoDz+o9kINMSg+2uhaK99RklPHxGv9vHUZWiestqbxfBgcH9k9oNzX6FBNrTR
 HVO5AwaZZLOt4/nr+T0dBzZXqA5JxboyuraDOfnae0ZRy2PYxsW59JMqkKSsenlkvJt/
 e3/R3aomLIHD7FCSzZw3VZl9nGOkdeWNn9CFJrlHXS77lKGqjd1TcRmNJOu6KzymxRNd
 kr538dzsFDyBeW1y6JgAZ2r8RdyfDabJyUYePpxiozgn7Wsb2QuRxkvUFEfwA3NHNPjQ
 TH3Qa04gZLACGeGuE/6LzJpBizKfsvMiIGQ2C1NjU06STnYERI9cb02zoUwSBmMlOk46
 mwlA==
X-Gm-Message-State: AOJu0Yxa7wigh8HF4pSRypasu4iQcpAVRyyEbuawkmE2WVwFD25Gl7ye
 X26TYgdiZgK0x/FiekusiLX63l9v7xdV0jqx4x8Z/nDtuONU6D8viU6YLsGc6sd2Ot24Y/vokVy
 folf99/+KAKabeG5GEJEtg9eq/8zpDbTm3Pqu6vddWHT9ra8e57B1bll5iZgjVChL5mXWSR2hUp
 ZdPy6oQM8iQbya6nk2DOTkvjb/ulZqmQ7iGHs=
X-Gm-Gg: ASbGncvISHgaQzsAk5kkjyxUDBKVCcBKpVXbw2pEt0bv9/gp2JGnplYKQ/BcJl0HJqO
 gwS10OqPrc0JPYRb24MMejSguBhEzCTuGYEr2ElTRfdjZa+CHFF0vXL6EdRoklHStM/TVYNjwAj
 jG3xnPlllQ4g9E/9DznRWrsWzoeDO//OKGvSkacIodGTD0Na/618VNzrlsdYY5iK3vigK7YF/0M
 K9gAT7DmBTYiY3QFv/8eFiixkSV73g8gryRr+V94KXNggl4+ncrO6doqmTmp/joWGghEMEGRsVh
 Z1bWPOj3tdz1AA4HMhH4zq9WqP8/+ucYlGr0npFD7w==
X-Received: by 2002:a5d:47a3:0:b0:386:34cb:37b with SMTP id
 ffacd0b85a97d-388e4d96d2fmr1534625f8f.56.1734519196326; 
 Wed, 18 Dec 2024 02:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/sWSUM6eFz9e0Fj2ehZix+pCZAtX4z9ddKA37lVSDdVWFlMJSod4Dayo4sxctiSlixawauw==
X-Received: by 2002:a5d:47a3:0:b0:386:34cb:37b with SMTP id
 ffacd0b85a97d-388e4d96d2fmr1534598f8f.56.1734519195851; 
 Wed, 18 Dec 2024 02:53:15 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-388c8046ca6sm13922120f8f.83.2024.12.18.02.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:15 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 04/15] s390x/s390-virtio-hcall: prepare for more diag500
 hypercalls
Date: Wed, 18 Dec 2024 11:52:52 +0100
Message-ID: <20241218105303.1966303-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
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
 target/s390x/kvm/kvm.c         | 16 +---------------
 target/s390x/tcg/misc_helper.c |  5 +++--
 4 files changed, 18 insertions(+), 29 deletions(-)

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
index dd0322c43a..9fbb7db163 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1491,20 +1491,6 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
     return r;
 }
 
-static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
-{
-    CPUS390XState *env = &cpu->env;
-    int ret;
-
-    ret = s390_virtio_hypercall(env);
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
@@ -1601,7 +1587,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
         handle_diag_318(cpu, run);
         break;
     case DIAG_KVM_HYPERCALL:
-        r = handle_hypercall(cpu, run);
+        handle_diag_500(cpu, RA_IGNORED);
         break;
     case DIAG_KVM_BREAKPOINT:
         r = handle_sw_breakpoint(cpu, run);
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 303f86d363..0ab2bf36cf 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -117,10 +117,11 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
 
     switch (num) {
     case 0x500:
-        /* KVM hypercall */
+        /* QEMU/KVM hypercall */
         bql_lock();
-        r = s390_virtio_hypercall(env);
+        handle_diag_500(env_archcpu(env), GETPC());
         bql_unlock();
+        r = 0;
         break;
     case 0x44:
         /* yield */
-- 
2.47.1


