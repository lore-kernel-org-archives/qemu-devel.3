Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFFBEBFD3F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCFN2-0001pY-4L; Mon, 13 Apr 2026 07:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCFN0-0001pP-Tn
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCFMy-0000eN-09
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776079338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/cKganVCUcy7ncPCYHfRMqqbTtbqcMv+xZ3LSLbvgvs=;
 b=T/Vr6G0mfLVbMVZuzQTqWYduW1L4LIDzl9Ao58aCitid9JjUq+jw/yhDV+//DTQXkPKn4B
 Tqj1vU1p1fSngrTywcMshdMu1ekO1EeO02C0nPJt8pgUqOElC8h3YSHFxAzy0RrTC6ZvZa
 UmibUyHhgHVVxlbxeAHD/0b6XunMejY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-kf8n1EHkNoKXbhmzrGITow-1; Mon, 13 Apr 2026 07:22:17 -0400
X-MC-Unique: kf8n1EHkNoKXbhmzrGITow-1
X-Mimecast-MFC-AGG-ID: kf8n1EHkNoKXbhmzrGITow_1776079336
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82a6c70f1f8so2872996b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776079336; x=1776684136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/cKganVCUcy7ncPCYHfRMqqbTtbqcMv+xZ3LSLbvgvs=;
 b=ShauDyYJPSn0kiNPAxoQgPuasE0GIJecSbM15PYFzcNTY4b0Vq+l1T7RNXyVCcyzt+
 T26yDra5TfoeAtT9x4xphoU5+tstAX+ewTAmlhbU6V70EfaHqR0hHRFo2dTp9RmpRMl3
 q5aJ/MZykD4YAZh29WGMj6cnCdIJqKeiCqnjfYHJwSlmr/PH8GpJmEfu0h/jDZ6Dxo4q
 50MCcGa7nBlQ58HxmpdQRDvBfq0LPayMfnFyqnRseS5VHosvsMM6j0PDx/imjE+xRWJH
 jTpFJ/NeBaPSsg2M8StKDG6IkrqSiN36fgQyXBaHNUFZiGbpXsWCWjTbxxu9mN6SQk5m
 OwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776079336; x=1776684136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cKganVCUcy7ncPCYHfRMqqbTtbqcMv+xZ3LSLbvgvs=;
 b=JbyZxqk/KuOuG7wthKvDrW/hxqVoRsRkzw6dZlGDcuJEfdOJlbwH/ZrZInPsVMWecR
 fb+84A4bIVOvWYvy9+0VZ7ZVzfVtb/xorkYCz2nCYUv4UO4IXBGSHPwNZyKR77KNEsDm
 GjcCfQgVWNLIBNQcq36upimPeWt0yg9tolkMSdekq4v+82b9Qc0dEj1jmrAAAJrcFftr
 2hUF8UNyQRpYhP36YoEj/Z3OG1huIYrIuxUeugpQpnwqYOTjWiZ8jOY7yRg48rHL0vwH
 sS5hUnWD3a7WRr2qO3IyCVW/tpvb9KgZADSQwqWO4fnhzJ/Kj1eCVgvPRl11EBY32mkW
 ZK+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CWiJ1jlx3g5U9LjML1xIvnRaOgsyjpvKa5heBTbLFkRlo1YnAAOIVQL2vZTGBC1HKI+RaejXt/M0G@nongnu.org
X-Gm-Message-State: AOJu0Yx0p8nmkT/SrwtSgE/KCHzkjqapgvzIdp2FvkCwh68yAQzUtDJv
 4dCUy/cDtmZ8ZUi0eK/J3CiPuqwoCSVm0l5aXSfHg7R2m/hUx/BKV73WZv1IILBiwkX6nd6MIox
 IDKXYvGUGiyhP0PEKVsoGh0fw9DaIDn7cKAI4foq2glCSDXAEgcqkDif3
X-Gm-Gg: AeBDieu4hRAwfh+w2wmL9QPTrA8pcHT93O8WlCYp4v5FkG/1JSRKqO1nqqbpYTxIt8P
 nNU/B5Xo2LDDed5cMxj9nHyhOOcstKWkClK14oH85xwTQPnj1JnxqRWv8n/FhZxEM2jPZ4f8JOg
 DerUZzVgqI5VuU/TE1TLm3aO1HiLrbZOUZBJf1yWe0bXF+/E9tbO/HqeG2S+A1gzMV0IXPnY3x8
 uM9+2CqKPrNpT+WmVITd7xX22uXIIsuf84Gqfb96wL4toQPshJ5Fj9T3T7haGKQupAV3ifxoXZN
 a0Qipbk+zItlvJfcy6dHsUi6Dqs/zNT6NbpVT0MTp3pAmws0++F0PMUEJRI7V37eqNjY2sL+s8U
 kg38VAJ9rhaCedIhXiKXSG61/A49FTfXfeISaJ+XNqAaY+8N3nWSyn7KzwRrtJxLjMEUODcuXgr
 fpRUgCWA==
X-Received: by 2002:a05:6a00:608b:b0:82f:2115:99ab with SMTP id
 d2e1a72fcca58-82f2115ea3dmr5937936b3a.33.1776079335951; 
 Mon, 13 Apr 2026 04:22:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:608b:b0:82f:2115:99ab with SMTP id
 d2e1a72fcca58-82f2115ea3dmr5937912b3a.33.1776079335491; 
 Mon, 13 Apr 2026 04:22:15 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82f0c35194asm13842808b3a.20.2026.04.13.04.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:22:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, Ani Sinha <anisinha@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH V2 for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
Date: Mon, 13 Apr 2026 16:51:51 +0530
Message-ID: <20260413112151.61261-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During refactoring of kvm_irqchip_create(), the refactored code was returning
early from do_kvm_irqchip_create() function if the required capabilities were
not present in KVM. This was not translating to an early return from
kvm_irqchip_create() as was the case before refactoring. This is because,
do_kvm_irqchip_create() did not have a means to notify the caller of the lack
of kvm capabilities. Fix this by making do_notify_irqchip_create() return
EOPNOTSUPP error when required capabilities are absent and then the caller
can check the return code and return early.

Converted some calls to exit() to assertion checks in order to make it cleaner.

Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

changelog:
v2: converted some exit() calls to assertions.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f..c78bf6a56f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void do_kvm_irqchip_create(KVMState *s)
+static int do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
@@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState *s)
             exit(1);
         }
     } else {
-        return;
+        /*
+         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP capabilities are
+         * present. Bail.
+         */
+        return -EOPNOTSUPP;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
-        fprintf(stderr, "kvm: irqfd not implemented\n");
-        exit(1);
-    }
+    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
 
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
-            error_report("Split IRQ chip mode not supported.");
-            exit(1);
-        } else {
-            ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
-        }
+        /* assert that split IRQ chip mode is supported. */
+        assert(s->kernel_irqchip_split != ON_OFF_AUTO_ON);
+        ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
     }
     if (ret < 0) {
         fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
         exit(1);
     }
+
+    return 0;
 }
 
 static void kvm_irqchip_create(KVMState *s)
 {
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
-    do_kvm_irqchip_create(s);
+    if (do_kvm_irqchip_create(s) < 0) {
+        return;
+    }
     kvm_kernel_irqchip = true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)
@@ -2835,6 +2837,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
 
     if (s->kernel_irqchip_allowed) {
+        /* ignore return from this function */
         do_kvm_irqchip_create(s);
     }
 
-- 
2.49.0


