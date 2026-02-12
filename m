Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0551AEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9C-0007Zo-AU; Thu, 12 Feb 2026 01:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ98-0007ZX-Dn
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ96-0005CZ-QA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHG3b4cYl6HI67xkeHbu34Z6D7hlRIGcfFnOo5hYIvQ=;
 b=cP9E2Q/6pst2irkWygASgIITGWU+YpRnjYt4x14x3KD8d1R0/yg4TE5W+J2V4dwMgt8zzs
 LwQO05vu9a4RkbsPjEsAyXOY6tvdIYgg2rjTww+9/GAVxpfvgoexyPTFNlLO0K9CZfE6TR
 HGezEqe04ouhAKcDqxh6KUV6tg4vrDE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-JwjOEMXTNNCiBsdiSpp4oQ-1; Thu, 12 Feb 2026 01:25:46 -0500
X-MC-Unique: JwjOEMXTNNCiBsdiSpp4oQ-1
X-Mimecast-MFC-AGG-ID: JwjOEMXTNNCiBsdiSpp4oQ_1770877545
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354bc535546so5945613a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877545; x=1771482345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHG3b4cYl6HI67xkeHbu34Z6D7hlRIGcfFnOo5hYIvQ=;
 b=hRb+BmHcO7v6aPdgMQLaxI2Q3xkkGvq7DL0kSQ+eHg0tQ6BIospgeAmMDCGxYcUkHy
 V8Yz554xQibGfO5TBTozUqB8J/RHXK/FU2Zh9Dm7RUM6GUIu7Bmafpjlj0P0a4ymWVo1
 Wp3pyLCW7kuvVeU2QnZ8a6QjS6ROtAagfREbPx42jsQxTqOu+v6gv1AWlNHyZpmx+SXS
 JSNx1+HGgT2qgBZAinJxfop8zk93prL6HpSgFnjh2oI9I527Hs2GrthLn54JroO9oM/a
 IyhVPLqLMmyh7JZATHvdOEjCBSSgEKTD8jjx3wg5+gWFReHR5eMxmgx/6GQ2+RcWryb+
 eLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877545; x=1771482345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHG3b4cYl6HI67xkeHbu34Z6D7hlRIGcfFnOo5hYIvQ=;
 b=DA7AT7sYC+SsUN981OtVGCrt0M4XZVC7mB80Oncpt3TLNyZN0MAgLagsxhFysAjPPG
 immBxmKICM6LmOodEKxe8YxddPqOC35c1K9BLUSwUo4PUUNO2VDdNdOkZfGBqjrjuk7J
 D3uHHTi5Sp0vmogXqLatbdlaH85dAH93gK5QlFDw474et+0alXxgjWSQohDA4fPSD69F
 621/0FrJdbz6eD2KaEE/oNUTrCmH2zXZOSWEAFJmsoakv0AzpuP+TEl3+BrPOF0qWTjO
 MYDOvS8bYek+cRhTceJC+cwg5miUkP2Bl4HqI36LmnCTesrReAWzgBj7tqCOHESsz9mO
 tMSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW28v9EBclQO/6P2hsywr9unGUixGtWLFbgxBSKsTpfiS2bomJ9Y6NiOGfgZ6hM+6uIYzvvMzJfVbnW@nongnu.org
X-Gm-Message-State: AOJu0YwPvtVShfm9nh/MpoWFAvHhOQ/Cd0XuL5kXHXGOVoeY5CSl1TSK
 6foGHnKvtaj1dHgaKTpOuCZGU51ccSDFF+Mr16k8NAeJRXnUJiRNATL15jb3EjDIUO4C/0rEKoN
 NU/xTkBqQXanTNkA/1JTxJ2/Pdlj7lSPWHcNsG76qYLeBHA8dW0/XlxIr
