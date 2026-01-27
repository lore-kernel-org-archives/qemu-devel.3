Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7887ED25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSg-0007iP-28; Tue, 27 Jan 2026 00:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSW-0007Ou-TI
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSV-0000BR-GB
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=CUl3y/v89PW6Zf6pjCvvmN9YJ0Xwv9o/N37pdZmJ1H1bHnA9wWpF7VJYDjtMve0pueGEGw
 Im/MB9UpBo4bJ+6gPZU34cR90HX1T+8Crkhr1vtxm4aNdN7yKIleHwCK/X5FG8wu2Jgv9n
 IKodtPreOv2HLgiG07vAVms4lHg4aHg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-xWb58dBfNzy4L0ziEGnrlA-1; Tue, 27 Jan 2026 00:17:45 -0500
X-MC-Unique: xWb58dBfNzy4L0ziEGnrlA-1
X-Mimecast-MFC-AGG-ID: xWb58dBfNzy4L0ziEGnrlA_1769491064
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c93f0849dso4944887a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491064; x=1770095864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=HxoskLZWcLARmeKo7SzuRKBoXQhfrGqQT5PIRUWSZgelzkksbkToG6E8kMxDVM0z4k
 riZonRidvcR48wr0tQWdi7J/tl3+Tnw63vFDtWiFJD5H57xJfmRBeDK0q4SM2/7T1VXB
 Hkn1tydX46A7DFfV67hIb6eDdUwb7eY3r7tgLtFhkJNs+RP5HPVMV+bc57nZ3+vYac8Q
 j/qdRDdLTtNzoC0XYgmkGJTYEbiP7w8djLlFYtblfKn1nbr5xHH2UGqcgBjtwrlXYLGq
 F4UvmTgdsXMCXC4NZ1ayYWQWz609F5/9mekKJdhD6y/l6UR6hNJ0hUBRoOxJHVdnyjEG
 KdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491064; x=1770095864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=A8tgB/EI5AgL5kcWqUoCTNgtTj9g3E2hbT5YzmGH/kZM447sFC7DYPKDO5yDWPlyw6
 U9bAmW3yIyva2CCmwzUU3TlnglS0PvHZWimVVLhlXBd0okUJsYk1MsdH48KtmwCRSEaX
 nmyIhEYoOcajpoF8W2z9/TcEGzFs2iWFPPX8JQrezu/si0xNBjFjQ27rS9xcBB5zJFQ6
 jb3BeGyChNRGFJlOqGDydKI/4KB/MbIP4ZQEdnTKOK/cOJuzDEwVFGXi0dFdfqi1SH/p
 6w31LVJ9UkGvpzAjaBOMxIa3ZdSaFetx7nUFzYPj5Q7nQRG2bPBgVD3oCJuQ0JKZ1DTy
 VzUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgsMc0H5IRkFvY1RvBlXLLxlvIDWpCwKvEm2grgzj+Cu9yOLd6wMnajn3tAN+Zj+tT19C9ilYTd9P6@nongnu.org
X-Gm-Message-State: AOJu0Yz5lhRMGPLKqPlusejL9MZ2q8vn7EcgRvUTXzdo9KnTUYhoszk4
 L8aE5+eDWIBvc9enTJGFbifc/2kMAr8BuGBN3rsic8EOEPAggW5kWH1GstDljC/BkysIFpVQTWk
 KZ7D3vvmz0+fKIGjx3aW/evO9WKf41aS36WGStDT0KJIzY6TW9qbjtMnS
X-Gm-Gg: AZuq6aJAW8F3V0Pj7Hu03f72CBn8rVkikXRiYRygU//bZO4zZ+6YXd+ypUis/FcU5un
 2AYdDBlyikioTxrn6eZVxLN/niGElsCEvaz6YxvttlubtAcUWWGDd5Cp+FpfjkHzWI27dmiiXpG
 JqIDxQty0VlvE+rksrerF+4ysyQ+bh27sgkps4qHALnFHprc27JppTgjwrOenc+JmoGFZ5+PF+Y
 qmlsWM8KkqTdMZfVfYisGyPNkI8AMi3KjSHzjlmKHIqKGtZiVqQtBEEDSICKQXnMS4AnWplD9Ww
 E+e0JX6OhhpC1CcnPHOkT9n7ZfsgN2krxpjR5DYYkPusZCYZ87inUwXweE0/TNAgry5utSNXw7U
 o+RiufsN7uXMzlyH58E5bmZ76059rFU6PujvyLIKLQQ==
X-Received: by 2002:a17:90a:d44e:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-353ffa6128dmr392843a91.8.1769491064288; 
 Mon, 26 Jan 2026 21:17:44 -0800 (PST)
X-Received: by 2002:a17:90a:d44e:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-353ffa6128dmr392831a91.8.1769491063927; 
 Mon, 26 Jan 2026 21:17:43 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:43 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 23/33] kvm/i8254: refactor pit initialization into a helper
Date: Tue, 27 Jan 2026 10:45:51 +0530
Message-ID: <20260127051612.219475-24-anisinha@redhat.com>
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


