Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E636D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbT4-0000io-4n; Tue, 27 Jan 2026 00:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSs-0000O7-40
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSq-0000GO-I5
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEDYSbwkzm3iHaRebY1agUkwYGBShvhOSyrbmVbxi+E=;
 b=NSmF2WtoDzFNkLlYBlxMO4jdNanTDMOAAEh+GarGE++ZPoaPYHhd5TWUnfGj7cmxV4FwoA
 RSJurzqZgtCVx2YGDveTajXnQxjNGP1tNslJrQk4SiRDh7IQWsSNE4LLGLNWJg8NNPAFXf
 l2FrUdy8RsvpANe0AUO0SfQRPdFSFSA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-vjIktgAGPqqzwq3W8CWrrg-1; Tue, 27 Jan 2026 00:18:02 -0500
X-MC-Unique: vjIktgAGPqqzwq3W8CWrrg-1
X-Mimecast-MFC-AGG-ID: vjIktgAGPqqzwq3W8CWrrg_1769491082
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c551e6fe4b4so3222326a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491082; x=1770095882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEDYSbwkzm3iHaRebY1agUkwYGBShvhOSyrbmVbxi+E=;
 b=M/6S+u2I6ixp39BY04vOZ/wbT7vHfGd8krHEDza90nrN/w3jct5hED7dMYy+Fje/Y2
 BYMLABDolPGC5N0vAebGGKZjG7a3Ditx107vFlva039HE27UKZ5k5T7UhZTHmlgIbLQm
 8/kEuUvqARp7kkkbtE3zk+1SGYeB6Jo/418Sme3p0eXQutaWvDrc8uYb3rgX3/E6GqIY
 pR+Rxm1tw9ppK4FqV1fAByILqBW7xcUmfPOpzVlIzQP8GFj018mZjQsPhtL99Zp1mD7L
 daaaZ90yOemQaaMYeTKGepZqn1EENTnBthmRIzZSenf25nybVRdpCbCbK5dYXQMqPwwg
 yzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491082; x=1770095882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bEDYSbwkzm3iHaRebY1agUkwYGBShvhOSyrbmVbxi+E=;
 b=NlE73csoLZW7YBdo5yRsfRJCLo0xJbRTdYU06zHtik2Vi3ZKs1rt95T94R0yT23kXP
 IJ2i4pFKzpiz81V+sBQqLel+lBBauuiCjivwQRHaCDfJx/CH3YYr27n8OjRkDfD1g837
 +qZmSxstFVyjpb/obuAosP8zk71Oum9Hi2DJSiVeq3SvwkbGQtBMXv4PJOE3SMq4+Ose
 GOfA/r46KXCLc9pC/+fYFhE/pcWM0Fea5D7A36qcarN6NRr6g2hY3xwE9W80nMejkKHA
 YCFueWNOaY0skn/dKFOMFrkAj4pdcwLPuknGaGNAZSvz1+vDG8t5CUhEs7jhnXzjEjHC
 DH3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf4F7FT6O3+sBd0mieYQSl8PDG7kcms4slbE13E6LzjYEWL+ZvPL1/AeUKG153nmAAGvBq1qLKJrQ1@nongnu.org
X-Gm-Message-State: AOJu0Yzl8l4euN2bB+LFgWOriH/1z8xZkJPUzsEruBcTRvX5BGib7dAs
 xlLzPb+XwbqDNQdhyEYcK55ViG/bLptszbw9BcGKMY78cscPVQQz3HgpB9H5PCq6bbepP/l1TJj
 +otzCjrbjlPvphhkQc2rwQateIbbiv9ZQACSnnw9vOr/HgejQgq6e6LOv
X-Gm-Gg: AZuq6aInBO7why8wq0qwnXQqvpesXj5SUI3Yw7YeOBNbyPIyPOK5aZ5+VXGci/yZfL9
 ByXp9yK42DbOKh5RLOISuRlq9sx4nlLADLkY5tYJbj9cf+E+F/qXwOI8sf41hM8/lb0Blzm+Yp/
 hum2EV84W6h4Cla7d2RRH+3q/FkZ8BXeT2S6HxQ+XBnpFzqzG03MFxAqblAkukCovHBu4wVIvRK
 ps/i5zS9CzrG/M98DK9dscT8VUxAgssvWynoFVDmPduFr9zx2APjBF5CGMoo8nI0a5zQqjQLAhI
 K5lYUhw6H8sl19AvdQ9b697g2E3knAWZ+8u0J3V30NUig0jGzHE4J8RRJl7jJRfX/CFCOGXb0iI
 snqVKqNXFbb0fgZb+Ty3ky+kTAX1RZ3p49GOBJkeKIA==
X-Received: by 2002:a05:6a20:918e:b0:366:18b3:85c3 with SMTP id
 adf61e73a8af0-38ec62899cdmr496036637.1.1769491081806; 
 Mon, 26 Jan 2026 21:18:01 -0800 (PST)
X-Received: by 2002:a05:6a20:918e:b0:366:18b3:85c3 with SMTP id
 adf61e73a8af0-38ec62899cdmr496015637.1.1769491081377; 
 Mon, 26 Jan 2026 21:18:01 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:18:01 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 29/33] kvm/vcpu: add notifiers to inform vcpu file
 descriptor change
Date: Tue, 27 Jan 2026 10:45:57 +0530
Message-ID: <20260127051612.219475-30-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index d43a363488..a28b0edade 100644
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
@@ -2313,6 +2316,22 @@ static int kvm_vmfd_change_notify(Error **errp)
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
@@ -2840,6 +2859,13 @@ static int kvm_reset_vmfd(MachineState *ms)
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
index a17cd368ca..8265d0ff4e 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -589,4 +589,21 @@ void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
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


