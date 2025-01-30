Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5C5C02194
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUPq-00084Y-8Q; Thu, 30 Jan 2025 08:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOw-0007O7-Rp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOt-00006t-6Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qV+61rvCL4A0t8T5oUkBk1b0e0MFCHm3CI8peZGVBkU=;
 b=eGiGVgNp2wJeVDaE04Vw1QQiDHlE9wwMInIPlnJqfcuhXD2kGaCbR5NAQ55HPZfNadBJDq
 gFU5FQGUzSjD53WM5lCJhSPzKwdCn5lirYMeY4TnSyyF3JyS4kX0FebzYmmXQKWslTMIS9
 iSsbRAL8EP/dyw3AtKW5gQ6wcHarXgs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-HPCoOzYHMJu39-l2FkUQMg-1; Thu,
 30 Jan 2025 08:16:05 -0500
X-MC-Unique: HPCoOzYHMJu39-l2FkUQMg-1
X-Mimecast-MFC-AGG-ID: HPCoOzYHMJu39-l2FkUQMg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CD8F1801F14; Thu, 30 Jan 2025 13:16:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEA4D30001BE; Thu, 30 Jan 2025 13:16:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 10/20] hw/s390x/s390-virtio-ccw: Fix a record/replay deadlock
Date: Thu, 30 Jan 2025 14:15:24 +0100
Message-ID: <20250130131535.91297-11-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Booting an s390x VM in record/replay mode hangs due to a deadlock
between rr_cpu_thread_fn() and s390_machine_reset(). The former needs
the record/replay mutex held by the latter, and the latter waits until
the former completes its run_on_cpu() request.

Fix by temporarily dropping the record/replay mutex, like it's done in
pause_all_vcpus().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20250124112625.23050-1-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3af613d4e9..b069303592 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -48,6 +48,7 @@
 #include "kvm/kvm_s390x.h"
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/s390x/virtio-ccw-md.h"
+#include "system/replay.h"
 #include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
@@ -454,6 +455,18 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
     CPUState *cs, *t;
     S390CPU *cpu;
 
+    /*
+     * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
+     * process the run_on_cpu() requests below. This is safe, because at this
+     * point one of the following is true:
+     * - All CPU threads are not running, either because the machine is being
+     *   initialized, or because the guest requested a reset using diag 308.
+     *   There is no risk to desync the record/replay state.
+     * - A snapshot is about to be loaded. The record/replay state consistency
+     *   is not important.
+     */
+    replay_mutex_unlock();
+
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
 
@@ -533,7 +546,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
              * went wrong.
              */
             s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
-            return;
+            goto out_lock;
         }
 
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
@@ -546,6 +559,15 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
         run_on_cpu(t, s390_do_cpu_set_diag318, RUN_ON_CPU_HOST_ULONG(0));
     }
     s390_ipl_clear_reset_request();
+
+out_lock:
+    /*
+     * Re-take the record/replay mutex, temporarily dropping the BQL in order
+     * to satisfy the ordering requirements.
+     */
+    bql_unlock();
+    replay_mutex_lock();
+    bql_lock();
 }
 
 static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
-- 
2.48.1


