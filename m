Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A957E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfzA-00050L-CF; Wed, 18 Feb 2026 06:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfye-0004Ff-5l
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyc-00087k-H3
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1nGeqoQ1o3VYpe1DNoWnGTiyMQ3GWu83ptlZVbrEhc=;
 b=JamQZVqq0v2AE1jmLEFxAPr+Tknx26d+SDGTeOMPsOJ09K/ri3qHonI8JF21oWu74j1GFz
 uGxtkGOrfdOOChQoP3j14ess3ytWv8jFnDiM0OVVmRpK/w5tftos1qlGTMzIVutR6PwzGX
 KopWAYhYUBGYoKlbB1DRINj5Z/QTiaY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-zDoGtpbgOj-R2SlMEW7uVQ-1; Wed, 18 Feb 2026 06:44:16 -0500
X-MC-Unique: zDoGtpbgOj-R2SlMEW7uVQ-1
X-Mimecast-MFC-AGG-ID: zDoGtpbgOj-R2SlMEW7uVQ_1771415055
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaeafeadbcso60782885ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415055; x=1772019855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1nGeqoQ1o3VYpe1DNoWnGTiyMQ3GWu83ptlZVbrEhc=;
 b=FFK9W6XOQE3TJqj0DPgkyDQMEoGBPrYtz1cabVZyiM7+YYR3oGUAJwqoBbhQhOr+jg
 88DfiDY3+q7NNsw/FCyjN+ix4lPa7ciz4dyYKEadf+EtTYmgBH3fnozPVPt1Xhjqvppa
 czmkkAbfFI2kGSHY7r5hEIwEUEtNvhfBdhjf/9BjN8O7tDGqMZVBS5JwTfIX2Ru/0Lcg
 yD7Yeuh6gO3MNxqxVLWVUSwZrBbn0hYmO3r2X3D4Ot5YMtFDsiVDbW6f4QqmMPCrpk6R
 UElb+bB2Tu2L9ZLgjP++xnTwpxcWphk3jCBiqgxCmuOKiZmOxabtsRl4QX4UiLG4sOYe
 sLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415055; x=1772019855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L1nGeqoQ1o3VYpe1DNoWnGTiyMQ3GWu83ptlZVbrEhc=;
 b=aVSKNpoLPPUQVg5oI2/L7MA3ewmVNK8qjTYXfzmyR2lSxwBjo5YQV0yqHhnF5i1B+d
 jgIW8O4X4EGbclpSigMbUy6useegbnFj7SQmRiilmITRAAN9XDO3rYwlwAB0hKq+UuUs
 SwuH9Xz9WG3lI19hi/y2YwFANB0Urxu3gpZmqSl8IKbP2FfwjOv9yyXUyLE+x531rfaY
 iRWw9LdU9jH9h9ZZBv5lBT0uqe4GpfxGBax6YtBtb7jTlNc+Q0ar13AMZhwSD0ZBmxyP
 GPIwdaNGqKu/DOHrX5S3UL3Nwni2hcnoGMXE6guILcudQcrJZ+qcj9NBdt2Yu37hE0ag
 apTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWfjFVPID6gMoRbkLTX6HqRq22SFb7f72+US8CIEMKMF252fBDUbkZ8A8nym9SHylFND5CPHu+qU9w@nongnu.org
X-Gm-Message-State: AOJu0YxOZB63txtSlwwnyS2OdNUkx57Bc6XE4fZdN+MaUVAA6sf7U3k8
 WgbRylsU5Iy7Hx2Avt1VqPg4NwmIJrKgabzICNIZUn8aVMtsG+7llc9EMcjFWUMAZwi3WS+FP77
 0jT9JWZ090wwrByI4tCiiQUsvBYshfJdKOdgGGbABv9b/BoEK2kp6rOCc
