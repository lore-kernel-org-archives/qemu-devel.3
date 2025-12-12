Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F656D49236
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4if-0004We-Au; Fri, 12 Dec 2025 10:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iS-0004Oy-Gh
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iQ-0006Kq-C4
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MC5lbXLd3guV2ptWnUpo8dxa+q+3ySAOJ4x29/7bkmQ=;
 b=CdF/OJc+jhD4cnkMDXUICDOxkgRW23Bc1apaKrxoXYgOM0G6qfqoUJ3fOoZvZk9ZZ9S7bk
 45LguYGfeUa8hDChOl8bpShmagRcrnHknKAkk0smh0p9SqRntrUXF1fam3HgwbOq1b3Xkn
 VjhNV9Lzb1FXe4QtFepIfmVNjQvkXAY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-D6dve7OdOoGsGWYlBGVlug-1; Fri, 12 Dec 2025 10:05:52 -0500
X-MC-Unique: D6dve7OdOoGsGWYlBGVlug-1
X-Mimecast-MFC-AGG-ID: D6dve7OdOoGsGWYlBGVlug_1765551951
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29f29ae883bso7084305ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551951; x=1766156751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MC5lbXLd3guV2ptWnUpo8dxa+q+3ySAOJ4x29/7bkmQ=;
 b=LpEO3i1Ru6i6BiEUv2ml7OfRGc970gX/QzgZYCJBYgZWMwnwUK7OWNYJjBwMzWzyds
 aHXhcIqMs5Lr6pSTf3NuQUmIf+APArmt3dwBgWrsE2nuzAEsokcLpKgucckGR2meWAWq
 ofss1N7Ox3Lte7TnnqgSoZc8nxCqOzC62dp6kHunQ/4PSeEGegahUArOwq8mBgjH749n
 Rsc4JdDr9q+gGhkDQSkZIi02ckZkrXy2FaYKpjFRsI/xjWs6ti00DpzetwgtPTsNTRhL
 HKWceJ6o7OBk24DMLt+xvva7WhSplJ94WS/+LLhWJyIgUTUBcTJZrcjsipBMDv30tMa/
 BENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551951; x=1766156751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MC5lbXLd3guV2ptWnUpo8dxa+q+3ySAOJ4x29/7bkmQ=;
 b=aRq3SfZk28BGOQ9QOwYDw4gdqT2qjqN6na3zM/2fSOPoJTZVL5Q8H5tOb2z/BoC5lR
 4pQobMaXpnt5efE++aEYFYeE92zH2zsC4GmlRZOGq7Z/m7CX4JL8+4A0EGwFswOZSIcd
 y3NPLNgNFQ7neQesqAVgPUZCCOBscEvgi05BTbjNiwEJoTFkYTnbT/GAfW1Jm23om/ty
 XP9gyn6qJcAJFNT3/BOejvEeUkWcgZm6lEQIj6VpJjcWVx+8PKcOI+BO9Dxcy7fuonuI
 T0pRb+YVr7U+jVhCKjnl9Tf8ChsGkTmI5tKkDMV9VeyTR4uUCuwL2lP8cQxMWfgRC2K5
 JgPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkFDjoQdP8strawO99d5x0ZFTQjK/P2MgNYpkCj2gp34+dTG/R5jwSdyiosHsJpJ0Bg5xu38ELrX/z@nongnu.org
X-Gm-Message-State: AOJu0Yww8iSl5Z8cGXB6fYsHTifpn9PmoOMOf5O8nOh7jv3ZucRD/9mP
 9ceM5L/6/DzSpTG1brMmN0EGkDZtUo62iIfTSyXXTinXGx12EQL4tWLWjZWgFmK2hXVdobFmirF
 PVhkk+e55vXcuZLytD9KkoKZ7/Hm+4Vv8AXwmUNbes5GYHTFzPLIg4eq1
X-Gm-Gg: AY/fxX6zhbO96dq46kweRe9/syTY6EBpCf45HtnjuEdAQ6o/ljc+QPtDJlmVhrJgez6
 A2Cc3TdA7+5HITJFoPE3FaBHPasEt9Uu7QxrXQxkYi4i+Rl2uM7OuKiaa32m/0+8aUZo8DQTb24
 CtXhDzDjwHx93qFADtUywPY869CnBK5NHACm5H+iX79wW4hwxZQgnYWU/jhjwCoMmCWzL3Lk8h0
 KHfJVsdc9LWLXwvag7+pFwcaCRNblzpGXgqFqf+YdLc2Nn20q4crR5+RdPpgosE565E4imsjZ2C
 K0k544W49Ca5GLTrLKhlExytuMv1iqtHSb6oBjA/lSIX9SMY/Q09RKjOCo45+iLYyKyU2wWErED
 RBpmWbZ8OR8R69esGvSLfvu84bdZQkW/rjEa9WlUJNzg=
X-Received: by 2002:a17:903:2ecc:b0:295:592e:7633 with SMTP id
 d9443c01a7336-29f26eb34ddmr23525605ad.29.1765551950898; 
 Fri, 12 Dec 2025 07:05:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFINyFysyaG3Z7M7nKx2uV1+TcX6mLN4/JurQM2jroBzGQCP/c1s4YHv6IamP+nxOelN0SRRw==
X-Received: by 2002:a17:903:2ecc:b0:295:592e:7633 with SMTP id
 d9443c01a7336-29f26eb34ddmr23525245ad.29.1765551950285; 
 Fri, 12 Dec 2025 07:05:50 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:50 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 26/28] kvm/vcpu: add notifiers to inform vcpu file
 descriptor change
Date: Fri, 12 Dec 2025 20:33:54 +0530
Message-ID: <20251212150359.548787-27-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When new vcpu file descriptors are created and bound to the new kvm file
descriptor as a part of the confidential guest reset mechanism, various
subsystems needs to know about it. This change adds notifiers so that various
subsystems can take appropriate actions when vcpu fds change by registering
their handlers to this notifier.
Subsequent changes will register specific handlers to this notifier.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c    | 27 ++++++++++++++++++++++++++-
 accel/stubs/kvm-stub.c | 10 ++++++++++
 include/system/kvm.h   | 17 +++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 638f193626..7f9c0d454a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -130,8 +130,10 @@ static NotifierWithReturnList register_vmfd_changed_notifiers =
 static NotifierWithReturnList register_vmfd_pre_change_notifiers =
     NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_pre_change_notifiers);
 
-static int kvm_rebind_vcpus(Error **errp);
+static NotifierWithReturnList register_vcpufd_changed_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vcpufd_changed_notifiers);
 
+static int kvm_rebind_vcpus(Error **errp);
 static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
 static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
 static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
@@ -2327,6 +2329,22 @@ void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n)
     notifier_with_return_remove(n);
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
 static int kvm_vmfd_pre_change_notify(Error **errp)
 {
     return notifier_with_return_list_notify(&register_vmfd_pre_change_notifiers,
@@ -2847,6 +2865,13 @@ static int kvm_reset_vmfd(MachineState *ms)
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
index 7f4e3c4050..5b94f3dc3c 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -95,6 +95,16 @@ void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n)
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
index cb5db9ff67..bfd09e70a0 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -586,6 +586,23 @@ void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
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
 /**
  * kvm_vmfd_add_pre_change_notifier - register a notifier to get notified when
  * kvm vm file descriptor is about to be changed as a part of the confidential
-- 
2.42.0


