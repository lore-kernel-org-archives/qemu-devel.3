Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D9FD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvU-0007KS-SO; Mon, 02 Mar 2026 03:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvJ-0006Xc-AT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvH-00022d-Hv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbeLcYv4ohkjdPq3n6XmS1TAfbnoqGUsUc4xgirKhzk=;
 b=OHvySFDySIbrTtmYhTpafkieVShDEIgE7zd5Xh28ZgvJDQ0bp/1nFzejiYbXMgPK4VhU4q
 K6lbEenC2nBV9fATRFwDkwUnT2E23mPG01WD+dYIyXQMurGojNvDzfPNWdVBcxlEasQl4s
 M3m02R3We35cUglQE8gFKGhBM9PJUNM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-zo0JT0jmOEmuCUuUDFVI5g-1; Mon, 02 Mar 2026 03:46:37 -0500
X-MC-Unique: zo0JT0jmOEmuCUuUDFVI5g-1
X-Mimecast-MFC-AGG-ID: zo0JT0jmOEmuCUuUDFVI5g_1772441197
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48378df3469so28249745e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441196; x=1773045996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbeLcYv4ohkjdPq3n6XmS1TAfbnoqGUsUc4xgirKhzk=;
 b=sOwn688FIaCxZRzJwbGD32Wvvt90+4ulYaQYzUoD6KnysGGqXZjkaNiheBOfM+aG9W
 +dEXrDqyn+XWIf21aguSvb9iv8YpCldExwvjP8k4hiC51J0Q63mEd/lw49m8vS8RUnPq
 nmx+eG3cdPOJjrsbtqio4q+j2rIYin0BNoBFh4tPpw/+TPFOOxoe/D4jP0rufZIJseNN
 R+0cA1X1sz14YXapWyXA8At69JhuuNGzk7ZRz+bDMwsDowQFeyozgcKdAhdP1iwFyd7v
 asiyFEwrH/zgekP0g6ON6hLouFljbH+HqLJR/Qx3dT7/Q19EOtbQX7ZmjBZ7XaBlA+VY
 OUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441196; x=1773045996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rbeLcYv4ohkjdPq3n6XmS1TAfbnoqGUsUc4xgirKhzk=;
 b=wG7iL024uegFUiXFuDNXXX7qXc52yU3ppkPo9oJ/Ssgn/WsSBOkg6CM18qNcise6sY
 Tl9k+bUJGWsMfN3Nq0LUD1QfwwQlbWM7tqnj5yxbaUSX6j0TpK/KETUuawXhOtqseib6
 ulmvb9F4b0tmDEpSBLXdFCLpQBUDk8pL2YdggRepD0ELkJJzTfgcKre/it2EdkCuYa7e
 Yi7/4uTg2l5Syu2pAxmO6f5dExNaqdQH9R/QRkYrs4elG38Nwl7GE/uBCmllfkw/8KO7
 bq115LkRp8syAS29yJm1Q9jAUPKK1JsXKZBzgckHwCr3nuEWr9xqHeuTxFVVECo/5Qr8
 UzKA==
X-Gm-Message-State: AOJu0Yzo1y1qQY/t1H6IotWp3WKBme+SVXU4p6A3MFOOOZunNOVdkkVf
 JppTd3FsjKpx+CkS5feWKTyoS9Afu2NDbukmDTeJtvPONR4Mb7Ukd6dvzsAdg1X/afPjkAToz4B
 IzKp9TEVsqStY1JK7nNPDy0rjpI6M6JNVojnqVpC3q9+1QV85jVJln+vfH61k3VdPyYDy4Wlnc0
 aMtjUJAkHZ5SKM4UrNzoLEYZcmLcDt+rD67nXit9DF
X-Gm-Gg: ATEYQzxBaB6pG4D34MPY/9gYLM8UD7n8N9YYxYAsKWWjvONkuR70idTbyamqQMmyRbH
 NOhXaaZW7msnnCBPAg2XO6AmsClLnbNoH3Q6wGtuetgtYqjm26ZQcsPemLFid4a3rtaI5Yx88k2
 P+ORFhliVoQeWStiQncquibMjD6Mzec+sGxAsviPb4K9hbzXxvq6GcQ82DAMXMwh8X1Vcdcb1Cy
 Hl33mje17rX5DL0xaGMIkFyY3ejR1Bx9ITvyZrERjRi61pFFMsmT7vuKZEgmhDh7oGYtFl9DnOC
 kEpzhHQTODE9nRrrm+KC6IHDNp+H2bPDiPFKO1NTsHuI9MQCRRJuNdrDPqgmgSzjAk+fZOnkN4n
 lagm06YJF38DePitNsGJSEhE6+upI6pbNK+zD44CTaDRKnhYVNxVLVU1OE4cB3qXJwozs35uaW6
 RaBVmiB7joou0+N5u3F3wxMVKoDps=
X-Received: by 2002:a05:600c:1549:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-483c990de68mr196761855e9.8.1772441195858; 
 Mon, 02 Mar 2026 00:46:35 -0800 (PST)
X-Received: by 2002:a05:600c:1549:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-483c990de68mr196761355e9.8.1772441195216; 
 Mon, 02 Mar 2026 00:46:35 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfec46dbsm125560715e9.30.2026.03.02.00.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 066/102] kvm/i8254: add support for confidential guest reset
Date: Mon,  2 Mar 2026 09:43:01 +0100
Message-ID: <20260302084338.473368-67-pbonzini@redhat.com>
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

A confidential guest reset involves closing the old virtual machine KVM file
descriptor and opening a new one. Since its a new KVM fd, PIT needs to be
re-initialized again. This is done with the help of a notifier which is invoked
upon KVM vm file descriptor change during the confidential guest reset process.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-26-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/i8254.c      | 23 +++++++++++++++++++++++
 hw/i386/kvm/trace-events |  1 +
 2 files changed, 24 insertions(+)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 255047458a8..70e8fd83cd0 100644
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
index 67bf7f174ed..33680ff82bd 100644
--- a/hw/i386/kvm/trace-events
+++ b/hw/i386/kvm/trace-events
@@ -20,3 +20,4 @@ xenstore_reset_watches(void) ""
 xenstore_watch_event(const char *path, const char *token) "path %s token %s"
 xen_primary_console_create(void) ""
 xen_primary_console_reset(int port) "port %u"
+kvmpit_post_vmfd_change(void) ""
-- 
2.53.0


