Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8C2C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHw0-0006JO-Qf; Mon, 12 Jan 2026 08:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuZ-0004V8-6M
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuW-0003tE-WF
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34fJR3EaRP0lXjDv/gJjVEbigtGQPR0fffJidhYwq0M=;
 b=WekqduqARwYEpbVshm6B6lTmwG3+Hs7WNr06pC1joRLcwDp3phCpYejt6oA7ZZHcUMjO0y
 zDkKIwdYftIXnF24WiorRFZeWav/fOnpxAwrGg2h3UwepwSLScxa6VEsMzbxINGVjo+RXQ
 IFbY73E8etXN71fMQ23JScw7/q4PfJ4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-GWcljjK-OoO0Uf-79-ptnA-1; Mon, 12 Jan 2026 08:24:40 -0500
X-MC-Unique: GWcljjK-OoO0Uf-79-ptnA-1
X-Mimecast-MFC-AGG-ID: GWcljjK-OoO0Uf-79-ptnA_1768224279
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b471737e673so8554209a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224279; x=1768829079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34fJR3EaRP0lXjDv/gJjVEbigtGQPR0fffJidhYwq0M=;
 b=lIDL0PIbqQHENzABYtWMjyxdAdb8dvoEQQRakimoO8yL/fHFRTcdQnqgtJsfOMdgkX
 25KiFrfyLjm1hermrPJvVNgIhlTdyGzE6WUdG9SUl93I+Hz19UhYnBy2e/jZ+WiEb4LE
 ro9szOkk1rcHe+gkwrzvHvSEWxxC9JWiPhfGSkqQE1svRbmFxqjQWueoQs+CdX2k6pae
 jYvakHtE2mxTKJD0Y6NOW2OeHYIe0po5u7eO2Q4rGwXfO+IbTcbqAVGBM9/A4A8NGEjv
 pDzVoMMWkXuEkWxoL8biutBbIs5Gc9bOr6tZoP/00pXxejUP93gbKqppE3Vex9Q5qHtb
 IFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224279; x=1768829079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34fJR3EaRP0lXjDv/gJjVEbigtGQPR0fffJidhYwq0M=;
 b=u7Tx6ryW6GZ8B8fC/DGblefAqbJvwkoL+4mE/3t5jJemZ+1PtEDikbO6Y3ia5UYDgi
 72FkflL0MnFZsXFhkv3H4/OjlNY0/NXJoFr0hhMqDoyq8dlugaqKPaD64/tk4LqOTH+7
 ZJTgUw4WOX9Vl1waUfJqljqEtVg6wyxEwKLOyBrToP4M5Q0RFjWH7gdaA4j1znkogsWT
 K62+AWAR9MKv8cg94mN+E+tgIDuM15d/KDAYqM/z/Vay/5AVcNlz6VVwQJYnzAYuUU4u
 E5PkRyO+iS1Guv/HSwsCDAjZG8JfwKGrHoYYiXGfdBj0Lt1oqoLD8pn6Yp8LR3x3P8If
 fnUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6rChpNADc8oWNOkUzwXqu8HUQEv7bPvct52GpnQGv6zYa6oHpAXgoDjxoDC/aSpxET6JuUEnMyilx@nongnu.org
X-Gm-Message-State: AOJu0Yxa4LaC5Y52vqcq9UtUHL2w/7/H24+YGPCUBLwZbSQc3hjHVA6o
 YA7Nhzni20vHI44HXBQX2xRlYSpy5i5bREW1mn7zvNpWLf5iLDQawLLdkO8AivdKVhGJBeUfUcd
 qLTi0GW18uTib9nDJbsk2116H7hctIoqXcMZ2ZKoP+zw3z+t3JlM3GLO6
X-Gm-Gg: AY/fxX7WA2LylIQ4lMR+BNEJjYJckD5nKiXDAI1gHfPgrGkH1PRZt60xGUSJU5Vdtjo
 9XIqOhGIYF3HSa+GHoAgXRAh/AJG4O9bUuUtd9lRH7RwbXc/aBPNbQUI1vr+aJfKAELz2rs4Joo
 e2q2uouaWj9S6ok3+QhmqrncYJlypcVJvAEICUtp8AyzTpkboNGRTfyqsle6dBd9LegrYSkJ2Do
 URU3vGv8HLJbxim9X8e3CRb3Vh31mPhbXYjL831pHsoEU5SvgmzU2t7UTmh1CQu9dycEA3Tn5cW
 BBTZzJbFmYZhRix/jFGeZspBe+ZcRIOYFL4s4HBJ8yJ+mw5pDQy1QQ6SHAnh4k4Zbye14wAxsFq
 Hcaq3erxx/KcV2vIYTVYtQKmGJdehEyWbAz/2WNAiEBA=
X-Received: by 2002:a05:6a20:7d9f:b0:350:7d78:18d9 with SMTP id
 adf61e73a8af0-3898f90887dmr15164015637.32.1768224279170; 
 Mon, 12 Jan 2026 05:24:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIt8GOnuhdYsXeV1HU+lkzI4cU54UMzoMp+l9q2VHcfA0UCoD8L3XqEJJR5fHmm3onZd1kpA==
X-Received: by 2002:a05:6a20:7d9f:b0:350:7d78:18d9 with SMTP id
 adf61e73a8af0-3898f90887dmr15164000637.32.1768224278747; 
 Mon, 12 Jan 2026 05:24:38 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:38 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 28/32] kvm/vcpu: add notifiers to inform vcpu file
 descriptor change
Date: Mon, 12 Jan 2026 18:52:41 +0530
Message-ID: <20260112132259.76855-29-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
index 2bd4dcd43b..efdfdf0ccb 100644
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
@@ -2328,6 +2330,22 @@ void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n)
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
@@ -2858,6 +2876,13 @@ static int kvm_reset_vmfd(MachineState *ms)
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
index edc3fa5004..120b77d039 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -587,6 +587,23 @@ void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
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


