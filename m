Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F7D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyxB-0003GS-Ea; Mon, 02 Mar 2026 03:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywY-0002xv-Vz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywX-0002As-Eb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsTvVrZLmqM52PWxCB6hO+fs/DKNlJZKBO6GuZlfP34=;
 b=SDo6GpUPWBiqMS6kPqbvgWTF83CS9QemJb3NMlVhYdKsJTLxSFod012+PcbJ0FROKMQ9aT
 +KK6QrKT7FOnjsyiRgDE4bVz615dQiQyvwgDcuiU2MTXjxAvwlmOQy6eLZtFC3CQulDwCf
 Tzwm5Iy+Coiv+ED0YgquBawnHk94rBc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-wUn_f-qcNOyIsEi_xmieOA-1; Mon, 02 Mar 2026 03:47:55 -0500
X-MC-Unique: wUn_f-qcNOyIsEi_xmieOA-1
X-Mimecast-MFC-AGG-ID: wUn_f-qcNOyIsEi_xmieOA_1772441274
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43997e095cdso2912616f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441273; x=1773046073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsTvVrZLmqM52PWxCB6hO+fs/DKNlJZKBO6GuZlfP34=;
 b=Wufefh9wr58mGS+UF5uwmdFIlQH15fQpPndNcAAbYzDOIJy0N6/F7HdVE0nBuFRbA5
 QBJMFTHoyetbqy2FprHi2Y/6CDO3Ycvtag2QyhQei5Z71fLfUpHLWMKO642zrB4X97Po
 dwnseFRI53Gu2luQyOozOz6tDnEWwH7adDGVPyrP+R1xuizjHAYJ7/gJS321RJbfhFRd
 mTC86umkrLxpZWeH9nHVr5boY52bZDimWhZP2PrRwoRSWCHEE/f5Vr5U8oPewQeIY2oW
 ePO2wG+Tz2ne9iNr1FdxtooQ8OWFM88+6IMBsevDTQLLO7RW+m+cCuX/XbyCe8BMKFFm
 h1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441273; x=1773046073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsTvVrZLmqM52PWxCB6hO+fs/DKNlJZKBO6GuZlfP34=;
 b=UgPbP4uune5AGUBQUPoGkoWNKWzyfc1KSWxw/W0aOh4bW/+EOS26+oV7ionyl5aQEo
 2ShI+7PwRoUUejT6HX9g9FzSZE1FjJdhmyTxuiC7EmxNLJobrAb8AQRxRszrRVoPY6sw
 hMxWO0Tat5KfhAPTUoZpVh3v7UNHKC6oPE3q3YWYh5m+AfCzA+gkNynYd0OCSYyv+cO5
 8gSHb6kbN9tFnqI+Kb58OG+e2vAIsZ6NtyxPI9b5TOUBDyiJruPlXeU3AstAj0LOYuit
 IlVVbNW1Tc9nmqVhSeeRnV+R/eMwS5GWPszgGt0Q2TFLEbjo+EACn/tynPDHwk9Cpo3z
 Ye5Q==
X-Gm-Message-State: AOJu0YzShGcwzNADbmB82PDUu1+oNaUZFA2BmbaNmzGy5JZjSARwODBE
 cyF58G291nJ3nVY/yqGPerZoit6IN0S9gIYYVfuEp8YUGG7Db3EWaTDCbnXYzheE8YiIg8Ivbha
 JZfev1u6SM0t0/QYr7Z8MMHL1DHxh7BGZEntego4rXm6tKv4bNm5MnRO4vLBUx8H3cOKYv4jovB
 5i5ZeqcUol/geeYPEPJzE8Me1uUUI+GZQT3St3BeYD
X-Gm-Gg: ATEYQzzwLFgtA4YwyjIRRWaDq/5ErDoVISeOdP3Sy2NGoQkE3cc/sVpcUK52at0/ST6
 4sEu+3cgBtJ8KjeXZWxb2PcDTqBKpBR2U7KocXKcclDtVXGUA0jFh4rQZ0mFUU3YL0DiNmyKEn0
 HMjz0JfumsJU0MeW63xMglS5cZcQPtV1Hgkrd6KvcIRLpNPmWn/xFWFcEzDvNjA7nKyWbeQ7ceM
 uVKm2Y2T+9Ptjhh+v0zJyh8Cw85k8lQT15WuOQl0o4zKF4PPXq7vYM5RYWyfzlZvhCvQhRZ2D2R
 fll2zFSLG2ZijqrLBgMK8SMTKe0IeyhpSDTCWn0ADbIHke0lumBSmgNiz9RzuUmBusbNQ9S/b/j
 EcDxhaR0Qc4chji7dcwso1R8EwvU4rjh+6vxNP3s6RGOuy95JVEcH5auOL4FrirmBIUwT0Pvg1k
 AwIYj8jN9u6pd+rnbL9SLWKOAolNk=
X-Received: by 2002:a05:600c:46c4:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-483c9c0f34cmr196582315e9.24.1772441273098; 
 Mon, 02 Mar 2026 00:47:53 -0800 (PST)
X-Received: by 2002:a05:600c:46c4:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-483c9c0f34cmr196581815e9.24.1772441272444; 
 Mon, 02 Mar 2026 00:47:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm631883135e9.0.2026.03.02.00.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:47:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 068/102] hw/hyperv/vmbus: add support for confidential guest
 reset
Date: Mon,  2 Mar 2026 09:47:14 +0100
Message-ID: <20260302084749.474955-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

On confidential guests when the KVM virtual machine file descriptor changes as
a part of the reset process, event file descriptors needs to be reassociated
with the new KVM VM file descriptor. This is achieved with the help of a
callback handler that gets called when KVM VM file descriptor changes during
the confidential guest reset process.

This patch is tested on non-confidential platform only.

Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-28-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/vmbus.c      | 37 +++++++++++++++++++++++++++++++++++++
 hw/hyperv/trace-events |  1 +
 2 files changed, 38 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c5bab5d2452..64abe4c4c16 100644
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
diff --git a/hw/hyperv/trace-events b/hw/hyperv/trace-events
index 7963c215b1c..d8c96f18e98 100644
--- a/hw/hyperv/trace-events
+++ b/hw/hyperv/trace-events
@@ -16,6 +16,7 @@ vmbus_gpadl_torndown(uint32_t gpadl_id) "gpadl #%d"
 vmbus_open_channel(uint32_t chan_id, uint32_t gpadl_id, uint32_t target_vp) "channel #%d gpadl #%d target vp %d"
 vmbus_channel_open(uint32_t chan_id, uint32_t status) "channel #%d status %d"
 vmbus_close_channel(uint32_t chan_id) "channel #%d"
+vmbus_handle_vmfd_change(void) ""
 
 # hv-balloon
 hv_balloon_state_change(const char *tostr) "-> %s"
-- 
2.53.0


