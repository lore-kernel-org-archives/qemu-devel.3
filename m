Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A12FA0C36
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 06:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCttx-0007rs-3k; Wed, 15 Apr 2026 02:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCttt-0007ra-Sj
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCttr-0007fQ-E2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776235135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TlUvblGUZFmpowKcYrdITWRBi4imocF9Ym6v0uJYyp0=;
 b=IghixYFUoxBL34KDOsaSezbNYCC3fOJI/8XbSMRV2K/WZ0QhHMDLWZn6r8hgHkaiLie6Fz
 MIJJIxV0iNacarX3LbbgSk0u1NrxC7a5JRW9c0qtQ2K1EyiNac8QCdNtswLVZWjcX0iQDD
 2sjV12H6vENrRRv8CprYc85rd5R7m8s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-rstIY0MsMqGXZWqKnUNZHw-1; Wed, 15 Apr 2026 02:38:54 -0400
X-MC-Unique: rstIY0MsMqGXZWqKnUNZHw-1
X-Mimecast-MFC-AGG-ID: rstIY0MsMqGXZWqKnUNZHw_1776235133
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358f058973fso6676243a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776235133; x=1776839933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TlUvblGUZFmpowKcYrdITWRBi4imocF9Ym6v0uJYyp0=;
 b=gSDrdWtHG1IVw7T6GD1SVoFrIMInC3zgdSH6DqoDreeW8pYi9MYkslp6apJ2JMuwxS
 nj41UVm4QY4nAJiXN7YUDkcMBQJRtdaXG/aTqf8DcLfWsgOu7RK5+gwDwh4stMIhdJcq
 TYTenQ7mf1RJVGY8F6saZgQLRuo31zWkh4bz4nlnLnIjgOyskJxu46eM+vnXd4ZneFE/
 +4QrasKifUiJGH5civICZx9gEzdCXdK/vvpzsKgmlwiCjz6eF8TMsay/6po1CpE/LbXv
 FZu5pfi7mdm5H0FJ+j447n8vxfcmw16NZrQAX+6Zl0SVgumS1J/J/VxwGXYnUFvgZsNE
 zzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776235133; x=1776839933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlUvblGUZFmpowKcYrdITWRBi4imocF9Ym6v0uJYyp0=;
 b=eOoK6eb14VRo/9AuXCLe0q+8nvGiwcHSEFaFWymxqB23TrUZ35dIRnA4Ja3L3MHJdw
 /LjnZOLWAgGXYRfOs0PPM3cuyG47Eh3DoywSO64neCb/Lxb5bVmgZ4lcgFO5SWdxxtkG
 gxa9IZaGxo3vGpx5Yay2z5nVHq5bgUb4KsTr2VNpIIM5JKPHJV0Z/igs8PQAbbskrtbY
 SlJiNsYwCwS8FE3XsSvBdNONX3eX/tlxp+TIejqjUTFl2ACRArvFaNatbqmqbv0aAJ1T
 o3ksb8d+CwTFUell4a/sp5K9kUn0K6REOGjGmf6QeX7qcYXeYMEVq4IMrzOkjtYvo8/T
 4s9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VufpyXZKnZXmf1Q6K1J7KQ2r6Shy0r4f5m4cY1MIQRiVNl3tSG/fcqhXBJX1vnQXYh0Kgl8mcXl7y@nongnu.org
X-Gm-Message-State: AOJu0YwMdxX6HqSbT10nvciQ/4vOWrBOypIiqRH9X3U0NFz9sGxGmf80
 IW0mFNzmk2KOnag8dFiMUmVzCBDrCzjTPpLL+cJmwwOfr/6G8qg7mxNIqTCRFoKI42t/VoEcQWH
 ooHeEZTfOTwh1cbbMRK0qxKVEw5aPjhu4++bmbclLTd4mwkCJi7xWrpPd
