Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4134F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5w2-00021e-Ts; Tue, 24 Feb 2026 22:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5w0-0001oJ-Kd
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vz-0008Bv-0n
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=Siin+S3ec67fInZyuQp1UkjYE3Zx+secoXXqb5SZCOOheoyG+uUx1UYpix6gJy0ibSdk7i
 Q7VE9WzpE+0KSiRv2gp4VWeYzOKMNAMEpBnm4X8n3TYXBH3cO645alasRfUYY37QeTH1mh
 mFBkbte8630we/PibVtDN72XxKnizXc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-CGAA8TnON96MFGKGSSEiCA-1; Tue, 24 Feb 2026 22:51:31 -0500
X-MC-Unique: CGAA8TnON96MFGKGSSEiCA-1
X-Mimecast-MFC-AGG-ID: CGAA8TnON96MFGKGSSEiCA_1771991490
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35301003062so43389430a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991490; x=1772596290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=mFEJsfjiylQj7WJzekNbbKL1RvJvi/lXFZfM1fvkpzQE8nkynyQcMK7/DhkpUW7EtC
 iLrolcGyWi7ilUAR7solSCm/eOc0kTDzGM3DdSVSdFkSk20+FGsJ9g/kLkPdMpG8Lpdz
 skkHzweV0YEdSP3er5IH+azeON7zxZH9D3pyYRlZx5g3CVyPVlftvdI/JUw4WYvW8BeZ
 XfTCx/ZjPFRSmyCER7G7JM9NBt30+shVFscIXlH5kNsumy1/6CDt3Gq4l43C0Spgx/jm
 QxQeJ3hf58Gz7EVjFsX1K/cCVn/bJuUsdbq74Vc90CeSuEaf7vTkcda29QsePCkeyBG5
 QZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991490; x=1772596290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=mojTKDozEiU8jbBYf02r/ppiSwig32EMVRrY2M9LZVANC1qneyNZYSIG85Hjgn/EaD
 Rk4IrLVjdDygw641fgZz1GJ9K8uqixVR6e7bKOjQ16QJsCJfZnQ5BOm8QScO/2DLJraS
 3VDZWgGJaMA1o4iQNPtvYJHqM3fuKwqRBfll1D9SYk75oO3D4XpPMlWVfJ6vE1t303mL
 4ITF8lupr1mM+9LkItNVSMJFo6I//ER2IbGNx9uCLg9SeBV7IJkOuc/OzDXv6zgJjnSH
 2mFR1yXMkba/B988r+l0Ehv96Z/ZaJfbSZPv0RLYHIIdujc4vZ/aFenf3zl2nmt87/XZ
 1Z2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSWpUKfp8cQSF6+G/sjyLs1Ww0sWyLueLn8e3iscQKEoLzt89IEBrvEnEtKgkbLunwNJe+8mgsNoZS@nongnu.org
X-Gm-Message-State: AOJu0Yz/qlP7xHsZIAfmfAWR4giytlqRlV1EnwNJQFKajuu8o5P1t4y2
 T3XyolBLyYj2EBBsw2UuAsDBMEK7zluOwzFjxeQJMLc7xIiuyxrALD2WvUjlcLZpr+E98VaRDCu
 DaW3jdNyk+6K//OozOrz/dOV2uz/VC49BGHy4J3a0/yXkhhQjJCNOKioY
X-Gm-Gg: ATEYQzwetO1NvPhdUPO0oWPn0OsgbmYJZ3mmBnbdvv6v9fAsPq+UMB5o81EJhybhUHO
 TFTiQXc7kAXvroN9Xa1ZLaxcB/dgBmgd+ABYvJg2eezmEwki3XnQnRveyS3w+Y6AlNBmj4P2wzV
 dDBO7/jGzfKpCED9JBKW+XYgkHn29pw/x2MJtorSORjmtn6SfYKam9LlzKkIOtGgAoRom75CAh8
 WoaLcX5rUj+riQeFXZX2OW9IoLD3vyLxLg7Gc41TgOm2gcKyuEXCC/GwqWZxnAS+aADc08ziCxR
 pBWQjRc10bxtkQokQvTQ1PDvdUcwznNKB7wKoBCKxn+XTO73WXODAYwzz7V07SASHdDYt62M70D
 0emcaJZX2iJ/zhxpsc1I57osDKtcdpxNeInfAiOtflpnYoxkWFq2MfKY=
