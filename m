Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0D2D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvs-0001CR-32; Mon, 02 Mar 2026 03:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuX-00055H-O7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuQ-0001vd-HO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkqEARvLlHBGX6rcIoTK2/5rB5MizOkytAb1OeGUb4Q=;
 b=GEDst9SwxtUhOib6HJN6ypn1ejTNazPE4GTsdcJ5N/Rjk5gt/G1m+z7LTnX2e3TOHKWoj5
 LdwIgGlPjm0VVltlRWh2WyL+riH9mDnXeCjVVl1lBuHfUjq5WkBosiNHdJj7U7cmcXtDP/
 6yl8znh8MYvYn9M/H2b+uNTNjtARQXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-k3qWNIvZOwmpPuLj4BlYow-1; Mon, 02 Mar 2026 03:45:40 -0500
X-MC-Unique: k3qWNIvZOwmpPuLj4BlYow-1
X-Mimecast-MFC-AGG-ID: k3qWNIvZOwmpPuLj4BlYow_1772441140
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836c819456so28172995e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441139; x=1773045939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkqEARvLlHBGX6rcIoTK2/5rB5MizOkytAb1OeGUb4Q=;
 b=djGK90pzXBQIbFsqN2zQXHRju6YrES6lc8AMNFBT9PoBijywZmKkK06prvmmtTrkCf
 8oXr6uqxWAP9F48TIlnbB8gJkdsZuWKLjmsqJIsT1VbZEvnH2mli25YOjrm+UaVj2zQy
 x0u3WOqt3C4t5sjrpLMXA+EfPitW9Fp1jm27RI8UpFf08uS9evUUhlvelR7DyfzMLMpt
 /hAOIimVq4ljAD8PX/itvcaNdLtR7iyS48ndRkgtjOeB5lS6iJ/id2qkA8pmLvRa/M+g
 jm309+u7XuFHH+CGSwc6miBPLly4wSyjDdGe2DBfg4MPtIstC5xYj16u/tif8jt4VXCC
 Qaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441139; x=1773045939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OkqEARvLlHBGX6rcIoTK2/5rB5MizOkytAb1OeGUb4Q=;
 b=iBoMGI8NDB/Kp8jBr2ciXH5/muQ+jGh45SO0pxo9uhfY17yEMgosySeP5pNgdG86DX
 piHFBgKVX7ISVP3kn14rdLfQU7lKNjkNts+8h4r6UyEDTxeEXnbseH9vDctGjAHXYzX7
 ILakrGL6N0oRPPQTDTR9kM6/tEih/LND3uEHw0itPTAYoCm8nMEd07jPH8HWyL7J0DCt
 6fmOO5yLIX2C8VTnnm1o2kLWUL9kioPS35tT5asrxV+k56pVZ15wHfvAgEnBsCVUlalo
 1ybVdLaJCamGX2fhQeM1+lMbhPbVW5/S3K8LUupxjjvh/1Vb8RV81vcWm+qoYyOFN6ue
 N/cw==
X-Gm-Message-State: AOJu0YxmJtc1heyjkXvRPS9ynt87YHC0g0pBmQA8BkLgLfawdwYRvPU8
 CXdu1Q3L7UjMguBX1XhX6CK0FglHR5ygnvgdS6/tkxhzILOmysMIZke3eUuAY8CxYub7dlb9by6
 ubxPbG/69QYWjN+JDWj0T+WxCKGkxnTjpPoeKgRl3Y8u9sZTiFWvBM1/0pZKkJIbrK6ZjaKguh9
 gnfpDirbMXxgyeB7HHnJ0UXM7aZ2VI0aKKv8uo2T26