X-Gm-Gg: AeBDietSHc6Sf1FblEgmHy7QCxnX9dNr3ER624JwdKVpVffxqxxvn055LW+nnpMl8kU
 /wXPDmFLrVn9zyIgFpiaX83h8wIYRrstupKrtKPFJcM2eMCQu2PrUvZ2xfi0rbSt8BVBl9q3axx
 JK+3cveD5nG6+sXA+4XOfDpl8FNSIMr6+n5N+ySY5C5RPepkjKIgx92h3qgxnuqUAPykKBLYbxY
 Jx/TBK8RmWdAAEn2P3FQaBEnqKSiebC3Rmt6nVh8K+1HRN+aOnHsJGQsG33gqgdTCCiiB4/MWWT
 Ar6/J2diydlnkbF8v1Sm+7/4XYLaQYcG4koMsdmJ6uzKnJpaezMVElNbbsy8CWAriJIzUAMfcn+
 VYCzlbqe1ikfVfk2jfVaUDozym5fzVcBUS3ePuj03gzHZBrCTLXinCd63FNBzxyPjfE2vqgD/Ek
 lLnGUtDg==
X-Received: by 2002:a17:90b:2e8c:b0:35f:d56d:1c45 with SMTP id
 98e67ed59e1d1-35fd56d1c7emr382512a91.12.1776235133093; 
 Tue, 14 Apr 2026 23:38:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8c:b0:35f:d56d:1c45 with SMTP id
 98e67ed59e1d1-35fd56d1c7emr382485a91.12.1776235132490; 
 Tue, 14 Apr 2026 23:38:52 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fd07a972esm596362a91.4.2026.04.14.23.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:38:52 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, peter.maydell@linaro.org,
 philmd@linaro.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH for-11.1] accel/kvm: refactor and clean up
 do_kvm_irqchip_create
Date: Wed, 15 Apr 2026 12:08:35 +0530
Message-ID: <20260415063835.85540-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Refactor do_kvm_irqchip_create() so it has specific return codes for specific
cases. Clean up the logic and add some clarifying comments. Adjust the
function call logic accourdingly. Should be no material change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b..788cbf8693 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2575,6 +2575,13 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
+/**
+ * do_kvm_irqchip_create - create irqchip
+ * @s: The KVMState pointer
+ *
+ * Returns: -errno on fatal errors, 0 on success and
+ *          non-negative on non-fatal errors.
+ */
 static int do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
@@ -2583,32 +2590,34 @@ static int do_kvm_irqchip_create(KVMState *s)
     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
         ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
         if (ret < 0) {
-            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
-            exit(1);
+            error_report("Enable kernel irqchip failed: %s", strerror(-ret));
+            return ret;
         }
     } else {
-        return -EOPNOTSUPP;
+        /*
+         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP capabilities are
+         * present. We can't proceed. Bail.
+         */
+        return 1;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
-        fprintf(stderr, "kvm: irqfd not implemented\n");
-        exit(1);
-    }
+    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
 
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
-            error_report("Split IRQ chip mode not supported.");
-            exit(1);
-        } else {
-            ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
-        }
+        /*
+         * If we are here, it means we are going to do an in-kernel irqchip.
+         * Lets make sure that the kernel_irqchip_split setting is not set to
+         * split mode.
+         */
+        assert(s->kernel_irqchip_split != ON_OFF_AUTO_ON);
+        ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
     }
     if (ret < 0) {
-        fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
-        exit(1);
+        error_report("Create kernel irqchip failed: %s", strerror(-ret));
+        return ret;
     }
 
     return 0;
@@ -2616,9 +2625,13 @@ static int do_kvm_irqchip_create(KVMState *s)
 
 static void kvm_irqchip_create(KVMState *s)
 {
+    int ret;
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
-    if (do_kvm_irqchip_create(s) < 0) {
+    ret = do_kvm_irqchip_create(s);
+    assert(ret >= 0);
+    if (ret) {
+        /* required kvm capabilities missing, we can't proceed. */
         return;
     }
     kvm_kernel_irqchip = true;
@@ -2839,8 +2852,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
 
     if (s->kernel_irqchip_allowed) {
-        /* ignore return from this function */
-        do_kvm_irqchip_create(s);
+        assert(do_kvm_irqchip_create(s) >= 0);
     }
 
     /*
-- 
2.49.0


