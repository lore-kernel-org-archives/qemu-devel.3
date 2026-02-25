Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162F7F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wB-0002sb-9H; Tue, 24 Feb 2026 22:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5w9-0002ii-Vh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5w8-0008Cm-5S
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R07URKEIXtCEvRwFxvKOZVapdXn6mm8J0XkXEtg38ug=;
 b=DkZym64XPZQR61tfr3Uei8RiNcuqX7f/Gh/pM4Q8JzAgjS04gxKlmWpKQJuxLNOyGtQG9c
 YZFSM+ptKtT4AcNmiEtflQLSrFZp9li3+cFuBDWtqdZy1rAa5Li/LtFf1memXrLgy+w+lB
 Cy0SEAvwIhjzQ3qYVxxa92ZpJEnsnF8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-G8GPAF5_P36umxY9O85MVA-1; Tue, 24 Feb 2026 22:51:40 -0500
X-MC-Unique: G8GPAF5_P36umxY9O85MVA-1
X-Mimecast-MFC-AGG-ID: G8GPAF5_P36umxY9O85MVA_1771991500
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3568090851aso39982319a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991500; x=1772596300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R07URKEIXtCEvRwFxvKOZVapdXn6mm8J0XkXEtg38ug=;
 b=jYY5Uk6qAeDqwiyNsjgpQ0Wax1TD+XTImFg7R7mX3NNRBkOpxWgClq8H42aGsZSGjU
 4PJo7RPPUUXB5606RY5viqycSRYGQEXjO4p8lVbpi3NF4ziJVxZo6bTe3KeGo/8tzxFc
 q1dPlX4UYzgYQ261nU1Q1akA3TighKI5b784n9Sg86T9YjSSrNa8siwjC7AddgouPOyO
 rFxNZF9x0i52c1eKvsAGJwd+zvwiQJpIdqdnjpbjpn7Vd6jNr+hR63gHeY6KZKb+XY+P
 xuqR/jPO+4KirTdv7s/Y6ou0scz3faIgZIfNMSVE7vTRm/yg3+uGZb+QBIlYIJrCWMay
 S27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991500; x=1772596300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R07URKEIXtCEvRwFxvKOZVapdXn6mm8J0XkXEtg38ug=;
 b=fHbFVDFa0S50R+SJ1+M5wDIWby9B3056IN7laiN8UJDmsCzdH8Rv4HFAQBD1e+3num
 IIjeOndVsVPnAhhxeSjSgpeqxdoVUwISCoPFcVALrTwBMWbopoUpBZ+PULGuDvA67/Aq
 tv3EN+KhaA8DFwz6wcBhGo2S5YXlS6LPA/udESvSZkiR9kXLMc/1NoXrodRj3AHU/DCv
 AhkBfk5U955yJPY3XRKdro+m2/ABNp8S2E0jZtaHegTe/DWPNbc0IhgUfOJy1ynejk9c
 /hfQIuPs45tcy6J2aEkG1523BAjM8x5wG8Pc8N8pfrWHbbDN0qvqbtf5X4Uw7c6GbeiV
 EsmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDEf/6NCLGEr+Krzk/IrElH+BD4NPVWtErhSx982EHkBzueVITTAoeE/uh5DP8vCsmr3dxtKuxY8mk@nongnu.org
X-Gm-Message-State: AOJu0YzP1O7TUDDI/XCwIn1k6nsjVcnYt7Wdc7gqJpxW+j6Qe35AqZBE
 pK6/Qqh64vqVI2w4TgOPTOAo7ogTUWvNl0KLwiKkTUCpQRvd4brijUWC7bbP0Ro2LdSWNv47Ykc
 7ED1yUy8L92tCY5QKXsN4g+xaXkB7OIayhMS6m2CCtdWSLLcnNMWwY5kW
X-Gm-Gg: ATEYQzx2TDiR6pqnZhSZQs8DB3MzSyBZp4QI0i1Hd2jPX9rXSJDrHCHfKHmt0rV1wLa
 i8sVhBgnxRhaBpss/su2IyZUWDpCb/6cvosCKCfl/bIddIS/n8VCB0SydsB/cQGuQqJXuvAwu/F
 pJ5ofxGrZeRS8HXkv08JhYbN2gKSRgJsyqdvsDf0rSR2gbk5ufltTsgctBS3o8sFwkl0ZCS9lKg
 PlH3plm9RUeND+5z5tCC5sWfgp+8Yxitj8ZyOAyS6ilG1e+L4qZYU1RK15iWbXm+p7rqn+IZ4bR
 Vw2PeUqoL2c2f3qP5vsOcD2yZQ10ocafFKAME6ZmEZvfz0TuOXU6NlLKYSLvF1bBC0BsXLWZsF0
 Ojqng3D4z8ry4scHkJvh9CNYqiIVA3/6TEqgrdEead+fWlXZnMOOhewc=
X-Received: by 2002:a17:90b:5546:b0:356:41c2:896f with SMTP id
 98e67ed59e1d1-3590f01f4e5mr940556a91.7.1771991499839; 
 Tue, 24 Feb 2026 19:51:39 -0800 (PST)
X-Received: by 2002:a17:90b:5546:b0:356:41c2:896f with SMTP id
 98e67ed59e1d1-3590f01f4e5mr940541a91.7.1771991499474; 
 Tue, 24 Feb 2026 19:51:39 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:39 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, pbonzini@redhat.com,
 ani@anisinha.ca, qemu-devel@nongnu.org
Subject: [PATCH v6 27/35] hw/hyperv/vmbus: add support for confidential guest
 reset
Date: Wed, 25 Feb 2026 09:19:32 +0530
Message-ID: <20260225035000.385950-28-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

On confidential guests when the KVM virtual machine file descriptor changes as
a part of the reset process, event file descriptors needs to be reassociated
with the new KVM VM file descriptor. This is achieved with the help of a
callback handler that gets called when KVM VM file descriptor changes during
the confidential guest reset process.

This patch is tested on non-confidential platform only.

Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
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


