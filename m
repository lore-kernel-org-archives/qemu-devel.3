Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30926E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfz8-0004hJ-4t; Wed, 18 Feb 2026 06:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyY-0003xJ-Ix
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyW-0007wy-6R
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uA6s98chAA/AAmOAgTNuehQ1wNW/fEWldjPI7yvg0g=;
 b=DfvG/Oom3/33HqQTMYzFdPMPMkS7wmibXerdxwg+nOTXOhNCL4e157TI+e02N/5/bcHadf
 dc++NUYLToljt36W+qf9dC3NMQzQZBlHHaz+gaPYXJpLvKJloVKGTMzGP0EZoiY31D0n05
 tkzPXwOxw8VeuWENRf5Xg/ktx4m4OoM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-XK4BvaTUPNCAPbHntx4L4Q-1; Wed, 18 Feb 2026 06:44:07 -0500
X-MC-Unique: XK4BvaTUPNCAPbHntx4L4Q-1
X-Mimecast-MFC-AGG-ID: XK4BvaTUPNCAPbHntx4L4Q_1771415046
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aae146bab0so63755095ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415046; x=1772019846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uA6s98chAA/AAmOAgTNuehQ1wNW/fEWldjPI7yvg0g=;
 b=HOU3jw0KVFsD59ZdibCENJdf3M0eVNMDgjCYd14lr+hsKqBRkh6WHf2BpM1KMzdEM2
 rfy6rEQPvwtEjDciRyU2pNNDr7APGaRn78BmFxbEStHdw5tlDY6txIQFbePgqX5YJEjp
 TWsiwP+Kpfy/nOIyYiuGm2aiUITZBO5FgARUb869Eueqmb9hTSxbEaetaAjYkhoOkjGI
 91eKHXFSExw4GJfzmixgpggcwbs1VA5lc/vPJ2dTUYf1X1UGZcdrDSlhHZNg7i+7UwHs
 YFFnw3xMtNWIXNr4rsPQ/eSsz8BDQaI3GwiBKadXgv9lymA3TGxQtbGO8O2G52cthIxp
 h7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415046; x=1772019846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2uA6s98chAA/AAmOAgTNuehQ1wNW/fEWldjPI7yvg0g=;
 b=p1d3lgsQ8bf8ozgAHWIXTz7gx6A+YaH/w9jx0jJ06PWFNnmjPT6s41I3VlB77y9MNo
 RowShnX8oK0kv1SXhM+3QVQgSB7ETyu01d3nXXntr23gtRpRsHidQaBYt5Mfkz7zQecn
 Kbb7NXyS5zVA8ZJPFZr+Id5UAHojw2QsVyIdf/lLLgdzYooCaLiJCB7JH7Zp4gNd6pzS
 AG/oW/ByhS+w4pbtqqCb+BOuUNcvsj77XGz6neTkJuwOxtqVV4OoqXIIP0QN6f45jQ64
 gYakx9xzEaULR08OkllmTd6HxoLMDUA2X86tR6liFHnEVDYy/TUEDgMWnSqUdeCwChh7
 TGTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0W9xvfYeEaA+go4xwAX89BNI6Tr6PuETjsErktYYBJYgoe6RM2EAcOGf1D4632+de/fzPAyyCARX8@nongnu.org
X-Gm-Message-State: AOJu0YzysEOZF/yllosK0mvff6qK7SERqjp/Mfef2k7xj2eaSGWnpCTx
 bQQrwEMljo/A0MuXFs4/fd6Rt9n6Xj7DsiFrA0wxr3JrgMmJOPQoy4l4OPd0iDgnIgPA/YipNEF
 /SMEITgLxgyRaSzujjCgr+stNVGEfCh8CH7rkeqlWjQZSf1dvqPUZdymZVmNpS7bs
X-Gm-Gg: AZuq6aLmIogDmTDyv1+EIxUeOZdhNxTS1cCRNMv7cimX1UZZrMkrMGQ+Ooiti/fvSCt
 ESSxJ981fOw9+MtsajDE5BUW5eV4J/VUeN1YnYDLsC1JfgvxgA6eYWTp8qwlKGL2xnnJGHsl4Yq
 WqZsfiUXx9jOgbOJDgkqd12bkD5pnH+JWDYIkanmrTaLFA+a29c2CH30lXg9h8HTgODlkwcPkZf
 o7HfE0R0BIUqrKJX0TCqpdQqr0pA+MF3oJbfYWcVHXWrFRsPJrMWcrz7NMnNniqaVAsAj0Xp++7
 cZdQ4lf+vUJidCBG3ClgETghEZuy7hSABI7jjHItrbplxAK08qp1U5aB4nED8o2FcbK2SIxFL03
 sspCZh/j5TDNiF8Lf8q4GvUEkNEkNvt8crPh4AlT8rLCwTSAiWQOh
X-Received: by 2002:a17:902:e945:b0:2ab:3cba:4307 with SMTP id
 d9443c01a7336-2ab50569fbbmr164911755ad.22.1771415045868; 
 Wed, 18 Feb 2026 03:44:05 -0800 (PST)
X-Received: by 2002:a17:902:e945:b0:2ab:3cba:4307 with SMTP id
 d9443c01a7336-2ab50569fbbmr164911625ad.22.1771415045480; 
 Wed, 18 Feb 2026 03:44:05 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:05 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 26/34] hw/hyperv/vmbus: add support for confidential guest
 reset
Date: Wed, 18 Feb 2026 17:12:19 +0530
Message-ID: <20260218114233.266178-27-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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


