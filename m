Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDD2EDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQB7-0001HC-Kh; Thu, 12 Feb 2026 01:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAR-0000OT-SJ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAQ-0005Lp-D6
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uA6s98chAA/AAmOAgTNuehQ1wNW/fEWldjPI7yvg0g=;
 b=il9O366HAuYlFZmYZU9E1XtqfVAeNSXG9QY9MJ3WNResd6uQW2yfqJF6rfhTAINNRScGe9
 Q6WJYXpOlcKSd7+1M8wkZRp5Z+vgmsPFPEo411x48irhD1vDQ9Ed2GWbnzI0QLAQpKFeVy
 yxDCcbu6kUcTErwn1/qDXr1QTkpZjhs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-MsHdjDvwPmmjZQ3aov2p7g-1; Thu, 12 Feb 2026 01:27:08 -0500
X-MC-Unique: MsHdjDvwPmmjZQ3aov2p7g-1
X-Mimecast-MFC-AGG-ID: MsHdjDvwPmmjZQ3aov2p7g_1770877627
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-353c9d644b0so4403478a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877627; x=1771482427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uA6s98chAA/AAmOAgTNuehQ1wNW/fEWldjPI7yvg0g=;
 b=QqM8fhiDpp/x2o5VPFtypq3indXGb/S34C4fjYUDwhppN5Bqu4OEu7LORjoWe8ZaZ4
 5CtRfIfwNuqoLpryiSNK7KRY8jRrNGLOl19rCiap0E0rogh8GYTzgMBlMXtmEE1zlXq3
 /E7yhdXmSobPghAUuu5nZ7xRiReYO5yAJADuKPTTFgta2HC8AxEp1+L9RfJhrj18rMK4
 gLY/304ZMipVGtf3gpdOgiJBYISQvOouL3gLMW4MlWaKF8LNM3GmkOqTow6F96RkhPNm
 wjDcqOf+cas4FrsKcOf+MuJ2AbT7xNkMV4JccRWcedHTgmxURG3IDJOkixOx6J1/y+01
 +Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877627; x=1771482427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2uA6s98chAA/AAmOAgTNuehQ1wNW/fEWldjPI7yvg0g=;
 b=l+bpxENoWDUlPQug4bSDDCYAIChpu/r/OKzrcyuMiCUT/i8t68UGcXwSnAHjWhurco
 L834y7haztt+l3RfFchFjP1w461hUfJaJVWrWpdxXSpBp/Ui5gzOosIqgph1qBHevgXm
 f8jZ4VpJHSIWcbOUS+Y8K5ZHgXJMZWidYv4GoxwBwQdAAR6zrh7y0mB3M7KiaXogeZEm
 k2bGyL08FJGjyLbYR+RGBGPfhAZGb8KwbYYYHdoU+CzimyfeUCN6bx1ufGlEELIE24ht
 7yyGIQQEvpFDN0VLUKry8bkh1PaBBCEsiByxoxZfXY7Zi+O9xPBm7gtW3D/niPchmxxc
 V+4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG/gaulgM2byBndEplMDBm7wQbWkJp50T7plipW6iaZpXwRckD7OAUstX6Xc4JtMZ9BCeiu6zzdSVm@nongnu.org
X-Gm-Message-State: AOJu0YwEfRtl3y65WcWE+x4TaGCXbbh9e9hdktjDIE8rjN5PCIGArSIm
 9Wshr3WC8ljTV0hpe70XOIYOLVPZZU8OxCNA5MJCDK+maDNH5xX4jouw+uQylW58otUGoq515xj
 XjxNy2GtFGWr160ofczZe+H5oZGUwhFvbQu+wFk1+WWtZdGugrOhXfewf
X-Gm-Gg: AZuq6aLmWjmt2+VqxXXBIrv90Zil2zqi78vWVpp5ZIG/hXvZCahjE99INyYj5sdeXsD
 BVG7IIglAMopdHGKQ6quIDiDwRNsKpA7xgqYWQ0YFX8lYZVOQqiFkcRveU46ZCip1L2swsJURFI
 zdw29cutAwq7lHdE/02MvvhZCS6UqfzMSXwIx7PxokKFcOzyZ37A60XJ+wLAOC4DxehY+VaMPOw
 d6A+3EUzVvJIEkTrwqVGLOUk/oYshBvaQ739imFhVUa0uODo4fMVjkUfGQtW2b4z9GhWz/hBWQn
 Ds9kxlbbVXhL/DXsX9ubtKcoUc1tGx7itoZhB+p5KZB9wT7NE6U29xh7xx+AgzsAl4g8wsWlmQv
 qolwGOit2eWcdWt6y/laigSjXfWRsLhQ4ZREe1qtGPJnDSIV3SGTMNRw=
