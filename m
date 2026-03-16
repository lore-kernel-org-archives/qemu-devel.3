Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5279FF4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25OE-0006PF-Pe; Mon, 16 Mar 2026 06:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nq-0006LN-RC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Np-0003W1-FD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/roQOV+Y+3FM8HDiyVu3DBdtQdt1vr6WF3+6X4BdEE=;
 b=fR7v0MvQUOd5fE96DfXQoID1ajqH4m+TDU+5/ZyM32T+xO8SmID/OVx87ikbs/a8Jx6zqw
 C0CPIKo1n70AnDKUmf5lH+A/F/K63PKd1c1xfXaqgslckaOJz6Vny7mozcXyEV36h8zg/i
 ltUxf7hyT1+B0eeOSUi6kZMYTRH6AkQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-DdOh85-tMHmMg_ocurcDdQ-1; Mon,
 16 Mar 2026 06:41:07 -0400
X-MC-Unique: DdOh85-tMHmMg_ocurcDdQ-1
X-Mimecast-MFC-AGG-ID: DdOh85-tMHmMg_ocurcDdQ_1773657666
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D873319560AB; Mon, 16 Mar 2026 10:41:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C181A19560AB; Mon, 16 Mar 2026 10:41:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 07/14] hw/arm: fsl-imx8mp: Don't call qdev_get_machine in soc
 init
Date: Mon, 16 Mar 2026 11:40:32 +0100
Message-ID: <20260316104039.195960-8-thuth@redhat.com>
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

    ./qemu-system-aarch64 -S -display none -M virt -device fsl-imx8mp,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of initialising the CPUs in
the SoC init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260312043158.4191378-6-alistair.francis@wdc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx8mp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 79f91427772..b36df829719 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -193,16 +193,9 @@ static const struct {
 
 static void fsl_imx8mp_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mpState *s = FSL_IMX8MP(obj);
-    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MP_NUM_CPUS); i++) {
-        g_autofree char *name = g_strdup_printf("cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
-    }
-
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
@@ -265,6 +258,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mpState *s = FSL_IMX8MP(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
+    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
     if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
@@ -273,6 +267,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < ms->smp.cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i], cpu_type);
+    }
+
     /* CPUs */
     for (i = 0; i < ms->smp.cpus; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-- 
2.53.0


