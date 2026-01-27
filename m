Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AADD25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRq-0006m0-PK; Tue, 27 Jan 2026 00:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRo-0006lW-C9
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRm-0008Ls-Eb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekxz0EEyBOQMVYi/GjNSmeh3FZ184pWI8lFYWcurNPM=;
 b=B6lfimfG/KNe2wVf0Wex226bQPdFk7rzX+pN7PsdOZ2fMqPbCqVv2DlaqeE+MknAGZcNqv
 n7GIGFieUxfguwM9f4yDUDwNv4jqg3WlmP0mU85j8TqBWyvRJs+DahzLwa56lh99f698HF
 hhx4tCDj2UaruC2kUJgK9ss9oVD0xU8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-O91VLUO1OZC6DolP3Wm8tA-1; Tue, 27 Jan 2026 00:16:59 -0500
X-MC-Unique: O91VLUO1OZC6DolP3Wm8tA-1
X-Mimecast-MFC-AGG-ID: O91VLUO1OZC6DolP3Wm8tA_1769491019
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-352c7f19acaso4033822a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491018; x=1770095818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekxz0EEyBOQMVYi/GjNSmeh3FZ184pWI8lFYWcurNPM=;
 b=rHLszYiivqT2L8mb2Ghcyij8SaAHEiWneI6XYlGHQaSXG1P5fgHzUNm8a212rXTQCw
 ST4WTv7dqbYNpQ6pkVLRL3UmCF96Su4RgYfTIstLOiBqN0s4udX6JLnV1YC2bfYOyQ1E
 8HVH0Yuw9nqaUNxpoCWXjmqZrRAAP7ROPuGcHcx/x19q6HNjxVISSGrvfi9ONRaUTw0l
 NNcAeywbIVoRSnuKX6QwV4S/HvDciR6sWmMwsDTcddzV4hiCyPwWEaNUEsJQBEE3McXR
 6T6pLLcrWa3C4bygp1ZK+XnP0g7AwhcYCAQD2mE6zD8gLEjEFZ99e1DS6RnkbaZwvLLL
 VYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491018; x=1770095818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekxz0EEyBOQMVYi/GjNSmeh3FZ184pWI8lFYWcurNPM=;
 b=Hf5xw04ECtgHztE0gAMHlZeBRMSrha3/oLt342Tiw8MQnJ9rPxRmMba6+6wCveF26I
 ysefnxvnQHSlxamCA1U7N82uyv4NPnxAd7h5MYIzKOc6BLYFo8sipPnDVt1p3enSL6J4
 IY/jtqMeHfObaZwJuuDzIMnCZ+JZv4rdeFQYggCf8sbgJg4S4SjPpItmk1HenLIGkoBc
 8Ax2Ze6zwPtSzgDQJEtwadP452ENfcsNKX3PEW1sI4wXsPZTV2NbNQK9rRzMNrw+FzJu
 TjISQTiPOXayVl3vu5XgAkJWEIzKABGkI/X7DhFrlx3btdGD3R7gHHPpQZhXMFBmIYih
 R3/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQaL59CECLMv8fP7cOTvo4BtzxujQX22yAV0mJ1Xw6HK9qR5v+hTOTqafKjisOWp1OVKlRr18crRsn@nongnu.org
X-Gm-Message-State: AOJu0Yza/u90CvPx3V6E54tYreyPwJCeY09TLcpw0zRJB7ClaD7MPJCY
 i6cDBSxeS93kG9PLfua4878AksH1C6Tp4h10A1gsoCYbkxLKmjgCSCH4BDLz0iUI6yES4JF8uBx
 z2mLFZlf++gAYx9ZGZX2k//irjthZS5EgStgt2JuwBq7Yu4ZU7p4saXlm
X-Gm-Gg: AZuq6aJxT8fnwIfwTQJmoBYiNgMbVh3ilT50GG35ucCo40KPln8pI0NBJ+nyjgOo+k4
 W3TLKOw/yRBw4MXzBd5DBtsxfRq9fRYttnB2+SNzPeGoLnIXpCg38sG093A6viII7Mw1ofAkmrx
 wUPbBDjcHwi2BKCBgiDUi2g6vKd8EOwHx9tVeT66QXWRcEMrWnxXMmjihpYyCTerDxMH/PFJ/EN
 /nBQ1UpCxZnUzTK1TYtIX5PufwqbcpnXqUYJDsit9PYSNkvDxEe3myz24TP0ZJHbIoFd0rudhAs
 bjpc+LZ3PyqRYRs1RynG0G4dS6gXGbfm2K7/fDTvD6+wAy7Meey/9IvcKcCO1Fpv3h6wE9dgObJ
 qpeDrByFgda9T4ShO5kTwLCdzFOrK7m1lVzxEcTa+gA==
X-Received: by 2002:a17:90b:3c88:b0:341:88c9:aefb with SMTP id
 98e67ed59e1d1-353fecc6679mr585036a91.5.1769491018479; 
 Mon, 26 Jan 2026 21:16:58 -0800 (PST)
X-Received: by 2002:a17:90b:3c88:b0:341:88c9:aefb with SMTP id
 98e67ed59e1d1-353fecc6679mr585022a91.5.1769491018057; 
 Mon, 26 Jan 2026 21:16:58 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:16:57 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 07/33] accel/kvm: add a notifier to indicate KVM VM file
 descriptor has changed
Date: Tue, 27 Jan 2026 10:45:35 +0530
Message-ID: <20260127051612.219475-8-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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
index 834df61c31..06d72111e2 100644
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
index d40cc9750c..6ab37fd440 100644
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


