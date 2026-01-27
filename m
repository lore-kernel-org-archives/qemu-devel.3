Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934B2D25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSg-0007jO-Sk; Tue, 27 Jan 2026 00:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSc-0007eJ-Uf
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSb-0000EJ-GR
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5C6sP8bU1zvxuy85CHu7c4a3R3EcqLaWP1a8seyGArg=;
 b=NveRxP23Idl1lUvOxb/vwfpuvrN5y7SalcEGMCquZNaoFW0Sv1+7EgHRyLVrnhojrnASCW
 7gHY3cEw1Wm+cw7076E91LUmbfisneh2AlruMkL+Ss5jtSNFYvnwtFzDZ0v/DdelXpJXKc
 RWB9ZbjjRieGBpw7d5Gzy+rodoktYzs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-v5ytG9K5MiewOoq2QYRnwA-1; Tue, 27 Jan 2026 00:17:50 -0500
X-MC-Unique: v5ytG9K5MiewOoq2QYRnwA-1
X-Mimecast-MFC-AGG-ID: v5ytG9K5MiewOoq2QYRnwA_1769491070
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34cc8bf226cso5352438a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491070; x=1770095870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C6sP8bU1zvxuy85CHu7c4a3R3EcqLaWP1a8seyGArg=;
 b=E9LOKJLJkoTu2lID+iEM8RV94Tf4dAjWgMYWMfbUr8/2zndAWPdxfl8Lo3eaAOo8NF
 4G4saEsuUtDS0qbeJWP+boyz2cUNV8zxfPmTO4iC7cmUQLrICld4kHUgkiLKRi3avBfp
 gZhHg89QQDHOrAG2ZwcFz0id89gT+hKPesvaubfX+Vngp24Zvz6L/9hFcFVBB4/mnYxj
 I8NdAcVpkKm4u/3y2u1FtZtl9FvbmCWgVs6vX7D8mpizAzQdHmHUTPuNv7Hb8xfRYlIZ
 1JygxO8HAYTieQGIcGNcKAShNdO+VVS8PqkXr0+Q+KL4QiVusemkI19DPma2RiwhBDC+
 LVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491070; x=1770095870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5C6sP8bU1zvxuy85CHu7c4a3R3EcqLaWP1a8seyGArg=;
 b=ESzYONa6eosH2jEIhmKkNMVGZfnJLe5PnA8FbftYbRbCvwLJcAM6LEpyZ9uJk/0ICk
 Y3CMjJ37V8c15RjsbvB+taaMLQkgzEgjZNJsyJ4K4r+FKAuztZ9RJ2d2PI+JBHZLZk1n
 XUvYtCUMcd2o7hkNegMoULO4jrROoM3qCfvMsB+ACUKFGk8yaLC4gPeJG8qBsQe0AXml
 GOVbi2M+i9w//suxxrndfNvLrAfyUhrLpUO75E0JrRWqwJn2+IbVXxIfmoDXX0o4STct
 UB+4p08LE1X23MreCv1JQsKDvV9fm1h4WvwxY0Ze4Lj7Yuz2l+azAaSQjLbQW8Oh1zUT
 GeFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvS+FSoXAoKeyj+2qFJa0HSsuWUBvYIKTZvtN6wnWeC2OwQaNSi46Q2sQ+lhO2w4P3VbvHjGwlyqG8@nongnu.org
X-Gm-Message-State: AOJu0YztzpqBMx1//T5OSjgHsMnY+yFnwysaTR/DEHKV6Ig0YreQLKoT
 A77cOdF85ZzOSoeB8Fj8Zyh6cmbB8qEBQg8Nv8gFT8gXjkSy1j07t4MH5+/+cNUe0zqY+sjtRFs
 f/TFAIuiEkRwgOkbUzpBhyyrhfp/2k8qrK0Tb+JmvDHK310a8dBlbi3ce
X-Gm-Gg: AZuq6aJ3ApPuMYUmVjX0O7jgNELKDXi38So47vv1+slyySy3KVTPcvjsoyahKa7YL2u
 IGT/9SG4z0m8kDe0fFts1FetXS20bFqbf4EHh9QCHly4LcM6Y1yo3S5pfrHXJFYwK13V2us2hQK
 7+XeXl29POVH1YAChPU8Cky+KoaUI0qZNaY2WVVbBwUSYv68DXngbpHiMx8sRMySzFRGRRIjFiA
 0SkW0ox7uFOQvsqapAQM/OZFgh4GLqBG7BkY1IK/9WjcO84Fds0pR2YVuiZrQ9MJMgN+eQhJTYU
 JGvzxDRKEO2cGS0kXqsUqegaJ+j9wA9LnFWBwQIZMsy3dLSOPZTw/d1yNiR2MfW48sUwp+iriAL
 Wxux0lJPmfu4kBaPqUPICyPyzbq1XLVoeSkm34kdOog==
X-Received: by 2002:a17:90b:1e51:b0:32e:749d:fcb7 with SMTP id
 98e67ed59e1d1-353fecdb174mr760701a91.13.1769491069756; 
 Mon, 26 Jan 2026 21:17:49 -0800 (PST)
X-Received: by 2002:a17:90b:1e51:b0:32e:749d:fcb7 with SMTP id
 98e67ed59e1d1-353fecdb174mr760679a91.13.1769491069377; 
 Mon, 26 Jan 2026 21:17:49 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:49 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 25/33] hw/hyperv/vmbus: add support for confidential guest
 reset
Date: Tue, 27 Jan 2026 10:45:53 +0530
Message-ID: <20260127051612.219475-26-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This patch is untested on confidential guests and only exists for completeness.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/hyperv/vmbus.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c5bab5d245..ff1b6f805c 100644
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
@@ -2347,6 +2354,32 @@ static void vmbus_dev_unrealize(DeviceState *dev)
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
+    return ret;
+}
+
 static const Property vmbus_dev_props[] = {
     DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
 };
@@ -2429,6 +2462,9 @@ static void vmbus_realize(BusState *bus, Error **errp)
         goto clear_event_notifier;
     }
 
+    vmbus->vmbus_vmfd_change_notifier.notify = vmbus_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&vmbus->vmbus_vmfd_change_notifier);
+
     return;
 
 clear_event_notifier:
-- 
2.42.0


