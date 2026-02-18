Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEA9E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxq-0003IY-NM; Wed, 18 Feb 2026 06:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxf-0003Cr-8U
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxZ-0007oa-CZ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7naDHCFXgwP8XzpSDjukvbV97EdMlpxxQpX15TgIFY=;
 b=XpTQ3VJ+sKuN8cLbRyvUFchVBXvmdDO8Id7etJejyTMls2/WSd9YkGJ6YveaOXL1LQaUBO
 osDGavX4ysX40uMy3r9EXJiXCFmsPJjUb3LgPeHxZVmvBaCNRqn5uH+BkBlmoBM9zz00YG
 jNMEegALXQgGWSmqr7TpRrSqUeTrAxI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-qSHzHDzNOKGNxvHKG8HwoA-1; Wed, 18 Feb 2026 06:43:06 -0500
X-MC-Unique: qSHzHDzNOKGNxvHKG8HwoA-1
X-Mimecast-MFC-AGG-ID: qSHzHDzNOKGNxvHKG8HwoA_1771414985
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a75ed2f89dso62612165ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414985; x=1772019785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7naDHCFXgwP8XzpSDjukvbV97EdMlpxxQpX15TgIFY=;
 b=Ame7wnQTfOuW165PhOXSSng8TvUXdTLbdi9DNisz7HgmvhLd7Nd2HLTb9oXWJMvpAV
 faUVGkLHtEDVy0iRiYcy2pZ7+KJJBOzIEEFJtBoLL+qFzvbuAKQ6RlxwyvRElpdaCVAf
 WgSTd3UEOwNhjrodYl4K4ZXhzhOmnxuNW5tC4pp8tKVETcXptBeY9wbjDakJ5fexoD+Q
 YkbHEbg9Em7hEskhWgD+H9SJLy3Vf9w060XtleC8fadSavT8C1xeMSHjC6qUTv4S7H89
 vItrl2U6njPn/1qqLX5Fs1yQXqXJKL2Amu7tnPyBIZgT5fHjqiJFgoxuZwg4ge3XUbwr
 06Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414985; x=1772019785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g7naDHCFXgwP8XzpSDjukvbV97EdMlpxxQpX15TgIFY=;
 b=UkAFgQ3N0QBSZY8+wLCPj4p98NPydpO0ew38OptQtd+AX2BiE7EwsUg0P51MN8AQ2d
 0rGl6qd8nKCoBRwDSPCNo8CWpEFgBbPB0fVz/HazkeMkWNfdmvGivwIX814asi/snBvM
 c89SyPzRRfSmyw2UFRJ6Kn5FsBrD6ztQsxom59AOVBVYmdDwWZyfyylRBuut4vRep33o
 wDEW4PKC5sFkG7JcfsbxdndI7zMzbagr8tDC0MdwOclM+YbBUEM6mGTTyK4fZK1encxk
 RNXqeHkMVUqxPVLNgRXb6wnGdwtT8D+zKy4zge0pYDyiGOcG0GK70cOa8NRKXqD0zXlF
 WLfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9SLE6UwxZgRC+cguzThphWiN3N2HJvTnkC+4GuGnIAUR8YcBWJe4yQCuYutr5zamJfNtauv39RlTJ@nongnu.org
X-Gm-Message-State: AOJu0YwuDKnPAJSvY7/gJOXrfjKwqQERpH4SwcLym+JIXUcJ64S+03/m
 sj/UgsClUqScSMstdqhyYYm/AqZmqOH/Ver3RyCaxgpc3s5X6aQnVeK3/8lpCwbj3URWqBJ5zxW
 tiDgiE79LQ1u6YCd1Tb55vyVvROIu0iKAyEJ830oWQijYokbstjl/tYka
X-Gm-Gg: AZuq6aKiySFoqweZcdbK2iEgLt0PGf5iPQgKUuqnFJtPkMGe5riR7pvxAoz+/V2twz+
 /xFBY0S/MkYm9gv6rSfMHu2fzb8dzz+G9aR65w+tbWPP8j1QHU6P8DXmbeCyQd76NtfLHP+85k1
 e3KtO8JKrWhFKk0ST+bFMjDOiP4Mq7hWLlSgifRpmVoFKus79xrlSMep0l6t83zG2UOoUvQHG3x
 9iII6R9kmqrVVxCHtFZR0/ZrtLicuEG4B3DhFcrvMNjV+ckNkUgnfoNEwEKW/evNpNkiHYlT2a8
 /Geu7yrq6Q/9PKAypCw6n5txhcPL3jGf5YI2lyPDycnerWZJUrwwdT8zOak9BQ5l3dELkYCOnu6
 rY0mDqK0DSlEWS7egdOTWj4flZL44S7KXlTa54uEef79p/G4SMv46
