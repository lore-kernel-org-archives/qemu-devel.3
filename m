Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50673C9EC91
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuK-0003fW-Lk; Mon, 12 Jan 2026 08:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuI-0003YM-H3
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuH-0003qw-1B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5Id00LIh2+9ZBejtUIqIXdXBw2c/GTI+LyXgpHZ0vY=;
 b=Iqu5u+567bR28PVDqjaXInXIQ/dnT4lOyYzRNEWLAV7uf8w3/mKDV7KPFloNzd7nCHmGOx
 Ykzs0i6oHsqp+OqyxlPWKj+bpmDpue5rvHQUSeSGoLoVoyHSR3Tke6fAm5pDeywdNSEF19
 8iuD9aZ6/kvRI/HxCOWUJyHINCH90y8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-2HfI4gXnOySqsmzRmA6SYQ-1; Mon, 12 Jan 2026 08:24:26 -0500
X-MC-Unique: 2HfI4gXnOySqsmzRmA6SYQ-1
X-Mimecast-MFC-AGG-ID: 2HfI4gXnOySqsmzRmA6SYQ_1768224266
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34e5a9de94bso12526346a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224265; x=1768829065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5Id00LIh2+9ZBejtUIqIXdXBw2c/GTI+LyXgpHZ0vY=;
 b=X5yErihaRqxEc03p3P0m7z1wJ6zmdA0//pW1xhgvOSNNeQaSO5VM+HhfKUtupjzVYX
 pn8A6tmw6OyHEGT1Rairr9A+6wdZhaIhln/LnzOMuIuo0j3UbjggNPisZSofd5MdSd0f
 KrKELSjFA6Be6hHIUlbzJk8RX6Y5hU9KGRPPUWNZajdJHQVoqFAobwOy9kH4ME1+iKNa
 gmaYBjn74Nm8Qk7UjU7NNJwf4GOPyg0ygiff96bXpLxmMGRbVPq62r82gc4wC1iMdb0M
 /uDtxqJKjcpXB8rZ2g3Sx4K/8GTNN0XhYNjg3c5BuVwcm2d6AWfzwCVIw2IEiqi4Z0EY
 JOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224265; x=1768829065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z5Id00LIh2+9ZBejtUIqIXdXBw2c/GTI+LyXgpHZ0vY=;
 b=ezG9RE3nuFPUhY7SQsu/YH8JUHmDB+euVopWB2phDcbCFeS5ZXwzB4JQDIM1jtSnl0
 vtyBbvROTCX7d98WTwuTBzu1uzKRS9rjxJbfkKElC7MStI+HgDRwheg/abtQsnfQ+i1B
 X+83rWzTKQBR8CH6UQucHBXOrMj/54kkXn/MBLs3uBwda9v2BRuzdKvnAGi5kMBfZxxe
 oMMZbC1+aJYjrFCFOCMaDO1QSHBFRavl53a9wZPh/4/oAhCnL0gaeUAna/Y1dK3PoH9N
 ThHmXMJ36CsvvqywuwvUN1nVjQjn+aIZkMoa5GhkIih/HfqteskE14dJCtNw0VIX7Vpb
 UjJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqRsTOoxCBD0GvbPO1W3oPgAMxvU8VbuCJsTs2ztDiQXJEEAfhkBaYGwGrvmuxPX2ip23wsvINtt+D@nongnu.org
X-Gm-Message-State: AOJu0YyRTBz7xKUpWzsksufS50zG7xQ4KgltgCtbpx8Oe6KoqgD9Jp6M
 VnZGU+s8PqPPDY03YT7gXEtxrr0P/mjy21bPJDPZzq+MFniy68yVrjGnOtjlrw/QYmepr+8h0jr
 J5DVu4Q3fGKX+5O4w08QkKCN59sAy7MUVUzQFn5UtHXZA2oeYDSTvcpq+kQ9p2/sc
X-Gm-Gg: AY/fxX5T6VsdoJCyYVcfLEGH1iE+TWnzAtmFnVruj4lnqxucCzvmaCVcLAomMTfzgyy
 ZkQbZGKkgmgPUUj5d9ruVKt4vu2MdIQ/UbWiAhL0ly2E4taMs5WnZ2fZhnM93ik47vyqWIAwtcz
 CBuSFmvuT2RDnZdYNHKaEC8JVZxe/km8HevcVNKMj50xndBEhJlenLzPrfp5ej+4A1ydECr28/+
 JRbB5t1l7y71UgrlIXCHdvl3sCent8pPHDj/qjHBBFNZCEzcicbC1Cd+Gn6uxLaZNXIaaGDPtyb
 QnvMOTrdQh1+6UhQ7OiavFqtkkcNWTvZvFzkSwCrF77e/oZ3LxquOFG3oIKBjF/tLG5IGvoudwT
 1XsJlNJEv//+dTb7TU8wYigctEW7+v9Rybfkz/X5X4NA=
X-Received: by 2002:a17:90b:4c11:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-34f68c7a647mr14962414a91.5.1768224265583; 
 Mon, 12 Jan 2026 05:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRQkvYubhnMVgKak+JgKwZBj63oDmTdKTQFrGpe5hmh7o3S0YUxy9JRuoHnvx3oExxFNRlrA==
X-Received: by 2002:a17:90b:4c11:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-34f68c7a647mr14962394a91.5.1768224265213; 
 Mon, 12 Jan 2026 05:24:25 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:24 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 23/32] hw/hyperv/vmbus: add support for confidential guest
 reset
Date: Mon, 12 Jan 2026 18:52:36 +0530
Message-ID: <20260112132259.76855-24-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 hw/hyperv/vmbus.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c5bab5d245..947fb7f4f8 100644
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
@@ -2347,6 +2354,26 @@ static void vmbus_dev_unrealize(DeviceState *dev)
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
@@ -2429,6 +2456,9 @@ static void vmbus_realize(BusState *bus, Error **errp)
         goto clear_event_notifier;
     }
 
+    vmbus->vmbus_vmfd_change_notifier.notify = vmbus_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&vmbus->vmbus_vmfd_change_notifier);
+
     return;
 
 clear_event_notifier:
-- 
2.42.0


