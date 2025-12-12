Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E01ED4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hd-00026G-4P; Fri, 12 Dec 2025 10:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hb-00022S-3e
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hZ-0005j8-Hp
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgjX+7Zs4GjKiVepp+8rEO8AQv67kp7/f2WN1WL8v60=;
 b=YMzIVdfOjAnAz5OvnWXXmUoteCaVTw0S9RuFAgKkchsrLyfA1eKKS3MJyYzEi3L7MSjc/I
 r/IAtZ0mb/S5ZkppDkb+LL0vu4CpeVWLc12M3MgPs/mjw6C4Diu2db16O1loUe8VgFoKDH
 COu4XaD37NdcYAjNg9gPsMxF/hfR6lc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Q0Go8_bDPUaopy_CsB3b9w-1; Fri, 12 Dec 2025 10:04:59 -0500
X-MC-Unique: Q0Go8_bDPUaopy_CsB3b9w-1
X-Mimecast-MFC-AGG-ID: Q0Go8_bDPUaopy_CsB3b9w_1765551898
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-297df52c960so25620075ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551898; x=1766156698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgjX+7Zs4GjKiVepp+8rEO8AQv67kp7/f2WN1WL8v60=;
 b=Nbt/FKO7MeCupRPvdQKjApOsV7YlnN8SF3+EdJa3CBTf83Dh/LiGKOdj14Cc1uhpvA
 nENsrGZCnSuuqEyf9zmMbrqzZmRPr52j1w7pJkjeezLPZdmGBF9oy5Nz+kkzLPrvK7fH
 KT8NnCdLafxlADivYQ+VMyHLOXEDvPMDVfiPB9ZoGQfaa4AN/KFmIEC8Cyx4CZZNVD1K
 2w5uBXztLy37LBYMadKG/E+JwkO6XgjX02mUugDdr0wrtLw8oAhbN/CWwSSGgKyePwAE
 KgnbZooj5IJsv9bFT3pTT5ID7GRV7IYpyV9e4vU6m4e35hf7x7s8XW57Vqx2RX+spp/Q
 CDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551898; x=1766156698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rgjX+7Zs4GjKiVepp+8rEO8AQv67kp7/f2WN1WL8v60=;
 b=Mh/JWciqr1m1f3XNh6ic8raTvez91bhGa7qcx4wi1fNUZySbFGHeX0t0A+RIiihZhY
 x92ZmJrQMDHTA5plAoVEUkk0VWTxyFXXaO3txqvVfbu6gNzgAybZLfxXkLAiYyzCB3Ss
 eIsW31NhyfKEtXF2edMFROjslTJ8sR2rF6I4qjj9hKsoLw1JdcGoA+cXtOLaFJaStubr
 CjTLI/BPB+k/fnIVCPGaksx0KQwGi7C2i0fIFfSe4vogPIuEw6EsXkHlXE8bR5R/D7ps
 Y8LyrTctm6vYKQTWA+b9cNfOk3zPvPiEJg8mY1HYychc1Zy0mohKhyymb/ro6SAZvLEM
 VMSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWmwXSQpJYha1hH9/eQ/fGEXo1tBgbRfU0te6VW5NuCe/GsDZ5GsJepXxZA4Psw1DBzXoCLghwf9D@nongnu.org
X-Gm-Message-State: AOJu0YydvgVVO7xZjS6YTLMkvBQwxobTZoM9sPa/I+sbhpTZV/u2AMpu
 2pGP76AbN5g7RtvI6P1hR+XwOlYuTG5dSsKNvNAz+VoNFdlv0KNOQhij++wtJMnJgzp2aETP885
 9Tb6sHlk4xs59Uy+DpJVN9l3jtYIhZgOE7jRIWGLIj3A0pgV10B5X+973