X-Gm-Gg: AZuq6aItbKqjb3dC+/w3MGrhonWI4GW0XtdisraOG6s4jv0OWfYZCZPXlHftbeS5Ciz
 UrHaVBSaU5bfWXNq9OO9HucI0nE/FCoTxdDszWnQV1TOWRGWO6iw0q42drDgf+lkOeGTyU2L6El
 G8oLkVauHCIQZAuI/tI0ok8XpgN5/W5GRAnCcnYH/JTO0qpRLeylNRgs9mCkodI4wS9xA320tfu
 bfNItN3wmvwh6+ZrWsUo+xa2tdFVmmhL/GSlWMe8kZqSlwXIXrEsk3qhDF9pajBZuIvR/HLwH8c
 45gAwLfIQ0HpoqVSotlSSlNi6DuRbtkgB+IUvWIYRqOTaY1WUI2FRltoPIKEdtXHY5EtknJAD7P
 4VsE+EVYL+25R8yLE68Nr1fGHmPVidV4URr/26obBwYATjB1LZPLrhX4=
X-Received: by 2002:a17:90b:5289:b0:34f:454f:69a9 with SMTP id
 98e67ed59e1d1-3568f41a0cdmr1587793a91.28.1770877545225; 
 Wed, 11 Feb 2026 22:25:45 -0800 (PST)
X-Received: by 2002:a17:90b:5289:b0:34f:454f:69a9 with SMTP id
 98e67ed59e1d1-3568f41a0cdmr1587776a91.28.1770877544747; 
 Wed, 11 Feb 2026 22:25:44 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 03/31] hw/accel: add a per-accelerator callback to change
 VM accelerator handle
Date: Thu, 12 Feb 2026 11:54:47 +0530
Message-ID: <20260212062522.99565-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

When a confidential virtual machine is reset, a new guest context in the
accelerator must be generated post reset. Therefore, the old accelerator guest
file handle must be closed and a new one created. To this end, a per-accelerator
callback, "reset_vmfd" is introduced that would get called when a confidential
guest is reset. Subsequent patches will introduce specific implementation of
this callback for KVM accelerator.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/accel/accel-ops.h |  1 +
 system/runstate.c         | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 23a8c246e1..998a95ca69 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -23,6 +23,7 @@ struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
+    int (*reset_vmfd)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
     /* get_stats: Append statistics to @buf */
diff --git a/system/runstate.c b/system/runstate.c
index 5d58260ed5..0a74e3ade5 100644
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
+    bool vmfd_reset = false;
+    int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
 
@@ -521,6 +525,29 @@ void qemu_system_reset(ShutdownCause reason)
     default:
         type = RESET_TYPE_COLD;
     }
+
+    /*
+     * different accelerators implement how to close the old file handle of
+     * the accelerator descriptor and create a new one here. Resetting
+     * file handle is necessary to create a new confidential VM context post
+     * VM reset.
+     */
+    if (!cpus_are_resettable() &&
+        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
+         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
+        if (ac->reset_vmfd) {
+            ret = ac->reset_vmfd(current_machine);
+            if (ret < 0) {
+                error_report("unable to reset vmfd: %s(%d)",
+                             strerror(-ret), ret);
+                vm_stop(RUN_STATE_INTERNAL_ERROR);
+            }
+            vmfd_reset = true;
+        } else {
+            error_report("accelerator does not support reset");
+        }
+    }
+
     if (mc && mc->reset) {
         mc->reset(current_machine, type);
     } else {
@@ -543,7 +570,15 @@ void qemu_system_reset(ShutdownCause reason)
      * it does _more_  than cpu_synchronize_all_post_reset().
      */
     if (cpus_are_resettable()) {
-        cpu_synchronize_all_post_reset();
+        if (vmfd_reset) {
+            /*
+             * If vmfd has changed, then vcpufds have also changed.
+             * Need to sync full cpu state for non confidential guests.
+             */
+            cpu_synchronize_all_post_init();
+        } else {
+            cpu_synchronize_all_post_reset();
+        }
     }
 
     vm_set_suspended(false);
-- 
2.42.0


