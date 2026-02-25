Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DF8F55455
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5ut-0007HC-Bc; Tue, 24 Feb 2026 22:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5ur-0007Gw-Af
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5up-00085o-KS
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILLZe/318SI2fwBccfO7VLFYXHx8OHK07juZHL2pnss=;
 b=iH8fqPRnbo8D1PpgLALG3MieKJg8iqIWO+kWPN0WNZHQPwz3sLNvEjpp3jf/asSJIpSHV9
 AKZRa6YX1jY+pnltD4GEuFaq9HInp9Y0Ye+LO7t+KLXuPvogJ6lnDEQ/lC0BhCubv90tU2
 KlTXN2puP5wfOrVJezjJZWfUoz/vEDw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-mUT6yYVNNNW_qbkFeadM0A-1; Tue, 24 Feb 2026 22:50:20 -0500
X-MC-Unique: mUT6yYVNNNW_qbkFeadM0A-1
X-Mimecast-MFC-AGG-ID: mUT6yYVNNNW_qbkFeadM0A_1771991420
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3568090851aso39978451a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991419; x=1772596219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILLZe/318SI2fwBccfO7VLFYXHx8OHK07juZHL2pnss=;
 b=QxYFcNUf6mUTxbuIicD3/9IFFc47ReRDKMX4OwIvkqnG3u+Qac33+xqfvFmQRYzZDn
 P0hyldCFQYris6NjuD/ejx5D18Oef3YKBiQgf2PsgNTbnqgYe6fR3O1ztaB2mVDdW9nd
 Cv9BHO6ydMrPKBuWHuNd/PdUX66l8okz5JECuM8vPWWMFr2m4dZVcDNaJNL0wvnhX9i6
 GKs+UN3Y1baVQ882Ut2WVI5mlkxQeTLHD3BrzPk08W1OrO8nPb4ARJyZ/7FGi+66GcG/
 lXLyvURqj920AqUdmn8fI0kiohZciouv7sWFA1ZUu1YmMBSwxR8/uJjZp0Q/2f4DmHYa
 Gadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991419; x=1772596219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ILLZe/318SI2fwBccfO7VLFYXHx8OHK07juZHL2pnss=;
 b=eZOOgQa8nEZOXFtqlVBkKEElpxK8IL6/+w+/ZJdUh4UDvtcIFLimleAXYsGSxi7tdr
 xf9gLbb5sH+h1dhqSCd8eXkLp3CzevSImdlg/cP43MTCae6v321wturqJxvzLjR2CaNH
 TI7oe/9pX0hEur9Erxe2WUr3pyeXBYzAnuE8TGxxzkCym0Z7nQJczKGJFd7HEGfjYwZ7
 6HtZ4mz9FHccFBT32D3k3vagQkY7kQiz7rf3+fjWrra9A/JBJc3xrwADtWY32sp+hkGI
 8WHUUEYD5WpSQ0olisKrV2KGGD19NZPIhmgu5DiwpGl26/pEegisPDngccuTzImlPVs8
 eeEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj6QnCxb7be+iosUgda2W445/OiEakES5wKKLZy23JWwe6neH8KVsbcQgTIPD0KkpLIeLS+5iNhdDS@nongnu.org
X-Gm-Message-State: AOJu0YywWxWTpqt+uY2B2qyplUgNCN5JBBKgiy3a1Lc+otTxL2+sxxIV
 As3lRrUJON+4usZyRzUK4dE1khXLHOaDMOiBqxoNS0HnzWd6+Y6yjfp0Ea0OuEXfst9uPTbAsdT
 CNOXfNB4IP4GAryBIXwJOUSUfO/+FGFwnfGjr1CBORtYKUue2LYaqS/7U6QuqjvzA
X-Gm-Gg: ATEYQzzcKS/5GV9Dnv/rIvHwFJJI1KV1/FrfKHjWxgPovkboKJyIeEjgXeYgkNlxNW/
 /3vIwzjeQO8RDsjQTdFj7R5cefDymahAt9ISq74JKUiKVevHP0h+uXTByyAdASBT6oaB7zRaL5W
 0lC4Tn3yhldpu8QXquhnaiDMPrx9oVr04QbVmuB0wjdlQk++jI/XNpU0Zj/G33Zd78cvr01qGUW
 IGppdqy1o7EO+RF90tmLQftpsSkTmbZnl0Lwk7zpuJYpph1j81wT4Rptgz4t/Vj4Xa+LH0wBBJt
 MLbltaAcMw6CYCBvBy/fvMzmHhwJJzrfW7YnUE4xdfyxcC5whrk3naYqzORsUBgUfNLKpatouso
 92SYDSlZD2jP872zVpGkY6cnavvvO/XIbTjruwWas/HwpHR4S6jfHN7M=
X-Received: by 2002:a17:90b:2e8f:b0:341:8ac7:39b7 with SMTP id
 98e67ed59e1d1-3590f1bd78dmr861963a91.25.1771991419417; 
 Tue, 24 Feb 2026 19:50:19 -0800 (PST)
X-Received: by 2002:a17:90b:2e8f:b0:341:8ac7:39b7 with SMTP id
 98e67ed59e1d1-3590f1bd78dmr861945a91.25.1771991419047; 
 Tue, 24 Feb 2026 19:50:19 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:18 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 03/35] hw/accel: add a per-accelerator callback to change
 VM accelerator handle
Date: Wed, 25 Feb 2026 09:19:08 +0530
Message-ID: <20260225035000.385950-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a confidential virtual machine is reset, a new guest context in the
accelerator must be generated post reset. Therefore, the old accelerator guest
file handle must be closed and a new one created. To this end, a per-accelerator
callback, "rebuild_guest" is introduced that would get called when a confidential
guest is reset. Subsequent patches will introduce specific implementation of
this callback for KVM accelerator.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/accel/accel-ops.h |  2 ++
 system/runstate.c         | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 23a8c246e1..f46492e3fe 100644
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
index 13f32bed8c..e7b50e6a3b 100644
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
2.42.0