X-Gm-Gg: AY/fxX7YDK6CnKDh+9o7Yr+hK0ioN94EC4fUr2LYlTyi6S5rLf8WXTsGvPBGfvm1d8L
 jR/TWLjlio9hQ6u0n4ERE5fkNuGhI/soIES3KZ+Z8JNX6UfLwVbO3h+eVd0OSLBbaaJ73zJLCXt
 Iv5GGbREDf4Wdi58rnXpBtDPGRiTlcx0EVFd4EVNY3v/l2C98EWQ7W0HymZcA16sgkhJz5TnzQE
 5AWF17Yh6GKraEbdMu9whlYaXLdDAqg6E6Ck4r3OODf5qSGPMdASqqj2JWtH9rGvm9zt1APnSK0
 ZF2OfWdXlrN+hHGef50qA9m6JjLdIiF9ASOvoWNrz2VyA6zxWwtyCn4nxL+pvEiEVCn0m8QX/Ih
 klMMWiyUPyoNR/3EqW1SoKEs4E4d4wB07VLkiw6Mjc6A=
X-Received: by 2002:a17:903:38d0:b0:295:9db1:ff32 with SMTP id
 d9443c01a7336-29f23cc4083mr22674675ad.48.1765551897970; 
 Fri, 12 Dec 2025 07:04:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzZSIzSedS7i5fW89+07VJqVZhC3NyNAYZLpbH9Gha7pzyQN6PN9hZP33q+bh0g/hvLJN8Uw==
X-Received: by 2002:a17:903:38d0:b0:295:9db1:ff32 with SMTP id
 d9443c01a7336-29f23cc4083mr22674195ad.48.1765551897348; 
 Fri, 12 Dec 2025 07:04:57 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:57 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 10/28] accel/kvm: Add notifier to inform that the KVM VM
 file fd is about to be changed
Date: Fri, 12 Dec 2025 20:33:38 +0530
Message-ID: <20251212150359.548787-11-anisinha@redhat.com>
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

Various subsystems might need to take some steps before the KVM file descriptor
for a virtual machine is changed. So a new notifier is added to inform them that
kvm VM file descriptor is about to change.

Subsequent patches will add callback implementations for specific components
that need this notification.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c    | 25 +++++++++++++++++++++++++
 accel/stubs/kvm-stub.c |  8 ++++++++
 include/system/kvm.h   | 15 +++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 679cf04375..5b854c9866 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,9 @@ static NotifierList kvm_irqchip_change_notifiers =
 static NotifierWithReturnList register_vmfd_changed_notifiers =
     NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_changed_notifiers);
 
+static NotifierWithReturnList register_vmfd_pre_change_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_pre_change_notifiers);
+
 struct KVMResampleFd {
     int gsi;
     EventNotifier *resample_event;
@@ -2193,6 +2196,22 @@ static int kvm_vmfd_change_notify(Error **errp)
                                             &vmfd_notifier, errp);
 }
 
+void kvm_vmfd_add_pre_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&register_vmfd_pre_change_notifiers, n);
+}
+
+void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+static int kvm_vmfd_pre_change_notify(Error **errp)
+{
+    return notifier_with_return_list_notify(&register_vmfd_pre_change_notifiers,
+                                            NULL, errp);
+}
+
 int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
@@ -2644,6 +2663,12 @@ static int kvm_reset_vmfd(MachineState *ms)
     memory_listener_unregister(&kml->listener);
     memory_listener_unregister(&kvm_io_listener);
 
+    ret = kvm_vmfd_pre_change_notify(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
     if (s->vmfd >= 0) {
         close(s->vmfd);
     }
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index a6e8a6e16c..7f4e3c4050 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -79,6 +79,14 @@ void kvm_irqchip_change_notify(void)
 {
 }
 
+void kvm_vmfd_add_pre_change_notifier(NotifierWithReturn *n)
+{
+}
+
+void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n)
+{
+}
+
 void kvm_vmfd_add_change_notifier(NotifierWithReturn *n)
 {
 }
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 6844ebd56d..cb5db9ff67 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -586,4 +586,19 @@ void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
  */
 void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n);
 
+/**
+ * kvm_vmfd_add_pre_change_notifier - register a notifier to get notified when
+ * kvm vm file descriptor is about to be changed as a part of the confidential
+ * guest "reset" process.
+ * @n: notifier with return value.
+ */
+void kvm_vmfd_add_pre_change_notifier(NotifierWithReturn *n);
+
+/**
+ * kvm_vmfd_remove_pre_change_notifier - de-register a notifier previously
+ * registered with kvm_vmfd_add_pre_change_notifier.
+ * @n: the notifier that was previously registered.
+ */
+void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n);
+
 #endif
-- 
2.42.0


