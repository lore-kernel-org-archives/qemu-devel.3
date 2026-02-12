Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F94EDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9S-0007c8-LL; Thu, 12 Feb 2026 01:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9J-0007aZ-8c
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9G-0005DL-28
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5PlrDMoIrug3cAYm+kTR0nrJ7BVWWy0jAqCy4UtGT4=;
 b=VRQ2AKBCBm5nMg8CecryXLoLuzPCwC/KE6i6ny+LWbmJL0snqDxbPTCky+WkKzlJuN/zDq
 QNFET9jOdvWBTP3wP6KZrlxJ38QgJts27RF5+IdGuyJ4lSPq5Kh2+cb7XaEhwdpq7vSZZ3
 0QH4+mJcXO+T6KroP3I2u/bgs2I07W8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-MNuYQgs7M1-sLltbBOGLXQ-1; Thu, 12 Feb 2026 01:25:55 -0500
X-MC-Unique: MNuYQgs7M1-sLltbBOGLXQ-1
X-Mimecast-MFC-AGG-ID: MNuYQgs7M1-sLltbBOGLXQ_1770877555
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35301003062so17081218a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877554; x=1771482354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5PlrDMoIrug3cAYm+kTR0nrJ7BVWWy0jAqCy4UtGT4=;
 b=Te8ah3Yq/z0nYL+kFRuiC6u9Z2erDt9av6Zq0pHDbnKZCFUyUwIub5eCiNuYm8MzFA
 dgiPC2B7LNEYjU/IkZ6Gw5HH54FZ1uijqTS4hb63Py+LlxqdVdTcH6lWOHxt+DObf94g
 yv/cnDCZRHIT54kpH6YUvehgzIdSKYnAEEdNKcG2kl9M3htncKlNtl4+DFrtt0L4stx7
 2cTCPn/vprblHItSV/lKux1Jzid8O4dw9ezjjBKLDwLiy5dEMe2yjHpegepIqytp/AL9
 D7qckwm6BadZ170r2jZbAbDDjg3Ikzs3d9+Tia4xPjKOWF/SBkHe7YFQ2q6lQg7umCf3
 1M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877554; x=1771482354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o5PlrDMoIrug3cAYm+kTR0nrJ7BVWWy0jAqCy4UtGT4=;
 b=bz5j4Fv5Mt0Zs5UlMu69zDPxRxaofT23xyk51vBZRgsuw40as7ouqOBRjTqZNimLC0
 83PCaoPE17ARkJLqn2z8ZsZVHOfBvvHTnUDJpYaQ1nd7LV49jnqzaqR0rMlET4zFt1nI
 ywDZPICt7gI1hs4mTwE4dhBJccXtVYxvlGRKhW/NfOLaFHgfKbc9Ak6pylIErFX7v1zF
 EgBZ/txyAHRAHQbfUwg+mSV5ldZh0hbCZTDj80duQC3ukgLE6S3YquliaFsA6heGQ2Nk
 6idheMd6MqT1T6hfVhH7PzkOKvqLignWWS9/wdQwtWc1mv+52Sp3p1QfO9i0BdVszv3U
 5pdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0f3vvfgiWBMAiDCgRRO/DojFvX8fVvqWDqKmnY6+/oisdpKz2c+s/OWKtLCnFP2Twpqrbh5Y37cbi@nongnu.org
X-Gm-Message-State: AOJu0YxXdpxqHTrlU+OiinPzVfU9WN/Ejw539KUcpWGjPeBFY/euUr4Z
 YX5glkL+OmCfAPAcuq1nPUHrjrdomB7hH1BbdixayyHX5WYKmsdXKtlNO0ikiIk0rxcKYTtOYWk
 9FUgr91AMb25cMKbcZsuwp6I/k3OEPG1WrD9y7FyvRYKUQOsPi6h0FcJT
X-Gm-Gg: AZuq6aLXrQY5AvZlhUF8El9hUt4EfSsbxQdUz5yF/lPk6LAPke3fUh9rHj7aJvqJd32
 3TNquOoAyi9FBZ4P2Ngz0C+udGitYtv3grUgruMBqtPexjozD/kx7HTfTVuQ1vQeM7VQtj9/FpK
 aK6NwW+1LN85konCHsAR//zA09XIX95st6i5h370G3DuIgdNZ31Sx2F5BHyH4ao4pFyTa+1h3dg
 IHuTrR9RIOmNPpmdnQvicv9fjGLOCnT4cBbLEHuB9X02HCWVJbZDQPpXXuxR8733c21GXHC6N2v
 pVE5IpRlbNM5ILIuwO9rWN/fAJfqYfVxRb8ByR/I58AhUtAm1kcbJoHQJzxoIV7y2mu8tIy1K2x
 sQM9vQSBfMNSNkkdZLfoSa4vkPZFNCL/5qCA04VlGGBhWGKU7fpiydOQ=
X-Received: by 2002:a17:90b:2dcb:b0:356:1edc:b6e with SMTP id
 98e67ed59e1d1-3568f2cc67dmr1813344a91.8.1770877554535; 
 Wed, 11 Feb 2026 22:25:54 -0800 (PST)
X-Received: by 2002:a17:90b:2dcb:b0:356:1edc:b6e with SMTP id
 98e67ed59e1d1-3568f2cc67dmr1813301a91.8.1770877553693; 
 Wed, 11 Feb 2026 22:25:53 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:53 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 06/31] accel/kvm: add a notifier to indicate KVM VM file
 descriptor has changed
Date: Thu, 12 Feb 2026 11:54:50 +0530
Message-ID: <20260212062522.99565-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 46243cfcf2..30d6295f53 100644
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


