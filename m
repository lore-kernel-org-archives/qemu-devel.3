Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5063EC9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuE-0003Ij-C1; Mon, 12 Jan 2026 08:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtc-0002jo-Um
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHta-0003iL-VR
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lPuM56addYmauPE+CYUQ8UQqZP2E6PELtzBhAc/1xHg=;
 b=XUHa1LyZM/QCDf6UqTGUTAKbsMgaKNFLPAiVFm+riFEwvCO2eKcNTGRK/dYChPHyoCrtL1
 KXlXF0I6f/b3bkcss4IuRQ1DoW3Fa7PK/LgvauzAgVi4ubH5BZKFoci3l4/jBw8HS1kc1G
 gmWwafZLNvYp0Ew65VZPVFLJUVkdZRs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-2_w4WIYbPkG-ayPXtNloww-1; Mon, 12 Jan 2026 08:23:44 -0500
X-MC-Unique: 2_w4WIYbPkG-ayPXtNloww-1
X-Mimecast-MFC-AGG-ID: 2_w4WIYbPkG-ayPXtNloww_1768224223
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c52d37d346dso2255730a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224223; x=1768829023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPuM56addYmauPE+CYUQ8UQqZP2E6PELtzBhAc/1xHg=;
 b=YYjWs41BbOZfAAnp4NCF+s0dnzil09zlZM1RiuYRZC/unBTkDOy9lLM8cu0edb7vmI
 2A6B85s7bbs/s4sKHtwgdrG3dM0zucN+ZtRXi+/eWh1LR8CNVC7lUWxUaJ450+1kE+Ld
 32vfS0m+zJ2vi+BIM6YTkHJR35SA15+TKag32nYwaZ/QxxGVf3taFtLdQTx7zgnbhtdN
 hxDM0m61mB3VXOjqQCK+jVi1YyeM/hanhNW11TCofclzENC/K4HHHbfDiYi0eI2u67+P
 ynuR0c/rvGLORb/qRh/PVpkrupYTUHy8fFL+4scUYE6cFZoPwmIR78jSx+LgbuCJRl7n
 z28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224223; x=1768829023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lPuM56addYmauPE+CYUQ8UQqZP2E6PELtzBhAc/1xHg=;
 b=raMw75MdAkqznUzZ82p3ltA4DtY+C88H6VqxYp1cMj3tmEbMDgUJQJ0/8fiyo12UeL
 WkEBIkeMq2dQXZDkeUZAdsP6/TFHdx7kC/ooVq2Pafl/u7pYkkiqOhOD5G4qKG1tOqAs
 TABRv7H5Mk/ZLP40+M5cmgXqKUPaFVvtxsoy9s51TWmCbBWW5gPbpnZGaAZWlErzN2kx
 W2pfcN6RgOCnQ+ufNZpZuMR0lParyETWTCNop1ynvWhTwL8sjqjZzix+5hm+DMQTsSr6
 9KI3RMSdv1ycX/DAqzBZ8IIv4vgWAMpNPlF9bbtv6dP2s2vgIUfgaaL9l02nE6fqQzAj
 mexA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsiJx5xGPn9E8zt4pURVnQb+BmPtw8Y5KlFJbqFoiaj+j0tuH8ACC68nqo52ZBcMo3Lw+Ni5iLTkOy@nongnu.org
X-Gm-Message-State: AOJu0YxZfD5credZIW80zCwhDYmbiDjgYE0pIqIC3qo1ppVQ60T+dRlC
 jnOALtK61Cja2Ec2vqyV2yOusx76EfsmgLd4zTa7mnZa3twd6mFsfR5iuYDPiHdVWPTEVOWVIFC
 qcztkPLdgJ/JEr66o2vsujPjf6giOVUH84R7k+gZ9rxCloW1m+pg7Rdu4
X-Gm-Gg: AY/fxX6TLZzczkK6XNsyPHWV0gEgvH3YZjpIfSHwKpOG1mZD9m/ydE2zMjbg5tFSqvO
 p49h6vDZeZKty8bygpqV81439hfkvQf61fx+cA+10OEX0kQuZb3zUaBOHqYKYItg/sOCO32AnZD
 y2ZptGwx0WNKhJ1jglxi5R8tmnrIxQmr5R3do0dJ8XyuNvWwKF6m8TJFzakwmxzO0zXAhzvws44
 XuV/XPwfx/ydOd52Y1AtKxL9PGpWQEsWYcVVltxm6g7iCVMen+qf64T/Xa/0xpzrx1caNwzjbVi
 IYFUq0qfsdJOAkj7J9rPNAFfu6tFfy9eqNKaGPrg49CjKfKVTyFiRFqmyduIE67Pk0j9Jskwo3r
 HAaEb0x+X3BInA2BqHT8+sSMNMUECeZkZOvxj9Yp9JCY=
X-Received: by 2002:a05:6a20:3d90:b0:35d:8c8:8acb with SMTP id
 adf61e73a8af0-3898f91d382mr16602109637.26.1768224223411; 
 Mon, 12 Jan 2026 05:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK1u9WC9nhoiyAr5vmMG3ufIQ8YPfuY4suBxhryhWv2uGiiK25n3oA/yPi5HyI2ZGlkvNYng==
X-Received: by 2002:a05:6a20:3d90:b0:35d:8c8:8acb with SMTP id
 adf61e73a8af0-3898f91d382mr16602097637.26.1768224223029; 
 Mon, 12 Jan 2026 05:23:43 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:42 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 06/32] accel/kvm: add a notifier to indicate KVM VM file
 descriptor has changed
Date: Mon, 12 Jan 2026 18:52:19 +0530
Message-ID: <20260112132259.76855-7-anisinha@redhat.com>
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
index df49a24466..ef8e855af5 100644
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
@@ -2671,6 +2691,16 @@ static int kvm_reset_vmfd(MachineState *ms)
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
index a5ab22421d..7df162b1f7 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -181,6 +181,7 @@ DECLARE_INSTANCE_CHECKER(KVMState, KVM_STATE,
 
 extern KVMState *kvm_state;
 typedef struct Notifier Notifier;
+typedef struct NotifierWithReturn NotifierWithReturn;
 
 typedef struct KVMRouteChange {
      KVMState *s;
@@ -566,4 +567,24 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
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


