Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81755EDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAn-0000mf-Cf; Thu, 12 Feb 2026 01:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAO-0000MY-2v
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAL-0005LN-Ny
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=PYRoZWIILrgd/uj7rccA88BxDOxVxCkvKtJszwoloU39sfDyhRgIxFPEXs9pTYARLMpkwX
 hCPkWGBNmuFsTcki73OVgUip+uJE7tGV3k75kmscJgfhVsqux1qnO0ZxmGFn1e+hBlbm+Y
 BNviXzx0YNc983skh7FQ7Vbw3kd1S3Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-ILAUJvMwMbyPwrNkhIcXXw-1; Thu, 12 Feb 2026 01:27:03 -0500
X-MC-Unique: ILAUJvMwMbyPwrNkhIcXXw-1
X-Mimecast-MFC-AGG-ID: ILAUJvMwMbyPwrNkhIcXXw_1770877622
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c44bf176so5392447a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877622; x=1771482422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=LZGp9E3ThHH9xKNWDWJywDfAloJ81pvaQ6l2hgMSqFI+J6RWB09LqRscj+JS/lxkZb
 JNIE4tCV5jircSFHunO5JSultrTQXfGDyfJGZFWTaoAdpvJYnhwKmEGtnb8nZ9p06Wc1
 cUbdotA+Z6YYmRxU6KGHrAnjrxU+4JtUfLMhM20tqW0AQLumxrrqHDD5+KHtYtHV98nB
 dYuzToIoUeJbjjqSW0qT8ocrAWzKJqEjOqmQH+9hvaRLzekt3cUScVub0jGVpaalMabS
 m9p/68y4Jgm6Gzzif0vQC5p/d9mE7gtwVyNP4hCMjd83NlNlIeTwPoon5zI4eGkvYZms
 bPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877622; x=1771482422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i567b0vkVMDwtdwVAwszAB2dBBQ7q9jKGjjwGdoXxsw=;
 b=rfThaAuTe6+iTQOLwvUw+N4EXHO89m6n22BSFvlJNu3/9IMw38Eb8bK/FDaIKKq4CO
 NK01fqSotKNvbp++3QICVWdWhSLtjHLtbVjpzdAMJ7dLTaSCs+pdj9rJeo5BDx1KKU+h
 hZTlw1894MbvUtQJB+Y6hZf7UIwB71PKhRL4oSsL974E/Y2YSv4xwBXzStq7XyV7HQ4P
 xWosD8H82i5CKQKgcgrEsXhV5PIBo48jV8SeeLiDWPWznBxepOCW8IBZsqXkYRMFRlYu
 Klnr9A43Ocex1xssaUDZ34ip6J+a5yoa7Pb0TNrxeYZVQMc4zvNQu46mtuML58LraPqj
 ypeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT3yx2R2QQv4ttyWYqxYNIBqJgeV6HSPEtZqxTJy7AOHbJ4xtg9FqzeYnGq0+KABrFmQYxS2RLW7Xk@nongnu.org
X-Gm-Message-State: AOJu0YyYVoXjBhUf7LQclfmguwIp10YcSebj5nlbaa/yQnzzLNVRiuss
 dizoBWbO22K9m13rVHwUk0JZqR3LQZZ2uldjkJJa8EqrigUX1RuLNLptsk46HBxPVv1wmGs+6/q
 eylFa43b6kkWXc7LkM0x1dH5C6qWM5+1euiwbpTEGgAPe5Jg1G90EZ+Yd