X-Gm-Gg: ATEYQzz2Z503qMtzTihEsZzBRanLDkpDZ6u5+FuYxCrMtnl4NgYPYJipy7EzxWKj+0+
 4szjojAsHxnAvURYK6ZG9HOzlkmqdMGWm+jRSkIXLoma32j3R0aqokB5mOOKUosU2t4EvomofcU
 eYWydKOIf9b1PFXI5FJNRhszOJEmNaIzC4j9VxMf3USXa5bxoModWA3zkjZFBQRXjhHSXqfiP+N
 mWRkamaWBbrhO8n2wZ0FERKgoVeTXJMFUGkOKInxt/t2lBc87UNvjmfDg/c+T3epqaBrTVvYURv
 PPbw04ReNRkNUjL15IPNC24i3D1Jp63i8+1AotXqWlgLhfWSCSFxTNPOqrYqzJy8oaU5fM697jl
 qc4vSuzOYCQTDDh7qJyal6C5m15TdGaWbLssIo/1MnKXzrivR47cy11KBPxEH+ckrLz0tK4N/+2
 hW4YwYMUoi+BgPnuOl7j4pq8AkaGg=
X-Received: by 2002:a05:600c:8207:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-483c9c1bb0amr228974125e9.16.1772441138871; 
 Mon, 02 Mar 2026 00:45:38 -0800 (PST)
X-Received: by 2002:a05:600c:8207:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-483c9c1bb0amr228973465e9.16.1772441138355; 
 Mon, 02 Mar 2026 00:45:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55d15besm8971971f8f.30.2026.03.02.00.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 044/102] hw/accel: add a per-accelerator callback to change VM
 accelerator handle
Date: Mon,  2 Mar 2026 09:42:39 +0100
Message-ID: <20260302084338.473368-45-pbonzini@redhat.com>
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

When a confidential virtual machine is reset, a new guest context in the
accelerator must be generated post reset. Therefore, the old accelerator guest
file handle must be closed and a new one created. To this end, a per-accelerator
callback, "rebuild_guest" is introduced that would get called when a confidential
guest is reset. Subsequent patches will introduce specific implementation of
this callback for KVM accelerator.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-4-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/accel/accel-ops.h |  2 ++
 system/runstate.c         | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 23a8c246e15..f46492e3fe1 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -23,6 +23,8 @@ struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
+    /* used mainly by confidential guests to rebuild guest state upon reset */
+    int (*rebuild_guest)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
     /* get_stats: Append statistics to @buf */
diff --git a/system/runstate.c b/system/runstate.c
index 13f32bed8cb..e7b50e6a3b1 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -42,6 +42,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qemu/accel.h"
+#include "accel/accel-ops.h"
 #include "qemu/error-report.h"
 #include "qemu/job.h"
 #include "qemu/log.h"
@@ -509,6 +510,9 @@ void qemu_system_reset(ShutdownCause reason)
 {
     MachineClass *mc;
     ResetType type;
+    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
+    bool guest_state_rebuilt = false;
+    int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
 
@@ -521,6 +525,29 @@ void qemu_system_reset(ShutdownCause reason)
     default:
         type = RESET_TYPE_COLD;
     }
+
+    if (!cpus_are_resettable() &&
+        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
+         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
+        if (ac->rebuild_guest) {
+            ret = ac->rebuild_guest(current_machine);
+            if (ret < 0) {
+                error_report("unable to rebuild guest: %s(%d)",
+                             strerror(-ret), ret);
+                vm_stop(RUN_STATE_INTERNAL_ERROR);
+            } else {
+                info_report("virtual machine state has been rebuilt with new "
+                            "guest file handle.");
+                guest_state_rebuilt = true;
+            }
+        } else if (!cpus_are_resettable())  {
+            error_report("accelerator does not support reset!");
+        } else {
+            error_report("accelerator does not support rebuilding guest state,"
+                         " proceeding with normal reset!");
+        }
+    }
+
     if (mc && mc->reset) {
         mc->reset(current_machine, type);
     } else {
@@ -543,7 +570,16 @@ void qemu_system_reset(ShutdownCause reason)
      * it does _more_  than cpu_synchronize_all_post_reset().
      */
     if (cpus_are_resettable()) {
-        cpu_synchronize_all_post_reset();
+        if (guest_state_rebuilt) {
+            /*
+             * If guest state has been rebuilt, then we
+             * need to sync full cpu state for non confidential guests post
+             * reset.
+             */
+            cpu_synchronize_all_post_init();
+        } else {
+            cpu_synchronize_all_post_reset();
+        }
     }
 
     vm_set_suspended(false);
-- 
2.53.0


