Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E103F4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25No-0006Gi-0n; Mon, 16 Mar 2026 06:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nm-0006Cn-Ci
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nk-0003Vm-1y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4W4qeaP2X0EzpJZ8hX+fOD64HVkp+XOO4VlC2trcGo=;
 b=Cn+L2NihdqrnWjVvQCl/lTmfcG3Wd6WAbt1o3b/wKmmsExN6JEa06ayhmTiMfK6T20IvXe
 4jfxQ8D+reaU92Yaz14CZCqnc6dgCBVLCcf1fB89eatTHjUu/QawYmph2ABKTSj1JGiW0P
 F9+oc6wxtRG8K8O3dsAsAzv83oKlWCI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-x91s8YehPau7HpKfUxKDlw-1; Mon,
 16 Mar 2026 06:41:04 -0400
X-MC-Unique: x91s8YehPau7HpKfUxKDlw-1
X-Mimecast-MFC-AGG-ID: x91s8YehPau7HpKfUxKDlw_1773657663
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FF4919560BE; Mon, 16 Mar 2026 10:41:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A46819560AB; Mon, 16 Mar 2026 10:40:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 06/14] hw/arm: fsl-imx7: Don't call qdev_get_machine in soc init
Date: Mon, 16 Mar 2026 11:40:31 +0100
Message-ID: <20260316104039.195960-7-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
References: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the soc_init function would result in
the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-aarch64 -S -display none -M virt -device fsl-imx7,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of initialising the CPUs in
the SoC init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260312043158.4191378-5-alistair.francis@wdc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx7.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 9a230d222fd..2defa498d38 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -32,20 +32,10 @@
 
 static void fsl_imx7_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(obj);
     char name[NAME_SIZE];
     int i;
 
-    /*
-     * CPUs
-     */
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX7_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a7"));
-    }
-
     /*
      * A7MPCORE
      */
@@ -179,6 +169,15 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPUs
+     */
+    for (i = 0; i < smp_cpus; i++) {
+        snprintf(name, NAME_SIZE, "cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a7"));
+    }
+
     /*
      * CPUs
      */
-- 
2.53.0