X-Gm-Gg: AZuq6aK2ejmLwZluQAsd0X7Yzz1bBzdlGso8VjrW/ommO9IBCy0iQwQHICCbG2WscSM
 IynmehfrR2BS0JKcMPa8KPY8yMVvvTimpsykDPfIkuNEMe+WIqhlOfnQprX5y/M8MnlEnzBjCeJ
 TAitDXG8d7WT0EKmvjjZYd6AmLUwwoM7FU/x8tHB1J3wUPKI85HZTn197ey3l/EkQx1i63+kuxm
 +jSJQ0TpqpSgebFztt9GQr5LmeeQ0hyUtL+Hq1G3KbiA0Gv9TnYi+rVZNwUH216qRQ1AcYYtD9Y
 hiEypJRSTyVn30JjVbJ9+tM6Fb9cnC/Wbcq3h+aggKmtj2MmHHQg4CT3LXIiiJxQHfSjolEIttk
 6ZQD8v7W4nc/FHNP3ZX9zIp9YDgleisHC80CzBvoX7rbO/eWCux0vF7A=
X-Received: by 2002:a17:90b:3141:b0:354:ad98:7d1c with SMTP id
 98e67ed59e1d1-3568f31c280mr1956670a91.11.1770877621949; 
 Wed, 11 Feb 2026 22:27:01 -0800 (PST)
X-Received: by 2002:a17:90b:3141:b0:354:ad98:7d1c with SMTP id
 98e67ed59e1d1-3568f31c280mr1956650a91.11.1770877621506; 
 Wed, 11 Feb 2026 22:27:01 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:01 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 23/31] kvm/i8254: add support for confidential guest reset
Date: Thu, 12 Feb 2026 11:55:07 +0530
Message-ID: <20260212062522.99565-24-anisinha@redhat.com>
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

A confidential guest reset involves closing the old virtual machine KVM file
descriptor and opening a new one. Since its a new KVM fd, PIT needs to be
re-initialized again. This is done with the help of a notifier which is invoked
upon KVM vm file descriptor change during the confidential guest reset process.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c      | 23 +++++++++++++++++++++++
 hw/i386/kvm/trace-events |  1 +
 2 files changed, 24 insertions(+)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 255047458a..70e8fd83cd 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -35,6 +35,7 @@
 #include "hw/core/qdev-properties-system.h"
 #include "system/kvm.h"
 #include "target/i386/kvm/kvm_i386.h"
+#include "trace.h"
 #include "qom/object.h"
 
 #define KVM_PIT_REINJECT_BIT 0
@@ -52,6 +53,8 @@ struct KVMPITState {
     LostTickPolicy lost_tick_policy;
     bool vm_stopped;
     int64_t kernel_clock_offset;
+
+    NotifierWithReturn kvmpit_vmfd_change_notifier;
 };
 
 struct KVMPITClass {
@@ -203,6 +206,23 @@ static void kvm_pit_put(PITCommonState *pit)
     }
 }
 
+static int kvmpit_post_vmfd_change(NotifierWithReturn *notifier,
+                                   void *data, Error** errp)
+{
+    KVMPITState *s = container_of(notifier, KVMPITState,
+                                  kvmpit_vmfd_change_notifier);
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    do_pit_initialize(s, errp);
+
+    trace_kvmpit_post_vmfd_change();
+    return 0;
+}
+
 static void kvm_pit_set_gate(PITCommonState *s, PITChannelState *sc, int val)
 {
     kvm_pit_get(s);
@@ -292,6 +312,9 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 
     qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
 
+    s->kvmpit_vmfd_change_notifier.notify = kvmpit_post_vmfd_change;
+    kvm_vmfd_add_change_notifier(&s->kvmpit_vmfd_change_notifier);
+
     kpc->parent_realize(dev, errp);
 }
 
diff --git a/hw/i386/kvm/trace-events b/hw/i386/kvm/trace-events
index 67bf7f174e..33680ff82b 100644
--- a/hw/i386/kvm/trace-events
+++ b/hw/i386/kvm/trace-events
@@ -20,3 +20,4 @@ xenstore_reset_watches(void) ""
 xenstore_watch_event(const char *path, const char *token) "path %s token %s"
 xen_primary_console_create(void) ""
 xen_primary_console_reset(int port) "port %u"
+kvmpit_post_vmfd_change(void) ""
-- 
2.42.0


