Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAC7D49236
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hS-0001x3-AS; Fri, 12 Dec 2025 10:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hO-0001uf-QQ
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hN-0005g8-5G
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bVGFXFJOeA9joOcTSQUXwNCiI9IN8A2ai1h2FlFtiU=;
 b=JHLNhaWCsNrD952PkJnszPhsqNffIDYNHxEnWi4htPpS7NFLwvqz2vRRfoRZoyJj5PYhXh
 1d0GyXWkFf0j3oZ8B/7i9y2bRrpgWJZoPMLDoGtpuM68nocPzq/YvtHpYnw6clnmklGq/6
 YGKK2CMYLmLR+o4JfKkN2iBnQIyCmiE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-nNf4JzEYM-avwRfx-J0Iqw-1; Fri, 12 Dec 2025 10:04:47 -0500
X-MC-Unique: nNf4JzEYM-avwRfx-J0Iqw-1
X-Mimecast-MFC-AGG-ID: nNf4JzEYM-avwRfx-J0Iqw_1765551886
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-295952a4dd6so13065555ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551886; x=1766156686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bVGFXFJOeA9joOcTSQUXwNCiI9IN8A2ai1h2FlFtiU=;
 b=XwwRP24RNA9ImLTbWPigboqZTrPghYb5yhb/wYxIVezGNOksp9tWfwzy6x64+kefKP
 rA6S+2yXQlOUOkw01B1V3vlwH+ylNQELX96Pgxqi0Y4YPbUSNGCDO8zr7XUrF0+khiXn
 fnvDH7cnpS3K+tqFCTsm7pxqx+junudIZFrKP9Xao61rny5FBM6l8oJ3H+MZ3Kfdj/lr
 7WTwohBFoFFXtr+u/CVN01ii54qE+X6F1PHd20H5z5PWXzt6CdltILKftxDekYmev00/
 kYOQ5nf/KsXk1I5c1r0gTW5w0d5CaJxx8l1s72O4SEKtdx/0XB7j3akVB0XfEAODGDL1
 iTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551886; x=1766156686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1bVGFXFJOeA9joOcTSQUXwNCiI9IN8A2ai1h2FlFtiU=;
 b=Iyq4dd2iUb+l00+PmwPhtSCEabaOaFQl5l90whsFiEClMhjdlILhHxD8PAvFUWAkhq
 xqiOxS75D7qTci1380frdiLmfNDkPKSFBhqP0FD4L8Fvccid9oj2aCMW/B+PoXEkFqD6
 zdqvJmrIoI9HwzmOR9LkOkXKGRvsXCgCHS2pVEf0lM2HR3wSI4iiXWTTDyVmiFya+Cb+
 x97y1PNkc4aV9utBo51GD3sggrgTNiDVsbyxawQ3KONrXYxiM7bSXHYaT5FNWGoqpjBz
 o3NUtN+GVrrbZZNDoiWytmvuawKf09W95RtIspS8QVz8u11dLzlijbtBsxcNG4tlBtcZ
 0fSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL5XrahgbJrAl0C1js/WJ+SU22tGRX2SFipacLTZYL7dUcOWaHWPgoggUNNDRE3NauZ+9t9EXb+o86@nongnu.org
X-Gm-Message-State: AOJu0YzbYC4tMge0gpAmlTHxneP1duJfIiy/i/UBvrJm7L8wW1WGmeCQ
 agx7vtoG14oNsVOuhayfkV82U8fa7J2TsRuTZ2fAu8trWfLfBuV+uXc4+wpEk9Slm1scJ15ezHU
 0OsVpmCruKIbAxWRNpbdWtPvLle1ZS4b/da2ibgCPv7pyFAauhL9BY8zi
X-Gm-Gg: AY/fxX7VyIgwQ5alIIXx4hbMQpTwmQKgmA7vjS2Nt4bJCUaKSqvQMm5a8rnaxWuLr7k
 FBWkTmxHL3tTCQkL5U0wzNV4D17NBg3IYfmXN85jQdRDm5yHDuaWQONnO1Q+WoFyca30KKpM/Th
 GA5KM4UsPzt1BFAksRDRI0wnyQR8kpT9UEMQzCFZ8dOlnMA0K8Khc2cYA4MpsDpCHDpI1xUukxI
 rjf/j1heOS+L+XafY8u5nOXTIVJRETElAoEg3bpMgXoEbQquMipOQmJXwE65q1b24g8E8bNNNph
 IrxoiGwFUggDAKhDhzkKSvhexQuH3wwBjaf3y6eEcLhoLEnF1SHbU7Z0UvfUP3s1VJdsRTceWf2
 riu5Sy1r2ZD7Jz6yO/2QLDfOrlqvSqvlOHMQrN1L5PO0=
X-Received: by 2002:a17:903:15cf:b0:297:c079:4c32 with SMTP id
 d9443c01a7336-29eeea0686dmr57884685ad.11.1765551886064; 
 Fri, 12 Dec 2025 07:04:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkjpSMTWKqwt1A7tVr9+iysMnzsonOe3OLhAtCzR04vkiSW5RhmALupyANyX+IIjejo60RoQ==
X-Received: by 2002:a17:903:15cf:b0:297:c079:4c32 with SMTP id
 d9443c01a7336-29eeea0686dmr57884455ad.11.1765551885605; 
 Fri, 12 Dec 2025 07:04:45 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:45 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 06/28] accel/kvm: add a notifier to indicate KVM VM file
 descriptor has changed
Date: Fri, 12 Dec 2025 20:33:34 +0530
Message-ID: <20251212150359.548787-7-anisinha@redhat.com>
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
index abdf91c0de..679cf04375 100644
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
@@ -2661,6 +2681,16 @@ static int kvm_reset_vmfd(MachineState *ms)
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
index ade13dd8cc..6844ebd56d 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -181,6 +181,7 @@ DECLARE_INSTANCE_CHECKER(KVMState, KVM_STATE,
 
 extern KVMState *kvm_state;
 typedef struct Notifier Notifier;
+typedef struct NotifierWithReturn NotifierWithReturn;
 
 typedef struct KVMRouteChange {
      KVMState *s;
@@ -565,4 +566,24 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
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