X-Received: by 2002:a17:902:d2cd:b0:2a0:c58b:ed6 with SMTP id
 d9443c01a7336-2ad174dcf1amr148038305ad.29.1771414985142; 
 Wed, 18 Feb 2026 03:43:05 -0800 (PST)
X-Received: by 2002:a17:902:d2cd:b0:2a0:c58b:ed6 with SMTP id
 d9443c01a7336-2ad174dcf1amr148037915ad.29.1771414984274; 
 Wed, 18 Feb 2026 03:43:04 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:03 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 06/34] accel/kvm: add a notifier to indicate KVM VM file
 descriptor has changed
Date: Wed, 18 Feb 2026 17:11:59 +0530
Message-ID: <20260218114233.266178-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A notifier callback can be used by various subsystems to perform actions when
KVM file descriptor for a virtual machine changes as a part of confidential
guest reset process. This change adds this notifier mechanism. Subsequent
patches will add specific implementations for various notifier callbacks
corresponding to various subsystems that need to take action when KVM VM file
descriptor changed.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c    | 30 ++++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c |  8 ++++++++
 include/system/kvm.h   | 21 +++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 14729666a0..b8a0685f7a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -90,6 +90,7 @@ struct KVMParkedVcpu {
 };
 
 KVMState *kvm_state;
+VmfdChangeNotifier vmfd_notifier;
 bool kvm_kernel_irqchip;
 bool kvm_split_irqchip;
 bool kvm_async_interrupts_allowed;
@@ -123,6 +124,9 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
 static NotifierList kvm_irqchip_change_notifiers =
     NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
 
+static NotifierWithReturnList register_vmfd_changed_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_changed_notifiers);
+
 struct KVMResampleFd {
     int gsi;
     EventNotifier *resample_event;
@@ -2173,6 +2177,22 @@ void kvm_irqchip_change_notify(void)
     notifier_list_notify(&kvm_irqchip_change_notifiers, NULL);
 }
 
+void kvm_vmfd_add_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&register_vmfd_changed_notifiers, n);
+}
+
+void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+static int kvm_vmfd_change_notify(Error **errp)
+{
+    return notifier_with_return_list_notify(&register_vmfd_changed_notifiers,
+                                            &vmfd_notifier, errp);
+}
+
 int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
@@ -2668,6 +2688,16 @@ static int kvm_reset_vmfd(MachineState *ms)
         do_kvm_irqchip_create(s);
     }
 
+    /*
+     * notify everyone that vmfd has changed.
+     */
+    vmfd_notifier.vmfd = s->vmfd;
+    ret = kvm_vmfd_change_notify(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
     /* these can be only called after ram_block_rebind() */
     memory_listener_register(&kml->listener, &address_space_memory);
     memory_listener_register(&kvm_io_listener, &address_space_io);
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 68cd33ba97..a6e8a6e16c 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -79,6 +79,14 @@ void kvm_irqchip_change_notify(void)
 {
 }
 
+void kvm_vmfd_add_change_notifier(NotifierWithReturn *n)
+{
+}
+
+void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n)
+{
+}
+
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fc7251fd9..f11729f432 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -181,6 +181,7 @@ DECLARE_INSTANCE_CHECKER(KVMState, KVM_STATE,
 
 extern KVMState *kvm_state;
 typedef struct Notifier Notifier;
+typedef struct NotifierWithReturn NotifierWithReturn;
 
 typedef struct KVMRouteChange {
      KVMState *s;
@@ -567,4 +568,24 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
+/* argument to vmfd change notifier */
+typedef struct VmfdChangeNotifier {
+    int vmfd;
+} VmfdChangeNotifier;
+
+/**
+ * kvm_vmfd_add_change_notifier - register a notifier to get notified when
+ * a KVM vm file descriptor changes as a part of the confidential guest "reset"
+ * process. Various subsystems should use this mechanism to take actions such
+ * as creating new fds against this new vm file descriptor.
+ * @n: notifier with return value.
+ */
+void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
+/**
+ * kvm_vmfd_remove_change_notifier - de-register a notifer previously
+ * registered with kvm_vmfd_add_change_notifier call.
+ * @n: notifier that was previously registered.
+ */
+void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n);
+
 #endif
-- 
2.42.0