X-Gm-Gg: AZuq6aJaOdiqQSA7B7DjPIogv4sGmN4QfwumvBnIt1LAtmACyGelDRhf1iAjIDWvLbS
 cDQnbUOFYB7kDg+h6ABQ7sQpnBX5TtNuOA4aRWoXqD1M+4evyoDuJTYaSp6ugJJ9+L4+7DdGOnQ
 nFqUlE0YIASMg+buQLM/R7A8QUvSDkszxMidfgGuwcqTa48qy0t5VeDwjGVhxstOVfqtekIRP2d
 30xv1zgkN8iGlwllmzaI5kzpbjOfK3HEwUbAHr9XlIwr1QybOT9caIj3Z2UINAS8MHA0LOC1MNW
 MJh/vUEUPceR35xKXSyndkqvf6bThE3m7JzYAtgnfQ/83fK12lnCRnmq4tAYvhujt4Nj3hBK3Qq
 Xpsyhu+Xj6sW1A6MOWY0ZZtuH+NFbielknpb8OuZAsB5kaWuwz4kP
X-Received: by 2002:a17:903:2f8f:b0:29f:2b8a:d3d with SMTP id
 d9443c01a7336-2ab50525225mr157634535ad.4.1771415055511; 
 Wed, 18 Feb 2026 03:44:15 -0800 (PST)
X-Received: by 2002:a17:903:2f8f:b0:29f:2b8a:d3d with SMTP id
 d9443c01a7336-2ab50525225mr157634365ad.4.1771415055103; 
 Wed, 18 Feb 2026 03:44:15 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:14 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 29/34] kvm/vcpu: add notifiers to inform vcpu file
 descriptor change
Date: Wed, 18 Feb 2026 17:12:22 +0530
Message-ID: <20260218114233.266178-30-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

When new vcpu file descriptors are created and bound to the new kvm file
descriptor as a part of the confidential guest reset mechanism, various
subsystems needs to know about it. This change adds notifiers so that various
subsystems can take appropriate actions when vcpu fds change by registering
their handlers to this notifier.
Subsequent changes will register specific handlers to this notifier.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c    | 26 ++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c | 10 ++++++++++
 include/system/kvm.h   | 17 +++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7be39111bb..d7ea60f582 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,9 @@ static NotifierList kvm_irqchip_change_notifiers =
 static NotifierWithReturnList register_vmfd_changed_notifiers =
     NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_changed_notifiers);
 
+static NotifierWithReturnList register_vcpufd_changed_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vcpufd_changed_notifiers);
+
 static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
 static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
 static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
@@ -2314,6 +2317,22 @@ static int kvm_vmfd_change_notify(Error **errp)
                                             &vmfd_notifier, errp);
 }
 
+void kvm_vcpufd_add_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&register_vcpufd_changed_notifiers, n);
+}
+
+void kvm_vcpufd_remove_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+static int kvm_vcpufd_change_notify(Error **errp)
+{
+    return notifier_with_return_list_notify(&register_vcpufd_changed_notifiers,
+                                            &vmfd_notifier, errp);
+}
+
 int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
@@ -2838,6 +2857,13 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
     assert(!err);
 
+    /* notify everyone that vcpu fd has changed. */
+    ret = kvm_vcpufd_change_notify(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
     /* these can be only called after ram_block_rebind() */
     memory_listener_register(&kml->listener, &address_space_memory);
     memory_listener_register(&kvm_io_listener, &address_space_io);
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index a6e8a6e16c..c4617caac6 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -87,6 +87,16 @@ void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n)
 {
 }
 
+void kvm_vcpufd_add_change_notifier(NotifierWithReturn *n)
+{
+    return;
+}
+
+void kvm_vcpufd_remove_change_notifier(NotifierWithReturn *n)
+{
+    return;
+}
+
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
diff --git a/include/system/kvm.h b/include/system/kvm.h
index fbe23608a1..4b0e1b4ab1 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -590,4 +590,21 @@ void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
  */
 void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n);
 
+/**
+ * kvm_vcpufd_add_change_notifier - register a notifier to get notified when
+ * a KVM vcpu file descriptors changes as a part of the confidential guest
+ * "reset" process. Various subsystems should use this mechanism to take
+ * actions such as re-issuing vcpu ioctls as a part of setting up vcpu
+ * features.
+ * @n: notifier with return value.
+ */
+void kvm_vcpufd_add_change_notifier(NotifierWithReturn *n);
+
+/**
+ * kvm_vcpufd_remove_change_notifier - de-register a notifer previously
+ * registered with kvm_vcpufd_add_change_notifier call.
+ * @n: notifier that was previously registered.
+ */
+void kvm_vcpufd_remove_change_notifier(NotifierWithReturn *n);
+
 #endif
-- 
2.42.0