X-Received: by 2002:a17:90b:1d03:b0:32e:7270:9499 with SMTP id
 98e67ed59e1d1-3590eedda59mr905258a91.0.1771991489853; 
 Tue, 24 Feb 2026 19:51:29 -0800 (PST)
X-Received: by 2002:a17:90b:1d03:b0:32e:7270:9499 with SMTP id
 98e67ed59e1d1-3590eedda59mr905243a91.0.1771991489482; 
 Tue, 24 Feb 2026 19:51:29 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:29 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 24/35] kvm/i8254: refactor pit initialization into a helper
Date: Wed, 25 Feb 2026 09:19:29 +0530
Message-ID: <20260225035000.385950-25-anisinha@redhat.com>
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

The initialization code will be used again by VM file descriptor change
notifier callback in a subsequent change. So refactor common code into a new
helper function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c | 68 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 81e742f866..255047458a 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -60,6 +60,43 @@ struct KVMPITClass {
     DeviceRealize parent_realize;
 };
 
+static void do_pit_initialize(KVMPITState *s, Error **errp)
+{
+    struct kvm_pit_config config = {
+        .flags = 0,
+    };
+    int ret;
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
+    if (ret < 0) {
+        error_setg(errp, "Create kernel PIC irqchip failed: %s",
+                   strerror(-ret));
+        return;
+    }
+    switch (s->lost_tick_policy) {
+    case LOST_TICK_POLICY_DELAY:
+        break; /* enabled by default */
+    case LOST_TICK_POLICY_DISCARD:
+        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
+            struct kvm_reinject_control control = { .pit_reinject = 0 };
+
+            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Can't disable in-kernel PIT reinjection: %s",
+                           strerror(-ret));
+                return;
+            }
+        }
+        break;
+    default:
+        error_setg(errp, "Lost tick policy not supported.");
+        return;
+    }
+
+    return;
+}
+
 static void kvm_pit_update_clock_offset(KVMPITState *s)
 {
     int64_t offset, clock_offset;
@@ -241,42 +278,13 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
     PITCommonState *pit = PIT_COMMON(dev);
     KVMPITClass *kpc = KVM_PIT_GET_CLASS(dev);
     KVMPITState *s = KVM_PIT(pit);
-    struct kvm_pit_config config = {
-        .flags = 0,
-    };
-    int ret;
 
     if (!kvm_check_extension(kvm_state, KVM_CAP_PIT_STATE2) ||
         !kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
         error_setg(errp, "In-kernel PIT not available");
     }
 
-    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
-    if (ret < 0) {
-        error_setg(errp, "Create kernel PIC irqchip failed: %s",
-                   strerror(-ret));
-        return;
-    }
-    switch (s->lost_tick_policy) {
-    case LOST_TICK_POLICY_DELAY:
-        break; /* enabled by default */
-    case LOST_TICK_POLICY_DISCARD:
-        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
-            struct kvm_reinject_control control = { .pit_reinject = 0 };
-
-            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
-            if (ret < 0) {
-                error_setg(errp,
-                           "Can't disable in-kernel PIT reinjection: %s",
-                           strerror(-ret));
-                return;
-            }
-        }
-        break;
-    default:
-        error_setg(errp, "Lost tick policy not supported.");
-        return;
-    }
+    do_pit_initialize(s, errp);
 
     memory_region_init_io(&pit->ioports, OBJECT(dev), NULL, NULL, "kvm-pit", 4);
 
-- 
2.42.0


