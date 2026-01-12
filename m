Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6716C9EC86
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHp5-0003nj-L4; Mon, 12 Jan 2026 08:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHll-0001d3-Pz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlj-0002ce-0S
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oG9Dsze0JU1GCFIaRY/UGoIwmjHYD7VTV+1WbSmKAZo=;
 b=WJL2aKF1RajyIlZKsRxbOCQZkCnpIa26fDprqsi/3CRgGqtNog2c0m1VwZjHf8/bnxyzPz
 VP1lvgUu6cA9Qo3zp3D0nKSZifFVQ7HJ0fwW0E9uZgylGvko9W6DUp1LIdgpYB1MxCn3ES
 ECWU1zMVoQamFYtQeAPxOteMKeLEusQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-wyUBvxG-MSCeg-jkX7WDgw-1; Mon,
 12 Jan 2026 08:15:32 -0500
X-MC-Unique: wyUBvxG-MSCeg-jkX7WDgw-1
X-Mimecast-MFC-AGG-ID: wyUBvxG-MSCeg-jkX7WDgw_1768223731
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29D4318005AF; Mon, 12 Jan 2026 13:15:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5473D30001A2; Mon, 12 Jan 2026 13:15:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/15] target/s390x: Un-inline s390_is_pv()
Date: Mon, 12 Jan 2026 14:14:55 +0100
Message-ID: <20260112131457.67128-14-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Inlining a method which use a static variable is really a
bad idea, as it totally defeats the point of both concepts.

Currently we have 12 + 4 = 16 static 'ccw' variables...:

  $ git grep -wl target/s390x/kvm/pv.h | fgrep .h
  hw/s390x/ipl.h
  $ git grep -wl target/s390x/kvm/pv.h | fgrep .c | wc -l
        12
  $ git grep -wl hw/s390x/ipl.h | fgrep .c | wc -l
         4

Fixes: c3347ed0d2e ("s390x: protvirt: Support unpack facility")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260107130807.69870-16-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/pv.h | 24 +-----------------------
 target/s390x/kvm/pv.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 94e885e9335..e266fc3d545 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -12,8 +12,6 @@
 #ifndef HW_S390_PV_H
 #define HW_S390_PV_H
 
-#include "qapi/error.h"
-#include "system/kvm.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
 struct S390PVResponse {
@@ -23,27 +21,7 @@ struct S390PVResponse {
 };
 
 #ifdef CONFIG_KVM
-#include "cpu.h"
-
-static inline bool s390_is_pv(void)
-{
-    static S390CcwMachineState *ccw;
-    Object *obj;
-
-    if (ccw) {
-        return ccw->pv;
-    }
-
-    /* we have to bail out for the "none" machine */
-    obj = object_dynamic_cast(qdev_get_machine(),
-                              TYPE_S390_CCW_MACHINE);
-    if (!obj) {
-        return false;
-    }
-    ccw = S390_CCW_MACHINE(obj);
-    return ccw->pv;
-}
-
+bool s390_is_pv(void);
 int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
 void s390_pv_vm_disable(void);
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 2bc916a5455..3d508165f34 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -25,6 +25,24 @@
 #include "target/s390x/kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
 
+bool s390_is_pv(void)
+{
+    static S390CcwMachineState *ccw;
+    Object *obj;
+
+    if (ccw) {
+        return ccw->pv;
+    }
+
+    /* we have to bail out for the "none" machine */
+    obj = object_dynamic_cast(qdev_get_machine(), TYPE_S390_CCW_MACHINE);
+    if (!obj) {
+        return false;
+    }
+    ccw = S390_CCW_MACHINE(obj);
+    return ccw->pv;
+}
+
 static bool info_valid;
 static struct kvm_s390_pv_info_vm info_vm;
 static struct kvm_s390_pv_info_dump info_dump;
-- 
2.52.0