X-Received: by 2002:a17:90b:1b0a:b0:343:e2ba:e8be with SMTP id
 98e67ed59e1d1-3568f307a58mr1581638a91.10.1770877627321; 
 Wed, 11 Feb 2026 22:27:07 -0800 (PST)
X-Received: by 2002:a17:90b:1b0a:b0:343:e2ba:e8be with SMTP id
 98e67ed59e1d1-3568f307a58mr1581626a91.10.1770877626939; 
 Wed, 11 Feb 2026 22:27:06 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:06 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 25/31] hw/hyperv/vmbus: add support for confidential guest
 reset
Date: Thu, 12 Feb 2026 11:55:09 +0530
Message-ID: <20260212062522.99565-26-anisinha@redhat.com>
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

On confidential guests when the KVM virtual machine file descriptor changes as
a part of the reset process, event file descriptors needs to be reassociated
with the new KVM VM file descriptor. This is achieved with the help of a
callback handler that gets called when KVM VM file descriptor changes during
the confidential guest reset process.

This patch is tested on non-confidential platform only.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/hyperv/trace-events |  1 +
 hw/hyperv/vmbus.c      | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/hw/hyperv/trace-events b/hw/hyperv/trace-events
index 7963c215b1..d8c96f18e9 100644
--- a/hw/hyperv/trace-events
+++ b/hw/hyperv/trace-events
@@ -16,6 +16,7 @@ vmbus_gpadl_torndown(uint32_t gpadl_id) "gpadl #%d"
 vmbus_open_channel(uint32_t chan_id, uint32_t gpadl_id, uint32_t target_vp) "channel #%d gpadl #%d target vp %d"
 vmbus_channel_open(uint32_t chan_id, uint32_t status) "channel #%d status %d"
 vmbus_close_channel(uint32_t chan_id) "channel #%d"
+vmbus_handle_vmfd_change(void) ""
 
 # hv-balloon
 hv_balloon_state_change(const char *tostr) "-> %s"
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c5bab5d245..64abe4c4c1 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -20,6 +20,7 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/core/sysbus.h"
 #include "exec/cpu-common.h"
+#include "system/kvm.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
@@ -248,6 +249,12 @@ struct VMBus {
      * interrupt page
      */
     EventNotifier notifier;
+
+    /*
+     * Notifier to inform when vmfd is changed as a part of confidential guest
+     * reset mechanism.
+     */
+    NotifierWithReturn vmbus_vmfd_change_notifier;
 };
 
 static bool gpadl_full(VMBusGpadl *gpadl)
@@ -2347,6 +2354,33 @@ static void vmbus_dev_unrealize(DeviceState *dev)
     free_channels(vdev);
 }
 
+/*
+ * If the KVM fd changes because of VM reset in confidential guests,
+ * reassociate event fd with the new KVM fd.
+ */
+static int vmbus_handle_vmfd_change(NotifierWithReturn *notifier,
+                                    void *data, Error** errp)
+{
+    VMBus *vmbus = container_of(notifier, VMBus,
+                                vmbus_vmfd_change_notifier);
+    int ret = 0;
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    ret = hyperv_set_event_flag_handler(VMBUS_EVENT_CONNECTION_ID,
+                                            &vmbus->notifier);
+    /* if we are only using userland event handler, it may already exist */
+    if (ret != 0 && ret != -EEXIST) {
+        error_setg(errp, "hyperv set event handler failed with %d", ret);
+    }
+
+    trace_vmbus_handle_vmfd_change();
+    return ret;
+}
+
 static const Property vmbus_dev_props[] = {
     DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
 };
@@ -2429,6 +2463,9 @@ static void vmbus_realize(BusState *bus, Error **errp)
         goto clear_event_notifier;
     }
 
+    vmbus->vmbus_vmfd_change_notifier.notify = vmbus_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&vmbus->vmbus_vmfd_change_notifier);
+
     return;
 
 clear_event_notifier:
-- 
2.42.0


