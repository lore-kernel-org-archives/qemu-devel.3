Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE15D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvu-0001Si-Ix; Mon, 02 Mar 2026 03:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvG-0006CF-1T
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvE-00022D-Cf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4F01VEmQLNn4bhnf/pHKH/Ewq60YHHQIBflyPA7EaqY=;
 b=ccZenK00s+sY+tZnG52t0PIHAf41HsxsMQ3uO64wIVyZBkhLZuhr+iq5d1NVK9OCfOQUia
 IZaADWdFlc7USs2/03Ua4dxRfYK0G/I0GeecxlcR8l3LK9pp/Ncmxa9C0Y0V7GpxbybQKw
 ApRNljbwb8fnbXrbXb8jeEbr5ucpUls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-QefkYCRgPIaY-dBqsUh9ZQ-1; Mon, 02 Mar 2026 03:46:34 -0500
X-MC-Unique: QefkYCRgPIaY-dBqsUh9ZQ-1
X-Mimecast-MFC-AGG-ID: QefkYCRgPIaY-dBqsUh9ZQ_1772441193
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so42275025e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441193; x=1773045993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4F01VEmQLNn4bhnf/pHKH/Ewq60YHHQIBflyPA7EaqY=;
 b=TMMfCxzh9fn4kTx6RxrYgrzbP7ZcMXKAgSMmHm39J9UCnS9TvgaAR7d6W9Y7holVr6
 KD9caeIFJX3/uPxNB4v3wYCfVt/PkTJ56zRql0+bxKeCFOtLq/MsvAuZvJYNzASq3hps
 43mhfzKjJQKJ9+t7AbqNa2tfVD8+6raFHwAxTM9UDfsin31gqmrfAo0x+BqsM3MZr2g6
 cP5Mxr5qWxnyw9OWy10oz+239uEUlqEzU1sMMswDCDnOn4fm2mLR61g/iJ9gEh5XPlUn
 ADFYhCC1y15XgSIe8S6fNaH2Mn6qRzJL64Knhl6/lx0PgfeRzLMnsJOzIFCF6QuL5XgQ
 Z7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441193; x=1773045993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4F01VEmQLNn4bhnf/pHKH/Ewq60YHHQIBflyPA7EaqY=;
 b=bXRQ+QswgKDCz+5GO6KwNxuxSZSosb0ugDm34TkAtC0mT2tyTCxzogwcFhEJARrP9+
 xgiH4yb0JOkHlhICoO1YKFEKn7mv0iirOym7R6ff8Lag1jzM/GvP7qHcom7h20pXwcFv
 1vjmIou1Fhxj1AyFfBBkz7vtaytJNb98ZpwRAIW+SLCbZp5SQsXa8wm1cgl6uNbvRqRY
 NeMkAHEo6oAwgkRQSNdh/utxel6OFOoBqOtmHrVpc854jbsFvFPWSrrqxtAiRSuCYHDi
 gN0LOHafhr2B/skbO/oHUvCvalq6cN77XxuhLDMlQAdK1i22AytlGBqZTBwNMK1i5PwN
 TyjQ==
X-Gm-Message-State: AOJu0Yz/LqrJ1h8l7zoh71GnbI6vVgbVWFLGCGoKE7GPkSPzpyYGInbq
 KWTZs1jwmDvcUMC89yghHxkClZC/RekjGYsQ6ojgVreT0lkfW/R0eTcBYsotSnwIXhFVT+e/sWA
 U5t/4vowS+RAMX+UlaXSFAJPxXwp9IH+iky5uJqFPEAMGc5YvikxqmGIZKu4K01ybbmQLy819ki
 qv6HiBnS9NJkcgmiXAmWuQMGBEV4H2rN0r1DULBiUV
X-Gm-Gg: ATEYQzxY0QO5Fu5KA4TsL3JF+LG9nzP8k2LwR8tgun3V6CnoZkc9puSfUA6pcki6M1h
 glbNnNpfYvCppon2JffzVpMMwWYPfsSnjEkuMKaVU7ESIXx21KBzMnHclDhrUnoiCcUER53g9YV
 dTzW2K62ULCHlaVISOezOdVBE7K+Pc7OoPhSSEedp+4Cr7lho2CPsP7I98hkxWpdn5pRfJWooDf
 RgR2bhQiHufnPbDfsmD7nR+IuceM0upJUDLv7fm4QFaVtBYfm4++8bSaSHdO9HO5xYf02H57Hch
 t6x2AXFAmARZwLfb547j0g9qp6ciGhznhgmJmSpZpBuR4NEzWO4c1Pf0WPAtZrvGd2ZLpVElJj4
 vjkmaS79uMFD/HcHE/3grOmUq37g2S4M6hcDaU3MVsQFmMl3+Gb26ZyhNkYMwfUtDsKepC6BlVv
 QC8V5TJtkLdPVYeDDGDUtvxvr/Clc=
X-Received: by 2002:a05:600c:c167:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-483c9bb660amr186784855e9.5.1772441192796; 
 Mon, 02 Mar 2026 00:46:32 -0800 (PST)
X-Received: by 2002:a05:600c:c167:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-483c9bb660amr186784375e9.5.1772441192319; 
 Mon, 02 Mar 2026 00:46:32 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm391139275e9.10.2026.03.02.00.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 065/102] kvm/i8254: refactor pit initialization into a helper
Date: Mon,  2 Mar 2026 09:43:00 +0100
Message-ID: <20260302084338.473368-66-pbonzini@redhat.com>
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

The initialization code will be used again by VM file descriptor change
notifier callback in a subsequent change. So refactor common code into a new
helper function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-25-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/i8254.c | 68 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 81e742f8667..255047458a8 100644
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
2.53.0


