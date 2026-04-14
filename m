Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5C0F34C7E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 05:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCVsT-0006xd-BN; Tue, 14 Apr 2026 00:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCVsN-0006x0-0g
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 00:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCVsL-00034R-0M
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 00:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776142787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hJZy2UscdG/YlP+O1GnZDMkC3Cg3TXz5lN5hulBLqC0=;
 b=HOCUaB1L0W3LQtVyOpIwelZ8XD2cFD3Ql8ZRplNthIkrE5TM4PMe5kC0ueGJr2RB0WdTfr
 cs61ueckkqCCpvJjnqo5zH67A1VGwu2LkHJHlnDb1S7Xo7oaydPdaUsEMNpZLTUC7wku4v
 a/XTaGA8NJoglY6B3LgnoRlatksDOT0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-kxe_pjRvPUabgERRjyU3Jw-1; Tue, 14 Apr 2026 00:59:45 -0400
X-MC-Unique: kxe_pjRvPUabgERRjyU3Jw-1
X-Mimecast-MFC-AGG-ID: kxe_pjRvPUabgERRjyU3Jw_1776142785
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2d83e7461so64045305ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776142784; x=1776747584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hJZy2UscdG/YlP+O1GnZDMkC3Cg3TXz5lN5hulBLqC0=;
 b=J8v3ZYg0rfX9h8iBVjVsCDuRly/gqKmNTWaMVE9HG1lfa6OPrdRtlYvA2ED5T9+5MH
 0MtyjQdQhmj+9m8dVVkcgG4XTQxxhXeQX+uVCMnj76Oo2jWKv2ClcxVUh0v2dz/nLX9h
 XeW6VAJgVnRgu04Cf0sA51m2BLaxHEroJaAmns+y/GH78fCZ2P7nal3J8eIWfJ1PHxyt
 WkpJYeWezkSACQ9iYJyjPBlPl4AJ/ug68P3RRtzM6QDv+tD9f90kl1L5Muu9XWAWK5HC
 e7o8iABDKiL+BhvbJg2Bp7PytHnlwYAlo4OGYd/cJ3gWVe9Jdk5wrWeYpMUIxgW238MA
 b/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776142784; x=1776747584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJZy2UscdG/YlP+O1GnZDMkC3Cg3TXz5lN5hulBLqC0=;
 b=LPff+AEqYYNjwuW09pREk4sveXzlBhwIEQarKG9yK38jRtYWflj1zUAWldYKuU77eW
 zp44Y9yaO3NsRzOZeIbpnOvZ/RsxZRDuDmfJKjWtQFfGipjDKLtMt/rpAVvx7rUZyHwi
 kUHCcOmO8CmzOjCsRGuuqrH8ClLUhWNtTF6sAvG0lm2j4RbFBw6OUbfStDwck7r62rtB
 KfRxyO0T/XH5Ek0l27Ch3yc35BV0e1HEe+Cay9F0o37V6AAGT5AizUEPzev+KkVC7hBr
 OwsiT33/l3yluIARCadMzSwleT1woftCqtyQEkkAof5i726pJ80FQ1yc8OAGv9xXGe31
 0QJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jr+GJ7fRjp1/KbfTILZQ+C3WaY4ItiqoBe6yQX0T8tLSMmF7NxHuolUxd02yyaGCBbS7xlwy3pPi2@nongnu.org
X-Gm-Message-State: AOJu0Yw1yEY2c3/CguMlsgME4wo8fa/ZDW7I3xgP9BZPwLk7dvhHfCwv
 bcKKFYS1PENRxa7+wgxbCKbzMN2XoY7mZI+quI8mRmg/a0STfxzXskJTDwsv29/+dMS2veYswkZ
 VSkbwQxHb5WMGe2QtY5E+IjDDvT3FKXBMRDjSHLQWLW5hGhgEeVRD3Re9
X-Gm-Gg: AeBDievBFgL/vRhvny1xZjTPovV1eklSoj3bBhNMMTfdpEbgpsoFGvHpXBWV1OpsNbV
 2b8EddNRI+nRBKullKanraOnqWsparYgAK8BgGwcBEuSIklxJuJAFTGSGmrA0ktwO7EHSZ8Ggb5
 v8uYJ3eNmwviHm2CeYWRzwXhOppQXV89oUx4ZzN38ufecLAhfTES6B9lZ5JB25ZUa+24JUKURSK
 criycpXeTX1Ip71sT93UDRPmmWM72vLlSXOJAnbcgB8dhO022mxCUWVxhqQHCG6cO15ykcR/bh+
 WT1GsBSvcsXaRZQQ9PuFG9te7mu/jA3KE3Tb9TjBSqz8J27d7NckbImB1ys0I7yCfuNbnx/KY4Q
 3PX+DAYCKP2UKjNJST68x9sUubh8W7YftZuRsYpE5ngv0xEh6+NllcckoSAnyxDu21i/JNDrATc
 d/K9Dt1g==
X-Received: by 2002:a17:903:38cc:b0:2b0:60f1:de58 with SMTP id
 d9443c01a7336-2b2d5a95893mr166867915ad.45.1776142784470; 
 Mon, 13 Apr 2026 21:59:44 -0700 (PDT)
X-Received: by 2002:a17:903:38cc:b0:2b0:60f1:de58 with SMTP id
 d9443c01a7336-2b2d5a95893mr166867635ad.45.1776142783844; 
 Mon, 13 Apr 2026 21:59:43 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b2d4f25df6sm137413715ad.56.2026.04.13.21.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 21:59:43 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH for-11.0 v3] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
Date: Tue, 14 Apr 2026 10:29:11 +0530
Message-ID: <20260414045911.63662-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

During refactoring of kvm_irqchip_create(), the refactored code was returning
early from do_kvm_irqchip_create() function if the required essential
capabilities were not present in KVM. This was not translating to an early
return from kvm_irqchip_create() as was the case before refactoring.
This is because, do_kvm_irqchip_create() did not have a means to notify the
caller of the lack of required kvm capabilities. Fix this by making
do_notify_irqchip_create() return EOPNOTSUPP error when  capabilities
are absent and then the caller can check the return code and return early.

Due to this regression during refactoring, all KVM guests on ppc64le hang
immediately during startup and this completely breaks all functionality on
that platform.

Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

changelogs:
v2: refactoring included which will resubmitted again for 11.1
v3: basically v1 with tags added.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f..92af42503b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void do_kvm_irqchip_create(KVMState *s)
+static int do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
@@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
             exit(1);
         }
     } else {
-        return;
+        return -EOPNOTSUPP;
     }
 
     if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
@@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
         fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
         exit(1);
     }
+
+    return 0;
 }
 
 static void kvm_irqchip_create(KVMState *s)
 {
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
-    do_kvm_irqchip_create(s);
+    if (do_kvm_irqchip_create(s) < 0) {
+        return;
+    }
     kvm_kernel_irqchip = true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)
@@ -2835,6 +2839,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
 
     if (s->kernel_irqchip_allowed) {
+        /* ignore return from this function */
         do_kvm_irqchip_create(s);
     }
 
-- 
2.49.0


