Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D248D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvn-0000YQ-I2; Mon, 02 Mar 2026 03:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyui-0005FI-Kj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuY-0001wI-I7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5ILIOhHq6Bf+THYvRqVzoWxL42vyxsfaFfm2JegWsM=;
 b=SadXA+VaYaS9lpqpHhupK9aUrOXUZs7HwcecA47+W6GnJLA5Q6MLbIMmi8bmxxXRnxyB+K
 ADZWCw2fntTtF8SS4EByYkcb4VFnGFG/tLC5lhSciJcbQ3r2gt/0I3iF+ZbplClE2jMjrX
 Es5Hy9Li7veYu4wJS9RUmYWQgfoZdlk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-_JZrdxsOMnSsqXbRUs43cw-1; Mon, 02 Mar 2026 03:45:51 -0500
X-MC-Unique: _JZrdxsOMnSsqXbRUs43cw-1
X-Mimecast-MFC-AGG-ID: _JZrdxsOMnSsqXbRUs43cw_1772441150
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so44019375e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441149; x=1773045949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5ILIOhHq6Bf+THYvRqVzoWxL42vyxsfaFfm2JegWsM=;
 b=EMPd+OCSe8/E1FYQp8dRrPxi/DOgLf7bjzk1w7ORYQBSITyD7sRrQtp4VBU1WqTW/6
 3uImlgv236SE9YBkqCdwAjq11vJD/GX+jURY0jqWeB8lTlyATnm58jvTUiGJoFFigdzA
 Fb+CrQYUWODUKYuSlWT+R3uczvZYHAv2URhH5PGM1KD1M4ZFaN6Hvsvgf5PEJlgm4F5s
 rLPKH619kAr9kwSxmClY64HBmeSGdxbfcZdtub5IKV1iM7meLpC1aRDNwmhHJ0mLwQnC
 y2MJjJGkxQ9u2fFGChbeCV6kJ51ZAtBJDF8fkPUKmQ1OjCpRMTWAsCDvh1GBKVvXoqIK
 n1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441149; x=1773045949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l5ILIOhHq6Bf+THYvRqVzoWxL42vyxsfaFfm2JegWsM=;
 b=D2cl0ULZ8JlIsA13Npiql6VObwaSgFAGOnyavt3fddLc5W9V4odfBN2dJz0xSmny4S
 rSTAO8ajL/CLTjSN1nWH57SHC9AFiOUli/AZIq7cViryJ6Cnx0NrFTwLq/6kCZ49LwkW
 CHPkWp89P8VKI97ZoRFRgC8ChLOLWQnsgNio6djkjJgMBPSLyj1pi31CIXYRkXBSPRXC
 dpry64LuTdRPI78JqxLL9ZZJEv9AS2i1Q6IpzJNmjgKFMqSjy8+jGbVr8sOtJxwOdFUx
 s01vd7u/KrxPIQ3ihZcoRBVwMcF1U9Bg1x+fJ50MiNzcOCZuLVGEygQrH8Z0byvAkb0S
 eTjw==
X-Gm-Message-State: AOJu0YxQjhQCwpybFdPA9fD7Fz1Vl7eJ25BsoxNu8bkFcdSgMbM7+7bD
 T9SJOhR9FgwFnNL9E+cV3rY8bV8B4hQlqZitOZOaObvcTkHYoV9hqZLCkbI2HLpzrC7Z/sSo4hB
 6u5rCpByMX/GPrnSxZHnAc7c0NNcWlYB3aZRXcltcqySzwEYS3k7jSF+gxGzDB6PlFxPckz53Cy
 S6zA3pZ12Tp8sMeiZ5lkQICNoi/yNKDhx/KNkXwI4n
X-Gm-Gg: ATEYQzxZuedzEGDXxtLrWNAC+izivfetWgykqeQ3u4IDOGR9XzDCkK0cJUjxI1JDhEH
 OC5cyCYuy0IqW/amSBFE/MYXhHsohbt5mPWEczIQy+9pSHxdRWQRLTBdWwLm9TVyAbPi4llYuVX
 JKvW7leljcuz+6Vu24XIAKj+8ELuvkQ6uC+QzenUmc4xKzIHvFdYLDyaYTN8erDBBvh/AQwq3ra
 ObsayHvnV67nHS8f91/0+N1nWFiYaet3VIAi2NUFwl5w48Tm2LPuGsm8mJUTWwEciAR/2jOitpJ
 FVkxjzKca9+pMybt5suu3SAbR4SzRLE/L3oxfcpWIzPYL9B+viCV5uBo3U+r+oDxh2HW4M3RcxX
 dFj3YH03RfojU2n8CWbkMSJt6D6tu8XXD9TJq+dK/A8Vl4t3JUNA322kz1pMhiR2s/6ddAnd8dj
 LG11a8ZnZaOvrbqM4op64WsYkYAik=
X-Received: by 2002:a05:600c:5395:b0:483:bcff:7948 with SMTP id
 5b1f17b1804b1-483c9b9eaf4mr197723545e9.10.1772441148724; 
 Mon, 02 Mar 2026 00:45:48 -0800 (PST)
X-Received: by 2002:a05:600c:5395:b0:483:bcff:7948 with SMTP id
 5b1f17b1804b1-483c9b9eaf4mr197722745e9.10.1772441147611; 
 Mon, 02 Mar 2026 00:45:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfba9a5esm269712625e9.4.2026.03.02.00.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 048/102] accel/kvm: add a notifier to indicate KVM VM file
 descriptor has changed
Date: Mon,  2 Mar 2026 09:42:43 +0100
Message-ID: <20260302084338.473368-49-pbonzini@redhat.com>
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

A notifier callback can be used by various subsystems to perform actions when
KVM file descriptor for a virtual machine changes as a part of confidential
guest reset process. This change adds this notifier mechanism. Subsequent
patches will add specific implementations for various notifier callbacks
corresponding to various subsystems that need to take action when KVM VM file
descriptor changed.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-8-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h   | 21 +++++++++++++++++++++
 accel/kvm/kvm-all.c    | 30 ++++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c |  8 ++++++++
 3 files changed, 59 insertions(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fc7251fd94..f11729f432c 100644
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
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 096edb5e198..3b57d2f9769 100644
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
index 68cd33ba973..a6e8a6e16cf 100644
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
-- 
2.53.0


