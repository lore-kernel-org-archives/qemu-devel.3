Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF99D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyxg-0003WG-K7; Mon, 02 Mar 2026 03:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywf-000304-5k
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywd-0002Bo-G5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vb8FQn3qqPMI5ex4Vc0fj/JZviKSQrKwDtnZxxtv6Kg=;
 b=RnVhR9pwDnPN4344mWZ1zjxSLFcRi2gK4urQAJ6m1v83P9z2laPydsppFH87N+JUJOpCxC
 96t7x0FWXa9LmMf2Ro3Dt8GVASKhfxF35YxtfKNOaeiXokSsdx19vn0qxp8UPoqdudcq/e
 pIcNuYI1oAmiwVm10intgioFIziNfSA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-VZYPpxb7NPaSm-qQXhPbWw-1; Mon, 02 Mar 2026 03:48:02 -0500
X-MC-Unique: VZYPpxb7NPaSm-qQXhPbWw-1
X-Mimecast-MFC-AGG-ID: VZYPpxb7NPaSm-qQXhPbWw_1772441281
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so44043445e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441280; x=1773046080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vb8FQn3qqPMI5ex4Vc0fj/JZviKSQrKwDtnZxxtv6Kg=;
 b=qGZnWeWFnufY5St0/cS7JMhOgti243XDMzrPxgjs4zD5QTYWxMu0eS294U678/vk8Z
 zsGS2VC23hVL8k/wVcyR8c0SI3R4CeZ74a7BMEtq/G0kMD3hYphSQfC+knrFxNZN64nK
 MPP5k1dNEyDSbFyAC7qH7T3nM3+NGLPsTxbTn/zScylLcUxce7bJfjOGLo52YupnnOjZ
 UjeRDyw1pO7wCY7uItTQsc9hCpV264DJYltiyrMG6sZq4O/H1FejAM0m2eB0iWfCxWhx
 aOxLEeFKAIENPXGKq2BxDTXfv+zrY+ZhMJFEbVexZDV/N7UCWYzbu9fsnMZwDiTOEhA+
 zuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441280; x=1773046080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vb8FQn3qqPMI5ex4Vc0fj/JZviKSQrKwDtnZxxtv6Kg=;
 b=XSqA/Afc3krHsXC7DwA51KlRaUhJN6KNJ98ATMgEGXRyknzoaAJ8AzYdBICFPMoxnQ
 S56WerLzVLbnRXuFgGgxcpcsQYRPWcTUN5LrwQG4qiS/+BtTurcqGWiz2Nt5R6ZxAVvH
 4uGDMqUCbseOG1K0lqoGa0/UQrhLCk6ZAgPE7xFYFZZm2sztJU52mApMF3hEgmGU8WXL
 O60RYCqIMJvKksWmJ/BNFKb5HGjYLEYY+d2EP/ywESJprWlsmOb+YC9emJeFliy+lUbk
 9S6naFcr2+vFImltA9MtTHkRcQgWj4nqqnXvf6zhjW3bgrP7irT5D8odLkkngCA9bBqZ
 7SeA==
X-Gm-Message-State: AOJu0YzORn1Ikf4LUBLpSurSiTRRWPEu2wrSXkqebmQq6jm3YwOMEMlv
 /HBBYqW/OdpCPvLl79c3uC62uGIHpD3OlNEb1Tq9cpoXuf2Y+uaHF/gp9aR6e1/x0I30yQH8b14
 top5iYwXFXDWwXr7k9IbctJP0dtVs6eBagar1WDYlLnsah6D0SEAAXHQMfCxs8NufvhLfwpaip9
 q0K+QS3CE5vUDCXFV7CL3RD5G3YmXnxcytuOBMuqQr
X-Gm-Gg: ATEYQzy8VrWRG47nqt1lLh/mxTrdvhJOHq1vHs8FTJK8FsfVHj7pP4SFZNplOqQTmQV
 0nrbrg1hiY2z+8nCEvGdSDe+yNynWvW6/IjAZS5YtCu+JzXCSj8BxpuEgyzZMDd3XFV0o1IP77s
 pih3/p4u5+fjiCMc62ZHxV3ZBImyYNhn5n7t+pHLotbcHxsj1IZUB9HpOje8NO5WJuyTDeqoLFg
 M3qrbwgNod0ZYfXGM9xWL5Q1G3VtxRE2z5X8yWmjtu3CLeRYZOpR4sfO6/gDx6TvIk2z7Z8rK8U
 IRgXyCcyorFpmJSqs38ayBCCeN+VFrfPkVBiIm9TQXqBXlgblz3I0KNbQNI5GDMQj6BLx273BB/
 XA/r8JbShP6WXzjRPJNY7CW2U1nnGcCR9YE9RcwRi7J09LXoSP+h9veCpu8YgyU/xAZZjxzwsV4
 7TCUVTFeMxwjKtAQfrr/QUItdTtWM=
X-Received: by 2002:a05:600c:4e56:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483c9b9eaddmr204329335e9.11.1772441279721; 
 Mon, 02 Mar 2026 00:47:59 -0800 (PST)
X-Received: by 2002:a05:600c:4e56:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483c9b9eaddmr204328775e9.11.1772441279110; 
 Mon, 02 Mar 2026 00:47:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c35910f1sm225380315e9.2.2026.03.02.00.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:47:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 071/102] kvm/vcpu: add notifiers to inform vcpu file descriptor
 change
Date: Mon,  2 Mar 2026 09:47:17 +0100
Message-ID: <20260302084749.474955-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

When new vcpu file descriptors are created and bound to the new kvm file
descriptor as a part of the confidential guest reset mechanism, various
subsystems needs to know about it. This change adds notifiers so that various
subsystems can take appropriate actions when vcpu fds change by registering
their handlers to this notifier.
Subsequent changes will register specific handlers to this notifier.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-31-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h   | 17 +++++++++++++++++
 accel/kvm/kvm-all.c    | 26 ++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c | 10 ++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index fbe23608a16..4b0e1b4ab14 100644
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
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a347a71a2ee..a1f910e9dff 100644
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
@@ -2841,6 +2860,13 @@ static int kvm_reset_vmfd(MachineState *ms)
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
index a6e8a6e16cf..c4617caac6b 100644
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
-- 
2.53.0


