Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4AAD4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4iE-0003Vb-CZ; Fri, 12 Dec 2025 10:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iA-00038z-76
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i8-00067v-HM
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+hUMfB7dPYW0Ylu11mGAE8OiIe7zJXRU6t355j1QZ0=;
 b=h2FNlKsvfYYiW3/fdhs2Lkky6Eeozu5SmQk4Sq5HJVCTrIMsrldNOmN7vifvGcxv/v7UPV
 Z5a6r8KDWUsv2ErusWaDvN/UOG6+7eX1v0k+3Vr28iFcC2rgD2ynQ+WVNUlvDPsTWL1IVg
 jU9SfMgSM//olyIwb2mKgKxwEBHH308=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-OTm1adgbMVe7b8lDCQxuew-1; Fri, 12 Dec 2025 10:05:33 -0500
X-MC-Unique: OTm1adgbMVe7b8lDCQxuew-1
X-Mimecast-MFC-AGG-ID: OTm1adgbMVe7b8lDCQxuew_1765551932
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29557f43d56so16174625ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551932; x=1766156732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+hUMfB7dPYW0Ylu11mGAE8OiIe7zJXRU6t355j1QZ0=;
 b=FvDJonmhJc/VRlDt9ItYnntX+XbdCTsJznlvQg+gP9to+zNc+mfFukxNheZcf+gd/x
 UC/VatCoIPrUsKIY/Y7abHXCymleJyYjNyIF/ETjZicBzMJFUWW5cmaOGgqCbmGFzROw
 rloEvQ4V2erSnlaa1bv9QkFZfS9om8laujgywJ075S7FQLV6nmVxEVtFOFXVhINUN8Qz
 hHlUXgFnfRoh26TdwyU721y4vHg64LYa6A9so3Edst/SITMLBqZwoJw75/ms91Cq/Ywx
 /k7TJYxPQB51eSUazumUOr5KzldiaD6oTu/K6ishw4jKIOaClK7anvJPfD29RU9eRiij
 uQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551932; x=1766156732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7+hUMfB7dPYW0Ylu11mGAE8OiIe7zJXRU6t355j1QZ0=;
 b=TtTB2dlIqSM0HjRwUX0+kyNsnSY1kz9w1FAr4xSIE4yLmRM+MrdzGRs7FW0S2plGPo
 OK37v8OV1yg2bQFb/fibCZlsZY5FGIwSbwaxQvkRxWQFW/BL9jD83QnK4eFGtsO2rQh7
 zM4j8x8DYw0WqpKLxGtisIrnYp5NmWDQnXYbXvOOTMzoUY5i7Ax3FzYGuul1K31EqSLW
 pUBS5YfyANIoxXWV2ZgC+UJb50mSyYEqi2iEm/M1zjSj5CP/q/xW3jVcDeChOTYPIgJ2
 Ht1MAaggyw2YYRMLbuX47wjDQs41GsipPhtr2P+4xSuC/DTjyaS5fn9ruiBqEJPmrvVo
 0Ksw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyUR1C+/WNzy4mx4cVPYkvTA0+2rELyPK/hyxAhAiCfVZGgobMBEoj2B4YkeJRg5Ji0+6EhFEw9Ilc@nongnu.org
X-Gm-Message-State: AOJu0Yz0CM/1P/DeeEs4EoyoHLkq/Z9UXTlPBsmaC28n7wLgCgQfACwc
 rpF/Bkyakk8S+GX3LWdEp4S1eBMS1xEVZ6ETzIKrA5H5TJJZjLrhxPJ+0Ew9q7+JiI66IuYTroJ
 DAHdVYGG7yqvQLZ2CSmCVVfORoXUAeJubANNFIeILFi4gHRVV+765pozJ
X-Gm-Gg: AY/fxX5kjxcOi/daszOoxGYvyYdgFFN+4kCvjPGFtzXVScOJktQkTcO09hAYSgQO2xX
 BoRGBEf4lbeFpd/uCx25r2k0NQu2dG6DAA0KuaAkXA0t3ZvAkwo/DCNNmbjCsZcqNuTyT7FbcSa
 6TCpdLZnaISTT6FKhN714geUVMm0rHtzzofoG8qY0vW8z6NyQzceEJBgLJvt+zbfVhpCXsFqEgR
 zihYgegFtrmpl13POO7EDJr+1irdLCBpLUweYYXH4JPeBE7mGr1t3k1y+skC0TD3jx86/Hg2EFO
 ggF2iGt0RVPMnliOtbsElm6PrmxCo3ODg8tb7KATgi4k7+yFFMTfFiInCsNbkF5FoZKybQRWbfG
 H0uwmfDImQ5jgB3Gdw+qZesiWrsN96XAKTVVoUzInK58=
X-Received: by 2002:a17:902:f693:b0:295:70cc:8ec4 with SMTP id
 d9443c01a7336-29f2436e844mr18941125ad.51.1765551931824; 
 Fri, 12 Dec 2025 07:05:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCOZzaeFRAwLOwniS/Zo6lEvdDrVSQx380FdsbgtviZVCAir36kb35UhyHGyUIx8t4pDAc8Q==
X-Received: by 2002:a17:902:f693:b0:295:70cc:8ec4 with SMTP id
 d9443c01a7336-29f2436e844mr18940645ad.51.1765551931084; 
 Fri, 12 Dec 2025 07:05:31 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:30 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 21/28] hw/hyperv/vmbus: add support for confidential guest
 reset
Date: Fri, 12 Dec 2025 20:33:49 +0530
Message-ID: <20251212150359.548787-22-anisinha@redhat.com>
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

On confidential guests when the KVM virtual machine file descriptor changes as
a part of the reset process, event file descriptors needs to be reassociated
with the new KVM VM file descriptor. This is achieved with the help of a
callback handler that gets called when KVM VM file descriptor changes during
the confidential guest reset process.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/hyperv/vmbus.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 961406cdd6..4763c0aebc 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -19,6 +19,7 @@
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/sysbus.h"
+#include "system/kvm.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
@@ -247,6 +248,12 @@ struct VMBus {
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
@@ -2346,6 +2353,26 @@ static void vmbus_dev_unrealize(DeviceState *dev)
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
+    ret = hyperv_set_event_flag_handler(VMBUS_EVENT_CONNECTION_ID,
+                                            &vmbus->notifier);
+    /* if we are only using userland event handler, it may already exist */
+    if (ret != 0 && ret != -EEXIST) {
+        error_setg(errp, "hyperv set event handler failed with %d", ret);
+    }
+
+    return ret;
+}
+
 static const Property vmbus_dev_props[] = {
     DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
 };
@@ -2428,6 +2455,9 @@ static void vmbus_realize(BusState *bus, Error **errp)
         goto clear_event_notifier;
     }
 
+    vmbus->vmbus_vmfd_change_notifier.notify = vmbus_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&vmbus->vmbus_vmfd_change_notifier);
+
     return;
 
 clear_event_notifier:
-- 
2.42.0


