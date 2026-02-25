Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF4F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5v6-0007MT-HP; Tue, 24 Feb 2026 22:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v3-0007Ld-2Q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v1-000877-De
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wunhJBbOcVRokAg1jAhfk7nGs+ox6MrG4ZKk3jSClw8=;
 b=We7dHjO6X3GQR+M7ww43hQvSKm5jkZMsu/Ot3fnJsVKA7gYk1o6LIniSFgNjXFIAks82aO
 Lpdd6osH0/AJJFlzd/P/91zdpP05xuXzXlKYZv6aWhOxVtL2rX4Qr+UqNeC990rb7LgbaI
 6SkOY/2f/5SesxuxjsvuWMuehB1R75I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Fjxpy4M5PXSh6yPuVc7cEg-1; Tue, 24 Feb 2026 22:50:33 -0500
X-MC-Unique: Fjxpy4M5PXSh6yPuVc7cEg-1
X-Mimecast-MFC-AGG-ID: Fjxpy4M5PXSh6yPuVc7cEg_1771991432
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35449510446so6218154a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991432; x=1772596232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wunhJBbOcVRokAg1jAhfk7nGs+ox6MrG4ZKk3jSClw8=;
 b=YGScczx51mJPuJyJQNtQ7XulevT3oNTOjnX5r4pwYY1TgUvmXgAls/XqyXOjggwQN/
 hyVnfyI6CvP9JJQVGZavsmUfpT+7w59nVzxhScrMNwG6GkzOFGMuKn79Yc1SnjvfnKEx
 J9UdcOPnsgYi3cXxhjid17ytyEsOrnuHr8DS+j6LXs314QWqG7hRDx1o6WXWjWA1CVrv
 NK0+KN+DquCaWCrklYDZq6tUI1W7gdshTzfuDJ9L1DUa5MCecFswUt07A+/Qe5VeQ1MY
 ofVV49uOXl5gntYs828Qb4Ks+6HkXeUdxZxnq9/wpUm4TmJOxtNviFN9iH7aRtU99fG9
 YWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991432; x=1772596232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wunhJBbOcVRokAg1jAhfk7nGs+ox6MrG4ZKk3jSClw8=;
 b=qTJoOxSfncAfuNM6D5BBD7KUAIzxm7CwfAvnM8Vj3xwCJz8TQnh0MmogDPB2/sW8P3
 GoQQvcaXPA5w+SFYMutt5zlg57rc+P+u5HxGSZkP5ePfRpUPzttYYTfdO6MIP1+HerCg
 dOlnU538N/5b+qYiSfMO5fQRo41GtrgF+0Vapun27yM1RUMtww7TbQiXrd7QLGF4qPD7
 AjYsofsMHJhepqPtSiZA4HwMZxhhvK0QQq8x4P6UIkd6BHSslX2swHDjE+x6Gujawquv
 ziP4ZfGhrUCCqot8w4fipwCn5I9xoWZxPI7qFwX+rdltg145GVKMmzLHqRQRucDuuUdj
 kO0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdSiSOXFCegH7TIYmHJQSqHG42Vori1k5rUemlOo5PlVBzyo9TH8qc2PhOVihBAnFGFRzgltIiJgJ/@nongnu.org
X-Gm-Message-State: AOJu0YyfeL19iPl9JIAJYhrDK7qYgtStZG6ySL2AubHX1o54wjAy4ZP9
 PC1VnYSPDA60K4J5WQX+hF7B0jc1HoNucLNH4eoFr2dDkZtAVEP0ak36XIHEJhF38K3wA/cpYsW
 +cA34L2e4JIrDUYFq276C2dUvIDty1aK/uqjpROcfKPS+I3jSfGnoIyO1
X-Gm-Gg: ATEYQzw6Z2PGO8Zvdkp/IQDfWGDTTC5AYyFAVhXvucFfrOtQvfZiaYLKuB5DNKCm3XH
 Kk1hlGQfCIpEIFe9pHpSjRH7388M+KrWtCGLSASqlm1TrWz/iLIaTujN/vGp83fjZatj/dwGA70
 KFHkEYMAmycddvK3ALUD3tpSTbbQ+MqSnNhpCZwKnFpMgQQye/ivpGMpZJ0H/rQCSgu+C4unn7K
 gD3camw52SUx4Ik541v4sl6rZPpjhm5iAeRW+YIp+hcYd3UoUnsM8mNzV+KwMKwte/Pmjbe7+QW
 VTn+vXrixTnm/DebWDKHHfqziW6mhmKIMMt676KOSDP4sgyCrVNrddzJW5eT73gfDU5BPVUbakh
 fuQfpJP2prqwnspSljv8KDMjO+jumiQklYJpBP3O/RbIK7c8ph4boc+Y=
X-Received: by 2002:a17:90a:fc43:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-358ae8c80ccmr12428347a91.28.1771991432223; 
 Tue, 24 Feb 2026 19:50:32 -0800 (PST)
X-Received: by 2002:a17:90a:fc43:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-358ae8c80ccmr12428333a91.28.1771991431798; 
 Tue, 24 Feb 2026 19:50:31 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:31 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 07/35] accel/kvm: add a notifier to indicate KVM VM file
 descriptor has changed
Date: Wed, 25 Feb 2026 09:19:12 +0530
Message-ID: <20260225035000.385950-8-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 096edb5e19..3b57d2f976 100644
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


